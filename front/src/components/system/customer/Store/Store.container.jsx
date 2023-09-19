import Store from './Store.jsx'
import { useNavigate } from 'react-router'
import { useState } from 'react'

const StoreContainer = (props) => {
    const [description,setDescription] = useState(
        {
            name:"Магазин 'Стиль и Комфорт'",
            description:"Магазин 'Стиль и Комфорт'\n\nМагазин 'Стиль и Комфорт' - это пространство, где каждый посетитель сможет найти все необходимое для создания уютной и модной обстановки в своем доме. Этот уникальный магазин предлагает широкий ассортимент товаров, которые сочетают в себе стиль и практичность.При входе в магазин 'Стиль и Комфорт' посетителя окутывает атмосфера уюта и гармонии. Просторный и элегантно оформленный интерьер создает приятное впечатление и позволяет легко ориентироваться среди различных отделов. На полках магазина представлены предметы мебели, текстильные изделия, декоративные элементы, освещение и аксессуары для дома. Здесь можно найти все, начиная от удобных и стильных диванов и кресел до качественного постельного белья и пушистых ковров. Команда опытных консультантов всегда готова помочь посетителям с выбором товара, предложить профессиональные рекомендации и ответить на все вопросы. Они всегда в курсе последних тенденций в дизайне интерьера и готовы поделиться своими знаниями с клиентами. Магазин 'Стиль и Комфорт' предлагает не только качественные товары, но и доступные цены. Здесь каждый сможет найти что-то подходящее для своего бюджета и вкуса. Постоянные акции и скидки делают покупки еще более выгодными. Посещение магазина 'Стиль и Комфорт' станет настоящим вдохновением для создания уютного и стильного интерьера. Здесь каждый найдет необходимые предметы для придания своему дому индивидуальности и комфорта."
        }
    )
    const navigate = useNavigate()

    const [items, setItems] = useState([
        {
            id: 0,
            name: 'Good 1',
            cost: 1234,
            details: {
                'Первая характеристика': 'Контент',
                'Вторая характеристика': 'Контент'
            },
            mark: 4.9,
            feedbackCount: 200,
            liked: false
        },
        {
            id: 1,
            name: 'Good 2',
            cost: 1234,
            details: {
                'Первая характеристика': 'Контент',
                'Вторая характеристика': 'Контент'
            },
            mark: 4.9,
            feedbackCount: 200,
            liked: false
        },
        {
            id: 2,
            name: 'Good 3',
            cost: 1234,
            details: {
                'Первая характеристика': 'Контент',
                'Вторая характеристика': 'Контент'
            },
            mark: 4.9,
            feedbackCount: 200,
            liked: false
        },
    ])

    const likeGood = (index) => {
        const goods = [...items]
        goods[index].liked = !goods[index].liked
        setItems(goods)
    } 

    const [groups, setGroups] = useState([
        {
            id: 0,
            name: 'Group 1',
            cost: 11200,
            items: [
                {},
                {},
                {}
            ]
        },
        {
            id: 1,
            name: 'Group 2',
            cost: 9300,
            items: [
                {},
                {},
                {},
                {}
            ]
        },
        {
            id: 1,
            name: 'Group 2',
            cost: 9300,
            items: [
                {},
                {},
                {},
                {}
            ]
        },
        {
            id: 1,
            name: 'Group 2',
            cost: 9300,
            items: [
                {},
                {},
                {},
                {}
            ]
        },
        {
            id: 1,
            name: 'Group 2',
            cost: 9300,
            items: [
                {},
                {},
                {},
                {}
            ]
        },
        {
            id: 1,
            name: 'Group 2',
            cost: 9300,
            items: [
                {},
                {},
                {},
                {}
            ]
        },
        {
            id: 1,
            name: 'Group 2',
            cost: 9300,
            items: [
                {},
                {},
                {},
                {}
            ]
        }
    ])


    const [descriptions, setDescriptions] = useState('1');
    const toggle = (id) => {
      if (descriptions === id) {
        setDescriptions();
      } else {
        setDescriptions(id);
      }
    };
    
    const goToGood = (id) => {
        navigate(`/product/${id}`)
    }
    
    const propsData = {
        items,
        goToGood,
        groups,
        likeGood,
        toggle,
        descriptions,
        description
    }

    return (
        <Store {...propsData}/>
    )
}

export default StoreContainer