import { useEffect, useState } from 'react'
import PersonalInfo from './PersonalInfo.jsx'
import UsersService from '../../../../../../services/Users.service.js'

const PersonalInfoContainer = (props) => {

    const userInfo = props.user

    const [user, setUser] = useState({

        lastname: userInfo.lastname,
        firstname: userInfo.firstname,
        patronymic: userInfo.patronymic,
        birthdate: userInfo.birthdate || '',
        gender: userInfo.gender

    })

    const onChange = (event) => {

        const id = event.target.id
        const value = event.target.value

        setUser({
            ...user,
            [id]: value
        })

    }

    const onSubmit = (event) => {

        event.preventDefault()

        const data = { ...user }

        if (data.birthdate === '') {
            data.birthdate = null
        }

        UsersService.updateUserProfile(data).then(
            res => {
                window.location.reload()
            }
        )
            .catch(
                error => {

                }
            )

    }

    const propsData = {
        user,
        onChange,
        onSubmit
    }

    return (
        <PersonalInfo {...propsData} />
    )
}

export default PersonalInfoContainer