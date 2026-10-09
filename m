Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F1466B58;
	Fri,  9 Oct 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574104; cv=fail; b=oHiOVl/NHK5vgBkN8BoYjrlNJyJg0OUJ0QRpGPsW4XKYmoH8ulsQ6v2UjUSu+H5sJa7iuJ8z+vkcYdAcxSWL23HrhPSTA1LgzKFJYsH1LpYLcwGOrM71kxnXM81Y468juY3WRCvV56tLRql5Cy/QcX24/A4ti9XMniFw42uwnz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574104; c=relaxed/simple;
	bh=fG0i3AWzPgxKNDFDHXgNwVK7E87e+Gf4PH7A9WF/G9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdDiY6LKsHTlFM72dyxQbVttS9iFJmno4ba7dOCpruN52Fj62QpXspTIJQmn760ljvcygwIBNj163XNT/OxC9r6LXxbtFzGbrW/RYvW2JddaZOkrEuUvG++AlWXKwfJOGD/vhDBIB5GeYSJi3/RNEbPQdv5k2yYUcr4NJn5/MNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8/mYDB+; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8/mYDB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3kpaKTUKHRevVM0uAvqWYppJrN9MeEk11VMr5+inYa8Y2qlWS1WP+c4P5PvdUk1Z5cGu4V4Jdv/mzFW0pgfqYcKxcyHhBMZMaoZAoH1PIbEJsgxmK80upJKcGApev3z8bacHvLW8m1Sg3V51GODMDCsRCy7q58DlCc94fQou+3uKrsrmWkkKJE54TEtD9KUv4kkaRpNAZvgAoepT0mjxgAIe9sCQDurSeUKliQ1R3ZEIOmaGHE8TefHDLFmL1ArI7Y89AENAxov1/M6/YHtLodk0Tf9GlTnje8cNE0X4XBujhN6lpkToG5YFgzJvZweGqDKMFOLd8EXSlWDF87qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1qpbK7D/kv2yYt+LzbsA15RoBWTDEyQq/aIdwO4Pls=;
 b=kpoMI/3HmzingIxSOnVK31Z4bACQb0cvKeAeMWjf4+P0JZi4xJvu58JtM9XyIbynpOV0tNZO7rDeq50+SydILjvF4GOLL0voCmUSvzj9sW4FxoypvUR3MtmJbc1EsVNY/MEGpfxzOKXwyckNt81t+JbVv4Ahhkww54Dwy8OK7M3w9B/WOb0/m/QEB7WGmGxLJ2aVZtsaQ1dwYkRupF5HnY9ZKxmUuMexQ7lsC4LRScykoWOuybWacnMin2BEA6jKNnTkamVyF56FaOdeIiw2li3JF5cI4owpB0oohT32lOd4Qhy/UvCCAkjTdiMqcKdoVNdGMla52AZrDD6hneWUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1qpbK7D/kv2yYt+LzbsA15RoBWTDEyQq/aIdwO4Pls=;
 b=C8/mYDB+URnoCIVlPw5ixwGwfTufxxBmMMRg/QBG6rWBbL5ro8UlVgC+K/bjJ8LigC5v34xS2eYGFwl+VUnFKSDRivJnbLYMEVHbWypMvMBRWle4bEpwemfVJ2z5VRrQMl0OAWCUCnWWlCKt47eTD/fXK6DxYzT/VmCtWiTl2o66LWomH8YYgvagzCPT4pkan/gWZKPu3FbF7RCelJARefGUZYHasTlPJXw+Z5fMOlhiMhKUrbuw/SaP6GUWs6HkaxwY8k3UKdWdOVAXaz4sX9iK4ZrwFUYqAy4L7yshQh1QW66B0E83DtMEe/F4Nvzkwet7CTXvQdyuHbML1MAziA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN0PR12MB5955.namprd12.prod.outlook.com
 (2603:10b6:208:37e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Fri, 9 Oct
 2026 19:28:01 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 19:28:01 +0000
Date: Fri, 9 Oct 2026 16:28:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Simon Song <xinmengs@nvidia.com>
Cc: alex@shazbot.org, dakr@kernel.org, acourbot@nvidia.com,
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com,
	smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, zhiwang@kernel.org, zhiw@nvidia.com,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v3 1/1] vfio/pci: Remove the core dependency on driver
 data
