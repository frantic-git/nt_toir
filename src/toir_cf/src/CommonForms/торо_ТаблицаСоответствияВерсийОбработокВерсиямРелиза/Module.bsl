#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ТаблицаСоответствийВерсий.Загрузить(торо_РасчетППР.ПолучитьТаблицуСоответствияВерсийОбработокРелизам());
	ВерсияТОиР = ОбновлениеИнформационнойБазы.ВерсияИБ("ТехническоеОбслуживаниеИРемонты3");
	
	Попытка
	ВерсияППР = торо_СЛКСервер.Версия_Session("торо_ЗащитаУправлениеРемонтами83");
	Исключение
		ТекстСообщения = НСтр("ru = 'Не удалось определить текущую версию обработки расчета ППР!'");
		ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
	КонецПопытки;		
		
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.ТаблицаСоответствийВерсий.ВыделенныеСтроки.Очистить();
		
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаСоответствийВерсий

&НаКлиенте
Процедура ТаблицаСоответствийВерсийПриИзменении(Элемент)
	
	Если Элемент.ПодчиненныеЭлементы.ТаблицаСоответствийВерсийВерсияРелиза.ТекстРедактирования = ВерсияТОиР Тогда
		Элемент.ПодчиненныеЭлементы.ТаблицаСоответствийВерсийВерсияРелиза.ЦветФона = WebЦвета.ГолубойСоСтальнымОттенком;
	ИначеЕсли Элемент.ПодчиненныеЭлементы.ТаблицаСоответствийВерсийВерсияОбработки.ТекстРедактирования = ВерсияППР Тогда
		Элемент.ПодчиненныеЭлементы.ТаблицаСоответствийВерсийВерсияОбработки.ЦветФона = WebЦвета.ГолубойСоСтальнымОттенком;
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти