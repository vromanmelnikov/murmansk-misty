import { useCallback, useEffect } from "react"
import System from "./system"
import { useLocation, useNavigate } from "react-router"
import UsersService from "../../services/Users.service"
import { useDispatch, useSelector } from "react-redux"
import { setTags, setUser } from "../../store/usersSlice"
import TagsService from "../../services/Tags.service"

const SystemContainer = (props) => {

    const location = useLocation()
    const navigate = useNavigate()
    const dispatch = useDispatch()

    const user = useSelector(state => state.users.user)

    useEffect(
        () => {
            const pathname = location.pathname
            if (pathname === '/') {
                navigate('/profile')
            }
            UsersService.getPersonalProfile().then(
                (res) => {

                    const user = res.data
                    dispatch(setUser(user))

                }
            )
        }, []
    )

    useEffect(
        () => {

            if (Object.keys(user).length !== 0) {

                TagsService.getTagsGroups().then(
                    (res) => {

                        const data = res.data

                        const staticTags = data.filter(item => item.name !== 'Маркет')
                        const dinamicTags = data.filter(item => item.name === 'Маркет')[0]

                        const userTags = user.tag_links

                        const newUserTags = {
                            static: [],
                            dinamic: []
                        }

                        for (let tag of userTags) {

                            for (let staticTag of staticTags) {
                                if (tag.tag.group_id === staticTag.id) {
                                    newUserTags.static.push(tag)
                                }
                            }

                            if (tag.tag.group_id === dinamicTags.id) {
                                newUserTags.dinamic.push(tag)
                            }

                        }

                        dispatch(setTags(newUserTags))

                    }
                )
                    .catch(
                        error => {
                            console.log(error)
                        }
                    )

            }

        }, [user]
    )

    return (
        <System />
    )
}

export default SystemContainer