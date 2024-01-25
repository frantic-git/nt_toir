///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.БлокироватьВладельца Тогда
		РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		Объект.ИспользоватьДляОтправки = Истина;
		Объект.ИспользоватьДляПолучения = ДоступноПолучениеПисем;
		ЗаполнитьНастройки();
	КонецЕсли;
	
	Элементы.ИспользоватьУчетнуюЗапись.ОтображатьЗаголовок = ДоступноПолучениеПисем;
	Элементы.ДляПолучения.Видимость = ДоступноПолучениеПисем;
	
	Если Не ДоступноПолучениеПисем Тогда
		Элементы.ДляОтправки.Заголовок = НСтр("ru = 'Использовать для отправки писем'");
	КонецЕсли;
	
	Элементы.ГруппаДляКогоУчетнаяЗапись.Доступность = Пользователи.ЭтоПолноправныйПользователь();
	
	РеквизитыТребующиеВводаПароляДляИзменения = Справочники.УчетныеЗаписиЭлектроннойПочты.РеквизитыТребующиеВводаПароляДляИзменения();
	
	// ТОИР++
	ДобавитьЭлементыФормыТОИР();
	// ТОИР--

	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКоманды = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКоманды");
		МодульПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	КонецЕсли;
	
	ЦветПодсветки = ЦветаСтиля.ПоясняющийОшибкуТекст;
	ИдентификаторИсправления = Параметры.ИдентификаторИсправления;
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.СпособАутентификацииПочтовыйСервис.Видимость = Ложь;
		
		Элементы.СпособАутентификацииПароль.СписокВыбора.Очистить();
		Элементы.СпособАутентификацииПароль.СписокВыбора.Добавить("OAuth", НСтр("ru = 'Авторизация на почтовом сервисе'"));
		Элементы.СпособАутентификацииПароль.СписокВыбора.Добавить("Пароль", НСтр("ru = 'Использовать пароль'"));
		
		Элементы.Пароль.РастягиватьПоГоризонтали = Истина;
		Элементы.Пароль.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Авто;
		
		Элементы.Пароль.Видимость = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ПарольИзменен Тогда
		УстановитьПривилегированныйРежим(Истина);
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, Пароль);
		ОбщегоНазначения.ЗаписатьДанныеВБезопасноеХранилище(ТекущийОбъект.Ссылка, Пароль, "ПарольSMTP");
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
	РаботаСПочтовымиСообщениямиСлужебный.ОбновитьНастройкиСервераВосстановленияПочты(ТекущийОбъект.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Если ВидУчетнойЗаписи = "Персональная" И Не ЗначениеЗаполнено(Объект.ВладелецУчетнойЗаписи) Тогда 
		Отказ = Истина;
		ТекстСообщения = НСтр("ru = 'Не выбран владелец учетной записи.'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения, , "Объект.ВладелецУчетнойЗаписи");
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.ПользовательSMTP = ?(ТекущийОбъект.ПриОтправкеПисемТребуетсяАвторизация И Не Объект.ТребуетсяВходНаСерверПередОтправкой, ТекущийОбъект.Пользователь, "");
	ТекущийОбъект.ТребуетсяВходНаСерверПередОтправкой = ТекущийОбъект.ТребуетсяВходНаСерверПередОтправкой И ТекущийОбъект.ПриОтправкеПисемТребуетсяАвторизация;
	ТекущийОбъект.ДополнительныеСвойства.Вставить("Пароль", ПроверкаПароля);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	ОписаниеОповещения = Новый ОписаниеОповещения("ПередЗакрытиемПодтверждениеПолучено", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(ОписаниеОповещения, Отказ, ЗавершениеРаботы);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ЗаполнитьРеквизитыОбъекта();
	
	ОбработчикиПередЗаписью = Новый Массив;
	ОбработчикиПередЗаписью.Добавить(Новый ОписаниеОповещения("ПроверитьЗаполнениеПередЗаписью", ЭтотОбъект, ПараметрыЗаписи));
	ОбработчикиПередЗаписью.Добавить(Новый ОписаниеОповещения("ПроверитьРазрешенияПередЗаписью", ЭтотОбъект, ПараметрыЗаписи));
	ОбработчикиПередЗаписью.Добавить(Новый ОписаниеОповещения("ПроверитьПарольПередЗаписью", ЭтотОбъект, ПараметрыЗаписи));
	
	ПодключитьОбработчикиПередЗаписью(ОбработчикиПередЗаписью, ЭтотОбъект, Отказ, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_УчетнаяЗаписьЭлектроннойПочты",,Объект.Ссылка);
	
	Если ПараметрыЗаписи.Свойство("ЗаписатьИЗакрыть") Тогда
		Закрыть();
	КонецЕсли;
	
	Если ПараметрыЗаписи.Свойство("ПроверитьНастройки") Тогда
		ПодключитьОбработчикОжидания("ВыполнитьПроверкуНастроек", 0.1, Истина);
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьВидНастройкиХраненияПисемНаСервере();
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	КонецЕсли;

	Если ЗначениеЗаполнено(ИдентификаторИсправления) Тогда
		ПоказатьСпособИсправления(ИдентификаторИсправления);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ЗаполнитьНастройки();
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиентСервер = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКомандыКлиентСервер");
		МодульПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСпособИсправления(СпособИсправления, ДополнительныеПараметры = Неопределено) Экспорт

	Если СпособИсправления = "ВключитьИспользованиеАвторизацииSMTP" Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Включите авторизацию на сервере исходящей почты.'"),
			Объект.Ссылка, , "Объект.ПриОтправкеПисемТребуетсяАвторизация");
	ИначеЕсли СпособИсправления = "Перенастроить" Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Для перенастройки почты нажмите на кнопку ""Перенастроить"".'"),
			Объект.Ссылка);
	ИначеЕсли СпособИсправления = "ИспользоватьSTARTTLSДляВходящейПочты" Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Переключите шифрование на STARTTLS (для входящей почты).'"),
			Объект.Ссылка, "ШифрованиеПриПолученииПочты");
	ИначеЕсли СпособИсправления = "ПерезаполнитьЛогинИПароль" Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Попробуйте очистить и ввести заново логин.'"),
			Объект.Ссылка, , "Объект.Пользователь");
	ИначеЕсли СпособИсправления = "ПерезаполнитьПароль" Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Введите пароль.'"),
			Объект.Ссылка, "Пароль");
	ИначеЕсли СпособИсправления = "ЗаполнитьАдресПочты" Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Проверьте адрес почты.'"),
			Объект.Ссылка, "Объект.АдресЭлектроннойПочты");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПротоколПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.ПротоколВходящейПочты) Тогда
		Объект.ПротоколВходящейПочты = "IMAP";
	КонецЕсли;
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Если СтрНачинаетсяС(Объект.СерверВходящейПочты, "pop.") Тогда
			Объект.СерверВходящейПочты = "imap." + Сред(Объект.СерверВходящейПочты, 5);
		КонецЕсли
	Иначе
		Если СтрНачинаетсяС(Объект.СерверВходящейПочты, "imap.") Тогда
			Объект.СерверВходящейПочты = "pop." + Сред(Объект.СерверВходящейПочты, 6);
		КонецЕсли;
	КонецЕсли;
	
	Элементы.СерверВходящейПочты.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Сервер %1'"), Объект.ПротоколВходящейПочты);
		
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	Элементы.ОставлятьПисьмаНаСервере.Видимость = ИспользуетсяПротоколPOP И ДоступноПолучениеПисем;
	
	УстановитьВидГруппыТребуетсяАвторизация(ЭтотОбъект, ИспользуетсяПротоколPOP);
	
	УстановитьПортВходящейПочты();
	УстановитьВидНастройкиХраненияПисемНаСервере();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидГруппыТребуетсяАвторизация(Форма, ИспользуетсяПротоколPOP)
	
	Если ИспользуетсяПротоколPOP Тогда
		Форма.Элементы.ТребуетсяАвторизацияПриОтправкеПисем.Заголовок = НСтр("ru = 'При отправке писем требуется авторизация'");
	Иначе
		Форма.Элементы.ТребуетсяАвторизацияПриОтправкеПисем.Заголовок = НСтр("ru = 'При отправке писем требуется авторизация на сервере исходящей почты (SMTP)'");
	КонецЕсли;

	Форма.Элементы.АвторизацияПриОтправкеПисем.Видимость = ИспользуетсяПротоколPOP;
	
