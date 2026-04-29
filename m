Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C82E175F;
	Wed, 29 Apr 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494199; cv=fail; b=YsiiOmnEbaeI99S6rOO7PGu9quDPYhOvM5o0wpNI6bgGopEn82XysQQQPtBI9injAUssqIg4L3csv+cdasZq4vrc7oFqT9GkvxPauUWJLuygRAmLFVAfLlbgQ9fwcXJwiR2IqvAbzNd4JWKr8qdXxasVR9TA62A8lWwmTjMADWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494199; c=relaxed/simple;
	bh=82xDYUmYqwwO7k67Wfl0pq5DqewKyukMi/H8VWFpQ0U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbBXkMIfhmaTyZbnPjbcjVIU3IvzFYcHRwq6+D1qct1rMZ8+xrOm81Ns83O+DUjNf08GNR798vN9oVYsRcDTrgIMrcCV3CW6MKt/8Qe/GZrbrWLetY9rXVoEGzIzDlyX7j58qZkZxVQLj+boKXsmO5bzPqz0wyh8Dktd7B9HYlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izOzOwPA; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izOzOwPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNNPRmAVC+XN3jDJLw7TKgSLLQnsSEL2gwQqnB0cWc18besc1uYNk+kJayKD+mpr0yRo6EWHs3u+DI34xZfCcydSrMoUuy9WTiBmXUg9mQ2otzvdheHg2qWLnZY4OB3qdZHRV9iSzGdzzQ5XZK+oTtfW71XgdWCTBO7FYRtBd0uekx52vAICou6vTxVQCI8wXJXIEJf4VAnxqTu/c0b9BlJvwWESBJJHu4e6L+YccE4Y6Dw6nJ5LuoG3ETJfuYGOMbSkEYoPuiQ960Go+wp8HiZP3ptmvj1SWx3Rpe90UdqF6lplVdiid6V7oOmHWhVN7OVq1ihIdp+av9Y6vTP1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkUF/rL2llKLNc3ikgf1NsE+hyjjdevO2hy3oA1Z6ME=;
 b=pqeeV1FRvySTTwMEU+lriDRWR/1hIDwt/zLtf3/OPS/7hleXWd00P97ZgcwzuTkq+SvHfcjchlRXn1LHv1UFgo/KLRE1qV2L9PJXi0CpjuWQCQjXGuEfScL6R5ruaU5zut9uBHMKjXT4PYM50JWByy/jhsu9foKBi1tNXr8S5YS3LqZJb9xEjmPvICPvyguD05n6X28zSGgJrANJrrAIxTxhuXdHGdmRPQZxNvZX7n7AW6+2cudh7r3ebntzJQTKYS84Dt5YzvrLpjclyJBBg6JnEB6yOZw1UdavYlvIrvhxVw19c8sdu7cLwDaLBJsrJaxMFcJ2Zd7uhu0kgZL/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkUF/rL2llKLNc3ikgf1NsE+hyjjdevO2hy3oA1Z6ME=;
 b=izOzOwPAoQj/iOJFE3XaDa9RsdhutxJDjtz3n6KfKPdhi9W1VRXfi+qq1EfRCqCb4DdqKLNLC/BPOjk/4cw3twyudmdgwKYFSxYSO22ti33QdAfPOc6nw41Q8zeSV7tLHHcUblUhfHVX+IrRYXoX+OhysXy00Bzu9WJUS94R1p0flihhCliMUrIhOCyg30LNPH0V6aDyzNEfOsxylP6FH558t/SMicvOYOZ4CogPn/0SMxgEz4708ZMiHYeN+0sbbJfFaxjk++XDS3oeOH2POq/HRyMTLi1U9MkfWKQwWGd6CVfwozHmJgImLxOPiQPCdzy1K1fbHIs+YElsxjrYdw==
