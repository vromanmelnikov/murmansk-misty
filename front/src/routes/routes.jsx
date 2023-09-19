import AuthContainer from "../components/auth/Auth.container"
import LoginContainer from "../components/auth/Login/Login.container"
import RegistrationContainer from "../components/auth/Registation/Registration.container"
import BasketContainer from "../components/system/customer/Basket/Basket.container"
import FavouritesContainer from "../components/system/customer/Favourites/Favourites.container"
import FoundProductsContainer from "../components/system/customer/FoundProducts/FoundProducts.container"
import ProductContainer from "../components/system/customer/Product/Product.container"
import RecommendationsContainer from "../components/system/customer/Recommendations/Recommendations.container"
import ProfileContainer from "../components/system/customer/profile/profile.container"
import SomeoneProfileContainer from "../components/system/customer/someoneProfile/someoneProfile.container"
import SystemContainer from "../components/system/system.container"
import CalendarEventContainer from "../components/system/customer/Calendar/calendarevent.container"
import GoodsContainer from "../components/system/customer/Favourites/Goods/Goods.container"
import GroupsContainer from "../components/system/customer/Favourites/Groups/Groups.container"
import StoreContainer from "../components/system/customer/Store/Store.container"
import MyStoreContainer from "../components/system/customer/MyStore/MyStore.container"

const Routes = [
    {
        path: '/auth',
        element: <AuthContainer />,
        children: [
            {
                path: '/auth/registration',
                element: <RegistrationContainer />
            },
            {
                path: '/auth/login',
                element: <LoginContainer />
            }
        ]
    },
    {
        path: '/',
        element: <SystemContainer />,
        children: [
            {
                path: '/profile',
                element: <ProfileContainer />
            },
            {
                path: '/favourites',
                element: <FavouritesContainer />,
                children: [
                    {
                        path: '/favourites/goods',
                        element: <GoodsContainer />
                    },
                    {
                        path: '/favourites/groups',
                        element: <GroupsContainer />
                    },
                ]
            },
            {
                path: '/basket',
                element: <BasketContainer />
            },
            {
                path: '/recommendations',
                element: <RecommendationsContainer />
            },
            {
                path: '/profile/:id',
                element: <SomeoneProfileContainer />
            },
            {
                path: '/calendar',
                element: <CalendarEventContainer />
            },
            {
                path: '/found-products/:request',
                element: <FoundProductsContainer />
            },
            {
                path: '/product/:id',
                element: <ProductContainer />
            },
            {
                path: '/store/:id',
                element: <StoreContainer />
            },
            {
                path: '/mystore/:id',
                element: <MyStoreContainer />
            }

        ]
    }

]

export default Routes