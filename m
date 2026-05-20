Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719732BF24;
	Wed, 20 May 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292074; cv=fail; b=Jxn1QAl4RRKP970phjjJHYvORqw0nIQTocxWhLsDGXjRWT+gkV+jNfq45PXreCS59+0U67G45pHZ5ixbvpzGvAhUZYJw0Fue55bQOxole3wsvTTZzGzQb9l0MFMN7WM+gB5N9Ay4r9H54FUW7csOW0dgQ9Hb3rBKBMWS5us3Vso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292074; c=relaxed/simple;
	bh=p8aRmlytLkDjaB+TXf6RGanIuWhttFdSoUzsuZzW8ME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxbL8VJ78MCPTH3JgOTHo6kV8VN4oWBgFyB5nh1PFuRDgpZyEFN+Q0VamswNhCcxxGmYYybucJOcJL6BKAZ8tNqRj2ra1G1bV5jliHqKIBJWQyM61bxLVpMidTKp+k97tLqfRLO8Jb89dgPkFdL9FoAbQMisgFcW6saeAAn2p6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XctBeU2b; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XctBeU2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah6IfzAcl2gEGCVlbTnm2y8RpbIthn8Xx3JIm0O4J44TYmDzPkQjsos2ONiEqlaoo9QSylwNdN4vj1PGUT8Ng1vkqdSFu7QQE4/sKCmynatZX+4Vp5yFKMWC4It/Y5kJhvDT5mQHM5ocM0Aka/0J8TjW0vQvwTJQhJ+ekIXjn2eQ1ceRqPt/Yp34kZV1sEcqWHiBed1laPFmOZpyiWpU04t0xd5CWSrDjm42YxlGQ7i5INvtcTZBhwFOc7PfgGvhKtQbCEGP1P1/pdtkreMgbuh+ZCMi75SC4jPcvbEGSFKpGro9rJit7FHZw2UMi6gC/S0O8K33CxgPr/NTmeFceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFXrOXLNo2NFnW8XTdpUucgGQfPB0ab9/HFASfREelE=;
 b=O6oKRhpTreimVtT+hKUlnV0bPba1jH/gDO9ylML8+e/El9wDl+gTZ5pzgfXgrptOFOIkIjuV3YxnRHNo2ja7aEcm0DEsOandOZtdAKAcL4naFfVsONQ4jwtAmmR6W1m5xkiKhoToeXx8IkYJB6J9Dvs3MODqVSBv/QAcGn0BVk4CINJA8Na6yyuzKG/0qVMLaVEhCnqhEtk52fO9nKUUznwXk5rlSpDPtpY+yEg2RzcNtw+7NFoDaoMz0z0jcu+kpl8+AocJn+HwDs7jjz9VzpWtZkKnv5WH/sLvvicMQOMgA31S+aordiF+Tqv7rIjb4KKU+UmvdbaJoUJpKggAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFXrOXLNo2NFnW8XTdpUucgGQfPB0ab9/HFASfREelE=;
 b=XctBeU2bC9oInIKLnzj/NtkMqljYA2pZmPZMLRPAmehvXnvot/LbnWvG18VYZC4yG91EEFIvkPwCJt/chJR+qxiUZCB+BxFy08j+dUGBQYPJaL3daBu6cL7ArFn/8Q8aSiQIFNSXMnQ3B8YNyswagFuLZdq6X4QdzH7GI8FAoHCA6w88VyPAaQTicsZvL3iovZLLkNk9k9TcMFbYNqMK6+yOKZTekmm/XL2mGQ73Y3NDVCsgarp1pLuwoaIBrmkChihJ0Wk8PtXE91+mhV4o9j51numi8AdE9Ab7S+VURjLC00oi4vr/n+e53JNgQS0YUgo5qN+/ePjuMW8ZoT2etw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 15:47:49 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.012; Wed, 20 May 2026
 15:47:49 +0000
Date: Wed, 20 May 2026 09:47:46 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Eric Curtin <ericcurtin17@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Ankit Agrawal
 <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] vfio/nvgrace-gpu: add GB10 device ID (0x2e12)
