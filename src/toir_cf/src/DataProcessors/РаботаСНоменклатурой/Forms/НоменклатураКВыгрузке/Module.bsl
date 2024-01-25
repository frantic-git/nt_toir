
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("АдресТоваровВХранилище", АдресТоваровВХранилище);
	Параметры.Свойство("Организация", Организация);
	НастройкаВыгрузки    = РаботаСНоменклатуройСлужебный.НастройкаВыгрузкиНоменклатуры(Организация);
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, НастройкаВыгрузки,, "Организация");
	
	ИспользоватьПодбор = РаботаСНоменклатурой.ИспользоватьПодборНоменклатурыСХарактеристиками();
	
	УстановитьПараметрыДинамическихСписков();
	ОбновитьСтатистику();
	УстановитьВидимостьДоступностьЭлементовФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЗаголовкиЗакладок();
	Элементы.ДекорацияОтбор.Заголовок = РаботаСНоменклатуройСлужебныйКлиент.ЗаголовокДекорацииУсловияОтбора(НастройкиОтбора);
	УстановитьЗаголовокВыгружаемыеРеквизиты();
	
	Если Не ПустаяСтрока(АдресТоваровВХранилище) И ЭтоАдресВременногоХранилища(АдресТоваровВХранилище) Тогда
		ЗакрытиеПодбора(АдресТоваровВХранилище, Истина);
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОповещатьОНовыхПриИзменении(Элемент)
	Элементы.ДекорацияОтбор.Доступность = ОповещатьОНовых;
	ОбновляемыеПараметры = Новый Структура("ОповещатьОНовых", ОповещатьОНовых);
	РаботаСНоменклатуройСлужебныйВызовСервера.ОбновитьПараметрыНастройкиВыгрузки(Организация, ОбновляемыеПараметры);
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияОтборОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	Если НавигационнаяСсылкаФорматированнойСтроки = "ИзменитьОтбор" Тогда
		СтандартнаяОбработка = Ложь;
		ОткрытьФормуУсловия(Ложь);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	РаботаСНоменклатуройКлиентПереопределяемый.ОткрытьФормуНоменклатуры(Элемент.ТекущиеДанные.Номенклатура, ЭтотОбъект);		
КонецПроцедуры

&НаКлиенте
Процедура СписокПослеУдаления(Элемент)
	ОбновитьСтатистику(, Ложь);
	ОбновитьЗаголовкиЗакладок(, Ложь);	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокВыгрузкаЗапрещена

