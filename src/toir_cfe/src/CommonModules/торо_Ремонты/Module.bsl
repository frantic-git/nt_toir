
#Область ПодпискиНаСобытия

&ИзменениеИКонтроль("торо_ЗапретИзмененияПроведенныхПриНаличииСозданныхНаОснованииПередЗаписью")
Процедура проф_торо_ЗапретИзмененияПроведенныхПриНаличииСозданныхНаОснованииПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения)

	Если Источник.БезусловнаяЗапись = Истина Или Источник.ЭтоНовый() Или (Не Источник.Проведен И РежимЗаписи = РежимЗаписиДокумента.Проведение) Тогда
		Возврат;
	КонецЕсли; 

	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Или РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда
		СвязанныеДокументы = КритерииОтбора.СвязанныеДокументы.Найти(Источник.Ссылка);

		ЕстьСвязанныеПроведенные = Ложь;
		ЕстьОстановочныйПроведенный = Ложь;
		Для Каждого СвязанныйДокумент Из СвязанныеДокументы Цикл

			Если ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_ПроектныеЗатратыНаРемонты") Тогда
				Продолжить;
			КонецЕсли;

			Если ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_УчетНаработкиОборудования") 
				И ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_УстановкаПроизвольногоЗначенияНаработки") Тогда
				Продолжить;
			КонецЕсли;

			Если ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_ЗаявкаНаРемонт") 
				И ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_ОстановочныеРемонты") Тогда

				Если СвязанныйДокумент.Проведен Тогда
					ЕстьОстановочныйПроведенный = Истина;
				КонецЕсли;
				Продолжить;
			КонецЕсли;

			Если (ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_АктОВыполненииЭтапаРабот")
				Или ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_ВыявленныеДефекты"))
				И (ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_УчетКонтролируемыхПоказателей")
				Или ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_УчетНаработкиОборудования")
				Или ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_СостоянияОбъектовРемонта")) Тогда
				Продолжить;
			КонецЕсли;

			Если ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_АктОВыполненииРегламентногоМероприятия")
				И (ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_УчетНаработкиОборудования")
				Или ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_ВыявленныеДефекты")
				Или ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_СостоянияОбъектовРемонта")
				Или ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_УчетКонтролируемыхПоказателей"))
				И СвязанныйДокумент.ИзМобильного Тогда
				Продолжить;
			КонецЕсли;
			
			#Вставка
			//++ Проф-ИТ, #439, Корнилов М.С., 18.01.2024
			Если ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_ЗаявкаНаРемонт") 
				ИЛИ ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_НарядНаВыполнениеРемонтныхРабот") Тогда  
				Продолжить;				
			КонецЕсли;
			//-- Проф-ИТ, #439, Корнилов М.С., 18.01.2024
			//++ Проф-ИТ, #245, Башинская А.Ю., 06.09.2023 
			Если (ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_ЗаявкаНаРемонт")  
					Или ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_ВыявленныеДефекты")  
					Или ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_АктОВыполненииЭтапаРабот") 
					Или ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_НарядНаВыполнениеРемонтныхРабот") 
				 	Или ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_АктОВыполненииРегламентногоМероприятия"))
				И ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_СостоянияОбъектовРемонта") Тогда
				Продолжить;
			КонецЕсли;        
			//-- Проф-ИТ, #245, Башинская А.Ю., 06.09.2023
			//++ Проф-ИТ, #430, Сергеев Д.Н., 17.01.2024
			Если ТипЗнч(Источник.Ссылка) = Тип("ДокументСсылка.торо_ВыявленныеДефекты") 
				И (ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_ЗаявкаНаРемонт")
				ИЛИ ТипЗнч(СвязанныйДокумент) = Тип("ДокументСсылка.торо_НарядНаВыполнениеРемонтныхРабот")) Тогда  
				Продолжить;				
			КонецЕсли;	
			//-- Проф-ИТ, #430, Сергеев Д.Н., 17.01.2024
			#КонецВставки 
			
			Если СвязанныйДокумент.Проведен Тогда
				ЕстьСвязанныеПроведенные = Истина;
				Прервать;
			КонецЕсли;

		КонецЦикла;

		Если ЕстьСвязанныеПроведенные И РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
			ШаблонСообщения = НСтр("ru = 'Невозможно проведение документа ""%1"", есть документы, введенные на основании данного!'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, Источник.Ссылка);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
		ИначеЕсли (ЕстьСвязанныеПроведенные Или ЕстьОстановочныйПроведенный) И РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения Тогда			
			ШаблонСообщения = НСтр("ru = 'Нельзя отменить проведение документа ""%1"", есть связанные документы!'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, Источник.Ссылка);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
		КонецЕсли;

	КонецЕсли;
КонецПроцедуры

#КонецОбласти 