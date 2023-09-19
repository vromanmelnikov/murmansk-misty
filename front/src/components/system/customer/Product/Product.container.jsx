import { useState, useEffect } from 'react'
import Product from './Product.jsx'
import { useParams } from 'react-router'
import StoreService from '../../../../services/Store.service.js'
import UsersService from '../../../../services/Users.service.js'
import { changeAddBook } from '../../../../store/modalSlice.js'
import { useDispatch } from 'react-redux'

const ProductContainer = (props) => {

    const dispatch = useDispatch()

    const [item, setItem] = useState({
        name: 'Good',
        cost: 1234
    })

    const addBook = () => {
        dispatch(changeAddBook())
        console.log('123')
    }

    const [currentProductItem, setCurrentProductItem] = useState({})
    const [feedbacks, setFeedbacks] = useState([])
    const [user, setUser] = useState({})
    const [count,setCount] = useState(1)
    const [likeflag, setLikeFlag] = useState(false)
    const likeGood = () => {

        setLikeFlag(!likeflag)
    }

    const ChangePrice = (price, details,id) => {

        setCurrentProductItem({
            ...currentProductItem,
            price: price,
            details: details,
            id:id,
        })


    }
    console.log(currentProductItem)

    const params = useParams()
    const id=params.id
    const addToBasket = () => {
        UsersService.addItemToBasket(currentProductItem.id, count).then(
            res => {
                setCount((a)=>a+1)
                console.log(count)
            }
        )
    }



    useEffect(
        () => {
            StoreService.getProductbyId(id).then(
                (res) => {
                    const item = res.data
                    setItem(item)
                    console.log(item)
                    setCurrentProductItem(item.product_items[0])
                    StoreService.getFeedbackbyProductId(id).then(
                        (res) => {
                            const feedbacks = res.data.items
                            setFeedbacks(feedbacks)

                        }

                    ).catch(error => {
                        console.log(error)
                    })



                }
            ).catch(error => {
                console.log(error)
            })




        }, [])



    const propsData = {
        item,
        feedbacks,
        user,
        likeGood,
        likeflag,
        ChangePrice,
        currentProductItem,
        addBook,
        addToBasket

    }

    return (
        <Product {...propsData} />
    )
}

export default ProductContainer