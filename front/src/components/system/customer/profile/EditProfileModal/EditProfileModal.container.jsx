import { useDispatch, useSelector } from 'react-redux'
import EditProfileModal from './EditProfileModal.jsx'
import { changeEditProfile } from '../../../../../store/modalSlice.js'
import { useEffect, useState } from 'react'
import TagsService from '../../../../../services/Tags.service.js'

const EditProfileModalContainer = (props) => {

    const flag = useSelector(state => state.modal.editProfile)
    const userTags = useSelector(state => state.users.userTags)
    const dispatch = useDispatch()

    const pages = [
        {
            id: 0,
            value: 'Личная информация',
        },
        {
            id: 1,
            value: 'Характеристики',
        },
        {
            id: 2,
            value: 'Интересы',
        },
    ]

    const [currentPage, setCurrentPage] = useState(pages[0])
    const [selectIsOpen, setSelectIsOpen] = useState(false)

    const [tagsGroups, setTagsGroups] = useState({
        static: [],
        dinamic: []
    })

    const [staticTags, setStaticTags] = useState([
        // {
        //     value: 'Молодежь'
        // },
        // {
        //     value: 'Работающий'
        // },
        // {
        //     value: 'Студент'
        // },
        // {
        //     value: 'Информационные технологии'
        // }
    ])

    const [tags, setTags] = useState([
        {
            value: 'Компьютерная техника'
        },
        {
            value: 'Аксессуары для музыкальных инструментов'
        }
    ])

    useEffect(
        () => {

            TagsService.getTagsGroups().then(
                (res) => {

                    const data = res.data

                    const staticTags = data.filter(item => item.name !== 'Маркет')
                    const dinamicTags = data.filter(item => item.name === 'Маркет')[0]
                    dinamicTags.items = []

                    TagsService.getAllTags().then(
                        (res) => {

                            const data = res.data.items

                            for (let tag of data) {

                                for (let staticTag of staticTags) {
                                    if (!staticTag.items) {
                                        staticTag.items = []
                                    }
                                    if (tag.group_id === staticTag.id) {
                                        staticTag.items.push(tag)
                                    }
                                }

                                if (tag.group_id === dinamicTags.id) {
                                    dinamicTags.items.push(tag)
                                }

                            }

                        }
                    )

                    setTagsGroups({
                        static: staticTags,
                        dinamic: dinamicTags
                    })

                }
            )

        }, []
    )

    const toggleSelect = () => setSelectIsOpen(!selectIsOpen)

    const changePage = (index) => {
        setCurrentPage(pages[index])
        toggleSelect()
    }

    const propsData = {
        flag,
        toggle: () => {
            dispatch(changeEditProfile())
        },
        pages,
        currentPage,
        selectIsOpen,
        toggleSelect,
        changePage,
        staticTags,
        tags,
        tagsGroups,
        userTags,
        user: props.user
    }

    return (
        <EditProfileModal {...propsData} />
    )
}

export default EditProfileModalContainer