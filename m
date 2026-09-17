Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020083.outbound.protection.outlook.com [52.101.196.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABB4E50A0;
	Thu, 17 Sep 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628491; cv=fail; b=slmUqLu3u1Ye4Z2pHELR46JFapGM6lKsbyR7JVoWYqgmcQh8ewrCYhMBk1tpDKNE/kaeyEI55sVzkHoAQ28BmeNaDVbYMTHp02Ezgh370qe8DvjaNpPomd6IGdhJZS5Lhr98+UL4L0ey+RRjtqVrtXtIZGSnmZqALjs/I/uRoks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628491; c=relaxed/simple;
	bh=r3Z5GrQXhAjCk9yyq/nqdQ1w2ux17yZXCYIoIugcVSI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=nL211wcKmmtQeqlUrLmug+gbCKdBfYdTneurDWzqhPAmvSrsAuVYakSOHG74VdQmEsPBiH+thahUbR5I/6FIcL+dNoSVROKTXXQEMJJf8CvGO+aWzqyqdwd/e1DK8oQkdvsXUueqsktZ9+keDwy1S/eNDQQtEp/kaX4zxbLxp5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=x0jLBVBe; arc=fail smtp.client-ip=52.101.196.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="x0jLBVBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5DcsusudbGht0Lr7aGSqn2ljlyz2wbWtkNs6/1a6KEro1Kx8+mNhjOTtZxk9CCX6K9nepwBN6F9elajUZw7fOtuj/Rd6FCexvVi2gyALLLriOT6We0phJPAhvGPPmFR+4BExoahKIQW5gq8fPCy06X22cXOlPC2aQx7aIYzX7gz07E8p5Jo3B4cu13T4Ka/lwMIKjj2u1utObPbisX6mIXZ2d1xw+hTAyWaJXWFQAn6N8Ra0UCaTt5KlL/qir/vW3HZjTSz+HBPRCpsvkkJkas1Dsfr4TLPJbptWSAnmv+f1S1i248i9u1alRll6Rud0wVtm3s2UjwjaSpGErD9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBmJ/LO39Mnnzr/uAaFkqSl7tUBOzEy9XapxJXkJQu0=;
 b=p4FAcmp0GdZqWS9o3Lj1mJ797NOBV34QBMG2xSthpm6o5Sx/jL1oTnbviuGiO6fy+QfkUFO0P3b0E+Gg+DQdpyF80VMufpDVgcpA6C+NapobpZ7F3sNgdDOUr8TEChcZP1kedhN6d63651zATSSoFGz9S5Nv3QcEt1ANTyA9SaOFSP7C5fSuarBovqlgMnU5BQjtrRvzSCPsv43HXmS7OlVMZkM+why5LRCcOM9HHTkFj0dh2H4Di7icVs/nVx29vEd/xKVu5oovEoKeHN27A1K0QdlF+JtWR6hSy2uKaZwkeFqPhh1SI5vrpe9qp7CaFKGTXVer7KF8FbT8WMbZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBmJ/LO39Mnnzr/uAaFkqSl7tUBOzEy9XapxJXkJQu0=;
 b=x0jLBVBevztDhfQlArij8dWIDnyOqq9tFyQoHE2PqTSGLc4whpx5cSjViGihqNrr1Jg8kAZbeP8kdo3VMcQQ0dc0joDZUJOWCvb0r12l3EtIus8WC1+3iFNhr/lI6gbhroIK1jxvz2ifBLV5iRJD2aJB12Q82DZQrfgWBUts4FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO0P265MB7075.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 07:01:23 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 07:01:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 08:01:18 +0100
Message-Id: <DLHECLAV3LP7.2OR5P6P544IMX@garyguo.net>
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO
 variant driver
From: "Gary Guo" <gary@garyguo.net>
To: "Dave Airlie" <airlied@gmail.com>, "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alex Williamson"
 <alex@shazbot.org>, "Zhi Wang" <zhiw@nvidia.com>, <acourbot@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <kvm@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
 <20260916162817.GW3968357@nvidia.com>
 <CAPM=9twda0Q9nj9E5AUCi4=en5tDA7ReBv8MV2Ftg-STwNbDLQ@mail.gmail.com>
In-Reply-To: <CAPM=9twda0Q9nj9E5AUCi4=en5tDA7ReBv8MV2Ftg-STwNbDLQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0109.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::13) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO0P265MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: b1365b7c-7d01-41cd-7186-08df14897c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	jgRfqQ2VKlkNN46ksBvO95oYTD0nATxXfL6VNk0SlhiZu3BnKEkOR8ZYXyynpD648TwOAYHDE1h2HzsiDcwUkRuo9ROKlEu4VeKc4+QIsOWxaHEfkmyPb9pzF9mAHlxIId09j2Pk7SVpIx/wqA4rD/gYP3coaHqF3KYa+1emj6YfkNgL9C4bn4st8XYMYlpxWsL1mGk6lyeqh3q2ddBLNxtrrikUEM1dRD5A28QeKHSAZOguX+NYHte/JKydIkiA6ptuZVANXu7iDbD3r6eOigRDRXKcB8zD6YQu6S/OV4SArmXBHKA6Qe2A6xN7Del36ShkBrq2ETXFsNMJC8vvh5OhgLlRs0o1JtEavK/PvWyrHwJba/JAaliYV4rCPJJeUonfiPrRpIPKl8TX535P0nQ4oBZjQX318L6U8mLOeJry2QC1WfEQecAyA1xHxqW7ordO1eu5rTyRjjS0DQvpf1vB2QzaHYoHLNAo6WB2Q9BepwcZ3oYvPk1evWO0S3EcZKKRTp//ePj8z7js0mZ7MUrHRSYoktXRwfw/Em/+ziM8fMTWsQn1gc4TrzMF089kreOQFLI5+ZDvgiQxTFjfaGm1zsrZLH2wNCbia7GpH7d1hlKq3us5miI7dP1mRuTMnU7T9aBVwB8UiAjrV/N0F/MxMI5A3MUOKFo8cEbsDtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qzl1QmtoTE51Nzg5NTBvTFRRTk55M1kvUVh2elNSWUZLdEw3eWRUQjE0SXVh?=
 =?utf-8?B?dmwxL1U2SkZDQjV3UXBhdnY2VkdIb1NMNWhUemNSN1R5M1g1L1paREF6VU01?=
 =?utf-8?B?b2lRMmhMMnVScFhBZFU0Q2JYYUdxZkNWSUFKNFFURE0xTytmY1BLMTN2a0hn?=
 =?utf-8?B?ZHhDaHFmcVNMeUV4Zjgwa3FKRHZNNGRjQ1dKR09pQ21XbmtWZmpHcElUQ25R?=
 =?utf-8?B?cWc5QkRhOXJmbklKOWR5WVNEZ2VSbUh3Vm41eFB3M3Y0cW9uZ0tMcUswRFQv?=
 =?utf-8?B?SW10T3NUSzV3cEtHSkxHSVBmZW9OTjRxRzVZWkh3QXN1TTR0eEJycnA4Vjdw?=
 =?utf-8?B?UmppaFowemxJRkptcmhxU015YW1kV1l5bktDdFF4Y3dsV29rUlptVzhiLzNa?=
 =?utf-8?B?a2pSK0k3cFJjdEl0QjVaclRzN2RtQS9jUGtTR3JhY25kQVloTWp5amJhb21L?=
 =?utf-8?B?QTlyTWpJcE02aDNvQXpQeFJTd0x5NUJxRlAyRDN5VDcyMUtidGp4UWs2aHYw?=
 =?utf-8?B?bWoyMWRDMytsQjR6T0RFUDl5UW4yWEdiR3hhSm9SQWdYcUIvb3d5L1B1UmEv?=
 =?utf-8?B?Q3FEY0Z1U3l5UDc1eHVyNllORVFHL1lrYTJCU1VGK2JHd3g4VGExMGYzV0NK?=
 =?utf-8?B?alBCdzh2WUJ5eGdkNFRvZmRiU2FaNTVOaDRzNTZXUUlDUDV6MHJCdHR3SEpq?=
 =?utf-8?B?c2JXakVIMXk5OHl0cURkU1NLSExHZHRGQm44a0pvUHk1RXJOMGpvZGNLalJ0?=
 =?utf-8?B?a0ZhNWdnWmlTY280bVQ4aGk3QzE4RGNaTnNzTlhpdkhTT0FjcUtnZUVaQm5Z?=
 =?utf-8?B?ZGdHblVqbzFvSGk2TjRMa3BScXNSakV0ekE4c3pvWUJJckVqNkRUNitYa0F3?=
 =?utf-8?B?NnphcWJ3cVY4NE9DSWptYzJubTYvSkUwWlNwaklXRVRveWFweTBldGFMZlZR?=
 =?utf-8?B?SzZmVUNudURJNFFFRGM0Q3U4WktlQU1rckxQZmZOejQ1TXh1SjVoNmUzMlp6?=
 =?utf-8?B?b1NoZUIyaWgyVllPR1NlVG0xakNVTjc2OEdNVUEwNENPUWd0ZDNNK1BYNnMv?=
 =?utf-8?B?NWdKcExad1N6c1RTSTVHcExZcmtlQWw0OW9YYllsM3JESHZYWk9mREUyck5h?=
 =?utf-8?B?MkhoMHlWQmNEUGhVY2ZQU0xqSkF0N2cxUUVRZElhaDBWSERlU1N2R2d4WUZB?=
 =?utf-8?B?cVg4dlBCTkJzdHhRRy83SXBJQmJMT0tHRGdqVE02bkl4cHRNMngyb25CbEl4?=
 =?utf-8?B?UXpnajNvZVFTdzB0eVNMTEhnYXlrYm9KMVhsNDFHb3NCamVFTk13UlAvTnBu?=
 =?utf-8?B?QThQQ2xDNEFDWG9mS3kvaXozT25qM285THNQbFJEckk2VVovaW9xWklBMFBQ?=
 =?utf-8?B?NUtBUC9uRnZvM0dsS1RSd1BzYVBQeHI1MWU1QjFWbXczSTJ5aHo3U2tGYStm?=
 =?utf-8?B?Ly9MSFY3dlhxc0xXQUNNRW9qQmNkMHdSVGJvZnVncjVkVGNTakNleFM0Ukhu?=
 =?utf-8?B?bFBOV09sTjI1MzJySGVBcmpDVi9BczVidmovY05XUk95QnZpV1dQM0ZPQWxN?=
 =?utf-8?B?dkJKT2Zvam03V3FYQnJSelVTbVNhUmY3RGZITGh6NTBCSHNWaTdBejlBdmc3?=
 =?utf-8?B?SU9qZm5ncU1ndXU3cVZvRzhscHpjM0RMa3psQUc4VmhRcjN1OHBHMkcrWUVN?=
 =?utf-8?B?WThOdE9wb3lMTk5Jcm9FOGlqZ1lId2JhSlkzMUdrbmNGZGtkSGk1V052djZB?=
 =?utf-8?B?WXR4OVluY282ZDJqZmdSVVFmV3hmZnZGekJoL0JzK3Jhd01nWGQ2SmpxZHBJ?=
 =?utf-8?B?d0s2dG9TMVNwNXI4akVFZFpKRndSK0M3YThTNC8rL3JZZ0ZRQ3lkK3prNWJV?=
 =?utf-8?B?cTNEVVloS2N0SGlldzJ2SER2YlBsdzViazZJb1piY0JTV3BTQk5nTCtpREtq?=
 =?utf-8?B?ZXplZS9IK0puSkN2NmtGdWQ3a0M0Vlp5QWEra2Rkb1BoQWJWSGszdkM4Nm8r?=
 =?utf-8?B?SEJJbDYybENiellpNGlIS2xycHFveDBZM041RVRTNUFxQjJCeTRrN3BKeGh1?=
 =?utf-8?B?M1hleWY0RTF1UjZMTE8zbWFyUFcyUWxaTGEvQzY4OUl4NFZ6VnpTN1FFMUJ0?=
 =?utf-8?B?UTM4ZVpNR201UVlFeTlNVXJEcG5CRGMwSkdRcGU4VENmajJGNEJGYldJSGox?=
 =?utf-8?B?dHFjVXVQaUFnZm9zREdmVjFvSTBCMWljdnlOTGFqeVk2Sit2RkNRNmw1T0NK?=
 =?utf-8?B?UHFnblVITnVnemZsV0UxQUJsWit6NXdhK3ZtaTNiS0lPckRIT3ZOLytQTm5U?=
 =?utf-8?Q?ZDWMKpXbNpifS/1sUW?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b1365b7c-7d01-41cd-7186-08df14897c23
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:01:23.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhRtvWDvaM20CGbWzvlCXphpaPUiLTAnGyEds1gBLS8/weBdzWzqeMDSLgSFcbDuIoMYayFFZB6Jh4pjnW2ARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7075

