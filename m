Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021084.outbound.protection.outlook.com [52.101.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232E3B0589;
	Thu, 17 Sep 2026 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629152; cv=fail; b=hD5BmuyJfde9l9xg3A5jzUHPDYfOiXrqt1+x/b9H5IcIQL6skNe1yXN4Pj2jOiC1JTxUMmp7azG78RfGyRCYdQg+EM6qvdYUe0QeJtGcXX11rZRJ2ii+UKmQQJQiXRGquT6Y8SfGDEC0A3DwznTNte4sZo/VL8O7YUoaa3IJcW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629152; c=relaxed/simple;
	bh=voWT8VeoRyeDB+0btPcuMZS4n6M5Ji7X9hbLEeS6aX8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XLRBPKXwhGvzhGiCBgzSzfhEg6kmb8PQjnWF+A2b9FThQbbtSjfGTUKOa/m2ZWa8b1O/xx9MSMbalLyYXYIGDXydDoEwGT1h+Kxdjd/ZoKrp8tYhp3U1NQlADaQ4WDGL0q8WKfVmGf9dL9pOve1gqTR8fs9aOcdXrRkU9UYVCWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oej7CMCa; arc=fail smtp.client-ip=52.101.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oej7CMCa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icLmA1pdD34iBpPqyawGnY56mXHkMB/Wft6MDSqPeT7J9oKMvz4rTFgIgnEUwi9n+8gj8PBpYqolRITCHoFR3LGY/bAwydI7hj93maR0Pi90/b5QQ6etKl/nDUOMVxDdbHDK41b8/jkaAaK6f2B5wlUtw8K5XfEio+D+hlJDsb6A9cI7nrjXohPyOqoQbC3r9B6geT0JMDNATnNe+iOUA3qS80wSsecMK1xY4KWEI5hDGLxqyXSfE2x6OuqaP/Rz9s5jbDymz6ZAzt5GN6Oy4DsmunJqlq3zck8IjaOh3C52jOya3MJSNgU17ThTRzTyvUMKo7hPVFdPqB5s58UTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERVxJiEPwsq9um/Ms+5vrqYTPmNsYFUxk3xXvcXQl18=;
 b=UjrlIigl9dS3uYJ+Q2q17O8Rqg1PCxfbxQ8c/eSaLzuvEDn0/g7nAi4f3zzW3C7j9f1H0s5TY8ObEOzH+NFtPpu8AWwhJ6b/9eQE5tHhhjNmLL3W9+DI1SyNhUHe3Z8unStP7CVEQgzmW3rCptK99lDM0ajg8aiW3wjvn4WIMogN1BfThc3JNKDqRMM1dA/55c0CBZaC3A7rNKz54rNObFUjePQlyWrlQ3SSq/dHk8v0zlYrc6GgclvaJsYG7d3J7OSfqeEOp0/NhkFkRRK+pApm/brMcKa5/AuRPjakmnQuEdc6P5C2Ka71eNXtmqyotDdnl3OnO6/op4ELW6flgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERVxJiEPwsq9um/Ms+5vrqYTPmNsYFUxk3xXvcXQl18=;
 b=oej7CMCaH8taxI1Tij7kWj7xHFOuE1XZnOpRUiiiMT+rclwle0ppz4FokKUbGv8jYjjTaMpBYK2rvYdo7MAyIa5rKjhChZbjYFoyX4QfND7GROIxV9cEld72aw7T/cie6Kyg7eUTv0iRA3+8wgEYV89hJeBp/l3/dDrTGwBOu/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CW1P265MB8814.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 07:12:27 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 07:12:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 08:12:21 +0100
Message-Id: <DLHEL1SN5YD4.2UD5Y2ZFLLKLS@garyguo.net>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <acourbot@nvidia.com>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
 <kevin.tian@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
From: "Gary Guo" <gary@garyguo.net>
To: "Alex Williamson" <alex@shazbot.org>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
In-Reply-To: <20260915120148.7548a8ca@shazbot.org>
X-ClientProxiedBy: LO4P123CA0493.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::12) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CW1P265MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d18a59-f2cd-47d4-44c2-08df148b0768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	bVCjftMUX24Dte888bkeo3eaCXybqFIMWWEMXxc82d2A2pv2pjYSbua5icy8ECp0IMVqtwm29JcHzZ/jsnrFececiNnnBREVQor2lz2Knkk3yNaqyQTmF6AOSt3FJC+Z7Ybbz04+NTbB+IJ7O8uvc8naypRs86Zeq1KxilKsw6fXs2WFST/qpj/hUhDWVSbCuTWX3SSQCaxEKoWzME8pRSL1KWsfelMNmoLNkIzghHaKMGQ64IhTuLuCF8nMVZzZg4jI025a/v6vE+1y5bskwyKGytlj+ZFGntPoTyM1gYJung8OMjsv9FNGgbxDSuURG1E2hkTca9tSW+DhcuPMQ/H5D+FALkTnhGxQUNn4rm0mCbIoYMev2kURdmZX3UQHH3VdBkUZXbOSaPAemozZsCAyLK/JpZBmaijZSFuYSbkxVoqzfAZSoCDd3PhA4QIucHfIZLV5J5xXJanpB9hgxhunNplQIdcbsxI86RyJ65xFMxIK5NMkC+pmnyoUpTi0iR3hN2G/A41ARPIGALB1WEjaA02KA20wPwxGDxkTBoFolirhF5+ZBWtzVfnwN8FEEO0T/KIhEJh+OgdT81wYPPNu1vrgfJB9o9ZrOT7hnKzu3OAHiRrnNwtC5TfMyzZ2Tci/fYzRhdd6dPkygbtGlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czkvaFRGTXZSbTA4NDdzdFc0a1A2OHpxT05idXVZVmtveVpJL2tCU2JCTFNH?=
 =?utf-8?B?Wjh3K3JYM25pdFRWRGxtMkR4aU5LUU5ZUDVSRHR6ckxPbEpwNHlIS2hPMFdR?=
 =?utf-8?B?M0FaREVxemthRDlBQml4VUhQSXc5Y0ljN2RhZ0FMcmZXejh2Y2FldzZydTBB?=
 =?utf-8?B?WnJIOXkxeUp6cktRZlJESjZKcFJ5bmxzU2JDK0tQRDFFSTYwZktDM0p5d1Bl?=
 =?utf-8?B?QUxLS1g2TkhCNkRzdWk2YkU1L0lPKzJabFBSdnRKTEJLazNUS3NxZ0xQdGF1?=
 =?utf-8?B?SndURnBuZ1BoaU9sdzc0WDZ1ZFpndWNJaFRuMXNXWVBpWGFsR0xVKytRSGxw?=
 =?utf-8?B?WUpKMTJac254d3d6bWZjYktzWU1lcXQ3ZG1kL3AyTUNMUFBVNUtNbU9TdDdV?=
 =?utf-8?B?RDZHRHprNTlVT2ZlVTU1b3MvUWJwZTJBeTF4VlJmRkY5RFBMYkYxL01zWmZ6?=
 =?utf-8?B?UUV4NDVPZHlybmI2S05EeG8yUGt0YVZ1ejRhY0xYWEdYNTNmSytOdEpXY2pw?=
 =?utf-8?B?cEVzWVpiTTJQVGhjNzU3aDdsVGlmUVlTZVRwa1VTSUcwQnQ2UXpVclRXZmZi?=
 =?utf-8?B?VUtTUmUwRWJVY2xzM1V5UWZsM0ZwdllCc2tSa0VKMnNmbmRvdlk5MkM3Vk9O?=
 =?utf-8?B?Vmg3Y2RSRWFhcmFyaCtVMmNpbnhJVUtlRzdiWjhCWE5lbkVKYUtWTG1ROVhU?=
 =?utf-8?B?OUNvRnpZZFhEc0U4RXFLK2NNNFBpRUpkckw4aG5VaC9hS244MHM2c0FSZGVk?=
 =?utf-8?B?OWlGYzNSMUJMU2xtdWhrYTkvU3Y2eExYMVQrNGR2c3ZWL1BxZDJud0NoR3or?=
 =?utf-8?B?TDVyTERnL0JESkdpbkIwWkJXSENNdGJJYVJiRFNzYnFrdmttRFVSSmlrdmtq?=
 =?utf-8?B?YTJUc0I1NDVFRjBmVDhZS2NVYm01TXNCWDNQZzE0L2hGRi93ZE5KU3dMR1Q4?=
 =?utf-8?B?STlvRU5GSlN1VFhsejUxd2hYNEJTNU9TYlhnS0VtM2U3SzZQbGM5SUNDWCtS?=
 =?utf-8?B?MFJVTWFlaXFiaUkzU29TSFk1UG1rWDIwQ1NXcUZZZ1JZcDhUcEF3Q2hiY0pN?=
 =?utf-8?B?Wld6WDB3MWM5c2dydnNPTTBmTXh6czhibmFyWVhvZ3BpUWFxWTNHSUtZTU5v?=
 =?utf-8?B?M2FJSWVWODltcllaNG5jTHNzbWtYVk1TTktiN292dldneGhmOWUvVkxRVmdG?=
 =?utf-8?B?TFkxdHVDWGpNN1dRenRrQ2djbnI5aEhzeThxeGxWMlgrOVZwZURkYk8xSXBv?=
 =?utf-8?B?ZmpWWXhpWmlBZDNhM1ZYblBZaDlmbTdpRkhNdkdqajZ6MElrbUJDU0J3cnlu?=
 =?utf-8?B?MTFuU0NKL005a0h6VmZrQXdyRUJYNjZJQUNzWHpVZVU0cVRaczJlZGl1cFBK?=
 =?utf-8?B?OU9wR1FRbW5SRW04b1huS3ROb3ZjMi9OME1KQUhiWndrb2NKQWtsUXZVRkRj?=
 =?utf-8?B?QWRsZzNlbVJiSjRGRlNscTNlak9yRzZPT0xxK0N1MittS21VTnI5SVdaakx1?=
 =?utf-8?B?cGZydkFEeitIMzZybWMyQTNTYWZ1MkRXNmN2VmlTQUwrUEtSUHBIR1htelkz?=
 =?utf-8?B?L3Z4R29ETFJ6MFRtcHF5aXFYYmZNeHFSV1JPTWhBOTczOHJyMG13N20yL0xI?=
 =?utf-8?B?TG1qejgwaFpJQjBHaFh0YUdZcjNYR2Z3NjBhdUh6QnYwS21WZjhtcW1JUVk2?=
 =?utf-8?B?YzFPWDFDY3dNK2U0K2pUdHFQRjlCdXR1OFFtK29VQ2VoZGJ2aS9sS0x3VEY4?=
 =?utf-8?B?aTZSZmlvNXYvNmVwdEthemJxYUsrSlZjL1lENFdRcmM3MTMwUzhFUUhoUFFk?=
 =?utf-8?B?c3BLVHFMZHViQVFrY0FuaU8wVVB1aG1LNHFDcFZHVytvdFVLSDZSbERGM1N0?=
 =?utf-8?B?NFVSd1BmdHlRMm5ZTzZCa0Z4RHM1VVA5UHBOMUxwTENuOStjTDIzanRxSDJQ?=
 =?utf-8?B?RnBTemg5Q2IvbHhVZnJpbmovc1p4Z1Nvc09vd01XUzdSU0FQZnI3NjFYRlNO?=
 =?utf-8?B?MGhqM0FUclVlSkwrNTV2T2hhVW4wR2FPVmcyZ3FTNVUyNmU5TXFvd1BDQkVu?=
 =?utf-8?B?SHpaQ2NJQmduVUlsZVBXbThoaVRIMklHc25ZTlp4UWo0SzJyTXJYM2JSZlZi?=
 =?utf-8?B?ZFJDOElwV3d1Zlk4UHhVamxNNCsxOUk0WGgwa0Nqc2pWWUp5c3FSelRaZE5v?=
 =?utf-8?B?MTF5QUpYenBHeHd2ZWIxRE1Udnpkc3kxejNRVEJMM0JGSmpuN1I1cWVJazFZ?=
 =?utf-8?B?S1Z5dGROTTRjM0FKazE3TTh4TzF0UXd0am5ENy90VmhldC9nTEVnZTVtMEts?=
 =?utf-8?Q?BZqtUCwbDzO+d4eAQk?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d18a59-f2cd-47d4-44c2-08df148b0768
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:12:26.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBo+5dUmB5tzYsXzN7rQDOtAb/YK/FljfmABX1gxbbzE22/j5+tDBGx6p8F0AuaNI7yKe4V0QIFzn6Z1SdjPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8814

