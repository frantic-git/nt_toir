
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура проф_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	//++ Проф-ИТ, #218, Карпов.Д.Ю., 11.08.2023
	НоваяКоманда = Команды.Добавить("ОткрытьРабочееМестоСпециалистаПоОбеспечению"); 
	НоваяКоманда.Действие = "ОткрытьРабочееМестоСпециалистаПоОбеспечениюНажатие"; 
	НоваяКоманда.Заголовок = "Рабочее место специалиста по обеспечению";
	
	НовыйЭлемент = Элементы.Добавить("ОткрытьРабочееМестоСпециалистаПоОбеспечению", Тип("КнопкаФормы"), Элементы.Группа3);
	НовыйЭлемент.ИмяКоманды = "ОткрытьРабочееМестоСпециалистаПоОбеспечению"; 
	//++ Проф-ИТ, #218, Карпов.Д.Ю., 11.08.2023

	//++ Проф-ИТ, #322, Соловьев А.А., 31.10.2023
	СтруктураСвойствСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	СтруктураСвойствСписка.ТекстЗапроса = ТекстЗапросаРемонты();
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Ремонты, СтруктураСвойствСписка);
	//-- Проф-ИТ, #322, Соловьев А.А., 31.10.2023
	
	//++ Проф-ИТ, #329, Соловьев А.А., 08.11.2023
	НоваяКоманда = Команды.Добавить("проф_ОткрытьФормуСписаниеТМЦ"); 
	НоваяКоманда.Действие = "проф_ОткрытьФормуСписаниеТМЦ"; 
	НоваяКоманда.Заголовок = "Списать ТМЦ по закрытым ремонтам";
	НоваяКоманда.Картинка = БиблиотекаКартинок.БыстрыйДоступ;
	НоваяКоманда.Отображение = ОтображениеКнопки.КартинкаИТекст;
	
	НовыйЭлемент = Элементы.Добавить("проф_ОткрытьФормуСписаниеТМЦ", Тип("КнопкаФормы"), Элементы.Группа3);
	НовыйЭлемент.ИмяКоманды = "проф_ОткрытьФормуСписаниеТМЦ"; 
	//-- Проф-ИТ, #329, Соловьев А.А., 08.11.2023
	
	//++ Проф-ИТ, #357, Соловьев А.А., 20.11.2023
	ДополнитьОтборы();
	
	НоваяКоманда = Команды.Добавить("проф_СвязанныеДокументыРемонта"); 
	НоваяКоманда.Действие = "проф_СвязанныеДокументыРемонта"; 
	НоваяКоманда.Заголовок = "Связанные документы";
	НоваяКоманда.Картинка = БиблиотекаКартинок.Отчеты;
	НоваяКоманда.Отображение = ОтображениеКнопки.КартинкаИТекст;
	
	НовыйЭлемент = Элементы.Добавить("проф_СвязанныеДокументыРемонта", Тип("КнопкаФормы"), Элементы.Группа3);
	НовыйЭлемент.ИмяКоманды = "проф_СвязанныеДокументыРемонта"; 
	//-- Проф-ИТ, #357, Соловьев А.А., 20.11.2023
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы 

&НаКлиенте
Процедура ОткрытьРабочееМестоСпециалистаПоОбеспечениюНажатие(Команда)
	//++ Проф-ИТ, #218, Карпов.Д.Ю., 11.08.2023	
	ОткрытьФорму("Обработка.торо_РабочееМестоСпециалистаОбеспечения.Форма.Форма"); 
	//++ Проф-ИТ, #218, Карпов.Д.Ю., 11.08.2023
КонецПроцедуры

//++ Проф-ИТ, #329, Соловьев А.А., 08.11.2023
&НаКлиенте
Процедура проф_ОткрытьФормуСписаниеТМЦ(Команда)
	ОткрытьФорму("Обработка.торо_РабочееМестоТехническогоСпециалиста.Форма.проф_ФормаСписаниеТМЦ"); 
КонецПроцедуры
//-- Проф-ИТ, #329, Соловьев А.А., 08.11.2023

//++ Проф-ИТ, #357, Соловьев А.А., 20.11.2023
&НаКлиенте
Процедура проф_СвязанныеДокументыРемонта(Команда)
	
	ТекущиеДанные = Элементы.Ремонты.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Документ", ТекущиеДанные.Документ);
	ОткрытьФорму("КритерийОтбора.торо_СвязанныеДокументыПоРемонту.ФормаСписка",
		ПараметрыФормы, ТекущиеДанные.Документ, , , );
	
КонецПроцедуры
//-- Проф-ИТ, #357, Соловьев А.А., 20.11.2023

#КонецОбласти

#Область ОбработчикиКомандЭлементовШапкиФормы

//++ Проф-ИТ, #357, Соловьев А.А., 20.11.2023

