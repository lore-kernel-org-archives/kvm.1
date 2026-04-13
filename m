Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200037FF62;
	Mon, 13 Apr 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103471; cv=fail; b=d8RjU++Xp2hFFkyfw5wtNc64aPGxcpL2iX9YRCr0aRo27awTQEbk2xXyN3U1Q59aVoE0RNbCXCRvU/svAnMclJrWwJ6YgWZ0UDoWwCMDnEtowqjSymNnOsR8JcyTJmBN5329HXBvdp04xI3m+g+NS99oFhdOi3jKYIIbb+Mypck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103471; c=relaxed/simple;
	bh=X+/g8nUBlBVmDNLhwovWAUHZGA8jjunukV6P8aDnnPo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPmsWwU0l0gTHoiH026Lvq60/zCUY3gIXVAgwqJKHZS3U8udXrSAxD5H5R/7FseNFnkJ/BinMKwiV+xl9ieYeUIbiOTy82IMjDQXT9VpZIHNyNEVFuBKX2GnRX+QXBKk3PZz+aiXqHw8P3iVHtIUCakinA8PozeLhLfgJPfIk7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZVvR7yvd; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZVvR7yvd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdKN8+CXk+J8hXHJMc2cwkwWtgIBHLlk5OIJeDkkyfG8juy2N74OA3SkQDm+pac92Tmr0sqNct9fFGqvm9PxeX+ntCjl3FYe6ioJ5WF+6xhApTtE/eJ06GOMnEkMVb+9kEgnI7+6L7ai8Z86m1PfSbjCzYWKVsgPeTDu1NeLRSxbiPo71ho7gj+kLtgiJMRPkEoNnzLQDy0rqUrSy6Kt0exP4x9niv5stjU9okkPjdNSF2QnK0Wkkv7XNDpeiXUR2QHP7Df2y+0S3olQfX4HdKuD/9EGq5OTcT0JypEpHvB6n11sxnaJgh/CPsW1CHOvpg1iYOEL9ymvIKhBy7glng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5Ok2TxckFK/Tkq+ed3FlmftCQqnodFt2+e4pQKjNDI=;
 b=ZjhYkF/F1prk/sHniurE7MYGsYR9XFV+Tbz3gUZ0FYgnNC2wob1whAjGu4faAFkiO1eql2Q7IWO0R8llM9kQAvrGs+daf9YVFS3iNOLs4RoZhj4C607ikXInI6dJFthJZ3ILq+MeG1BCMRY2mSsFJj1+v3LTTbezeaihJ5U8pGD/dLIcQEmHa95bnRev9dhUBALQBzi0cErEJP22kE2VBp1mzfnYc0rxweKOBMWOgRu/0ELTeEnCD9i0O+26VGv8srsTSz6t6pWYOFpuA7ncdrOctHDd0rVUqklJ7ScVM4TuK3mCz+tMUoCnqJWUMKEmIbgiYHCC00n0Uasw7M+Q4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5Ok2TxckFK/Tkq+ed3FlmftCQqnodFt2+e4pQKjNDI=;
 b=ZVvR7yvduqu5ETpzJlYIzRlX+1CUFzIfXj+ub0NENBtkhHnVv2k6x/lU7fe+Lia3FcjnPwzdH81z+Xa5ZE93dNbhscRj5xA27mCxXPPE3r4Qb3B2zrVjRQP1J80o7gS3s+3B60iEa6I1ZCFqkykhUuF16Kohkl6JZYVh6diLeB9HO4uh2jC/dy1lv/S7OH7IrZymK/LtOI5LvVGSydrboXg+CGfvAkauikOBRhI6/jLZidS2akiGph1pdVCwYiEIoo4RQUMwJKWweNLRMDYXFtf7ZmRjE5Nh8TRED8BfWvu88Rscs6wnevLG5oPjCCOxXFZmWBXYQlBs8vVzH40eEQ==
Received: from BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Mon, 13 Apr
 2026 18:04:26 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::f4) by BN9PR03CA0295.outlook.office365.com
 (2603:10b6:408:f5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 18:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 18:04:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 11:04:03 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 11:04:02 -0700
Date: Mon, 13 Apr 2026 12:04:00 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: David Matlack <dmatlack@google.com>
CC: <alex@shazbot.org>, <shuah@kernel.org>, Rubin Du <rubind@nvidia.com>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 4/4] vfio: selftests: Add NVIDIA Falcon driver for
 DMA testing
