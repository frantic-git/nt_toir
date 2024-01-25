#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ДанныеЗадания = Параметры.ДанныеЗадания;
	ПараметрыЗапуска = Параметры.ПараметрыЗапуска;
	РезультатВыполнения = Параметры.РезультатВыполнения;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстновитьОформлениеФормы();
	ЗагрузитьДанные();

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

	Если ЗавершениеРаботы Или Не ЗначениеЗаполнено(IDЗадания) Тогда
	    Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	Отказ = Истина;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПередЗакрытиемПослеВопроса", ЭтотОбъект);
	ПоказатьВопрос(ОписаниеОповещения, НСтр("ru = 'Выполняется загрузка данных. Если прервать процесс, данные не будут загружены в систему. Закрыть форму?'"), РежимДиалогаВопрос.ДаНет);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиОповещенийФоновыхЗаданий

&НаКлиенте 
Процедура ОбработчикОповещенияОПрогрессе(Результат, ДополнительныеПараметры) Экспорт
	Попытка
		Прогресс = Результат.Прогресс;
		Если (ТипЗнч(Прогресс) = Тип("Структура") И Прогресс.Свойство("ЗавершеноАварийно")
			Или Результат.Свойство("Статус") И Результат.Статус = "Выполнено")
			Или Не (ТипЗнч(Прогресс) = Тип("Структура") И Прогресс.Свойство("ДополнительныеПараметры") И ЗначениеЗаполнено(Прогресс.ДополнительныеПараметры)) Тогда
			Возврат;
		КонецЕсли;
		
		Если Прогресс.Свойство("Процент") И ТипЗнч(Прогресс.Процент) = Тип("Число") Тогда
			РезультатВыполнения = Прогресс;
		ИначеЕсли ЗначениеЗаполнено(Прогресс.ДополнительныеПараметры) Тогда
			РезультатВыполнения = Прогресс.ДополнительныеПараметры;
			Оповестить("ОбработчикОповещенияОПрогрессе_Перенос20_30", РезультатВыполнения);
		КонецЕсли;
		
		УстновитьОформлениеФормы();
	Исключение
		ОписаниеОшибки = Нстр("ru = 'Ошибка при обработке оповещения о прогрессе выполнения фонового задания по причине:'") + Символы.ПС + Символы.ПС + ОписаниеОшибки();
		ОбщегоНазначенияКлиент.СообщитьПользователю(ОписаниеОшибки);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОкончанияФоновогоЗадания(Результат, ДополнительныеПараметры) Экспорт
	Попытка
		Если Результат = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		РезультатВыполнения = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
		Если Не ЗначениеЗаполнено(РезультатВыполнения)
			Или Не ТипЗнч(РезультатВыполнения) = Тип("Структура") Тогда
			ОписаниеОшибки = Нстр("ru = 'При получении результата выполнения фонового задания произашла ошибка, см. журнал регистрации.'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ОписаниеОшибки);
		КонецЕсли;
		
		УстновитьОформлениеФормы();
	Исключение
		ОписаниеОшибки = Нстр("ru = 'Ошибка при обработке оповещения об окончании выполнения фонового задания по причине:'") + Символы.ПС + Символы.ПС + ОписаниеОшибки();
		ОбщегоНазначенияКлиент.СообщитьПользователю(ОписаниеОшибки);
		
		СброситьОформлениеФормы();
	КонецПопытки;
	
	IDЗадания = Неопределено;
	
	Оповестить("ОбработчикОкончанияФоновогоЗадания_Перенос20_30", РезультатВыполнения);
	Закрыть();

КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ЗагрузитьДанные()
	
	Если ПараметрыЗапуска.ЭтоКлиент Тогда
		ДвоичныеДанныеАрхива = Новый ДвоичныеДанные(ПараметрыЗапуска.ИмяФайлаДанных);
		ПараметрыЗапуска.Вставить("ДвоичныеДанныеАрхива", ДвоичныеДанныеАрхива);
	КонецЕсли;
	
	СтруктураФоновогоЗадания = ВыполнитьФоновоеЗаданиеНаСервере(ДанныеЗадания, ПараметрыЗапуска);
	
	IDЗадания = СтруктураФоновогоЗадания.ИдентификаторЗадания;
	
	УстновитьОформлениеФормы();
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Истина;
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	Если ДанныеЗадания.ПодключитьОбработчикОповещенияОПрогрессе Тогда
	    ПараметрыОжидания.ОповещениеОПрогрессеВыполнения = Новый ОписаниеОповещения(ДанныеЗадания.ОбработчикОповещенияОПрогрессе, ЭтотОбъект);
	КонецЕсли;
	
	Если ДанныеЗадания.ПодключитьОбработчикЗавершения Тогда
	    ДлительныеОперацииКлиент.ОжидатьЗавершение(СтруктураФоновогоЗадания,
													Новый ОписаниеОповещения(ДанныеЗадания.ОбработчикЗавершения, ЭтотОбъект),
													ПараметрыОжидания);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ВыполнитьФоновоеЗаданиеНаСервере(ДанныеЗадания, ПараметрыЗапуска)
	ПараметрыЗадания = Новый Структура();
	ПараметрыЗадания.Вставить("ПараметрыВыполнения", ПараметрыЗапуска);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = ДанныеЗадания.НаименованиеЗадания;
	ПараметрыВыполнения.ЗапуститьВФоне = Истина;
	ПараметрыВыполнения.Вставить("ИдентификаторФормы", УникальныйИдентификатор); 
	
	СтруктураФоновогоЗадания = ДлительныеОперации.ВыполнитьВФоне(ДанныеЗадания.ВыполняемыйМетод, ПараметрыЗадания, ПараметрыВыполнения);
	
	Возврат СтруктураФоновогоЗадания;
КонецФункции

&НаКлиенте
Процедура УстновитьОформлениеФормы()
	Если Не ЗначениеЗаполнено(РезультатВыполнения)
		Или Не ТипЗнч(РезультатВыполнения) = Тип("Структура") Тогда
		СброситьОформлениеФормы();
	 	Возврат;
	КонецЕсли;
	
	Если РезультатВыполнения.Свойство("Процент") И ТипЗнч(РезультатВыполнения.Процент) = Тип("Число") Тогда
		ПроцентВыполнения = РезультатВыполнения.Процент;
	КонецЕсли;
	
	Если РезультатВыполнения.Свойство("Текст") И ТипЗнч(РезультатВыполнения.Текст) = Тип("Строка") Тогда
		ДопИнформацияВыполнение = РезультатВыполнения.Текст;
	КонецЕсли;
	
	Если РезультатВыполнения.Свойство("ЗагрузкаДанных") И ЗначениеЗаполнено(РезультатВыполнения.ЗагрузкаДанных) Тогда
		Если РезультатВыполнения.ЗагрузкаДанных.Статус = "Выполняется" Тогда
			Элементы.СтатусЗагрузкиДанных.Заголовок = "Загрузка данных. ";
		КонецЕсли;
	КонецЕсли;
	
	Если РезультатВыполнения.Свойство("ЗагрузкаКлючейМП") И ЗначениеЗаполнено(РезультатВыполнения.ЗагрузкаКлючейМП) Тогда
		Если РезультатВыполнения.ЗагрузкаКлючейМП.Статус = "Выполняется" Тогда
			Элементы.СтатусЗагрузкиДанных.Заголовок = "Загрузка ключей. ";
		КонецЕсли;
	КонецЕсли;
	
	Если РезультатВыполнения.Свойство("ЗагрузкаНастроек") И ЗначениеЗаполнено(РезультатВыполнения.ЗагрузкаНастроек) Тогда
		Если РезультатВыполнения.ЗагрузкаНастроек.Статус = "Выполняется" Тогда
			Элементы.СтатусЗагрузкиДанных.Заголовок = "Загрузка настроек пользователя. ";
		КонецЕсли;
		
	КонецЕсли;
		
	Если РезультатВыполнения.Свойство("ЗагрузкаИсторииСистемыВзаимодействия") И ЗначениеЗаполнено(РезультатВыполнения.ЗагрузкаИсторииСистемыВзаимодействия) Тогда
		Если РезультатВыполнения.ЗагрузкаИсторииСистемыВзаимодействия.Статус = "Выполняется" Тогда
			Элементы.СтатусЗагрузкиДанных.Заголовок = "Загрузка истории системы взаимодействия. ";
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СброситьОформлениеФормы()
	
	ПроцентВыполнения = 0;
	ДопИнформацияВыполнение = "";

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемПослеВопроса(Результат, Параметры) Экспорт
    Если Результат = КодВозвратаДиалога.Нет Тогда
        Возврат;
	КонецЕсли;
	
	ОтменитьВыполнениеЗадания(IDЗадания);
	Оповестить("ОбработчикОкончанияФоновогоЗадания_Перенос20_30", Неопределено);
	IDЗадания = Неопределено;
	Закрыть();
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОтменитьВыполнениеЗадания(IDЗадания)
    ДлительныеОперации.ОтменитьВыполнениеЗадания(IDЗадания);
КонецПроцедуры

#КонецОбласти