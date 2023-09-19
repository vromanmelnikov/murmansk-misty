import { useDispatch, useSelector } from 'react-redux'
import BudgetModal from './BudgetModal.jsx'
import { changeBudget } from '../../../../../../store/modalSlice.js'
import { useEffect, useState } from 'react'
import UsersService from '../../../../../../services/Users.service.js'
import { useParams } from 'react-router'

const BudgetModalContainer = (props) => {

    const dispatch = useDispatch()
    const [budget, setBudget] = useState(0)
    const flag = useSelector(state => state.modal.budget)

    const onSubmit = (event) => {
        event.preventDefault()
        UsersService.addBudget(budget).then(
            res => {
                console.log(res)
                    
            }
        )
            .catch(
                error => {
                    console.log(error)
                }
            )
    }

    const addBudget=(event)=>{
        let value=event.target.value
        setBudget(parseInt(value));
        
    }

    const close = () => {
        dispatch(changeBudget())
    }

    const propsData = {
        flag,
        close,
        onSubmit,
        addBudget
    }

    return (
        <BudgetModal {...propsData} />
    )
}

export default BudgetModalContainer