Message-ID: <20260413120400.534fb287@nvidia.com>
In-Reply-To: <adl3j0piontmOQZS@google.com>
References: <20260408225459.3088623-1-alex.williamson@nvidia.com>
	<20260408225459.3088623-5-alex.williamson@nvidia.com>
	<adl3j0piontmOQZS@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ceb5b4-9b73-4445-9253-08de998719df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nKd1QE4TgYaOzPp7TuEKGJZAT5vcycb+Gc4A7GOYwZ+IfLSCgrXWdVE51wgzOI9hDXRIe8B1IDeykTASvabTcWw3r0EXfNnkLPvmSegxm6HowsGN55Qjf/tbBfk162H6hGnlXEOrIq0CZn1YiEPkuTL/6xRz/mIxrBPcxgRZMjyONzey1cqr9ksTKpBQMtZeS3DqtamZJvEKpn1Yb7da3sNV5GJI7533HSWL1RgcMOIHwrlsYhOK9ChaavucBCMm7caVrUGePsxssoSGgcBBfs/BmlLl6eRSx8ttxz4DJltcGxC9JVSwcPb6S7h4c3gnLEXdZrhlRKdNoiIgcUXM3YyBGL+n7bCmdjw1jPjQ1FjVpcFn6DnKalkdYdNd/beDxtQ0O2M+fRI4RCkwEhtlOU28y59ONsEEpMnYShQxDO0lQBkGda6xJigPMSHMA5uOaaOKf40l7R7cESbTMpVM2VrrNEa/mDm4YXgzre38W7p+/6nBfDxmNp0eO5qwGeHTnf4dT2Fi/Ybj8nDXpaG0xaNv7NhrEN9KOWZcLF9JrUAi7YI/BEzeUzoS7CrmMlNuxH1NpGbaDCgpG1E3dTen2q40+5FTvF/M4wJ9aVjwoa9eL9KdScEhnoCRL7GybDRBVDgDByi4ns4nhkBxBOLWR7zScNQyA2qN1cyVJgln0Uv2QH/dFrgX+9LJFxKx8lV/3m3XOvs5EE80dEgpHdxxPE56qkLyV82/gECCnQjd9FcHwY5+SuR1CkeTN9rmS2uz1R0+MgMLGKzXNUO56roqtQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	20nSlBeaNwAI/nKkQpL0A4gwn8+Kt/Z424inv+lZnrbRkUEuiVO67QQ+oCWRaX0u78TTs2XEOFQDDcifavOtUduMoL//E+7a9IbyR59cLa1hpvMNfrurmQZ4lS+EtSA/4Ky5ohSCQy0A/KX5qLSUYG5rGyX+kYsky1/+3vzAC2Hu1Fv3k3FSI1EFQchIx5cDv1wk6sFn6tdVfHyR0kFUqV5mjJySJFvYqllzlPi0aWBY2TIxiNGbocvq/EssQ9Nj0stCakc9HW/EiNfbBcxqmwNKZ+f6TwBizM5UN30jqoGN2SosZLT/sk7aDyq27eg8mEfNDXjqUcwlrdf2yGAVfYJg9krIzC6I4a5Bj8jkUwvjmzmJEle3kAxesI7ej9eSqvDkKHG+pAThW2BYmT8AMKAiQ08deO3zeXTduwsdpixmRYBCdZA2rWw5WsYHweFF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:04:26.5100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ceb5b4-9b73-4445-9253-08de998719df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818

On Fri, 10 Apr 2026 22:19:59 +0000
David Matlack <dmatlack@google.com> wrote:
> On 2026-04-08 04:54 PM, Alex Williamson wrote:
> > From: Rubin Du <rubind@nvidia.com>
> > +static int fsp_init(struct vfio_pci_device *device)
> > +{
> > +	int ret;
> > +
> > +	ret = gpu_poll_register(device, "fsp_boot_complete",
> > +				NV_FSP_BOOT_COMPLETE_OFFSET,
> > +				NV_FSP_BOOT_COMPLETE_MASK, 0xffffffff, 5000);  
> 
> Sashiko is wondering if the mask should be something other than
> 0xffffffff:
> 
>   https://sashiko.dev/#/patchset/20260408225459.3088623-1-alex.williamson%40nvidia.com?part=4

I consulted the gpu-admin-tools and it performs the same test.  I think
the hangup here is that we're labeling the expected value field with a
macro named _MASK, when the mask is actually provided in the next
field.  I'll rename this to _SUCCESS for consistency with the reference
implementation.

> [...]
> > +	if (!falcon->no_outside_reset) {
> > +		ret = falcon_reset(device);
> > +		if (ret)
> > +			return ret;
> > +	}  
> 
> falcon_enable() is called right before nv_falcon_dma_init(). Calling
> falcon_reset() here will do falcon_disable() and then falcon_enable()
> again. So it seems unnecessary?

Yes, I think that initial falcon_enable() is unnecessary, and it's a
bit subtle, but a no_outside_reset device doesn't do anything for
enable or disable.  I think the solution is to pull that test to the
top of the enable function, at which point we can more clearly call
falcon_reset() unconditionally here and remove the earlier
falcon_enable() call.

I've incorporated all your other comments, aside from the optional
refactoring, thanks!  Testing to make sure the above change doesn't
regress on any devices will take some time, so I'll expect this to miss
the merge window and hopefully get queued for 7.2.  Thanks,

Alex
