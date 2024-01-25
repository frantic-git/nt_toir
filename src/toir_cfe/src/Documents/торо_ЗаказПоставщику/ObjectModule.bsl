
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий 

&После("ОбработкаПроведения")
Процедура проф_ОбработкаПроведения(Отказ, РежимПроведения)
	
	//++ Проф-ИТ, #82, Иванова Е.С., 18.09.2023
	Движения.проф_ЗаказыПоставщику.Записывать = Истина;
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	торо_ЗаказПоставщикуТовары.Номенклатура КАК Номенклатура,
				   |	торо_ЗаказПоставщикуТовары.проф_Назначение КАК Назначение,
	               |	торо_ЗаказПоставщикуТовары.Характеристика КАК Характеристика,
	               |	СУММА(торо_ЗаказПоставщикуТовары.Количество) КАК Количество,
	               |	торо_ЗаказПоставщикуТовары.Склад КАК Склад
	               |ИЗ
	               |	Документ.торо_ЗаказПоставщику.Товары КАК торо_ЗаказПоставщикуТовары
	               |ГДЕ
	               |	торо_ЗаказПоставщикуТовары.Ссылка = &Ссылка
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	торо_ЗаказПоставщикуТовары.Номенклатура,
				   |	торо_ЗаказПоставщикуТовары.проф_Назначение,
	               |	торо_ЗаказПоставщикуТовары.Характеристика,
	               |	торо_ЗаказПоставщикуТовары.Склад";
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		Движение = Движения.проф_ЗаказыПоставщику.ДобавитьПриход();
		Движение.Период = Дата;
		Движение.Склад = Склад;
		Движение.ЗаказПоставщику = Ссылка;
		Движение.ДатаПоставки = ДатаПоставки;
		ЗаполнитьЗначенияСвойств(Движение, Выборка);		
	КонецЦикла;		
	//-- Проф-ИТ, #82, Иванова Е.С., 18.09.2023
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли