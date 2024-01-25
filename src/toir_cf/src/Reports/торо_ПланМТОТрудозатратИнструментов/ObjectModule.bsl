#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПЕРЕМЕННЫЕ

Перем ИспользоватьРегламентныеМероприятия;
Перем ИспользоватьППР;                    
Перем ИспользоватьДефекты;               
Перем ИспользоватьВнешниеОснования;       
Перем ИспользоватьСметы;                  

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	Если НЕ слкМенеджерЗащиты.ПроверитьЛицензиюСеанса("28DD") И НЕ слкМенеджерЗащиты.ПроверитьЛицензиюСеанса("5DD5") Тогда
		ТекстОшибки = НСтр("ru='Лицензия не обнаружена! Формирование отчета невозможно.'");
		ВызватьИсключение ТекстОшибки;
	КонецЕсли;
	
	ТекущаяИерархия = торо_ОтчетыСервер.ПолучитьЗначениеСтруктурыИерархии(КомпоновщикНастроек);
	
	торо_ОтчетыСервер.УстановитьЗапросыНаборовДанныхИерархииОР(СхемаКомпоновкиДанных, ТекущаяИерархия, "ОкончаниеПериода");
	торо_ОтчетыСервер.УстановитьПолеОбъектИерархии(СхемаКомпоновкиДанных.НаборыДанных.Объекты.Запрос, "ВТ_Итог.ОбъектРемонта", ТекущаяИерархия);
	торо_ОтчетыСервер.УстановитьТипГруппировкиОбъектаИерархии(КомпоновщикНастроек, ТекущаяИерархия);
	
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
	Настройки.События.ПриЗагрузкеВариантаНаСервере = Истина;
	Настройки.События.ПослеЗаполненияПанелиБыстрыхНастроек = Истина;
	Настройки.ЗагрузитьНастройкиПриИзмененииПараметров = ЗагрузитьНастройкиПриИзмененииПараметров();
КонецПроцедуры

Процедура ПриЗагрузкеПользовательскихНастроекНаСервере(Форма, НовыеПользовательскиеНастройкиКД) Экспорт
	
	ПользовательскиеНастройкиЭлементы = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;
	ПрименитьФункциональныеОпцииКНастройкам(ПользовательскиеНастройкиЭлементы);
	Если Форма.КлючТекущегоВарианта = "ПланМТО" Тогда
		Форма.ОтчетНаименованиеТекущегоВарианта = "План МТО: таблица";
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗагрузкеВариантаНаСервере(Форма, НовыеПользовательскиеНастройкиКД) Экспорт
	
	ПользовательскиеНастройкиЭлементы = КомпоновщикНастроек.ПользовательскиеНастройки.Элементы;	
	ПрименитьФункциональныеОпцииКНастройкам(ПользовательскиеНастройкиЭлементы);
	
КонецПроцедуры

Процедура ПрименитьФункциональныеОпцииКНастройкам(ПользовательскиеНастройкиЭлементы)

	Для каждого Элемент Из ПользовательскиеНастройкиЭлементы Цикл
		Если ТипЗнч(Элемент) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") Тогда
			Если (Строка(Элемент.Параметр) = "УчитыватьППР"
				И Не ИспользоватьППР)Тогда
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
				Продолжить;
			ИначеЕсли (Строка(Элемент.Параметр) = "УчитыватьРегламентныеМероприятия"
				И Не ИспользоватьРегламентныеМероприятия) Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
				Продолжить;
			ИначеЕсли (Строка(Элемент.Параметр) = "УчитыватьСметыПоДефектам"
				И Не ИспользоватьДефекты
				И Не ИспользоватьСметы ) Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
				Продолжить;
			ИначеЕсли (Строка(Элемент.Параметр) = "УчитыватьСметыПоВнешнимОснованиям"
				И Не ИспользоватьВнешниеОснования
				И Не ИспользоватьСметы ) Тогда 
				Элемент.Значение      = Ложь;
				Элемент.Использование = Ложь;
				Элемент.РежимОтображения = РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный;
			КонецЕсли; 
		КонецЕсли;
	КонецЦикла; 
	
КонецПроцедуры

Процедура ПослеЗаполненияПанелиБыстрыхНастроек(Форма, ПараметрыЗаполнения) Экспорт
	
	Если Найти(Форма.ИмяФормы,"НастройкиОтчета") > 0  Тогда
		
		ЭлементыФормы = Форма.Элементы;
		ЭлементГруппаГлавное = ЭлементыФормы.Найти("ОбычныеОтборы");
		Если Не ЭлементГруппаГлавное = Неопределено Тогда
			ЭлементГруппаГлавное.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
		КонецЕсли; 
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьЗначениеФО(НаименованиеФО) Экспорт
	
	Возврат ПолучитьФункциональнуюОпцию(НаименованиеФО);
	
КонецФункции

Функция ЗагрузитьНастройкиПриИзмененииПараметров()  
	
	Параметры = Новый Массив;
	Параметры.Добавить(Новый ПараметрКомпоновкиДанных("ИерархияТип"));	
	Возврат Параметры;
	
КонецФункции

ИспользоватьРегламентныеМероприятия = ПолучитьЗначениеФО("торо_ИспользоватьРегламентныеМероприятия");
ИспользоватьППР                     = ПолучитьЗначениеФО("торо_ИспользоватьППР");
ИспользоватьДефекты                 = ПолучитьЗначениеФО("торо_УчетВыявленныхДефектовОборудования");
ИспользоватьВнешниеОснования        = ПолучитьЗначениеФО("торо_ИспользоватьВнешниеОснованияДляРабот");
ИспользоватьСметы                   = ПолучитьЗначениеФО("торо_ИспользоватьСметыРемонта");


#КонецОбласти

#КонецЕсли