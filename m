Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F74E36E6
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732346; cv=fail; b=XiofN9eMEVp6KyWApVkKwTXxZ+zloZlcYRJONRQGNgS4tmiVCbSlVOzFG6NzOnMlAEAMmgdxkRmLosGjQjdvzy/e29gvVvWBT/JEgRwbS1hT4MVuyJJCI2qy74RLq+sHsnB8dryHkDIyOYZTD6PrCnZpNHZ/po/vRwS0KhAmlyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732346; c=relaxed/simple;
	bh=zeg5iFxF2J4bFl0GACcGOgq3L05e8Okq5JKyTkqkU28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GFS91hNtUCtZQ7u0QWw1JUOuNFZEhIRDeuCRcb94Uvs7azNUVJO+WFfHq55WlPQlN2feBP5ef5HEgRQkdjv0MQ58JCSFYsGp18gd0F4di4lycqQ/USdycvRk9pKDgIze/Q0meKpbU4Lpa1wjKIhzjhqLmvSSNYbLajYdfOaZZ3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gyZ0DBOz; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gyZ0DBOz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEoJ5S5qITgJKHcRj9YfPOv25+HuvO701kKhW60g/5RmJ1gVjGd7i20X5ZBtk0fTdnX+1kwdC64cSJP60xjjCmcsah6ROq38MdtWCNzNsedsMJTmhBAQpAzr1MeCnvBEa+Yff4AjVz2aoKSaE7a23yVFTcQeCN/kcKg+jNZzYD9yAKEbbRWSYplNzfP2XnG7sUC/T37APyEFgRmNGN5dMIKI01wwHoC0laJpcKPrJZGDWlotsDFx5qaDwEhBQbssPckuXLdc4nVxA3Cl9auuOdatttdV/kfx76tXB46/MzIJ5tXbn188vEocUa4+7g4j6V5ocTnDfhcgttcgN9xzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJSIR/zQLt9Nq13Y1WYv0j4W6EStOQQnb/Ojycs+5Uk=;
 b=gINfVuW2horzk9so7+GKjajxhxo1LhOLxckIJIvE8BylFp111MSaftSH0jMFjbnfSyrwNrYX7h5BarXwVlEK5XyGHuX/YwSAi8vw4QMRxf+9Cf6hjIym1Vi35/1vY4BzZ1YfVaTREasFLKQzrB6olNqBcle0GxOuIJrAPpTar68NgvRsCPsV4Y1gFhLE60tsObPTRd9l8UW/hSqs+6jkdI87akjBkbDLJpvM4syNEKOZGCxVBg7aqSzXhAq1L3E+21omFuKxClO31PU5zqnANWN8mY45REYZH8sc51vs92sT30vZuH5QKuuIOHyk0bc+o/3ywC1Gw++2tNskK3VTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJSIR/zQLt9Nq13Y1WYv0j4W6EStOQQnb/Ojycs+5Uk=;
 b=gyZ0DBOz/CNVvKepe5xKbWqVi5pIB3d63jtUIor7cCSo6VwE/Tzwa6Swqxnaa/1eHABtOHbMyDNbTqWfoDpgzfULY8HQp/Ncuuq3hPpBaikKnPLnOoYFRbc5U9jwufLDmRxQeFyflEMaSezL1sG+VhYm6S3zTFZmF4niId2TYCBO5t9J+LGAvxaclihwBdBRypQW56rclJidsyTwp8PqwGyDCFzRQXwHyTFuMAQMN85oWN7X8KYM0SXIavrdgROu/5WdSQXoXK2dhd+hnqPL9IOPtPZUbAPgUrHpECTtRD8dUZpXaB7Yg4Fv0BXvAPxi9FUpDxOmCC//8Isb/V4Eww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:52:18 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 11:52:18 +0000
Date: Fri, 18 Sep 2026 08:52:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: sashiko-reviews@lists.linux.dev, David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v6 06/10] vfio: selftests: Allow drivers to specify
 required region size
Message-ID: <20260918115217.GA11142@nvidia.com>
References: <6-v6-8af36cf7b73f+e2-mlx5st_jgg@nvidia.com>
 <20260917235245.CAAE41F00898@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917235245.CAAE41F00898@smtp.kernel.org>
X-ClientProxiedBy: YT4P288CA0042.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::23) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d11d25-6696-4688-f343-08df157b4a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	U1vL/ilhYRKSyAf13p8ABBEKqB2AvfO2wkh3K1z9Mpgi04rv46luJ9Dl/W9NNxR7B8JQ13f8E6dN+6qMFumoSfy72SAvjp8ruIT8esUdMzYfZVkgUxhDbXcpplxCWdmPq/hbbhd5NyrJqXhtiEG8A+JQoYRY+FbYZ9ulZtLp+n/ZHybCvHejXvBtiyR8Gw3YJsFLZ0x14StQbOnAzC0XpaF6G54s7azAf/+UkPrBuPmFQBjJQpydgKfMrUm9hlLJOVXVKVFZbcqns5ZSMRf0mhaQGvAGk3Id7uIncQvmXzH5VGpou85TIRcOrCRpj0LnI9EEXPWMWy8UL0SIFD0J1mtrTZUOJr8gbKDLe7YOgMkAPrXpstwY039sDn2kBbPVVawN/k1GKU3E0P3p9dWlsxX3W5obvnz1fJZGCeMZOEbAf5ipcFafpIbJ2IFWDOQhxr6KIKmAqDQr8PztCmj5Ux7AyY424LDGYyOX/wbY05s1thvcrG9AB+hH15GWplQ+L8zft3sSFNVmJQNkSpLowB+xN3+eygFMz4ZCM1Kqr25N74H8KI9SauTJUI6beZ00uW+HwmF0vfgTWkUGWN1urvhAc9h3cDvVAFMp1mQSVsmi995q8NYBt4UuCGY8p/xgFabL+SNFWfoGV+5PmM6jpXB4htuMA6g72oBeOpfmsT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HVVHTF6D1tfQTxWxhzjk9gZV775u7yDpvfjgXAhlcR9XkE3pakn5LLnQ5fR+?=
 =?us-ascii?Q?EhTo3FMXzTTj911yf4OaOyc4dG+QSrOTErwbx1xnh0s6BWWHzzKnNlz2vlWM?=
 =?us-ascii?Q?EenRE83G1cDpVO2wYwQqbWuBHYTSw4NI4vBmMqBgvh0VxUi8HK/c5ww/AmUS?=
 =?us-ascii?Q?ocadH3HV+IQa87hlEGCUQlQziCVEOhTEiKT+bpm/n2HUZmzOcO/8lWq6owjN?=
 =?us-ascii?Q?Rrpqj1pJqbeN9JzYowCG+xWHSXZfUHaoOPYPvVxIa0L0Ji0GN3K4QM/yAf7p?=
 =?us-ascii?Q?DkIFmid9XC3JWjPEQ1Du7DB1wzJD6PblipMJNOUqTF0EVH1Ccl6u7KDy2PuC?=
 =?us-ascii?Q?9PSdaUkJSJGge8Fi1Z4cIXk8dUOSqgjM7lWAAGW5AuQCKzVVBHWxlVODFY+u?=
 =?us-ascii?Q?gaIFsKlGcdJTCgVVF55ti9Rie72LBLEsPSDmV1bfJpwUlsUHApKY7a6dmM49?=
 =?us-ascii?Q?jD5nDLYkc4q8njAFwB2NA6I0CYkU7JybYpH4LF55+R0iKE5KIXgxY+1fxgtl?=
 =?us-ascii?Q?GvnqLv/DVAtWWe5AKtbLxxdBoaIRpZXitH6hX+/rM5Ga7v7QgvjnItdS5W5V?=
 =?us-ascii?Q?x2ho4mpMgtWfui9fAVJQ6AsYingCvyxHGSkvFu6jehRejWxRGbbVFDC4HjC0?=
 =?us-ascii?Q?oTZN4JHUEv4UB7Bw7/CskWCFFxuU5DHdfzD5lOCIJe1es4sLq/+A4lycOQOX?=
 =?us-ascii?Q?/hXR8Vnuy2u8Jbs3ktM+YB0i53SOY95bUHGh3jWac7rlNMTiMmO9bU1Co8mV?=
 =?us-ascii?Q?sWp4iAmOy5RvQX0C/wrj/0vf1MGQPxNYT+vKXPNqJM2RwZyRnWl13ZNezvkD?=
 =?us-ascii?Q?2IZm6YF6goCknM3DvGINi3Nz2GIrr6wnJbbi+9Rkw3uXsT45FaE95H8QWkhE?=
 =?us-ascii?Q?5KkBF2eNMeE+QQ3s5Pic5JPAhstTbaLyTF+TYI2c1WE2SuLzRNBMkgBdNkSl?=
 =?us-ascii?Q?CSardMxwexRvcfUBAhigJ5OIa1+ShZfdLXHLd6ssPPHlYwvMcOi16J0q8pGo?=
 =?us-ascii?Q?1nuEMmHcutFcAks6p2FEe5/x5PMCarzw02IkNEz/P/RMuplMTXZmkEzDqVWs?=
 =?us-ascii?Q?61iVoKYBRgfI6jdO5Izk7deSSFB0NLC+2yKg+BJYDPXtpndOZD6aEaScCCSR?=
 =?us-ascii?Q?NyJaFH4zAzYqgr6zKNw/4BNXWmI/KfKhuwoQeFSqYWsZ6OmgXuM0kKKAt1yY?=
 =?us-ascii?Q?ZsncUdsHbw6HnYP+ZaU8cOphS9VOXPDp7xq4K6wFIBT4rEDlhdsEHAW4BTYZ?=
 =?us-ascii?Q?PcQvAAk0XpoUE/QRUgoVkg0RRAwNN8pu3hK7lDgJjrAnRp2RxseKJhGgHjaw?=
 =?us-ascii?Q?YOXKXgVEUkrKbCN7KQYSk06BmNEQZbYe68Xvh4VRhfgldaprRKI0sMxPnhQz?=
 =?us-ascii?Q?LfCf2VWJmrN49w2a6Hfv3pEKtUVqxZsO1Zerb4aflS9dpJTBg6l32jNxbEFS?=
 =?us-ascii?Q?N5uU9FwwR66ZMm/qahB2IgAfTs+6Ddg0dXrLjX75rR1dWMTWVVTenoYs1ac4?=
 =?us-ascii?Q?XXzDDLeysHCy6I5F9Xn9tnzYAf1Fc0q7XefKVwFIcaoWZ/I9Ag01kVwhomFP?=
 =?us-ascii?Q?5FbnXiuHRyFr/KVAKfgLeqcLqDVIJDui/XDoIS4ny57LhHLa3dUxKon9RmhM?=
 =?us-ascii?Q?yi3ddftXt3BcmAioiSoomTJ5bAaoRgAGb7P3wM0lNVeke/7koXYfB+xK6ft+?=
 =?us-ascii?Q?0hNYKauWVchkrw2ui/dRPkoBIAwtmKzKcW6q3w7gPtyIp+Kz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d11d25-6696-4688-f343-08df157b4a7b
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:52:18.5646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCeMW2orbYAQFBIpBW6i9sNlDuzeuR5bYPDLQO3Wns5odxhzmGwqiGveBmhrH6XK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

On Thu, Sep 17, 2026 at 11:52:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests: kvm/irq_test overwrites dynamic driver region size
> --
> 
> commit 97ad8ed7fec97be65848236fd1c8afab2ff66a54
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> 
> vfio: selftests: Allow drivers to specify required region size
> 
> This commit adds a region_size field to struct vfio_pci_driver_ops to let
> drivers declare their required DMA-mapped region size. It updates the core
> driver probe and the vfio_pci_driver_test to use this dynamically probed
> size instead of hardcoding 2MB.
> 
> > diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> > index 761bf117d624f..2bd949aafd731 100644
> > --- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> > +++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> > @@ -87,7 +87,8 @@ FIXTURE_SETUP(vfio_pci_driver_test)
> >  	driver = &self->device->driver;
> >  
> >  	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
> > -	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
> > +	region_setup(self->iommu, self->iova_allocator, &driver->region,
> > +		     driver->region.size);
> 
> [Severity: Medium]
> Since this changes the vfio test to use the dynamic driver->region.size
> instead of SZ_2M, should tools/testing/selftests/kvm/irq_test.c be updated
> as well?
> 
> It looks like vfio_setup_msi() in kvm/irq_test.c still forcefully overwrites
> the dynamically probed size back to 2MB:
> 
> tools/testing/selftests/kvm/irq_test.c:vfio_setup_msi() {
> 	...
> 	region = &device->driver.region;
> 	region->size = SZ_2M;
> 	region->iova = iova_allocator_alloc(allocator, region->size);
> 	...
> }
> 
> Will this cause the KVM irq_test to fail with a VFIO_ASSERT_GE during driver
> initialization via vfio_pci_driver_init() when tested with a driver that
> requires a larger region, such as the mlx5 driver mentioned in the commit
> message?

I have no idea, Dave? Did kvm start using this stuff?

Jason
