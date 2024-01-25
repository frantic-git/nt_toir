#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область Проведение

// Процедура - Инициализировать данные документа.
// Предназначена для вызова процедуры ИнициализироватьТаблицыДляДвижений общего модуля
// ПроведениеСервер с нужными параметрами.
//
// Параметры:
//  ДокументСсылка		 - ДокументСсылка.ЗаказНаВнутреннееПотребление - Ссылка на документ.
//  ДополнительныеСвойства - Структура - По ключу структуры "ТаблицыДляДвижений" 
//										можно получить таблицы для движений 
//										после выполнения процедуры.
Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства) Экспорт

	// Создание запроса инициализации движений и заполенение его параметров.
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);

	// Формирование текста запроса.
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстыЗапроса.Добавить(ТекстЗапросаТаблицаЗаказыНаВнутреннееПотребление(), "ТаблицаЗаказыНаВнутреннееПотребление");

	// Исполнение запроса и выгрузка полученных таблиц для движений.
	ПроведениеСервер.ИницализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений);

КонецПроцедуры
#КонецОбласти

// Формирует структуру для создания внутреннего потребления по одному
// или нескольким заказам на внутреннее потребление.
//
// Параметры:
//	МассивСсылок - Массив из ДокументСсылка.ЗаказНаВнутреннееПотребление - заказы на внутреннее потребление
//							по которым необходимо ввести внутреннее потребление товаров.
// 	ТекстПредупреждения - Строка - строка, в которую будет помещено сообщение
//									поясняющее почему нельзя оформить документ.
//
// Возвращаемое значение:
//		Структура - структура, в которую будут помещены реквизиты шапки из массива заказов.
//
Функция ПараметрыОформленияВнутреннегоПотребления(МассивСсылок, ТекстПредупреждения) Экспорт
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	МИНИМУМ(Заказ.Организация)                        КАК Организация,
	|	МИНИМУМ(Заказ.Склад)                              КАК Склад,
	|	МИНИМУМ(Заказ.Подразделение)                      КАК Подразделение,
	|	МИНИМУМ(Заказ.Сделка)                             КАК Сделка,
	|	МИНИМУМ(Заказ.ХозяйственнаяОперация)              КАК ХозяйственнаяОперация,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Заказ.Организация)           КАК РазличныхОрганизаций,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Заказ.Склад)                 КАК РазличныхСкладов,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Заказ.Подразделение)         КАК РазличныхПодразделений,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Заказ.Сделка)                КАК РазличныхСделок,
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ Заказ.ХозяйственнаяОперация) КАК РазличныхХозяйственныхОпераций
	|ИЗ
	|	Документ.ЗаказНаВнутреннееПотребление КАК Заказ
	|ГДЕ
	|	Заказ.Ссылка В(&МассивСсылок)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Заказ.Ссылка КАК Заказ,
	|	Заказ.Статус КАК Статус,
	|	(НЕ Заказ.Проведен) КАК ЕстьОшибкиПроведен,
	|	ВЫБОР
	|		КОГДА Заказ.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВнутреннихЗаказов.Закрыт)
	|				ИЛИ Заказ.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыВнутреннихЗаказов.КВыполнению)
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ЕстьОшибкиСтатус
	|ИЗ
	|	Документ.ЗаказНаВнутреннееПотребление КАК Заказ
	|ГДЕ
	|	Заказ.Ссылка В(&МассивСсылок)
	|	И ((НЕ Заказ.Проведен)
	|			ИЛИ Заказ.Статус <> ЗНАЧЕНИЕ(Перечисление.СтатусыВнутреннихЗаказов.КВыполнению)
	|				И Заказ.Статус <> ЗНАЧЕНИЕ(Перечисление.СтатусыВнутреннихЗаказов.Закрыт))");
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	РезультатЗапроса = Запрос.ВыполнитьПакет();
	ВыборкаРеквизитыШапки = РезультатЗапроса[0].Выбрать();
	ВыборкаРеквизитыШапки.Следующий();
	
	Отказ = Ложь;
	
	ШаблонСообщения = НСтр("ru='У выделенных распоряжений отличается поле ""%ПредставлениеПоля%""'");
	ТекстСообщения = "";
	
	Если ВыборкаРеквизитыШапки.РазличныхОрганизаций > 1 Тогда
		ТекстСообщения = ТекстСообщения
							+ ?(ТекстСообщения = "", "", Символы.ПС)
							+ СтрЗаменить(ШаблонСообщения, "%ПредставлениеПоля%", НСтр("ru='""Организация""'"));
		
		Отказ = Истина;
	КонецЕсли;
	
	Если ВыборкаРеквизитыШапки.РазличныхСкладов > 1 Тогда
		ТекстСообщения = ТекстСообщения
							+ ?(ТекстСообщения = "", "", Символы.ПС)
							+ СтрЗаменить(ШаблонСообщения, "%ПредставлениеПоля%", НСтр("ru='""Склад""'"));
		
		Отказ = Истина;
	КонецЕсли;
	
	Если ВыборкаРеквизитыШапки.РазличныхПодразделений > 1 Тогда
		ТекстСообщения = ТекстСообщения
							+ ?(ТекстСообщения = "", "", Символы.ПС)
							+ СтрЗаменить(ШаблонСообщения, "%ПредставлениеПоля%", НСтр("ru='""Подразделение""'"));
		
		Отказ = Истина;
	КонецЕсли;
	
	Если ВыборкаРеквизитыШапки.РазличныхСделок > 1 Тогда
		ТекстСообщения = ТекстСообщения
							+ ?(ТекстСообщения = "", "", Символы.ПС)
							+ СтрЗаменить(ШаблонСообщения, "%ПредставлениеПоля%", НСтр("ru='""Сделка""'"));
		
		Отказ = Истина;
	КонецЕсли;
	
	Если ВыборкаРеквизитыШапки.РазличныхХозяйственныхОпераций > 1 Тогда
		ТекстСообщения = ТекстСообщения
							+ ?(ТекстСообщения = "", "", Символы.ПС)
							+ СтрЗаменить(ШаблонСообщения, "%ПредставлениеПоля%", НСтр("ru='""Операция""'"));
		
		Отказ = Истина;
	КонецЕсли;
	
	Если Отказ Тогда
		ТекстПредупреждения = НСтр("ru='Невозможно оформить внутреннее потребление на основании выбранных распоряжений.'")
								+ Символы.ПС
								+ ТекстСообщения;
								
		Возврат Неопределено;
		
	КонецЕсли;
	
	Если Не РезультатЗапроса[1].Пустой() Тогда
		
		ВыборкаЗаказы = РезультатЗапроса[1].Выбрать();
		
		Пока ВыборкаЗаказы.Следующий() Цикл
			
			Если ВыборкаЗаказы.ЕстьОшибкиПроведен Тогда
				
				ШаблонСообщения = НСтр("ru='Документ %1 не проведен. Ввод на основании непроведенного документа запрещен.'");
				ТекстСообщения = СтрШаблон(ШаблонСообщения, ВыборкаЗаказы.Заказ);
				ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
				
			ИначеЕсли ВыборкаЗаказы.ЕстьОшибкиСтатус Тогда
					
				ШаблонСообщения = НСтр("ru='Документ %1 находится в статусе ""%2"". Ввод на основании разрешен только в статусах ""К выполнению"", ""Закрыт"".'");
				ТекстСообщения = СтрШаблон(ШаблонСообщения, ВыборкаЗаказы.Заказ, ВыборкаЗаказы.Статус);
				ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	ПараметрыОформления = Новый Структура;
	ПараметрыОформления.Вставить("Организация",           ВыборкаРеквизитыШапки.Организация);
	ПараметрыОформления.Вставить("Склад",                 ВыборкаРеквизитыШапки.Склад);
	ПараметрыОформления.Вставить("ХозяйственнаяОперация", ВыборкаРеквизитыШапки.ХозяйственнаяОперация);
	ПараметрыОформления.Вставить("Подразделение",         ВыборкаРеквизитыШапки.Подразделение);
	ПараметрыОформления.Вставить("Сделка",                ВыборкаРеквизитыШапки.Сделка);
	
	Возврат ПараметрыОформления;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение
Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);

	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДанныеШапки.Дата       КАК Период,
		|	ДанныеШапки.Склад      КАК Склад
		|ИЗ
		|	Документ.ЗаказНаВнутреннееПотребление КАК ДанныеШапки
		|ГДЕ
		|	ДанныеШапки.Ссылка = &Ссылка";
	
	Реквизиты = Запрос.Выполнить().Выбрать();
	Реквизиты.Следующий();
	
	Запрос.УстановитьПараметр("Период",     Реквизиты.Период);
	Запрос.УстановитьПараметр("Склад",      Реквизиты.Склад);

