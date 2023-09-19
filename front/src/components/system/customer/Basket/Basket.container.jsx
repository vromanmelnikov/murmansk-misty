import { useEffect, useState } from 'react'
import Basket from './Basket.jsx'
import UsersService from '../../../../services/Users.service.js'
import { useNavigate } from 'react-router'
import StoreService from '../../../../services/Store.service.js'

const BasketContainer = (props) => {

    const navigate = useNavigate()

    const [goods, setGoods] = useState([])
    const [cost, setCost] = useState(0)

    useEffect(
        () => {

            UsersService.getBasket().then(
                (res) => {

                    const data = res.data.items
                    setGoods(data)

                }
            )
                .catch(
                    error => {
                        console.log(error)
                    }
                )

        }, []
    )

    useEffect(
        () => {

            let newCost = 0

            for (let item of goods) {

                const count = item.count
                const price = item.product_item.price

                newCost += price * count

            }

            setCost(newCost)

        }, [goods]
    )

    const addItem = (id) => {

        UsersService.addItemToBasket(id, 1).then(
            (res) => {

                let items = [...goods].map(
                    item => {

                        let newItem = { ...item }

                        if (item.product_item_id === id) {
                            newItem.count += 1
                        }

                        return newItem
                    }
                )

                setGoods(items)

            }
        )
        
    }

    const deleteItem = (id) => {

        UsersService.deleteItemFromBasket(id).then(
            (res) => {

                let items = [...goods].filter(item => item.id !== id)
                setGoods([...items])

            }
        )

    }

    const buyAll = () => {

        for (let item of goods) {

            const id = item.id

            StoreService.buyItemFromBusket(id).then(
                res => {
                    setGoods([])
                }
            )

        }

    }

    const goToGood = (id) => {

        navigate(`/product/${id}`)
    }

    const propsData = {
        goods,
        cost,
        addItem,
        deleteItem,
        goToGood,
        buyAll
    }

    return (
        <Basket {...propsData} />
    )
}

export default BasketContainer