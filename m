Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743751A74D;
	Wed, 16 Sep 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576107; cv=fail; b=W2cHhcmeadbyVIVXSXvXPsa9lXF/I4PjypM4l1a9EM3oOp//yfdBxE3CFB6yxfiXl1Hlw96uYfJYDtz+mTRr1/7MrASGB3Q7HcFBzA/1rrsM/U+oaQMLO0C76DE5ViRDo9muV//071IrJwGFBO6ntwhxd2abY5lqrocn9PO98ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576107; c=relaxed/simple;
	bh=PAugz/0t6N6OMypAUnOYcR23i1P3Djr/LOvHii9/La0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZIPawxffjns8V/wtMnU4YJzqf/IeXtM6acBowRNyI+L+NTyr2PIAkYSm+jYLo0mJO70ZueW8S6vCeJiuSAut031Fq4y+24GL/4zs9vHsrWkBlvBpKr06fE8X+/QBxhGlFQtPz1Yx7BCsU+o51nnNH9TPYTSIgfiT+1VWFVM4c6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Og/ZKOF5; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Og/ZKOF5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3tBFn6SPpHz7c8mh56I3sVkZmSBP53AxHJjHEwpnJ1IMcG0UlzZFW87IubU8lSjzZasgJ3lcqLqYstQAVCE7ZkB/MZ+UZAjI84/cA67XCJZEU+YVlmw7Ajt+ehpnD8zz415Q9FwBEYOeznFv+UUr2c6lPd7LQuaWoJCPQBi5KHxg6xQx/UvoUjG5yg9AQ/2ijIRKzz2givITNhEXQQKv2H1aACzdACfSma5w5ZqwQcD+DOEASJ42CBC1aKtX/JGt8Sks6DcHhg9pld8JAKdEtUXcVeUuAmWM03GMoJ4GBMpkahkv94Ot3O8puAdKfOiaXdKtaVTg3xQJcHe6PLMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVOssh43K+nE8QKi1SZTyBm69GiCwFPsoqtrWCCyW4g=;
 b=c2Tt+6nZnrt6T14SPeHIZ5MOCjwHDaYFZh4li1s4mW9lKnPxXHPbVvrGzNJSIxRB0qg9ghyf7XqbQoj8OQjBpKPWXSpBiw4BdbSNhk+9Jrg1Dn4TSb4DKJbXApIH4PJOpf5MGFwWZVSBC+DgDtuUiDIBpDEqTkhNlpPPTUbRI1dyvGQD1sT9ZJjmP1Vy9p6+U04KzIqOLdfUDgekBkUysSK0wYzaam/qs1aX8Cn+2aVtnUvEhe7AMD2tG/bIx1UZttwHeAc1+M6K/7jBRJ9AxcCvM4oTgxxemWhODDoT20F4q1+Hd3GSQ7ZT6AgmGLrJzfOtJIq5Y/H2pE29TYIE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVOssh43K+nE8QKi1SZTyBm69GiCwFPsoqtrWCCyW4g=;
 b=Og/ZKOF5Wt55VDaY9whwqGwTzYi/dyA6jKogzUdjhjf90vh9FRgMLzNFQ/UUvBh5o9uNADJOn2ObdSfWMITMPEMjLyOC7ZCnm/DIIxXZ6CxfRgLTQWWYNKGrf85S2CHCbPoTk23AslXvf336lnIuZ4yQDJjuY0uz1idGh50jrr+sEEZ8UAxYo4un8Q9yzCecoetQPkQ5QupSSI9sCY368ZvqEbymTj7VR0UJLYX3dkw3fxbNDJgQ7C/+HlgxHeECFiAjt0EGitpxpswGN29ewkQJdQdmAqrNtIoYNyHG8qj54rHYnDU1ZRMk6OwCFHRAHQ4Cev4+jcxZg6xXNzaoig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ0PR12MB7068.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 16:28:19 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 16:28:19 +0000
Date: Wed, 16 Sep 2026 13:28:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>,
	acourbot@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, airlied@gmail.com, simona@ffwll.ch,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
	smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, nova-gpu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhiwang@kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 12/13] vfio/nvidia-vgpu: add the NVIDIA vGPU VFIO variant
 driver
Message-ID: <20260916162817.GW3968357@nvidia.com>
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
 <20260916141718.GU3968357@nvidia.com>
 <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLGUPX9KPFKF.12CU304YAST79@kernel.org>
