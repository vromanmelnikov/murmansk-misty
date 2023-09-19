import { useEffect, useState } from "react"
import ProfileInfo from "./profileInfo"
import { useDispatch, useSelector } from "react-redux"
import { changeEditProfile } from "../../../../../store/modalSlice"
import { useNavigate, useParams } from "react-router"
import JWTService from "../../../../../services/JWT.service"
import UsersService from "../../../../../services/Users.service"
import { setTags } from "../../../../../store/usersSlice"
import TagsService from "../../../../../services/Tags.service"
import FilesService from "../../../../../services/Files.service"
import API_CONFIG from "../../../../../config/api.config"

const ProfileInfoContainer = (props) => {

    const userTags = useSelector(state => state.users.userTags)
    const user = useSelector(state => state.users.user)

    const dispatch = useDispatch()
    const navigate = useNavigate()

    const editProfile = () => {
        dispatch(changeEditProfile())
    }

    const logout = () => {
        JWTService.clearTokens()
        navigate('/auth/login')
    }

    const updateImage = () => {

        if (props.isPersonal) {

            const fileInput = document.createElement('input')
            fileInput.type = 'file'

            fileInput.onchange = (event) => {

                const file = event.target.files[0]

                // console.log(file)

                FilesService.addFile(file).then(
                    res => {

                        const data = res.data

                        const profile = {
                            "lastname": user.lastname,
                            "firstname": user.firstname,
                            "patronymic": user.patronymic,
                            "birthdate": user.birthdate,
                            "gender": true,
                            "image": `${API_CONFIG.PROD_BASE_URL}/files/${data}`
                        }

                        UsersService.updateUserProfile(profile).then(
                            res => {
                                console.log(res.data)
                            }
                        )

                    }
                )

            }

            fileInput.click()

        }

    }

    const propsData = {
        isPersonal: props.isPersonal,
        editProfile,
        user,
        logout,
        userTags,
        updateImage
    }

    return (
        <ProfileInfo {...propsData} />
    )
}

export default ProfileInfoContainer