Message-ID: <20260520094746.660ed777@nvidia.com>
In-Reply-To: <20260519194545.41503-1-ericcurtin17@gmail.com>
References: <20260519194545.41503-1-ericcurtin17@gmail.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e335f4a-c405-4237-67c9-08deb6872503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	uPM0uARqkVGsrzXQoX2ETALFbWHNQFSwxOqZ1an+c1ws5cFdsAR6chJgFXvmgnD/AcKL29xLq41vsko6gHRkyMYBpLUlpgnC65xJ65jM/L0EBGAmhWtrMwwRUUODrsYtDPh8yvbh/3h4SXkEsO9zzfVCud+K/spocBKREbxV/PLNsD4GREidj07y6CtW62MmEyeCKx/h0v6gvLu7vQZcvN3r3mQcBD2a1ujS/NWWMuHppwRvTYDFPbji0lMqaEYrfFfWOdHtgcO8VWYtOJwRaXLeXMhUoWMOjuFesJYpYxWdAovmXVMsdKOyXQOMLEpVRrapHey42F4gxzp3CIKoe3BMFHpbzsn0/RLI+HV93De9IqEHNrjz0Nf/O4mV2SlQaOFIPvbtNIOU92ki26daOoGWDEyAtJ2BZxYoILZEBtOfAWyM7QvHUUNcAHhgFUFB9oVHVNH5Xs4g4rIzCuIdq4dLT3kP7GpLFuKaSmrzc2YZoRnQ2j3LJNuHvIKSubcNMCgUaEsU4ulFhpqXFiiY/4JGn4iHqKTQwgP6j4osEHn5ju+2Ay+qMkJteI3i4sF+4iPFy0CwZBjlJegVjYlY2wQcChmEZ5uRRsbDlF1orlkAD2+KdNi8rC1vk23a1RT/D8VF+0XCCf7nSaLY6ds4C0abiuvm3PC/8Hv/LnqI8+x+t2njzJrMuJKKt2qpE4Ko
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gK/uIaG8A8e8bD1W+0qBGLxMV7SL96eCmi1urD/JnQ7Xx13UbMFWBG/25sUs?=
 =?us-ascii?Q?hjyzd+Mjs1fAXvrJn64ZqO1qV9aGKt//UgQ6jyEbOjeSd8FObMHgIqwwim/i?=
 =?us-ascii?Q?Q0hl2O2rqfDThdD0LxdfaSLv1G/tDDzgGT7OEFqSN7sGCTk3+lFk66H48Mr7?=
 =?us-ascii?Q?H6mNxUodNGlWvNQLgKhzxttGKWUbWk/KXYNAmr/Wvb3H6Zwpwb/3KOTMlu0O?=
 =?us-ascii?Q?XWD4AR3iy+stPmS9hfxGnVM6NlJQudmPMG8iSoBWOMyaUiGvlZzNIh/5vHqW?=
 =?us-ascii?Q?N10zRoOwI8Zft6PbIVIADCLzs2FeoKf7BnMUJaoeOvJjxp/h3DCIprLTdTZr?=
 =?us-ascii?Q?CUXF712hKN+o20+Ybtznw0NZ8PllwT3hxWE0jS8aFNazcybGp059n7bc1wzU?=
 =?us-ascii?Q?bKIc+n/93271J5bcPFqJnQYwEufHlTxaC/QV1n9tqKr24711kxSNC0pe20i4?=
 =?us-ascii?Q?QBH5RHFpI9GENjElId5GIR6DY1XiiCYfNxR8tYPJeZRoscoo7+rlSYio/uj0?=
 =?us-ascii?Q?SogBuzrLqT60MIVStwJ7S8Db3naY3tbCtmwt/nPT7NkutfDs6VW8PXZ9l5y6?=
 =?us-ascii?Q?yxnx2gj65VwsGX2O6aWwGDIH+D9eK54Es0ITyL7nXyneIyJRxuWQflRgKlmF?=
 =?us-ascii?Q?Z8LIOX1dhCTLCVKgFgM8A85RrdU05o2QHwBE5sRUVjPRDFq82++oe8p6hox+?=
 =?us-ascii?Q?Zg2TZSi4rYI/hhz18Fjc2Cw+mChuw5b+crmAhIxC6wvr8HRAFZY9NlDxIg2o?=
 =?us-ascii?Q?HacDgLIFU/CgsLLQEILHOdVCrhNqRu3Sv7rI9Xr6Dxh5d1qldN60Q+1hypfA?=
 =?us-ascii?Q?61wGuY+sa22KhLaoSQeLiLVXC4ud0nEcsK7NTrCDEe5P0uqhMN21kShPx0M7?=
 =?us-ascii?Q?6mjaO950p86ohnlrkyRFk5UtIg3PJRGFjDb5njw1OK22IeV5FEczmAMssyJ3?=
 =?us-ascii?Q?HFByaONT6JAthpCxuSR/+7VjravHXgK1DPG4kWWYfewVjrqgZ8eoAbezqBv1?=
 =?us-ascii?Q?Yj3B0EAwh6Ea07E/8Zc5fiDwbn6SKcNxymVRgZmuVbbAsmxnd/zLVCqLOVse?=
 =?us-ascii?Q?UbwhpeyJ/rMNnpZ1IIPyh9H9/4oD9iFH3h10xIce9V7JqGQmNIIg5oc25O7e?=
 =?us-ascii?Q?uWWGAeQH4T2/R0y87VUHDDZ9ZPkAb/W0FVAJdnJ8Q5qPJMhxjNGYewlRPMey?=
 =?us-ascii?Q?Ch/ZMBsRItYXCc8vhc3LDVOULnEQhHyguyGmzrEV84Tq0ugHfvNK4152GZ+i?=
 =?us-ascii?Q?9jLUOKtpmtUHlMc0O0cD+UEGEPd6J9B276FNb4LtRY46t6+x9lg0Wm5QZ2aD?=
 =?us-ascii?Q?DaeO7EUtbQ/HKj8Fs6qKmw8jlWjRqJuk7QNuyhiDewxQppcn0aP6ruXK/mZM?=
 =?us-ascii?Q?wzJYlkNpMWGwGr7SZHRceBxFn54EcMw70yuSlFK39LD7iPhqzTXtrrhCDtsJ?=
 =?us-ascii?Q?9ystffzFoKA8Am+VewZsvjstOrp13JHT4ose0NDxx4YnwhDaq0X4Iuv4TaH7?=
 =?us-ascii?Q?h7u7akcS32uFWOCSKltO977j44jfIEQcZsX2O1nlg+mkq5Kxa84rcNV4fqrv?=
 =?us-ascii?Q?Nyqq6MZKdUn66xthRtqRhLulE8Q+e3IdTJLZ7vP31zyRL8FkY+k4+dmN/FzC?=
 =?us-ascii?Q?g7EcuFk6wpsU3/ic6BiPK5VOiXNXPsandgiQF6z60vQsqf7bA9jLL8gKXdMQ?=
 =?us-ascii?Q?vdgJEGXZxZm6MoetUUeTOdVOgzOCFNmGMACpUBzoeZ9ESxCaVGkFoVM32s5Y?=
 =?us-ascii?Q?RH5R9ugYbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e335f4a-c405-4237-67c9-08deb6872503
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:47:49.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBcTxIBgiRYPY/AeE2/vXRAM1tI78Ucmy6oHfB22pYYNIImX2gAmMbAIWNDncJiUbO8GXSa5kSr+FnOvb+3BnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006

On Tue, 19 May 2026 20:45:45 +0100
Eric Curtin <ericcurtin17@gmail.com> wrote:

> The NVIDIA GB10 GPU (device ID 0x2e12, found in DGX GB10 systems) is a
> Grace-Blackwell chip that shares the same NVLink-C2C coherent memory
> architecture as the existing GH200/GB200/GB300 entries.  It exposes
> CPU-coherent device memory via the ACPI DSD properties
> nvidia,gpu-mem-base-pa / nvidia,gpu-mem-size and requires the same
> specialised BAR emulation provided by nvgrace-gpu-vfio-pci.
> 
> Without this entry the device falls through to the generic vfio-pci
> driver, which fails the iommufd IOMMU_RESV_DIRECT check because the
> NVLink-C2C memory apertures appear as RESV_DIRECT in the IOMMU group
> reserved regions, yielding:
> 
>   vfio-pci 000f:01:00.0: Firmware has requested this device have a
>   1:1 IOMMU mapping, rejecting configuring the device without a 1:1
>   mapping.  Contact your platform vendor.
> 
> Tested on a DGX GB10 system (aarch64, kernel 6.17.0-1014-nvidia).

This is proposing a patch against upstream v7.1-rc, not a vendor or
downstream kernel.  What relevant testing against upstream has been
performed?

It's unclear to me how using the nvgrace-gpu driver rather than
vfio-pci gets around a RESV_DIRECT mapping requirement on the IOMMU
group.  Can you elaborate?

The requirement is enforced when setting the group to a container for
the legacy path or when binding the device when using iommufd.  Both of
those occur irrespective of using vfio-pci or a variant driver.

I also don't find that a DGX Spark GB10 exposes the ACPI DSD properties
claimed here, so while the architecture may be similar, the support for
the nvgrace-gpu specific functionality doesn't appear to be present.
Thanks,

Alex
 
> Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..ac1acf41df86 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -1244,6 +1244,8 @@ static const struct pci_device_id nvgrace_gpu_vfio_pci_table[] = {
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2941) },
>  	/* GB300 SKU */
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x31C2) },
> +	/* GB10 SKU */
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2E12) },
>  	{}
>  };
>  

