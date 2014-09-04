---
title: "Using factories for cleanliness in Android testing"
slug: "using-factories-for-cleanliness-in-android-testing"
wordpress_url: "http://www.ryanclarke.net/post/using-factories-for-cleanliness-in-android-testing/"
date: "2014-04-14"
tags: ["android", "SEP", "testing", "work"]
categories: ["Technology"]
description: ""

---

I am on a team building a native Android app for a local credit union. We are doing some really cool stuff around testing with unit tests, automated instrumentation tests using spoon, and manual user experience testing. We are working in a low-ceremony, flow-based process with continuous client feedback. One tool we are using to greatly improve our test quality is factories. Android uses Java and so the very name "factory" on a Java project (for a credit union, no less) is probably making you think of BaseAbstractStrategyBuilderFactoryImpl and such, but such enterprisyness is not the case. [![Factory chimneys billowing polution](http://www.ryanclarke.net/wp-content/uploads/pollution-295305_6401.png)](http://www.ryanclarke.net/wp-content/uploads/pollution-295305_6401.png) In reality, factories aren't obligatorily complex: we are simply building an object. If there was any business logic going on I'm sure it would be more complex, but we're just using them in tests to make writing, debugging, and understanding them easier. Even with a test-first development flow, many tests end up needing some state setup to run correctly and hit to correct code paths. And state setup is a chore. Java is fairly verbose. Factories allow us to hide that boring instantiation and assignment snooze-festing in a separate place from the main test function. Take this example from a bit of code I've been working on recently. I've added some Arrange, Act, Assert comments to make this easier to follow.

    @RunWith(AppTestRunner.class)
    public class AccountsListActivityTest extends AppActivityUnitTestCase<AccountsListActivity> {

        public AccountsListActivityTest() {
            super(AccountsListActivity.class);
        }

        @Test
        public void selectingAccountListItemLaunchesAccountDetail() {

            // Arrange account
            Account account = new Account();
            account.id = "checking-account-id";
            account.name = "CHECKING";
            account.isInCashFlow = false;
            account.isFavorite = false;

            // Arrange group
            AccountGroup group = new AccountGroup();
            group.id = "group-id";
            group.owners.add("George E. Meade");
            group.owners.add("Robert E. Lee");

            // Arrange group account
            group.accounts.add(account);

            // Arrange list item
            AccountListItem accountListItem = new AccountListItem();
            accountListItem.build(group, account);

            // Act
            activity.onItemSelected(accountListItem);

            // Assert
            Intent startedIntent = assertThat(activity).launchedActivity(AccountDetailActivity.class);
            assertThat(startedIntent).hasExtra(AppExtras.ACCOUNT, account);
        }
    }

Not very thrilling? At least it is straightforward, especially since you can see exactly what state is necessary to build make this action work. But why do we care that you can only build an accountListItem from a group and an account? Why do we care that account.isFavorite is required? "isFavorite = false" is my motto when it comes to this load of excess. All of the necessary state arrangements are clear, necessary, and completely irrelevant to what we're testing. The boring explicitness makes the thing we care about hard to find. I told you this was a snooze-fest. I'm going to take all the arrange stuff out and make a private method on my test class to hide all the boring setup.

    @RunWith(AppTestRunner.class)
    public class AccountsListActivityTest extends AppActivityUnitTestCase<AccountsListActivity> {

        public AccountsListActivityTest() {
            super(AccountsListActivity.class);
        }

        @Test
        public void selectingAccountListItemLaunchesAccountDetail() {
            // Arrange
            AccountListItem accountListItem = setupState();

            // Act
            activity.onItemSelected(accountListItem);

            // Assert
            Intent startedIntent = assertThat(activity).launchedActivity(AccountDetailActivity.class);
            assertThat(startedIntent).hasExtra(AppExtras.ACCOUNT, account);
        }

        private AccountListItem setupState() {
            // Arrange account
            Account account = new Account();
            account.id = "checking-account-id";
            account.name = "CHECKING";
            account.isInCashFlow = false;
            account.isFavorite = false;

            // Arrange group
            AccountGroup group = new AccountGroup();
            group.id = "group-id";
            group.owners.add("George E. Meade");
            group.owners.add("Robert E. Lee");

            // Arrange group account
            group.accounts.add(account);

            // Arrange list item
            AccountListItem accountListItem = new AccountListItem();
            accountListItem.build(group, account);
        } 
    }

The setupState() method is still pretty overwhelming, but we can ignore it when we read the test method and that is an instant readability win. Now comes the point of this article. Since we don't care about the details of the state setup for this test and the (redacted) others in this class, we can move all this out into a factory that will build the objects we need for us. Now other test classes that will need similar state just say "give me one" and no fuss will ensue. The reusability aspect is really nice. The test is now looking clean.

    @RunWith(AppTestRunner.class)
    public class AccountsListActivityTest extends AppActivityUnitTestCase<AccountsListActivity> {

        public AccountsListActivityTest() {
            super(AccountsListActivity.class);
        }

        @Test
        public void selectingAccountListItemLaunchesAccountDetail() {
            activity.onItemSelected(basicAccountListItem());

            Intent startedIntent = assertThat(activity).launchedActivity(AccountDetailActivity.class);
            assertThat(startedIntent).hasExtra(AppExtras.ACCOUNT_account, account);
        }
    }

In my factory I've refactored the state into a few simple, reusable methods that I can mix and match. This arrangement grew out of the needs of the various tests as we wrote them and needed different pieces of data.

    public class AccountsFactory {

        private static AccountGroup emptyGroup() {
            AccountGroup group = new AccountGroup();
            group.id = "group-id";
            group.owners.add("George E. Meade");
            group.owners.add("Robert E. Lee");

            return group;
        }

        public static AccountGroup groupWithAccount(Account account) {
            AccountGroup group = emptyGroup();
            group.accounts.add(basicAccount());

            return group;
        }

        public static Account basicAccount() {
            Account account = new Account();
            account.id = "checking-account-id";
            account.name = "CHECKING";
            account.isInCashFlow = false;
            account.isFavorite = false;

            return account;
        }

        public static AccountListItem basicAccountListItem() {
            AccountListItem accountListItem = new AccountListItem();
            accountListItem.build(groupWithAccount(), basicAccount());

            return accountListItem;
        }
    }

The Aesop-approved moral to this story is to only put the relevant stuff in the test and hide the rest of the boring state-making in a convenient spot for reuse. On this current project we call them factories, and they work great.