&НаКлиенте
Процедура СписокВыгрузкаЗапрещенаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	РаботаСНоменклатуройКлиентПереопределяемый.ОткрытьФормуНоменклатуры(Элемент.ТекущиеДанные.Номенклатура, ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура СписокВыгрузкаЗапрещенаПослеУдаления(Элемент)
	ОбновитьСтатистику(Ложь);
	ОбновитьЗаголовкиЗакладок(Ложь);	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Добавить(Команда)
	ОткрытьПодбор();
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИсключение(Команда)
	ОткрытьПодбор(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура Очистить(Команда)
	
	Если КоличествоВыгружается = 0 Тогда
		Возврат
	КонецЕсли;
	
	ПоказатьВопрос(Новый ОписаниеОповещения("ОчиститьЗавершение", ЭтотОбъект),
		НСтр("ru = 'Список выгружаемых позиций будет очищен. Продолжить?'"),
		РежимДиалогаВопрос.ДаНет,,
		КодВозвратаДиалога.Да);
		
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат	
	КонецЕсли;
	
	ДлительнаяОперация = ОчиститьСписокВыгрузки(УникальныйИдентификатор, Организация);
	Если ДлительнаяОперация.Статус = "Выполнено" Тогда
		ПослеОчисткиСпискаВыгрузки(ДлительнаяОперация, Неопределено);
		Возврат
	КонецЕсли;
	
	ОповещениеОЗавершении   = Новый ОписаниеОповещения("ПослеОчисткиСпискаВыгрузки", ЭтотОбъект);
	ПараметрыОжидания       = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтаФорма);
	ПараметрыОжидания.ТекстСообщения = НСтр("ru = 'Очистки списка выгрузки'");
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеОчисткиСпискаВыгрузки(Результат, ДополнительныеПараметры) Экспорт 
	
	Если Результат = Неопределено Тогда // Пользователь отменил задание.
		Возврат;
	КонецЕсли;

	Если Результат.Статус = "Ошибка" Тогда
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
	Элементы.Список.Обновить();
	КоличествоВыгружается = 0;
	ОбновитьЗаголовкиЗакладок();
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОчиститьСписокВыгрузки(Знач УникальныйИдентификатор, Знач Организация)
	
	НаименованиеЗадания = НСтр("ru = 'Работа с номенклатурой. Очистки списка выгрузки.'");
	ИмяМетода           = "Обработки.РаботаСНоменклатурой.ОчиститьСписокВыгрузки";
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеЗадания;
	
	Возврат ДлительныеОперации.ВыполнитьПроцедуру(ПараметрыВыполнения, ИмяМетода, Организация);
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьПоУсловию(Команда)
	
	ОткрытьФормуУсловия();
			
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьВыгружаемыеРеквизиты(Команда)
	ПараметрыОткрытия  = Новый Структура("Организация", Организация);
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриЗакрытииФормыВыгружаемыхРеквизитов", ЭтотОбъект);
	ОценкаПроизводительностиКлиент.ЗамерВремени("Обработка.РаботаСНоменклатурой.Форма.ВыгружаемыеРеквизиты.ОткрытиеФормы");
	ОткрытьФорму("Обработка.РаботаСНоменклатурой.Форма.ВыгружаемыеРеквизиты", ПараметрыОткрытия, ЭтаФорма, УникальныйИдентификатор,,, ОписаниеОповещения);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбновитьЗаголовкиЗакладок(ОбновитьВыгружается = Истина, ОбновитьИсключения = Истина)
	
	СтрокаДостигнутЛимит = СтрШаблон(НСтр("ru = 'более %1'"), ЛимитСтрока);
	
	Если ОбновитьВыгружается = Истина Тогда
		ВыгружаетсяПредставление = Строка(КоличествоВыгружается);
		Если КоличествоВыгружается >= ЛимитЧисло Тогда
			ВыгружаетсяПредставление = СтрокаДостигнутЛимит;
		ИначеЕсли КоличествоВыгружается = 0 Тогда
			ВыгружаетсяПредставление = НСтр("ru = 'не выбрана'");
		КонецЕсли;
		Элементы.СтраницаВыгружаются.Заголовок = СтрШаблон(НСтр("ru = 'К выгрузке (%1)'"), ВыгружаетсяПредставление);
	КонецЕсли;
	
	Если ОбновитьИсключения = Истина Тогда
		ИсключенияПредставление = Строка(КоличествоИсключения);
		Если КоличествоИсключения >= ЛимитЧисло Тогда
			ИсключенияПредставление = СтрокаДостигнутЛимит;
		ИначеЕсли КоличествоИсключения = 0 Тогда
			ИсключенияПредставление = НСтр("ru = 'нет'");
		КонецЕсли;
		Элементы.СтраницаИсключения.Заголовок = СтрШаблон(НСтр("ru = 'Исключения (%1)'"), ИсключенияПредставление);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПодбор(Регистрация = Истина)
	ОчиститьСообщения();
	ОписаниеОповещения = Новый ОписаниеОповещения("ЗакрытиеПодбора", ЭтотОбъект, Регистрация);
	
	Если ИспользоватьПодбор Тогда
		РаботаСНоменклатуройКлиентПереопределяемый.ОткрытьФормуПодбораНоменклатурыСХарактеристиками(ЭтотОбъект,
			ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		ОтборЭлементов     = Новый Структура("ЭтоГруппа", Ложь);
		ПараметрыОткрытия  = Новый Структура;
		ПараметрыОткрытия.Вставить("МножественныйВыбор", Регистрация);
		ПараметрыОткрытия.Вставить("ВыборГруппИЭлементов", ИспользованиеГруппИЭлементов.Элементы);
		ПараметрыОткрытия.Вставить("Отбор", ОтборЭлементов);
		РаботаСНоменклатуройКлиентПереопределяемый.ОткрытьФормуВыбораНоменклатуры(ПараметрыОткрытия, ЭтотОбъект,
			ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытиеПодбора(РезультатЗакрытия, ДополнительныеПараметры) Экспорт 
	
	Если ТипЗнч(РезультатЗакрытия) = Тип("Строка") Тогда
		ДобавитьКВыгрузкеНоменклатуруСХарактеристиками(РезультатЗакрытия, ДополнительныеПараметры);
	ИначеЕсли ТипЗнч(РезультатЗакрытия) = Тип("Структура") И РезультатЗакрытия.Свойство("АдресТоваровВХранилище") Тогда
		ДобавитьКВыгрузкеНоменклатуруСХарактеристиками(РезультатЗакрытия.АдресТоваровВХранилище, ДополнительныеПараметры);
	ИначеЕсли ТипЗнч(РезультатЗакрытия) = Тип("Массив") 
		Или ТипЗнч(РезультатЗакрытия) = ТипЗнч(ПустаяНоменклатура) Тогда
		ДобавитьКВыгрузкеНоменклатуру(РезультатЗакрытия, ДополнительныеПараметры);				
	Иначе
		Возврат
	КонецЕсли;
	
	Элементы.Список.Обновить();
	Элементы.СписокВыгрузкаЗапрещена.Обновить();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеДобавленияНоменклатурыКВыгрузке(Результат, ДополнительныеПараметры) Экспорт 
	
	Если Результат = Неопределено Тогда // Пользователь отменил задание.
		Возврат;
	КонецЕсли;

	Если Результат.Статус = "Ошибка" Тогда
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
	РезультатДобавления   = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
	КоличествоВыгружается = КоличествоВыгружается + РезультатДобавления.Добавлено;
	УдалитьИзВременногоХранилища(Результат.АдресРезультата);
	ОбновитьЗаголовкиЗакладок(, Ложь);
	ОчиститьСообщения();
	Для каждого ТекстСообщения Из РезультатДобавления.ТекстЛога Цикл
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДобавитьНовуюНоменклатуру(Знач УникальныйИдентификатор, Знач Организация, Знач МассивНоменклатуры)

	НаименованиеЗадания = НСтр("ru = 'Работа с номенклатурой. Добавление новой номенклатуры по списку.'");
	ИмяМетода           = "Обработки.РаботаСНоменклатурой.ДобавитьКВыгрузкеНоменклатуруПоСписку";
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеЗадания;
	
	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, ИмяМетода, Организация, МассивНоменклатуры);

КонецФункции

&НаСервереБезКонтекста
Функция ДобавитьИсключениеНоменклатуры(Организация, Номенклатура, ЛимитЗаписей)
	
	ИмяТаблицыНоменклатура = РаботаСНоменклатурой.ИмяТаблицыПоТипу(Метаданные.ОпределяемыеТипы.НоменклатураРаботаСНоменклатурой.Тип);
	ПустаяХарактеристика   = РаботаСНоменклатурой.ПустаяСсылкаНаХарактеристику();
	СписокСостояний        = РаботаСНоменклатуройСлужебный.СостоянияНоменклатурыДоВыгрузки();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("СписокСостояний", СписокСостояний);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСТИНА
	|ИЗ
	|	РегистрСведений.СостоянияВыгрузкиНоменклатуры КАК СостоянияВыгрузкиНоменклатуры
	|ГДЕ
	|	СостоянияВыгрузкиНоменклатуры.Организация = &Организация
	|	И СостоянияВыгрузкиНоменклатуры.Номенклатура = &Номенклатура
	|	И СостоянияВыгрузкиНоменклатуры.Состояние НЕ В (&СписокСостояний)";
	
	Если НЕ Запрос.Выполнить().Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	НаборЗаписей = РегистрыСведений.СостоянияВыгрузкиНоменклатуры.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Организация.Установить(Организация);
	НаборЗаписей.Отбор.Номенклатура.Установить(Номенклатура);
	Запись = НаборЗаписей.Добавить();
	Запись.Номенклатура = Номенклатура;
	Запись.Организация  = Организация;
	Запись.Состояние    = Перечисления.СостоянияВыгрузкиНоменклатуры.ВыгрузкаЗапрещена;;
	НаборЗаписей.Записать();
	
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1000
	|	СправочникНоменклатура.Ссылка КАК Номенклатура
	|ИЗ
	|	Справочник.Номенклатура КАК СправочникНоменклатура
	|ГДЕ
	|	ИСТИНА В
	|			(ВЫБРАТЬ ПЕРВЫЕ 1
	|				ИСТИНА
	|			ИЗ
	|				РегистрСведений.СостоянияВыгрузкиНоменклатуры КАК СостоянияВыгрузкиНоменклатуры
	|			ГДЕ
	|				СостоянияВыгрузкиНоменклатуры.Организация = &Организация
	|				И СостоянияВыгрузкиНоменклатуры.Номенклатура = СправочникНоменклатура.Ссылка
	|				И СостоянияВыгрузкиНоменклатуры.Состояние В (&СписокСостояний))
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1000
	|	СостоянияВыгрузкиНоменклатуры.Номенклатура КАК Номенклатура
	|ИЗ
	|	РегистрСведений.СостоянияВыгрузкиНоменклатуры КАК СостоянияВыгрузкиНоменклатуры
	|ГДЕ
	|	СостоянияВыгрузкиНоменклатуры.Организация = &Организация
	|	И СостоянияВыгрузкиНоменклатуры.ХарактеристикаНоменклатуры = &ПустаяХарактеристика
	|	И СостоянияВыгрузкиНоменклатуры.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияВыгрузкиНоменклатуры.ВыгрузкаЗапрещена)";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "1000", ЛимитЗаписей);
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "Справочник.Номенклатура", ИмяТаблицыНоменклатура);
	Запрос.УстановитьПараметр("ПустаяХарактеристика", ПустаяХарактеристика);
	Результат             = Запрос.ВыполнитьПакет();
	КоличествоВыгружается = Результат[0].Выбрать().Количество();
	КоличествоИсключения  = Результат[1].Выбрать().Количество();
	
	Возврат Новый Структура("КоличествоВыгружается, КоличествоИсключения", КоличествоВыгружается, КоличествоИсключения);
	
