Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F43ECBE2
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310124; cv=fail; b=Mf1/+k2xWcnYCesVKAGVmYVGWW23CNZTHG6zv4qzFdCybPEaYSSDmR4wRi+UwqTZVhlA/3CKjEUP8EzxRVfbiS3H4AifvVilTMqroZDx9TIx304HAWfKTAmxxkk3LODN9ofJcvYd5Tc0UGpCIuue1NWq+inNweCRYD2QQrxo8zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310124; c=relaxed/simple;
	bh=Z+nH9mxuF8l2LtFvxiQ/u7clQKVk73NuRccwuaWI4us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HnUrS1x4o6HGtmCxlGFRAgpTmZkEqPs69lKFbZoUVe5dRKd+JGJP4fvp4wSrsWOsBOd8TMBIf3ftXVvAYQzTJhLgO1mKiLA5On322vGUmNERFPmDRT31KU73NNpsr8eysLv1LnIrSc/8sAXcgWwogLcEs0Xbf3eJK7EtQqiAWIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdZxAVVH; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdZxAVVH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXvWs3GGYTlg/LkBeHNIkD/9V6lTkyMog5zAPaj+m8edPVYYnmUWNM0Sz8T1LXiHOnridUU9oQW22wcIpbq+vEm2+p6icgjoPWOzbs0vMy4CTAXb0tLV4Me6+ubKEOM2PTIMEjsUGdnQ1VXLgzNTO1gfWzlmGEUj6GNG4tGilT3hG7fDvpxMdO9eebzQgSIaR5KuO6AHBZqMj9Mbr51oWePb3TGNR89V01yi8OkwbDQtubrWwSpmr2hsbOyyff/Tr6EKI+O1SW8EBqM8S4OohJwEoDRCvHXhaAELaTy5lEIZpsAisoSEwu9J/LpSKGCsMjkhBuOcTwyjwHDf4vkhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+nH9mxuF8l2LtFvxiQ/u7clQKVk73NuRccwuaWI4us=;
 b=fD4gbKU5fwUJjTEEVpF5KKtcPbH/WKLXGwpu7sz72Shdj03k+y4gANqWYjxvYIa+vYNvWHN4vG0+72ovh23KCQpEGtE8PFGd6o9uHfuBZSz0XulmXqWJXJheNOPEhlK+AhxmoJa7SVzaEIVg1mCmKvY/44ToIUYjl4QQOu2Du+H3pA5Nfm+XkogO6H9qa/mv81awGyhPCtLRiiehbb/wyQNTj4+Pdr2LdP6iBG1Y9Jdv6AorOLpkicAaHccOxKBN2NMA3hFjfNjMfqj956uiNr+q4C9he8togu+7NVxKU0MBN8NXDKLhWCK5DINbz0HCYiEZCdjevjFvALHMvPp/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+nH9mxuF8l2LtFvxiQ/u7clQKVk73NuRccwuaWI4us=;
 b=mdZxAVVH4JDhSbb1waIvovxG89vEMH1yCTX+xPLzySvKZvPAmfmjqZ7rdRRtOL3rxSsFkG7Vc2lrxZaCIJKxiGpU957qSdnPlk05sBQr4UfdidIagoNGqEoJz5LWNZzMCDozmm35X2cRM1CcNw/tDtTtm7BpnWszZ+vK1w470bMywXlGiniCj2yMkGUk46XNqhKXVyzJpyHXWb5kcCBbp94hm+qhcKgz0fDtdbn05hqOLsbXXx90gEywzRcMcMFISFR8k1vEDv2Rh6sBWO/Ah6C+ytRqvomYtex4nuzvIkujhiq1Mihhu7+e/BVp8GLRhyLGY1boprUEvI3ccW8PFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 17:41:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Fri, 17 Jul 2026
 17:41:57 +0000
