
#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, Замещение)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого Запись из ЭтотОбъект Цикл 
		СтарыйСтатус = торо_РаботаССогласованиями.ПолучитьТекущийСтатусСогласованияДокумента(Запись.СогласуемыйДокумент);
		ИзмененСтатус = СтарыйСтатус <> Запись.СтатусДокумента;
		
		Если ИзмененСтатус Тогда
			СтруктураДанных = Новый Структура;
			СтруктураДанных.Вставить("ПредыдущийСтатусДокумента", СтарыйСтатус);
			СтруктураДанных.Вставить("СтатусДокумента", Запись.СтатусДокумента);
			СтруктураДанных.Вставить("ИспользоватьСогласование", Истина);
			СтруктураДанных.Вставить("БылПроведен", Запись.СогласуемыйДокумент.Проведен);
			СтруктураДанных.Вставить("СпособСогласования", Запись.СогласуемыйДокумент.СпособСогласования);
			торо_РаботаСУведомлениями.СформироватьУведомленияСобытияхСогласованияДокументов(СтруктураДанных, Запись.СогласуемыйДокумент);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