КонецФункции

&НаКлиенте
Процедура ОткрытьФормуУсловия(ОбновитьЗаписиРегистра = Истина)

	Оповещение        = Неопределено;
	ПараметрыОткрытия = РаботаСНоменклатуройКлиент.ПараметрыФормыУсловияОтбораНоменклатуры();
	ПараметрыОткрытия.НастройкиОтбора = НастройкиОтбора;
	Если ОбновитьЗаписиРегистра = Истина Тогда
		Оповещение = Новый ОписаниеОповещения("ОбновитьОтбор", ЭтотОбъект);
	КонецЕсли;
	РаботаСНоменклатуройКлиент.ОткрытьФормуУсловияОтбораНоменклатуры(ПараметрыОткрытия, ЭтотОбъект, Оповещение);

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОтбор(РезультатЗакрытия, ДополнительныеПараметры) Экспорт 
	Если РезультатЗакрытия <> Неопределено Тогда
		НастройкиОтбора = РезультатЗакрытия;
		Элементы.ДекорацияОтбор.Заголовок  = РаботаСНоменклатуройСлужебныйКлиент.ЗаголовокДекорацииУсловияОтбора(НастройкиОтбора);
		ОповещатьОНовых = Истина;
		Элементы.ДекорацияОтбор.Доступность = ОповещатьОНовых;
		
		ДлительнаяОперация = ЗаполнитьРегистрПоОтбору(УникальныйИдентификатор, Организация, НастройкиОтбора);
		Если ДлительнаяОперация.Статус = "Выполнено" Тогда
			ПослеДобавленияНоменклатурыКВыгрузке(ДлительнаяОперация, Неопределено);
			Возврат
		КонецЕсли;
		
		ОповещениеОЗавершении   = Новый ОписаниеОповещения("ПослеДобавленияНоменклатурыКВыгрузке", ЭтотОбъект);
		ПараметрыОжидания       = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтаФорма);
		ПараметрыОжидания.ТекстСообщения = НСтр("ru = 'Заполнение по отбору'");
		
		ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);
		
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаполнитьРегистрПоОтбору(Знач УникальныйИдентификатор, Знач Организация, Знач НастройкиОтбора)
	
	ОбновляемыеПараметры = Новый Структура("НастройкиОтбора, ОповещатьОНовых", НастройкиОтбора, Истина);
	РаботаСНоменклатуройСлужебный.ОбновитьПараметрыНастройкиВыгрузки(Организация, ОбновляемыеПараметры);
	
	НаименованиеЗадания = НСтр("ru = 'Работа с номенклатурой. Добавление новой номенклатуры по отбору.'");
	ИмяМетода           = "Обработки.РаботаСНоменклатурой.ДобавитьКВыгрузкеНоменклатуруПоОтбору";
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НаименованиеЗадания;
	
	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, ИмяМетода, Организация, НастройкиОтбора);
	
КонецФункции

&НаКлиенте
Процедура Готово(Команда)
	Закрыть(КоличествоВыгружается);
КонецПроцедуры

&НаСервере
Функция ТекущиеДелаВстроены()
	
	Результат = Ложь;
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ТекущиеДела") Тогда
		Возврат Результат;
	КонецЕсли;
	
	Попытка
		Обработчики = Новый Массив;
		ОбщийМодульТекущиеДелаПереопределяемый = ОбщегоНазначения.ОбщийМодуль("ТекущиеДелаПереопределяемый");
		ОбщийМодульТекущиеДелаПереопределяемый.ПриОпределенииОбработчиковТекущихДел(Обработчики);
		Результат = (Обработчики.Найти(Обработки.РаботаСНоменклатурой) <> Неопределено);
	Исключение
		ИмяСобытия     = НСтр("ru = 'Электронное взаимодействие.Работа с номенклатурой'", ОбщегоНазначения.КодОсновногоЯзыка());
		ТекстСообщения = НСтр("ru = 'Не удалось проверить встраивание уведомлений через подсистему СтандартныеПодсистемы.ТекущиеДела'");
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка,,, ТекстСообщения);
	КонецПопытки;
	
	Возврат Результат
	
КонецФункции

&НаКлиенте
Процедура УстановитьЗаголовокВыгружаемыеРеквизиты()
	
	Если Не ВыгружатьВсеРеквизиты() Тогда
		ТекстЗаголовка = НСтр("ru = 'выбранные'");
	Иначе 
		ТекстЗаголовка = НСтр("ru = 'все'");
	КонецЕсли;
	
	ТекстЗаголовка = СтрШаблон(НСтр("ru = 'Ограничить набор выгружаемых реквизитов (%1)'"), ТекстЗаголовка);
	Элементы.ВыбратьВыгружаемыеРеквизиты.Заголовок = ТекстЗаголовка;
	
