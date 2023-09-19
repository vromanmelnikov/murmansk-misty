import { useEffect, useState } from 'react'
import Shops from './Shops.jsx'
import { useNavigate } from 'react-router'
import { useDispatch } from 'react-redux'
import { changeAddStore } from '../../../../../store/modalSlice.js'

const ShopsContainer = (props) => {

    const navigate = useNavigate()
    const dispatch = useDispatch()

    const goToStore = (id) => {
        navigate(`/mystore/${id}`)
    }

    const addStore = () => {
        dispatch(changeAddStore())
    }

    const propsData = {
        stores: props.stores || [],
        goToStore,
        addStore
    }

    return (
        <Shops {...propsData} />
    )
}

export default ShopsContainer