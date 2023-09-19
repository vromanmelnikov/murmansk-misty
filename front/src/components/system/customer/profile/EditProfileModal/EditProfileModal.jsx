import { Badge, Form, FormGroup, Input, Modal, ModalBody, ModalHeader } from 'reactstrap'
import Styles from './EditProfileModal.module.css'

import icon from '../../../../../assets/photos/drop_trigger.png'
import AddButtonContainer from '../../../../UI/AddButton/AddButton.container'
import PersonalInfoContainer from './PersonalInfo/PersonalInfo.container'
import DinamicTagsContainer from './DinamicTags/DinamicTags.container'
import StaticTagsContainer from './StaticTags/StaticTags.container'

const EditProfileModal = (props) => {

    return (
        <Modal
            isOpen={props.flag}
            toggle={props.toggle}
            centered
            className={`${Styles.modal}`}
        >
            <ModalBody>
                <div className={`${Styles.select}`}>
                    <h2>{props.currentPage.value}</h2>
                    <img
                        className={`${Styles.trigger}`}
                        src={icon}
                        onClick={props.toggleSelect}
                    />
                    <div className={`${Styles.selectItems} ${props.selectIsOpen && Styles.openedSelectItems}`}>
                        {
                            props.pages.map(
                                (item, index) => {
                                    return (
                                        <span
                                            key={index}
                                            className={`${Styles.item}`}
                                            onClick={
                                                () => {
                                                    props.changePage(index)
                                                }
                                            }
                                        >
                                            {item.value}
                                        </span>
                                    )
                                }
                            )
                        }
                    </div>
                </div>
                <div className={`${Styles.content}`}>
                    {
                        props.currentPage.id === 0
                        &&
                        <PersonalInfoContainer user={props.user}/>
                    }
                    {
                        props.currentPage.id === 1
                        &&
                        <StaticTagsContainer tags={props.userTags.static} groups={props.tagsGroups.static} user={props.user}/>
                    }
                    {
                        props.currentPage.id === 2
                        &&
                        <DinamicTagsContainer tags={props.userTags.dinamic} groups={props.tagsGroups.dinamic} user={props.user}/>
                    }
                </div>
            </ModalBody>

        </Modal>
    )

}

export default EditProfileModal