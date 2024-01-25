#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если НЕ Отказ Тогда
		ОбновитьРеквизитНаборСвойствХарактеристик();
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	Если НЕ ЭтоГруппа Тогда
		УправлениеСвойствами.ПередЗаписьюВидаОбъекта(ЭтотОбъект, "Справочник_Номенклатура", "НаборСвойств"); 
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЧтенииПредставленийНаСервере() Экспорт
    МультиязычностьСервер.ПриЧтенииПредставленийНаСервере(ЭтотОбъект);
 КонецПроцедуры
 
Процедура ПриКопировании(ОбъектКопирования)
	
	Если Не ЭтоГруппа Тогда
		
		НаборСвойств              = Неопределено;
		НаборСвойствХарактеристик = Неопределено;
		НаборСвойствСерий         = Неопределено;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбновитьРеквизитНаборСвойствХарактеристик()
	
	Если ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры
		ИЛИ ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры Тогда
		
		Если Не ЗначениеЗаполнено(НаборСвойствХарактеристик) Тогда
			
			ОбъектНабора = Справочники.НаборыДополнительныхРеквизитовИСведений.СоздатьЭлемент();
			
		Иначе
			
			Если Не НаборСвойствНужноИзменить(НаборСвойствХарактеристик) Тогда
				Возврат;
			КонецЕсли;
			
			ОбъектНабора = НаборСвойствХарактеристик.ПолучитьОбъект();
			
		КонецЕсли;
		
		ОбъектНабора.Наименование    = Наименование + НСтр("ru = ' (Для характеристик)'");
		ОбъектНабора.Родитель        = УправлениеСвойствами.НаборСвойствПоИмени("Справочник_ХарактеристикиНоменклатуры");
		ОбъектНабора.ПометкаУдаления = ПометкаУдаления;
		
		ОбъектНабора.Записать();
		
		НаборСвойствХарактеристик = ОбъектНабора.Ссылка;
		
	Иначе
		
		Если ЗначениеЗаполнено(НаборСвойствХарактеристик) Тогда
			
			ОбъектНабора = НаборСвойствХарактеристик.ПолучитьОбъект();
			
			ОбъектНабора.Наименование    = Наименование + НСтр("ru = ' (Для характеристик)'");
			ОбъектНабора.Родитель        = УправлениеСвойствами.НаборСвойствПоИмени("Справочник_ХарактеристикиНоменклатуры");
			ОбъектНабора.ПометкаУдаления = Истина;
			ОбъектНабора.Записать();
			
			НаборСвойствХарактеристик = Справочники.НаборыДополнительныхРеквизитовИСведений.ПустаяСсылка();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Функция НаборСвойствНужноИзменить(НаборСвойств)
	
	Результат = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(НаборСвойств, Новый Структура("Наименование, ПометкаУдаления"));
	Возврат (Результат.Наименование <> Наименование) ИЛИ (Результат.ПометкаУдаления <> ПометкаУдаления);
	
КонецФункции

#КонецОбласти
#КонецЕсли
