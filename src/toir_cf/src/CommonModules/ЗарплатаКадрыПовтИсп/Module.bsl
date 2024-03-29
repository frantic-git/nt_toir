
#Область СлужебныеПроцедурыИФункции

// Возвращает коллекцию элементов справочника ВидыКонтактнойИнформации с типом Адрес.
//
Функция ВидыРоссийскихАдресов() Экспорт
	
	РоссийскиеАдреса = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВидыКонтактнойИнформации.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ВидыКонтактнойИнформации КАК ВидыКонтактнойИнформации
		|ГДЕ
		|	ВидыКонтактнойИнформации.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Адрес)
		|	И ВидыКонтактнойИнформации.ТолькоНациональныйАдрес";
		
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		РоссийскиеАдреса.Вставить(Выборка.Ссылка, Истина);
	КонецЦикла; 
	
	Возврат РоссийскиеАдреса;
	
КонецФункции

#КонецОбласти
