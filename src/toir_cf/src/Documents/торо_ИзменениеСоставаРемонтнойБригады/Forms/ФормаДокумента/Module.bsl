#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Если НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
			
			Объект.Организация = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
			"НастройкиТОиР",
			"ОсновнаяОрганизация",
			Истина);
			
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Объект.Подразделение) Тогда
			
			Объект.Подразделение = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
			"НастройкиТОиР",
			"ОсновноеПодразделение",
			Истина);
			
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Объект.Ответственный) Тогда
			
			Объект.Ответственный = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(
			"НастройкиТОиР",
			"ОсновнойОтветственный",
			Справочники.Пользователи.ПустаяСсылка());
			
		КонецЕсли;
		
		Если Параметры.Свойство("РемонтнаяБригада") И ЗначениеЗаполнено(Параметры.РемонтнаяБригада) Тогда 
			Объект.РемонтнаяБригада = Параметры.РемонтнаяБригада;
		КонецЕсли;
		
		Если Параметры.Свойство("СоставБригады") Тогда 
			Для каждого Строка  Из Параметры.СоставБригады Цикл
				НС = Объект.СоставРемонтнойБригады.Добавить();
				ЗаполнитьЗначенияСвойств(НС, Строка);
			КонецЦикла;
		КонецЕсли;
						
	КонецЕсли;
	// Заголовок формы++
	
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	
	// Заголовок формы--
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
    УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// Заголовок формы++
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы
&НаКлиенте
Процедура РемонтнаяБригадаПриИзменении(Элемент)
	
	Объект.СоставРемонтнойБригады.Очистить();
	
	Если Не ЗначениеЗаполнено(Объект.РемонтнаяБригада) Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьСоставРемонтнойБригады();
	
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСоставРемонтнойБригады
&НаКлиенте
Процедура СоставРемонтнойБригадыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	ТекДанные = Элемент.ТекущиеДанные;
	Если ОтменаРедактирования И (Не ЗначениеЗаполнено(ТекДанные.Исполнитель) ИЛИ НЕ ЗначениеЗаполнено(ТекДанные.Квалификация) ИЛИ Объект.СоставРемонтнойБригады.НайтиСтроки(Новый Структура("Исполнитель",ТекДанные.Исполнитель)).Количество() > 1) Тогда
		Объект.СоставРемонтнойБригады.Удалить(ТекДанные);
		Возврат;
	КонецЕсли;
	
	Если Объект.СоставРемонтнойБригады.НайтиСтроки(Новый Структура("Исполнитель, Квалификация", ТекДанные.Исполнитель, ТекДанные.Квалификация)).Количество() > 1 И НЕ ОтменаРедактирования Тогда
		ТекстСообщения = НСтр("ru = 'Следующие исполнители с одной и той же квалификацией внесены в список более одного раза:'") + "  - " + ТекДанные.Исполнитель + " (" + ТекДанные.Квалификация + ")";
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения,,,, Отказ);
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока И НЕ Копирование Тогда 
		ТекущиеДанные = Элемент.ТекущиеДанные;
		Если ТекущиеДанные <> Неопределено Тогда
			ТекущиеДанные.КТУ = 1;
		КонецЕсли;
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыКвалификацияПриИзменении(Элемент)
	ТекДанные = Элементы.СоставРемонтнойБригады.ТекущиеДанные;
	
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыКвалификацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокВыбораКвалификацийСотрудника(Элемент, ЭтотОбъект, Элементы.СоставРемонтнойБригады.ТекущиеДанные.Исполнитель, Объект.Дата, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыКвалификацияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокАвтоподбораКвалификацийСотрудника(Элементы.СоставРемонтнойБригады.ТекущиеДанные.Исполнитель, Объект.Дата, Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыКвалификацияОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокАвтоподбораКвалификацийСотрудника(Элементы.СоставРемонтнойБригады.ТекущиеДанные.Исполнитель, Объект.Дата, Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры


&НаКлиенте
Процедура СоставРемонтнойБригадыИсполнительНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекДанные = Элементы.СоставРемонтнойБригады.ТекущиеДанные;
	Если ЗначениеЗаполнено(ТекДанные.Квалификация) Тогда
		СписокСотрудников = торо_ПроцедурыУправленияПерсоналом.ПолучитьСписокСотрудниковСКвалификацией(ТекДанные.Квалификация, Объект.Дата);
	Иначе
		СписокСотрудников = торо_ПроцедурыУправленияПерсоналом.ПолучитьСписокНеуволенныхСотрудников();
	КонецЕсли;
	
	ОткрытьФорму("Справочник.Сотрудники.ФормаВыбора", Новый Структура("Отбор, РежимВыбора", Новый Структура ("СписокСотрудников", СписокСотрудников), Истина), Элемент,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыИсполнительАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокАвтоподбораСотрудниковСКвалификацией(Элементы.СоставРемонтнойБригады.ТекущиеДанные.Квалификация, Объект.Дата, Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыИсполнительОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокАвтоподбораСотрудниковСКвалификацией(Элементы.СоставРемонтнойБригады.ТекущиеДанные.Квалификация, Объект.Дата, Текст, ДанныеВыбора, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СоставРемонтнойБригадыБригадирПриИзменении(Элемент)
	
	Для каждого текСтрока из Объект.СоставРемонтнойБригады Цикл
		текСтрока.бригадир = Ложь;
	КонецЦикла;
	
	ТекСтрока = Элементы.СоставРемонтнойБригады.ТекущиеДанные;
	Если текСтрока <> Неопределено Тогда
		текСтрока.Бригадир = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры
 
&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаСервере
// Процедура выполняет заполнение таблицы состава ремонтной бригады.
//
Процедура ЗаполнитьСоставРемонтнойБригады()
	
	Ресурсы = Объект.РемонтнаяБригада.РесурсыРемонтнойБригады;
	
	ТаблицаПрежнегоСостава = ПолучитьТаблицуТекущегоСостава();
	
	Для Каждого СтрокаРабочий Из Ресурсы.Рабочие Цикл
		
		Для Счетчик1 = 1 По СтрокаРабочий.Количество Цикл
			
			НовСтрСостава = Объект.СоставРемонтнойБригады.Добавить();
			НовСтрСостава.Квалификация = СтрокаРабочий.Квалификация;
			НовСтрСостава.КТУ         = 1;
			
			НайденнаяСтрока = ТаблицаПрежнегоСостава.Найти(СтрокаРабочий.Квалификация);
			Если Не НайденнаяСтрока = Неопределено Тогда
				НовСтрСостава.Исполнитель = НайденнаяСтрока.Исполнитель;
				ТаблицаПрежнегоСостава.Удалить(НайденнаяСтрока);
			КонецЕсли;
			
		КонецЦикла; 
		
	КонецЦикла; 
	
	
КонецПроцедуры

&НаСервере
// Функция возвращает состав ремонтной бригады по дате документа.
//
Функция ПолучитьТаблицуТекущегоСостава()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	СоставБригадСрезПоследних.Исполнитель,
	               |	СоставБригадСрезПоследних.Квалификация
	               |ИЗ
	               |	РегистрСведений.торо_СоставРемонтныхБригад.СрезПоследних(&Дата, РемонтнаяБригада = &РемонтнаяБригада) КАК СоставБригадСрезПоследних
	               |ГДЕ
	               |	СоставБригадСрезПоследних.ИсключенИзБригады = ЛОЖЬ";
				   
	Запрос.УстановитьПараметр("Дата", КонецДня(Объект.Дата));
	Запрос.УстановитьПараметр("РемонтнаяБригада", Объект.РемонтнаяБригада);

	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, ЭтотОбъект, "Объект.Комментарий");	
	
КонецПроцедуры

#КонецОбласти