КонецПроцедуры

&НаКлиенте
Функция ВыгружатьВсеРеквизиты()
	
	Результат = Истина;
	
	Если ТипЗнч(ВыгружаемыеРеквизиты) <> Тип("Структура") Тогда
		Возврат Результат;
	КонецЕсли;
	
	Если ВыгружаемыеРеквизиты.Свойство("Реквизиты") И ВыгружаемыеРеквизиты.Реквизиты.Количество() Тогда
		Результат = Ложь;
	ИначеЕсли ВыгружаемыеРеквизиты.Свойство("ДополнительныеРеквизиты")
		И ВыгружаемыеРеквизиты.ДополнительныеРеквизиты.Количество() Тогда
		Результат = Ложь;
	ИначеЕсли ВыгружаемыеРеквизиты.Свойство("ВыгружатьИндивидуальныеХарактеристики")
		И ВыгружаемыеРеквизиты.ВыгружатьИндивидуальныеХарактеристики Тогда
		Результат = Ложь;
	ИначеЕсли ВыгружаемыеРеквизиты.Свойство("ВидыНоменклатуры")
		И ВыгружаемыеРеквизиты.ВидыНоменклатуры.Количество() Тогда
		Результат = Ложь;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПриЗакрытииФормыВыгружаемыхРеквизитов(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если ЗначениеЗаполнено(РезультатЗакрытия) Тогда
		ДоИзменения = Новый Структура("ВыгружаемыеРеквизиты", ВыгружаемыеРеквизиты);
		Если Не РаботаСНоменклатуройСлужебныйКлиентСервер.ДанныеСовпадают(РезультатЗакрытия, ДоИзменения) Тогда
			ВыгружаемыеРеквизиты = РезультатЗакрытия.ВыгружаемыеРеквизиты;
			РаботаСНоменклатуройСлужебныйВызовСервера.ОбновитьПараметрыНастройкиВыгрузки(Организация, РезультатЗакрытия);
			УстановитьЗаголовокВыгружаемыеРеквизиты();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрыДинамическихСписков()

	ВедетсяУчетПоХарактеристикам = (РаботаСНоменклатурой.ВедетсяУчетПоХарактеристикам() = Истина);
	ПустаяХарактеристика         = ?(ВедетсяУчетПоХарактеристикам, РаботаСНоменклатурой.ПустаяСсылкаНаХарактеристику(),
		Неопределено);
	СписокСостояний              = РаботаСНоменклатуройСлужебный.СостоянияНоменклатурыДоВыгрузки();

	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "Организация", Организация);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "СписокСостояний", СписокСостояний);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "ВедетсяУчетПоХарактеристикам",
		ВедетсяУчетПоХарактеристикам);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(Список, "ПустаяХарактеристика",
		ПустаяХарактеристика);

	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(СписокВыгрузкаЗапрещена, "Организация",
		Организация);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(СписокВыгрузкаЗапрещена, "ПустаяХарактеристика",
		ПустаяХарактеристика);
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(СписокВыгрузкаЗапрещена, "ВедетсяУчетПоХарактеристикам",
		ВедетсяУчетПоХарактеристикам);

