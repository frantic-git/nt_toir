#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - Структура - см. возвращаемое значение ФункцииОтчетовКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
		// Никаких настроек не требуется	
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	КлючВарианта = КомпоновщикНастроек.Настройки.ДополнительныеСвойства.КлючПредопределенногоВарианта;
	Если КлючВарианта = "ПланЗакупок" Тогда 
		СхемаКомпоновкиДанных.НаборыДанных.ИсточникСвязи.Запрос = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	торо_ЗаказыПоставщикуОстатки.Номенклатура КАК Номенклатура,
		|	торо_ЗаказыПоставщикуОстатки.Характеристика КАК Характеристика,
		|	торо_ЗаказыПоставщикуОстатки.Склад КАК Склад,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику КАК ЗаказПоставщику,
		|	торо_ЗаказыПоставщикуОстатки.КоличествоОстаток КАК КоличествоЗакупленное,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику.ДатаПоставки КАК ДатаПоставки,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику.Организация КАК Организация,
		|	торо_ЗаказыПоставщикуОстатки.Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику.Контрагент КАК Контрагент
		|ПОМЕСТИТЬ ВТ_Остатки
		|ИЗ
		|	РегистрНакопления.торо_ЗаказыПоставщику.Остатки(&ДатаОкончания,{ЗаказПоставщику.ДатаПоставки МЕЖДУ &ДатаНачала И &ДатаОкончания} ) КАК торо_ЗаказыПоставщикуОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_Остатки.Номенклатура КАК Номенклатура,
		|	ВТ_Остатки.Характеристика КАК Характеристика,
		|	ВТ_Остатки.Склад КАК Склад,
		|	ВТ_Остатки.ЗаказПоставщику КАК ЗаказПоставщику,
		|	ВТ_Остатки.КоличествоЗакупленное КАК КоличествоЗакупленное,
		|	ВТ_Остатки.ДатаПоставки КАК ДатаПоставки,
		|	ВТ_Остатки.Организация КАК Организация,
		|	ВТ_Остатки.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	ВТ_Остатки.Контрагент КАК Контрагент
		|ИЗ
		|	ВТ_Остатки КАК ВТ_Остатки"; 
		
		СхемаКомпоновкиДанных.НаборыДанных.ПриемникСвязи.Запрос = "ВЫБРАТЬ
		|	торо_ИнтеграцияДокументов.ID КАК ID,
		|	ЗаказНаВнутреннееПотребление.Ссылка КАК Ссылка,
		|	ЗаказНаВнутреннееПотребление.ДатаОтгрузки КАК Дата,
		|	ЗаказНаВнутреннееПотребление.торо_ОбъектРемонта КАК ОбъектРемонта,
		|	ЗаказНаВнутреннееПотребление.торо_ВидРемонта КАК ВидРемонта
		|ПОМЕСТИТЬ ВТ_ИДРемонтов
		|ИЗ
		|	РегистрСведений.торо_ИнтеграцияДокументов КАК торо_ИнтеграцияДокументов
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление
		|		ПО торо_ИнтеграцияДокументов.ДокументЕРП = ЗаказНаВнутреннееПотребление.Ссылка
		|{ГДЕ
		|	ЗаказНаВнутреннееПотребление.ДатаОтгрузки МЕЖДУ &ДатаНачала И &ДатаОкончания}
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ИДРемонтов.Ссылка КАК Ссылка,
		|	ВТ_ИДРемонтов.ID КАК ID,
		|	ВТ_ИДРемонтов.Дата КАК Дата,
		|	ВЫБОР
		|		КОГДА ВТ_ИДРемонтов.ВидРемонта = ЗНАЧЕНИЕ(Справочник.торо_ВидыРемонтов.ПустаяСсылка)
		|			ТОГДА торо_ОбщиеДанныеПоРемонтам.ВидРемонта
		|		ИНАЧЕ ВТ_ИДРемонтов.ВидРемонта
		|	КОНЕЦ КАК ВидРемонта,
		|	ВЫБОР
		|		КОГДА ВТ_ИДРемонтов.ОбъектРемонта = НЕОПРЕДЕЛЕНО
		|			ТОГДА торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта
		|		ИНАЧЕ ВТ_ИДРемонтов.ОбъектРемонта
		|	КОНЕЦ КАК ОбъектРемонта
		|ПОМЕСТИТЬ ВТ_ЗаказыНаВП
		|ИЗ
		|	ВТ_ИДРемонтов КАК ВТ_ИДРемонтов
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
		|		ПО ВТ_ИДРемонтов.ID = торо_ОбщиеДанныеПоРемонтам.IDРемонта
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ЗаказыНаВП.Ссылка КАК Ссылка,
		|	ВТ_ЗаказыНаВП.ID КАК ID,
		|	ВТ_ЗаказыНаВП.Дата КАК Дата,
		|	ВТ_ЗаказыНаВП.ВидРемонта КАК ВидРемонта,
		|	ВТ_ЗаказыНаВП.ОбъектРемонта КАК ОбъектРемонта,
		|	ЗаказНаВнутреннееПотреблениеТовары.Номенклатура КАК Номенклатура,
		|	ЗаказНаВнутреннееПотреблениеТовары.Характеристика КАК Характеристика,
		|	ЗаказНаВнутреннееПотреблениеТовары.Количество КАК Количество
		|ПОМЕСТИТЬ ВТ_Товары
		|ИЗ
		|	ВТ_ЗаказыНаВП КАК ВТ_ЗаказыНаВП
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление.Товары КАК ЗаказНаВнутреннееПотреблениеТовары
		|		ПО ВТ_ЗаказыНаВП.Ссылка = ЗаказНаВнутреннееПотреблениеТовары.Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	торо_ЗаказПоставщикуДокументыОснования.Ссылка КАК ЗаказПоставщику,
		|	ВТ_Товары.Ссылка КАК ЗаказНаВП,
		|	ВТ_Товары.Дата КАК ДатаПотребности,
		|	ВТ_Товары.ВидРемонта КАК ВидРемонта,
		|	ВТ_Товары.ОбъектРемонта КАК ОбъектРемонта,
		|	ВТ_Товары.Номенклатура КАК Номенклатура,
		|	ВТ_Товары.Характеристика КАК Характеристика,
		|	ВТ_Товары.Количество КАК КоличествоТребуемое
		|ИЗ
		|	Документ.торо_ЗаказПоставщику.ДокументыОснования КАК торо_ЗаказПоставщикуДокументыОснования
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_Товары КАК ВТ_Товары
		|		ПО торо_ЗаказПоставщикуДокументыОснования.ДокументОснование = ВТ_Товары.Ссылка
		|{ГДЕ
		|	торо_ЗаказПоставщикуДокументыОснования.Ссылка.ДатаПоставки МЕЖДУ &ДатаНачала И &ДатаОкончания}";
		
	ИначеЕсли КлючВарианта = "ПланПоставокПодВП" Тогда
		
		СхемаКомпоновкиДанных.НаборыДанных.ПриемникСвязи.Запрос = "ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	торо_ЗаказыПоставщикуОстатки.Номенклатура КАК Номенклатура,
		|	торо_ЗаказыПоставщикуОстатки.Характеристика КАК Характеристика,
		|	торо_ЗаказыПоставщикуОстатки.Склад КАК Склад,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику КАК ЗаказПоставщику,
		|	торо_ЗаказыПоставщикуОстатки.КоличествоОстаток КАК КоличествоЗакупленное,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику.ДатаПоставки КАК ДатаПоставки,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику.Организация КАК Организация,
		|	торо_ЗаказыПоставщикуОстатки.Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	торо_ЗаказыПоставщикуОстатки.ЗаказПоставщику.Контрагент КАК Контрагент
		|ПОМЕСТИТЬ ВТ_Остатки
		|ИЗ
		|	РегистрНакопления.торо_ЗаказыПоставщику.Остатки(&ДатаОкончания,{ЗаказПоставщику.ДатаПоставки МЕЖДУ &ДатаНачала И &ДатаОкончания} ) КАК торо_ЗаказыПоставщикуОстатки
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_Остатки.Номенклатура КАК Номенклатура,
		|	ВТ_Остатки.Характеристика КАК Характеристика,
		|	ВТ_Остатки.Склад КАК Склад,
		|	ВТ_Остатки.ЗаказПоставщику КАК ЗаказПоставщику,
		|	ВТ_Остатки.КоличествоЗакупленное КАК КоличествоЗакупленное,
		|	ВТ_Остатки.ДатаПоставки КАК ДатаПоставки,
		|	ВТ_Остатки.Организация КАК Организация,
		|	ВТ_Остатки.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	ВТ_Остатки.Контрагент КАК Контрагент
		|ИЗ
		|	ВТ_Остатки КАК ВТ_Остатки"; 
		
		СхемаКомпоновкиДанных.НаборыДанных.ИсточникСвязи.Запрос = "ВЫБРАТЬ
		|	торо_ИнтеграцияДокументов.ID КАК ID,
		|	ЗаказНаВнутреннееПотребление.Ссылка КАК Ссылка,
		|	ЗаказНаВнутреннееПотребление.ДатаОтгрузки КАК Дата,
		|	ЗаказНаВнутреннееПотребление.торо_ОбъектРемонта КАК ОбъектРемонта,
		|	ЗаказНаВнутреннееПотребление.торо_ВидРемонта КАК ВидРемонта
		|ПОМЕСТИТЬ ВТ_ИДРемонтов
		|ИЗ
		|	РегистрСведений.торо_ИнтеграцияДокументов КАК торо_ИнтеграцияДокументов
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление
		|		ПО торо_ИнтеграцияДокументов.ДокументЕРП = ЗаказНаВнутреннееПотребление.Ссылка
		|{ГДЕ
		|	ЗаказНаВнутреннееПотребление.ДатаОтгрузки МЕЖДУ &ДатаНачала И &ДатаОкончания}
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ИДРемонтов.Ссылка КАК Ссылка,
		|	ВТ_ИДРемонтов.ID КАК ID,
		|	ВТ_ИДРемонтов.Дата КАК Дата,
		|	ВЫБОР
		|		КОГДА ВТ_ИДРемонтов.ВидРемонта = ЗНАЧЕНИЕ(Справочник.торо_ВидыРемонтов.ПустаяСсылка)
		|			ТОГДА торо_ОбщиеДанныеПоРемонтам.ВидРемонта
		|		ИНАЧЕ ВТ_ИДРемонтов.ВидРемонта
		|	КОНЕЦ КАК ВидРемонта,
		|	ВЫБОР
		|		КОГДА ВТ_ИДРемонтов.ОбъектРемонта = НЕОПРЕДЕЛЕНО
		|			ТОГДА торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта
		|		ИНАЧЕ ВТ_ИДРемонтов.ОбъектРемонта
		|	КОНЕЦ КАК ОбъектРемонта
		|ПОМЕСТИТЬ ВТ_ЗаказыНаВП
		|ИЗ
		|	ВТ_ИДРемонтов КАК ВТ_ИДРемонтов
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
		|		ПО ВТ_ИДРемонтов.ID = торо_ОбщиеДанныеПоРемонтам.IDРемонта
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ЗаказыНаВП.Ссылка КАК Ссылка,
		|	ВТ_ЗаказыНаВП.ID КАК ID,
		|	ВТ_ЗаказыНаВП.Дата КАК Дата,
		|	ВТ_ЗаказыНаВП.ВидРемонта КАК ВидРемонта,
		|	ВТ_ЗаказыНаВП.ОбъектРемонта КАК ОбъектРемонта,
		|	ЗаказНаВнутреннееПотреблениеТовары.Номенклатура КАК Номенклатура,
		|	ЗаказНаВнутреннееПотреблениеТовары.Характеристика КАК Характеристика,
		|	ЗаказНаВнутреннееПотреблениеТовары.Количество КАК Количество
		|ПОМЕСТИТЬ ВТ_Товары
		|ИЗ
		|	ВТ_ЗаказыНаВП КАК ВТ_ЗаказыНаВП
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ЗаказНаВнутреннееПотребление.Товары КАК ЗаказНаВнутреннееПотреблениеТовары
		|		ПО ВТ_ЗаказыНаВП.Ссылка = ЗаказНаВнутреннееПотреблениеТовары.Ссылка
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	торо_ЗаказПоставщикуДокументыОснования.Ссылка КАК ЗаказПоставщику,
		|	ВТ_Товары.Ссылка КАК ЗаказНаВП,
		|	ВТ_Товары.Дата КАК ДатаПотребности,
		|	ВТ_Товары.ВидРемонта КАК ВидРемонта,
		|	ВТ_Товары.ОбъектРемонта КАК ОбъектРемонта,
		|	ВТ_Товары.Номенклатура КАК Номенклатура,
		|	ВТ_Товары.Характеристика КАК Характеристика,
		|	ВТ_Товары.Количество КАК КоличествоТребуемое
		|ИЗ
		|	Документ.торо_ЗаказПоставщику.ДокументыОснования КАК торо_ЗаказПоставщикуДокументыОснования
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_Товары КАК ВТ_Товары
		|		ПО торо_ЗаказПоставщикуДокументыОснования.ДокументОснование = ВТ_Товары.Ссылка
		|{ГДЕ
		|	торо_ЗаказПоставщикуДокументыОснования.Ссылка.ДатаПоставки МЕЖДУ &ДатаНачала И &ДатаОкончания}";
	КонецЕсли;	
	
КонецПроцедуры 

#КонецОбласти  


#КонецЕсли