Received: from CH0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:610:e6::14)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 20:23:10 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::93) by CH0PR03CA0279.outlook.office365.com
 (2603:10b6:610:e6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 20:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 20:23:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 13:22:45 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 13:22:44 -0700
Date: Wed, 29 Apr 2026 14:22:42 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
CC: <kvm@vger.kernel.org>, <joonas.kylmala@netum.fi>, Leon Romanovsky
	<leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Fix double-put during dma-buf cleanup
Message-ID: <20260429142242.70f746b4@nvidia.com>
In-Reply-To: <20260429182736.409323-2-clopez@suse.de>
References: <20260429182736.409323-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b26a40-8132-44cf-7a30-08dea62d219d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m15ehfefJG+x0QlsPXrdBrn73DDbtkiSZSdC/MlFQgHPqTKV6sawj2lVkDD34FE4scOMTdyUjliXVW0Lr36gvDiUsESB/cm8DFed6Tg4Vg/lmM6UiRfGHg2lhcbxwZ70gNsbZlfoKb/6gWBBVX0SOOgjiRpO82aOd+4jt0DdtVIDTsaCB6gxhB2non+Zhe+ymR5ozQqLIH83orp6G70zcindQwRx59I9THYv3ja4Aw8Iz/DUr0OvOdSV8pgigPU/z/Wr5lXg55/HmlP3FMJqNfH0oauoOz04tKEO878imY8UcirxMZbMwKsiT8ktH/9SsBKY49fRXpaBK5ouN3zCVTRbhoK+7LYwjfowJPNa3bp2eEYQEEYfBZ3We5gFtQmaqUlqcoBJYqi91ZyE5lfWbKT+NokjW6KjlHBaWhnnYpc9I/3DtgRLeD7xqbGDVVrHakH/QEIk4ag4h03tQ9lNz9TbnqPUQk49eQWWu8DLNGDvXumD76g/thx/LIEbF1MUtAFOmvIjak1q0oiqkqJxtQc1szgjVRXY2s3FbucTW5SMpOX3Iq8BJOivLPu9JBT+3RQ5ZbxudGCcB14F+JqmFumHkUl1bhAa5q0VScdfodK5x4+YsSyyB/vCu97LnY9Ro8hkjsWE1cAyzKuzrNJHodm7MM9mlnXMdP+drdoS0s8CvGTKCJS4b6uuKWhwwjT7y8sSK9Bcr6aq5CMsA0O5ufc1latIOAIjdp2kL1j46YL+sYq3Fj9sbjyTOq7pz8eT4I6Lqx+IHgvY+c30CITQrw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7ve8wKDZuLqEQAGoynIXrKLbxNpLVv1XgDv38nkFPmjeQ6KI+eod6jVhPih3FJ3mqz1fxDcQjJhVh/5Wa0mKMLJT32nAwFKr2RRchmLyxDXpgj+hAWVejzfUoS2pCLXdDMkmpiF70qI7esr4OTwDwkSIkmCszEvvaEq0KNKBehKZjJg4nKspmQ022zihuswLgWQesH5pGMwnPyVJAyw9J7yquSG+oW17vEa0txI9oEzTQcjpcvPZw1CvSGDEQ7YzxHeCwyLJYZ8Ti/6xL2dya3cd2hKrNw+wjLp563FUSLMCx6mcrV7SpkrPRsLLr9Oyldi+YQf2V0RoFeKtWsUevMYn5VOzihUecfT6bawMke6nVorV7fkxXHgqdIBvRim2rvCp/rmJf/di1u9E1JgeFxskvmzCe5R98c2vtwrft0fcT1Si1+WaIP2HDMtM86n7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 20:23:09.9374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b26a40-8132-44cf-7a30-08dea62d219d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

On Wed, 29 Apr 2026 20:27:36 +0200
Carlos L=C3=B3pez <clopez@suse.de> wrote:

> When a dmabuf is created for a VFIO PCI device BAR, it is added
> to the device's list of dmabufs. If PCI memory access is disabled,
> vfio_pci_dma_buf_move() is called to revoke the dma-buf, dropping a
> reference via kref_put(), and setting its revoked field to true.
>=20
> Currently, vfio_pci_dma_buf_cleanup() does not check if the buffer
> was already revoked, calling kref_put() on all dmabufs for the device,
> potentially leading to a refcount underflow and use-after-free, as
> reported by Joonas Kylm=C3=A4l=C3=A4.
>=20
> Check priv->revoked before calling kref_put() to avoid underflowing the
> reference count.
>=20
> [  216.397532] ------------[ cut here ]------------
> [  216.397540] refcount_t: underflow; use-after-free.
> [  216.397542] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/=
0x90, CPU#5: python3/3269
> [ ... ]
> [  216.397851] RIP: 0010:refcount_warn_saturate+0x59/0x90
> [  216.397859] Code: 44 48 8d 3d 09 bc 35 01 67 48 0f b9 3a c3 cc cc cc c=
c 48 8d 3d 08 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 07 bc 35 01 <=
67> 48 0f b9 3a e9 4d b4 70 00 48 8d 3d 06 bc 35 01 67 48 0f b9 3a
> [  216.397862] RSP: 0018:ffffd05f83a03c60 EFLAGS: 00010246
> [  216.397867] RAX: 0000000000000000 RBX: ffff8db0425a49c0 RCX: 000000000=
0000000
> [  216.397871] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffb=
0364910
> [  216.397873] RBP: ffff8dafc9fc0550 R08: ffff8dafca8f90a8 R09: 000000000=
0000000
> [  216.397876] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8dafc=
9fc0000
> [  216.397878] R13: ffff8dafc9fc0560 R14: 7fffffffffffffff R15: ffff8db04=
25a4980
> [  216.397882] FS:  00007fc096c06780(0000) GS:ffff8db74ea75000(0000) knlG=
S:0000000000000000
> [  216.397886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  216.397889] CR2: 00007fc096932010 CR3: 000000014040b005 CR4: 000000000=
0f72ef0
> [  216.397892] PKRU: 55555554
> [  216.397894] Call Trace:
> [  216.397898]  <TASK>
> [  216.397904]  vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
> [  216.397923]  vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
> [  216.397935]  vfio_df_close+0x4c/0x80 [vfio]
> [  216.397946]  vfio_df_group_close+0x36/0x80 [vfio]
> [  216.397956]  vfio_device_fops_release+0x21/0x40 [vfio]
> [  216.397965]  __fput+0xe6/0x2b0
> [  216.397972]  __x64_sys_close+0x3d/0x80
> [  216.397979]  do_syscall_64+0xea/0x15d0
> [  216.397988]  ? ksys_write+0x6b/0xe0
> [  216.397996]  ? __x64_sys_pread64+0x91/0xc0
> [  216.398003]  ? do_syscall_64+0x128/0x15d0
> [  216.398010]  ? do_syscall_64+0x128/0x15d0
> [  216.398017]  ? ksys_write+0x6b/0xe0
> [  216.398023]  ? do_syscall_64+0x128/0x15d0
> [  216.398029]  ? __x64_sys_ioctl+0x96/0xe0
> [  216.398036]  ? do_syscall_64+0x128/0x15d0
> [  216.398042]  ? do_syscall_64+0x9f/0x15d0
> [  216.398048]  ? clear_bhb_loop+0x30/0x80
> [  216.398054]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  216.398059] RIP: 0033:0x7fc096c9a687
> [  216.398063] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 5=
9 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <=
5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [  216.398067] RSP: 002b:00007ffe422781f0 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000003
> [  216.398071] RAX: ffffffffffffffda RBX: 00007fc096c06780 RCX: 00007fc09=
6c9a687
> [  216.398074] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000005
> [  216.398076] RBP: 0000000000a83590 R08: 0000000000000000 R09: 000000000=
0000000
> [  216.398079] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc09=
6f43160
> [  216.398081] R13: 0000000000000135 R14: 0000000000a83590 R15: 00007fc09=
6f43168
> [  216.398087]  </TASK>
> [  216.398089] ---[ end trace 0000000000000000 ]---
>=20
> Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
> Closes: https://lore.kernel.org/kvm/GVXPR02MB12019AA6014F27EF5D773E89BFB3=
72@GVXPR02MB12019.eurprd02.prod.outlook.com/
> Reported-by: Joonas Kylm=C3=A4l=C3=A4 <joonas.kylmala@netum.fi>
> Assisted-by: Gemini:gemini-3.1-flash-lite-preview
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index f87fd32e4a01..deb9c351c4a6 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -389,14 +389,20 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_=
device *vdev)
>  		dma_resv_lock(priv->dmabuf->resv, NULL);
>  		list_del_init(&priv->dmabufs_elm);
>  		priv->vdev =3D NULL;
> -		priv->revoked =3D true;
> -		dma_buf_invalidate_mappings(priv->dmabuf);
> -		dma_resv_wait_timeout(priv->dmabuf->resv,
> -				      DMA_RESV_USAGE_BOOKKEEP, false,
> -				      MAX_SCHEDULE_TIMEOUT);
> -		dma_resv_unlock(priv->dmabuf->resv);
> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> -		wait_for_completion(&priv->comp);
> +
> +		if (!priv->revoked) {
> +			priv->revoked =3D true;
> +			dma_buf_invalidate_mappings(priv->dmabuf);
> +			dma_resv_wait_timeout(priv->dmabuf->resv,
> +					      DMA_RESV_USAGE_BOOKKEEP, false,
> +					      MAX_SCHEDULE_TIMEOUT);
> +			dma_resv_unlock(priv->dmabuf->resv);
> +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
> +			wait_for_completion(&priv->comp);
> +		} else {
> +			dma_resv_unlock(priv->dmabuf->resv);
> +		}
> +
>  		vfio_device_put_registration(&vdev->vdev);
>  		fput(priv->dmabuf->file);
>  	}