On Thu Sep 17, 2026 at 2:49 AM BST, Dave Airlie wrote:
> On Thu, 17 Sept 2026 at 02:28, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> Stated another way - the very point of vfio-pci is to remove
>> duplicated code from the drivers.
>>
>> So if we wanted to push hard on removing drvdata, and don't want to
>> touch the struct device I would probably say to #define up a way for
>> the driver to build its unique trampolines. It wastes a bunch of .text
>> but at least it doesn't duplicate code.
>
> +static pci_ers_result_t hisi_acc_vfio_pci_aer_err_detected(
> +       struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +       struct hisi_acc_vf_core_device *hisi_acc_vdev =3D hisi_acc_drvdat=
a(pdev);
> +
> +       return vfio_pci_core_aer_err_detected(&hisi_acc_vdev->core_device=
,
> state);
> +}
> +
> +static int hisi_acc_vfio_pci_runtime_suspend(struct device *dev)
> +{
> +       struct hisi_acc_vf_core_device *hisi_acc_vdev =3D dev_get_drvdata=
(dev);
> +
> +       return vfio_pci_core_runtime_suspend(&hisi_acc_vdev->core_device)=
;
> +}
> +
> +static int hisi_acc_vfio_pci_runtime_resume(struct device *dev)
> +{
> +       struct hisi_acc_vf_core_device *hisi_acc_vdev =3D dev_get_drvdata=
(dev);
> +
> +       return vfio_pci_core_runtime_resume(&hisi_acc_vdev->core_device);
> +}
> +
> +static const struct dev_pm_ops hisi_acc_vfio_pci_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(hisi_acc_vfio_pci_runtime_suspend,
> +                          hisi_acc_vfio_pci_runtime_resume, NULL)
> +};
>
> is how much code it adds to current drivers, this doesn't seem
> excessive for 10 drivers,
> like you could obfuscate it a bit with some macros, but I really don't
> see a lot of value in hiding
> what is effectively just standard driver boilerplate.

If it's just these callbacks, you could even have vfio-pci directly proxyin=
g these
callbacks by having a `struct device` -> `struct vfio_pci_core_device` hash=
map.
(Not that I'm saying it's a good idea).

Best,
Gary

