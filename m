Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53450AC37;
	Wed, 16 Sep 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568251; cv=fail; b=ufwpuXGjaMIuymfT5hnL07Bo6jIGGnGucCxfYrVqubSSxfIblAYIl4y9+aWMhx0Zw8N+8TnOId4Ei63vUve8i642H7a6QqJNOuv/mDQMbRt9rXLd9b11+SL6qB1KVcgXC9rRtAJoUSwKHcnUjVq9Hl18X96LQ8TLb4Z3wsHIyWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568251; c=relaxed/simple;
	bh=Ht1I7m1d0FuEk4tx6y4Ry1uyLsoFW9HFIWTqJuJ9gJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hgmi6jjOAPZA+Tcgf4av2p+cXCmAa2mhLn/yo3FRPqfE7ApU8h/Y8UKZ3zamLK1RDkgilskQoHA1B8hlnjVavwJPJmbmxBbHxbomtIkti6Uc8mj2xPnVKMmoPaWijAa6Jc+zl1lGnOpqklAZuO9Ry15OeawChP0sxiDqcN7K3zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gPqe9tPv; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gPqe9tPv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8PAzUhOg4nNdNwOtZgg7JnvvB6xPGKc/vkKRH4Yr3JwAeEx10A8keyMeqAOdgMjrXmheIt9S5jEhy+BStWuthvXScMZER8RhlKd3DZC3OPWayk9ZMuC2wF/cM7q3hQoJdiWclq9qa45PfUegFrag1/wMXM+iuHCxJ1VMtt7/SbV8DKPsEbcsK1v/vdpOn0QaXieXtA/TtHgzBNPrIbhWW2fSvDyxF8uXwSfofcqmYWgDNNZY0V6OBwFyBtVvQTaqHDj2IQdTW/SYv7H0/So/ZUCOOfiu3i7ryK9/ZcFuKAI/haYajVORPOa+FpQ4g8C2vSFXzqbWnxfe1S5vdt2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGANMnxAP6sa3/ztAcveZ3pgpH6ex6oiQKg8LrGSzWk=;
 b=Rm1IgY7ht8UGkUtpJ/ozWXJURK5LLq4tfQNGLS1EeOXSptT//bjISc6k5QSoe8SMTZJVRqu46K6zmlvyPWI/331IxpjaCy2SuUU3Iui7Y5nGVw3/MUCjEmz738GcCmCExJWhGVbLhZ2Ony1BWHYoL7MiAy8FAuq3mwpc8SSW5tAJiKMswTTlajp5GczofRO5j4NKhQD24H664UwwQO687jFANpXPLfKJyLfiwxJ9obY4jUja9riMK0gbIOydhYBziS+GY4OLtH6GwaMGD74ujK5n7CjupM2foszNPPCTGuJKzq638cjkm1xixZmOIXFF0XdEBxrRJ3rXbLFh5c3iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGANMnxAP6sa3/ztAcveZ3pgpH6ex6oiQKg8LrGSzWk=;
 b=gPqe9tPvF9lqSn22EseeAkq+9UHUPo2a+kSzoJ+r9inHkO320JySnjct83NdtLgi7IcDBOjDpLYTMCXh2hin4PwWWDcaY01DPTeUzzPGCpg/ts8h1iPVlkFsuOmwFUY9fH6ACwvyXPOUH+I4Sax22bYcP3EfMxPM5b69t6GIgocwxbuWML4IATyzzuFYRTxFK5mfCGkbdKKW8V4qDIMRnjHJhfgU2Nh+vMn5qgInsmMc6U4iTvq+X0v7XWATGt58gkSDsCPgRwckpaReIk+iCq5OshT0VyYCvZTbInrERgg1Li/6uPwIFN/tgR30kDGU9TRP0jgmyIy5NBLcSz9gNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PR12MB8350.namprd12.prod.outlook.com
 (2603:10b6:208:40d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:17:19 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 14:17:19 +0000
Date: Wed, 16 Sep 2026 11:17:18 -0300
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
Message-ID: <20260916141718.GU3968357@nvidia.com>
References: <20260905081116.106613-1-zhiw@nvidia.com>
 <20260905081116.106613-13-zhiw@nvidia.com>
 <DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org>
 <20260914121217.70fa0d93@shazbot.org>
 <DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org>
 <20260915120148.7548a8ca@shazbot.org>
 <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLG7C7MLGSTC.2GSTD84WI595N@kernel.org>
X-ClientProxiedBy: YT4PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::12) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d821fd5-aada-4266-4be4-08df13fd37d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mruOq3RmhCdeTYLN+F7s/fH8dRVtM69Zwv5ng3Odm1FZc2poYVhxPcg/tgzkfkEedC0gRCklFY9zJ5iPaIT1vG0bRSMc/mu2n72nNW3IyKU9ES1a1+m7khfzwsPgvM+yLlxu9RPaknHGcjArF+Hx3me+GzloxNJkggmrDD12GxkRizX73LGkM4DiGVBoI0uQe66rruqeSyfOBRfp6s2vsIOrWkPQ1HAOeiWbjkm6tBOLUKmcNX6qooDOMldFajunlX/Y5zR+aRGN8zIqfWo0nrt4TfzL7R4+AHPvI83ixx81NUuZ5mIhPs8x44nnYg7YRtKEQ5w73GojHpWidRyoz5S7LAUegaAvliy2DoXQWoh4MU4AUS+fiDlFWt1sIt5aq8tpvB6vjMmAamnvp+kuBm4xMWZxVDILjmgZ8UhNnfI1lOY+G8H0l8pCEyC2zDTF9nuMLE///2I0+7b4d4/GUMRjHitI6yC2gf+Y1vpJZHhzDcReOOv8GOcTqkTeuk4Tpc1d2wG/BHV6JX/WFcQHuLxSJj7Jdgczo9z2BIE4URCjCXf2bA16V8G4d8j+uSOuQT/OyNW93jRgi1GZy6FUGZfHevXOXWCOPkLpb3tLiZiDZ52SmPf78r6oZO9d15nAwJID7Z3oj8KyJs/T5eDeeRv9wkhMTdDwSjxZfnJmo30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PpYkGwGVHPZrdcylCSnoGm920n1XmNa+B39hfwBRvMYOQ73h5pN6aOjVOVR/?=
 =?us-ascii?Q?qtSSCU8z7E5kHqYaJi8Wh+muWFAoXQmD1r5XO2Hiycap1TruOd+c54onc5G7?=
 =?us-ascii?Q?aAaF3x2LV0PxInODG/bCgdziM9/Yoo0jmIbeknUVQ19sIyqVzbgrQyGx4PFc?=
 =?us-ascii?Q?a5Ul1cQDeWc9h4MNl/Xbmll2z7PHj7AIuBWNUKoiLlPJdv6J/eYqrT6psOvK?=
 =?us-ascii?Q?Uq+0KHDRoVCttJJajsW2iT7Fyi0mA52NgMn+jwVs53A25Ks0NFgGhgFkQaCG?=
 =?us-ascii?Q?R/GC4UfAy7K0I/3fa9ccBv+pAaYROk5uKAmldofttTT6mZmoXljTz/vTaf67?=
 =?us-ascii?Q?Lqfl6RfNM+kmrC5YXYedX5+wHxKlOvwojHFTdkkKy7WiiDgKB1w2JhBzgQ+g?=
 =?us-ascii?Q?nFqXByoLat2od8loKGsJqXa9X0fcU+Tg1pWtwUNAwDh+nwlNxGCy9qugG1aX?=
 =?us-ascii?Q?gBzqijBEME+YaHRz2LZYjGBsHNYOaY077Agrv5OORgkpZMlqTpUkgGwq7Ecu?=
 =?us-ascii?Q?G6p9HqqMlHNk0GbrD8Y+UUOWmGrmKStEnFfIoOjla5vFycGnxd6XM8oVSPK+?=
 =?us-ascii?Q?VZRNRH5R+H5qNBTHh2fv0Zhw52iqUrO+JFHSLRJLAS/On+HfanjlQ8JRK16P?=
 =?us-ascii?Q?eg0g0TjAY84onnpEWzS+u7Z9PnMuVsZkTEd3mo9ucvY0C8InEnVQyTnreTAj?=
 =?us-ascii?Q?E0Tab7a/I2/c7azS21uY+MolbHuvrW3xI7LmWTRJXb/FxpSf/uzKgjiWBrvy?=
 =?us-ascii?Q?1OI03Tu/Ce7lqmHOhZrFGeZvbtWbhCgtaCsWE/8M76EYem0DQ5AoZPz4X0rW?=
 =?us-ascii?Q?LO3Xj9TAO3x8FmiXvNSmd8TK7AxcLRYdliqurgkkeT1OkxgB4GARbpKMSZL7?=
 =?us-ascii?Q?fA06I4BJoAIr+YBjQJIqzY/vsomC4o9y+5D0fbVJxEbWmntn99Hy36kZNBpY?=
 =?us-ascii?Q?m0utqsfe3+Py4ej4wsB3c1F0y1hKF0sOiGSPGQltbZ26ZJssjuwIL/sSNM0a?=
 =?us-ascii?Q?W9OEiywPVmV9A7vyXWv34qGUYcFkW7YtfAiaklvfQlG8nVFr/uWxQKrR8qPb?=
 =?us-ascii?Q?xxqHqj6tPR4XBLgea0AG61CzLWWflpiDuv2HUeV3Ehlk3tpZU+knQ2kkx0H2?=
 =?us-ascii?Q?pqS0Jc+3Rdwq8fJzDCtxkGxC5IVjmbb2FGfFhTPGJrHNkV428CElzW0BVwlW?=
 =?us-ascii?Q?o/nSLwgYJcGoneKidcqfCejekiSvwv20BDe2Cpfjv4FnUi/XelBhUSgJAB8t?=
 =?us-ascii?Q?5g3pthvKFZtL3lnuP2Qn1+WtGhzB18CmJho593QwfGWW5YARu98wnRIjL76m?=
 =?us-ascii?Q?2/rQclF40vXpp6zJTO64xz8YjTAOV3itmT7VoeNGiUCmlhtQE4NN+N1ZnsnK?=
 =?us-ascii?Q?WbOJsgzOBtqEBkzRPyF0VYIyLWlEoYjTbUh6vSh6UV/iXUpPk/ochEeMUJV3?=
 =?us-ascii?Q?/HnS5Ep794eEwdjT2pmnr/PM+KEJfocbBNalXutJRct3WnD0D0SNb678qczE?=
 =?us-ascii?Q?jAPJS8URPxgo7chy9/0BL4oZiZUD5ortLrBlwwotumqfmZXrQh0lFyHLd89S?=
 =?us-ascii?Q?MPXY9Y2LfbXMg9PPeedmC5RPHJ/Tb4neAeEtwzNFVOMkcJzHoHcFTW9QGREE?=
 =?us-ascii?Q?Q0H5wJGYY69C5NDjUzOqGad+oan90gZwPyw4gXWnE+WcAfADNrIvcyyD8y14?=
 =?us-ascii?Q?pfjekzXtc9sAvUcRZOtbUS8IoIFLOfKZBpP2jZB6/NmOSITI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d821fd5-aada-4266-4be4-08df13fd37d3
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:17:19.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssW24AMJM3EPpVusyj38lsvvwo4Yrzx2uJWKyY2ezRDWVRh2tDWmI6m6UATZLBP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

