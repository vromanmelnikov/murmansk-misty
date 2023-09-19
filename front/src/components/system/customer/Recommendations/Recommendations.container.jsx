import { useEffect, useState } from 'react'
import Recommendations from './Recommendations.jsx'
import { useNavigate } from 'react-router'
import { useSelector } from 'react-redux'
import StoreService from '../../../../services/Store.service.js'
import UsersService from '../../../../services/Users.service.js'

const RecommendationsContainer = (props) => {

    const userTags = useSelector(state => state.users.userTags)

    const navigate = useNavigate()

    const [tags, setTags] = useState([])

    useEffect(
        () => {

            if (userTags.dinamic.length !== 0) {

                (async function () {
                    let tagList = structuredClone(userTags.dinamic)

                    for (let i = 0; i < tagList.length; i++) {

                        let res = []

                        try {
                            res = await StoreService.getProductsByTag(tagList[i].tag_id)
                            tagList[i].items = res.data.items
                        }
                        catch(err) {
                            tagList[i].items = res
                        }

                    }

                    setTags(tagList)
                })()



            }



        }, [userTags]
    )

    const likeGood = (id) => {

        StoreService.getProductbyId(id).then(
            res => {

                const data = res.data

                const productItemID = data.product_items[0].id

                UsersService.addItemToFavourites(productItemID).then(
                    res => {

                    }
                )
                .catch(
                    error => {
                        console.log(error)
                    }
                )
            }
        )
            .catch(
                error => {
                    console.log(error)
                }
            )

    }

    const goToGood = (id) => {
        navigate(`/product/${id}`)
    }

    const propsData = {
        tags,
        goToGood,
        likeGood
    }

    return (
        <Recommendations {...propsData} />
    )
}

export default RecommendationsContainer