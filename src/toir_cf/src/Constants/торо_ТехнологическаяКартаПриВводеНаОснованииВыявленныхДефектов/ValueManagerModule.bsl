#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если Значение <> Константы.торо_ТехнологическаяКартаПриВводеНаОснованииВыявленныхДефектов.Получить() Тогда
		ДополнительныеСвойства.Вставить("ЗначениеИзменилось", Истина);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ДополнительныеСвойства.Свойство("ЗначениеИзменилось") Тогда
		торо_ПланированиеРемонтов.ПометитьКОбновлениюПроектныеЗатратыНаРемонтыПриИзмененииПараметровДляВД();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
