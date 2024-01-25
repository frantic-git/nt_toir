#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ТекЭлемент = ПараметрыВыполненияКоманды.Источник.ТекущийЭлемент;
	
	Если ТипЗнч(ТекЭлемент) = Тип("ТаблицаФормы") Тогда
		ПараметрКоманды = ТекЭлемент.ТекущиеДанные.Ссылка;
	Иначе
		Возврат;
	КонецЕсли;
	
	КлючЗаписи = ПолучитьКлючЗаписиПоИсточнику(ПараметрКоманды);
	Если КлючЗаписи <> Неопределено Тогда
		ПараметрыФормы = Новый Структура("Ключ", КлючЗаписи);
	Иначе
		ПараметрыФормы = Новый Структура("Источник", ПараметрКоманды);		
	КонецЕсли;
	ОткрытьФорму("РегистрСведений.НапоминанияПользователя.Форма.Напоминание", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьКлючЗаписиПоИсточнику(Источник)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	НапоминанияПользователя.Пользователь,
	|	НапоминанияПользователя.ВремяСобытия,
	|	НапоминанияПользователя.Источник
	|ИЗ
	|	РегистрСведений.НапоминанияПользователя КАК НапоминанияПользователя
	|ГДЕ
	|	НапоминанияПользователя.Пользователь = &Пользователь
	|	И НапоминанияПользователя.Источник = &Источник";
	
	Запрос.УстановитьПараметр("Пользователь", Пользователи.ТекущийПользователь());
	Запрос.УстановитьПараметр("Источник", Источник);
	
	Запрос.Текст = ТекстЗапроса;
	Выборка = Запрос.Выполнить().Выбрать();
	
	ПараметрыНапоминания = Новый Структура("Пользователь,Источник,ВремяСобытия");
	
	Результат = Неопределено;
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ПараметрыНапоминания, Выборка);
		Результат = РегистрыСведений.НапоминанияПользователя.СоздатьКлючЗаписи(ПараметрыНапоминания);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
КонецФункции
#КонецОбласти