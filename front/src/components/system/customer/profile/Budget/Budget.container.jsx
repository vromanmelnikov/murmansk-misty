import { useState } from 'react'
import Budget from './Budget.jsx'
import { useSelector } from 'react-redux'
import { changeBudget } from '../../../../../store/modalSlice.js'
import { useDispatch } from 'react-redux'

const BudgetContainer = (props) => {

    const user = useSelector(state => state.users.user)
    const dispatch = useDispatch()

    const [budget, setBudget] = useState(
        '30000'
    )

    const addBudget = () => {
        dispatch(changeBudget())
        
    }


    const propsData = {
        budget,
        addBudget,
        user
    }

    return (
        <Budget {...propsData} />
    )
}

export default BudgetContainer