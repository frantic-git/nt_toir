#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ, Замещение)
	
	торо_МТОСервер.ПоместитьРемонтыВРегистрДляПроверкиАктуальности(ЭтотОбъект.Отбор.ГруппаОбъектовРемонтов.Значение);
	торо_ПланированиеРемонтов.ПометитьКОбновлениюПроектныеЗатратыНаРемонтыПриОбновленииНормативовОР(ЭтотОбъект.Отбор.ГруппаОбъектовРемонтов.Значение);
	
	Если ЗначениеЗаполнено(ЭтотОбъект.Отбор.ГруппаОбъектовРемонтов.Значение) 
		И НЕ ЭтотОбъект.ДополнительныеСвойства.Свойство("НеОбновлятьРегистрНаличиеНормативов") Тогда
		торо_РаботаСНормативамиСервер.ОбновитьСвойствоОР_ЕстьЦепочкиРемонтов(ЭтотОбъект.Отбор.ГруппаОбъектовРемонтов.Значение);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти
