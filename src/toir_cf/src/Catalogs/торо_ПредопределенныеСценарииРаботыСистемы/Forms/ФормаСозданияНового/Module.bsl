
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПараметрСоздания = ЭтаФорма.Параметры.ПараметрыСоздания; 
	
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура ОК(Команда)

	Если НЕ ЗначениеЗаполнено(Наименование) Тогда
		ТекстСообщения = НСтр("ru = 'Не заполнено поле <Наименование>'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли; 
	
	Ссылка = СоздатьЭлементСправочникаНаСервере(ПараметрСоздания,Наименование,Описание);
	
	Если Не ТипЗнч(Ссылка) = Тип("Строка") Тогда
		
		Структура = Новый Структура("Ссылка", Ссылка);
		Оповестить("ОБРАБОТКА_ВЫБОРА_СЦЕНАРИЯ", Структура);
	    Закрыть();
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	Закрыть();
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервереБезКонтекста
Функция СоздатьЭлементСправочникаНаСервере(ПараметрСоздания,Наименование,Описание)
	
	Возврат Справочники.торо_ПредопределенныеСценарииРаботыСистемы.СоздатьЭлементСправочникаНаСервере(ПараметрСоздания,Наименование,Описание);		
КонецФункции
#КонецОбласти