КонецПроцедуры

&НаКлиенте
Процедура СерверВходящейПочтыПриИзменении(Элемент)
	Объект.СерверВходящейПочты = СокрЛП(НРег(Объект.СерверВходящейПочты));
КонецПроцедуры

&НаКлиенте
Процедура СерверИсходящейПочтыПриИзменении(Элемент)
	Объект.СерверИсходящейПочты = СокрЛП(НРег(Объект.СерверИсходящейПочты));
КонецПроцедуры

&НаКлиенте
Процедура АдресЭлектроннойПочтыПриИзменении(Элемент)
	Объект.АдресЭлектроннойПочты = СокрЛП(Объект.АдресЭлектроннойПочты);
КонецПроцедуры

&НаКлиенте
Процедура ОставлятьКопииПисемНаСервереПриИзменении(Элемент)
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура УдалятьПисьмаССервераПриИзменении(Элемент)
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПарольПриИзменении(Элемент)
	ПарольИзменен = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольИзменениеТекстаРедактирования(Элемент, Текст, СтандартнаяОбработка)
	Элементы.Пароль.КнопкаВыбора = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПарольНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	РаботаСПочтовымиСообщениямиКлиент.ПолеПароляНачалоВыбора(Элемент, Пароль, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ДляКогоУчетнаяЗаписьПриИзменении(Элемент)
	Элементы.ПользовательУчетнойЗаписи.Доступность = ВидУчетнойЗаписи = "Персональная";
	ОповеститьОбИзмененииВладельцаУчетнойЗаписи();
КонецПроцедуры

&НаКлиенте
Процедура ПользовательУчетнойЗаписиПриИзменении(Элемент)
	ОповеститьОбИзмененииВладельцаУчетнойЗаписи();
КонецПроцедуры

&НаКлиенте
Процедура ТребуетсяАвторизацияПриОтправкеПисемПриИзменении(Элемент)
	Элементы.АвторизацияПриОтправкеПисем.Доступность = Объект.ПриОтправкеПисемТребуетсяАвторизация;
	Элементы.АвторизацияПриОтправкеПисем.Видимость = Объект.ПротоколВходящейПочты = "POP";
КонецПроцедуры

&НаКлиенте
Процедура ШифрованиеПриОтправкеПочтыПриИзменении(Элемент)
	Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты = ШифрованиеПриОтправкеПочты = "SSL";
	УстановитьПортИсходящейПочты();
КонецПроцедуры

&НаКлиенте
Процедура ШифрованиеПриПолученииПочтыПриИзменении(Элемент)
	Объект.ИспользоватьЗащищенноеСоединениеДляВходящейПочты = ШифрованиеПриПолученииПочты = "SSL";
	УстановитьПортВходящейПочты();
КонецПроцедуры

&НаКлиенте
Процедура СпособАвторизацииПриОтправкеПочтыПриИзменении(Элемент)
	Объект.ТребуетсяВходНаСерверПередОтправкой = ?(СпособАвторизацииПриОтправкеПочты = "POP", Истина, Ложь);
	УстановитьВидНастройкиХраненияПисемНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура НужнаПомощьНажатие(Элемент)
	
	РаботаСПочтовымиСообщениямиКлиент.ПерейтиКДокументацииПоВводуУчетнойЗаписиЭлектроннойПочты();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеПриИзменении(Элемент)
	Элементы.ФормаПроверитьНастройки.Доступность = Объект.ИспользоватьДляОтправки Или Объект.ИспользоватьДляПолучения;
КонецПроцедуры

&НаКлиенте
Процедура СпособАутентификацииПриИзменении(Элемент)
	
	Объект.АвторизацияСПомощьюПочтовогоСервиса = СпособАутентификации = "OAuth";
	
#Если МобильныйКлиент Тогда
	Элементы.Пароль.Видимость = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
#Иначе
	Элементы.Пароль.Доступность = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
#КонецЕсли

	Если Объект.АвторизацияСПомощьюПочтовогоСервиса Тогда
		ОткрытьФормуПомощникаНастроек(Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиентСервер = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиентСервер");
		МодульПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКоманды = ОбщегоНазначения.ОбщийМодуль("ПодключаемыеКоманды");
		МодульПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПодключаемыеКоманды") Тогда
		МодульПодключаемыеКомандыКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ПодключаемыеКомандыКлиент");
		МодульПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	Записать(Новый Структура("ЗаписатьИЗакрыть"));
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьНастройки(Команда)
	ВыполнитьПроверкуНастроек();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПомощникНастройки(Команда)
	
	ОткрытьФормуПомощникаНастроек();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьВидНастройкиХраненияПисемНаСервере()
	
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	Элементы.ОставлятьПисьмаНаСервере.Видимость = ИспользуетсяПротоколPOP И ДоступноПолучениеПисем;
	Элементы.НастройкаПериодаХраненияПисем.Доступность = Объект.ОставлятьКопииСообщенийНаСервере;
	Элементы.ПериодХраненияСообщенийНаСервере.Доступность = УдалятьПисьмаССервера;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПортВходящейПочты()
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Если Объект.ПортСервераВходящейПочты = 995 Тогда
			Объект.ПортСервераВходящейПочты = 993;
		КонецЕсли;
	Иначе
		Если Объект.ПортСервераВходящейПочты = 993 Тогда
			Объект.ПортСервераВходящейПочты = 995;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПортИсходящейПочты()
	Если Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты Тогда
		Если Объект.ПортСервераИсходящейПочты = 587 Тогда
			Объект.ПортСервераИсходящейПочты = 465;
		КонецЕсли;
	Иначе
		Если Объект.ПортСервераИсходящейПочты = 465 Тогда
			Объект.ПортСервераИсходящейПочты = 587;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытиемПодтверждениеПолучено(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Записать(Новый Структура("ЗаписатьИЗакрыть"));
КонецПроцедуры

&НаКлиенте
Процедура ОповеститьОбИзмененииВладельцаУчетнойЗаписи()
	Оповестить("ПриИзмененииВидаУчетнойЗаписиЭлектроннойПочты", ВидУчетнойЗаписи = "Персональная", ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРеквизитыОбъекта()
	
	Если Не УдалятьПисьмаССервера Тогда
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;
	
	Если Объект.ПротоколВходящейПочты = "IMAP" Тогда
		Объект.ОставлятьКопииСообщенийНаСервере = Истина;
		Объект.ПериодХраненияСообщенийНаСервере = 0;
	КонецЕсли;
	
	Если ВидУчетнойЗаписи = "Общая" И ЗначениеЗаполнено(Объект.ВладелецУчетнойЗаписи) Тогда
		Объект.ВладелецУчетнойЗаписи = Неопределено;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПроверитьЗаполнениеПередЗаписью(Отказ, ПараметрыЗаписи) Экспорт
	
	Если Не ПроверитьЗаполнение() Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьРазрешенияПередЗаписью(Отказ, ПараметрыЗаписи) Экспорт
	
	Отказ = Истина;
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеПроверкиРазрешений", ЭтотОбъект, ПараметрыЗаписи);
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежимеКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("РаботаВБезопасномРежимеКлиент");
		МодульРаботаВБезопасномРежимеКлиент.ПрименитьЗапросыНаИспользованиеВнешнихРесурсов(
			ЗапросыНаИспользованиеВнешнихРесурсов(), ЭтотОбъект, ОписаниеОповещения);
	Иначе
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, КодВозвратаДиалога.ОК);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьПарольПередЗаписью(Отказ, ПараметрыЗаписи) Экспорт
	
	Если Не ПроверкаПароляВыполнена(ПараметрыЗаписи) Тогда
		Отказ = Истина;
		ПроверкаПароля = "";
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВводаПароля", ЭтотОбъект, ПараметрыЗаписи);
		ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПроверкаДоступаКУчетнойЗаписи", , ЭтотОбъект, , , , ОписаниеОповещения);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗапросыНаИспользованиеВнешнихРесурсов()
	
	Запрос = Неопределено;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПрофилиБезопасности") Тогда
		МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
		Запрос = МодульРаботаВБезопасномРежиме.ЗапросНаИспользованиеВнешнихРесурсов(Разрешения(), Объект.Ссылка);
	КонецЕсли;
	
	Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Запрос);
	
КонецФункции

&НаСервере
Функция Разрешения()
	
	Результат = Новый Массив;
	
	МодульРаботаВБезопасномРежиме = ОбщегоНазначения.ОбщийМодуль("РаботаВБезопасномРежиме");
	
	Если Объект.ИспользоватьДляОтправки Тогда
		Результат.Добавить(
			МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
				"SMTP",
				Объект.СерверИсходящейПочты,
				Объект.ПортСервераИсходящейПочты,
				НСтр("ru = 'Электронная почта.'")));
	КонецЕсли;
	
	Если Объект.ИспользоватьДляПолучения Тогда
		Результат.Добавить(
			МодульРаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
				Объект.ПротоколВходящейПочты,
				Объект.СерверВходящейПочты,
				Объект.ПортСервераВходящейПочты,
				НСтр("ru = 'Электронная почта.'")));
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ПослеПроверкиРазрешений(Результат, ПараметрыЗаписи) Экспорт
	
	Если Результат = КодВозвратаДиалога.ОК Тогда
		ПараметрыЗаписи.Вставить("РазрешенияПолучены");
		Записать(ПараметрыЗаписи);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПроверкаПароляВыполнена(ПараметрыЗаписи)
	
	Если Не ПараметрыЗаписи.Свойство("ПарольВведен") Тогда
		ЗначенияРеквизитовПередЗаписью = Новый Структура(РеквизитыТребующиеВводаПароляДляИзменения);
		ЗаполнитьЗначенияСвойств(ЗначенияРеквизитовПередЗаписью, Объект);
		Возврат Не ТребуетсяПроверкаПароля(Объект.Ссылка, ЗначенияРеквизитовПередЗаписью);
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция ТребуетсяПроверкаПароля(Ссылка, ЗначенияРеквизитов)
	Возврат Справочники.УчетныеЗаписиЭлектроннойПочты.ТребуетсяПроверкаПароля(Ссылка, ЗначенияРеквизитов);