X-ClientProxiedBy: YT4PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: d5070ed4-8e66-4196-8aaa-08df140f8470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A9B+0inhkF3hPBzSKSZj/GNszUUgxdtAT45Sot9SqJqYj4y1KLhEiyx+LXF5Wt1WmCFDb9Nwl0NjH8WB+w9+T2ZksBVMWOdbLBtbOuujWAvQbsBWTd4Pyars73+C6S1MIKnzIRX4/iTm/+J1h/ExYyIDchFL7Cr6XLpBQRJyW6FwNJxMHyifRFEdkZ+Gkyeh1WcmhxkcTxOgVRx+sdvKZwG+BJ2wTiXpwRh0FQwpCAg1Q/HxNnWBksbTRBQ0aNfl+ZxLQ50puSiTEdZrUlgUidBTi00rwh69QHBgLzsmu7GmbQfQUeVtqlVyHe36UKUMZLt3m1nVyEUqiSkG+/vxJDUQ2X3JnFN8t/z2eTfhZTW9EbHTMLuuasQFDGu6zX5Lbnvl2qs8vJ8WNQ6yHLijZ7+In/2zG2IMl7Ng7ToXhmdZipF6fkxmR7llBLviuT0hEPfXUZerxL/AujtmhJoc7d4yMHXhJ/qw3Rj48Wtkex2nVtxr0+6w56uW2T7L5d5C3VHyw688pCbvLiXFpGDccNcJVmRBrxR6HlLnYw9DPnNON+VQUv9b45966CepSwmbjMeTRxoipSbYYQLlnjVGxgsx8RPG3pA6/vV20HVwTlm4MKhC92HovBeQe3DX4kd+gOEwc759C4HpxNCRYyFWxy85g/kFvjnbyeEjPjE6QAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0Kgp08WKXHGvHYo24bLRuJ1+WE601KFDIhZsS0IRhQvCx1p6YyvLp85r2WV?=
 =?us-ascii?Q?x+L3ivj+Ax0AWk8QV1ZzGhA2vrstXgFCBJv2rreLdw0JeSKe3xRbRrUox9ZV?=
 =?us-ascii?Q?lB7e/vCb4HdwXQ/NYmde9du1ZVhhMCFz+v8lJBzpJGmlAfZLH2RTB2kYwNx7?=
 =?us-ascii?Q?DTW5dcO9eNTGfDGu3y0msl24/pvlvaJ32RJTk4CpyRdq3jmf5lcQY0+xfUQE?=
 =?us-ascii?Q?cRG4lkln+5GMEEXT1ji2dn4CgAVi8MEWCP6BKuo5UVaknJMdPCe37XO14cXB?=
 =?us-ascii?Q?f8KN4SjVeAtvBHUlGd7vj3WTuLnIanIc4wwleJVTXAeejNBUuo1UZJrS0f8M?=
 =?us-ascii?Q?Zd3Veuvg/io8CtWhWDoIwTbiWdvpoyj8O/nPE8p8NEKR8jXce/pI1H142nlS?=
 =?us-ascii?Q?p2hwFiUo3qKs1/OII3VPX48p8vhQUSyHG60La4vXaocoreleyWbBKI6gx2QR?=
 =?us-ascii?Q?g79Z4pErB7sJdrjfr/rL6bCAs13OICfK1Z+L6l/5m/GcZhxjb+UVllFyJN4d?=
 =?us-ascii?Q?HVPW8s5H1UjYJHP4eRNdSoTTGSR4oUIv3yxEu1tVfzWpnT4J1ps0WydnUqHX?=
 =?us-ascii?Q?fWAF2mllfcK7u5+ZyzxLZBeW1wV844NzUiIeOfd9L+XKFepLvHwiTTqhxw2g?=
 =?us-ascii?Q?snUE3kMprGWcBZ1RG0ZdtdZ4ly0810zzbaIeK7gE8fHhqeBBt3y2yWS5NC8Q?=
 =?us-ascii?Q?asHowdInjnCdsBvK2WpFOl8hJnkkBne5T5tWHI8HuzuWeAJLZjTnodFrvRSs?=
 =?us-ascii?Q?AW+c7Tg8bPVbM3O3YHoMdhCqxtFTTtD8+kDUF+GOrZ37SiRlAlRcjaoaVgs7?=
 =?us-ascii?Q?U/5+NbCEov3e6w5/ei8YZjbaxdl8Hozsl6uZXjYhEDd29LH3PLQJDkzE2fI8?=
 =?us-ascii?Q?tTsERBawdvNAzHQenJ3YiSsLDJUoGDsMtfITofXIqHp1YpQjJb1keHCmV/zG?=
 =?us-ascii?Q?hjvgwkrIJK1pRVb3jl6COF7XFK0RhnrLR98Pc1nlnkS+V+1DWCEnjK7TZ//f?=
 =?us-ascii?Q?LkVaQURFpE4ekHkVvQffYbGHbifKu7R7yR7JP9Y+O5DZwIXkca725qy7YC9A?=
 =?us-ascii?Q?AEYKuIjDo9gXXQ4wV7J5Ns7CU7N/ncj1KLkaxFjP9q2Eca6cDQE3pjKHmbjv?=
 =?us-ascii?Q?621o5U7zTJ1fPAeoLd0vQav8VYJogNTxBHxhVPlqemgrSOsUso0pC0CZ+4y3?=
 =?us-ascii?Q?00HYL5tjXRH4e6CsD7oq1A3BWaixAvt2o61c8EyJ65hgliSCxbPhV+I65ABB?=
 =?us-ascii?Q?fS6mzvz+26kFyOR2FfdmUSU6smod+xGtJh6J2aUNZbE6K7Q+ixFiFIgv79/E?=
 =?us-ascii?Q?3afnaONrPaU3EiVUJRSI3Bk0W7mJelTQjX8HuTdGWk8oh18Bzf1GRKE0mM7x?=
 =?us-ascii?Q?UMp269IVDuuKKsKfj2HYVbVsjjeoce6RXIMKu7s9+EnkoF2GDzQoeO+c3DII?=
 =?us-ascii?Q?3nQauDX0zcCOj1hckEWk5vNuggCMWMLTXn+LIhFgUo7587OkwfpxNlkOsdtE?=
 =?us-ascii?Q?KxDLJpI+agJZSXM3di0qVwy2/giU213BTZebhM3Gm5fWfpVHQnIrRvLXPQnC?=
 =?us-ascii?Q?LYDZjOBeCf6yGo6m6F0CfWhM7kQBYazIF1Bly+T6V2XnDgtMfjbTuS5zMQyD?=
 =?us-ascii?Q?GArjhDPpRaO+g09gmlpJfdiUF543chXZNO8H5L6aekgmkmf9KWQgZoYoHQY7?=
 =?us-ascii?Q?dcY16hvcO6irt0rYsPwrCvYcwBI3bXe/N5cbesNqSwFCTroV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5070ed4-8e66-4196-8aaa-08df140f8470
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:28:18.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYzwsk6HJeINdtHkRu7xLCFRzmutMjGLuQ/Yqp+bK2U1lIRVC5os7dLLqvV4heZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068

