#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.Свойства
	Контекст = Новый Структура();
	Контекст.Вставить("Объект",                     Объект);
	Контекст.Вставить("ИмяЭлементаДляРазмещения",   "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтаФорма, Контекст);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов
	
	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект, Объект);
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Серии = Объект.ВидНоменклатуры.НастройкаИспользованияСерий;
	Иначе		
		ЗаполнитьПоПараметрам();
	КонецЕсли;
	
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);
	
	Элементы.НастройкаИспользованияСерий.Видимость = ПолучитьФункциональнуюОпцию("ИспользоватьСерииНоменклатуры");
	Элементы.ГруппаХарактеристикиНоменклатуры.Видимость = ПолучитьФункциональнуюОпцию("торо_ИспользоватьХарактеристикиНоменклатуры");
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой                 
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("РежимПредставленияОбъектаСервиса", "Гиперссылка");
	РаботаСНоменклатурой.ПриСозданииНаСервереФормаНоменклатуры(ЭтотОбъект, Объект.Ссылка, Элементы.ГруппаРаботаСНоменклатурой, ДополнительныеПараметры);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	
	// ЭлектронноеВзаимодействие.ТорговыеПредложения
	ТорговыеПредложения.ПриСозданииПодсказокФормы(ЭтотОбъект, Элементы.ПодсказкиБизнесСеть);
	// Конец ЭлектронноеВзаимодействие.ТорговыеПредложения
	
	// ЭлектронноеВзаимодействие.СопоставлениеНоменклатурыКонтрагентов
	СопоставлениеНоменклатурыКонтрагентов.ПриСозданииФормыНоменклатуры(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.СопоставлениеНоменклатурыКонтрагентов
	
	НастройкаВидимостиФормы = "СвернутьВсеГруппы";
	СкрытьРаскрытьВсеГруппы(Истина);
	
	ОбработатьВидимостьСхемыОбеспечения();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// ЭлектронноеВзаимодействие.ТорговыеПредложения
	ТорговыеПредложенияКлиент.ОбновитьПодсказкуФормы(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.ТорговыеПредложения

	УстановитьДоступностьСерийХарактеристик();	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
	Если ИмяСобытия = "Запись_ПрисоединенныйФайл" ИЛИ ИмяСобытия = "Запись_Файл" Тогда
		
		Модифицированность = Истина;
		СсылкаНаФайл = ?(ТипЗнч(Источник) = Тип("Массив"), Источник[0], Источник);
		
		Если ВыборИзображения Тогда
			
			Объект.ФайлКартинки = СсылкаНаФайл;
			АдресКартинки = НавигационнаяСсылкаКартинки(Объект.ФайлКартинки, УникальныйИдентификатор);
						
		КонецЕсли;
		
	КонецЕсли;
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	Если ИмяСобытия = РаботаСНоменклатуройКлиент.ОписаниеОповещенийПодсистемы().ЗагрузкаНоменклатуры
		ИЛИ ИмяСобытия = РаботаСНоменклатуройКлиент.ОписаниеОповещенийПодсистемы().СопоставлениеНоменклатуры Тогда
		ПриСозданииЧтенииНаСервере();
	КонецЕсли;
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства	
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатурой.ПерезаполнитьВстроенныеРеквизиты(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой

	МультиязычностьСервер.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
	Если Не Объект.ФайлКартинки.Пустая() Тогда
		АдресКартинки = НавигационнаяСсылкаКартинки(Объект.ФайлКартинки, УникальныйИдентификатор);
	Иначе
		АдресКартинки = "";
	Конецесли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.ДополнительныеСвойства.Вставить("СменаВидаНоменклатурыОтработана");
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	МультиязычностьСервер.ПередЗаписьюНаСервере(ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// подсистема запрета редактирования ключевых реквизитов объектов	
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтаФорма);

	МультиязычностьСервер.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатурой.ПриЗаписиНаСервереФормаНоменклатуры(ЭтотОбъект, ТекущийОбъект, Отказ);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	УстановитьДоступностьСерийХарактеристик();
	
	ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);

	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатуройКлиент.ПослеЗаписиФормаНоменклатуры(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатуройКлиент.ПередЗакрытиемФормыНоменклатуры(ЭтотОбъект, Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("СправочникСсылка.НоменклатураПрисоединенныеФайлы") Тогда
		Если ЗначениеЗаполнено(ВыбранноеЗначение) Тогда
			Объект.ФайлКартинки = ВыбранноеЗначение;
			АдресКартинки = НавигационнаяСсылкаКартинки(Объект.ФайлКартинки, УникальныйИдентификатор)
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВидНоменклатурыПриИзменении(Элемент)
	
	ВидНоменклатурыПриИзмененииНаСервере();
	УстановитьДоступностьСерийХарактеристик();
	
КонецПроцедуры

&НаКлиенте
Процедура АдресКартинкиНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ЗаблокироватьДанныеФормыДляРедактирования();
	ДобавитьИзображениеНаКлиенте();
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	Если Не ЗначениеЗаполнено(Объект.НаименованиеПолное) Тогда
		Объект.НаименованиеПолное = Объект.Наименование;
	КонецЕсли;
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатуройКлиент.ПриИзмененииСобратьСтрокуПоиска(ЭтотОбъект, Элемент);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой 
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_Открытие(Элемент, СтандартнаяОбработка)
	МультиязычностьКлиент.ПриОткрытии(ЭтотОбъект, Объект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаВидимостиФормыПриИзменении(Элемент)
		
	Если НастройкаВидимостиФормы = "ПоказатьВсе" Тогда
		Свернуть = Ложь;
	Иначе
		Свернуть = Истина;
	КонецЕсли;
		
	СкрытьРаскрытьВсеГруппы(Свернуть);
		
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПерейтиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ГиперссылкаПерейтиСформироватьПараметрыИВопрос(Элемент.Имя, НавигационнаяСсылкаФорматированнойСтроки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

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

// ЭлектронноеВзаимодействие.ТорговыеПредложения
&НаКлиенте
Процедура Подключаемый_ПодсказкиБизнесСетьНажатие(Команда)
	
	ТорговыеПредложенияКлиент.ОткрытьФормуПодсказок(ЭтотОбъект);
	
КонецПроцедуры

// Конец ЭлектронноеВзаимодействие.ТорговыеПредложения

&НаКлиенте
Процедура ВыбратьКартинкуИзПрисоединенныхФайлов(Команда)
	
	РаботаСФайламиКлиент.ОткрытьФормуВыбораФайлов(Объект.Ссылка, ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображение(Команда)
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ТекстВопроса = НСтр("ru='Для выбора изображения необходимо записать объект. Записать?'");
		Ответ = Неопределено;

		ПоказатьВопрос(Новый ОписаниеОповещения("ДобавитьИзображениеЗавершение", ЭтотОбъект), ТекстВопроса, РежимДиалогаВопрос.ДаНет);
        Возврат;
		
	КонецЕсли;
	
	ДобавитьИзображениеФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура ИзменитьИзображение(Команда)
	
	ОчиститьСообщения();
	
	Если ЗначениеЗаполнено(Объект.ФайлКартинки) Тогда
		
		РаботаСФайламиКлиент.ОткрытьФормуФайла(Объект.ФайлКартинки);
		
	Иначе
		
		ТекстСообщения = НСтр("ru='Отсутствует изображение для редактирования'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,, "АдресКартинки");
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьИзображение(Команда)
	
	Объект.ФайлКартинки = ПредопределенноеЗначение("Справочник.НоменклатураПрисоединенныеФайлы.ПустаяСсылка");
	АдресКартинки = "";

КонецПроцедуры

&НаКлиенте
Процедура ПросмотретьИзображение(Команда)
	ПросмотретьПрисоединенныйФайл("ФайлКартинки", "АдресКартинки",
		НСтр("ru='Отсутствует изображение для просмотра'"));
КонецПроцедуры

&НаКлиенте
Процедура ПодставитьРабочееНаименование(Команда)
	Объект.НаименованиеПолное = Объект.Наименование;
	Модифицированность = Истина;
КонецПроцедуры

// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
&НаКлиенте
Процедура Подключаемый_НачалоВыбораРаботаСНоменклатурой(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	РаботаСНоменклатуройКлиент.ВыбратьОбъектСервиса(ЭтотОбъект, Элемент, СтандартнаяОбработка, Ложь,
		Новый ОписаниеОповещения("ЗакрытиеФормыВыбораОбъектаСервиса", ЭтотОбъект, Новый Структура));
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОчисткаРаботаСНоменклатурой(Элемент, СтандартнаяОбработка)
	
	РаботаСНоменклатуройКлиент.НажатиеОчиститьНоменклатуру(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_НажатиеРежимОбновленияРаботаСНоменклатурой(Элемент)
	
	РаботаСНоменклатуройКлиент.НажатиеРежимОбновления(ЭтотОбъект, ПодготовитьДанныеДляИнтерактивногоЗаполнения(), 
		Новый ОписаниеОповещения("ЗакрытиеФормыЗаполненияОбъекта", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьРаботаСНоменклатурой(Элемент, СтандартнаяОбработка)
	
	РаботаСНоменклатуройКлиент.ОткрытьКарточкуОбъектаСервиса(ЭтотОбъект, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ИзменениеТекстаРедактированияРаботаСНоменклатурой(Элемент, Текст, СтандартнаяОбработка)
	
	РаботаСНоменклатуройКлиент.ИзменениеТекстаСобратьСтрокуПоиска(ЭтотОбъект, Текст, Элемент, СтандартнаяОбработка)
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРаботаСНоменклатурой(Элемент)
	
	РаботаСНоменклатуройКлиент.ПриИзмененииСобратьСтрокуПоиска(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_НажатиеРаботаСНоменклатурой(Элемент, СтандартнаяОбработка)
	
	РаботаСНоменклатуройКлиент.НажатиеГиперссылки(ЭтотОбъект, Элемент, СтандартнаяОбработка,
		Новый ОписаниеОповещения("ЗакрытиеФормыВыбораОбъектаСервиса", ЭтотОбъект, Новый Структура));
		
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработкаНавигационнойСсылкиРаботаСНоменклатурой(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	РаботаСНоменклатуройКлиент.НажатиеГиперссылки(ЭтотОбъект, Элемент, СтандартнаяОбработка,
		Новый ОписаниеОповещения("ЗакрытиеФормыВыбораОбъектаСервиса", ЭтотОбъект, Новый Структура));
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПослеЗаписиРаботаСНоменклатурой()
	
	РаботаСНоменклатуройКлиент.ПослеЗаписиФормаНоменклатурыПродолжение(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытиеФормыВыбораОбъектаСервиса(ДанныеОбъекта, ДополнительныеПараметры) Экспорт 
	
	РаботаСНоменклатуройКлиент.ОбработкаОповещенияЗакрытиеФормыВыбора(
		ДанныеОбъекта, ДополнительныеПараметры, ПодготовитьДанныеДляИнтерактивногоЗаполнения(),
		Новый ОписаниеОповещения("ЗакрытиеФормыЗаполненияОбъекта", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытиеФормыЗаполненияОбъекта(ПараметрыЗакрытияФормы, ДополнительныеПараметры) Экспорт 
	
	ЗаполнитьРеквизитыФормы(ПараметрыЗакрытияФормы);
	
КонецПроцедуры

&НаСервере
Функция ПодготовитьДанныеДляИнтерактивногоЗаполнения()
	
	Возврат РаботаСНоменклатурой.ПодготовитьДанныеДляИнтерактивногоЗаполнения(ЭтотОбъект);
			
КонецФункции

&НаСервере
Процедура ЗаполнитьРеквизитыФормы(ПараметрыЗакрытияФормы)
	
	РаботаСНоменклатурой.ЗаполнитьРеквизитыФормы(ЭтотОбъект, ПараметрыЗакрытияФормы);
				
КонецПроцедуры

// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой

// Обработчик команды, создаваемой механизмом запрета редактирования ключевых реквизитов.
//
&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	Если Не Объект.Ссылка.Пустая() Тогда
		ПараметрыФормы = Новый Структура("Ссылка", Объект.Ссылка);
		ОткрытьФорму("Справочник.Номенклатура.Форма.РазблокированиеРеквизитов", ПараметрыФормы,,,,,
					Новый ОписаниеОповещения("Подключаемый_РазрешитьРедактированиеРеквизитовОбъектаЗавершение", ЭтотОбъект),
					РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъектаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Массив") И Результат.Количество() > 0 Тогда
		ЗапретРедактированияРеквизитовОбъектовКлиент.УстановитьДоступностьЭлементовФормы(ЭтаФорма, Результат);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПросмотретьПрисоединенныйФайл(ИмяРеквизитаОбъекта, ИмяРеквизитаФормы, ТекстСообщенияОбОшибке)
	
	ОчиститьСообщения();
	
	Если ЗначениеЗаполнено(Объект[ИмяРеквизитаОбъекта]) Тогда
		РаботаСФайламиКлиент.ОткрытьФайл(
			РаботаСФайламиСлужебныйВызовСервера.ПолучитьДанныеФайла(
				ЭтаФорма.Объект[ИмяРеквизитаОбъекта],
				УникальныйИдентификатор));
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщенияОбОшибке,, ИмяРеквизитаФормы);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НавигационнаяСсылкаКартинки(ФайлКартинки, ИдентификаторФормы)
	
	УстановитьПривилегированныйРежим(Истина);
	
	ПараметрыДанныхФайла = РаботаСФайламиКлиентСервер.ПараметрыДанныхФайла();
	ПараметрыДанныхФайла.ИдентификаторФормы = ИдентификаторФормы;
	
	Попытка
		АдресКартинки = РаботаСФайлами.ДанныеФайла(ФайлКартинки, ПараметрыДанныхФайла).СсылкаНаДвоичныеДанныеФайла;
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		АдресКартинки = "";
	КонецПопытки;
	
	Возврат АдресКартинки;
	
КонецФункции

&НаКлиенте
Процедура ДобавитьИзображениеНаКлиенте()
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		ТекстВопроса = НСтр("ru='Для выбора изображения необходимо записать объект. Записать?'");
		Ответ = Неопределено;

		ПоказатьВопрос(Новый ОписаниеОповещения("ДобавитьИзображениеНаКлиентеЗавершение", ЭтотОбъект), ТекстВопроса, РежимДиалогаВопрос.ДаНет);
        Возврат;
		
	КонецЕсли;
	
	ДобавитьИзображениеНаКлиентеФрагмент();
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображениеНаКлиентеЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
    
    Ответ = РезультатВопроса;
    
    Если Ответ = КодВозвратаДиалога.Да Тогда
        Если Не Записать() Тогда
            Возврат;
        КонецЕсли;
    Иначе
        Возврат;
    КонецЕсли;
    
    
    ДобавитьИзображениеНаКлиентеФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображениеНаКлиентеФрагмент()
    
    Перем ИдентификаторФайла;
    
    ВыборИзображения   = Истина;
    ИдентификаторФайла = Новый УникальныйИдентификатор;
    
    РаботаСФайламиКлиент.ДобавитьФайлы(Объект.Ссылка, ИдентификаторФайла, НСтр("ru = 'Все картинки (*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf)|*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf"
		                            + "|Все файлы(*.*)|*.*"
		                            + "|Формат bmp(*.bmp*;*.dib;*.rle)|*.bmp;*.dib;*.rle"
		                            + "|Формат GIF(*.gif*)|*.gif"
		                            + "|Формат JPEG(*.jpeg;*.jpg)|*.jpeg;*.jpg"
		                            + "|Формат PNG(*.png*)|*.png"
		                            + "|Формат TIFF(*.tif)|*.tif"
		                            + "|Формат icon(*.ico)|*.ico"
		                            + "|Формат метафайл(*.wmf;*.emf)|*.wmf;*.emf'"));
    ВыборИзображения   = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображениеЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
    
    Ответ = РезультатВопроса;
    
    Если Ответ = КодВозвратаДиалога.Да Тогда
        Записать();
    Иначе 
        Возврат
    КонецЕсли;
    
    
    ДобавитьИзображениеФрагмент();

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьИзображениеФрагмент()
    
    ВыборИзображения = Истина;
    ИдентификаторФайла = Новый УникальныйИдентификатор;
    
    РаботаСФайламиКлиент.ДобавитьФайлы(Объект.Ссылка, ИдентификаторФайла,НСтр("ru = 'Все картинки (*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf)|*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf"
		                            + "|Все файлы(*.*)|*.*"
		                            + "|Формат bmp(*.bmp*;*.dib;*.rle)|*.bmp;*.dib;*.rle"
		                            + "|Формат GIF(*.gif*)|*.gif"
		                            + "|Формат JPEG(*.jpeg;*.jpg)|*.jpeg;*.jpg"
		                            + "|Формат PNG(*.png*)|*.png"
		                            + "|Формат TIFF(*.tif)|*.tif"
		                            + "|Формат icon(*.ico)|*.ico"
		                            + "|Формат метафайл(*.wmf;*.emf)|*.wmf;*.emf'"));
    ВыборИзображения = Ложь;

КонецПроцедуры

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
Процедура ВидНоменклатурыПриИзмененииНаСервере(ЗаполнениеПоИсточникуКопирования = Ложь)
	
	Справочники.Номенклатура.ЗаполнитьРеквизитыПоВидуНоменклатуры(Объект,,,ЗаполнениеПоИсточникуКопирования);
	
	Если ЗначениеЗаполнено(Объект.ВидНоменклатуры) Тогда
		Серии = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ВидНоменклатуры, "НастройкаИспользованияСерий");
	Иначе
		Серии = Неопределено;
	КонецЕсли;
	
	ОбновитьЭлементыДополнительныхРеквизитов();
	
	ОбработатьВидимостьСхемыОбеспечения();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПоПараметрам()
	
	Если Параметры.Свойство("Родитель") Тогда
		Объект.Родитель = Параметры.Родитель;
	КонецЕсли;
	
	Если Параметры.Свойство("ВидНоменклатуры") И Параметры.ВидНоменклатуры <> Неопределено Тогда
		Объект.ВидНоменклатуры = Параметры.ВидНоменклатуры;
		ВидНоменклатурыПриИзмененииНаСервере();
	КонецЕсли
			
КонецПроцедуры

&НаСервере
Процедура ПриСозданииЧтенииНаСервере()

	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатурой.ПерезаполнитьВстроенныеРеквизиты(ЭтотОбъект);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	
	Если ЗначениеЗаполнено(Объект.ФайлКартинки) Тогда
		АдресКартинки = НавигационнаяСсылкаКартинки(Объект.ФайлКартинки, УникальныйИдентификатор);
	КонецЕсли;
	
	ОбновитьЭлементыХарактеристикиНоменклатуры();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьЭлементыХарактеристикиНоменклатуры()
	
	ИспользоватьХарактеристики =
	    ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.ВидНоменклатуры, "ИспользоватьХарактеристики");
	
	
	ИндивидуальныеХарактеристикиНоменклатуры =
		Объект.ВидНоменклатуры.ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры;
		
	Если ИндивидуальныеХарактеристикиНоменклатуры Тогда 
		ИспользованиеХарактеристик = НСтр("ru = 'Индивидуальные для номенклатуры'");
		ВладелецХарактеристик      = Объект.Ссылка;
	Иначе
		ИспользованиеХарактеристик = НСтр("ru = 'Общие для вида номенклатуры'");
		ВладелецХарактеристик      = Объект.ВидНоменклатуры;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СкрытьРаскрытьВсеГруппы(Свернуть)
	
	ИменаСворачиваемыхГрупп = ИменаСворачиваемыхГрупп();
	
	Для Каждого ИмяГруппы Из ИменаСворачиваемыхГрупп Цикл
		
		ИзменитьСвернутостьГруппы(ИмяГруппы, Свернуть);
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ИзменитьСвернутостьГруппы(ИмяГруппы, Свернуть)
	
	ЭлементСворачиваемаяГруппа = Элементы["СворачиваемаяГруппа" + ИмяГруппы];
	
	Если Свернуть Тогда
		ЭлементСворачиваемаяГруппа.Скрыть();
	Иначе
		ЭлементСворачиваемаяГруппа.Показать();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ИменаСворачиваемыхГрупп()
	
	ИменаСворачиваемыхГрупп = Новый Массив;
	
	ИменаСворачиваемыхГрупп.Добавить("ОсновныеПараметрыУчета");
	ИменаСворачиваемыхГрупп.Добавить("ЕдиницыИзмерения");
	
	ИменаСворачиваемыхГрупп.Добавить("КартинкаОписание");
	ИменаСворачиваемыхГрупп.Добавить("ДополнительныеРеквизиты");
	ИменаСворачиваемыхГрупп.Добавить("СведенияОПроизводителе");
	
	ИменаСворачиваемыхГрупп.Добавить("ОбеспечениеИПроизводство");
	
	Возврат ИменаСворачиваемыхГрупп;
КонецФункции

&НаКлиенте
Процедура ГиперссылкаПерейтиСформироватьПараметрыИВопрос(ИмяЭлемента, Гиперссылка)
	
	ОчиститьСообщения();
	
	ПараметрыПереходаПоГиперссылке = ПараметрыПереходаПоГиперссылке(ИмяЭлемента, Гиперссылка);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка)
		Или Модифицированность Тогда
		
		ТекстВопроса = Нстр("ru = 'Данные еще не записаны.
                             |Переход к дополнительной информации возможен только после записи элемента.
                             |Записать элемент?'");
		
		ПоказатьВопрос(Новый ОписаниеОповещения("ГиперссылкаПерейтиВопросЗавершение", ЭтотОбъект, ПараметрыПереходаПоГиперссылке), ТекстВопроса, РежимДиалогаВопрос.ДаНет);
		Возврат;
		
	КонецЕсли;
	
	ГиперссылкаПерейти(ПараметрыПереходаПоГиперссылке);
	
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПерейтиВопросЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	Если РезультатВопроса <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ЭлементЗаписан = Записать();
	Исключение
		Возврат;
	КонецПопытки;
	
	Если Не ЭлементЗаписан Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыПереходаПоГиперссылке = ПараметрыПереходаПоГиперссылке(ДополнительныеПараметры.ИмяЭлемента,
																		ДополнительныеПараметры.Гиперссылка);
	ГиперссылкаПерейти(ПараметрыПереходаПоГиперссылке);
КонецПроцедуры

&НаКлиенте
Процедура ГиперссылкаПерейти(ПараметрыПереходаПоГиперссылке)
	
	Если ПараметрыПереходаПоГиперссылке.ИмяФормы <> Неопределено Тогда		
		ОткрытьФорму(ПараметрыПереходаПоГиперссылке.ИмяФормы,
			ПараметрыПереходаПоГиперссылке.ПараметрыФормы, , ЭтаФорма.УникальныйИдентификатор, , , ,
			ПараметрыПереходаПоГиперссылке.РежимОткрытияОкнаФормы);

	Иначе
		ТекстИсключения = НСтр("ru = 'Не определено действие по гиперссылке.'");
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ПараметрыПереходаПоГиперссылке(ИмяЭлемента, Гиперссылка)
	
	ПараметрыПереходаПоГиперссылке = Новый Структура("ИмяЭлемента, Гиперссылка, ИмяФормы, НавигационнаяСсылка, ИмяГруппы, ПараметрыФормы, РежимОткрытияОкнаФормы");
	ПараметрыПереходаПоГиперссылке.ИмяЭлемента = ИмяЭлемента;
	ПараметрыПереходаПоГиперссылке.Гиперссылка = Гиперссылка;
	
	Если ИмяЭлемента = "ГиперссылкаПерейтиХарактеристикиНоменклатуры" Тогда
		
		Отбор = Новый Структура;
		Отбор.Вставить("Владелец", Объект.Ссылка);
		ПараметрыФормы = Новый Структура("Отбор", Отбор);
		
		ПараметрыПереходаПоГиперссылке.ИмяФормы       = "Справочник.ХарактеристикиНоменклатуры.ФормаСписка";
		ПараметрыПереходаПоГиперссылке.ПараметрыФормы = ПараметрыФормы;
		
	ИначеЕсли ИмяЭлемента = "ГиперссылкаПерейтиНастройкаСпособовОбеспеченияПотребностей" Тогда
		
		Отбор = Новый Структура;
		Отбор.Вставить("Номенклатура", Объект.Ссылка);
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Отбор",	Отбор);
		ПараметрыФормы.Вставить("Источник",	"Номенклатура");
				
		ПараметрыПереходаПоГиперссылке.ИмяФормы       = "Обработка.НастройкаСпособовОбеспеченияПотребностей.Форма.Форма";
		ПараметрыПереходаПоГиперссылке.ПараметрыФормы = ПараметрыФормы;
		
	КонецЕсли;
	
	Если ПараметрыПереходаПоГиперссылке.РежимОткрытияОкнаФормы = Неопределено Тогда
		ПараметрыПереходаПоГиперссылке.РежимОткрытияОкнаФормы = РежимОткрытияОкнаФормы.Независимый;
	КонецЕсли;
	
	Возврат ПараметрыПереходаПоГиперссылке;
	
КонецФункции

&НаКлиенте
Процедура УстановитьДоступностьСерийХарактеристик()

	Если ЗначениеЗаполнено(Объект.ВидНоменклатуры) Тогда
		Если Элементы.Найти("ФормаСправочникСерииНоменклатурыСерии") <> Неопределено Тогда
			Элементы.Форматоро_Перейти.ПодчиненныеЭлементы.ФормаСправочникСерииНоменклатурыСерии.Доступность = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(Объект.ВидНоменклатуры, "ИспользоватьСерии");
		КонецЕсли;
		Если Элементы.Найти("ФормаСправочникХарактеристикиНоменклатурыОткрытьПоЗначению") <> Неопределено Тогда
			ИспользоватьХаракеристики_ВидНоменклатуры = торо_ОбщегоНазначенияВызовСервера.ЗначениеРеквизитаОбъекта(Объект.ВидНоменклатуры, "ИспользоватьХарактеристики");
			Элементы.Форматоро_Перейти.ПодчиненныеЭлементы.ФормаСправочникХарактеристикиНоменклатурыОткрытьПоЗначению.Доступность = ИспользоватьХаракеристики_ВидНоменклатуры;
			Элементы.ГиперссылкаПерейтиХарактеристикиНоменклатуры.Видимость = ИспользоватьХаракеристики_ВидНоменклатуры;
			Если ИспользоватьХаракеристики_ВидНоменклатуры Тогда
				СформироватьГиперссылкуХарактеристик();
			КонецЕсли;
		КонецЕсли;
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура СформироватьГиперссылкуХарактеристик()
	Если ПолучитьФункциональнуюОпцию("торо_ИспользоватьХарактеристикиНоменклатуры") Тогда 
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ХарактеристикиНоменклатуры.Ссылка) КАК Количество
		               |ИЗ
		               |	Справочник.ХарактеристикиНоменклатуры КАК ХарактеристикиНоменклатуры
		               |ГДЕ
		               |	ХарактеристикиНоменклатуры.Владелец = &ВладелецХарактеристики
		               |	И НЕ ХарактеристикиНоменклатуры.ПометкаУдаления";
		Если Объект.ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ИндивидуальныеДляНоменклатуры Тогда
			ВладелецХарактеристики = Объект.Ссылка;
		ИначеЕсли Объект.ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры Тогда
			ВладелецХарактеристики = Объект.ВидНоменклатуры;
		КонецЕсли;
		Запрос.УстановитьПараметр("ВладелецХарактеристики", ВладелецХарактеристики);
		Выборка = Запрос.Выполнить().Выбрать();
		Выборка.Следующий();
		ЗаголовокГиперссылки = Новый ФорматированнаяСтрока(НСтр("ru = 'Список'") + " (" + Выборка.Количество + ")",,,,"ХарактеристикиНоменклатуры");
		Элементы.ГиперссылкаПерейтиХарактеристикиНоменклатуры.Заголовок = ЗаголовокГиперссылки;	
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбработатьВидимостьСхемыОбеспечения()
	
	ЕстьПравоЧтения = ПравоДоступа("Чтение", Метаданные.Справочники.СхемыОбеспечения);
	Если ЕстьПравоЧтения
		И (Объект.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.Товар
			Или Объект.ТипНоменклатуры = Перечисления.ТипыНоменклатуры.МногооборотнаяТара) Тогда
	    Элементы.СворачиваемаяГруппаОбеспечениеИПроизводство.Видимость = Истина;
	Иначе
		Элементы.СворачиваемаяГруппаОбеспечениеИПроизводство.Видимость = Ложь;
		Объект.СхемаОбеспечения = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
