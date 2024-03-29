#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	КадровыйУчетФормы.ФормаКадровогоДокументаПриСозданииНаСервере(ЭтаФорма);
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	Если Не ЗначениеЗаполнено(Параметры.Ключ) Тогда
		
		Если Не ЗначениеЗаполнено(Объект.ДатаНачала) Тогда
			Объект.ДатаНачала = ТекущаяДатаСеанса();
		КонецЕсли;
		
		Если Параметры.Свойство("Сотрудник") И ЗначениеЗаполнено(Параметры.Сотрудник) Тогда 
			Объект.Сотрудник = Параметры.Сотрудник;
		КонецЕсли;
		
		ПриПолученииДанныхНаСервере();
		
		Если ЗначениеЗаполнено(Объект.Сотрудник) И Не ЗначениеЗаполнено(Объект.ИсправленныйДокумент) Тогда
			УстановитьТекущиеДанныеСотрудника();
		КонецЕсли;
		
		ОбработатьИзменениеОрганизации();
		
	КонецЕсли;
	
	УстановитьДоступностьЭлементов(ЭтаФорма);
	ФОИспользоватьШтатноеРасписание = Ложь;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ЗаполнитьПоПозицииВГруппеДобавитьОтменить",
		"Видимость",
		ФОИспользоватьШтатноеРасписание);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ЗаполнитьПоПозицииВГруппеКнопокДобавитьПродолжить",
		"Видимость",
		ФОИспользоватьШтатноеРасписание);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ЗаполнитьПоПозицииВГруппеКнопокДобавитьУдалить",
		"Видимость",
		ФОИспользоватьШтатноеРасписание);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ЗаполнитьПоПозицииВГруппеДобавитьОтменитьЕО",
		"Видимость",
		ФОИспользоватьШтатноеРасписание);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ЗаполнитьПоПозицииВГруппеКнопокДобавитьПродолжить1",
		"Видимость",
		ФОИспользоватьШтатноеРасписание);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ЗаполнитьПоПозицииВГруппеКнопокДобавитьУдалитьЕО",
		"Видимость",
		ФОИспользоватьШтатноеРасписание);
		
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
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	ПриПолученииДанныхНаСервере();
	
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
	
	УстановитьПривилегированныйРежим(Истина);
	
	ДанныеНачисленийВРеквизит(ТекущийОбъект);
	УстановитьКомментарии(ЭтаФорма);
	УстановитьОтображениеНадписей();
	// Заголовок формы++
		торо_РаботаСДиалогами.УстановитьЗаголовокФормыДокумента(Объект, ЭтаФорма, "");
	// Заголовок формы--	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
	КадровыйУчетКлиент.ОповеститьОбИзмененииРабочегоМеста(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ИмяСобытия = "ЗаписанИндивидуальныйГрафикСотрудника" Тогда
		
		Если Источник = ЭтаФорма Тогда
			ИндивидуальныйГрафикСсылка = Параметр.Ссылка;
			ИндивидуальныйГрафикДата = Параметр.Дата;
			ИндивидуальныйГрафикНомер = Параметр.Номер;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ДанныеВыбора = Новый СписокЗначений;
	
	масСотрудников = СписокПодходящихСорудников(Объект.ДатаНачала, Объект.ДатаОкончания, Объект.Организация, Текст);
	Для каждого ТекСтрока из масСотрудников Цикл
		ДанныеВыбора.Добавить(ТекСтрока);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура СотрудникОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	масСотрудников = СписокПодходящихСорудников(Объект.ДатаНачала, Объект.ДатаОкончания, Объект.Организация, Текст);
	ДанныеВыбора = Новый СписокЗначений;
	Для каждого ТекСтрока из масСотрудников Цикл
		ДанныеВыбора.Добавить(ТекСтрока);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	ОрганизацияПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СотрудникПриИзменении(Элемент)
	
	СотрудникПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаНачалаПриИзменении(Элемент)
	
	ДатаНачалаПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзмениласьПозицияПриИзменении(Элемент)
	
	ИзмениласьПозицияПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодразделениеПриИзменении(Элемент)
	
	ПодразделениеПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоСтавокПриИзменении(Элемент)
	КоличествоСтавокКомментарий = КадровыйУчетРасширенныйКлиентСервер.КомментарийККоличествуСтавок(ТекущееКоличествоСтавок, Объект.КоличествоСтавок, ТекущееКоличествоСтавок);
КонецПроцедуры

&НаКлиенте
Процедура КоличествоСтавокРегулирование(Элемент, Направление, СтандартнаяОбработка)
	КадровыйУчетРасширенныйКлиент.КоличествоСтавокРегулирование(Объект.КоличествоСтавок, Направление, СтандартнаяОбработка);
	КоличествоСтавокКомментарий = КадровыйУчетРасширенныйКлиентСервер.КомментарийККоличествуСтавок(ТекущееКоличествоСтавок, Объект.КоличествоСтавок, Объект.КоличествоСтавок);
КонецПроцедуры

&НаКлиенте
Процедура ИзменилсяГрафикПриИзменении(Элемент)
	
	ЗаполнитьГрафик();
	
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаВводИндивидуальногоГрафикаНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура РуководительПриИзменении(Элемент)
	
	Если ЗначениеЗаполнено(Объект.Руководитель) Тогда 
		Объект.ДолжностьРуководителя = ПолучитьДолжностьРуководителя(Объект.Руководитель, Объект.Дата);
	Иначе Объект.ДолжностьРуководителя = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьСведенияОДоговореПриИзменении(Элемент)
	Объект.ДатаЗавершенияТрудовогоДоговора = ТекущаяДатаЗавершенияТД;
	УстановитьДоступностьЭлементов(ЭтаФорма);
	Элементы.ДатаЗавершенияТДПодсказка.Видимость = Объект.ИзменитьСведенияОДоговоре;
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
Процедура ПриПолученииДанныхНаСервере()
	
	
	УстановитьПривилегированныйРежим(Истина);
	
	УстановитьФункциональныеОпцииФормы();
	
	УстановитьДоступностьЭлементовИзмененияДанныхСотрудника();
	
	УстановитьТекущиеКадровыеДанные();
	
	ДанныеНачисленийВРеквизит(Объект);
	
	УстановитьОтображениеНадписей();
	
КонецПроцедуры

&НаСервере
Процедура ИзмениласьПозицияПриИзмененииНаСервере()
	
	УстановитьДанныеРабочегоМеста();
	УстановитьДоступностьЭлементов(ЭтаФорма);
	УстановитьКомментарии(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДанныеРабочегоМеста()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ЗначениеЗаполнено(Объект.Сотрудник) Тогда
		Объект.Подразделение 				= ТекущееПодразделение;
		Объект.Должность 					= ТекущаяДолжность;
		Объект.ВидЗанятости 				= ТекущийВидЗанятости;
	Иначе
		Если ЗначениеЗаполнено(Объект.Сотрудник) И НЕ ЗначениеЗаполнено(Объект.ОбособленноеПодразделение) Тогда
			Объект.ОбособленноеПодразделение 	= Объект.Организация;
		КонецЕсли;
		Объект.Подразделение 				= Справочники.СтруктураПредприятия.ПустаяСсылка();
		Объект.Должность 					= Справочники.Должности.ПустаяСсылка();
		Объект.ВидЗанятости 				= Перечисления.ВидыЗанятости.ПустаяСсылка();
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьФункциональныеОпцииФормы() 
	
	ГоловнаяОрганизация = Объект.Организация;
	
	ПараметрыФО = Новый Структура("Организация", ГоловнаяОрганизация);
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыФО);
	
КонецПроцедуры

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	
	УстановитьФункциональныеОпцииФормы();
	ОбработатьИзменениеОрганизации();
	УстановитьДоступностьЭлементов(ЭтаФорма);

	УстановитьДоступностьНовогоПодразделения(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура СотрудникПриИзмененииНаСервере()

	УстановитьТекущиеДанныеСотрудника();
	УстановитьОтображениеНадписей();

КонецПроцедуры

&НаСервере
Процедура ОбработатьИзменениеОрганизации()

	Если ЗначениеЗаполнено(Объект.Организация) Тогда
		КадровыйУчетФормы.ЗаполнитьОтветственныхЛицПоОрганизации(ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТекущиеДанныеСотрудника()
	
	УстановитьТекущиеКадровыеДанные();
	УстановитьДанныеРабочегоМеста();
	
	Объект.Подразделение = ТекущееПодразделение;
	Объект.Должность = ТекущаяДолжность;
	Объект.КоличествоСтавок = ТекущееКоличествоСтавок;
	Объект.ГрафикРаботы = ТекущийГрафикРаботы;
	Объект.ВидЗанятости = ТекущийВидЗанятости;
	Объект.ФизическоеЛицо = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Сотрудник, "ФизическоеЛицо");
	Объект.ДатаЗавершенияТрудовогоДоговора = ТекущаяДатаЗавершенияТД;
	
	УстановитьДоступностьЭлементовИзмененияДанныхСотрудника();
	
	УстановитьДоступностьНовогоПодразделения(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьЭлементовИзмененияДанныхСотрудника()
	
	ДоступноИзменениеДанныхСотрудника = ЗначениеЗаполнено(Объект.Сотрудник);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИзмениласьПозиция",
		"Доступность",
		ДоступноИзменениеДанныхСотрудника);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИзменилсяГрафик",
		"Доступность",
		ДоступноИзменениеДанныхСотрудника);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИзменилисьНачисления",
		"Доступность",
		ДоступноИзменениеДанныхСотрудника);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИзменитьЕжегодныеОтпуска",
		"Доступность",
		ДоступноИзменениеДанныхСотрудника);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИзменитьАванс",
		"Доступность",
		ДоступноИзменениеДанныхСотрудника);
	
