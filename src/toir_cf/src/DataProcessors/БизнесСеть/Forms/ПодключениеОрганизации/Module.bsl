
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("Организация", Организация);
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		ВызватьИсключение НСтр("ru = 'Не передана организация'");
	КонецЕсли;
	
	ДанныеОрганизацииВBase64 = 
		ПоместитьВоВременноеХранилище(
			БизнесСеть.ДанныеОрганизацииВBase64(Организация), УникальныйИдентификатор);
			
	НастроитьФормуПриСоздании();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Элементы.КартинкаДлительнаяОперация.Видимость Тогда
		Отказ = Истина;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ОписаниеОповещенияОЗакрытии, ДанныеСервиса);
	
	ОписаниеОповещенияОЗакрытии = Неопределено;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ГиперссылкаНаСайтБизнесСетиНажатие(Элемент)
	
	ОткрытьСайтБизнесСети();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодсказкаНажатие(Элемент)
	
	ПараметрыОткрытия = Новый Структура;
	
	ПараметрыОткрытия.Вставить("РежимПриглашения",     "Общий");
	ПараметрыОткрытия.Вставить("Организация",          Организация);
	ПараметрыОткрытия.Вставить("ЗаполнятьПриОткрытии", Истина);
	
	ОткрытьФорму("Обработка.БизнесСеть.Форма.ОтправкаПриглашенийКонтрагентам", ПараметрыОткрытия);

	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключить(Команда)

	ОчиститьСообщения();
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	НастроитьФормуПриДлительнойОперации(Истина);
	
	Оповещение = Новый ОписаниеОповещения("ПодключитьОрганизациюКСервисуЗавершение", ЭтотОбъект);
	
	БизнесСетьСлужебныйКлиент.ПодключитьОрганизациюКСервису(Организация, КодАктивации, ЭтотОбъект, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменаПодключения(Команда)
	
	Закрыть(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПодключениеОрганизацииКСервису

&НаКлиенте
Процедура ПодключитьОрганизациюКСервисуЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	НастроитьФормуПриДлительнойОперации(Ложь);
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	БизнесСетьСлужебныйКлиент.ВывестиСообщенияФоновогоЗадания(Результат);
	
	ДанныеСервиса = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
	
	Если Не ЗначениеЗаполнено(ДанныеСервиса) Тогда
		БизнесСетьСлужебныйКлиент.ПоказатьОповещениеБизнесСети(НСтр("ru = 'Не удалось подключить организацию'"));
		Возврат;
	КонецЕсли;
	
	Если ДанныеСервиса.СтатусПодключения = "Подключена" Тогда
		Оповестить("Запись_НаборКонстант",, "ИспользоватьОбменБизнесСеть");
		Оповестить("БизнесСеть_РегистрацияОрганизаций",, ЭтотОбъект.ВладелецФормы);
		НастроитьФормуПослеПодключенияОрганизации();
	Иначе
		БизнесСетьСлужебныйКлиент.ПоказатьОповещениеБизнесСети(НСтр("ru = 'Не удалось подключить организацию'"));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

&НаСервере
Процедура НастроитьФормуПриСоздании()
	
	Если БизнесСеть.ТребуетсяПовторноеПодключениеОрганизации(Организация) Тогда
		ШаблонСтроки = 
			НСтр("ru = 'Для организации <a href=""%1"">%2</a> доступ к сервису 1С:Бизнес-сеть был приостановлен. Необходимо повторное подключение организации.'");
	Иначе
		ШаблонСтроки = НСтр("ru = 'Для подключения информационной базы к организации
			|<a href=""%1"">%2</a> в сервисе 1С:Бизнес-сеть, введите одноразовый пароль.'");
	КонецЕсли;	

	Элементы.ПодсказкаФормы.Заголовок = СтроковыеФункции.ФорматированнаяСтрока(
		ШаблонСтроки,
		ПолучитьНавигационнуюСсылку(Организация), 
		Организация);
	
	Элементы.КартинкаДлительнаяОперация.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьСайтБизнесСети()
	
	ДанныеОрганизации = ПолучитьИзВременногоХранилища(ДанныеОрганизацииВBase64);
	
	БизнесСетьСлужебныйКлиент.ОткрытьСтраницуРегистрацииОрганизации(ДанныеОрганизации);

КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПриДлительнойОперации(ЭтоНачалоДлительнойОперации)
	
	Элементы.КартинкаДлительнаяОперация.Видимость = ЭтоНачалоДлительнойОперации;
	Элементы.Продолжить.Доступность               = Не ЭтоНачалоДлительнойОперации;
	Элементы.Отмена.Доступность                   = Не ЭтоНачалоДлительнойОперации;
	Элементы.КодАктивации.Доступность             = Не ЭтоНачалоДлительнойОперации;
	
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуПослеПодключенияОрганизации()
		
	Элементы.ГруппаСтраницы.ТекущаяСтраница = Элементы.СтраницаОрганизацияПодключена;
	
	Элементы.Продолжить.Доступность = Ложь;
	
	Элементы.ПодсказкаФормы.Заголовок = 
		СтроковыеФункции.ФорматированнаяСтрока(
			СтрШаблон(
				"Подключение информационной базы к организации
				|<a href=""%1"">%2</a> в сервисе 1С:Бизнес-сеть завершено.",
					ПолучитьНавигационнуюСсылку(Организация), Организация));
					
	Элементы.Отмена.Заголовок = НСтр("ru = 'Закрыть'");

КонецПроцедуры

#КонецОбласти