On Tue Sep 15, 2026 at 7:01 PM BST, Alex Williamson wrote:
> On Mon, 14 Sep 2026 23:36:24 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>> On Mon Sep 14, 2026 at 8:12 PM CEST, Alex Williamson wrote:
>> > The one piece here that I can actually review is [5], where
>> > dev_get_drvdata() is replaced with a vfio-pci-core struct pointer
>> > embedded in the struct pci_dev, which is a non-starter as far as havin=
g
>> > a common PCI-core shared by various drivers. =20
>>=20
>> Well, that was just a quick hack to get it out of the way. :)
>>=20
>> I think there are a couple of options.
>>=20
>>   (1) Make the PM helpers take a struct vfio_pci_core_device * in the fi=
rst
>>       place and let the driver forward to the helpers in its own PM call=
backs.
>>=20
>>   (2) Provide an (optional?) driver callback that translates a struct pc=
i_dev to
>>       struct vfio_pci_core_device.
>>=20
>>   (3) Provide a macro for drivers to define PM ops, letting drivers prov=
ide the
>>       function that translates struct pci_dev to struct vfio_pci_core_de=
vice.
>>=20
>>   (4) Give struct vfio_pci_core_device its own PM domain (which is proba=
bly a
>>       bit overkill :).
>>=20
>> I understand that the idea is to hide the PM handling in the vfio-pci fr=
amwork,
>> but I think the existing implementation is a bit of a layering violation=
, since
>> class device implementations shouldn't impose requirements on the bus de=
vice
>> private data layout.
>>=20
>> I also think that the approach to fully hide it in the framework is only=
 really
