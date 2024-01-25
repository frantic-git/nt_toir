#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область СлужебныеПроцедурыИФункции
# Область Печать

// Заполняет список команд печати.
//
// Параметры:
// КомандыПечати – ТаблицаЗначений – состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	// Заявка на ремонт
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.МенеджерПечати = "Документ.торо_УчетНаработкиОборудования";
	КомандаПечати.Идентификатор = "УчетПараметровНаработки";
	КомандаПечати.Представление = НСтр("ru = 'Учет наработки оборудования'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	КомандаПечати.СразуНаПринтер = ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекЗагрузить(
	"НастройкиТОиР",
	"ПечатьДокументовБезПредварительногоПросмотра",
	Ложь);
	
КонецПроцедуры

// Определяет список команд создания на основании.
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
		
КонецПроцедуры

// Добавляет команду создания документа "Учет наработки оборудования".
//
// Параметры:
//   КомандыСозданияНаОсновании - ТаблицаЗначений - Таблица с командами создания на основании. Для изменения.
//       См. описание 1 параметра процедуры СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании().
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Если ПравоДоступа("Добавление", Метаданные.Документы.торо_УчетНаработкиОборудования) Тогда
        КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
        КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.торо_УчетНаработкиОборудования.ПолноеИмя();
        КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.торо_УчетНаработкиОборудования);
        КомандаСоздатьНаОсновании.РежимЗаписи = "Записывать";
		КомандаСоздатьНаОсновании.ФункциональныеОпции = "торо_УчетНаработкиОборудования";
        Возврат КомандаСоздатьНаОсновании;
	КонецЕсли; 
	
    Возврат Неопределено;
	
КонецФункции

// Сформировать печатные формы объектов.
//
// ВХОДЯЩИЕ:
//   ИменаМакетов    - Строка    - Имена макетов, перечисленные через запятую.
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать.
//   ПараметрыПечати - Структура - Структура дополнительных параметров печати.
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы.
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	НужноПечататьМакет = УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "УчетПараметровНаработки");
	Если НужноПечататьМакет Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
		КоллекцияПечатныхФорм,
		"УчетПараметровНаработки",
		НСтр("ru = 'Учет наработки оборудования'"),
		ПечатьУчетПараметровНаработки(МассивОбъектов, ПараметрыПечати),
		,
		"Документ.торо_УчетНаработкиОборудования.ПФ_MXL_УчетПараметровНаработки");
	КонецЕсли;
	
КонецПроцедуры

