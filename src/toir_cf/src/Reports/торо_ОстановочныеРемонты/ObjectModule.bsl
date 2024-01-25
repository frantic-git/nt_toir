#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ТекущаяИерархия = торо_ОтчетыСервер.ПолучитьЗначениеСтруктурыИерархии(КомпоновщикНастроек);
	
	торо_ОтчетыСервер.УстановитьЗапросыНаборовДанныхИерархииОР(СхемаКомпоновкиДанных, ТекущаяИерархия, "ДатаОкончания", "Данные");
	торо_ОтчетыСервер.УстановитьПолеОбъектИерархии(СхемаКомпоновкиДанных.НаборыДанных.Данные.Запрос, "ВТ_ОсновныеРемонты.ОбъектРемонта", ТекущаяИерархия);
	торо_ОтчетыСервер.УстановитьТипГруппировкиОбъектаИерархии(КомпоновщикНастроек, ТекущаяИерархия);
			
	Для Каждого ПараметрВывода Из КомпоновщикНастроек.Настройки.ПараметрыВывода.Элементы Цикл
		Если ПараметрВывода.Параметр = Новый ПараметрКомпоновкиДанных("ВыводитьПараметрыДанных") Тогда 
			Если ПараметрВывода.Значение = ТипВыводаТекстаКомпоновкиДанных.Авто Тогда
				ПараметрВывода.Значение = ТипВыводаТекстаКомпоновкиДанных.Выводить;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - Структура - см. возвращаемое значение ОтчетыКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт

	// Никаких настроек не требуется.
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли