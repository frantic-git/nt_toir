
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура("Отбор, Заголовок", Новый Структура("Контрагент", ПараметрКоманды), НСтр("ru='Договоры с контрагентом'"));
	
	ОткрытьФорму("Справочник.ДоговорыКонтрагентов.ФормаСписка",
				 ПараметрыФормы,
				 ПараметрыВыполненияКоманды.Источник,
				 ПараметрыВыполненияКоманды.Уникальность,
				 ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры

#КонецОбласти