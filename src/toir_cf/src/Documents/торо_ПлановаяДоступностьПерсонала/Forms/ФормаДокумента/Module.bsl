
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.ГруппаГлобальные;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// Заголовок формы++
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--
	
	фСостояниеЯвка = ПредопределенноеЗначение("Справочник.торо_СостоянияСотрудника.Явка");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЗаполнитьПериодПланирования();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
    УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства	
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом	
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
	
	// Заголовок формы++
	торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, ЭтотОбъект, "Объект.Комментарий");	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыРабочееВремяСотрудников

&НаКлиенте
Процедура РабочееВремяСотрудниковСотрудникНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	
	ТекДанные = Элементы.РабочееВремяСотрудников.ТекущиеДанные;
	Если ТекДанные <> Неопределено Тогда
		ПараметрыФормы.Вставить("ТекущаяСтрока", ТекДанные.Сотрудник);
	КонецЕсли;
	
	стрОтбор = Новый Структура;
	стрОтбор.Вставить("ТекущаяОрганизация",Объект.Организация);
	стрОтбор.Вставить("ТекущееПодразделение",Объект.Подразделение);
	ПараметрыФормы.Вставить("Отбор", стрОтбор);
	
	ОткрытьФорму("Справочник.Сотрудники.ФормаСписка", ПараметрыФормы, Элемент, УникальныйИдентификатор);

КонецПроцедуры

&НаКлиенте
Процедура РабочееВремяСотрудниковСотрудникПриИзменении(Элемент)
	
	ТекДанные = Элементы.РабочееВремяСотрудников.ТекущиеДанные;
	Если ТекДанные <> Неопределено Тогда
		ТекДанные.Должность = ДолжностьСотрудника(ТекДанные.Сотрудник, Объект.Организация, Объект.Подразделение, Объект.Дата);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РабочееВремяСотрудниковВремяНачалаПриИзменении(Элемент)
	
	ТекДанные = Элементы.РабочееВремяСотрудников.ТекущиеДанные;
	РабочееВремяСотрудниковВремяРаботыПриИзменении(ТекДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура РабочееВремяСотрудниковВремяОкончанияПриИзменении(Элемент)
	
	ТекДанные = Элементы.РабочееВремяСотрудников.ТекущиеДанные;
	РабочееВремяСотрудниковВремяРаботыПриИзменении(ТекДанные);

КонецПроцедуры

&НаКлиенте
Процедура РабочееВремяСотрудниковВремяРаботыПриИзменении(ТекДанные)
	
	Если ЗначениеЗаполнено(ТекДанные.ВремяНачала) И ЗначениеЗаполнено(ТекДанные.ВремяОкончания) Тогда
		
		ВремяРаботы = ТекДанные.ВремяОкончания - ТекДанные.ВремяНачала;
		
		Если ВремяРаботы + 1 < 0 Тогда
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Время окончания меньше времени начала");
			
		Иначе
			
			ТекДанные.ВремяРаботы = ВремяРаботы;
			
		КонецЕсли;
		
	Иначе
		
		ТекДанные.ВремяРаботы = 0;
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура РабочееВремяСотрудниковСостояниеСотрудникаПриИзменении(Элемент)
	
	ТекДанные = Элементы.РабочееВремяСотрудников.ТекущиеДанные;
	Если ТекДанные.СостояниеСотрудника <> фСостояниеЯвка Тогда
		ТекДанные.ВремяНачала    = Неопределено;
		ТекДанные.ВремяОкончания = Неопределено;
		ТекДанные.ВремяРаботы   = 0;
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

&НаКлиенте
Процедура ЗаполнитьПериодПланирования()

	ПериодПланирования.ДатаНачала    = Объект.НачалоПланирования;
	ПериодПланирования.ДатаОкончания = Объект.ОкончаниеПланирования;

КонецПроцедуры // ЗаполнитьПериодПланирования()

&НаСервереБезКонтекста
Функция ДолжностьСотрудника(Сотрудник, Организация, Подразделение, ДатаСреза)

	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	                      |	КадроваяИсторияСотрудниковСрезПоследних.Должность КАК Должность
	                      |ИЗ
	                      |	РегистрСведений.КадроваяИсторияСотрудников.СрезПоследних(&ДатаСреза, ) КАК КадроваяИсторияСотрудниковСрезПоследних
	                      |ГДЕ
	                      |	КадроваяИсторияСотрудниковСрезПоследних.Сотрудник = &Сотрудник
	                      |	И КадроваяИсторияСотрудниковСрезПоследних.Организация = &Организация
	                      |	И КадроваяИсторияСотрудниковСрезПоследних.Подразделение = &Подразделение");
	Запрос.УстановитьПараметр("ДатаСреза", ДатаСреза);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Подразделение", Подразделение);
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Должность;
	Иначе
		Результат = Неопределено;
	КонецЕсли;
	
	Возврат Результат;

КонецФункции // ДолжностьСотрудника()

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

&НаКлиенте
Процедура РабочееВремяСотрудниковСотрудникАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	ТекущаяДата = ПериодПланирования.ДатаНачала;
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокАвтоподбораПринятыхСотрудников(ТекущаяДата, Текст, ДанныеВыбора, СтандартнаяОбработка, Объект.Организация, Объект.Подразделение);
КонецПроцедуры

&НаКлиенте
Процедура РабочееВремяСотрудниковСотрудникОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ТекущаяДата = ПериодПланирования.ДатаНачала;
	торо_ЗаполнениеДокументовКлиент.СформироватьСписокАвтоподбораПринятыхСотрудников(ТекущаяДата, Текст, ДанныеВыбора, СтандартнаяОбработка, Объект.Организация, Объект.Подразделение);
КонецПроцедуры

#КонецОбласти