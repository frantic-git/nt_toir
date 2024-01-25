#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ТекущаяИерархия = торо_ОтчетыСервер.ПолучитьЗначениеСтруктурыИерархии(КомпоновщикНастроек);
	
	торо_ОтчетыСервер.УстановитьЗапросыНаборовДанныхИерархииОР(СхемаКомпоновкиДанных, ТекущаяИерархия, "ДатаОкончания");
	торо_ОтчетыСервер.УстановитьПолеОбъектИерархии(СхемаКомпоновкиДанных.НаборыДанных.Объекты.Запрос, "ОбъединенныеДанные.ОбъектРемонта", ТекущаяИерархия);
	торо_ОтчетыСервер.УстановитьТипГруппировкиОбъектаИерархии(КомпоновщикНастроек, ТекущаяИерархия);
	
	НастроитьДополнениеПериодичности(КомпоновщикНастроек.Настройки);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Настройки общей формы отчета подсистемы "Варианты отчетов".
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   КлючВарианта - Строка - Имя предопределенного варианта отчета или уникальный идентификатор пользовательского.
//   Настройки - Структура - см. возвращаемое значение ФункцииОтчетовКлиентСервер.ПолучитьНастройкиОтчетаПоУмолчанию().
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	Настройки.События.ПриЗагрузкеПользовательскихНастроекНаСервере = Истина;
	Настройки.События.ПриЗагрузкеВариантаНаСервере 						= Истина;
	Настройки.События.ПриСозданииНаСервере 								= Истина;
	
	Настройки.ЗагрузитьНастройкиПриИзмененииПараметров = ЗагрузитьНастройкиПриИзмененииПараметров();

КонецПроцедуры

Процедура ПриЗагрузкеПользовательскихНастроекНаСервере(Форма, НовыеПользовательскиеНастройкиКД) Экспорт
	
	ПользовательскиеНастройкиЭлементы = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
	НастройкиКомпоновщика = КомпоновщикНастроек.Настройки;
	ПрименитьФункциональныеОпцииКНастройкам(ПользовательскиеНастройкиЭлементы, НастройкиКомпоновщика, Форма);
	
КонецПроцедуры

Процедура ПриЗагрузкеВариантаНаСервере(Форма, НовыеПользовательскиеНастройкиКД) Экспорт
	
	ПользовательскиеНастройкиЭлементы = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
	НастройкиКомпоновщика = КомпоновщикНастроек.Настройки;
	ПрименитьФункциональныеОпцииКНастройкам(ПользовательскиеНастройкиЭлементы, НастройкиКомпоновщика, Форма);
	
КонецПроцедуры

Процедура ПрименитьФункциональныеОпцииКНастройкам(ПользовательскиеНастройкиЭлементы, НастройкиКомпоновщика, Форма)
	
	// Сделать привязку между выводимыми данными в отчете и ФО в системе:
	// 1. Флаг "По дефектам" - ФО "Учет выявленных дефектов";
	// 2. Флаг "По ППР" - ФО "Использовать ППР";
	// 3. Флаг "По предписаниям" - ФО "Использовать внешние основания для работ";
	// 4. Флаг "По регламентным мероприятиям" - ФО "Использовать регламентные мероприятия";
	// 5. Флаг "Затраты по запчастям" - ФО "Учет запчастей".

	ФО_УчетДефектов = ПолучитьФункциональнуюОпцию("торо_УчетВыявленныхДефектовОборудования");
	ФО_ИспользоватьППР = ПолучитьФункциональнуюОпцию("торо_ИспользоватьППР");
	ФО_ИспользоватьВнешниеОснования = ПолучитьФункциональнуюОпцию("торо_ИспользоватьВнешниеОснованияДляРабот");
	ФО_ИспользоватьРегламентныеМероприятия = ПолучитьФункциональнуюОпцию("торо_ИспользоватьРегламентныеМероприятия");
	ФО_УчетЗапчастей = ПолучитьФункциональнуюОпцию("торо_УчетЗапчастей");
	
	Для каждого Элемент Из ПользовательскиеНастройкиЭлементы Цикл
		Если ТипЗнч(Элемент) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") Тогда
			Если Строка(Элемент.Параметр) = "ПоДефектам" И Не ФО_УчетДефектов Тогда
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			ИначеЕсли Строка(Элемент.Параметр) = "ПоППР" И Не ФО_ИспользоватьППР Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			ИначеЕсли Строка(Элемент.Параметр) = "ПоПредписаниям" И Не ФО_ИспользоватьВнешниеОснования Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			ИначеЕсли Строка(Элемент.Параметр) = "ПоРегламентнымМероприятиям" И Не ФО_ИспользоватьРегламентныеМероприятия Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			ИначеЕсли Строка(Элемент.Параметр) = "ЗатратыПоЗапчастям" И Не ФО_УчетЗапчастей Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт

	ФО_УчетДефектов = ПолучитьФункциональнуюОпцию("торо_УчетВыявленныхДефектовОборудования");
	ФО_ИспользоватьППР = ПолучитьФункциональнуюОпцию("торо_ИспользоватьППР");
	ФО_ИспользоватьВнешниеОснования = ПолучитьФункциональнуюОпцию("торо_ИспользоватьВнешниеОснованияДляРабот");
	ФО_ИспользоватьРегламентныеМероприятия = ПолучитьФункциональнуюОпцию("торо_ИспользоватьРегламентныеМероприятия");
	ФО_УчетЗапчастей = ПолучитьФункциональнуюОпцию("торо_УчетЗапчастей");

	Если ЭтоАдресВременногоХранилища(Форма.НастройкиОтчета.АдресСхемы) Тогда
		СКД = ПолучитьИзВременногоХранилища(Форма.НастройкиОтчета.АдресСхемы);
		
		Параметр = СКД.Параметры.Найти("ПоДефектам");
		Если Параметр <> Неопределено И Не ФО_УчетДефектов Тогда
			Параметр.Значение = Ложь;
			Параметр.ОграничениеИспользования = Истина;
		КонецЕсли;
		
		Параметр = СКД.Параметры.Найти("ПоППР");
		Если Параметр <> Неопределено И Не ФО_ИспользоватьППР Тогда
			Параметр.Значение = Ложь;
			Параметр.ОграничениеИспользования = Истина;
		КонецЕсли;

		Параметр = СКД.Параметры.Найти("ПоПредписаниям");
		Если Параметр <> Неопределено И Не ФО_ИспользоватьВнешниеОснования Тогда
			Параметр.Значение = Ложь;
			Параметр.ОграничениеИспользования = Истина;
		КонецЕсли;

		Параметр = СКД.Параметры.Найти("ПоРегламентнымМероприятиям");
		Если Параметр <> Неопределено И Не ФО_ИспользоватьРегламентныеМероприятия Тогда
			Параметр.Значение = Ложь;
			Параметр.ОграничениеИспользования = Истина;
		КонецЕсли;
		
		Параметр = СКД.Параметры.Найти("ЗатратыПоЗапчастям");
		Если Параметр <> Неопределено И Не ФО_УчетЗапчастей Тогда
			Параметр.Значение = Ложь;
			Параметр.ОграничениеИспользования = Истина;
		КонецЕсли;

		Форма.НастройкиОтчета.АдресСхемы = ПоместитьВоВременноеХранилище(СКД, Форма.НастройкиОтчета.АдресСхемы);
		Форма.НастройкиОтчета.СхемаМодифицирована = Истина;
	КонецЕсли;
	
