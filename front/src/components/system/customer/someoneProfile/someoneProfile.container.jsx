import { useParams } from "react-router"
import SomeoneProfile from "./someoneProfile"
import { useEffect, useState } from "react"
import UsersService from "../../../../services/Users.service"
import { useDispatch, useSelector } from "react-redux"
import { setUser } from "../../../../store/usersSlice"
import StoreService from "../../../../services/Store.service"

const SomeoneProfileContainer = (props) => {

    const params = useParams()
    const dispatch = useDispatch()

    const [favouriteProducts, setFavouriteProducts] = useState([])

    useEffect(
        () => {

            window.document.title = 'Профиль'

            const id = params.id

            UsersService.getFriendsRecommends().then(
                res => {

                    const data = res.data

                    const item = data.filter(item => item.friend_id == parseInt(id))[0]

                    const favourites = item.friend.favourites

                    setFavouriteProducts(favourites)

                }
            )

            UsersService.getProfileByID(id).then(
                (res) => {

                    const user = res.data
                    dispatch(setUser(user))

                }
            )

            return () => {
                UsersService.getPersonalProfile().then(
                    (res) => {

                        const user = res.data
                        dispatch(setUser(user))

                    }
                )
            }

        }, []
    )

    const propsData = {
        favouriteProducts
    }

    return (
        <SomeoneProfile {...propsData} />
    )
}

export default SomeoneProfileContainer