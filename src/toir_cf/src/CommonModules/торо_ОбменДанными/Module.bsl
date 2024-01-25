
#Область СлужебныеПроцедурыИФункции

Процедура ПринудительнаяРегистрацияОбъектов(ИмяПланОбмена, ОбъектРегистрации, ТипОбъекта) Экспорт
	
	Менеджер = "";
	Если ТипОбъекта = "Справочник" Тогда
		Менеджер = Справочники;
	ИначеЕсли ТипОбъекта = "Документ" Тогда
		Менеджер = Документы;
	Иначе
		Возврат;
	КонецЕсли;
	
	УзелДляОтправки = торо_ОбменДаннымиПовтИсп.ПолучитьУзелДляРегистрацииИзменений(ИмяПланОбмена);
	Если УзелДляОтправки = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	Если ОбъектРегистрации.ЭтоНовый() Тогда
		НоваяСсылка = Менеджер[ОбъектРегистрации.Метаданные().Имя].ПолучитьСсылку();
		ОбъектРегистрации.УстановитьСсылкуНового(НоваяСсылка);
	КонецЕсли;
	ПланыОбмена.ЗарегистрироватьИзменения(УзелДляОтправки, ОбъектРегистрации);
	
КонецПроцедуры

#КонецОбласти
