import { useEffect, useState } from "react"
import Profile from "./profile"
import UsersService from "../../../../services/Users.service"
import TagsService from "../../../../services/Tags.service"
import { useDispatch, useSelector } from "react-redux"
import { setTags } from "../../../../store/usersSlice"


const ProfileContainer = (props) => {

    const [editProfile, setEditProfile] = useState(false)
    const changeEdit = () => setEditProfile(!editProfile)

    // const [user, setUser] = useState({})

    const user = useSelector(state => state.users.user)

    useEffect(
        () => {
            
            window.document.title = 'Профиль'

        }, []
    )

    const propsData = {
        editProfile,
        changeEdit,
        user,
    }

    return (
        <Profile {...propsData} />
    )
}

export default ProfileContainer