КонецПроцедуры

Функция ЗагрузитьНастройкиПриИзмененииПараметров()  
	
	Параметры = Новый Массив;
	Параметры.Добавить(Новый ПараметрКомпоновкиДанных("ИерархияТип"));	
	Возврат Параметры;
	
КонецФункции

Процедура НастроитьДополнениеПериодичности(НастройкиСхемы)
	
	Для Каждого ЭлементНастройки Из НастройкиСхемы.Структура Цикл
		Если ТипЗнч(ЭлементНастройки) = Тип("ТаблицаКомпоновкиДанных") Тогда
			Для Каждого Колонка Из ЭлементНастройки.Колонки Цикл
				Если Колонка.Имя = "Детализация" Тогда
					ПолеГруппировки = Колонка.ПоляГруппировки.Элементы[0];
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Если ПолеГруппировки <> Неопределено Тогда
		ЭлементыПользовательскихНастроек = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
		ЭлементыПараметрыДанных = НастройкиСхемы.ПараметрыДанных.Элементы;
		
		ПараметрПериодичностьОтчета = ЭлементыПараметрыДанных.Найти("Периодичность");
		СтрокаПараметрПериодичность = ЭлементыПользовательскихНастроек.Найти(ПараметрПериодичностьОтчета.ИдентификаторПользовательскойНастройки);
		Если СтрокаПараметрПериодичность <> Неопределено Тогда
			ЗначениеПериодичности = СтрокаПараметрПериодичность.Значение;
			Если ЗначениеПериодичности = Перечисления.Периодичность.День Тогда
				ПолеГруппировки.ТипДополнения = ТипДополненияПериодаКомпоновкиДанных.День;
			ИначеЕсли ЗначениеПериодичности = Перечисления.Периодичность.Неделя Тогда
				ПолеГруппировки.ТипДополнения = ТипДополненияПериодаКомпоновкиДанных.Неделя;
			ИначеЕсли ЗначениеПериодичности = Перечисления.Периодичность.Месяц Тогда
				ПолеГруппировки.ТипДополнения = ТипДополненияПериодаКомпоновкиДанных.Месяц;
			ИначеЕсли ЗначениеПериодичности = Перечисления.Периодичность.Квартал Тогда
				ПолеГруппировки.ТипДополнения = ТипДополненияПериодаКомпоновкиДанных.Квартал;
			ИначеЕсли ЗначениеПериодичности = Перечисления.Периодичность.Год Тогда
				ПолеГруппировки.ТипДополнения = ТипДополненияПериодаКомпоновкиДанных.Год;
			КонецЕсли;
		КонецЕсли;
		
		ПараметрПериодОтчета = ЭлементыПараметрыДанных.Найти("ПериодОтчета");
		СтрокаПараметрПериод = ЭлементыПользовательскихНастроек.Найти(ПараметрПериодОтчета.ИдентификаторПользовательскойНастройки);
		Если СтрокаПараметрПериод <> Неопределено И СтрокаПараметрПериод.Использование Тогда
			ЗначениеПараметраПериод = СтрокаПараметрПериод.Значение; 
			ПолеГруппировки.НачалоПериода = ЗначениеПараметраПериод.ДатаНачала;
			ПолеГруппировки.КонецПериода = ЗначениеПараметраПериод.ДатаОкончания;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли

