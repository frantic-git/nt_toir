#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Документ = Параметры.Документ;
	ДокументID = Параметры.ДокументID;
	ДокументТип = Параметры.ДокументТип;
	
	ВидДокумента = Параметры.ВидДокумента;
	ВидДокументаID = Параметры.ВидДокументаID;
	ВидДокументаТип = Параметры.ВидДокументаТип;
	
	ВопросДеятельности = Параметры.ВопросДеятельности;
	ВопросДеятельностиID = Параметры.ВопросДеятельностиID;
	ВопросДеятельностиТип = Параметры.ВопросДеятельностиТип;
	
	Контрагент = Параметры.Контрагент;
	КонтрагентID = Параметры.КонтрагентID;
	КонтрагентТип = Параметры.КонтрагентТип;
	
	Организация = Параметры.Организация;
	ОрганизацияID = Параметры.ОрганизацияID;
	ОрганизацияТип = Параметры.ОрганизацияТип;
	
	Подразделение = Параметры.Подразделение;
	ПодразделениеID = Параметры.ПодразделениеID;
	ПодразделениеТип = Параметры.ПодразделениеТип;
	
	НоменклатураДел = Параметры.НоменклатураДел;
	НоменклатураДелID = Параметры.НоменклатураДелID;
	НоменклатураДелТип = Параметры.НоменклатураДелТип;
	НоменклатураДелГод = Параметры.НоменклатураДелГод;
	
	Если НоменклатураДелГод = 0 Тогда
		НоменклатураДелГод = Год(ТекущаяДатаСеанса());
	КонецЕсли;
	
	ОбновитьДанные();
	
	Элементы.Список.ОтборСтрок = Новый ФиксированнаяСтруктура(
		Новый Структура("РазделID, РазделТип", "БезРаздела", "БезРаздела"));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьДелаЗаПриИзменении(Элемент)
	
	ОбновитьДанные();
	
	Для Каждого Строка Из Разделы.ПолучитьЭлементы() Цикл
		Элементы.Разделы.Развернуть(Строка.ПолучитьИдентификатор());
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРазделы

&НаКлиенте
Процедура РазделыПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ОбработкаОжидания", 0.2, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	Строка = Элемент.ТекущиеДанные;
	Если Строка = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяНоменклатураДел = Строка.Представление;
	ТекущаяНоменклатураДелID = Строка.ID;
	ТекущаяНоменклатураДелТип = Строка.Тип;
	ТекущаяНоменклатураДелГод = Строка.Год;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Выбрать();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаВыбрать(Команда)
	
	Выбрать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработкаОжидания()
	
	Строка = Элементы.Разделы.ТекущиеДанные;
	Если Строка = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("РазделID", ?(ЗначениеЗаполнено(Строка.ID), Строка.ID, "БезРаздела"));
	СтруктураПоиска.Вставить("РазделТип", ?(ЗначениеЗаполнено(Строка.Тип), Строка.Тип, "БезРаздела"));
	Элементы.Список.ОтборСтрок = Новый ФиксированнаяСтруктура(СтруктураПоиска);
	
КонецПроцедуры

