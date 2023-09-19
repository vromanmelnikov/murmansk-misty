import { Card, Col, Input, Row } from 'reactstrap'
import Styles from './Favourites.module.css'
import { Outlet } from 'react-router'

const Favourites = (props) => {

    return (
        <div className='container mt-3'>

            {/* <Card className={`${Styles.content}`}>

            </Card> */}

            <Row>
                <Col xs='3'>
                    <Card className={`p-4`}>
                        <Input type='select' onChange={event => props.onSelectChange(event)} value={props.select}>
                            {
                                props.selectItems.map(
                                    (item, index) => {
                                        return (
                                            <option key={index} value={item.id}>{item.value}</option>
                                        )
                                    }
                                )
                            }
                        </Input>
                    </Card>
                </Col>
                <Col xs='9'>
                    <Outlet />
                </Col>
            </Row>
        </div>
    )

}

export default Favourites