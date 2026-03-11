Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E622423A;
	Wed, 11 Mar 2026 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211636; cv=fail; b=nRRnw3PVf5v49JU8IU5q75f3W0LvRSp3O5Q6O5eGwZo6ywxgPz7a6HqePu2nUj7wxameUwCgErbyXMHo5LTg7P3Dfc3s86xiv33/ItA1+xX7EWA8eTBgqUatOiXn//jZX6016l1k/zw9Gfzd7BMVjUixY2ZTw6KsW3jUoCQOSN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211636; c=relaxed/simple;
	bh=goPB+tTM8imyh+LAssnq3vtHoz2QxpMeuq8pfuwgtng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l9jMpOzuRlUIfit5y29gos6iLcZG2siK//KHWC89ejKHM0NQYJE8T/9ns2bM+nM5KHwmUgJRsvg0Nn2TYgYMUbFYZA2NYz2kHGgccDO6cSpsGQOKsUfj6pezfkRgrwB3s2l+GJ/mllNFAs9y6p3A0VU+dciLSJYtJbrLhThK8BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upBdQaxE; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upBdQaxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwZ8xIiROt6ImfN0rcslEg4SjHUldjAiXS2tuw0Gh99v/AKCmOF1eMKUbbVBCBVMBXmzjFxpO40aFZ8xb59oiWdtaX6WMEVOvWDBLXkHUA/DZQpB3PznRkhwONoZAhbUUhOGsjZPfufQxdAFwamV2SF66eD0o+7/bJQ4lVjnJZap7J+mdOULkhI/HUEIHskPMluvT93PDhEYr+CFSOdGlJPFhd74XLkiY9aN3NSTyW0B9cmYMCJ6jZUG/8j56I4KE3qK5cobJdzIELt9mYDpBET22KEK56/d4QH9eNNZQV1VzQkXvnejHpn2mTmGTQYaJHneRLMMeWaI44TnSLQmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KoVG+lg2+9Fu1Gc8mi8quPDzmazC6SlaCzUbiua2Z0=;
 b=DDF6Dxd9sXcUBfQzq/o0JdUQJoY0hx3PEZLxNc4+ar117wjAcA4gLZpgw8znWG51nmr13s2UgtYc6glQ0qXW98o/14TC9azdbfZEDyi7wpgQH1mZpFw4SvHqG1NDOjGIvP81V13qPcanaF7T5HZZPQ6DADEuaBIUk2/r9V6sxwH8qQF33fK7wpteIXSuT6f6hzCL/annDeF473pgJrxmq648iNHAIrvdziQ1/5sUNd3lKH2TShyy62Al5VjiJcdf1/4aK40k9QA6sIw7qHxdApD8JB2jfCDDvtbLfr9vwhfjwipy9xpGZZQc7aGiUc5hnDvbLngg6nhWsi0/KU0YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KoVG+lg2+9Fu1Gc8mi8quPDzmazC6SlaCzUbiua2Z0=;
 b=upBdQaxExptDSVAikBcuw2YYU1QNrg5cazd/50qpGx0tyZgLkDhvrvqoDyvqyNo/+SGhDO3KZRI7gFqJgyLH457pLDXD1MvTtpyC5UPwqwa7Nz+JBcBifzWy3vr37lSDOhjx7wi5xXf58FOzs92qe8umxJ2AiIXRNQ8a+9+s+1oWrKLO5KCwUOC3eB3qDewtZZ7nWoELPiFM8sRUMVuf7PtXiAqJrfmNZCtC6B3Wxgt4epblyCRH0RFlxcDG+ONjzawkruw9ViYZkntY6pGJ0erOyvloXrwV6SbVbLoxX2lY8D7q+0/S7fmwRBgoaBwwwFGOU9MJ2sTPjYkZdpbHDg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:47:12 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%6]) with mapi id 15.20.9700.003; Wed, 11 Mar 2026
 06:47:12 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, Shameer Kolothum
 Thodi <skolothumtho@nvidia.com>, Neo Jia <cjia@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 00/15] Add virtualization support for EGM
Thread-Topic: [PATCH RFC v2 00/15] Add virtualization support for EGM
Thread-Index: AQHcpNzaOt1igUkxvECzSrGf7z/GFbWgQqmAgAivw4M=
Date: Wed, 11 Mar 2026 06:47:12 +0000
Message-ID:
 <SA1PR12MB719904F9ED153FF4BA4EFA28B047A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260223155514.152435-1-ankita@nvidia.com>
 <20260305103335.74fb8141@shazbot.org>