КонецФункции

&НаКлиенте
Процедура ПослеВводаПароля(Пароль, ПараметрыЗаписи) Экспорт
	
	Если ТипЗнч(Пароль) = Тип("Строка") Тогда
		ПроверкаПароля = Пароль;
		ПараметрыЗаписи.Вставить("ПарольВведен");
		Записать(ПараметрыЗаписи);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПроверкуНастроек()
	Если Модифицированность Тогда
		Записать(Новый Структура("ПроверитьНастройки"));
	Иначе
		ОписаниеОповещения = Новый ОписаниеОповещения("ПоказатьСпособИсправления", ЭтотОбъект);
		ПараметрыОткрытия = Новый Структура("УчетнаяЗапись", Объект.Ссылка);
		ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПроверкаНастроекУчетнойЗаписи",
			ПараметрыОткрытия, ЭтотОбъект, , , , ОписаниеОповещения);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриЗавершенииНастройки(Результат, ТолькоАвторизация) Экспорт
		
	Если ТолькоАвторизация Тогда
		Если Результат <> Истина Тогда
			Объект.АвторизацияСПомощьюПочтовогоСервиса = Ложь;
			СпособАутентификации = "Пароль";
#Если МобильныйКлиент Тогда
			Элементы.Пароль.Видимость = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