КонецПроцедуры

Функция ТекстЗапросаТаблицаЗаказыНаВнутреннееПотребление()

	ТекстЗапроса = "ВЫБРАТЬ
                   |    МАКСИМУМ(ВложенныйЗапрос.Порядок)                КАК Порядок,
                   |    МАКСИМУМ(ВложенныйЗапрос.НомерСтроки)            КАК НомерСтроки,
                   |    ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)           КАК ВидДвижения,
                   |    ВложенныйЗапрос.Период                           КАК Период,
                   |    ВложенныйЗапрос.ЗаказНаВнутреннееПотребление     КАК ЗаказНаВнутреннееПотребление,
                   |    ВложенныйЗапрос.Номенклатура                     КАК Номенклатура,
                   |    ВложенныйЗапрос.Характеристика                   КАК Характеристика,
                   |    ВложенныйЗапрос.КодСтроки                        КАК КодСтроки,
                   |    &Склад                                           КАК Склад,
                   |    СУММА(ВложенныйЗапрос.КОформлению)               КАК КОформлению
                   |ИЗ
                   |    (ВЫБРАТЬ
                   |        1 КАК Порядок,
                   |        ТаблицаТовары.НомерСтроки                    КАК НомерСтроки,
                   |        НАЧАЛОПЕРИОДА(&Период, ДЕНЬ)                 КАК Период,
                   |        ТаблицаТовары.Ссылка                         КАК ЗаказНаВнутреннееПотребление,
                   |        ТаблицаТовары.Номенклатура                   КАК Номенклатура,
                   |        ТаблицаТовары.Характеристика                 КАК Характеристика,
                   |        ТаблицаТовары.КодСтроки                      КАК КодСтроки,
                   |        ТаблицаТовары.Количество                     КАК КОформлению
                   |    ИЗ
                   |        Документ.ЗаказНаВнутреннееПотребление.Товары КАК ТаблицаТовары
                   |    ГДЕ
                   |        ТаблицаТовары.Ссылка = &Ссылка) КАК ВложенныйЗапрос
                   |
                   |СГРУППИРОВАТЬ ПО
                   |    ВложенныйЗапрос.Характеристика,
                   |    ВложенныйЗапрос.Номенклатура,
                   |    ВложенныйЗапрос.ЗаказНаВнутреннееПотребление,
                   |    ВложенныйЗапрос.Период,
                   |    ВложенныйЗапрос.КодСтроки
                   |
                   |ОБЪЕДИНИТЬ ВСЕ
                   |
                   |ВЫБРАТЬ
                   |    2,
                   |    ТаблицаТовары.НомерСтроки,
                   |    ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход),
                   |    &Период,
                   |    ТаблицаТовары.Ссылка,
                   |    ТаблицаТовары.Номенклатура,
                   |    ТаблицаТовары.Характеристика,
                   |    ТаблицаТовары.КодСтроки,
                   |    &Склад,
                   |    -ТаблицаТовары.Количество
                   |ИЗ
                   |    Документ.ЗаказНаВнутреннееПотребление.Товары КАК ТаблицаТовары
                   |ГДЕ
                   |    ТаблицаТовары.Ссылка = &Ссылка
                   |    И ТаблицаТовары.Отменено
                   |
                   |УПОРЯДОЧИТЬ ПО
                   |    НомерСтроки,
                   |    Порядок";

	Возврат ТекстЗапроса;