In-Reply-To: <20260305103335.74fb8141@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|PH7PR12MB5620:EE_
x-ms-office365-filtering-correlation-id: a4e243aa-4897-4aff-720e-08de7f3a0630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 FG5Ha5h3CP7u4x9npA/qUWCwBlLDMFPNdO2d4T3Zl++DhHC4fbUz89E9QtjY3oZc7nISk/mJ0q3h8M7o89tTU+qfrdoHovtju4pl+MSXED6biDXKKB7UYuwDaXOoaPLr0gaMMMZyfRy3HIHj6lcmXVoCoQgtj98xler6LlVZbv0U+h/sza3LjRKSFCUnJsIAt8doGYYpFUMpZvDAcfwuQDNVVz3GWtKqDR8f7taGGgXlVbCOxdpCQ/Ju33w1Q170DMwQMIhGFNahf3+zFVVoXsIRiNVr4XiGtch58gLmLkgcEDB5TyLwRv/3SD+jnSxzrorC3pgCF2P2iiFDrvzqdqJc+7d4hmH7eWtQVVy7m6SOO9sGH8onABbjvor/5t80WZWXZPyYLHcxVZ7rJvhkIZHJIlWaJGDmN7BkJpctXzHgn6+DYyAmSuWiyxTMTfXtroD4Q32RwlvC+gigncIpL5eadQ09Wbe7tERttuHHHQ3k/Jm+BKHQPnBhqkuuCYQWSx9yz1boJOMYcmKxh2hxo/zakO8BN9JVBpet9pX2qiRoBUSp7CGkZijCNRGVJB/K7D/1g3R8Oji61YB+BTIFPWR85vVZ5cTzJ4dSi+fEKeoWOK+RRXAXwZ7rliRyJeBpXEcblEeEVjRmSYYcleXHdwytlrVfhzNUBrSZ6sAjnO4T2WfdMCi00JCKHSUneg0D4bGG/XEZhhMnx8KI3lHsdVIy9Mdm7uDwDyAS5+4C9hnK8CxRV29pV0jhHUjZSkRLKtnUKDOyHXllyOvjxFQ4qzP4Dql+Xf2o1Lir2CknMuE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?reNWAf8VVKbHzkTTppt8V7jEwmISjU6BHm2jdJ8qYdzcfifHAtMXxOTHju?=
 =?iso-8859-1?Q?MfkhcyjJiDRZblgYqtZCOGZb5yuXaEwaC3N4sn56aScEDh+IV/xyi6zzV4?=
 =?iso-8859-1?Q?SAT6mOi1v/D1aAiUoEtjWC02CME9Me/7GI1UYpLlxP+sGRxg8pBt/ehEDP?=
 =?iso-8859-1?Q?VaWwSN5zFffPys0Haeph4VzSg5AeFcrbjga5Nu37juHRz010VBa33ft+H1?=
 =?iso-8859-1?Q?5xKWH6fs4xoCBOfAt0dYL3EQS0Qsr8qpTZGwsRUZukif5RVjPkBkId12BI?=
 =?iso-8859-1?Q?jToNOrWrmtfMBfwvFWq9KKMSyNGODMXnZzEiNgO5v1pJQQqroDVDIqRXWD?=
 =?iso-8859-1?Q?RYmxetjdK3NXIzeEkdMu6woVwhvOiM/NWvyKqyv0jSwr2qzeI7zzspNgCd?=
 =?iso-8859-1?Q?LfSl5HdykIUuDulEhMHfu5c0Xi9mf5kNtOb4Li6/k6qS6KMlJfOwAyBK79?=
 =?iso-8859-1?Q?eQGrZ3M7bZD2mwKh3saeKIQkVY+GryKd7Le7nHsnlM6NXovSt19ULmYfSd?=
 =?iso-8859-1?Q?9EI+9ObOSRuUY/NBvx2mRLpq2zlL+GkJ4FJKT1kNYYdGeNeGU9GmQMZilm?=
 =?iso-8859-1?Q?cHk5673cQLTWPJCDTKVhjHsuPi9h5baATBs78HbStj1OMo+V2cK8yQ6F2H?=
 =?iso-8859-1?Q?LW8z7tImsgFviYDW8jSa/+JTzX3i9Wbtj2WSVPMsmkcFqAJvWez2D7flpf?=
 =?iso-8859-1?Q?a1ZwSEHJIB34QLKMFiRBkcvg3vWqCOKAZKXeBCl28KarnkoMyJD6VFm6V0?=
 =?iso-8859-1?Q?nzbOPtrqieksEWWcm9az+/1egdvJxv1QfV9dTZ2AnrsYjXS+HVFDTdLMgK?=
 =?iso-8859-1?Q?2wHjtQa4LLgEkjTsMoNWpYrlKvY+PTofjlk7JcOTKcpJCR95vbaHek7Xjj?=
 =?iso-8859-1?Q?zMIEwrlTR2lKssEW8+O8CGyfsF9FNUE6u8uJBM8YjBPrScEd5u8CY6N5JL?=
 =?iso-8859-1?Q?0aUrcwWQx/oL+WNnnWoJlIKgmJzsTEL6qJiIqBlEJezMaQli3KXh2DL7UU?=
 =?iso-8859-1?Q?KMsRxizRzggCG/hcv6qaeY7cEXshgMcsS8Lk/I4dh4udUyCjg8tNpP8Ali?=
 =?iso-8859-1?Q?X3Pyx/K5IONVRE9qQIlnM4nerDYbPo29CGB4J25o3z6erRRUpJe+DuwpyG?=
 =?iso-8859-1?Q?9mjAXoa8j3tXpL+u2Q4rgHgB1cZlDLnTgYB58fc3a/60dmjtPvHErfT9AU?=
 =?iso-8859-1?Q?BI9+nwRzoHpOSkHc7jMXAhcE4xDy1Yx9gy363RmeFyVkEIOEGdxt+0J6Uz?=
 =?iso-8859-1?Q?KcfnDQiE6a96I0Z8d8Me6LWt5DLygLuHqsInh9bixCCpS5XTrWIYvx6TQ0?=
 =?iso-8859-1?Q?RnQRWUoisDxLFIg8bhvPXx/TRf9oOFbGZkhYZnIa0CeKcpDR27xjM8pgy9?=
 =?iso-8859-1?Q?mpHSkByrTqT/KVZkLCf1RE0rrvNWJj9RsX2OUVhfNxnHX8Oxj0yr8/TzyI?=
 =?iso-8859-1?Q?3EWYs+LnsAmZ0fwEPPOKzooXWY3Hvb9pL0SljPPVaNw5uaygb5VIuK/MOz?=
 =?iso-8859-1?Q?3Ad1nddCEo6iSw6tujyfRN4ufCnMDKDMb6tSv1GcC/xeKwLprNOM7UoJuz?=
 =?iso-8859-1?Q?jw0kmDkCJ+7WYTdxFzAtwZ3dojU4+jyTH0wYRmmMCIUUTWfQgPLXqCX2q0?=
 =?iso-8859-1?Q?gE7knwFhw/DnbenRyTUNe4c1orsHL9yUq3e2PhyrDY/I6MXOQqkF+hj0ZO?=
 =?iso-8859-1?Q?hbTkI30TG/U9sYBzAWUXAFcKXDJcivJFH/BGmodO02KzI5O4v8QZ6GQTTS?=
 =?iso-8859-1?Q?fbu26mDNnH45T4FGoXJakcCQeZ1d9D68HWu9rUkI94qzya?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e243aa-4897-4aff-720e-08de7f3a0630
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 06:47:12.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2ZE3m2CFm3EA/vHvrnMlYE65v2gWeNCZpD63SH7yTm+80RagdDtCcjU8dzerCvcyw/bJfrRBkCyVgIIsoHytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620