On Tue, Sep 15, 2026 at 11:19:01PM +0200, Danilo Krummrich wrote:

> The driver_data pointer in struct device is defined to be a pointer where a
> driver can store *arbitrary* data for the duration the driver is bound to this
> device.

There are places in the kernel where the drvdata of the bound device
ends up owned by the subsystem, not the end driver.  Yes, an ideal
driver + subsystem should never even need drvdatab beyond remove. Yet,
things are not perfect..

The fundamental issue is some kernel API surfaces that the subystem
needs to work with only provide a struct device in their callbacks and
the subystem has no option but to use the drvdata for its own purpose
to recover the subsystem specific data.

For example VFIO hooks into this nasty API:

        ret = vga_client_register(pdev, vfio_pci_set_decode);
        if (ret)
                return ret;

Which doesn't provide a void * token to pass the core code's
struct. 

Another is all the PCI callbacks which assume the op behind them uses
drvdata to get its data.

It is not necessarily easy to fix. Rrouting all those PCI callbacks
through trampolines in every single driver is really not an appealing
design. There are alot of VFIO drivers.

Maybe it needs a dev->drvdata and dev->subsystem_data, maybe it needs
some PCI thing where the pm ops can get a void *, IDK.

This is not some philosophical thing about busses or classes, it is
just an accommodation for the way the kernel is now. Fix the above and
you can get rid of it.

> > I have no doubt that integration with a more structured language would
> > lead to various improvements.  However, it doesn't seem there are
> > resources to support it in the short term.
> 
> As mentoined above, there are people volunteering now. Without starting it, it
> can't scale further than that. :)

There are lots of other vfio patches that need attention too, and it
seems we are short of that more than anything. Now you need to do a
bunch of C refactoring patches as well just to get things ready to
show a bunch of rust code. It is a lot of work.

I don't really understand in a nutshell why we should do this for nova
the mails were so long... Can we not just ignore the lifetime
imperfection for this?

> However, I don't really see the use-case; you can't load nvidia-vgpu without
> nova-core in the first place, so it would require to unbind nova-core through
> sysfs force unbind, no?

nvidia gpu is a more unique scenario, if you are building a general
bindings it has to support the flows like this.

I've wanted to rework the way the common ops are shimmed in for a
while, you'd probably want to do that before rust bindings.

Jason