КонецПроцедуры

&НаСервере
Процедура ДатаНачалаПриИзмененииНаСервере()
	
	УстановитьТекущиеДанныеСотрудника();
	
	УстановитьОтображениеНадписей();
	
КонецПроцедуры	

&НаСервере
Процедура УстановитьТекущиеКадровыеДанные()
	
	Если ЗначениеЗаполнено(Объект.Сотрудник) Тогда
		
		СтруктураОтбораКадровыхДанных = Новый Структура("ЛевоеЗначение, ВидСравнения, ПравоеЗначение", "Регистратор", "<>", Объект.Ссылка);
		Отбор = Новый Массив;
		Отбор.Добавить(СтруктураОтбораКадровыхДанных);
		
		ПоляОтбораПериодическихДанных = Новый Структура;
		ПоляОтбораПериодическихДанных.Вставить("КадроваяИсторияСотрудников", Отбор);
		ПоляОтбораПериодическихДанных.Вставить("ГрафикРаботыСотрудников", Отбор);
		ПоляОтбораПериодическихДанных.Вставить("РазрядыКатегорииСотрудников", Отбор);
		Поля = "Подразделение,Должность,КоличествоСтавок,ГрафикРаботы,Организация,ВидЗанятости";
		
		УстановитьПривилегированныйРежим(Истина);
		
		ДанныеСотрудников = КадровыйУчет.КадровыеДанныеСотрудников(Ложь, Объект.Сотрудник, Поля, , ПоляОтбораПериодическихДанных);
	
		УстановитьПривилегированныйРежим(Ложь);
		
		Если ДанныеСотрудников.Количество() > 0 Тогда
			ТекущиеКадровыеДанныеСотрудника = ДанныеСотрудников[0];
			
			ТекущееПодразделение = ТекущиеКадровыеДанныеСотрудника.Подразделение;
			ТекущийГрафикРаботы = ТекущиеКадровыеДанныеСотрудника.ГрафикРаботы;
			ТекущееКоличествоСтавок = ТекущиеКадровыеДанныеСотрудника.КоличествоСтавок;
			ТекущаяДолжность =  ТекущиеКадровыеДанныеСотрудника.Должность;
			ТекущийВидЗанятости = ТекущиеКадровыеДанныеСотрудника.ВидЗанятости;
			ТекущаяДатаЗавершенияТД = ПолучитьДатуЗавершенияТД(Объект.Сотрудник, Объект.ДатаНачала);
		КонецЕсли;	
		
	Иначе
		ТекущееПодразделение = Справочники.СтруктураПредприятия.ПустаяСсылка();
		ТекущаяДолжность = Справочники.Должности.ПустаяСсылка();
		ТекущийГрафикРаботы = Справочники.Календари.ПустаяСсылка();
		ТекущееКоличествоСтавок = 0;
		ТекущийВидЗанятости = Перечисления.ВидыЗанятости.ПустаяСсылка();
		ТекущаяДатаЗавершенияТД = Неопределено;
	КонецЕсли;
	
	УстановитьКомментарии(ЭтаФорма);
	
