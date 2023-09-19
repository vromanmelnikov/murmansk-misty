import { useState } from 'react'
import StaticTags from './StaticTags.jsx'
import TagsService from '../../../../../../services/Tags.service.js'

const StaticTagsContainer = (props) => {

    const [editFlag, setEditFlag] = useState(false)
    const toggle = () => setEditFlag(!editFlag)

    const userTags = props.user.tag_links

    const onChange = (event) => {

        const value = event.target.value

        // for (let group of props.groups) {

        //     console.log(value, group.items)

        //     const tag = group.items.filter(item => item.id === value)

        //     if (tag) {
        //         console.log(tag)
        //         break
        //     }

        //     console.log(tag)

        // }
        

        TagsService.addTagToUser(value).then(
            (res) => {

                // const tag = userTags.filter(item => item.id === value)[0]
                // console.log(tag)

            }
        )
        .catch(
            error => {
                console.log(error)
            }
        )

    }

    const propsData = {
        tags: props.tags,
        editFlag,
        groups: props.groups,
        toggle,
        onChange
    }

    return (
        <StaticTags {...propsData} />
    )
}

export default StaticTagsContainer