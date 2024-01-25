
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Объект.ОтборВД = Истина;
	Объект.ОтборВО = Истина;
	Объект.ОтборППР = Истина;
	
	НастройкиВосстановлены = ВосстановитьНастройки();
	
	Если НЕ ЗначениеЗаполнено(Объект.ВариантОтображения) Тогда
		Объект.ВариантОтображения = "БезЗаявок";
	КонецЕсли;
	
	ФОИспользоватьППР = ПолучитьФункциональнуюОпцию("торо_ИспользоватьППР");
	ФОИспользоватьВнешниеОснования = ПолучитьФункциональнуюОпцию("торо_ИспользоватьВнешниеОснованияДляРабот");
	ФОИспользоватьДефекты = ПолучитьФункциональнуюОпцию("торо_УчетВыявленныхДефектовОборудования");
	
	УстановитьПараметрыДинамическогоСписка();
	УстановитьПараметрыВыбораДоговора();
	
	СоответствиеДляМультиязычности = Новый Соответствие();
	МассивРегистров = Новый Массив;
	МассивРегистров.Добавить("РегистрСведений.торо_ВыявленныеДефекты");
	МассивРегистров.Добавить("РегистрСведений.торо_ВнешниеОснованияДляРабот");
	СоответствиеДляМультиязычности.Вставить("Ремонты", МассивРегистров);
	
	торо_МультиязычностьСервер.ПриСозданииНаСервереОбработкаДинамическихСписков(ЭтаФорма, СоответствиеДляМультиязычности);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьОтборСпискаПоВариантуОтображения();
	УстановитьОтборыСписка();
	УправлениеФормой();
	СформироватьЗаголовокСвернутойГруппы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если НЕ ЗавершениеРаботы Тогда
		СохранитьНастройки();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "СозданДокументЧерезРМТехСпец" Тогда
		Элементы.Ремонты.Обновить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьДокументИсточник(Команда)
	
	ТекущиеДанные = Элементы.Ремонты.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено Тогда
		ПоказатьЗначение(, ТекущиеДанные.Документ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьРМДиспетчера(Команда)
	
	ОткрытьФорму("Обработка.торо_РабочееМестоДиспетчера.Форма");
	
КонецПроцедуры

&НаКлиенте
Процедура ВвестиЗаявку(Команда)
	
	ВыполнитьВводДокументаНаОсновании("торо_ЗаявкаНаРемонт", "заявку");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВариантОтображенияПриИзменении(Элемент)
	
	УстановитьОтборСпискаПоВариантуОтображения();
	УстановитьОтборыСписка();
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура РемонтыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "РемонтыЗаявка" Тогда
		ОткрытьЗаявку();
	Иначе
		ОткрытьДокументИсточник(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборПодразделениеИспользованиеПриИзменении(Элемент)
	
	Если Объект.ОтборПодразделениеИспользование Тогда
		Объект.ОтборКонтрагентИспользование = Ложь;
		Объект.ОтборДоговорИспользование = Ложь;
	КонецЕсли;
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборБригадаИспользованиеПриИзменении(Элемент)
	
	Если Объект.ОтборБригадаИспользование Тогда
		Объект.ОтборКонтрагентИспользование = Ложь;
		Объект.ОтборДоговорИспользование = Ложь;
	КонецЕсли;
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонтрагентИспользованиеПриИзменении(Элемент)
	
	Если Объект.ОтборКонтрагентИспользование Тогда
		Объект.ОтборПодразделениеИспользование = Ложь;
		Объект.ОтборБригадаИспользование = Ложь;
	КонецЕсли;
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборДоговорИспользованиеПриИзменении(Элемент)
	
	Если Объект.ОтборДоговорИспользование Тогда
		Объект.ОтборПодразделениеИспользование = Ложь;
		Объект.ОтборБригадаИспользование = Ложь;
	КонецЕсли;
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборПодразделениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураПодбора = Новый Структура;
	СтруктураПодбора.Вставить("МассивВыбранных"                          , ПодразделениеИсполнитель.ВыгрузитьЗначения());
	СтруктураПодбора.Вставить("ТипЗначений"                              , Новый ОписаниеТипов("СправочникСсылка.СтруктураПредприятия"));
	СтруктураПодбора.Вставить("ИспользоватьВариантУчетаИерархииЭлементов", Истина);
	СтруктураПодбора.Вставить("Заголовок"                                , НСтр("ru = 'Отбор по подразделениям-исполнителям'")); 
	
	ОткрытьПодбор(СтруктураПодбора, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборПодразделениеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Не ВыбранноеЗначение = Неопределено Тогда
		
		СтандартнаяОбработка = Ложь;
		ПодразделениеИсполнитель.Очистить();
		ПодразделениеИсполнитель.ЗагрузитьЗначения(ВыбранноеЗначение);
		ОтборБригадаОбработкаВыбора(Элементы.ОтборБригада, ОтобратьБригадыПоМассивуПодразделений(ВыбранноеЗначение, Бригада.ВыгрузитьЗначения()), Ложь);
		УстановитьОтборыСписка();
	
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборПодразделениеПриИзменении(Элемент)

	УстановитьОтборыСписка();	
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборБригадаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураПодбора = Новый Структура;
   	СтруктураПодбора.Вставить("МассивВыбранныхПодразделений", ПодразделениеИсполнитель.ВыгрузитьЗначения());
    СтруктураПодбора.Вставить("МассивВыбранных"             , Бригада.ВыгрузитьЗначения());
    СтруктураПодбора.Вставить("ТипЗначений"                 , Новый ОписаниеТипов("СправочникСсылка.торо_РемонтныеБригады"));
    СтруктураПодбора.Вставить("Заголовок"                   , НСтр("ru = 'Отбор по бригадам'")); 
	
	ОткрытьПодбор(СтруктураПодбора, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборБригадаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Не ВыбранноеЗначение = Неопределено Тогда
		
		СтандартнаяОбработка = Ложь;
		Бригада.Очистить();
		Бригада.ЗагрузитьЗначения(ВыбранноеЗначение);
		УстановитьОтборыСписка();
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонтрагентНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураПодбора = Новый Структура;
	СтруктураПодбора.Вставить("МассивВыбранных" , Контрагент.ВыгрузитьЗначения());
	СтруктураПодбора.Вставить("ТипЗначений"     , Новый ОписаниеТипов("СправочникСсылка.Контрагенты"));
	СтруктураПодбора.Вставить("Заголовок"       , НСтр("ru = 'Отбор по контрагентам'")); 
	
	ОткрытьПодбор(СтруктураПодбора, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонтрагентОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Не ВыбранноеЗначение = Неопределено Тогда
		
		СтандартнаяОбработка = Ложь;
		Контрагент.Очистить();
		Контрагент.ЗагрузитьЗначения(ВыбранноеЗначение);
		
		ОтборДоговорОбработкаВыбора(Элементы.ОтборДоговор, ОтобратьДоговорыПоМассивуКонтрагентов(ВыбранноеЗначение, ДоговорКонтрагента.ВыгрузитьЗначения()), Ложь);
		
		УстановитьОтборыСписка();

	КонецЕсли; 	
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонтрагентПриИзменении(Элемент)
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборДоговорНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СтруктураПодбора = Новый Структура;
    СтруктураПодбора.Вставить("МассивВыбранных"            , ДоговорКонтрагента.ВыгрузитьЗначения());
    СтруктураПодбора.Вставить("МассивВыбранныхКонтрагентов", Контрагент.ВыгрузитьЗначения());
    СтруктураПодбора.Вставить("ТипЗначений"                , Новый ОписаниеТипов("СправочникСсылка.ДоговорыКонтрагентов"));
    СтруктураПодбора.Вставить("Заголовок"                  , НСтр("ru = 'Отбор по договорам контрагентов'")); 
	
	ОткрытьПодбор(СтруктураПодбора, Элемент);	
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборДоговорОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если Не ВыбранноеЗначение = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ДоговорКонтрагента.Очистить();
		ДоговорКонтрагента.ЗагрузитьЗначения(ВыбранноеЗначение);
		УстановитьОтборыСписка();
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборДоговорПриИзменении(Элемент)

	 УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборБригадаПриИзменении(Элемент)
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборСтатусИспользованиеПриИзменении(Элемент)
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборСтатусПриИзменении(Элемент)
	
	УстановитьОтборыСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборППРПриИзменении(Элемент)
	СформироватьЗаголовокСвернутойГруппы();
	УстановитьОтборыСписка();
КонецПроцедуры

&НаКлиенте
Процедура ОтборВОПриИзменении(Элемент)
	СформироватьЗаголовокСвернутойГруппы();
	УстановитьОтборыСписка();
КонецПроцедуры

&НаКлиенте
Процедура ОтборВДПриИзменении(Элемент)
	СформироватьЗаголовокСвернутойГруппы();
	УстановитьОтборыСписка();
КонецПроцедуры

&НаКлиенте
Процедура ОтборНачалоПериодаПриИзменении(Элемент)
	Если Объект.ОтборНачалоПериода > Объект.ОтборКонецПериода Тогда
		ТекстСообщения = НСтр("ru = 'Запрещено вводить дату начала больше даты окончания.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	УстановитьОтборыСписка();
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонецПериодаПриИзменении(Элемент)
	Если Объект.ОтборНачалоПериода > Объект.ОтборКонецПериода Тогда
		ТекстСообщения = НСтр("ru = 'Запрещено вводить дату начала больше даты окончания.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;	
	УстановитьОтборыСписка();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПериодИспользованиеПриИзменении(Элемент)
	УстановитьОтборыСписка();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ВосстановитьНастройки()
	
	ЗначениеНастроек = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("Обработка.торо_АдресацияЗаявок", "");
	
	Если ТипЗнч(ЗначениеНастроек) = Тип("Структура") Тогда
		ЗаполнитьЗначенияСвойств(Объект, ЗначениеНастроек, , "ОтборПодразделение, ОтборБригада, ОтборКонтрагент, ОтборДоговор");
		ПодразделениеИсполнитель = ЗначениеНастроек.ОтборПодразделение;
		Бригада = ЗначениеНастроек.ОтборБригада;
		Контрагент = ЗначениеНастроек.ОтборКонтрагент;
		ДоговорКонтрагента = ЗначениеНастроек.ОтборДоговор;
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура СохранитьНастройки()
	
	СохраненнаяНастройка = Новый Структура;
	СохраненнаяНастройка.Вставить("ВариантОтображения", Объект.ВариантОтображения);
	СохраненнаяНастройка.Вставить("ОтборПодразделение", ПодразделениеИсполнитель);
	СохраненнаяНастройка.Вставить("ОтборПодразделениеИспользование", Объект.ОтборПодразделениеИспользование);
	СохраненнаяНастройка.Вставить("ОтборБригада", Бригада);
	СохраненнаяНастройка.Вставить("ОтборБригадаИспользование", Объект.ОтборБригадаИспользование);
	СохраненнаяНастройка.Вставить("ОтборКонтрагент", Контрагент);
	СохраненнаяНастройка.Вставить("ОтборКонтрагентИспользование", Объект.ОтборКонтрагентИспользование);
	СохраненнаяНастройка.Вставить("ОтборДоговор", ДоговорКонтрагента);
	СохраненнаяНастройка.Вставить("ОтборДоговорИспользование", Объект.ОтборДоговорИспользование);
	СохраненнаяНастройка.Вставить("ОтборСтатус", Объект.ОтборСтатус);
	СохраненнаяНастройка.Вставить("ОтборСтатусИспользование", Объект.ОтборСтатусИспользование);
	
	ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранить("Обработка.торо_АдресацияЗаявок", "", СохраненнаяНастройка);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыДинамическогоСписка()
	
	Ремонты.Параметры.УстановитьЗначениеПараметра("торо_ВидРемонтаВД", Константы.торо_ВидРемонтаПриВводеНаОснованииВыявленныхДефектов.Получить());
	Ремонты.Параметры.УстановитьЗначениеПараметра("торо_ВидРемонтаВО", Константы.торо_ВидРемонтаПриВводеНаОснованииВнешнихОснований.Получить());
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборСпискаПоВариантуОтображения()

	Если Объект.ВариантОтображения = "БезЗаявок" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "ВведенаЗаявка", Ложь,,,Истина, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	ИначеЕсли Объект.ВариантОтображения = "СЗаявками" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "ВведенаЗаявка", Истина,,,Истина, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);		
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "ВведенаЗаявка", Ложь,,,Ложь, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте 
Процедура УстановитьОтборыСписка()
	
	Ремонты.Параметры.УстановитьЗначениеПараметра("ОтборПоПериоду", Объект.ОтборПериодИспользование);
	Ремонты.Параметры.УстановитьЗначениеПараметра("ДатаНачала", Объект.ОтборНачалоПериода);
	Ремонты.Параметры.УстановитьЗначениеПараметра("ДатаОкончания", ?(ЗначениеЗаполнено(Объект.ОтборКонецПериода), Объект.ОтборКонецПериода, Дата(3999,1,1)));

	СписокДокументовОснований = Новый Массив();
	Если Объект.ОтборППР И ФОИспользоватьППР Тогда
		СписокДокументовОснований.Добавить(ПредопределенноеЗначение("Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ПланГрафикППР"));	
	КонецЕсли; 
	Если Объект.ОтборВО И ФОИспользоватьВнешниеОснования Тогда
		СписокДокументовОснований.Добавить(ПредопределенноеЗначение("Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВнешнееОснованиеДляРабот"));	
	КонецЕсли; 
	Если Объект.ОтборВД И ФОИспользоватьДефекты Тогда
		СписокДокументовОснований.Добавить(ПредопределенноеЗначение("Перечисление.торо_ВидыДокументовНачалаЦепочкиРемонтов.ВыявленныйДефект"));	
	КонецЕсли; 
	
	Ремонты.Параметры.УстановитьЗначениеПараметра("СписокВидовИсточников", СписокДокументовОснований);
		
	Если Объект.ВариантОтображения = "БезЗаявок" Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "СтатусРемонта", Объект.ОтборСтатус,,,Ложь, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);	
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "СтатусРемонта", Объект.ОтборСтатус,,,Объект.ОтборСтатусИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);	
	КонецЕсли; 
			
	Если (Объект.ОтборПодразделениеИспользование ИЛИ Объект.ОтборБригадаИспользование) И Объект.ВариантОтображения <> "БезЗаявок" Тогда
		
		ПустыеИсполнители = Новый Массив;
		ПустыеИсполнители.Добавить(Неопределено);
		ПустыеИсполнители.Добавить(ПредопределенноеЗначение("Справочник.СтруктураПредприятия.ПустаяСсылка"));
		
		Если ЗначениеЗаполнено(ПодразделениеИсполнитель) Тогда
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "Исполнитель", 
					ПодразделениеИсполнитель, ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборПодразделениеИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		Иначе
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "Исполнитель", 
					ПустыеИсполнители, ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборПодразделениеИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		КонецЕсли;
		
		ПустыеБригады = Новый Массив;
		ПустыеБригады.Добавить(Неопределено);
		ПустыеБригады.Добавить(ПредопределенноеЗначение("Справочник.торо_РемонтныеБригады.ПустаяСсылка"));

		Если ЗначениеЗаполнено(Бригада) Тогда
		   ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "УточнениеИсполнителя", 
					Бригада,ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборБригадаИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		Иначе
		   ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "УточнениеИсполнителя", 
					ПустыеБригады,ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборБригадаИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		КонецЕсли;
		
	ИначеЕсли (Объект.ОтборКонтрагентИспользование ИЛИ Объект.ОтборДоговорИспользование) И Объект.ВариантОтображения <> "БезЗаявок" Тогда
		
		ПустыеИсполнители = Новый Массив;
		ПустыеИсполнители.Добавить(Неопределено);
		ПустыеИсполнители.Добавить(ПредопределенноеЗначение("Справочник.Контрагенты.ПустаяСсылка"));
		
		Если ЗначениеЗаполнено(Контрагент) Тогда
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "Исполнитель", 
					Контрагент, ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборКонтрагентИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		Иначе
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "Исполнитель", 
					ПустыеИсполнители, ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборКонтрагентИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		КонецЕсли;		
		
		ПустыеДоговора = Новый Массив;
		ПустыеДоговора.Добавить(Неопределено);
		ПустыеДоговора.Добавить(ПредопределенноеЗначение("Справочник.ДоговорыКонтрагентов.ПустаяСсылка"));
		
		Если ЗначениеЗаполнено(ДоговорКонтрагента) Тогда
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "УточнениеИсполнителя", 
					ДоговорКонтрагента,ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборДоговорИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);		
		Иначе	
		    ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "УточнениеИсполнителя", 
					ПустыеДоговора,ВидСравненияКомпоновкиДанных.ВСписке,,
					Объект.ОтборДоговорИспользование, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		КонецЕсли; 				
		
	Иначе
		
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "Исполнитель",	Неопределено,ВидСравненияКомпоновкиДанных.Равно,,Ложь, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Ремонты, "УточнениеИсполнителя",	Неопределено,,,Ложь, РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УправлениеФормой()

	Элементы.РемонтыВведенаЗаявка.Видимость = (Объект.ВариантОтображения <> "БезЗаявок");
	Элементы.РемонтыЗаявка.Видимость = (Объект.ВариантОтображения <> "БезЗаявок");
	
	Элементы.ГруппаОтборПодразделениеБригада.Видимость = (Объект.ВариантОтображения <> "БезЗаявок");
	Элементы.ГруппаОтборКонтрагентДоговор.Видимость = (Объект.ВариантОтображения <> "БезЗаявок");
	Элементы.ГруппаОтборСтатус.Видимость = (Объект.ВариантОтображения <> "БезЗаявок");
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьЗаявку()
	
	ТекущиеДанные = Элементы.Ремонты.ТекущиеДанные;
	Если ТекущиеДанные <> Неопределено И ЗначениеЗаполнено(ТекущиеДанные.Заявка) Тогда
		ПоказатьЗначение(, ТекущиеДанные.Заявка);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыВыбораДоговора()
	
	Если ЗначениеЗаполнено(Объект.ОтборДоговор) И Объект.ОтборДоговор.Контрагент <> Объект.ОтборКонтрагент Тогда
		Объект.ОтборДоговор = Справочники.ДоговорыКонтрагентов.ПустаяСсылка();		
	КонецЕсли; 
	
	МассивСвязей = Новый Массив;
	
	Если ЗначениеЗаполнено(Объект.ОтборКонтрагент) Тогда
		МассивСвязей.Добавить(Новый СвязьПараметраВыбора("Отбор.Контрагент", "Объект.ОтборКонтрагент", РежимИзмененияСвязанногоЗначения.Очищать));
	КонецЕсли;
	
	Элементы.ОтборДоговор.СвязиПараметровВыбора = Новый ФиксированныйМассив(МассивСвязей);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьВводДокументаНаОсновании(ТипВводимогоДокумента, ПредставлениеДокументаВВинПадеже)

	МассивДанныхСтрок = ПолучитьМассивВыделенныхСтрокРемонтов(Элементы.Ремонты);
	Если МассивДанныхСтрок.Количество() = 0 Тогда
		ТекстСообщения = НСтр("ru = 'Выберите ремонт!'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	ЗаполнитьТаблицуВводаНаОсновании();
	
	МассивРемонтовППР = Новый Массив;
	Для каждого Строка Из МассивДанныхСтрок Цикл
		Если ТипЗнч(Строка.Документ) = Тип("ДокументСсылка.торо_ПланГрафикРемонта") Тогда
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
	
	Если НЕ ДляВсехРемонтовЕстьОснование(МассивДанныхСтрок, СоответствиеРемонтовИОснований, ПредставлениеДокументаВВинПадеже) Тогда
		Возврат;
	КонецЕсли;

	Если СоответствиеРемонтовИОснований.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ВызватьОбработчикОповещения",ЭтаФорма, Новый Структура("ИмяСобытия, Источник", "СозданДокументЧерезРМТехСпец", Тип("ДокументСсылка."+ТипВводимогоДокумента)));
	
	СоответствиеИДДокументам = Новый Соответствие;
	Для каждого КлючИЗначение Из СоответствиеРемонтовИОснований Цикл
		Если КлючИЗначение.Значение.Количество() > 0 Тогда
			СоответствиеИДДокументам.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение[0]);
		КонецЕсли;
	КонецЦикла; 
	
	СоздатьДокументИОткрытьФорму("Документ."+ТипВводимогоДокумента+".ФормаОбъекта", СоответствиеИДДокументам, ОписаниеОповещения);
	
КонецПроцедуры
	
&НаКлиенте
Функция ПолучитьМассивВыделенныхСтрокРемонтов(ЭлементыРемонты)
	
	МассивВыделенныхСтрок = Новый Массив;	
	
	Для Каждого НомСтроки Из ЭлементыРемонты.ВыделенныеСтроки Цикл
		Строка = ЭлементыРемонты.ДанныеСтроки(НомСтроки);
		Если НЕ Строка = Неопределено Тогда 
			МассивВыделенныхСтрок.Добавить(Строка);
		КонецЕсли;
	КонецЦикла;	
	
	Возврат МассивВыделенныхСтрок;
		
КонецФункции

&НаСервере
Процедура ЗаполнитьТаблицуВводаНаОсновании()
	
	ТабНастроек = торо_ЗаполнениеДокументовПовторноеИспользование.ПолучитьТаблицуВводаНаОсновании();
	ВводНаОсновании.Загрузить(ТабНастроек);
	
КонецПроцедуры

&НаКлиенте
Функция ПроверитьВводНаОсновании(ДокументОснование, ДокументВводимый)
	
	МассивСтрок = ВводНаОсновании.НайтиСтроки(Новый Структура("ДокументОснование, ДокументВводимый", ДокументОснование, ДокументВводимый));
	
	Если МассивСтрок.Количество() > 0 Тогда 
		Возврат Истина;
	Иначе
		Возврат Ложь;	
	КонецЕсли;
	
КонецФункции

&НаКлиентеНасервереБезКонтекста
Процедура ВставитьЗначениеВСписокВСоответствии(Соответствие, Ключ, Значение)
	
	ТекущееЗначение = Соответствие[Ключ];
	Если ТекущееЗначение = Неопределено Тогда
		ТекущееЗначение = Новый Массив;
	КонецЕсли;
	
	ТекущееЗначение.Добавить(Значение);
	
	Соответствие.Вставить(Ключ, ТекущееЗначение);	
	
КонецПроцедуры

&НаКлиенте
Функция ДляВсехРемонтовЕстьОснование(МассивДанныхСтрок, СоответствиеРемонтовИОснований, ПредставлениеДокументаДляПользователя)
	
	// Проверим, по всем ли ремонтам нашлось хотя бы одно основание.
	МассивДокументовБезОснований = Новый Массив;
	Для каждого Строка Из МассивДанныхСтрок Цикл
		МассивОснований = СоответствиеРемонтовИОснований[Строка.ID_Ремонта];
		Если МассивОснований = Неопределено И МассивДокументовБезОснований.Найти(Строка.Документ) = Неопределено Тогда
			МассивДокументовБезОснований.Добавить(Строка.Документ);                                
		КонецЕсли;
	КонецЦикла; 
	
	Если МассивДокументовБезОснований.Количество() > 0 Тогда
		Если МассивДанныхСтрок.Количество() = 1 Тогда
			ШаблонСообщения = НСтр("ru = 'Настройки ввода на основании запрещают ввести %1 на основании выбранного документа.
			|Настройка и администрирование -> Настройка параметров системы -> Интерфейс и ввод документов -> Настройка бизнес-процессов.'");
		ИначеЕсли МассивДанныхСтрок.Количество() > 1 Тогда
			ШаблонСообщения = НСтр("ru = 'Настройки ввода на основании запрещают ввести %1 на основании некоторых выбранных документов.
			|Настройка и администрирование -> Настройка параметров системы -> Интерфейс и ввод документов -> Настройка бизнес-процессов.'");
		КонецЕсли;
		ТекстСообщения = СтрШаблон(ШаблонСообщения, ПредставлениеДокументаДляПользователя);
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат Ложь;
	КонецЕсли;

	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура СоздатьДокументИОткрытьФорму(ИмяФормы, СоответствиеИДДокументам, ОписаниеОповещения = Неопределено)

	ОткрытьФорму(ИмяФормы, Новый Структура("Основание",СоответствиеИДДокументам),ЭтаФорма,,,,ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ВызватьОбработчикОповещения(Результат, ДопПараметры) Экспорт
	
	ОбработкаОповещения(ДопПараметры.ИмяСобытия, Неопределено, ДопПараметры.Источник);
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьЗаголовокСвернутойГруппы()
	
	ЗаголовокСвернутойГруппы = "Выводить информацию по ";
	
	ПерваяЗапись = Истина;
	Если Объект.ОтборППР Тогда
		ЗаголовокСвернутойГруппы = ЗаголовокСвернутойГруппы + "план графикам ремонта";
		ПерваяЗапись = Ложь;
	КонецЕсли;
	
	Если Объект.ОтборВО Тогда
		Если не ПерваяЗапись тогда
			ЗаголовокСвернутойГруппы = ЗаголовокСвернутойГруппы + ", ";
		КонецЕсли;
		
		ЗаголовокСвернутойГруппы = ЗаголовокСвернутойГруппы + "внешним основаниям";
		ПерваяЗапись = Ложь;
	КонецЕсли;
	
	Если Объект.ОтборВД Тогда
		Если не ПерваяЗапись тогда
			ЗаголовокСвернутойГруппы = ЗаголовокСвернутойГруппы + ", ";
		КонецЕсли;
		ЗаголовокСвернутойГруппы = ЗаголовокСвернутойГруппы + "выявленным дефектам";
		ПерваяЗапись = Ложь;
	КонецЕсли;
	
	Элементы.ГруппаОтборыОснования.ЗаголовокСвернутогоОтображения = ЗаголовокСвернутойГруппы;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаполнитьСоответствиеКорректировокППР(МассивРемонтовППР, СоответствиеКорректировокППР)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ПлановыеРемонтныеРаботыСрезПоследних.ID КАК ID,
	|	торо_ПлановыеРемонтныеРаботыСрезПоследних.Регистратор КАК Документ
	|ИЗ
	|	РегистрСведений.торо_ПлановыеРемонтныеРаботы.СрезПоследних(
	|			,
	|			ID В (&МассивID)
	|				И Регистратор ССЫЛКА Документ.торо_ПланГрафикРемонта) КАК торо_ПлановыеРемонтныеРаботыСрезПоследних";
	
	Запрос.УстановитьПараметр("МассивID", МассивРемонтовППР);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		СоответствиеКорректировокППР.Вставить(Выборка.ID, Выборка.Документ);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте 
Процедура ОткрытьПодбор(СтруктураПодбора, Элемент)
	
	ОткрытьФорму("ОбщаяФорма.торо_ФормаПодбораВСписок", СтруктураПодбора, Элемент,,ВариантОткрытияОкна.ОтдельноеОкно,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаСервереБезКонтекста 
Функция ОтобратьБригадыПоМассивуПодразделений(МассивПодразделений, МассивБригады)
	
	Запрос = Новый Запрос;
	# Область ТекстЗапроса
	Запрос.Текст = "ВЫБРАТЬ
	|	торо_РемонтныеБригады.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.торо_РемонтныеБригады КАК торо_РемонтныеБригады
	|ГДЕ
	|	торо_РемонтныеБригады.Подразделение В (&Подразделение)
	|	И торо_РемонтныеБригады.Ссылка В (&Ссылка)";
	# КонецОбласти
	
	Запрос.УстановитьПараметр("Подразделение", МассивПодразделений);
	Запрос.УстановитьПараметр("Ссылка"       , МассивБригады);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Новый Массив;
	Иначе
		Выборка = РезультатЗапроса.Выбрать();
		
		Массив = Новый Массив;
		Пока Выборка.Следующий() Цикл
			Массив.Добавить(Выборка.Ссылка);	
		КонецЦикла; 
		
		Возврат Массив;
	КонецЕсли; 
	
КонецФункции

&НаСервереБезКонтекста 
Функция ОтобратьДоговорыПоМассивуКонтрагентов(МассивКонтрагентов, МассивДоговоры)
	
	Запрос = Новый Запрос;
	# Область ТекстЗапроса
	Запрос.Текст = "ВЫБРАТЬ
	               |	ДоговорыКонтрагентов.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	               |ГДЕ
	               |	ДоговорыКонтрагентов.Ссылка В(&Ссылка)
	               |	И ДоговорыКонтрагентов.Контрагент В(&Контрагент)";
	# КонецОбласти
	
	Запрос.УстановитьПараметр("Контрагент", МассивКонтрагентов);
	Запрос.УстановитьПараметр("Ссылка"    , МассивДоговоры);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Новый Массив;
	Иначе
		Выборка = РезультатЗапроса.Выбрать();
		
		Массив = Новый Массив;
		Пока Выборка.Следующий() Цикл
			Массив.Добавить(Выборка.Ссылка);	
		КонецЦикла; 
		
		Возврат Массив;
	КонецЕсли; 
	
КонецФункции

#КонецОбласти