#Иначе
			Элементы.Пароль.Доступность = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
#КонецЕсли
			ТекстПредупреждения = НСтр("ru = 'Не удалось авторизоваться на почтовом сервисе.'");
			Если ТипЗнч(Результат) = Тип("Строка") Тогда
				ТекстПредупреждения = ТекстПредупреждения + Символы.ПС + Результат;
			КонецЕсли;
			ПоказатьПредупреждение(Неопределено, ТекстПредупреждения);
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	Прочитать();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройки()
	
	ДоступноПолучениеПисем = РаботаСПочтовымиСообщениямиСлужебный.НастройкиПодсистемы().ДоступноПолучениеПисем;
	Элементы.ОставлятьПисьмаНаСервере.Видимость = Объект.ПротоколВходящейПочты = "POP" И ДоступноПолучениеПисем;
	
	Элементы.СерверВходящейПочты.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
	НСтр("ru = 'Сервер %1'"), Объект.ПротоколВходящейПочты);
	
	УдалятьПисьмаССервера = Объект.ПериодХраненияСообщенийНаСервере > 0;
	Если Не УдалятьПисьмаССервера Тогда
		Объект.ПериодХраненияСообщенийНаСервере = 10;
	КонецЕсли;
	
	Если НЕ Объект.Ссылка.Пустая() Тогда
		УстановитьПривилегированныйРежим(Истина);
		ПарольУстановлен = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(Объект.Ссылка) <> "";
		УстановитьПривилегированныйРежим(Ложь);
		Пароль = ?(ПарольУстановлен, ЭтотОбъект.УникальныйИдентификатор, "");
		ПарольИзменен = Ложь;
		РаботаСПочтовымиСообщениямиСлужебный.ОформитьПолеПароля(Элементы.Пароль);
		
		Если Не Справочники.УчетныеЗаписиЭлектроннойПочты.ИзменениеРазрешено(Объект.Ссылка) Тогда
			ТолькоПросмотр = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Элементы.ФормаЗаписатьИЗакрыть.Доступность = Не ТолькоПросмотр;
	
	ЭтоПерсональнаяУчетнаяЗапись = ЗначениеЗаполнено(Объект.ВладелецУчетнойЗаписи);
	Элементы.ПользовательУчетнойЗаписи.Доступность = ЭтоПерсональнаяУчетнаяЗапись;
	ВидУчетнойЗаписи = ?(ЭтоПерсональнаяУчетнаяЗапись, "Персональная", "Общая");
	
	ИспользуетсяПротоколPOP = Объект.ПротоколВходящейПочты = "POP";
	Элементы.АвторизацияПриОтправкеПисем.Доступность = Объект.ПриОтправкеПисемТребуетсяАвторизация;
	УстановитьВидГруппыТребуетсяАвторизация(ЭтотОбъект, ИспользуетсяПротоколPOP);
	
	ШифрованиеПриОтправкеПочты = ?(Объект.ИспользоватьЗащищенноеСоединениеДляИсходящейПочты, "SSL", "Авто");
	ШифрованиеПриПолученииПочты = ?(Объект.ИспользоватьЗащищенноеСоединениеДляВходящейПочты, "SSL", "Авто");
	
	СпособАвторизацииПриОтправкеПочты = ?(Объект.ТребуетсяВходНаСерверПередОтправкой, "POP", "SMTP");
	Элементы.ФормаПроверитьНастройки.Доступность = Объект.ИспользоватьДляОтправки Или Объект.ИспользоватьДляПолучения;
	Элементы.ФормаОткрытьПомощникНастройки.Доступность = Не Объект.Ссылка.Пустая() И Не ТолькоПросмотр;
	
	Если Объект.АвторизацияСПомощьюПочтовогоСервиса Тогда
		СпособАутентификации = "OAuth";
	Иначе
		СпособАутентификации = "Пароль";
	КонецЕсли;
	
	Если ОбщегоНазначения.ЭтоМобильныйКлиент() Тогда
		Элементы.Пароль.Видимость = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
	Иначе
		Элементы.Пароль.Доступность = Не Объект.АвторизацияСПомощьюПочтовогоСервиса;
	КонецЕсли;
	
