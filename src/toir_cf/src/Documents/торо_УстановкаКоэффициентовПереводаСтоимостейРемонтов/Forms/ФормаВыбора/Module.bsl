
#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура СоздатьДляОбъектовРемонта(Команда)
	ОткрытьФорму("Документ.торо_УстановкаКоэффициентовПереводаСтоимостейРемонтов.ФормаОбъекта", Новый Структура("ВидОперации", ПредопределенноеЗначение("Перечисление.торо_ВидыДокументаВводНачДанных.ПоОбъектуРемонта")), ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДляСписковОбъектов(Команда)
	ОткрытьФорму("Документ.торо_УстановкаКоэффициентовПереводаСтоимостейРемонтов.ФормаОбъекта", Новый Структура("ВидОперации", ПредопределенноеЗначение("Перечисление.торо_ВидыДокументаВводНачДанных.ПоСпискуОбъектовРемонта")), ЭтаФорма);
КонецПроцедуры
#КонецОбласти
