#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий
Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("РаботаВАвтономномРежиме") Тогда
		ВызватьИсключение НСтр("ru = 'Изменение классификатора ОКОФ в режиме ""Автономного рабочего места"" запрещено'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
#КонецЕсли