КонецПроцедуры

// Последовательно вызывает указанные обработчики в событии ПередЗаписью через обработчик ожидания.
&НаКлиенте
Процедура ПодключитьОбработчикиПередЗаписью(Обработчики, Форма, Отказ, ПараметрыЗаписи)
	
	Если Не ПараметрыЗаписи.Свойство("ОбработчикиПередЗаписью") Тогда
		ПараметрыЗаписи.Вставить("ОбработчикиПередЗаписью", Новый Структура)
	КонецЕсли;
	
	Для Каждого Обработчик Из Обработчики Цикл
		Если Не ПараметрыЗаписи.ОбработчикиПередЗаписью.Свойство(Обработчик.ИмяПроцедуры) Тогда
			ПараметрыЗаписи.ОбработчикиПередЗаписью.Вставить(Обработчик.ИмяПроцедуры, Ложь);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Проверка Из ПараметрыЗаписи.ОбработчикиПередЗаписью Цикл
		Если Проверка.Значение = Ложь Тогда
			Отказ = Истина;
			ОписаниеОповещения = Новый ОписаниеОповещения(Проверка.Ключ, Форма, ПараметрыЗаписи);
			
			ИмяПараметра = "СтандартныеПодсистемы.ОбработчикОжиданияПередЗаписьюВФорме";
			Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
				ПараметрыПриложения.Вставить(ИмяПараметра, Новый Массив);
			КонецЕсли;
			ОбработчикОжиданияПередЗаписьюВФорме = ПараметрыПриложения[ИмяПараметра]; // Массив
			ОбработчикОжиданияПередЗаписьюВФорме.Добавить(ОписаниеОповещения);
			
			ПодключитьОбработчикОжидания("ВыполнитьПроверкуПередЗаписьюВФорме", 0.1, Истина);
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// ТОИР++
&НаСервере
Процедура ДобавитьЭлементыФормыТОИР()
	
	НовыйЭлемент = Элементы.Добавить("торо_МаксимальноеКоличествоОтправляемых", Тип("ПолеФормы"), Элементы.ОтправкаПисем); 
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.торо_МаксимальноеКоличествоОтправляемых";
	