Функция ПечатьУчетПараметровНаработки(МассивОбъектов, ПараметрыПечати)

	ТабДок = Новый ТабличныйДокумент;
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.торо_УчетНаработкиОборудования.ПФ_MXL_УчетПараметровНаработки");
	
		ЗапросШапки = Новый Запрос;
	ЗапросШапки.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_УчетНаработкиОборудования.Ссылка КАК Ссылка,
	|	торо_УчетНаработкиОборудования.Номер КАК Номер,
	|	торо_УчетНаработкиОборудования.Дата КАК Дата,
	|	торо_УчетНаработкиОборудования.Организация КАК Организация,
	|	торо_УчетНаработкиОборудования.Подразделение КАК Подразделение,
	|	торо_УчетНаработкиОборудования.Ответственный КАК Ответственный,
	|	торо_УчетНаработкиОборудования.Комментарий КАК Комментарий,
	|	торо_УчетНаработкиОборудования.НаработкаОбъектов.(
	|		Ссылка КАК Ссылка,
	|		НомерСтроки КАК НомерСтроки,
	|		Объект КАК Объект,
	|		Показатель КАК Показатель,
	|		ДатаРаботыС КАК ДатаРаботыС,
	|		ДатаРаботыПо КАК ДатаРаботыПо,
	|		СтароеЗначение КАК СтароеЗначение,
	|		НовоеЗначение КАК НовоеЗначение,
	|		НаработкаСНачалаЭксплуатации КАК НаработкаСНачалаЭксплуатации,
	|		Наработка КАК Наработка,
	|		НаработкаСНачалаЭксплуатацииНачало КАК НаработкаСНачалаЭксплуатацииНачало,
	|		СтруктураИерархии КАК СтруктураИерархии,
	|		РаспространятьНаПодчиненных КАК РаспространятьНаПодчиненных
	|	) КАК НаработкаОбъектов
	|ИЗ
	|	Документ.торо_УчетНаработкиОборудования КАК торо_УчетНаработкиОборудования
	|ГДЕ
	|	торо_УчетНаработкиОборудования.Ссылка В(&Ссылка)";
	
	ЗапросШапки.УстановитьПараметр("Ссылка", МассивОбъектов);
	ВыборкаШапки = ЗапросШапки.Выполнить().Выбрать();
	
	ЭтоПервый = Истина;
	
	Пока ВыборкаШапки.Следующий() Цикл	
		Если НЕ ЭтоПервый Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		ЭтоПервый = Ложь;
		
		Шапка = Макет.ПолучитьОбласть("Шапка");
		СтрокаТаблицы = Макет.ПолучитьОбласть("СтрокаТаблицы");
		Подвал = Макет.ПолучитьОбласть("Подвал");
		
		Шапка.Параметры.Заполнить(ВыборкаШапки);
		Шапка.Параметры.Организация = торо_ЗаполнениеДокументов.ПолучитьПредставлениеОрганизацииДляПечати(ВыборкаШапки.Организация);
		ТабДок.Вывести(Шапка);
		
		Ном = 1;
		НаработкаОбъектов = ВыборкаШапки.НаработкаОбъектов.Выгрузить();
		Для Каждого Строка Из НаработкаОбъектов Цикл
			СтрокаТаблицы.Параметры.Н = Ном;	
			СтрокаТаблицы.Параметры.Объект         = торо_ЗаполнениеДокументов.ПолучитьПредоставленияОРДляПечати(Строка.Объект);	
			СтрокаТаблицы.Параметры.Показатель     = Строка.Показатель;	
			СтрокаТаблицы.Параметры.ЕдИзм          = Строка.Показатель.ЕдиницаИзмерения;	
			СтрокаТаблицы.Параметры.ИнвНомерОС     = Строка.Объект.ИнвентарныйНомер;	
			СтрокаТаблицы.Параметры.ТехНомерОС     = Строка.Объект.ТехНомер;	
			СтрокаТаблицы.Параметры.ДатаРаботыС    = Строка.ДатаРаботыС;	
			СтрокаТаблицы.Параметры.СтароеЗначение = Строка.СтароеЗначение;	
			СтрокаТаблицы.Параметры.Наработка      = Строка.Наработка;	
			СтрокаТаблицы.Параметры.ДатаРаботыПо   = Строка.ДатаРаботыПо;	
			СтрокаТаблицы.Параметры.НовоеЗначение  = Строка.НовоеЗначение;	
			ТабДок.Вывести(СтрокаТаблицы);
			Ном = Ном+1;
		КонецЦикла;
		
		Подвал.Параметры.Комментарий = ВыборкаШапки.Комментарий;
		Подвал.Параметры.Ответственный = ВыборкаШапки.Ответственный;
		
		ТабДок.Вывести(Подвал);
	КонецЦикла;
	
	ТабДок.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	ТабДок.АвтоМасштаб = Истина;
	ТабДок.ТолькоПросмотр = Истина;
	ТабДок.ОтображатьСетку = Ложь;
	ТабДок.ОтображатьЗаголовки = Ложь;
	
	ТабДок.ТолькоПросмотр = Истина;
	ТабДок.КлючПараметровПечати = "торо_ПечатьУчетПараметровНаработки";
	Возврат ТабДок;
	
	
КонецФункции // ПечатьУчетПараметровНаработки()

#КонецОбласти

Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
	
	Настройки.ПриПолученииСлужебныхРеквизитов = Истина;
	
КонецПроцедуры

Процедура ПриПолученииСлужебныхРеквизитов(Реквизиты) Экспорт
	
	Реквизиты.Добавить("ИзМобильного");
		
КонецПроцедуры

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ 
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(Подразделение)
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ДляВсехСтрок(&Ограничение_ОР)";

	ОграничениеОР = торо_УправлениеДоступом.ПолучитьОграничениеДоступаДляОбъектаРемонтаВТаблице("НаработкаОбъектов.Объект", Истина);
	Ограничение.Текст = СтрЗаменить(Ограничение.Текст, "&Ограничение_ОР", ОграничениеОР);

	Ограничение.ТекстДляВнешнихПользователей = Ограничение.Текст;

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецЕсли