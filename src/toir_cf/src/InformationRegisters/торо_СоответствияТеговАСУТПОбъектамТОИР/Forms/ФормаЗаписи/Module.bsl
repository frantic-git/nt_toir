
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьТекСтраницу();
	УстановитьОтборПоказателейПоОбъектуРемонта();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОбъектРемонтаПриИзменении(Элемент)
	
	УстановитьОтборПоказателейПоОбъектуРемонта();
	
КонецПроцедуры

&НаКлиенте
Процедура ТипСигналаПриИзменении(Элемент)
	УстановитьТекСтраницу();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьОтборПоказателейПоОбъектуРемонта()
	
	Если ЗначениеЗаполнено(Запись.ОбъектРемонта) Тогда
		масВыбора = УстановитьСписокПоказателейДляВыбора(Запись.ОбъектРемонта);
	
		ПараметрыВыбора = Новый Массив;
		ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.Ссылка", Новый ФиксированныйМассив(масВыбора)));
		Элементы.Показатель.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
		
		масВыбора = УстановитьСписокПараметровНаработкиДляВыбора(Запись.ОбъектРемонта);
		
		ПараметрыВыбора = Новый Массив;
		ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.Ссылка", Новый ФиксированныйМассив(масВыбора)));
		Элементы.ПараметрНаработки.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
		
		масВыбора = УстановитьСписокТиповыхДефектовДляВыбора(Запись.ОбъектРемонта);
		
		ПараметрыВыбора = Новый Массив;
		ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.Ссылка", Новый ФиксированныйМассив(масВыбора)));
		Элементы.ВидДефекта1.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
	Иначе
		масВыбора = новый Массив;
		
		ПараметрыВыбора = Новый Массив;
		ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.Ссылка", Новый ФиксированныйМассив(масВыбора)));
		
		Элементы.Показатель.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
		Элементы.ПараметрНаработки.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
		Элементы.ВидДефекта1.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекСтраницу()
	
	Если Запись.ТипСигнала = ПредопределенноеЗначение("Перечисление.торо_ТипыСигналовАСУТП.Показатель") Тогда
		Элементы.Настройки.ТекущаяСтраница = Элементы.стрПоказатель;
	ИначеЕсли Запись.ТипСигнала = ПредопределенноеЗначение("Перечисление.торо_ТипыСигналовАСУТП.Состояние") Тогда
		Элементы.Настройки.ТекущаяСтраница = Элементы.стрСостояние;
	ИначеЕсли Запись.ТипСигнала = ПредопределенноеЗначение("Перечисление.торо_ТипыСигналовАСУТП.Наработка") Тогда
		Элементы.Настройки.ТекущаяСтраница = Элементы.стрНаработка;
	ИначеЕсли Запись.ТипСигнала = ПредопределенноеЗначение("Перечисление.торо_ТипыСигналовАСУТП.Дефект") Тогда
		Элементы.Настройки.ТекущаяСтраница = Элементы.стрДефект;
	ИначеЕсли Запись.ТипСигнала = ПредопределенноеЗначение("Перечисление.торо_ТипыСигналовАСУТП.KPI") Тогда
		Элементы.Настройки.ТекущаяСтраница = Элементы.стрКПИ;
	Иначе
		Элементы.Настройки.ТекущаяСтраница = Элементы.стрПустая;
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция УстановитьСписокПоказателейДляВыбора(ОбъектРемонта)
	
	масВыбора = Новый Массив;
	
	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда 
		
		ТиповойОР = ОбъектРемонта.ТиповойОР;
		
		СписокТиповых = Новый Массив;
		Если ЗначениеЗаполнено(ТиповойОР) Тогда
			СписокТиповых.Добавить(ТиповойОР);
		КонецЕсли;
		
		ТаблицаРодителейТиповых = торо_ОбщегоНазначения.ПолучитьТаблицуРодителейСпискаОбъектов(СписокТиповых, Тип("СправочникСсылка.торо_ТиповыеОР"), Истина);
		ТаблицаРодителейТиповых.Колонки.Добавить("ОбъектРемонта", Новый ОписаниеТипов("СправочникСсылка.торо_ОбъектыРемонта"));
		ТаблицаРодителейТиповых.ЗаполнитьЗначения(ОбъектРемонта, "ОбъектРемонта");
		
		МассивПоказателей = ПланыВидовХарактеристик.торо_ИзмеряемыеПоказателиОбъектовРемонта.ПолучитьСтруктуруИзмеряемыхПоказателейОбъектовРемонта(ОбъектРемонта,,Истина,,ТаблицаРодителейТиповых);
		
		Для каждого текЭл из МассивПоказателей Цикл
			масВыбора.Добавить(текЭл.Показатель);
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат масВыбора;
	
КонецФункции

&НаСервереБезКонтекста
Функция УстановитьСписокПараметровНаработкиДляВыбора(ОбъектРемонта)
	
	масВозврата = Новый Массив;
	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда
		
		масПоказателей = торо_РаботаСНаработкой.ПолучитьТаблицуПараметровНаработки(ОбъектРемонта, ОбъектРемонта.ТиповойОР);
		
		Для каждого текЭл из масПоказателей Цикл
			масВозврата.Добавить(текЭл.Показатель);
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат масВозврата;
	
КонецФункции

&НаСервереБезКонтекста
функция УстановитьСписокТиповыхДефектовДляВыбора(ОбъектРемонта);
	
	масВозврата = новый Массив;
	Если ЗначениеЗаполнено(ОбъектРемонта) Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	торо_ТиповыеДефектыОборудования.Ссылка КАК Ссылка
		               |ИЗ
		               |	Справочник.торо_ТиповыеДефектыОборудования КАК торо_ТиповыеДефектыОборудования
		               |ГДЕ
		               |	торо_ТиповыеДефектыОборудования.Владелец = &Направление";
		
		Запрос.УстановитьПараметр("Направление", НаправлениеОР(ОбъектРемонта));
			
		РезЗапроса = Запрос.Выполнить();
		Если НЕ РезЗапроса.Пустой() Тогда
			Выборка = РезЗапроса.Выгрузить();
			масВозврата = Выборка.ВыгрузитьКолонку("Ссылка");
		КонецЕсли;
		
	КонецЕсли;
		
	Возврат масВозврата;
	
КонецФункции

&НаКлиенте
Процедура ВидДефекта1НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	СтруктураПараметров = Новый Структура("Отбор, ОдноНаправление", Новый Структура("Владелец",  НаправлениеОР(Запись.ОбъектРемонта)), Истина);
	ОткрытьФорму("Справочник.торо_ТиповыеДефектыОборудования.ФормаВыбора", СтруктураПараметров, Элемент);
КонецПроцедуры

&НаСервереБезКонтекста 
Функция НаправлениеОР(ОбъектРемонта)
	Если ЗначениеЗаполнено(ОбъектРемонта.Направление) Тогда
		Возврат ОбъектРемонта.Направление;
	Иначе
		Возврат Справочники.торо_НаправленияОбъектовРемонтныхРабот.БезНаправления;
	КонецЕсли; 
КонецФункции

&НаКлиенте
Процедура ПараметрНаработкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураОтбора = Новый Структура("Ссылка", УстановитьСписокПараметровНаработкиДляВыбора(Запись.ОбъектРемонта));
	ПараметрыФормы = Новый Структура("Отбор",СтруктураОтбора);
	
	ОткрытьФорму("Справочник.ПараметрыВыработкиОС.ФормаВыбора", ПараметрыФормы, Элемент);
	
КонецПроцедуры

#КонецОбласти