>> worth if it doesn't otherwise impose subtle requirements on the driver (=
such as
>> the layout requirement of the bus device private data).
>>=20
>> Thus, I'd personally just go with (1) as it is the most honest approach =
in terms
>> of driver layering. But I think (2) is a good alternative that is not mo=
re
>> invasive than asking drivers to set the bus device private data to
>> struct vfio_pci_core_device *.
>
> I'd position this more as a library convention than a class layering
> violation.  vfio-pci was originally one driver, vfio-pci-core was
> pulled out to enable device specific support, ex. migration, in a more
> manageable way.  struct vfio_pci_core_device is not strictly a class,
> it's the object used by the library that variant drivers opt to use
> rather than re-implementing vfio-pci from the ground up.
>
> The conventions of that library mean variant drivers get things like
> VGA routing and power management for free, in adherence with how these
> features are exported by the core, and can choose to opt-in to common
> error handling.
>
> The use of drvdata is part of that convention and audited by the core
> such that failed compliance is rejected on registration.  Clearly we
> could allow variant drivers to provide ops for their own callbacks and
> export core helpers they can use, but only a Rust driver requires this
> and we need to figure out how to do this without degrading the audit in
> the core.
>
> Turning vfio-pci-core into a proper class to be able to have a real
> layering violation claim seems like a much larger project.
>
>> > My concerns are of course who is going to review the Rust vfio-pci
>> > variant drivers from a vfio perspective, not just a drm driver
>> > viewpoint. =20

FWIW, if we want vfio-pci to be a middle layer (looks like there're some
disagreements about this), we could quite simply achieve this by define

    mod vfio_pci {

        trait Driver {
            /* callbacks here */
        }

        struct Adapter<D: Driver>(D);

        impl pci::Driver for Adapter {
            ...
        }

    }

and then the way for people to be using this would to create the "Adapter" =
which
does the middle layering and register *that* as pci driver instead. Then
all PCI callbacks will first land in vfio-pci abstration's code before it
filters through things in the driver. This way, vfio-pci-core imlements the=
 pci
driver then it controls its drvdata layout.=20

Best,
Gary