Thanks Alex for the review.=0A=
=0A=
>> The patch series introduce a new nvgrace-egm auxiliary driver module=0A=
>> to manage and map the HI/EGM region in the Grace Blackwell systems.=0A=
>> This binds to the auxiliary device created by the parent=0A=
>> nvgrace-gpu (in-tree module for device assignment) / nvidia-vgpu-vfio=0A=
>> (out-of-tree open source module for SRIOV vGPU) to manage the=0A=
>> EGM region for the VM. Note that there is a unique EGM region per=0A=
>> socket and the auxiliary device gets created for every region. The=0A=
>> parent module fetches the EGM region information from the ACPI=0A=
>> tables and populate to the data structures shared with the auxiliary=0A=
>> nvgrace-egm module.=0A=
>>=0A=
>> nvgrace-egm module handles the following:=0A=
>> 1. Fetch the EGM memory properties (base HPA, length, proximity domain)=
=0A=
>> from the parent device shared EGM region structure.=0A=
>> 2. Create a char device that can be used as memory-backend-file by Qemu=
=0A=
>> for the VM and implement file operations. The char device is /dev/egmX,=
=0A=
>> where X is the PXM node ID of the EGM being mapped fetched in 1.=0A=
>> 3. Zero the EGM memory on first device open().=0A=
>> 4. Map the QEMU VMA to the EGM region using remap_pfn_range.=0A=
>> 5. Cleaning up state and destroying the chardev on device unbind.=0A=
>> 6. Handle presence of retired poisoned pages on the EGM region.=0A=
>>=0A=
>> Since nvgrace-egm is an auxiliary module to the nvgrace-gpu, it is kept=
=0A=
>> in the same directory.=0A=
>=0A=
>=0A=
> Pondering this series for a bit, is this auxiliary chardev approach=0A=
> really the model we should be pursuing?=0A=
>=0A=
> I know we're trying to disassociate the EGM region from the GPU, and=0A=
> de-duplicate it between GPUs on the same socket, but is there actually a=
=0A=
> use case of the EGM chardev separate from the GPU?=0A=
=0A=
It is not just de-duplication. The EGM is a carveout of system memory=0A=
logically and physically separate and disconnected from the GPU. The=0A=
uniqueness here is that the information (SPA, size) of the region is presen=
t=0A=
on the GPU ACPI tables.=0A=
=0A=
>=0A=
> The independent lifecycle of this aux device is troubling and it hasn't=
=0A=
> been confirmed whether or not access to the EGM region has some=0A=
>dependency on the state of the GPU.=A0=0A=
=0A=
The EGM region is independent on the state of the GPU. One can plausibly=0A=
bootup the VM with just the EGM memory chardev as the backend file and=0A=
no GPU.=0A=
=0A=
> nvgrace-gpu is manipulating sysfs=0A=
> on devices owned by nvgrace-egm, we don't have mechanisms to manage the=
=0A=
> aux device relative to the state of the GPU, we're trying to add a=0A=
> driver that can bind to device created by an out-of-tree driver, and=0A=
> we're inventing new uAPIs on the chardev for things that already exist=0A=
> for vfio regions.=0A=
=0A=
Sorry for the confusion. The nvgrace-egm would not bind to the device=0A=
created by the out-of-tree driver. We would have a separate out-of-tree=0A=
equivalent of nvgrace-egm to bind to the device by the out-of-tree vfio=0A=
driver. Maybe we can consider exposing a register/unregister APIs from=0A=
nvgrace-egm where a module (in-tree nvgrace / out-of-tree) can register=0A=
a pdev and nvgrace-egm can use to fetch the region info.=0A=
=0A=
> Therefore, does it actually make more sense to expose EGM as a device=0A=
> specific region on the vfio device fd?=0A=
>=0A=
> For example, nvgrace-gpu might manage the de-duplication by only=0A=
> exposing this device specific region on the lowest BDF GPU per socket.=0A=
> The existing REGION_INFO ioctl handles reporting the size to the user.=0A=
> The direct association to the GPU device handles reporting the node=0A=
> locality.=A0 If necessary, a capability on the region could report the=0A=
> associated PXM, and maybe even the retired page list.=0A=
>=0A=
> All of the lifecycle issues are automatically handled, there's no=0A=
> separate aux device.=A0 If necessary, zapping and faulting across reset=
=0A=
> is handled just like a BAR mapping.=0A=
=0A=
The EGM memory (which becomes the system memory of the VM) cannot=0A=
be connected to the GPU reset as it is unrelated to the GPU device. We woul=
d=0A=
not want that to happen to system memory on GPU reset.=0A=
=0A=
> If we need to expose the EGM size and GPU association via sysfs for=0A=
> management tooling, nvgrace-gpu could add an "egm_size" attribute to the=
=0A=
> PCI device's sysfs node.=A0 This could also avoid the implicit=0A=
>  implementation knowledge about which GPU exposes the EGM device=0A=
> specific region.=0A=
>=0A=
> Was such a design considered?=A0 It seems much, much simpler and could be=
=0A=
> implemented by either nvgrace-gpu or identically by an out-of-tree=0A=
> driver without references in an in-kernel ID table.=0A=
>=0A=
> I'd like to understand the pros and cons of such an approach vs the one=
=0A=
> presented here.=A0 Thanks,=0A=
=0A=
We didn't consider it as a separate BAR / region as the EGM memory (part of=
 the=0A=
system memory) is unrelated to the GPU device besides having its informatio=
n=0A=
in the GPU ACPI table and becomes the system memory of the VM. Considering=
=0A=
it as part of the device BAR / region would connect the lifecyle of the EGM=
 region=0A=
on the GPU device. Also we cannot consider zapping/faulting across GPU rese=
t=0A=
as it is system memory of the VM.=0A=
=0A=
Thanks=0A=
Ankit Agrawal=