Message-ID: <20261009192800.GG13920@nvidia.com>
References: <20261005184236.1946167-1-xinmengs@nvidia.com>
 <20261005184236.1946167-2-xinmengs@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005184236.1946167-2-xinmengs@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0504.namprd03.prod.outlook.com
 (2603:10b6:408:130::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7122d8-6452-4f03-1ff9-08df263b6ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	COoW11bikGUk9SxXzqjUpoTmsGSOLmfkTtl7+dPAnvX2tATZZpZiHDqb2veCEptHdmSzibcoIUiyJNG4YIkMnyFBL6MWk4U1kz/XtB8D/FOP1Rt9bsYjsJ9sl9hUTsntPMQfTHwdfFaoOOEVlOgPpzm2O1XNwRYqYtQq9/9Xc0lA1y1249Q1HABfxkIcUXdxN7WyWAk0tHNVF/mP77C+26f+fT9pgTUUWZD81HnBJkZBfTJL8uLqXF+FUdeuVyX399s2y66zwHvElRLw1hQxSg9LfpzIEy6tYmvRus9Kx5TeSMncdlEtlf1lJ/5NL6mWO3kpe6AiE9QaRiQawX+b1Clsm/x7IFLcLG9tA7o46B6B+QiM4zEGm3CK+tU+XGFcuegO4qygJJYl4bfzNnsZ7KRFQBQvey3uhbRb1hXrv22d2dRa52CVrUgmdWUEhBQQfr3EP8FWLCVpRJtRVQ97uwtXg8oH4A67wjlkESEo+IGb8tZxheqqHhYTttazEzMYRQG742qHjdCThNkQANOGCnQQif6nDWSNy+xDrQBWIThaPfyWpRJl6iQa4DPEhdhOQ/lVORC/g3uucHoAChAL58fBimZnk3H5RvCZbUV4Xg2908qgynoOpilAm9TSkZbSZy9oyNE1RcyaA6JObokyupZjgysZu2ZrnsRXjweWMU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9nM4XZ7qxxWqLmyTqf/1GMUiYeQxrXcLR0x6lEF6EzHZ5kqwFBKBp2iuLuv?=
 =?us-ascii?Q?6hCkn7tIiimEC3ZsZ3SafGwanpsBA+sM2qTVVHOQDs11eRv+KE4b3tcldakd?=
 =?us-ascii?Q?4YPKxraJF5oxqEMVVDtgnhQfcoF4SRZqM+h1d0b0ayBNQpYbo/ZZwbIkwGbz?=
 =?us-ascii?Q?TQTqCz9dbIhTu1kjvVx7r/y4IIlHkLSmNHgKg4TuKaXPERBCXwBQd7X8uhfM?=
 =?us-ascii?Q?PKPHRW1vUkXGqh1V1RQeGgYzML2ZLynTZpeyaA3M4Adf+IR31RtZtvsfC0Bo?=
 =?us-ascii?Q?ho10pGu4UuA2eyNDhrtNkKAG4/p0iTzF0+pSrGREnOabxAeZuY/morEUraFX?=
 =?us-ascii?Q?dHWLGgF5Am+0xvq9MSV2LUzM7g7YeQ9l6frQPlltxPpVCReqM5SJmgfl8IZH?=
 =?us-ascii?Q?Qt92Mk+uCWSZxT/ZP08DZnmQNrH7seY3CuBJbcdfcfeBX1JrQRc7ksM9xhnK?=
 =?us-ascii?Q?p3lQg4F5/RNCUaaD2zditrLG1I2a6YlUmiI7Q/u39RPAcB7TCDUQLf21ri4w?=
 =?us-ascii?Q?6M3tA9RircEMUsB7FhctHGbapgclN4TNU13GSmJb/q3Tfl5r/TaIYUXNK2d2?=
 =?us-ascii?Q?OSRGylHKWT9VdlItUroZ2zBfZ1PoiVY/f3bk6VOWtvDl5ougKNXaWrswPzeh?=
 =?us-ascii?Q?J1gP04JZp1jPkksfK5XBwNVrXnOLjB9gm++wCoy7ZRnl7yJexsR0gcVOiqhj?=
 =?us-ascii?Q?NIU5FyHtVu4L+NF4vh2d0Q/vZgdKWAkh5HUdbX0DdJSpwehPnN8TkGnR3TGP?=
 =?us-ascii?Q?v6vxlCypYGK2szO5SClapqkfAwp4kitYAT7FVQTrVswETDRD79lHvwTKUqXO?=
 =?us-ascii?Q?v8c5adtQuh0AsAJdFEJQyFkmBjCUc9S4V9IIoMWil3LlJEeOGs2KoA6duU31?=
 =?us-ascii?Q?cIsnlorPGpSUbQFqNGccN2X93OhMQAK4Y/wopUgbkzYk8ByV0JTTa3sp5E87?=
 =?us-ascii?Q?ZV0CeUHX3fZCFGMrV6Fv3krJwk9pkRpyTzX1AIQQjyXOl0dIlxTrCsmPsJet?=
 =?us-ascii?Q?mHDk+uDQNz4epRE/+vI8FQOXYvwyc29ZcbI9SlTdWDyNK7hYnGX7+lYZgrGi?=
 =?us-ascii?Q?AUgbwCW8qHUdZXp3bPq9ttmkZHirq3qz0F/4rqpvJYFyGWSa7IqOcaUhdepo?=
 =?us-ascii?Q?UYM5ofauVHbYYONvVSNBPfymqEKlCcaxwW03JMiPdrrr9EGTGy20rDXswUXo?=
 =?us-ascii?Q?BpyaM99TAki1mR2QbRiOfNciMYp19nS70ogZOauv+72cZ/gPUQIewN2+sAAc?=
 =?us-ascii?Q?Mj4d8m7nTfo0pvq/WakeftDOwQGcHWPUJrGWGnlypyY+KoVWa66ghWD6FkgX?=
 =?us-ascii?Q?G4jBqqZvIFhWUp6bX/bh5SbQ5+8MX2aXSPjPsXqAOMuIy1AKKU0UYF1mFYCN?=
 =?us-ascii?Q?kR5/Ig5o13ANwu16NiPk+KxwwlHqTRMPejyLOx8FEmxYGPQlZBlkieV/mJ/J?=
 =?us-ascii?Q?cCx9Ny/20DRbdQfa8sR5/MZphPERY0NdHIcRlD+1g+PZbKYmxWgJVTa0KW/m?=
 =?us-ascii?Q?vxPUrDJ+eoeg68QRkCB3T2A25zSSyqiUnVh1oXnfudPxCdwSXv5+jAMlgkZE?=
 =?us-ascii?Q?DQGs2/If9QMw1wjXHjAg9bi30y/GvE/87xCfTyxcfbBa6tFKAuU7YhIYzHn7?=
 =?us-ascii?Q?6Kyh5CCg14OIyiiUA3yjoBl3H+pXY6xcYcxgDM0n7CokptbuSDOv8r8V78dF?=
 =?us-ascii?Q?0RIqaUgkNZ85SNbOOWcC9vD7fuQZ7cyCxhxGL91MtZkNA757?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7122d8-6452-4f03-1ff9-08df263b6ec9
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 19:28:01.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIUSHizmCi29WBneK202AI4QOhZzyjTdwRz9/kbYwvdeeetEMDbFAONhaEslvq5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

On Mon, Oct 05, 2026 at 11:42:36AM -0700, Simon Song wrote:
> vfio-pci-core currently has runtime functions that interpret pci
> driver_data as a pointer to vfio_pci_core_device, and enforce vfio
> variant drivers must set vfio_pci_core_device to their pci driver_data.
> This constrains variant drivers' private-data layout, including the
> typed driver data used by the Rust PCI infrastructure.
> 
> Add VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
> each vfio variant driver, update vfio variant drivers to store their
> private strctures in driver_data and use generated wrapper to pass the
> vfio core device to helpers.
> 
> Select the vga decode callback during vfio_pci_vga_init based on if
> vfio_vga_disabled, the callback only use pci_dev and does not require
> driver_data
> 
> Assisted-by: LLM
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Alex Williamson <alex.williamson@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 27 ++++----
>  drivers/vfio/pci/ism/main.c                   | 19 +++---
>  drivers/vfio/pci/mlx5/main.c                  | 13 ++--
>  drivers/vfio/pci/nvgrace-gpu/main.c           | 19 +++---
>  drivers/vfio/pci/pds/pci_drv.c                |  8 ++-
>  drivers/vfio/pci/pds/vfio_dev.c               |  5 +-
>  drivers/vfio/pci/qat/main.c                   | 12 ++--
>  drivers/vfio/pci/vfio_pci.c                   | 33 +++++++++-
>  drivers/vfio/pci/vfio_pci_core.c              | 61 +++++++------------
>  drivers/vfio/pci/virtio/main.c                |  8 ++-
>  drivers/vfio/pci/xe/main.c                    |  8 ++-
>  include/linux/vfio_pci_core.h                 | 41 ++++++++++++-
>  12 files changed, 159 insertions(+), 95 deletions(-)

This looks OK to me, but it probably should have been 3 patches,
mixing the VGA stuff into all of this (and you have a smart approach)
is not how upstream likes to see things arranged.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
