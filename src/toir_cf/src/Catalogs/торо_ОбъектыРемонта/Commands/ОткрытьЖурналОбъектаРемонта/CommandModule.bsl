
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("ОбъектРемонта", ПараметрКоманды);
	Если ТипЗнч(ПараметрыВыполненияКоманды.Источник) = Тип("ФормаКлиентскогоПриложения") Тогда 
		Если ПараметрыВыполненияКоманды.Источник.ИмяФормы = "Справочник.торо_ОбъектыРемонта.Форма.ФормаЭлемента" Тогда 
			ПараметрыФормы.Вставить("ДатаВводаВЭксплуатацию", ПараметрыВыполненияКоманды.Источник.ДатаВводаВЭксплуатацию);
			ПараметрыФормы.Вставить("ДатаСнятияСУчета", ПараметрыВыполненияКоманды.Источник.ДатаСнятияСУчета);
		ИначеЕсли ПараметрыВыполненияКоманды.Источник.ИмяФормы = "Обработка.торо_РабочееМестоДиспетчера.Форма.Форма" Тогда
			ПараметрыФормы.Вставить("ИзРМТехнолога", Истина);
		КонецЕсли;
	КонецЕсли;
	
	ОткрытьФорму("Справочник.торо_ОбъектыРемонта.Форма.ЖурналОбъектаРемонта", ПараметрыФормы,, ПараметрКоманды.УникальныйИдентификатор());
КонецПроцедуры

#КонецОбласти