Date: Fri, 17 Jul 2026 14:41:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
Message-ID: <20260717174155.GC699082@nvidia.com>
References: <9-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <20260717170401.B637B1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717170401.B637B1F00A3A@smtp.kernel.org>
X-ClientProxiedBy: YT4P288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 72352d19-20d8-418e-925f-08dee42ab290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+YgWz1RmFIlnVg81KjTUw4oEY9+ukoa6dF6lzL0r8AzHqJ3MfmJMIl8mUjOV3nJnPLwrKYVhv+px1Yjbm+2Xy0YCDk9qxwvUaQLLcZCZfh05JuYStvEjQhyzREXUjU855NPXIy/V2N90s/JJ6sYvt2mcHN/6SDzplS5rBv00iL+t2YDKqIm2V52U+ToyX8+Yd2rO3rSJNFcHwOl6uumTyU/dbUoGXhxpAVEkTZcoWfdIc/bEmKRDnd4rtqXdHA/0sEVfNUEA1miDA1I9zWjatY+GoOIvG7AcKIYyrYw+2ba1krCWzFq6OkO8r5Yk9qUZmAwVy70zrqQWU9OkcpSaR/r0HTNq9QpOZR59maHHHhemAUhCRQDBvCM3UvbCK/ul9ctyDcXDu8kZxtE2XqtniwFwH322HUevkYJRIXmlhRKmIeVdZ876c/XU+Cac+eZniePKARKcm3aQtas9mfmDSPrHu/fr4v9ucSxDRC/jEN61vexasPDNZhpKlPrTObhVvlwgcXkVmaR4JSIR6/vQ/gX2ZP73VpGFZf94nrm7wioovkJ58y9rSWCb5kgxkfq1BlLt7FTGPypPIDyb7wEyZp/mGbsxDpdc2jMWIwAnRPLWHY0iD9w/pFIdD4z1rt2olRh8WKnz132bxvbqc1XymatK3p35eC9RBkoJbYbaRzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9Z3dEzPzzm+EsccUFT+23ayQgbKHBEBpA0TwOvTVxg/Rqm+cGVlnAKBJAT2?=
 =?us-ascii?Q?b4FvDs6be9e0hAp95sC8t7YN06JKt5fr8zG/MAESfhxfuOsk1z5Tq/IZUout?=
 =?us-ascii?Q?dLECGcMLAeoZFlkosTDfq4K1JNhVUkFEjXiqrJ65jqtu4ZU/BFSgBrFzTzxe?=
 =?us-ascii?Q?EnLkDZaY5+P2rAlnfNnWHbRK9TR0K8jtwq04nEO+Gv1iwrNK6Op6V3ODBHd1?=
 =?us-ascii?Q?dRu1KgvF1AYHoporlI7+Q5WNIN3YMfm4yBWrRvjyi0hbgRwjIPhGZEJJmsY+?=
 =?us-ascii?Q?zPIw8gu2Ai0QRiUVK6QAOvKjL7lFrgSvoUqv7lEppwKdk+m6pdLDlFxSgXgs?=
 =?us-ascii?Q?SDnvwY5LQGO5DGyNS7gX7aETLUu2MwoWwFZnpUqeGXCSfu0aBKhcF3xqok9l?=
 =?us-ascii?Q?NOhMAz02v4/231edYTzSIU3OigUmJpqPPdGuxg2mhC6jo9QK1/4e3ceHcblF?=
 =?us-ascii?Q?UtOxpw5nE8EoZ8lFpf4eUb+s+IWTjRIT4+5rctRTpG0A8/xC/pulxGB0eF3E?=
 =?us-ascii?Q?ZLM7fYpWnOdc1mF8sQTltAZqeEmrel+QqD+XE2Gr3s/zTF5JJU15LQl2UZX9?=
 =?us-ascii?Q?mcFsW0bKxFdekKg5agtslcyI0IxC7cBKJux1wTQtzk6fSRCxQTlO10hrjEWl?=
 =?us-ascii?Q?QJ1ohDAiFzpqspcqWVfHwyD7DEQ0w9OoQLzYxwa3XEjJSr1P2LEEbD4c1k3m?=
 =?us-ascii?Q?GQrPeJ90TH3xzbUc2hW/WaWO+LwH63qPvIyXP6CY91BV0O7g5/aRnvRWU919?=
 =?us-ascii?Q?mVVXVDAR7c3Ma/SoocnuuLOTqr3/zh5+oPGc6ndxOYhktC4NANRej4JCw0kp?=
 =?us-ascii?Q?OUg7lgs4i9aYDMmhMjVVS9vQw8e5y0cnM/0pIsnnnu53U6wR0CZGRwtolXxt?=
 =?us-ascii?Q?N55qvu1EOvWxCYrUr2lbTFpwUBk6uCPeA+ltL7ws2Ey+p1NK/ahs+5KnNITe?=
 =?us-ascii?Q?t0M6cmQZc+tUvCh7CZHnp9cOlHNHrljc8NhsQrutGPYCRvwhbJGP59mOcKOh?=
 =?us-ascii?Q?ts+gM5sotsw2jQuLosq3h3mONIA70uWh5/t8QToQwe/6WVN4JKeFqLeJah1g?=
 =?us-ascii?Q?rkY6bR2J6w/2evoKQNegNjfFzjTTp5PthCSQ2XlqnH28LNEtDvcs6JIDyY0n?=
 =?us-ascii?Q?skU8N3fr/M+XAgeewn8LWYyDERAWA9d0eUNyn87M3DlGz7p6+luKDcGOhsYv?=
 =?us-ascii?Q?DDyKYopc6QhC1z2J3nNPKlDiaEFEKxGOIfFB29vanCm5oOEbXEoG8vJNCZII?=
 =?us-ascii?Q?uyRHZrpZ7MalYZG4/2oG4soYPOhHALN/PrXYvnQRocziN+o7CC9JWQiNZTkK?=
 =?us-ascii?Q?mpY5ilKbM6ePhuBHy7GSX1FYPvDGh1233SYtPP/ZifjOupdMbzGKZKUtp2ea?=
 =?us-ascii?Q?bmcKpabFLAEQ7tT6zSwU19ZNPNYZhYEDcv8EOe7Z4vZywtow54BsKp8lAp1E?=
 =?us-ascii?Q?CINGhrpYfF7KV5i6ePbtou00V0s0JdxQKWuEh0K4Dd1ON/SXlUl9LsqYNzWk?=
 =?us-ascii?Q?INI7DPgLELBwobA6pLUytQhNrhBKDI+Cslhp2prkQHS4p7o4ehYMlX3YNZY6?=
 =?us-ascii?Q?7K2YVL91FztYVC0I1ND4eytcd673sahOA4gEBT3F5WmTZSumWIuvqvlO8l9Q?=
 =?us-ascii?Q?sUB9Pkal/f8r3kb/4o2tzGva1zRwC5tbLioUY/5egmwMknVdXmjJOYM+Tg3m?=
 =?us-ascii?Q?38Z/IpgR5ck9o0hWvPq8oSS54yqJJSoXGDLfG0Vq8FY17UEA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72352d19-20d8-418e-925f-08dee42ab290
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 17:41:57.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yExXxw/ay9l2d2IHWm+q+D8BX0ViM8B6uBex7iEFUUEiO2k1XSHI6SvZ110QWeeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

On Fri, Jul 17, 2026 at 05:04:01PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> - [Medium] Valid hardware IDs like 0 are incorrectly treated as unallocated resources, leading to resource leaks during teardown.
> - [Medium] Stale command data read due to missing ownership bit poll in async command completion.
> - [Medium] Asynchronous MANAGE_PAGES reclaim loses track of remaining pages if firmware claims fewer pages than requested.
> - [Medium] Heap buffer overflow when processing unvalidated `num_claimed` count from firmware.
> - [Medium] Out-of-bounds MMIO pointer derivation using unvalidated `uar_page` index.
> - [Medium] Undefined behavior due to bitwise shift exceeding integer width.
> - [Medium] Spurious failure during HCA teardown when the firmware temporarily returns 0 reclaimed pages.
> - [Medium] Unconditional RoCE capability query crashes the selftest on devices where RoCE is disabled or unsupported.

I think these are bogus - we don't have a model where we don't trust
the HW/FW in this driver.

Jason