Thanks for taking a look at this.  I was putting some AI to work on
this AI sourced issue as well.  We found a similar solution, but
ultimately headed in a direction that it would be best to return the
device to the dmabuf creation state rather than allow this invariant
refcount to exist.  There's an alternate option below that Leon and
Christian can weigh in on.  I'll post some selftests additions that
trigger this and exercise the expected flows regardless.  Thanks,

Alex

commit 744d9704fb83e843d511c0c668c16d43175c6ad7
Author: Alex Williamson <alex.williamson@nvidia.com>
Date:   Wed Apr 29 12:19:34 2026 -0600

    vfio/pci: fix dma-buf kref underflow after revoke
   =20
    vfio_pci_dma_buf_move(revoked=3Dtrue) and vfio_pci_dma_buf_cleanup()
    ran the same drain sequence: set priv->revoked, invalidate mappings,
    wait for fences, drop the registered kref, wait for completion.
    When the VFIO device fd was closed after PCI_COMMAND_MEMORY had been
    cleared, both ran in turn -- the second kref_put underflowed and the
    subsequent wait_for_completion() blocked on a completion that the
    first run had already consumed:
   =20
      refcount_t: underflow; use-after-free.
      WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
      Call Trace:
       vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
       vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
       vfio_df_close+0x4c/0x80 [vfio]
       vfio_df_group_close+0x36/0x80 [vfio]
       vfio_device_fops_release+0x21/0x40 [vfio]
       __fput+0xe6/0x2b0
       __x64_sys_close+0x3d/0x80
   =20
    Collapse the duplication: vfio_pci_dma_buf_cleanup() now delegates
    the drain to vfio_pci_dma_buf_move(true), which is idempotent for
    already-revoked dma-bufs.  cleanup retains only list removal and
    the device registration drop; the dma_resv_lock that bracketed
    those is dropped along with the in-line drain that required it,
    memory_lock continues to protect them.
   =20
    Re-arm the kref and the completion at the end of move()'s revoke
    branch so post-revoke state matches post-creation (kref =3D=3D 1,
    completion ready).  This keeps cleanup's call into move() a no-op
    when revoke already ran, and replaces the explicit kref_init() that
    the un-revoke branch used to perform for the un-revoke -> remap
    path.
   =20
    Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
    Reported-by: Joonas Kylm=C3=A4l=C3=A4 <joonas.kylmala@netum.fi>
    Closes: https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BF=
