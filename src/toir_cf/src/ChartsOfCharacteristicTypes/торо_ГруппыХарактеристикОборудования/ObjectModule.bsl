#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗаполнятьАвтоматически Тогда
		ЗаполнитьСписокХаракеристикАвтоматически();
	Иначе
		ПараметрыАвтозаполнения.Очистить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьСписокХаракеристикАвтоматически()

	СписокХарактеристик.Очистить();
	
	Если ПараметрыАвтозаполнения.Количество() > 0 Тогда
		МассивХарактеристик = ПланыВидовХарактеристик.торо_ГруппыХарактеристикОборудования.ОтобратьХарактеристикиОборудования(ТипЗначения, ПараметрыАвтозаполнения);
		Для каждого Характеристика из МассивХарактеристик Цикл
			НоваяСтрока = СписокХарактеристик.Добавить();
			НоваяСтрока.Характеристика = Характеристика;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
