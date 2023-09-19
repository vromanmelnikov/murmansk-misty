import { useState } from 'react'
import DinamicTags from './DinamicTags.jsx'
import TagsService from '../../../../../../services/Tags.service.js'

const DinamicTagsContainer = (props) => {

    const [editFlag, setEditFlag] = useState(false)
    const toggle = () => setEditFlag(!editFlag)

    const onChange = (event) => {

        const value = event.target.value

        TagsService.addTagToUser(value).then(
            (res) => {
                
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
        <DinamicTags {...propsData}/>
    )
}

export default DinamicTagsContainer