import { useEffect, useState } from 'react'
import Goods from './Goods.jsx'
import UsersService from '../../../../../services/Users.service.js'
import { useNavigate } from 'react-router'

const GoodsContainer = (props) => {

    const navigate = useNavigate()

    const [items, setItems] = useState([])

    const likeGood = (index) => {
        const goods = [...items]
        goods[index].liked = !goods[index].liked
        setItems(goods)
    }

    const addToBasket = (id) => {

        UsersService.addItemToBasket(id, 1).then(
            (res) => {
                console.log(res)
            }
        )
            .catch(
                error => {

                }
            )

    }

    const deleteGood = (id) => {

        UsersService.deleteFavourites(id).then(
            () => {

                const newItems = items.filter(item => item.id !== id)
                setItems([...newItems])

            }
        )

    }

    useEffect(
        () => {

            UsersService.getFavourites().then(
                res => {

                    const data = res.data.items
                    setItems(data)

                }
            )
                .catch(
                    error => {

                    }
                )

        }, []
    )

    const goToGood = (id) => {

        navigate(`/product/${id}`)
    }

    const propsData = {
        items,
        deleteGood,
        addToBasket,
        goToGood
    }

    return (
        <Goods {...propsData} />
    )
}

export default GoodsContainer