&НаКлиенте
Процедура Выбрать()
	
	ОчиститьСообщения();
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("НоменклатураДел", ТекущаяНоменклатураДел);
	Результат.Вставить("НоменклатураДелID", ТекущаяНоменклатураДелID);
	Результат.Вставить("НоменклатураДелТип", ТекущаяНоменклатураДелТип);
	Результат.Вставить("НоменклатураДелГод", ТекущаяНоменклатураДелГод);
	
	Закрыть(Результат);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьДанные()
	
	Прокси = ИнтеграцияС1СДокументооборотБазоваяФункциональностьПовтИсп.ПолучитьПрокси();
	ПрочитатьДеревоРазделовВФорму(Прокси);
	ПрочитатьСписокНоменклатурыДелВФорму(Прокси);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьДеревоРазделовВФорму(Прокси)
	
	Запрос = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMGetCaseFilesListSectionsTreeRequest");
	Запрос.year = НоменклатураДелГод;
	Запрос.company = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMOrganization");
	Запрос.company.name = Организация;
	Запрос.company.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		ОрганизацияID,
		ОрганизацияТип);
	Запрос.department = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMSubdivision");
	Запрос.department.name = Подразделение;
	Запрос.department.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		ПодразделениеID,
		ПодразделениеТип);
	РезультатДеревоРазделов = ИнтеграцияС1СДокументооборотБазоваяФункциональность.ВыполнитьЗапрос(Прокси, Запрос);
	ИнтеграцияС1СДокументооборотБазоваяФункциональность.ПроверитьВозвратВебСервиса(Прокси, РезультатДеревоРазделов);
	
	ДеревоРазделов = РеквизитФормыВЗначение("Разделы");
	ДеревоРазделов.Строки.Очистить();
	
	Корень = ДеревоРазделов.Строки.Добавить();
	Корень.Наименование = НСтр("ru = 'Разделы'");
	Корень.ИндексКартинки = -1;
	
	ЗаполнитьДеревоРазделов(Корень, РезультатДеревоРазделов.caseFilesListSectionsTree);
	
	ЗначениеВРеквизитФормы(ДеревоРазделов, "Разделы");
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьСписокНоменклатурыДелВФорму(Прокси)
	
	Запрос = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMGetCaseFilesCatalogRequest");
	
	Запрос.year = НоменклатураДелГод;
	
	Запрос.company = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMOrganization");
	Запрос.company.name = Организация;
	Запрос.company.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		ОрганизацияID,
		ОрганизацияТип);
	
	Запрос.department = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMSubdivision");
	Запрос.department.name = Подразделение;
	Запрос.department.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		ПодразделениеID,
		ПодразделениеТип);
	
	Запрос.documentType = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMObject");
	Запрос.documentType.name = ВидДокумента;
	Запрос.documentType.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		ВидДокументаID,
		ВидДокументаТип);
	
	Запрос.correspondent = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMCorrespondent");
	Запрос.correspondent.name = Контрагент;
	Запрос.correspondent.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		КонтрагентID,
		КонтрагентТип);
	
	Запрос.activityMatter = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьОбъект(Прокси, "DMActivityMatter");
	Запрос.activityMatter.name = ВопросДеятельности;
	Запрос.activityMatter.objectID = ИнтеграцияС1СДокументооборотБазоваяФункциональность.СоздатьObjectID(
		Прокси,
		ВопросДеятельностиID,
		ВопросДеятельностиТип);
	
	РезультатСписокНоменклатурыДел = ИнтеграцияС1СДокументооборотБазоваяФункциональность.ВыполнитьЗапрос(Прокси, Запрос);
	ИнтеграцияС1СДокументооборотБазоваяФункциональность.ПроверитьВозвратВебСервиса(Прокси, РезультатСписокНоменклатурыДел);
	
	Таблица = РеквизитФормыВЗначение("Список");
	
	Таблица.Очистить();
	Для Каждого caseFilesCatalog Из РезультатСписокНоменклатурыДел.caseFilesCatalogs Цикл
		НовСтр = Таблица.Добавить();
		НовСтр.Наименование = caseFilesCatalog.name;
		НовСтр.Представление = caseFilesCatalog.objectID.presentation;
		НовСтр.Индекс = caseFilesCatalog.index;
		НовСтр.Год = caseFilesCatalog.year;
		НовСтр.ID = caseFilesCatalog.objectID.ID;
		НовСтр.Тип = caseFilesCatalog.objectID.type;
		Если ИнтеграцияС1СДокументооборотБазоваяФункциональность.СвойствоУстановлено(caseFilesCatalog, "section") Тогда
			НовСтр.РазделID = caseFilesCatalog.section.objectID.ID;
			НовСтр.РазделТип = caseFilesCatalog.section.objectID.type;
		Иначе
			НовСтр.РазделID = "БезРаздела";
			НовСтр.РазделТип = "БезРаздела";
		КонецЕсли;
	КонецЦикла;
	
	ЗначениеВРеквизитФормы(Таблица, "Список");
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоРазделов(Дерево, caseFilesListSectionsTree)
	
	Для Каждого caseFilesListSectionsTreeElement Из caseFilesListSectionsTree Цикл
		НовыйЭлемент = Дерево.Строки.Добавить();
		НовыйЭлемент.Наименование = caseFilesListSectionsTreeElement.caseFilesListSection.name;
		НовыйЭлемент.ID = caseFilesListSectionsTreeElement.caseFilesListSection.objectID.ID;
		НовыйЭлемент.Тип = caseFilesListSectionsTreeElement.caseFilesListSection.objectID.type;
		НовыйЭлемент.ИндексКартинки = 0;
		Если ИнтеграцияС1СДокументооборотБазоваяФункциональность.СвойствоУстановлено(
				caseFilesListSectionsTreeElement, "caseFilesListSectionsTree") Тогда
			ЗаполнитьДеревоРазделов(НовыйЭлемент, caseFilesListSectionsTreeElement.caseFilesListSectionsTree)
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
