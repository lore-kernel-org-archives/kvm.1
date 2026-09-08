Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C673544898;
	Tue,  8 Sep 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876161; cv=fail; b=lblLmy9nCy9pIDCZrjO7XYoO1yI3BRzyDI8syYmeLXlcUx8DKtq/BlBHeQV3eu/+Q0r7xcWp7X6YpY/Tbo9f/BNR8P3ypaFi9G4l9leOZtgfQatDzbNjv5bscwxNrg8IiVNlpVTXlnFIHW6hc0jm8gsVaw/dKXcv9DFjcC0OPto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876161; c=relaxed/simple;
	bh=tsu9lWKpElmnmgtrKFGDDFUQr/wTXgppVPT2hVYJdnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZWIrgHQUlxg1yoPg35p3XQOhS4c0CoUegKGb0aN8TAGZpmbhiPkv8jz+swUde8xA7Bgn9O2KRMhZQ08CiEObGV702vb9hh3N+cdvQtJ9XR+fqM1jL8NAPn8YJteZhLsLok2ZfPvikHgpj0hEv70KscAS0igN7mosClu765fu24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A7C92gNE; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7C92gNE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caV6kjCWKWbBk232+v9CnYpHdEZyL2TkHVH1Cc4FDxSaCFZxApt28xueMmP6kVTOTy+5RmUWW+HTlZGxE3PcApM7GhUcFUJoKpLN/CUDfgxAztxNU6v0rrLm4oFSSFXYsfiipEvGxNzrhUho+794pMocQqKAka0BvGoW35VhdjI24XSku4800+2bgz2n41D7rxW1JDaYWjwhC+cjq4Yj9rkhj1Nx3DF+uRcD2NeODmRsVuDQzwf/RpxyTzwhqJBN7rHWnPo+gSTu6njIpummIC7LQ4OMpnnXbFlHtdbGygeOv4YjLHmU3400XJArWDJzpVgwKl1tOMSQkgK+8JFVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKBYbhefP4xBCnUnQ8ftwBDBMy39nXnpwKVtu5+1FuM=;
 b=u/khdxZpWNENBC4DkjVl9LrWEfhvs3UdHn7LFvbH5UfI2YbAmlNAO0hPAwMi+ob5b3TlrvxL2EfqA8eMeje1tWrmh7LSY5afReWxcQL47uS83jTUaooN2D/o1XLuAEIzKX5kCloibKHcVl4TTFXw8OnXONT/g1zwjQ/SSj+d1SgqoRLjk51eLQ2zJ3ZD8hpIE2STH2iacTxqgrR9l1UKm9BH831XHH+v3Uay2yRjoSsfV+vOzZpeR01vYjGefyiZfm9eHLVuXPlIwJIwj9fBlIbhIhM+FwnTS2NlbicjLIAlohP/wn7Rj3u1542LPjHkr7YS5FwLRim+JEyrSNsHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKBYbhefP4xBCnUnQ8ftwBDBMy39nXnpwKVtu5+1FuM=;
 b=A7C92gNE5UbsC7UEwHgQiGoKRZ1FK4kg3KYWHIc9SxD9dynoJvuBkR8ffp+m+90sf/ziQ+hBP8nWqtC9GnJXmIdAf1cwGbF/e9hwbKDbdHlpU+r2rr+P6itntGCQWqtdBBBVEx5sZOLd31lgPKHaYTaJmT8iqpalItISj2U6kRS9naayBwZJ1uf1J8BBi0CInFdieAkiqajorrgPy1kuaevU1eCSZLR5RWUqNiEctrKctzgtiQJJnfWeRTzHigX778lkoEcA+7hWXjodXpgfShkIGSX28kTvwd1STtjsmb1fRrfmgsivVNTEk37vHFraUPBnsvXFx0Xk27enFM45ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by MI9PR04MB849679.eurprd04.prod.outlook.com
 (2603:10a6:290:bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:02:26 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 14:02:26 +0000
Date: Tue, 8 Sep 2026 17:02:23 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
Message-ID: <hgkdqynnvx6brlnrgjkkfbfcu7nkjdgoi2npyupyjw5mwzzefg@7toxbidyue4i>
References: <20260903092922.470-1-suruurism@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903092922.470-1-suruurism@gmail.com>
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|MI9PR04MB849679:EE_
X-MS-Office365-Filtering-Correlation-Id: 310a241b-1c7a-4e3f-058c-08df0db1d050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|19092799006|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	73MvIxYX+noqghpdokn8sGPCbD90fZu8P3Uf01L70SbpI9dBxBqgUkj2OM08wxlBhzAKpq2kKXAPrdo+JhGIpo4MBY6noBNvnmDfdQiDlWL0KgzpN7br6D4jBE9dM1XFsdTAQOm2de0sXndIJSXGK/HLD+LyVgIxxslPc2pZHcZuunbRtkgjZsdidPZA2+k92gzZfNRGEzraSIiQ/1IAL18CXAPbWIg/T8ZovHWVWtjhRWWByhNQ6qPhpeAULJWRXiLwC1DYBe3Atpy9J8MQ9TCvsyffiAnq2TVH0nHqUdVGtajW/RwuBG/hRwL1m/LjrYflEJFkxgj7+ahNcGc/rk8RmxoQeRyUuIZFaCINC4AdLqV+nAnccZqvVllRvlLL9fAogXOGAAHazrecrzCaGzsLMa0BdJDJJitHKin9AWdy9DN8B0jWFBYPwMwOGdqxYYBvqdkr+5QPcf3kJmVwJxznpgr0LZMWi/ge9+7Rbrl7fBGIs09ptguTCGD2mG/qKK9Mdhv5GSaPsKdRVoT0cJp6HgJozf3oNGOB+MjPtxGwRX5VWAyXtp7UjXhKY1XWV63QQT+RYmN2TnKxLpCSFCxcEcBqsiHUvu/B4wkf6/nqpI5RsNerGHy2nJ4gNxDGTERfebJM/y/wsC+3RGfyRl07USiVtYsY4REzGpxh9u4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGvDkIryS0D88Lt+bwYYdYTAa/r4s6XoeALlRIo7HByAoXwp0l+1shIoOcHP?=
 =?us-ascii?Q?ix1i/mH3Q8LOx8mIqZOIHU1U88RnL3wq0mJzQVIVWQKtirb3qzR+lU/3DDl6?=
 =?us-ascii?Q?aW+ZLL9fNf+uLKtCjS8CCAaeF2VMRbV+CUXNEGVKSYRuYdqWxO2sN2z/1nae?=
 =?us-ascii?Q?7/0w+TwjrruprDKMtmV9KM/PCQ3hTg5yF4LyeTNTjmnS9ngAPHud3h1ZeQp5?=
 =?us-ascii?Q?VCejqC0ajdC34XIDK4/616JFXcozK+8leJErvE73frosp+sUhICxPTpFHubY?=
 =?us-ascii?Q?oEYBcyZJ9621IYLIKVZyPJNFyyZ9qV3rRTC9WxRwJzLeo9O8GI2yicqHCKvI?=
 =?us-ascii?Q?w6fOmYRitOfBHKf+qEVzP29dDf5V93vMnEZ74qqeswCD4lz4P5Pg02ePxZse?=
 =?us-ascii?Q?LjB8ZjJuroV0MMHle4r4jwy3WNlWnuthrwsSmF/FJeGj1yl5U93FakamMkZI?=
 =?us-ascii?Q?cm8Ze3cdfIgRilpIuxO42vf8D6lYA5UHeZ1m+fWGa31xLjp1rmn/BLhrh0Ym?=
 =?us-ascii?Q?BF/C6EHXfGYIoEZUAN+apAxCDrwWziELroKtJN9WkJLmQIrilcGFsyYdHpID?=
 =?us-ascii?Q?S4aPYLChdz3EVfm5MpZzWGXf/T+iMHLPR6zMYa+1GhWEZ02+QRTjWrHwrRhr?=
 =?us-ascii?Q?geoK05AQRk8SkDXRXInHKj+Qv4bZzeEsPKEglbbGEsGRihDpg8IJDgenO0kj?=
 =?us-ascii?Q?x5Y6yMyHqHceFwwKHhJ9fT6VXXDQYDYBs90VL9r60BxhJqHoAUikr0OhJDrz?=
 =?us-ascii?Q?eJnPuW8J4bKxLkTE/F78FoV0PrIa5ReJ+TTDXaJ1R0+eU1wBvP2ZVuIOQzgD?=
 =?us-ascii?Q?jn40YEZWZGWaCkTetZDXpFp0FDzLOx0PxxhfAQu2fUzzh3NaDRn96c3QYoGB?=
 =?us-ascii?Q?5OEkHOvzD8GgAcCb1UT5VRHGryMNwar4FWYlvz2vo+nl44Kzz9YUU4jnKPR6?=
 =?us-ascii?Q?AHMz19GLWyMi3uGSXXkZpDZvKWo5182Bb+hSMA4v0APVHZ2Gu5NtQ7Y2R4m+?=
 =?us-ascii?Q?QBubPP7iT7jDxtECGByA4aGdMVULyhcVKojL1M04oyKK3Rouru6h1L5x/HYx?=
 =?us-ascii?Q?Y/2jgJY4rQ5Bhr9HuUrQ4Rtv8DakLfJBFLcYYh22SEYPaNhRDMdfG1iiuZbK?=
 =?us-ascii?Q?Rmw2JmggbGkpsYIJa/TW2AZsSvCQmhmMpWPm0RcB7vzv3F//r5BWRWQou5RM?=
 =?us-ascii?Q?x3fBCZLAef3iI5c+fXKpZTe46Slc3eqvmse6zKo6KHty/d6CnV9JFYKL9vLa?=
 =?us-ascii?Q?B0jKBavuX/ZAiTopTbMrkjcoKcV1eVzZlIa6oiT4iNrh1UbBUqFZ8angiNoR?=
 =?us-ascii?Q?VXWrtBGwy9qVHA2VYfyGZpUCRAA+6akohKaem5bwl5gDl8TPR78teYP+4AZS?=
 =?us-ascii?Q?rWBAyZ2ifRo9Diawfk5RnFMGhOC3v6aLT+nt+caRw5+MmaPTHrP4fQ70GTYx?=
 =?us-ascii?Q?OoA1Xbbd8wS1HxW4BuqPsPuj6PugUma2yYtrnqzK1y5FY8iKy7z8EykL3RbP?=
 =?us-ascii?Q?FL+xhpov9tBvuOCGqVbh05M7x8KDsqUMRHaPXFJa6NzWUTldTrUd/BnsLLQW?=
 =?us-ascii?Q?VqxdLVcKJ7rW7UwK/KNivx2xwPsUthBOHjG6CMkLJK80vVFRUrTBouzJ2v1J?=
 =?us-ascii?Q?R3pbz50832+vXPNfW6/8L5SUsR0q93JCIBKyJV4PZuqhBj8maoFBQdkPH3+H?=
 =?us-ascii?Q?AitDg0Fehi/bjGeo4f3WGWJbZdvgxGeJW8GN92lPboHA7wb/UeVjr7CgJK0j?=
 =?us-ascii?Q?aoX0it5UAA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310a241b-1c7a-4e3f-058c-08df0db1d050
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:02:26.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qyN92IkZypdrXWi2ttKARpVzpCbR5byK4ZEXJQAS2khl6uDjKAJcqxfBEnGxLaEaO8rkmoomPuy7eTMtjDTDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB849679

On Thu, Sep 03, 2026 at 12:29:22PM +0300, Abdifatah Suruur wrote:
> vfio_fsl_mc_mmap_mmio() overwrites vma->vm_pgoff with the physical
> frame number of the MMIO region and passes it to remap_pfn_range().
> The VMA is inserted into the device file's mapping->i_mmap interval
> tree keyed by vm_pgoff, which VFIO expects to be the logical file
> offset: the core links every device mmap to the device inode's
> i_mapping precisely so that unmap_mapping_range() can revoke all
> mappings associated with a device (see vfio_device_cdev_open()).
> 
> With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
> coordinate space and unmap_mapping_range() cannot find the VMA,
> leaving stale MMIO mappings behind any revocation attempt.  Keep
> vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
> the physical PFN to remap_pfn_range() explicitly.
> 
> Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

