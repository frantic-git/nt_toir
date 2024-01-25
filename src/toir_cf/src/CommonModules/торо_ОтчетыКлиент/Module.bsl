#Область СлужебныйПрограммныйИнтерфейс

Процедура ОткрытьКонтекстныйОтчет_ИсторияИзмененияДатРемонта(ДокументИсточник, ПараметрыВыполнения) Экспорт
	
	МассивID = торо_ПланированиеРемонтовВызовСервера.ПолучитьМассивIDРемонтов(ДокументИсточник);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отбор", Новый Структура("IDРемонта", МассивID));
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	ПараметрыФормы.Вставить("ИспользоватьОтборПоПериоду", Ложь);
	ОткрытьФорму("Отчет.торо_ИсторияИзмененияДатРемонта.Форма", ПараметрыФормы);
	
КонецПроцедуры

Процедура ОткрытьЖурналРемонтовППР(ДокументИсточник, ПараметрыВыполнения) Экспорт
	
	ПараметрыДляПечати = Новый Структура("ДокументППР", ДокументИсточник);
	ОткрытьФорму("Документ.торо_ПланГрафикРемонта.Форма.ФормаЖурналаРемонтов", ПараметрыДляПечати, ПараметрыВыполнения.Форма, ПараметрыВыполнения.Форма.УникальныйИдентификатор);
	
КонецПроцедуры

Процедура ОткрытьФормуЖурналаДефектов(ДокументИсточник, ПараметрыВыполнения) Экспорт
	
	ОткрытьФорму("Документ.торо_ВыявленныеДефекты.Форма.ФормаЖурналаДефектов", , ПараметрыВыполнения.Форма);
	
КонецПроцедуры

Функция ОткрытьПланФактныйАнализППР(ДокументИсточник, ПараметрыВыполнения) Экспорт
	
	РеквизитыДокумента = торо_ОбщегоНазначенияВызовСервера.ЗначенияРеквизитовОбъекта(ДокументИсточник, "Проведен, ДатаПланирования");
	
	Если НЕ РеквизитыДокумента.Проведен Тогда
		ТекстСообщения = НСтр("ru = 'Отчет не формируется на основании непроведенных документов. Проведите документ.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Неопределено;
	КонецЕсли;
	
	ПериодОтчета = Новый СтандартныйПериод();
	ПериодОтчета.Вариант = ВариантСтандартногоПериода.ПроизвольныйПериод;
	ПериодОтчета.ДатаНачала = РеквизитыДокумента.ДатаПланирования;
	ПериодОтчета.ДатаОкончания = торо_ПечатьСервер.ДатаОкончанияПланированияПланГрафикППР(ДокументИсточник);
	ПараметрыОтбора = Новый Структура("ПериодОтчета, ДокументППР", ПериодОтчета, ДокументИсточник);
	ПараметрыОтчета = Новый Структура("ПараметрыОтбора", ПараметрыОтбора);
	Параметры = Новый Структура("ПараметрыОтчета", ПараметрыОтчета);
	ОткрытьФорму("Отчет.торо_ПланФактныйАнализППР.Форма", Параметры);
	
КонецФункции

#КонецОбласти