КонецФункции
#КонецОбласти

Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
	Настройки.ПриПолученииСлужебныхРеквизитов = Истина;
	
КонецПроцедуры

Процедура ПриПолученииСлужебныхРеквизитов(Реквизиты) Экспорт
	
	Реквизиты.Добавить("МаксимальныйКодСтроки");
		
КонецПроцедуры

#Область Печать 
// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	// Заказ на внутреннее потреблени
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ЗаказНаВнутреннееПотребление";
	КомандаПечати.Представление = НСтр("ru = 'Заказ на внутреннее потребление'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПараметрыВывода.ДоступнаПечатьПоКомплектно = Истина;
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ЗаказНаВнутреннееПотребление") Тогда
		
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
			КоллекцияПечатныхФорм,
			"ЗаказНаВнутреннееПотребление",
			НСтр("ru = 'Заказ на внутреннее потреблени'"),
			ПечатьЗаказНаВнутреннееПотребление(МассивОбъектов, ОбъектыПечати),
			,
			"Документ.ЗаказНаВнутреннееПотребление.ПФ_MXL_ЗаказНаВнутреннееПотребление");
		
	КонецЕсли;
КонецПроцедуры

Функция ПечатьЗаказНаВнутреннееПотребление(МассивОбъектов, ОбъектыПечати)
	
	ДопКолонка = Неопределено;
	ВыводитьДопКолонку = Ложь;
	
	ЗапросПоДокументам = Новый Запрос;
	ЗапросПоДокументам.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	ЗапросПоДокументам.Текст =
	"ВЫБРАТЬ
	|	Документ.Ссылка КАК Ссылка,
	|	Документ.Номер КАК Номер,
	|	Документ.Дата КАК Дата,
	|	Документ.ДатаОтгрузки КАК ДатаОтгрузки,
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(Документ.Склад) КАК Склад,
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(Документ.Подразделение) КАК Подразделение,
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(Документ.Организация) КАК Организация,
	|	Документ.Организация.Префикс КАК Префикс,
	|	ТЧТовары.Номенклатура.НаименованиеПолное КАК Номенклатура,
	|	ТЧТовары.Характеристика.НаименованиеПолное КАК Характеристика,
	|	ТЧТовары.Характеристика.Наименование КАК НаименованиеХарактеристики,
	|	ТЧТовары.Серия.Наименование КАК Серия,
	|	СУММА(ТЧТовары.КоличествоУпаковок) КАК Количество,
	|	ВЫБОР
	|		КОГДА ТЧТовары.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиНоменклатуры.ПустаяСсылка)
	|			ТОГДА ТЧТовары.Номенклатура.ЕдиницаИзмерения.Наименование
	|		ИНАЧЕ ТЧТовары.Упаковка.Наименование
	|	КОНЕЦ КАК Упаковка
	|ИЗ
	|	Документ.ЗаказНаВнутреннееПотребление.Товары КАК ТЧТовары
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление КАК Документ
	|		ПО ТЧТовары.Ссылка = Документ.Ссылка
	|ГДЕ
	|	Документ.Ссылка В(&МассивОбъектов)
	|	И НЕ ТЧТовары.Отменено
	|
	|СГРУППИРОВАТЬ ПО
	|	Документ.Ссылка,
	|	Документ.Номер,
	|	Документ.Дата,
	|	Документ.ДатаОтгрузки,
	|	Документ.Организация.Префикс,
	|	ТЧТовары.Номенклатура.НаименованиеПолное,
	|	ТЧТовары.Характеристика.НаименованиеПолное,
	|	ТЧТовары.Характеристика.Наименование,
	|	ТЧТовары.Серия.Наименование,
	|	ВЫБОР
	|		КОГДА ТЧТовары.Упаковка = ЗНАЧЕНИЕ(Справочник.УпаковкиНоменклатуры.ПустаяСсылка)
	|			ТОГДА ТЧТовары.Номенклатура.ЕдиницаИзмерения.Наименование
	|		ИНАЧЕ ТЧТовары.Упаковка.Наименование
	|	КОНЕЦ,
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(Документ.Склад),
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(Документ.Подразделение),
	|	ПРЕДСТАВЛЕНИЕССЫЛКИ(Документ.Организация)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Дата,
	|	Ссылка,
	|	Номенклатура,
	|	НаименованиеХарактеристики
	|ИТОГИ
	|	МАКСИМУМ(Номер),
	|	МАКСИМУМ(Дата),
	|	МАКСИМУМ(ДатаОтгрузки),
	|	МАКСИМУМ(Склад),
	|	МАКСИМУМ(Подразделение),
	|	МАКСИМУМ(Организация),
	|	МАКСИМУМ(Префикс)
	|ПО
	|	Ссылка";
	
	ТабДокумент = Новый ТабличныйДокумент;
	ТабДокумент.ИмяПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_ЗаказНаВнутреннееПотребление";
	
	РеквизитыДокумента = Новый Структура("Номер, Дата, Префикс");
	СинонимДокумента = Метаданные.Документы.ЗаказНаВнутреннееПотребление.Синоним;
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.ЗаказНаВнутреннееПотребление.ПФ_MXL_ЗаказНаВнутреннееПотребление");
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	ОбластьПодписи   = Макет.ПолучитьОбласть("Подписи");
	
	ИспользоватьХарактеристики = Константы.торо_ИспользоватьХарактеристикиНоменклатуры.Получить();
	ИспользоватьСерии = Константы.ИспользоватьСерииНоменклатуры.Получить();
	
	Если ИспользоватьХарактеристики И НЕ ИспользоватьСерии Тогда  
		ОбластьШапка  = Макет.ПолучитьОбласть("ШапкаТаблицыФО");
		ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаФО");
		ОбластьШапка.Параметры.ЗаголовокКолонки = "Характеристика";
	ИначеЕсли ИспользоватьСерии И НЕ ИспользоватьХарактеристики Тогда
		ОбластьШапка  = Макет.ПолучитьОбласть("ШапкаТаблицыФО");
		ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаФО");
		ОбластьШапка.Параметры.ЗаголовокКолонки = "Серия";
	ИначеЕсли ИспользоватьХарактеристики И ИспользоватьСерии Тогда
		ОбластьШапка  = Макет.ПолучитьОбласть("ШапкаТаблицыФО");
		ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаФО");
		ОбластьШапка.Параметры.ЗаголовокКолонки = "Характеристика, серия";
	Иначе 
		ОбластьШапка  = Макет.ПолучитьОбласть("ШапкаТаблицы");
		ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
	КонецЕсли;
	ОбластьГраница    = Макет.ПолучитьОбласть("Граница");
	
	ПервыйДокумент = Истина;
		
	ВыборкаДокументы = ЗапросПоДокументам.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаДокументы.Следующий() Цикл
		
		НомерСтрокиНачало = ТабДокумент.ВысотаТаблицы + 1;
		
		Если Не ПервыйДокумент Тогда
			ТабДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		ПервыйДокумент = Ложь;
		
		// Вывод заголовка.
		ЗаполнитьЗначенияСвойств(РеквизитыДокумента, ВыборкаДокументы);
		ОбластьЗаголовок.Параметры.ТекстЗаголовка = ОбщегоНазначенияУТКлиентСервер.СформироватьЗаголовокДокумента(РеквизитыДокумента, СинонимДокумента);
		ОбластьЗаголовок.Параметры.Заполнить(ВыборкаДокументы);
		ОбластьЗаголовок.Параметры.Организация = торо_ЗаполнениеДокументов.ПолучитьПредставлениеОрганизацииДляПечати(ВыборкаДокументы.Организация);
		ТабДокумент.Вывести(ОбластьЗаголовок);
		
		// Вывод шапки.
		ТабДокумент.Вывести(ОбластьШапка);
		
		// Вывод строк документа.
		ВыборкаСтроки = ВыборкаДокументы.Выбрать();
		Счетчик = 0;
		Пока ВыборкаСтроки.Следующий() Цикл
			Счетчик = Счетчик + 1;
			МатериалыХарактеристика = "";
			МатериалыСерия = "";
			ОбластьСтрока.Параметры.Заполнить(ВыборкаСтроки);
			ОбластьСтрока.Параметры.НомерСтроки = Счетчик;
			Если ИспользоватьХарактеристики Тогда  
				МатериалыХарактеристика = ?(ЗначениеЗаполнено(ВыборкаСтроки.Характеристика),ВыборкаСтроки.Характеристика, 
				                          ?(ЗначениеЗаполнено(ВыборкаСтроки.НаименованиеХарактеристики),ВыборкаСтроки.НаименованиеХарактеристики,""));
			КонецЕсли;
			Если ИспользоватьСерии Тогда
				МатериалыСерия = ?(ЗначениеЗаполнено(ВыборкаСтроки.Серия), ВыборкаСтроки.Серия, "");
			КонецЕсли;
			Если ЗначениеЗаполнено(МатериалыХарактеристика) И ЗначениеЗаполнено(МатериалыСерия) Тогда
				ОбластьСтрока.Параметры.ХарактеристикаСерия = Строка(МатериалыХарактеристика) + ", " + Строка(МатериалыСерия);
			ИначеЕсли ИспользоватьХарактеристики ИЛИ ИспользоватьСерии Тогда 
				ОбластьСтрока.Параметры.ХарактеристикаСерия = Строка(МатериалыХарактеристика) + Строка(МатериалыСерия);
			КонецЕсли;
							
			ТабДокумент.Вывести(ОбластьСтрока);
		КонецЦикла;
		
		ТабДокумент.Вывести(ОбластьГраница);

		// Вывод подвала.
		ТабДокумент.Вывести(ОбластьПодписи);

		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабДокумент, НомерСтрокиНачало, ОбъектыПечати, ВыборкаДокументы.Ссылка);

	КонецЦикла;

	// ТОиР
	ТабДокумент.ТолькоПросмотр = Истина;
	ТабДокумент.КлючПараметровПечати = "торо_ПечатьЗаказНаВнутреннееПотребление";
	// ТОиР
	Возврат ТабДокумент;

КонецФункции

#КонецОбласти

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Подразделение)";

	Ограничение.ТекстДляВнешнихПользователей = Ограничение.Текст;
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	Если ПравоДоступа("Просмотр", Метаданные.Отчеты.торо_СостояниеОбеспеченияЗаказов) Тогда
		Команда = КомандыОтчетов.Добавить();
		Команда.Представление      = НСтр("ru = 'Состояние обеспечения'");
		Команда.МножественныйВыбор = Истина;
		Команда.ИмяПараметраФормы  = "Отбор.ЗаказНаВнутреннееПотребление";
		Команда.КлючВарианта       = "Основной";
		Команда.Менеджер           = "Отчет.торо_СостояниеОбеспеченияЗаказов";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли