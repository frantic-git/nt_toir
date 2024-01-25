#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
	
	Элементы.Список.РежимВыбора = Параметры.РежимВыбора;
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	РаботаСНоменклатурой.ПриСозданииНаСервереФормаСпискаВидаНоменклатуры(ЭтотОбъект, ЭтотОбъект.КоманднаяПанель);
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	Если ИмяСобытия = РаботаСНоменклатуройКлиент.ОписаниеОповещенийПодсистемы().ЗагрузкаКатегорий Тогда
		Если Параметр.Количество() > 0 Тогда
			Элементы.Список.ТекущаяСтрока = Параметр[0];
		КонецЕсли;
	КонецЕсли;
	// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// ЭлектронноеВзаимодействие.РаботаСНоменклатурой

&НаКлиенте
Процедура Подключаемый_ПодобратьКатегорииИзСервиса(Команда)
		
	РаботаСНоменклатуройКлиент.ПодобратьКатегорииИзСервиса(ЭтотОбъект);
	
КонецПроцедуры

// Конец ЭлектронноеВзаимодействие.РаботаСНоменклатурой

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Элементы.Список);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
	ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры
 
&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Элементы.Список);
КонецПроцедуры
 
&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Элементы.Список);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодЁ	ключаемыеКоманды

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

#КонецОбласти
