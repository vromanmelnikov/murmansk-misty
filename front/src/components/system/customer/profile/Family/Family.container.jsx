import { useEffect, useState } from 'react'
import Family from './Family.jsx'
import UsersService from '../../../../../services/Users.service.js'
import { useNavigate } from 'react-router'
import { changeAddFriend } from '../../../../../store/modalSlice.js'
import { useDispatch } from 'react-redux'

const FamilyContainer = (props) => {

    const navigate = useNavigate()
    const dispatch = useDispatch()

    const [familyList, setFamilyList] = useState([])

    useEffect(
        () => {

            UsersService.getFriends().then(
                res => {
                    const data = res.data.items
                    setFamilyList(data)
                }
            )
            .catch(
                error => {
                    
                }
            )

        }, []
    )

    const goToProfile = (id) => {
        navigate(`/profile/${id}`)
    }

    const addFriend = () => {
        dispatch(changeAddFriend())
    }

    const propsData = {
        familyList,
        goToProfile,
        addFriend
    }

    return (
        <Family {...propsData} />
    )
}

export default FamilyContainer