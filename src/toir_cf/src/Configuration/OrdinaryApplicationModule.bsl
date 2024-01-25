
// СтандартныеПодсистемы

#Область ОписаниеПеременных

// Хранилище глобальных переменных.
//
// ПараметрыПриложения - Соответствие - хранилище переменных, где:
//   * Ключ - Строка - имя переменной в формате "ИмяБиблиотеки.ИмяПеременной";
//   * Значение - Произвольный - значение переменной.
//
// Инициализация (на примере СообщенияДляЖурналаРегистрации):
//   ИмяПараметра = "СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации";
//   Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
//     ПараметрыПриложения.Вставить(ИмяПараметра, Новый СписокЗначений);
//   КонецЕсли;
//  
// Использование (на примере СообщенияДляЖурналаРегистрации):
//   ПараметрыПриложения["СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации"].Добавить(...);
//   ПараметрыПриложения["СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации"] = ...;
Перем ПараметрыПриложения Экспорт; // Хранилище глобальных переменных.

#КонецОбласти

// Конец СтандартныеПодсистемы


#Область ОбработчикиСобытий

Процедура ПередНачаломРаботыСистемы()
	
	// СтандартныеПодсистемы
	СтандартныеПодсистемыКлиент.ПередНачаломРаботыСистемы();
	// Конец СтандартныеПодсистемы
	
	// ИнтернетПоддержкаПользователей
	ИнтернетПоддержкаПользователейКлиент.ПередНачаломРаботыСистемы();
	// Конец ИнтернетПоддержкаПользователей
	
КонецПроцедуры

Процедура ПриНачалеРаботыСистемы()
	
	// СтандартныеПодсистемы
	СтандартныеПодсистемыКлиент.ПриНачалеРаботыСистемы();
	// Конец СтандартныеПодсистемы
	
КонецПроцедуры

Процедура ПередЗавершениемРаботыСистемы(Отказ, ТекстПредупреждения)
	
	// СтандартныеПодсистемы
	СтандартныеПодсистемыКлиент.ПередЗавершениемРаботыСистемы(Отказ, ТекстПредупреждения);
	// Конец СтандартныеПодсистемы
	
КонецПроцедуры

#КонецОбласти