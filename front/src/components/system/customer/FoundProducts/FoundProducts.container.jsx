import { useEffect, useState } from 'react'
import FoundProducts from './FoundProducts.jsx'
import { useNavigate, useParams } from 'react-router'
import FinderService from '../../../../services/FInder.service.js'

const FoundProductsContainer = (props) => {

    const navigate = useNavigate()
    const params = useParams()

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

    useEffect(
        () => {

            const request = params.request

            FinderService.findProducts(request).then(
                res => {

                    const data = res.data

                    setItems(data)

                }
            )
            .catch(
                error => {
                    console.log(error)
                }
            )

        }, []
    )

    const goToGood = (id) => {
        navigate(`/product/${id}`)
    }

    const propsData = {
        items,
        goToGood,
        groups,
        likeGood
    }

    return (
        <FoundProducts {...propsData}/>
    )
}

export default FoundProductsContainer