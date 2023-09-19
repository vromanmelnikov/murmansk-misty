import { Badge, Input } from 'reactstrap'
import Styles from './DinamicTags.module.css'
import AddButtonContainer from '../../../../../UI/AddButton/AddButton.container'

const DinamicTags = (props) => {

    return (
        <>
            <div className={`${Styles.tags}`}>
                {
                    props.tags.length === 0
                    &&
                    <h1><Badge>Нет тегов</Badge></h1>
                }
                {
                    props.tags.map(
                        (item, index) => {
                            return (
                                <h4 key={index}>
                                    <Badge color='primary'>
                                        {item.tag.name}
                                    </Badge>
                                </h4>
                            )
                        }
                    )
                }

            </div>
            <AddButtonContainer callback={props.toggle} />
            {
                props.editFlag === true
                &&
                <div className={`${Styles.groups}`}>
                    <Input type='select' onChange={(event) => props.onChange(event)}>
                        {
                            props.groups.items.map(
                                (tag, tagIndex) => {
                                    return (
                                        <option key={tagIndex} value={tag.id}>{tag.name}</option>
                                    )
                                }
                            )
                        }
                    </Input>
                </div>
            }
        </>
    )

}

export default DinamicTags