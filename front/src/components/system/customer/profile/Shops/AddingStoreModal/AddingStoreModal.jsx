import { Form, Input, Modal, ModalBody, ModalHeader } from 'reactstrap'
import Styles from './AddingStoreModal.module.css'

const AddingStoreModal = (props) => {

    return (
        <Modal isOpen={props.flag} toggle={props.close} centered>
            <ModalHeader>Добавление магазина</ModalHeader>
            <ModalBody>
                <Form className={`${Styles.form}`}>
                    <Input type='text' placeholder='Название'/>
                    <Input type='text' placeholder='Ссылка на сайт'/>
                    <Input type='text' placeholder='Адрес'/>
                    <Input type='textarea' placeholder='Описание магазина'/>
                    <Input type='file' />
                    <Input type='submit' value={'Создать магазин'}/>
                </Form>
            </ModalBody>
        </Modal>
    )

}

export default AddingStoreModal