#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПЕРЕМЕННЫЕ

перем СтруктураДанных Экспорт;  // Структура, хранящая данные для работы с уведомлениями.
Перем БезусловнаяЗапись Экспорт; // Отключает проверки при записи документа

#Область ОбработчикиСобытий
Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка  Тогда
		Возврат;
	КонецЕсли;

	СуммаДокумента = НаправленияОбъектовРемонтныхРабот.Итог("Лимит");
	
	Если ЭтоНовый() Тогда
		Автор = Пользователи.ТекущийПользователь();
	КонецЕсли;

КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	ТаблицаЛимитов = НаправленияОбъектовРемонтныхРабот.Выгрузить();
	ТаблицаЛимитов.Свернуть("Организация, Направление , СпособВыполнения", "Лимит");
	
	ДвиженияПоРегистру_торо_ГодовыеЛимитыРемонтныхРабот(РежимПроведения, ТаблицаЛимитов, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// Проверяет таблицу лимитов на попытку ввода повторных данных
//
Процедура ПроверитьТаблицуЛимитов(ТаблицаЛимитов, Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ТабДок.Организация КАК Организация,
	|	ТабДок.Направление КАК Направление,
	|	ТабДок.СпособВыполнения КАК СпособВыполнения
	|ПОМЕСТИТЬ ТаблицаЛимитов
	|ИЗ
	|	Документ.торо_УстановкаЛимитаНаПлановыеРемонтныеРаботы.НаправленияОбъектовРемонтныхРабот КАК ТабДок
	|ГДЕ
	|	ТабДок.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ГодовыеЛимитыРемонтныхРабот.Регистратор КАК Регистратор,
	|	торо_ГодовыеЛимитыРемонтныхРабот.Организация КАК Организация,
	|	торо_ГодовыеЛимитыРемонтныхРабот.Направление КАК Направление,
	|	торо_ГодовыеЛимитыРемонтныхРабот.СпособВыполнения КАК СпособВыполнения
	|ИЗ
	|	ТаблицаЛимитов КАК ТаблицаЛимитов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_ГодовыеЛимитыРемонтныхРабот КАК торо_ГодовыеЛимитыРемонтныхРабот
	|		ПО ТаблицаЛимитов.Организация = торо_ГодовыеЛимитыРемонтныхРабот.Организация
	|			И ТаблицаЛимитов.Направление = торо_ГодовыеЛимитыРемонтныхРабот.Направление
	|			И ТаблицаЛимитов.СпособВыполнения = торо_ГодовыеЛимитыРемонтныхРабот.СпособВыполнения
	|			И (торо_ГодовыеЛимитыРемонтныхРабот.Период = &Период)";
	
	Запрос.УстановитьПараметр("Ссылка",Ссылка);
	Запрос.УстановитьПараметр("Период",НачалоГода(ГодУтверждения));
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если НЕ РезультатЗапроса.Пустой() Тогда
		Отказ = Истина;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ЕстьОрганизация 	= ЗначениеЗаполнено(Выборка.Организация);
		ЕстьНаправление 	= ЗначениеЗаполнено(Выборка.Направление);
		ЕстьСпособ 	= ЗначениеЗаполнено(Выборка.СпособВыполнения);
		
		Если ЕстьОрганизация Тогда
			Если ЕстьНаправление Тогда
				Если ЕстьСпособ Тогда
					ШаблонСообщения = НСтр("ru = 'Для организации %1 по направлению %2 для способа выполнения %3 уже заданы лимиты плановых работ (документ: %4)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Организация, Выборка.Направление, Выборка.СпособВыполнения, Выборка.Регистратор);
				Иначе
					ШаблонСообщения = НСтр("ru = 'Для организации %1 по направлению %2 уже заданы лимиты плановых работ (документ: %3)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Организация, Выборка.Направление, Выборка.Регистратор);
				КонецЕсли;
			Иначе
				Если ЕстьСпособ Тогда
					ШаблонСообщения = НСтр("ru = 'Для организации %1 для способа выполнения %2 уже заданы лимиты плановых работ (документ: %3)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Организация, Выборка.СпособВыполнения, Выборка.Регистратор);
				Иначе
					ШаблонСообщения = НСтр("ru = 'Для организации %1 уже заданы лимиты плановых работ (документ: %2)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Организация, Выборка.Регистратор);	
				КонецЕсли;
			КонецЕсли;
		Иначе
			Если ЕстьНаправление Тогда
				Если ЕстьСпособ Тогда
					ШаблонСообщения = НСтр("ru = 'По направлению %1 для способа выполнения %2 уже заданы лимиты плановых работ (документ: %3)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Направление, Выборка.СпособВыполнения, Выборка.Регистратор);
				Иначе
					ШаблонСообщения = НСтр("ru = 'По направлению %1 уже заданы лимиты плановых работ (документ: %2)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Направление, Выборка.Регистратор);
				КонецЕсли;
			Иначе
				Если ЕстьСпособ Тогда
					ШаблонСообщения = НСтр("ru = 'Для способа выполнения %1 уже заданы лимиты плановых работ (документ: %2)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения,  Выборка.СпособВыполнения, Выборка.Регистратор);
				Иначе
					ШаблонСообщения = НСтр("ru = 'Уже заданы лимиты плановых работ (документ: %1)'");
					ТекстСообщения = СтрШаблон(ШаблонСообщения, Выборка.Регистратор);
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
				
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
				
	КонецЦикла;
	
КонецПроцедуры

// Процедура выполняет движения документа по регистру "торо_ГодовыеЛимитыРемонтныхРабот".
//	
Процедура ДвиженияПоРегистру_торо_ГодовыеЛимитыРемонтныхРабот(РежимПроведения, ТаблицаЛимитов, Отказ)
	
	УстановитьУправляемыеБлокировки();
	ПроверитьТаблицуЛимитов(ТаблицаЛимитов, Отказ);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	НаборДвижений = Движения.торо_ГодовыеЛимитыРемонтныхРабот;
	
	// Получим таблицу значений, совпадающую со структурой набора записей регистра.
	ТаблицаДвижений = НаборДвижений.Выгрузить();
		
	// Заполним таблицу движений.
	торо_ОбщегоНазначения.ЗагрузитьВТаблицуЗначений(ТаблицаЛимитов, ТаблицаДвижений);
	
	Если НЕ Константы.ВалютаУправленческогоУчета.Получить() = Валюта Тогда
		
		Для каждого СтрокаТаблицыДвижений Из ТаблицаДвижений Цикл
		
			СтрокаТаблицыДвижений.Лимит = СтрокаТаблицыДвижений.Лимит * Курс / Кратность ;
		
		КонецЦикла; 
		
	КонецЕсли;
	
	ТаблицаДвижений.ЗаполнитьЗначения(НачалоГода(ГодУтверждения), "Период");
	ТаблицаДвижений.ЗаполнитьЗначения(Истина, "Активность");
		
	Если Не Отказ Тогда
		
		Движения.торо_ГодовыеЛимитыРемонтныхРабот.Загрузить(ТаблицаДвижений);
		Движения.торо_ГодовыеЛимитыРемонтныхРабот.Записать();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьУправляемыеБлокировки()
	
	Блокировка = Новый БлокировкаДанных;
	
	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.торо_ГодовыеЛимитыРемонтныхРабот");
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.ИсточникДанных = НаправленияОбъектовРемонтныхРабот;
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Организация","Организация");
	ЭлементБлокировки.ИспользоватьИзИсточникаДанных("Направление","Направление");
	ЭлементБлокировки.УстановитьЗначение("Период",НачалоГода(ГодУтверждения));
	
	Блокировка.Заблокировать();
	
КонецПроцедуры
#КонецОбласти

#КонецЕсли