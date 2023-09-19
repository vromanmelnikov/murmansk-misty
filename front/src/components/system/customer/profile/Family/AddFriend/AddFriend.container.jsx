import { useDispatch, useSelector } from 'react-redux'
import { changeAddFriend } from '../../../../../../store/modalSlice.js'
import AddFriend from './AddFriend.jsx'

const AddFriendContainer = (props) => {

    const dispatch = useDispatch()

    const flag = useSelector(state => state.modal.addFriend)

    const close = () => {
        dispatch(changeAddFriend())
    }

    const propsData = {
        flag,
        close
    }

    return (
        <AddFriend {...propsData} />
    )
}

export default AddFriendContainer