КонецПроцедуры	

&НаСервереБезКонтекста
Функция ПолучитьДатуЗавершенияТД(Сотрудник, ДатаНачала)
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ПриемНаРаботу.Сотрудник КАК Сотрудник,
		|	ПриемНаРаботу.ДатаЗавершенияТрудовогоДоговора КАК ДатаЗавершенияТрудовогоДоговора
		|ПОМЕСТИТЬ ВТ_ПриемНаРаботу
		|ИЗ
		|	Документ.ПриемНаРаботу КАК ПриемНаРаботу
		|ГДЕ
		|	ПриемНаРаботу.Сотрудник = &Сотрудник
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Сотрудник
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КадровыйПеревод.Сотрудник КАК Сотрудник,
		|	КадровыйПеревод.ДатаЗавершенияТрудовогоДоговора КАК ДатаЗавершенияТрудовогоДоговора,
		|	КадровыйПеревод.ДатаНачала КАК ДатаНачала
		|ПОМЕСТИТЬ ВТ_КадровыйПеревод
		|ИЗ
		|	Документ.КадровыйПеревод КАК КадровыйПеревод
		|ГДЕ
		|	КадровыйПеревод.Сотрудник = &Сотрудник
		|	И КадровыйПеревод.ДатаНачала < &ДатаНачала
		|	И КадровыйПеревод.ИзменитьСведенияОДоговоре
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Сотрудник,
		|	ДатаНачала
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ВТ_КадровыйПеревод.Сотрудник КАК Сотрудник,
		|	МАКСИМУМ(ВТ_КадровыйПеревод.ДатаНачала) КАК ДатаНачала
		|ПОМЕСТИТЬ ВТ_ДействующийПеревод
		|ИЗ
		|	ВТ_КадровыйПеревод КАК ВТ_КадровыйПеревод
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТ_КадровыйПеревод.Сотрудник
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Сотрудник,
		|	ДатаНачала
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	ВТ_КадровыйПеревод.Сотрудник КАК Сотрудник,
		|	ВТ_КадровыйПеревод.ДатаЗавершенияТрудовогоДоговора КАК ДатаЗавершенияТрудовогоДоговора
		|ПОМЕСТИТЬ ВТ_ДатаЗавершенияТДПоКП
		|ИЗ
		|	ВТ_КадровыйПеревод КАК ВТ_КадровыйПеревод
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ДействующийПеревод КАК ВТ_ДействующийПеревод
		|		ПО ВТ_КадровыйПеревод.Сотрудник = ВТ_ДействующийПеревод.Сотрудник
		|			И ВТ_КадровыйПеревод.ДатаНачала = ВТ_ДействующийПеревод.ДатаНачала
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Сотрудник
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ЕСТЬNULL(ВТ_ДатаЗавершенияТДПоКП.ДатаЗавершенияТрудовогоДоговора, ВТ_ПриемНаРаботу.ДатаЗавершенияТрудовогоДоговора) КАК ДатаЗавершенияТрудовогоДоговора
		|ИЗ
		|	ВТ_ПриемНаРаботу КАК ВТ_ПриемНаРаботу
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДатаЗавершенияТДПоКП КАК ВТ_ДатаЗавершенияТДПоКП
		|		ПО ВТ_ПриемНаРаботу.Сотрудник = ВТ_ДатаЗавершенияТДПоКП.Сотрудник";
	
	Запрос.УстановитьПараметр("Сотрудник", Сотрудник);
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
	    Возврат Дата(1, 1, 1);
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	ВыборкаДетальныеЗаписи.Следующий();
	
	Возврат ВыборкаДетальныеЗаписи.ДатаЗавершенияТрудовогоДоговора;
