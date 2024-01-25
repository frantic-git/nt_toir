#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если НЕ ЭтотОбъект.Значение И Справочники.Организации.КоличествоОрганизаций() > 1 Тогда 
		Отказ = Истина;
	ИначеЕсли ЭтотОбъект.Значение И Справочники.Организации.КоличествоОрганизаций() <= 1 Тогда 
		 Отказ = Истина;
	КонецЕсли;
		
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Константы.НеИспользоватьНесколькоОрганизаций.Установить(НЕ ЭтотОбъект.Значение);
	
КонецПроцедуры


#КонецОбласти

#КонецЕсли