On Wed, Sep 16, 2026 at 05:38:21PM +0200, Danilo Krummrich wrote:
> Usually, class device implementations can't make assumptions of the underlying
> bus, because they have to work for any bus. I.e. there's no other way than
> providing helpers and letting drivers do the glue code between the bus and the
> class device.

You should think of VFIO as a series of helper libraries. One of those
libraries is "here are all the PCI PM ops you need".

Drivers rarely need to customize these ops, they just need to wire it
up to the support library to avoid a bunch of code duplication.

Stated another way - the very point of vfio-pci is to remove
duplicated code from the drivers.

So if we wanted to push hard on removing drvdata, and don't want to
touch the struct device I would probably say to #define up a way for
the driver to build its unique trampolines. It wastes a bunch of .text
but at least it doesn't duplicate code.

> The reason this seems undesirable from a vfio-pci perspective is that it is
> special in the sense that it is a class device that is specifically built to sit
> on top of a spcific bus device (i.e. struct pci_dev).

It is a library, all these ideas to do things with the driver core to
implement a library make no architectural sense.

> It still makes me think that there should be some closer integration of vfio-pci
> with the PCI core, as it is specifically built for this bus.

It has such a basic need I don't see this as a reason to pollute pci
core with any vfio specific things. Like I would nak your [1], that's
completely wrong layering.

> > I don't really understand in a nutshell why we should do this for nova
> > the mails were so long... Can we not just ignore the lifetime
> > imperfection for this?
> 
> I mentioned some points in the first two paragraphs of [2]. Besides that, I
> don't see a reason why we should spend time and effort for working out the
> inferior solution, where the better alternative is even less effort, contributes
> to better quality and stability of the whole driver project and also offers a
> chance for the vfio subsystem to gain new contributors and gather experience
> with the language that has proven itself in many areas already.

It seems to be quite a leap that it is less effort. IDK..

> TBH, I don't think it makes a difference; having Rust abstractions is pretty
> much the same as having another driver. I.e. it would be equivalent to saying
> "before we accept another pci-vfio driver we need to do some rework".

Well, it is, but thats the point when judging effort..

Jason
