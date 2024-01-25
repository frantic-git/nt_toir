#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьВидимостьЭлементовПоПравамПользвателя();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементовПоПравамПользвателя()
	
	СоответствиеЭлементов = Новый Соответствие;
	СоответствиеЭлементов.Вставить("ГруппаВидыДефектов", Метаданные.Справочники.торо_ВидыДефектов);
	СоответствиеЭлементов.Вставить("ГруппаПричиныДефектов", Метаданные.Справочники.торо_ПричиныДефектов);
	СоответствиеЭлементов.Вставить("ГруппаТиповыеДефекты", Метаданные.Справочники.торо_ТиповыеДефектыОборудования);
	СоответствиеЭлементов.Вставить("ГруппаКритичностьДефекта", Метаданные.Справочники.торо_КритичностьДефекта);
	СоответствиеЭлементов.Вставить("ГруппаУсловияВыявленияДефекта", Метаданные.Справочники.торо_УсловияВыявленияДефекта);
	СоответствиеЭлементов.Вставить("ГруппаКонтролируемыеПоказателиОбъектовРемонта", Метаданные.ПланыВидовХарактеристик.торо_ИзмеряемыеПоказателиОбъектовРемонта);
	СоответствиеЭлементов.Вставить("ГруппаЗначенияИзмеряемыхПоказателейОбъектовРемонта", Метаданные.Справочники.торо_ЗначенияИзмеряемыхПоказателейОбъектовРемонта);
	СоответствиеЭлементов.Вставить("ГруппаПараметрыВыработкиОС", Метаданные.Справочники.ПараметрыВыработкиОС);
	СоответствиеЭлементов.Вставить("ГруппаПричиныИзмененияНаработки", Метаданные.Справочники.торо_ПричиныИзмененияНаработки);
	СоответствиеЭлементов.Вставить("ГруппаВидыЭксплуатации", Метаданные.Справочники.торо_ВидыЭксплуатации);
	СоответствиеЭлементов.Вставить("ГруппаПричиныПростояОбордования", Метаданные.Справочники.торо_ПричиныПростояОборудования);
	СоответствиеЭлементов.Вставить("ГруппаАнализКоренныхПричин", Метаданные.Справочники.торо_КоренныеПричиныДефектов);
	
	Для каждого КлючИЗначение из СоответствиеЭлементов Цикл
		Если НЕ ПравоДоступа("Просмотр", КлючИЗначение.Значение) И Элементы.Найти(КлючИЗначение.Ключ) <> Неопределено Тогда
			Элементы[КлючИЗначение.Ключ].Видимость = Ложь;	
		КонецЕсли;
	КонецЦикла;
	
	Если НЕ Константы.торо_УчетСостоянияОборудования.Получить() Тогда
		Элементы.ГруппаВидыЭксплуатации.Видимость = Ложь;
		Элементы.ГруппаПричиныПростояОбордования.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ПолучитьФункциональнуюОпцию("торо_НазначениеНаРемонтСУчетомРисков") Тогда
		Элементы.ГруппаНазначениеСУчетомРисковЗаголовок.Видимость = Ложь;
	КонецЕсли; 
	
	Если НЕ ПолучитьФункциональнуюОпцию("торо_ИспользоватьАнализКорневыхПричин") Тогда 
		Элементы.ГруппаАнализКоренныхПричин.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьВидыДефектов(Команда)
	ОткрытьФорму("Справочник.торо_ВидыДефектов.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПричиныДефектов(Команда)
	ОткрытьФорму("Справочник.торо_ПричиныДефектов.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьТиповыеДефектыОборудования(Команда)
	ОткрытьФорму("Справочник.торо_ТиповыеДефектыОборудования.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКритичностьДефекта(Команда)
	ОткрытьФорму("Справочник.торо_КритичностьДефекта.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьУсловияВыявленияДефекта(Команда)
	ОткрытьФорму("Справочник.торо_УсловияВыявленияДефекта.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПричиныИзмененияНаработки(Команда)
	ОткрытьФорму("Справочник.торо_ПричиныИзмененияНаработки.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПараметрыВыработкиОС(Команда)
	ОткрытьФорму("Справочник.ПараметрыВыработкиОС.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКонтролируемыеПоказателиОбъектовРемонта(Команда)
	ОткрытьФорму("ПланВидовХарактеристик.торо_ИзмеряемыеПоказателиОбъектовРемонта.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьЗначенияИзмеряемыхПоказателейОбъектовРемонта(Команда)
	ОткрытьФорму("Справочник.торо_ЗначенияИзмеряемыхПоказателейОбъектовРемонта.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВидыЭксплуатации(Команда)
	ОткрытьФорму("Справочник.торо_ВидыЭксплуатации.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПричиныПростояОборудования(Команда)
	ОткрытьФорму("Справочник.торо_ПричиныПростояОборудования.ФормаСписка", , ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКатегорииТяжестиПоследствий(Команда)
	ОткрытьФорму("Справочник.торо_КатегорииТяжестиПоследствий.Форма.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьОбъектыВоздействия(Команда)
	ОткрытьФорму("Справочник.торо_ОбъектыВоздействия.Форма.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКатегорииРиска(Команда)
	ОткрытьФорму("Справочник.торо_КатегорииРиска.Форма.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКатегорииВероятности(Команда)
	ОткрытьФорму("Справочник.торо_КатегорииВероятности.Форма.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьРСПоследствия(Команда)
	ОткрытьФорму("РегистрСведений.торо_Последствия.Форма.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКоренныеПричины(Команда)
	ОткрытьФорму("Справочник.торо_КоренныеПричиныДефектов.Форма.ФормаСписка",,ЭтаФорма);
КонецПроцедуры

#КонецОбласти
