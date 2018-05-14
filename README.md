ManyWho SDK for Salesforce
==========================

This project contains the basic configuration settings for running ManyWho inside Salesforce. In addition, the project includes an example Visualforce page and Lightning Component for Communities. This code can be customized as needed to meet your organizational objectives.

## Install the Unmanaged Package

You can install this code using the standard Salesforce Package Manager. However, it cannot be upgraded due to limitations in Salesforce with unmanaged packages:

Production & Developer Edition
https://login.salesforce.com/packaging/installPackage.apexp?p0=04t36000000wVg1

Sandboxes
https://test.salesforce.com/packaging/installPackage.apexp?p0=04t36000000wVg1

After installing, you must manually configure network access:

1. Click on Setup in Salesforce
1. In the **Administer**section, expand the **Security Controls** menu and click on **Network Access**
1. Create 3 new *Trusted IP Ranges*:
  * Start IP Address: **54.164.117.86**, End IP Address: **54.164.117.86**
  * Start IP Address: **54.88.201.125**, End IP Address: **54.88.201.125**
  * Start IP Address: **54.84.53.201**, End IP Address: **54.84.53.201**

## Install from GitHub

You can also install this code using the GitHub deploy tool built by FinancialForce. However, users have reported login issues:

<a href="https://githubsfdeploy.herokuapp.com">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

Special thanks to Andy of FinancialForce for making this great deployment utility. You can read more about Andy here:

https://andyinthecloud.com

## Contents

There are a few cool things in this package that you can use and configure as you like.


### Visualforce Page

To run a Flow inside of Salesforce, you can use our standard Visualforce Page. It's important to note that our UI runs inside of Salesforce - this isn't an IFrame. The page is located at: `apex/flow`. As part of this package, we've linked the page to a Flow we built that has some instructions in it. If you want to link the page to your own Flow, you need to do the following:

1. Build a Flow! You'll need a ManyWho account for this.
2. Publish the Flow.
3. In the Publish URL for your Flow, it will look a bit like this: `https://flow.manywho.com/1ae14654-0699-401f-aaf6-f0adbb5418c8/play/default/?flow-id=0fabfe3a-3226-4288-8ea0-be69bb9cb612`.
4. From your Flow URL, grab out the `tenant-id` and `flow-id` values according to the following structure: `https://flow.manywho.com/{tenant-id}/play/default/?flow-id={flow-id}`. Using the above example:
    - `tenant-id: 1ae14654-0699-401f-aaf6-f0adbb5418c8`
    - `flow-id: 0fabfe3a-3226-4288-8ea0-be69bb9cb612`
5. Load the Visualforce page like this: /apex/flow?tenant-id={tenant-id}&flow-id={flow-id}. Again, using the above example:
    - `apex/flow?tenant-id=1ae14654-0699-401f-aaf6-f0adbb5418c8&flow-id=0fabfe3a-3226-4288-8ea0-be69bb9cb612

That's it. Basically, the Visualforce page can be re-used for all of your Flows. All it needs is the tenant-id and flow-id to know which Flow to run. A few important things to think about here:

1. You might put the link to the Flow in a Button.
2. You might hard-code those values into the Visualforce page itself.
3. You might store the tenant-id and flow-id in an Object or Custom Setting to ease management.
4. You might associate the page with a standard controller for Account, Contact, etc so you can embed it in the record detail, etc.

The goal of ManyWho is to give you plenty of flexibility. Remember, this page can be embedded in Salesforce1, Actions (in Chatter), etc. It's a Visualforce page - all the same rules apply :)


### Salesforce1

We have already created a menu item in Salesforce1 that links to the above Visualforce page. The great news is that all Flows built on ManyWho are already responsive to mobile, tablet and desktop. They can also run seamlessly inside the Salesforce1 app - and outside the Salesforce1 app. As before, it's a Visualforce page so you have all the flexibility of Salesforce1 to decide where best to access the Flow.


### Mobile Offline using Cordova (PhoneGap)

The cool thing about the ManyWho platform is that it supports offline Flows out-of-the-box. So you can build your awesome Flow applications and we've already made sure they'll work offline. Check out this project to get details:

https://github.com/manywho/ui-cordova


### Communities Lightning Component

To run a Flow inside of Lightning Communities, we've created a Lightning Component for you already. As with the Visualforce page, this isn't an IFrame, our UI is running inside of the Lightning Component. If you want to link the component to your own Flow, you need to do the following:

1. Build a Flow! You'll need a ManyWho account for this.
2. Publish the Flow.
3. In the Publish URL for your Flow, it will look a bit like this: `https://flow.manywho.com/1ae14654-0699-401f-aaf6-f0adbb5418c8/play/default/?flow-id=0fabfe3a-3226-4288-8ea0-be69bb9cb612`.
4. From your Flow URL, grab out the `tenant-id` and `flow-id` values according to the following structure: `https://flow.manywho.com/{tenant-id}/play/default/?flow-id={flow-id}`. Using the above example:
    - `tenant-id: 1ae14654-0699-401f-aaf6-f0adbb5418c8`
    - `flow-id: 0fabfe3a-3226-4288-8ea0-be69bb9cb612`
5. Open Lightning Communities Builder
6. Find the ManyWho Flow component in the components section.
7. Drop the component onto a page in your community.
8. Paste the information captured in step 4 into the appropriate boxes in the component configuration.

That's it. Basically, the Lightning Component can be re-used for all of your Flows. All it needs is the tenant-id and flow-id to know which Flow to run.


## Managing Change un-managed Package

It's important to note that each time you deploy this project, we will overwrite any changes you've made to the code. If you think you're likely to make a bunch of changes, we recomment using the power of GitHub!

1. Fork this repo
2. Make your changes in there
3. Contribute back if you like! Also sync our latest changes into your code!
4. Deploy to Salesforce using your GitHub repo, not this one :)

## Contributing

Contribution are welcome to the project - whether they are feature requests, improvements or bug fixes! Refer to 
[CONTRIBUTING.md](CONTRIBUTING.md) for our contribution requirements.

## License

This service is released under the [MIT License](http://opensource.org/licenses/mit-license.php).
