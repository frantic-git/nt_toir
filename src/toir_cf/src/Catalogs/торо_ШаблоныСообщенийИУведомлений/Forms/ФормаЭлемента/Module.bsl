
#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ДобавитьКомандыТегов();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура кнДобавитьТегНажатие(Команда)
	
	Если ЭтаФорма.ТекущийЭлемент = Элементы.ТемаПисьма
		Или ЭтаФорма.ТекущийЭлемент = Элементы.ТелоПисьма Тогда
		
		ИмяТега = "%" + Команда.Имя + "%";
		ЭтаФорма.ТекущийЭлемент.ВыделенныйТекст = ИмяТега;
		
	КонецЕсли;
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
&НаСервере
Процедура ДобавитьКомандыТегов()
	
	ДобавитьКоманду("Номер"                           , Элементы.ГруппаДокументы);
	ДобавитьКоманду("Дата"                            , Элементы.ГруппаДокументы);
	ДобавитьКоманду("Ответственный"                   , Элементы.ГруппаДокументы);
	ДобавитьКоманду("Комментарий"                   , Элементы.ГруппаДокументы);
	
	ДобавитьКоманду("Согласующий"                    , Элементы.ГруппаСогласование);
	ДобавитьКоманду("СтатусДокумента"                , Элементы.ГруппаСогласование);
	ДобавитьКоманду("ПредыдущийСтатусДокумента"      , Элементы.ГруппаСогласование);
	ДобавитьКоманду("СледующийСтатусДокумента"       , Элементы.ГруппаСогласование);
	
	ДобавитьКоманду("ОбъектРемонта"				  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("Показатель"					  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("ЗначениеПоказателя"			  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("ЕдиницаИзмеренияПоказателя" 	  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("УсловиеУведомления" 			  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("Значение" 					  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("ГраницаИнтервала" 			  , Элементы.ГруппаПоПараметрамУведомлений);
	ДобавитьКоманду("КритическиеЗначенияПоказателей" , Элементы.ГруппаПоПараметрамУведомлений);
	
	ДобавитьКоманду("ОбъектРемонта"				  , Элементы.ГруппаПоСобытиямДокумента);
	ДобавитьКоманду("ЗначенияПоказателейОбъектовРемонта" , Элементы.ГруппаПоСобытиямДокумента);
	
	ДобавитьКоманду("Адресат"                        , Элементы.ГруппаОбщие);
	
	ДобавитьКоманду("ДефектныеОбъектыРемонта"        , Элементы.ГруппаВыявленныеДефекты);
	ДобавитьКоманду("ДефектныеОбъектыРемонтаСОписаниемИПоследствиями"        , Элементы.ГруппаВыявленныеДефекты);
	
	ДобавитьКоманду("ОписанияДефектов", Элементы.ГруппаЗаявка);
	ДобавитьКоманду("ОбъектРемонта", Элементы.ГруппаЗаявка);

	ДобавитьКоманду("СобытиеПодпискиИТС", Элементы.ГруппаПодпискиИТС);
	ДобавитьКоманду("ДатаОкончанияПодпискиИТС", Элементы.ГруппаПодпискиИТС);
	ДобавитьКоманду("ДнейДоОкончанияПодпискиИТС", Элементы.ГруппаПодпискиИТС);
	
	ДобавитьКоманду("ОбъектРемонта", Элементы.ГруппаФункциональныеМеста);
	ДобавитьКоманду("ФункциональноеМесто", Элементы.ГруппаФункциональныеМеста);
	ДобавитьКоманду("СтруктураИерархии", Элементы.ГруппаПроверкаТребованийПоДокументам);
	ДобавитьКоманду("Ограничение", Элементы.ГруппаПроверкаТребованийПоДокументам);
	
	Если Константы.торо_ИспользоватьУтверждениеЗаказовНаВнутреннееПотребление.Получить() Тогда
		ДобавитьКоманду("СтатусУтверждения", Элементы.ГруппаУтверждениеЗаказовНаВП);
		ДобавитьКоманду("КомментарииКУтверждению", Элементы.ГруппаУтверждениеЗаказовНаВП);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьКоманду (ИмяКоманды, Группа)
	НовКнопкаМеню = Элементы.Добавить(Группа.Имя + ИмяКоманды, Тип("КнопкаФормы"), Группа);
	НовКнопкаМеню.Вид        = ВидКнопкиФормы.КнопкаКоманднойПанели;
	НовКнопкаМеню.Заголовок  = "%" + ИмяКоманды + "%";

	Если ЭтаФорма.Команды.Найти(ИмяКоманды) = Неопределено Тогда
		НовКоманда = ЭтаФорма.Команды.Добавить(ИмяКоманды);
		НовКоманда.Действие      = "кнДобавитьТегНажатие";
		НовКоманда.Заголовок     = "%"+ ИмяКоманды +"%";
	КонецЕсли;
	
	НовКнопкаМеню.ИмяКоманды = ИмяКоманды;	
КонецПроцедуры

#КонецОбласти