КонецФункции

&НаСервере
Процедура УстановитьКомментарии(Форма)
	
	Форма.КоличествоСтавокКомментарий = КадровыйУчетРасширенныйКлиентСервер.КомментарийККоличествуСтавок(
		Форма.ТекущееКоличествоСтавок,
		Форма.Объект.КоличествоСтавок,
		Форма.Объект.ИзменитьПодразделениеИДолжность);
		
	УстановитьПозицияКомментарий();
	
	УстановитьГрафикРаботыКомментарий(Форма);
	
	Форма.Элементы.ПозицияКомментарий.Подсказка = Форма.ПозицияКомментарий;
	Форма.Элементы.ГрафикРаботыКомментарий.Подсказка = Форма.ГрафикРаботыКомментарий;
	
	Форма.Элементы.ДатаЗавершенияТДПодсказка.Видимость = Форма.Объект.ИзменитьСведенияОДоговоре;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьПозицияКомментарий()
	
	Если Объект.ИзменитьПодразделениеИДолжность Тогда
		
		Если ЗначениеЗаполнено(ТекущееПодразделение) Тогда
			
			Отбор = Новый Структура("Сотрудник", Объект.Сотрудник);
			ТабПредыдущихДанных = РегистрыСведений.КадроваяИсторияСотрудников.СрезПоследних(Объект.ДатаНачала-1, Отбор);
			Если ТабПредыдущихДанных.Количество() > 0 Тогда 
				ПредыдущиеДанные = ТабПредыдущихДанных[0];
				Если ЗначениеЗаполнено(ПредыдущиеДанные.ДействуетДо) И Объект.ДатаНачала > ПредыдущиеДанные.ДействуетДо 
				  И ЗначениеЗаполнено(ПредыдущиеДанные.ДолжностьПоОкончании) Тогда
					ПредыдущаяДолжность = ПредыдущиеДанные.ДолжностьПоОкончании;
					ПредыдущееПодразделение = ПредыдущиеДанные.ПодразделениеПоОкончании;
				Иначе
					ПредыдущаяДолжность = ПредыдущиеДанные.Должность;
					ПредыдущееПодразделение = ПредыдущиеДанные.Подразделение; 
				КонецЕсли;
				
				ПозицияКомментарий = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Ранее сотрудник занимал должность ""%1"" в подразделении ""%2""'"),
				ПредыдущаяДолжность, ПредыдущееПодразделение);
			КонецЕсли;
			
		Иначе
			
			ПозицияКомментарий = НСтр("ru = 'Сотрудник еще не принят на работу'");
			
		КонецЕсли;
		
	Иначе
		
		ПозицияКомментарий = "";
		
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьГрафикРаботыКомментарий(Форма)
	
	Если Форма.Объект.ИзменитьГрафикРаботы Тогда
			
		Форма.ГрафикРаботыКомментарий = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Ранее сотрудник работал по графику %1'"),
			Форма.ТекущийГрафикРаботы);

	Иначе
				
		Форма.ГрафикРаботыКомментарий = "";
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДанныеНачисленийВРеквизит(ТекущийОбъект)
	
	ТаблицаСотрудников = ТаблицаСотрудников();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементов(Форма)
	
	ИзменитьПозициюДолжность		= Форма.Объект.ИзменитьПодразделениеИДолжность;
	ИзменитьГрафикРаботы			= Форма.Объект.ИзменитьГрафикРаботы;
	ИзменитьСведенияОДоговоре		= Форма.Объект.ИзменитьСведенияОДоговоре;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"Подразделение",
		"Доступность",
		ИзменитьПозициюДолжность);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"Должность",
			"Доступность",
			ИзменитьПозициюДолжность);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"КоличествоСтавок",
		"Доступность",
		ИзменитьПозициюДолжность);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"РазрядКатегория",
		"Доступность",
		ИзменитьПозициюДолжность);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ВидЗанятости",
		"Доступность",
		ИзменитьПозициюДолжность);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"СтатьяФинансирования",
		"Доступность",
		ИзменитьПозициюДолжность);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"График",
		"Доступность",
		ИзменитьГрафикРаботы);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ДатаЗавершенияТрудовогоДоговора",
		"Доступность",
		ИзменитьСведенияОДоговоре);
		
КонецПроцедуры

&НаСервере
Процедура ПодразделениеПриИзмененииНаСервере()
	
	ЗаполнитьГрафик(Истина);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьГрафик(Перезаполнение = Ложь)
	
	Если Объект.ИзменитьГрафикРаботы ИЛИ Перезаполнение Тогда
		
		ЗначенияДляЗаполнения = Новый Структура;
				
		ЗначенияДляЗаполнения.Вставить("Организация", "Объект.Организация");
		ЗначенияДляЗаполнения.Вставить("Подразделение", 				"Объект.Подразделение");
		ЗначенияДляЗаполнения.Вставить("ГрафикРаботы",					"Объект.ГрафикРаботы");
		
		ФиксированныеЗначения = Новый Массив;
		ФиксированныеЗначения.Добавить("Организация");
		ФиксированныеЗначения.Добавить("Подразделение");

		ЗарплатаКадры.ЗаполнитьЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения, ФиксированныеЗначения);
		
		Если Не ЗначениеЗаполнено(Объект.ГрафикРаботы) Тогда
			Объект.ГрафикРаботы = ТекущийГрафикРаботы;
		КонецЕсли;
		
		Если Перезаполнение Тогда
			
			Если Объект.ГрафикРаботы <> ТекущийГрафикРаботы Тогда
				Объект.ИзменитьГрафикРаботы = Истина;
			Иначе
				Объект.ИзменитьГрафикРаботы = Ложь;
			КонецЕсли;
			
		КонецЕсли; 
		
	Иначе
		
		Объект.ГрафикРаботы = ТекущийГрафикРаботы;
		
	КонецЕсли;
	
	УстановитьДоступностьЭлементов(ЭтаФорма);
	УстановитьКомментарии(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КомментарийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования,
		ЭтотОбъект,
		"Объект.Комментарий"
	);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьНовогоПодразделения(Форма)
	
	ДоступностьПодразделнияИДолжности = 
		Форма.Объект.ИзменитьПодразделениеИДолжность;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"Подразделение",
		"Доступность",
		ДоступностьПодразделнияИДолжности);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ПозицияШтатногоРасписания",
		"Доступность",
		ДоступностьПодразделнияИДолжности);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"Должность",
		"Доступность",
		ДоступностьПодразделнияИДолжности);
	
КонецПроцедуры

&НаСервере
Функция ТаблицаСотрудников()
	
	ТаблицаСотрудников = Новый ТаблицаЗначений;
	ТаблицаСотрудников.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	ТаблицаСотрудников.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	
	СтрокаСотрудник = ТаблицаСотрудников.Добавить();
	СтрокаСотрудник.Сотрудник = Объект.Сотрудник;
	
	Возврат ТаблицаСотрудников;
	
КонецФункции

&НаСервере
Процедура УстановитьОтображениеНадписей()
	
	МассивСотрудников = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Объект.Сотрудник);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СписокПодходящихСорудников(ДатаНачала, ДатаОкончания, Организация, Текст)
	Возврат Документы.КадровыйПеревод.СписокПодходящихСорудников(ДатаНачала, ДатаОкончания, Организация, Текст);
КонецФункции

&НаСервере 
Функция ПолучитьДолжностьРуководителя (Руководитель, Дата)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	КадроваяИсторияСотрудниковСрезПоследних.Должность КАК Должность
				   |ИЗ
	               |	РегистрСведений.КадроваяИсторияСотрудников.СрезПоследних(&Дата, ФизическоеЛицо = &Руководитель) КАК КадроваяИсторияСотрудниковСрезПоследних";
	
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Руководитель", Руководитель);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Должность = Выборка.Должность;
	КонецЕсли;
	
	Возврат Должность;
		
КонецФункции     

#КонецОбласти