&НаКлиенте
Процедура ИспользоватьОтборПоГосНомеруПриИзменении(Элемент)
	УстановитьОтборПоГосНомеру();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОтборПоVINПриИзменении(Элемент)
	УстановитьОтборПоVIN();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоГосНомеруПриИзменении(Элемент)
	УстановитьОтборПоГосНомеру();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоVINПриИзменении(Элемент)
	УстановитьОтборПоVIN();
КонецПроцедуры

//-- Проф-ИТ, #357, Соловьев А.А., 20.11.2023

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
&ИзменениеИКонтроль("ВыполнитьВводДокументаНаОсновании")
Процедура Проф_ВыполнитьВводДокументаНаОсновании(ТипВводимогоДокумента, ПредставлениеДокументаВВинПадеже)
	#Вставка
	//++ Проф-ИТ, #237, Карпов.Д.Ю., 11.08.2023
	Если ТипВводимогоДокумента = "торо_ЗаявкаНаРемонт" Тогда
		МассивОР = Новый Массив;
		Для Каждого НомСтроки Из Элементы.Ремонты.ВыделенныеСтроки Цикл
			Строка = Элементы.Ремонты.ДанныеСтроки(НомСтроки);
			Если МассивОР.Найти(Строка.ОбъектРемонта) = Неопределено Тогда
				МассивОР.Добавить(Строка.ОбъектРемонта);    			
			КонецЕсли;
		КонецЦикла;	
			
		Если МассивОР.Количество() > 1 Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю("Документ должен быть создан по одному Объекту ремонта.");
			Возврат; 
	//++ Проф-ИТ, #250, Карпов.Д.Ю., 19.09.2023.Заменил директуву "Вместо" на "ИзменениеИКонтроль"
		КонецЕсли;
	//-- Проф-ИТ, #250, Карпов.Д.Ю., 19.09.2023
	КонецЕсли;
	//++ Проф-ИТ, #237, Карпов.Д.Ю., 11.08.2023
	#КонецВставки
		
	Если ТипВводимогоДокумента = "торо_НарядНаРегламентноеМероприятие"
		ИЛИ ТипВводимогоДокумента = "торо_АктОВыполненииРегламентногоМероприятия" Тогда
		ЭлементФормыТаблица = Элементы.Мероприятия;
	Иначе
		ЭлементФормыТаблица = Элементы.Ремонты;
	КонецЕсли;
	#Удаление
	МассивДанныхСтрок = Новый Массив;
	Если НЕ ОбязательныеПроверкиПередВводомНаОсновании(ЭлементФормыТаблица, МассивДанныхСтрок) Тогда
		Возврат;
	КонецЕсли;
	#КонецУдаления
	#Вставка  
	//++ Проф-ИТ, #250, Карпов.Д.Ю., 19.09.2023
	ТекДанные = ЭлементФормыТаблица.ТекущиеДанные;
	МассивДанныхСтрок = Новый Массив;
	Если ТипВводимогоДокумента = "торо_НарядНаВыполнениеРемонтныхРабот" Тогда
		Если НЕ проф_ОбязательныеПроверкиПередВводомНаОсновании(МассивДанныхСтрок, "заявку на ") Тогда
			Возврат;
		КонецЕсли;
	//++ Проф-ИТ, #300, Корнилов М.С., 16.10.2023
	ИначеЕсли ТипВводимогоДокумента = "торо_ЗаявкаНаРемонт" 
		И ТипЗнч(ТекДанные.Документ) = Тип("ДокументСсылка.торо_ВыявленныеДефекты") Тогда
		
		Если НЕ ОбязательныеПроверкиЗаявкаНаРемонтПередВводомНаОсновании(ЭлементФормыТаблица, МассивДанныхСтрок) Тогда
			Возврат;
		КонецЕсли;
	ИначеЕсли ТипВводимогоДокумента = "торо_АктОВыполненииЭтапаРабот" Тогда 	
		Если НЕ проф_ОбязательныеПроверкиПередВводомНаОсновании(МассивДанныхСтрок) Тогда
			Возврат;
		КонецЕсли;
	//-- Проф-ИТ, #300, Корнилов М.С., 16.10.2023
	Иначе
		Если НЕ ОбязательныеПроверкиПередВводомНаОсновании(ЭлементФормыТаблица, МассивДанныхСтрок) Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	//-- Проф-ИТ, #250, Карпов.Д.Ю., 19.09.2023.
	#КонецВставки
	ЗаполнитьТаблицуВводаНаОсновании();
	
	МассивРемонтовППР = Новый Массив;
	Для каждого Строка Из МассивДанныхСтрок Цикл
		Если ТипЗнч(Строка.Документ) = Тип("ДокументСсылка.торо_ПланГрафикРемонта")
			ИЛИ ТипЗнч(Строка.Документ) = Тип("ДокументСсылка.торо_ГрафикРегламентныхМероприятийТОиР") Тогда
			МассивРемонтовППР.Добавить(Строка.ID_Ремонта);
		КонецЕсли;
	КонецЦикла;
	
	СоответствиеКорректировокППР = Новый Соответствие;
	Если МассивРемонтовППР.Количество() > 0 Тогда
		ЗаполнитьСоответствиеКорректировокППР(МассивРемонтовППР, СоответствиеКорректировокППР);
	КонецЕсли;
	
	СоответствиеРемонтовИОснований = Новый Соответствие;
		
	// Добавление возможных оснований.
	Для каждого Строка Из МассивДанныхСтрок Цикл
		Если ПроверитьВводНаОсновании(Строка.ТипДокумента, ТипВводимогоДокумента) Тогда
			КорректировкаППР = СоответствиеКорректировокППР.Получить(Строка.ID_Ремонта);
			Если КорректировкаППР = Неопределено Тогда
				ВставитьЗначениеВСписокВСоответствии(СоответствиеРемонтовИОснований, Строка.ID_Ремонта, Строка.Документ);
			Иначе
				ВставитьЗначениеВСписокВСоответствии(СоответствиеРемонтовИОснований, Строка.ID_Ремонта, КорректировкаППР);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла; 
	
	// Добавляетя выявленные дефекты, введенные на основании ВО. 
	// С релиза 2.0.38.1 связь больше не сохраняется. 
	// Сохранено для временного поддержания обратной совместимости со старыми документами.
	Если ПроверитьВводНаОсновании("торо_ВыявленныеДефекты", ТипВводимогоДокумента) И ФОИспользоватьДефекты Тогда
		
		ТаблицаЗаявок = ПолучитьСвязанныеДокументыПОID(МассивДанныхСтрок, "ВыявленныеДефекты", Истина);
		Для каждого Строка из ТаблицаЗаявок Цикл
			ВставитьЗначениеВСписокВСоответствии(СоответствиеРемонтовИОснований, Строка.ID, Строка.Документ);
		КонецЦикла;
		
	КонецЕсли;
	
	Если ПроверитьВводНаОсновании("торо_ЗаявкаНаРемонт", ТипВводимогоДокумента) И ФОИспользоватьСметы Тогда
		
		ТаблицаЗаявок = ПолучитьСвязанныеДокументыПОID(МассивДанныхСтрок, "ЗаявкиНаРемонт", Истина);
		Для каждого Строка из ТаблицаЗаявок Цикл
			ВставитьЗначениеВСписокВСоответствии(СоответствиеРемонтовИОснований, Строка.ID, Строка.Документ);
		КонецЦикла;
		
	КонецЕсли;
	
	Если ПроверитьВводНаОсновании("торо_НарядНаВыполнениеРемонтныхРабот", ТипВводимогоДокумента) И ФОИспользоватьНаряды Тогда
		
		ТаблицаНарядов = ПолучитьСвязанныеДокументыПОID(МассивДанныхСтрок, "НарядыНаРемонт", Истина);
		Для каждого Строка из ТаблицаНарядов Цикл
			ВставитьЗначениеВСписокВСоответствии(СоответствиеРемонтовИОснований, Строка.ID, Строка.Документ);
		КонецЦикла;
		
	КонецЕсли;
	
	Если ПроверитьВводНаОсновании("торо_НарядНаРегламентноеМероприятие", ТипВводимогоДокумента) И ФОИспользоватьНарядыНаРегламентныеМероприятия Тогда
		
		ТаблицаНарядов = ПолучитьСвязанныеДокументыПОID(МассивДанныхСтрок, "НарядыНаМероприятия", Истина);
		Для каждого Строка из ТаблицаНарядов Цикл
			ВставитьЗначениеВСписокВСоответствии(СоответствиеРемонтовИОснований, Строка.ID, Строка.Документ);
		КонецЦикла;
		
	КонецЕсли;
	
	Если НЕ ДляВсехРемонтовЕстьОснование(МассивДанныхСтрок, СоответствиеРемонтовИОснований, ПредставлениеДокументаВВинПадеже) Тогда
		Возврат;
	КонецЕсли;

	Если СоответствиеРемонтовИОснований.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	// Проверим, нужно ли открывать форму выбора основания.
	ОткрыватьФормуВыбораОснования = Ложь;
	Для каждого КлючИЗначение из СоответствиеРемонтовИОснований Цикл
		Если КлючИЗначение.Значение.Количество() > 1 Тогда
			ОткрыватьФормуВыбораОснования = Истина;
		КонецЕсли;
	КонецЦикла;
	
	Если ОткрыватьФормуВыбораОснования Тогда
		
		Оповещение = Новый ОписаниеОповещения("ВыборОснованийДляДокумента",ЭтаФорма,Новый Структура("СоздаваемыйДокумент", ТипВводимогоДокумента));
		
		СтруктураДанныхДляВыбораОснований = Новый Структура;
		СтруктураДанныхДляВыбораОснований.Вставить("СоответствиеРемонтовИОснований" , СоответствиеРемонтовИОснований);
		СтруктураДанныхДляВыбораОснований.Вставить("МассивВыделенныхСтрок" , МассивДанныхСтрок);
		
		ОткрытьФорму("Обработка.торо_РабочееМестоТехническогоСпециалиста.Форма.ФормаВыбораОснования",СтруктураДанныхДляВыбораОснований,ЭтаФорма,,ВариантОткрытияОкна.ОтдельноеОкно,,Оповещение,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	Иначе
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ВызватьОбработчикОповещения",ЭтаФорма,Новый Структура("ИмяСобытия, Источник", "СозданДокументЧерезРМТехСпец", Тип("ДокументСсылка."+ТипВводимогоДокумента)));
		
		СоответствиеИДДокументам = Новый Соответствие;
		Для каждого КлючИЗначение Из СоответствиеРемонтовИОснований Цикл
			Если КлючИЗначение.Значение.Количество() > 0 Тогда
				СоответствиеИДДокументам.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение[0]);
			КонецЕсли;
		КонецЦикла; 
		
		СоздатьДокументИОткрытьФорму("Документ."+ТипВводимогоДокумента+".ФормаОбъекта", СоответствиеИДДокументам, ОписаниеОповещения);
		
	КонецЕсли;
	