B372@GVXPR02MB12019.eurprd02.prod.outlook.com/
    Assisted-by: Claude:claude-opus-4-7
    Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci=
_dmabuf.c
index f87fd32e4a01..fdc22e8b4656 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -354,19 +354,18 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_devic=
e *vdev, bool revoked)
 			if (revoked) {
 				kref_put(&priv->kref, vfio_pci_dma_buf_done);
 				wait_for_completion(&priv->comp);
-			} else {
 				/*
-				 * Kref is initialize again, because when revoke
-				 * was performed the reference counter was decreased
-				 * to zero to trigger completion.
+				 * Re-arm the registered kref reference and the
+				 * completion so the post-revoke state matches the
+				 * post-creation state.  An un-revoke followed by a
+				 * new mapping needs the kref to be non-zero before
+				 * kref_get(), and vfio_pci_dma_buf_cleanup()
+				 * delegates its drain back through this revoke
+				 * path on a possibly-already-revoked dma-buf.
 				 */
 				kref_init(&priv->kref);
-				/*
-				 * There is no need to wait as no mapping was
-				 * performed when the previous status was
-				 * priv->revoked =3D=3D true.
-				 */
 				reinit_completion(&priv->comp);
+			} else {
 				dma_resv_lock(priv->dmabuf->resv, NULL);
 				priv->revoked =3D false;
 				dma_resv_unlock(priv->dmabuf->resv);
@@ -382,21 +381,22 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_de=
vice *vdev)
 	struct vfio_pci_dma_buf *tmp;
=20
 	down_write(&vdev->memory_lock);
+
+	/*
+	 * Drain any active mappings via the revoke path.  The move is
+	 * idempotent for dma-bufs already in the revoked state and
+	 * leaves every priv with the kref re-armed and the completion
+	 * ready, so cleanup itself does not need to participate in kref
+	 * bookkeeping.
+	 */
+	vfio_pci_dma_buf_move(vdev, true);
+
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
=20
-		dma_resv_lock(priv->dmabuf->resv, NULL);
 		list_del_init(&priv->dmabufs_elm);
 		priv->vdev =3D NULL;
-		priv->revoked =3D true;
-		dma_buf_invalidate_mappings(priv->dmabuf);
-		dma_resv_wait_timeout(priv->dmabuf->resv,
-				      DMA_RESV_USAGE_BOOKKEEP, false,
-				      MAX_SCHEDULE_TIMEOUT);
-		dma_resv_unlock(priv->dmabuf->resv);
-		kref_put(&priv->kref, vfio_pci_dma_buf_done);
-		wait_for_completion(&priv->comp);
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