КонецПроцедуры // ТОИР--

&НаКлиенте
Процедура ВыполнитьПроверкуПередЗаписьюВФорме()
	
	ИмяПараметра = "СтандартныеПодсистемы.ОбработчикОжиданияПередЗаписьюВФорме";
	Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
		ПараметрыПриложения.Вставить(ИмяПараметра, Новый Массив);
	КонецЕсли;
	ОбработчикиОжидания = ПараметрыПриложения[ИмяПараметра];
	
	Если ОбработчикиОжидания.Количество() > 0 Тогда
		ОписаниеОповещения = ОбработчикиОжидания[0];
		ИмяПроцедуры = ОбработчикиОжидания[0].ИмяПроцедуры;
		Форма = ОбработчикиОжидания[0].Модуль; // РасширениеУправляемойФормыДляСправочника
		ПараметрыЗаписи = ОбработчикиОжидания[0].ДополнительныеПараметры;
		ОбработчикиОжидания.Удалить(0);
		ПараметрыЗаписи.ОбработчикиПередЗаписью[ИмяПроцедуры] = Истина;
		Отказ = Ложь;
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, Отказ);
		Если Не Отказ Тогда
			Форма.Записать(ПараметрыЗаписи);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФормуПомощникаНастроек(ТолькоАвторизация = Ложь)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПриЗавершенииНастройки", ЭтотОбъект, ТолькоАвторизация);
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("Ключ", Объект.Ссылка);
	Если ТолькоАвторизация Тогда
		ПараметрыОткрытия.Вставить("ТолькоАвторизация", Истина);
	Иначе
		ПараметрыОткрытия.Вставить("Перенастройка", Истина);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПомощникНастройкиУчетнойЗаписи", 
		ПараметрыОткрытия, , , , , ОписаниеОповещения);
		
КонецПроцедуры
#КонецОбласти
