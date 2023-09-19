import { useDispatch, useSelector } from 'react-redux'
import ProductModal from './ProductModal.jsx'
import { changeAddBook } from '../../../../../../store/modalSlice.js'
import { useEffect, useState } from 'react'
import UsersService from '../../../../../../services/Users.service.js'
import { useParams } from 'react-router'

const ProductModalContainer = (props) => {

    const dispatch = useDispatch()
    const params = useParams()

    const [date, setDate] = useState({
        date: '',
        time: ''
    })
    const [booking, setBooking] = useState({
        id: 0,
        description: '',
        time: '',
        details: {},

    })

    useEffect(
        () => {

            UsersService.getPersonalProfile().then(
                res => {
                    const data = res.data
                    
                    setBooking(
                        {
                            ...booking,
                            id: data.id
                        }
                    )
                }
            )
                .catch(
                    error => {
                        console.log(error)
                    }
                )

        }, []
    )

    const submit = (event) => {
        event.preventDefault()

        UsersService.addBooking(booking.id, booking.description, booking.time, booking.details).then(
            res => {

            }
        ).catch(
            error => {
                console.log(error)
            }
        )
    }



    const addBooking = (event) => {

        let name = event.target.name


        let value = event.target.value
        setDate({
            ...date,
            [name]: value,
        })
        booking.time = date.date + 'T' + date.time + ':00.000Z'
        // setBooking({
        //             ...booking,
        //             id:id

        // })

    }

    const flag = useSelector(state => state.modal.addBook)

    const close = () => {
        dispatch(changeAddBook())
    }
    const propsData = {
        close,
        flag,
        booking,
        submit,
        addBooking

    }

    return (
        <ProductModal {...propsData} />
    )
}

export default ProductModalContainer