//@strict-types

#Область СлужебныйПрограммныйИнтерфейс

// Отправляет данные абонента в сервис настроек.
// 
// Параметры:
// 	ИдентификаторУчетнойЗаписи - Строка
// 	ОписаниеОповещения - ОписаниеОповещения - содержит описание процедуры, которая будет вызвана после отправки данных
// 	                     со следующими параметрами:
// 	                     Результат - см. СервисНастроекЭДО.ОтправитьДанныеАбонентаВСервисНастроек
// 	                     ДополнительныеПараметры - Произвольный - значение, которое было указано при создании 
// 	                     объекта ОписаниеОповещения.
// 	Форма - ФормаКлиентскогоПриложения - форма, во временное хранилище которой надо поместить результат
// выполнения процедуры.
Процедура ОтправитьДанныеАбонентаВСервисНастроек(ИдентификаторУчетнойЗаписи, ОписаниеОповещения, Форма = Неопределено) Экспорт
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Форма);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ПараметрыОжидания.ОповещениеПользователя.Показать = Ложь;
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	
	ИдентификаторФормы = ?(Форма = Неопределено, Новый УникальныйИдентификатор(), Форма.УникальныйИдентификатор);
	ДлительнаяОперация = СервисНастроекЭДОВызовСервера.НачатьОтправкуДанныхАбонентаВСервисНастроек(
		ИдентификаторУчетнойЗаписи, ИдентификаторФормы);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация,
		ОписаниеОповещения,
		ПараметрыОжидания);
		
КонецПроцедуры

#КонецОбласти