КонецПроцедуры 

&НаКлиенте
Функция проф_ОбязательныеПроверкиПередВводомНаОсновании(МассивДанныхСтрок, Текст = "")
	//++ Проф-ИТ, #250, Карпов.Д.Ю., 20.09.2023
	ТекДанные = Элементы.ЗаявкиНаРемонт.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда
		ТекстСообщения = СтрШаблон(НСтр("ru = 'Выберите %1ремонт!'"), Текст);
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;
	МассивДокументов = ПолучитьМассивВыделенныхДокументов(Элементы.ЗаявкиНаРемонт,"ДокументЗаявка");
	МассивВыделенныхСтрок = ПолучитьМассивСтрокРемонтовПоДокументу(МассивДокументов);
	
	ОбработатьОстановочныеРемонтыИЗакрытия(МассивВыделенныхСтрок);
	
	КолЗавершенных = 0;
	
	Для Каждого Строка Из МассивВыделенныхСтрок Цикл
		
		Если ЗначениеЗаполнено(Строка.Завершенные) Тогда
			Если ТипЗнч(Строка.Завершенные) = Тип("Строка")
			Или Строка.Завершенные  Тогда
				КолЗавершенных = КолЗавершенных + 1;
			Иначе
				Структура = Новый Структура;
				Структура.Вставить("ОбъектРемонта", Строка.ОбъектРемонта);
				Структура.Вставить("ВидРемонта", Строка.ВидРемонта);
				Структура.Вставить("ПланируемаяДатаНачалаРемонта", Строка.ПланируемаяДатаНачалаРемонта);
				Структура.Вставить("ID_Ремонта", Строка.ID_Ремонта);
				Структура.Вставить("Документ", Строка.Документ);
				Структура.Вставить("ТипДокумента", Строка.ТипДокумента);

				МассивДанныхСтрок.Добавить(Структура);
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Если КолЗавершенных > 0 Тогда
		ТекстСообщения = НСтр("ru = 'В списке выбранных ремонтов есть завершенные!'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	//-- Проф-ИТ, #250, Карпов.Д.Ю., 20.09.2023 
КонецФункции 

&НаКлиенте
Функция ПолучитьМассивВыделенныхДокументов(ЭлементФормыТаблица,РеквизитДокумента) 
	
	//++ Проф-ИТ, #250, Карпов.Д.Ю., 20.09.2023 	
	МассивДокументовЗаявкаНаРемонт = Новый Массив;
	Для Каждого НомСтроки Из ЭлементФормыТаблица.ВыделенныеСтроки Цикл
		Строка = ЭлементФормыТаблица.ДанныеСтроки(НомСтроки);
		Если Строка <> Неопределено Тогда 
			МассивДокументовЗаявкаНаРемонт.Добавить(Строка[РеквизитДокумента]);
		КонецЕсли;
	КонецЦикла;
	Возврат МассивДокументовЗаявкаНаРемонт;
	//-- Проф-ИТ, #250, Карпов.Д.Ю., 20.09.2023 
	
КонецФункции

&НаСервере
Функция ПолучитьМассивСтрокРемонтовПоДокументу(Знач МассивДокументовЗаявкаНаРемонт) 
	
	//++ Проф-ИТ, #250, Карпов.Д.Ю., 20.09.2023 		
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
		|	торо_ЗаявкаНаРемонтРемонтыОборудования.ОбъектРемонта КАК ОбъектРемонта,
		|	торо_ЗаявкаНаРемонтРемонтыОборудования.ВидРемонтныхРабот КАК ВидРемонта,
		|	торо_ЗаявкаНаРемонтРемонтыОборудования.ДатаНачала КАК ПланируемаяДатаНачалаРемонта,
		|	торо_ЗаявкаНаРемонтРемонтыОборудования.ID КАК ID_Ремонта,
		|	торо_ЗаявкаНаРемонтРемонтыОборудования.ДокументИсточник КАК Документ,
		|	ТИПЗНАЧЕНИЯ(торо_ЗаявкаНаРемонтРемонтыОборудования.ДокументИсточник) КАК ТипДокумента
		|ПОМЕСТИТЬ ВТ_ДанныеПоЗаявкам
		|ИЗ
		|	Документ.торо_ЗаявкаНаРемонт.РемонтыОборудования КАК торо_ЗаявкаНаРемонтРемонтыОборудования
		|ГДЕ
		|	торо_ЗаявкаНаРемонтРемонтыОборудования.Ссылка В(&СсылкаДокумент)
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	ID_Ремонта
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТ_ДанныеПоЗаявкам.ОбъектРемонта КАК ОбъектРемонта,
		|	ВТ_ДанныеПоЗаявкам.ВидРемонта КАК ВидРемонта,
		|	ВТ_ДанныеПоЗаявкам.ПланируемаяДатаНачалаРемонта КАК ПланируемаяДатаНачалаРемонта,
		|	ВТ_ДанныеПоЗаявкам.ID_Ремонта КАК ID_Ремонта,
		|	ВТ_ДанныеПоЗаявкам.Документ КАК Документ,
		|	ВТ_ДанныеПоЗаявкам.ТипДокумента КАК ТипДокумента,
		|	ЕСТЬNULL(торо_ОбщиеДанныеПоРемонтам.Завершен, ЛОЖЬ) КАК Завершенные
		|ИЗ
		|	ВТ_ДанныеПоЗаявкам КАК ВТ_ДанныеПоЗаявкам
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
		|		ПО ВТ_ДанныеПоЗаявкам.ID_Ремонта = торо_ОбщиеДанныеПоРемонтам.IDРемонта";
	
	Запрос.УстановитьПараметр("СсылкаДокумент", МассивДокументовЗаявкаНаРемонт);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	Возврат ОбщегоНазначения.ТаблицаЗначенийВМассив(Результат.Выгрузить());
	//-- Проф-ИТ, #250, Карпов.Д.Ю., 20.09.2023 
	
КонецФункции

//++ Проф-ИТ, #300, Корнилов М.С., 16.10.2023
&НаКлиенте
Функция ОбязательныеПроверкиЗаявкаНаРемонтПередВводомНаОсновании(ЭлементФормыТаблица, МассивДанныхСтрок) 

	ТекДанные = ЭлементФормыТаблица.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда
		ТекстСообщения = НСтр("ru = 'Выберите ремонт!'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;
	
	МассивРемонтов = ПолучитьМассивРемонтовПоВыявленномуДефекту(ТекДанные.Документ);
	
	ОбработатьОстановочныеРемонтыИЗакрытия(МассивРемонтов);
	
	КолЗавершенных = 0;
	
	Для Каждого Строка Из МассивРемонтов Цикл
		
		Если Не ЗначениеЗаполнено(Строка.Завершенные) Тогда
			Продолжить;
		КонецЕсли;	
		
		Если ТипЗнч(Строка.Завершенные) = Тип("Строка")
		Или Строка.Завершенные Тогда
			КолЗавершенных = КолЗавершенных + 1;
		Иначе                                   
			Структура = Новый Структура("ОбъектРемонта, ВидРемонта, ПланируемаяДатаНачалаРемонта,
										|ID_Ремонта, Документ, ТипДокумента");
			ЗаполнитьЗначенияСвойств(Структура, Строка);
			МассивДанныхСтрок.Добавить(Структура);
		КонецЕсли;		
		
	КонецЦикла;
	
	Если КолЗавершенных > 0 Тогда
		ТекстСообщения = НСтр("ru = 'В списке выбранных ремонтов есть завершенные!'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьМассивРемонтовПоВыявленномуДефекту(ДокументСсылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_ВыявленныеДефектыСписокДефектов.ОбъектРемонта КАК ОбъектРемонта,
	|	ЗНАЧЕНИЕ(Справочник.торо_ВидыРемонтов.ПустаяСсылка) КАК ВидРемонта,
	|	торо_ВыявленныеДефекты.ДатаОбнаружения КАК ПланируемаяДатаНачалаРемонта,
	|	торо_ВыявленныеДефектыСписокДефектов.ID КАК ID_Ремонта,
	|	торо_ВыявленныеДефекты.Ссылка КАК Документ,
	|	ТИПЗНАЧЕНИЯ(торо_ВыявленныеДефекты.Ссылка) КАК ТипДокумента
	|ПОМЕСТИТЬ ВТ_ДанныеПоЗаявкам
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты.СписокДефектов КАК торо_ВыявленныеДефектыСписокДефектов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|		ПО торо_ВыявленныеДефектыСписокДефектов.Ссылка = торо_ВыявленныеДефекты.Ссылка
	|ГДЕ
	|	торо_ВыявленныеДефектыСписокДефектов.Ссылка = &ДокументСсылка
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ID_Ремонта
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеПоЗаявкам.ОбъектРемонта КАК ОбъектРемонта,
	|	ВТ_ДанныеПоЗаявкам.ВидРемонта КАК ВидРемонта,
	|	ВТ_ДанныеПоЗаявкам.ПланируемаяДатаНачалаРемонта КАК ПланируемаяДатаНачалаРемонта,
	|	ВТ_ДанныеПоЗаявкам.ID_Ремонта КАК ID_Ремонта,
	|	ВТ_ДанныеПоЗаявкам.Документ КАК Документ,
	|	ВТ_ДанныеПоЗаявкам.ТипДокумента КАК ТипДокумента,
	|	ЕСТЬNULL(торо_ОбщиеДанныеПоРемонтам.Завершен, ЛОЖЬ) КАК Завершенные
	|ИЗ
	|	ВТ_ДанныеПоЗаявкам КАК ВТ_ДанныеПоЗаявкам
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
	|		ПО ВТ_ДанныеПоЗаявкам.ID_Ремонта = торо_ОбщиеДанныеПоРемонтам.IDРемонта";
	
	Запрос.УстановитьПараметр("ДокументСсылка", ДокументСсылка);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	Возврат ОбщегоНазначения.ТаблицаЗначенийВМассив(Результат.Выгрузить());
	
КонецФункции
//-- Проф-ИТ, #300, Корнилов М.С., 16.10.2023

//++ Проф-ИТ, #322, Соловьев А.А., 31.10.2023
&НаСервере
Функция ТекстЗапросаРемонты()
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ИнтеграцияДокументов.ID КАК ID,
	|	МИНИМУМ(ВЫБОР
	|			КОГДА ЕСТЬNULL(ЗаказыОстатки.КОформлениюОстаток, 0) - ЕСТЬNULL(Резервы.КоличествоОстаток, 0) - ЕСТЬNULL(НаРуках.КоличествоОстаток, 0) <= 0
	|				ТОГДА ИСТИНА
	|			ИНАЧЕ ЛОЖЬ
	|		КОНЕЦ) КАК Обеспечен
	|ПОМЕСТИТЬ Обеспечение
	|ИЗ
	|	РегистрСведений.торо_ИнтеграцияДокументов КАК ИнтеграцияДокументов
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ЗаказыНаВнутреннееПотребление.Остатки КАК ЗаказыОстатки
	|		ПО (ТИПЗНАЧЕНИЯ(ИнтеграцияДокументов.ДокументЕРП) = ТИП(Документ.ЗаказНаВнутреннееПотребление))
	|			И ИнтеграцияДокументов.ДокументЕРП = ЗаказыОстатки.ЗаказНаВнутреннееПотребление
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.торо_РезервыНаСкладах.Остатки КАК Резервы
	|		ПО (ЗаказыОстатки.ЗаказНаВнутреннееПотребление = Резервы.ЗаказНаВнутреннееПотребление)
	|			И (ЗаказыОстатки.Номенклатура = Резервы.Номенклатура)
	|			И (ЗаказыОстатки.Характеристика = Резервы.Характеристика)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.торо_ТоварыНаРуках.Остатки КАК НаРуках
	|		ПО (ЗаказыОстатки.ЗаказНаВнутреннееПотребление = НаРуках.ЗаказНаВнутреннееПотребление)
	|			И (ЗаказыОстатки.Номенклатура = НаРуках.Номенклатура)
	|			И (ЗаказыОстатки.Характеристика = НаРуках.Характеристика)
	|
	|СГРУППИРОВАТЬ ПО
	|	ИнтеграцияДокументов.ID
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ID
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ОбщиеДанныеПоРемонтам.IDРемонта КАК ID_Ремонта,
	|	торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки КАК ТипДокумента,
	|	торо_ОбщиеДанныеПоРемонтам.ДокументНачалаЦепочки КАК Документ,
	|	ВЫРАЗИТЬ(торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта КАК Справочник.торо_ОбъектыРемонта) КАК ОбъектРемонта,
	|	торо_ОбъектыРемонта.Приоритет КАК ПриоритетОР,
	|	ВЫБОР
	|		КОГДА торо_ОбщиеДанныеПоРемонтам.ВидРемонта = ЗНАЧЕНИЕ(Справочник.торо_ВидыРемонтов.ПустаяСсылка)
	|				И торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВыявленныйДефект)
	|			ТОГДА &торо_ВидРемонтаВД
	|		КОГДА торо_ОбщиеДанныеПоРемонтам.ВидРемонта = ЗНАЧЕНИЕ(Справочник.торо_ВидыРемонтов.ПустаяСсылка)
	|				И торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки = ЗНАЧЕНИЕ(Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВнешнееОснованиеДляРабот)
	|			ТОГДА &торо_ВидРемонтаВО
	|		ИНАЧЕ торо_ОбщиеДанныеПоРемонтам.ВидРемонта
	|	КОНЕЦ КАК ВидРемонта,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДокументОснование КАК ДокументПлановыхДат,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаНачала КАК ПланируемаяДатаНачалаРемонта,
	|	торо_АктуальныеПлановыеДатыРемонтов.ДатаОкончания КАК ПланируемаяДатаОкончанияРемонта,
	|	ЕСТЬNULL(торо_ПлановыеИсполнителиРемонтов.СпособВыполнения, НЕОПРЕДЕЛЕНО) КАК СпособВыполнения,
	|	ЕСТЬNULL(торо_ПлановыеИсполнителиРемонтов.Исполнитель, НЕОПРЕДЕЛЕНО) КАК Исполнитель,
	|	ЕСТЬNULL(торо_ПлановыеИсполнителиРемонтов.УточнениеИсполнителя, НЕОПРЕДЕЛЕНО) КАК Бригада,
	|	торо_ОбщиеДанныеПоРемонтам.Организация КАК Организация,
	|	торо_ОбщиеДанныеПоРемонтам.ПодразделениеИнициатор КАК Подразделение,
	|	торо_ОбщиеДанныеПоРемонтам.ЕстьЗаявка КАК ВведенаЗаявка,
	|	ВЫБОР
	|		КОГДА торо_ТекущееСостояниеОРСрезПоследних.ВидЭксплуатации = ЗНАЧЕНИЕ(Справочник.торо_ВидыЭксплуатации.ПустаяСсылка)
	|			ТОГДА ""Не установлено""
	|		ИНАЧЕ торо_ТекущееСостояниеОРСрезПоследних.ВидЭксплуатации
	|	КОНЕЦ КАК СостояниеОР,
	|	торо_ОбщиеДанныеПоРемонтам.Завершен КАК Завершенные,
	|	СтатусыРемонтов.Статус КАК СтатусРемонта,
	|	торо_ГарантийностьРемонтов.Гарантийный КАК ГарантийныйРемонт,
	|	ЕСТЬNULL(Обеспечение.Обеспечен, ЛОЖЬ) КАК Обеспечен,
	|	торо_ОстановочныеРемонтыСрезПоследних.IDОсновного КАК IDОсновного,
	|	торо_ВыявленныеДефекты.ДефектОписание КАК ОписаниеДефекта,
	//++ Проф-ИТ, #357, Соловьев А.А., 20.11.2023
	|	торо_ОбъектыРемонта.проф_VIN КАК VIN,
	|	торо_ОбъектыРемонта.проф_Госномер КАК Госномер,
	//-- Проф-ИТ, #357, Соловьев А.А., 20.11.2023
	|	торо_ВыявленныеДефекты.КритичностьДефекта КАК КритичностьДефекта
	|ИЗ
	|	РегистрСведений.торо_ОбщиеДанныеПоРемонтам КАК торо_ОбщиеДанныеПоРемонтам
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.торо_АктуальныеПлановыеДатыРемонтов КАК торо_АктуальныеПлановыеДатыРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_АктуальныеПлановыеДатыРемонтов.IDРемонта
	|			И (торо_ОбщиеДанныеПоРемонтам.ВидДокументаНачалаЦепочки В (&СписокВидовИсточников))
	|			И (торо_АктуальныеПлановыеДатыРемонтов.ДатаНачала <= &ПлановыйПериод)
	|			И (НЕ торо_ОбщиеДанныеПоРемонтам.Отменен)
	|			И (торо_АктуальныеПлановыеДатыРемонтов.ДатаНачала > &ДатаОтбораСнизу)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ПлановыеИсполнителиРемонтов КАК торо_ПлановыеИсполнителиРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_ПлановыеИсполнителиРемонтов.IDРемонта
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ТекущееСостояниеОР.СрезПоследних(&ТекущаяДата, ) КАК торо_ТекущееСостояниеОРСрезПоследних
	|		ПО торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта = торо_ТекущееСостояниеОРСрезПоследних.ОбъектРемонта
	|		ЛЕВОЕ СОЕДИНЕНИЕ Обеспечение КАК Обеспечение
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = Обеспечение.ID
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ОстановочныеРемонты.СрезПоследних КАК торо_ОстановочныеРемонтыСрезПоследних
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_ОстановочныеРемонтыСрезПоследних.IDЗависимого
	|			И (НЕ торо_ОстановочныеРемонтыСрезПоследних.Отвязан)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_ВыявленныеДефекты.ID
	|			И торо_ОбщиеДанныеПоРемонтам.ДокументНачалаЦепочки = торо_ВыявленныеДефекты.Регистратор
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_СтатусыРемонтов.СрезПоследних КАК СтатусыРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = СтатусыРемонтов.IDРемонта
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.торо_ГарантийностьРемонтов.СрезПоследних КАК торо_ГарантийностьРемонтов
	|		ПО торо_ОбщиеДанныеПоРемонтам.IDРемонта = торо_ГарантийностьРемонтов.IDРемонта
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
	|		ПО торо_ОбщиеДанныеПоРемонтам.ОбъектРемонта = торо_ОбъектыРемонта.Ссылка
	|ГДЕ
	|	(&ОтображатьЗаверешенные = ИСТИНА
	|			ИЛИ торо_ОбщиеДанныеПоРемонтам.Завершен = ЛОЖЬ)
	|	И торо_ОбщиеДанныеПоРемонтам.Замещен = ЛОЖЬ
	|	И торо_ОбщиеДанныеПоРемонтам.ДокументНачалаЦепочки.ПометкаУдаления = ЛОЖЬ
	|	И торо_АктуальныеПлановыеДатыРемонтов.ДокументОснование.ПометкаУдаления = ЛОЖЬ";
	
	Возврат ТекстЗапроса;
	
КонецФункции
//-- Проф-ИТ, #322, Соловьев А.А., 31.10.2023

//++ Проф-ИТ, #357, Соловьев А.А., 20.11.2023

&НаСервере
Процедура ДополнитьОтборы()
	
	ТипДанныхБулево = Новый ОписаниеТипов("Булево");
	ТипДанныхСтрока20 = Новый ОписаниеТипов("Строка", , 
		Новый КвалификаторыСтроки(20, ДопустимаяДлина.Переменная));
	ТипДанныхСтрока12 = Новый ОписаниеТипов("Строка", , 
		Новый КвалификаторыСтроки(12, ДопустимаяДлина.Переменная));
	
	ДобавляемыеРеквизиты = Новый Массив;
	НовыйРеквизит = Новый РеквизитФормы("ИспользоватьОтборПоГосНомеру", ТипДанныхБулево); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	НовыйРеквизит = Новый РеквизитФормы("ОтборПоГосНомеру", ТипДанныхСтрока12); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	НовыйРеквизит = Новый РеквизитФормы("ИспользоватьОтборПоVIN", ТипДанныхБулево); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	НовыйРеквизит = Новый РеквизитФормы("ОтборПоVIN", ТипДанныхСтрока20); 
	ДобавляемыеРеквизиты.Добавить(НовыйРеквизит);
	
	ИзменитьРеквизиты(ДобавляемыеРеквизиты);
	
	проф_ГруппаОтбор						= Элементы.Добавить("проф_ГруппаОтбор", Тип("ГруппаФормы"), Элементы.Группа6);
	проф_ГруппаОтбор.Вид					= ВидГруппыФормы.ОбычнаяГруппа;
	проф_ГруппаОтбор.Отображение			= ОтображениеОбычнойГруппы.Нет;
	проф_ГруппаОтбор.ОтображатьЗаголовок	= Ложь; 
	проф_ГруппаОтбор.Группировка			= ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	
	НовыйЭлемент					= Элементы.Добавить("ИспользоватьОтборПоГосНомеру", Тип("ПолеФормы"), проф_ГруппаОтбор);
	НовыйЭлемент.Вид				= ВидПоляФормы.ПолеФлажка;
	НовыйЭлемент.Заголовок			= НСтр("ru = 'Использовать отбор по гос. номеру'");
	НовыйЭлемент.ПутьКДанным		= "ИспользоватьОтборПоГосНомеру";
	НовыйЭлемент.УстановитьДействие("ПриИзменении", "ИспользоватьОтборПоГосНомеруПриИзменении");
	
	НовыйЭлемент  					= Элементы.Добавить("ОтборПоГосНомеру", Тип("ПолеФормы"), проф_ГруппаОтбор);
	НовыйЭлемент.Вид 				= ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	НовыйЭлемент.ПутьКДанным		= "ОтборПоГосНомеру";
	НовыйЭлемент.УстановитьДействие("ПриИзменении", "ОтборПоГосНомеруПриИзменении");
	
	НовыйЭлемент  					= Элементы.Добавить("ИспользоватьОтборПоVIN", Тип("ПолеФормы"), проф_ГруппаОтбор);
	НовыйЭлемент.Вид 				= ВидПоляФормы.ПолеФлажка;
	НовыйЭлемент.Заголовок			= НСтр("ru = 'Использовать отбор VIN'");
	НовыйЭлемент.ПутьКДанным		= "ИспользоватьОтборПоVIN";
	НовыйЭлемент.УстановитьДействие("ПриИзменении", "ИспользоватьОтборПоVINПриИзменении");
	
	НовыйЭлемент					= Элементы.Добавить("ОтборПоVIN", Тип("ПолеФормы"), проф_ГруппаОтбор);
	НовыйЭлемент.Вид				= ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	НовыйЭлемент.ПутьКДанным		= "ОтборПоVIN";
	НовыйЭлемент.УстановитьДействие("ПриИзменении", "ОтборПоVINПриИзменении");
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоГосНомеру()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "ГосНомер", ЭтотОбъект["ОтборПоГосНомеру"], 
		ВидСравненияКомпоновкиДанных.Содержит, , ЭтотОбъект["ИспользоватьОтборПоГосНомеру"] И Не ПустаяСтрока(ЭтотОбъект["ОтборПоГосНомеру"]), 
		РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоVIN()
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "VIN", ЭтотОбъект["ОтборПоVIN"], 
		ВидСравненияКомпоновкиДанных.Содержит, , ЭтотОбъект["ИспользоватьОтборПоVIN"] И Не ПустаяСтрока(ЭтотОбъект["ОтборПоVIN"]), 
		РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры
	
//-- Проф-ИТ, #357, Соловьев А.А., 20.11.2023

#КонецОбласти