КонецПроцедуры
	
&НаСервере
Процедура ОбновитьСтатистику(ОбновитьВыгружается = Истина, ОбновитьИсключения = Истина)

	ЛимитЧисло      = РаботаСНоменклатуройСлужебныйКлиентСервер.РазмерПорции();
	ЛимитСтрока     = Формат(ЛимитЧисло, "ЧГ=");
	
	ТекстЗапроса = "";
	Если ОбновитьВыгружается Тогда
		ТекстЗапроса = Список.ТекстЗапроса;
	КонецЕсли;
	Если ОбновитьИсключения Тогда
		Если ОбновитьВыгружается Тогда
			ТекстЗапроса = ТекстЗапроса + ";";
		КонецЕсли;
		ТекстЗапроса = ТекстЗапроса + СписокВыгрузкаЗапрещена.ТекстЗапроса;
	КонецЕсли;
	
	СхемаЗапроса = Новый СхемаЗапроса;
	СхемаЗапроса.УстановитьТекстЗапроса(ТекстЗапроса);
	Для Каждого ЗапросПакета Из СхемаЗапроса.ПакетЗапросов Цикл
		ЗапросПакета.ВыбиратьРазрешенные = Истина;
		ЗапросПакета.Операторы[0].КоличествоПолучаемыхЗаписей = ЛимитЧисло;
	КонецЦикла;
	ТекстЗапроса = СхемаЗапроса.ПолучитьТекстЗапроса();

	Запрос = Новый Запрос(ТекстЗапроса);
	
	Для Каждого ПараметрСписка Из Список.Параметры.Элементы Цикл
		Запрос.УстановитьПараметр(ПараметрСписка.Параметр, ПараметрСписка.Значение);
	КонецЦикла;
	
	Результат = Запрос.ВыполнитьПакет();
	Если ОбновитьВыгружается Тогда
		КоличествоВыгружается = Результат[0].Выбрать().Количество();
	КонецЕсли;
	Если ОбновитьИсключения Тогда
		КоличествоИсключения = Результат[?(ОбновитьВыгружается,1,0)].Выбрать().Количество();		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступностьЭлементовФормы()

	ТекущиеДелаВстроены = ТекущиеДелаВстроены();
	Элементы.ГруппаОповещение.Видимость = ТекущиеДелаВстроены;
	Если Не ТекущиеДелаВстроены И ОповещатьОНовых Тогда
		ОповещатьОНовых      = Ложь;
		ОбновляемыеПараметры = Новый Структура("ОповещатьОНовых", ОповещатьОНовых);
		РаботаСНоменклатуройСлужебный.ОбновитьПараметрыНастройкиВыгрузки(Организация, ОбновляемыеПараметры);
	КонецЕсли;
	Элементы.ДекорацияОтбор.Доступность = ОповещатьОНовых;

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьКВыгрузкеНоменклатуру(ДобавляемаяНоменклатура, ДобавитьКВыгрузке)

	Если ДобавитьКВыгрузке = Истина Тогда

		ДлительнаяОперация = ДобавитьНовуюНоменклатуру(УникальныйИдентификатор, Организация, ДобавляемаяНоменклатура);
		Если ДлительнаяОперация.Статус = "Выполнено" Тогда
			ПослеДобавленияНоменклатурыКВыгрузке(ДлительнаяОперация, Неопределено);
			Возврат;
		КонецЕсли;

		ОповещениеОЗавершении = Новый ОписаниеОповещения("ПослеДобавленияНоменклатурыКВыгрузке", ЭтотОбъект);
		ПараметрыОжидания     = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтаФорма);
		ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;

		ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);
	Иначе
		РезультатДобавления = ДобавитьИсключениеНоменклатуры(Организация, ДобавляемаяНоменклатура, ЛимитСтрока);
		Если ТипЗнч(РезультатДобавления) = Тип("Структура") Тогда
			ЗаполнитьЗначенияСвойств(ЭтотОбъект, РезультатДобавления);
			ОбновитьЗаголовкиЗакладок();
		Иначе
			ТекстСообщения = НСтр(
				"ru = 'В исключения можно добавить только номенклатуру, которая ранее не выгружалась.'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаСервереБезКонтекста
Функция ДобавитьКВыгрузкеНоменклатуруСХарактеристикамиНаСервере(Знач Организация, Знач АдресТоваров, Знач ДобавитьКВыгрузке)

	Возврат Обработки.РаботаСНоменклатурой.ДобавитьКВыгрузкеНоменклатуруСХарактеристиками(Организация, АдресТоваров, ДобавитьКВыгрузке);

КонецФункции

&НаКлиенте
Процедура ДобавитьКВыгрузкеНоменклатуруСХарактеристиками(АдресТоваров, ДобавитьКВыгрузке)

	РезультатДобавления = ДобавитьКВыгрузкеНоменклатуруСХарактеристикамиНаСервере(Организация, АдресТоваров, ДобавитьКВыгрузке);
	
	Если ДобавитьКВыгрузке Тогда
		ШаблонДобавлено = НСтр("ru = 'Добавлено к выгрузке: %1'"); 
	Иначе
		ШаблонДобавлено = НСтр("ru = 'Добавлено в исключения: %1'"); 		 				
	КонецЕсли;
	ШаблонИсключено = НСтр("ru = 'Найдено в исключениях (не добавлено): %1'");
	ШаблонВыгружается = НСтр("ru = 'Уже выгружается (не добавлено): %1'");
	
	Если РезультатДобавления.Добавлено > 0 Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(СтрШаблон(ШаблонДобавлено, РезультатДобавления.Добавлено));
		Если ДобавитьКВыгрузке Тогда
			КоличествоВыгружается = КоличествоВыгружается + РезультатДобавления.Добавлено;
		Иначе
			КоличествоИсключения = КоличествоИсключения + РезультатДобавления.Добавлено;
			КоличествоВыгружается = КоличествоВыгружается - РезультатДобавления.Изменено;
		КонецЕсли;
		ОбновитьЗаголовкиЗакладок(, Не ДобавитьКВыгрузке);
	КонецЕсли;
	Если РезультатДобавления.Исключено > 0 Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(СтрШаблон(ШаблонИсключено, РезультатДобавления.Исключено));		
	КонецЕсли;
	Если РезультатДобавления.Выгружается > 0 Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(СтрШаблон(ШаблонВыгружается, РезультатДобавления.Выгружается));		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти