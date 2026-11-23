Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795427782;
	b=kf5/9j5TlC0OjEoc5lJ7s3r2WVLrm4U2Hvn+ZkT7KrSz1lRoHNxRbfhBVS3UeRDrCbgv
	 FLygA+HAOmkZw7Rym1VmjpQ3mzTb0LEtv4i8fYQ+rLN2+/LJ7TAaiLSMoUgWVxy1QGLNX
	 SC9oacr8HxY9gT74lyGy809WU83xXQ/9YK7wxTxZGPvG/jJVlhxv3CPyQSvsOTbL6JFiu
	 qHXA65sEJc1Ar+0CAvOrfxjnvBGczwJa7ZcZDp1foXRr2E8OB36bpkUcqDnuMWbKFotHP
	 4L3r3EKh3MwdGYvrM1Z2uV7edWgcf6Bfi8IFQ87Ku2jcI9CLrL2IGk9v61FLgTMGCBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427782;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=W+173H+DrvHHZm+6baQoutAA98RgQNzFpQgX9GHm4Z8=;
	b=3ZjpBVJmbYJ7QQOvpRwhth+sH/LdojePL0ivAdHWHgbK974R6L/Y0XyufByja/VeVG/S
	 E8UM0O/9UkJv2dgyG0IaGIo6/TVtpTXbMDmAFnIjyT1wjTMHl7ohVRNT8Ej0AUxvOZOgO
	 39bQeLhUNFMs2a3X+CpYpMjTj0hryR5MQHgr2QsZnIlcjQP9HauJfVYoiZemRCaYhEbgX
	 nrIL6HWD/DiJ4YjiflSxOYyIC23hPogoeBfAeLszRjuOiPPbEPKkGcPeUU3sAzbILNt1m
	 a/7RJUVrb/VjI9RsFOUjvDL1SBLku7LzC42ItsQY1vMr/2BicmRthzhGhO9TAB1xINg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="HMu/rGXa";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.66
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42431606A31A;
	Mon, 23 Nov 2026 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42431606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HMu/rGXa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOdg0h3iQIFlS9dy4mLi/xkA6Mmdsp2oLg2OpZfFwkCNzP3K1G9ksLEbPVHXRLucPhyZj4N5sFALIHYxniMasK56mfUCdXwd1e37mEnvLSjl7oGZnoMXyVgMA1O87CvjJqCRyf3CWl9Ko+jZivEAqvFHFwDlLi4m1df8SMR1daHT3gfui3Wr/VRgTwRcXLa53Xb8k7zULELlrbYOn7RiRXOFfvbOVrskwf0eyOHHxgzNleZ0oIF8e61ETCtjrqMFSjpJT9W6RrqDj497qJZfaOsv/X8NIxJYs7QgMijDfo/vrXUu/6ysMGMMe9NZ/d/s/CDhwMcRLL/lx8Z7S7ROsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+173H+DrvHHZm+6baQoutAA98RgQNzFpQgX9GHm4Z8=;
 b=JZoyUwMceUp9QRYBY4fgBXKJVjeDD7f+3Q5ea08Knhz7mEHASdAXSdlvLmcvqQCRZ7SJACD+WYK/Ys3/sdivFRnRs2XsovKuK+7fbZ56VJjN3rFojmtD+z5yHPdO1iygmKQjR8cHggCMyR7na9Wi7FC++egDib3PHoWLVD0CKO3lpKbko0DjBRzRUHcEyZZGV6X0WuGNWh2v56rK4l28l9ugPUXrrgAtB3dNhG1Gb2RpBm5Z+xkimI+qEtsz3Hu6okzNtWcnf6b8yMXRHxQPSHsUVRkmnF7xjOzwS8FWL0ZvTzVKOsCdSpbnVr3IohsO3rYQB7IK6Nk77qio6MIj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+173H+DrvHHZm+6baQoutAA98RgQNzFpQgX9GHm4Z8=;
 b=HMu/rGXaPM01Lzo9s9JjccwJ6yvF0ix3mU5AuYBnlJY3VABxfAwJFmpw8HMgus8ViySZcYldknrskUDuo2aD9M6NSHcczggep/I1LDKncIreNdBJNIDbBN7buHxt1D9ZfD5iKaDeZaaj//1sIYAPBeAGOToS0SdTbazi2XkyOAc7lq+v+vHwUXO1uXcaqehwNglrNP9l56mcVKeHgtTO/sfI9WbZRSNC2vyO5wouWDPuMEXABmaB89U7va8XKZLEhW/Ykm7zpDmcgmD74GOjA2tNkGnJkROiSVjtTq8n97Z3Zvrl0NprRMF0/vyE0kHZ08HM1Psq4gSxcOdPlmtvXg==
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 23 Nov
 2026 09:56:17 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::34) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Mon,
 23 Nov 2026 09:56:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:56:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 01:55:48 -0800
Received: from [10.221.209.237] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 01:55:45 -0800
Message-ID: <13ef18c5-ae21-45d8-927f-0a9502e34162@nvidia.com>
Date: Mon, 23 Nov 2026 11:55:43 +0200
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/mlx5: Fix an unwind issue in mlx5vf_add_pages()
To: Hungyu Lin <dennylin0707@gmail.com>, <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<leon@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261116030131.15346-1-dennylin0707@gmail.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20261116030131.15346-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa73058-eb33-4006-d7c6-08df4948048a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261026121527099003|261028144727099003|261021121427099003|10067099003|261026140227099003|261022105027099003|261102123227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	jrnUVhMblEQJB2/Sdg1AaMDqB9xMLuAyS1LIweRIeohoyxEGjXsAIvQ/NiG9ntI+spIEzPdNVn4FFaDTDX+wsxJwj0X1i/3juM6Y02lAiFos0N6MErDIl52d50j0sYTzUKwpLwueWRLaGETO4Xn4Ea6c2EsuvD3KrXOMp7WNouczV92sm2VlPCuwnU628WLcreu2xKi476jWFY3StZqgOa3bmMHsYDM3ciDUlmSrm39i+Z03iaF+srII3SpHcueaEkmzBjZB1/3BUih7Q8HMeeLrNvzRnTqPPo+ZsYTL19a3xtZLR8Qi8va8sFEdjJXH5u/91lO/cbhOqAYOYmUULlZ9+ygIYRHyBbnjgYQ8bJt3x/GVkmmsQahirWxuAMR/Tl/E1Ga62Yf2tEP6XQaxcasBqzly0LC/OIUcUqbiJdMTBBGGAJstIauue7/C5QZOXLJrqUI9FMazou8pR57GmDa88O0rtw3MHM4E5po+tTBW1BixoMkTKa9c0kUJS1axWXHc4nAN0LpzDc+QIPzECHtodr9HcylOdQTYfQ7mZkqALn49HdaEwaKf5ElyIfVdF2U1DPj1EHaYChVsP8z7nmoK8lmRhhkgLY6m4vq64A97vUK+xSIuFJiXmaGAaPUFhQ8jffqzXQWZyM037l2lnkYDrEEkjI+059oH1hdvZOgvJtOyBMgK8dFxHPEX50BMecELIPqBHY0Ni0uEH2LJMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261026121527099003)(261028144727099003)(261021121427099003)(10067099003)(261026140227099003)(261022105027099003)(261102123227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mN52+4/R0TQdjM4tQhmf7UUosPjwjkIor4JdfmdLzogkSVjdpvODwI167R2pr+GdwgBFAoSAA/w7lL+0rBNrgL5HemYeL1br2DAKsRuwo81rojNj33bUscmociYKpLCokYjKy6pm5XoKU+d5UN1D5/lASSHHT257OmdQ5K71JtvhYp/Mv3o/VsT2jYaH0iH+qtrX+bQ2z/6FDtgCBSqnSy2wxUOKRcU2u2bYHgb+w8H/xXba02oLGiR/4pyv7OyTmqTHd56u0hpff1MGKoM7I5SA+KzpgV9+NOY70rfnXmWjij/2H7mXLr0j6wJ/dCHyrhWWtqTxU/dzpTPTKUzw1qBeJFECRZcyWdXM/WgdJsMP512ZmOE0SYFPtSSJxQY6Heif6h77XOP/z7QIHZUhRPh2e1DnLWkSjAYsaHQ6+o8vikFAe62HnLMLw3X8Fod/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:56:17.0918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa73058-eb33-4006-d7c6-08df4948048a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

On 16/11/2026 5:01, Hungyu Lin wrote:
> mlx5vf_add_pages() gets a pointer to the page list of its caller. If
> alloc_pages_bulk() fails after some of the pages were allocated, the
> unwind flow frees them with
> 
> 	__free_page(*page_list[i]);
> 
> The index is applied to page_list before it is dereferenced, so only
> the first page is freed. For the other pages the code reads the memory
> that follows the page list pointer of the caller and dereferences it.
> In both callers this is a dma_iova_state that is still zeroed, which
> ends in a NULL pointer dereference, and the pages are leaked.
> 
> The pages are allocated with GFP_KERNEL_ACCOUNT, so the allocation can
> fail, for example when the memory cgroup of the task is out of memory.
> 
> Dereference page_list before indexing it.
> 
> Fixes: 089803c40193 ("vfio/mlx5: Enable the DMA link API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>   drivers/vfio/pci/mlx5/cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
> index 04180035a7fe..8e8514f2660f 100644
> --- a/drivers/vfio/pci/mlx5/cmd.c
> +++ b/drivers/vfio/pci/mlx5/cmd.c
> @@ -518,7 +518,7 @@ static int mlx5vf_add_pages(struct page ***page_list, unsigned int npages)
>   
>   err:
>   	for (i = 0; i < done; i++)
> -		__free_page(*page_list[i]);
> +		__free_page((*page_list)[i]);
>   
>   	kvfree(*page_list);
>   	*page_list = NULL;

Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Yishai
