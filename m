Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F02376BD0
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204774; cv=fail; b=ue8PKTrz7/QabBGndJBJCSXZ76iMJLlKGrbLAtnlIpnKIGKs9Ce1NI1+BovMczLNiwGsDGk5GMqmtwRHy8urLiedEF6pTIIaxdK6fCXluy/j66y1r+3sqYSMA9mrs/rJpN3utbnd4i0MvKF62o9zuAJ2ziOJ37uoXu69Aoluxvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204774; c=relaxed/simple;
	bh=IyX0+2gd5Lo5246VhxI8wP458XpFySkxwdQRX6tGxRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YterOVhLTR1vDoboVDQaYxdFNiUSXGWsSxFeGfSRv+UGgzlIA/s7sTJHvEkuWThETHsDb2bdu++z/N7/412sPpyDuO7R43aBWs1bdsFKN7fZBCgbiH2csm41vAvoUYP1NDZWrLH2IB3Z4e6zxOIMbAvCWEMua1Fnvb+reSBX8HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZKCEJL2; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZKCEJL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3tJ8iZrzkNVWluLExAhYTWFDpGF6LPQS+nIDhFt0JyYT86XOCmFPOnjJsSNON4pgyR/GLNrFwCUb+Cw6E/FYUraknBmRqXQNfDMuljtEp2Hxxa2V6DNm0XiYjygEml0NEHr6SIWpSusQwnjOANmRHbZ+wrNDV4kk4VmxrBTWVkz+davbZnxjctpXRLBtWV9+4U49ShovNI1tYw7xMW3KYGDgQy/Kovzbk1RuM6gHmP+jxBk7glHZcawPyq3JaHreGqiaD37B51fJBTyp3LwZFCDtR/+RMkffkHGIl5DMY5FwAfv3edTxLtrtD1px+Yva5zZ5Qs+EZAMmqfwOurZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du3ZJpkXE+vH+mGIfhxmlo2Rd2or7N/8uLQ1Y07LS/g=;
 b=TiSXZqUmFrHLz/2UzuJ58Y57NURoYf8n1NjtD1zWzxia8qaxQ7McUTfNt45YoaoStxH3QlOOhE4At/1xnFYaGEK860HwdahXDM5GG9VBsrYmvx2pu16b5AI2jrHGMo3JrgoNr70yMpG70Sd5Y+Of8DPRmsGjloAzxH/70hR7KnOJh2cckySeEfUVYFSDpIZ5D+ywaOuX0Ba5neVCr1jDs7K2hFksYJxuaMSDd/CIN+IT3+E3IC296DdD0xXZXJURZl+pFyamv1OZmwCSrzVN6u3/4dzLuFTYbb/MWO08PaQ6DgM6kgrHp/9X/PLdTUGl/yfmg2m7HWI7CxouLZ2ltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du3ZJpkXE+vH+mGIfhxmlo2Rd2or7N/8uLQ1Y07LS/g=;
 b=jZKCEJL22b6jb5QZ6kcE8n/uSO24cK5Z7Em7UYnEtBjmea8/7LNlUVk9vnfDl3L84hUaAmH849ipKvDXAKfZDYkS3iq/vL0/DdQP1iYp7My3BCditCN3d0lV4eCNb/WFw/Enxcvl0JNv+zPZ/5hr5s71YSdcGinyu+mo/1dOcIZmm/t5mLPPoqTPjawSbUgj3SqX0dJ/+YcaDPcL0Y46r9Ea0aiutfZjXUfRy7IUEDdVkB5f5PeN0jxRYXPv6NvVyDAiz0qA0KUzcvtJu9QmYrvPoV8f9ty7Q5ejPFMjiMPiYNY2CPASoR9XHtXmhs1+CMFqr4cOBF9x8Ycw9RIc7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 19:06:08 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 19:06:07 +0000
Date: Thu, 11 Jun 2026 13:06:06 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio/pci: Latch all module parameters per device
Message-ID: <20260611130606.5d0a9f7a@nvidia.com>
In-Reply-To: <20260611184428.C16441F00A3A@smtp.kernel.org>
References: <20260611182528.4004073-3-alex.williamson@nvidia.com>
	<20260611184428.C16441F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::10) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 415155a1-b40e-4590-f2c8-08dec7ec7e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|6133799003|11063799006|3023799007|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fBkjBBmKW0XISFzot9Y5sMeOFQC58p8h+ZCzRlloQQHFwzOr/VbS5xaq0nVT34DjIfQEHx3Phu2CeEvEqRB7sTTmt2LEMhbJUglE2M3vBwUuesSXUhp/0HUU2FPDP8oSENZuglQ6uZzr/dJM8tSWG7ubOMTv0fUHBk6BkSJgfXO81RH5ByzqX9zl25psRVKgUDhBMOJm1EFVeit1NMCP63I1OBcML/bts2INoRq323xJ4NEP4oF7ZM9V/mLGkmB29cNaYu+dtxAeQ9W/RU5juDtZJZwKkDxuCjAM/2Fk6OMqze0VC0mm+U0PPOiXVC2sxjHjIxahBy2zVTsCFYQ94ecqOgR5PabR7TbhYsEQPDdJlW9Zrj98al8C8jlM7+O1eHJyjyUmW7Q1v8Jsl1iM4H5n/TnOVtByzPcvB39YsfryeoOLAiwapP2bD743DhaOerN0e2JWZnn1anMup6pNB1hl6KSpvigkxFKJ+Dr2aXrKlY9zHjOKbZEkgB+OhchtdEwdYeMG+aSD8f59vao+Vy2wQKKoFLA3lOPXQuY5W8axk+kyZm84N4fKAiCzwVUkwhdleKkF1pcx/Ld5mtd8BVD7XiEeiWsqL9AXVhMldCksujcR+E8+6SH92q6NWurIp87EwAQbHLYShGNpVYgeqaAxH6rhaGNybqGlwi1V8k08yvB7yL18NQGqTaDOCXTl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(6133799003)(11063799006)(3023799007)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4iPo7dAkTrDiOCGbvjhQ9YFVXMcUfWSqH18pkJ/qbHGDPD0h3GBw0TbvXh5?=
 =?us-ascii?Q?FYObtBDxguIjBTMVNTMO/hFtsFB2KeH7nLIAyzt8SZj0XQaow+nqz1nGiaov?=
 =?us-ascii?Q?CKwekShOSJmNddxwQN8tWxy6hopGsmOzr41dxI0zaoBXL0pjJPUAvZsK2/Hh?=
 =?us-ascii?Q?ZOFMB23nxNBdRwAdBzGPLMEWula/nFx5RqZ57wSoyN7+62R9xOVIBcyfq42L?=
 =?us-ascii?Q?cQjMomXB4lsO7N+r9W+3VGiIDd7TaXCp2Y4F990IjGUuF/wugLXo2YgVA1sx?=
 =?us-ascii?Q?14MKQFEhAtmUGSCo/zq93YOLgj0P2nGIDoP0J1OABzUxnRxqX7sirkAT2XpP?=
 =?us-ascii?Q?btpvRsWjuSPZMzh+zJNrDdfo/VdaIWrQ4J2NV1xhbD+bIA6gsZ3sPhPsoV1O?=
 =?us-ascii?Q?8TgctR+PIJDFmX27sRJKVJbwEE2g4Q5CjwURjTkNx7gpK41ipOFum4ALrnX+?=
 =?us-ascii?Q?ub0dugg+PRnX2HUjs7Om5QUTc2Nc8i4UFrRtH9nLe2tRVTfUsP9Yx4K1M6t9?=
 =?us-ascii?Q?luT7dHUpnakRSzxbsfqjhj7GgZxTN3E2m1LLQ2d1z24S3clnl3AeNNQTMBqa?=
 =?us-ascii?Q?ckolrJOO0Cs9le+rHWtTV9oZtlAZg4GlRCAUMOgcIWjDjogQ2zPSsG+TPfyG?=
 =?us-ascii?Q?FgI8r0A4AV+ct/TAi7J6VGmAM/qxqTrlh9VLiznmjNVSCUt7mycJKLMPKs+e?=
 =?us-ascii?Q?N5BCSq6Xibc5a4pxxBfCxzQZGCdTC4sKYPlb7QIwsm5/PgKqQJkMv7WO3SC7?=
 =?us-ascii?Q?RI0YrdHZBeSXmTEXWJtPW/LexzbrykeOQaXhvYiP8s1pho4YYW635XLAy/fr?=
 =?us-ascii?Q?jlKHN9RcePLEpJQg/7VLe58cLq5S26K/lrr8ryPN3Sh4c/9ZYOk9Nfx4PnfO?=
 =?us-ascii?Q?3dXhrtYKze3aclvHozdo/ADo+ONjc+Qq7TwOZ7h2wgdVU4jy3jyWSSWrzv4J?=
 =?us-ascii?Q?u+zCrDGemZr8UeCRb3LeC0wuitgxuHCP+Wqu7ma4w7YjeYV/MHskajiCE2Ss?=
 =?us-ascii?Q?oJwJ7fE5W6Sp81bk/97fS9EZz51tDNHVTeGReCPY3aFiVQStniNQ4ebX0733?=
 =?us-ascii?Q?rMaT5gbmc37w1lCL2nN2Mmp2v6VMX8ajsSXzUQWGAOCtqq4nGAdrYsx0jSup?=
 =?us-ascii?Q?dZXTvviiu1yH2coelz37qCgMeWeF4QbBhZSdVZJzwTt18zj5TBWcjOuMsqlX?=
 =?us-ascii?Q?sMsoAUCfCsLBO6wA7aXx2iNH91be1swILkTvafenAQUqWkWoYuinH+PCwsQp?=
 =?us-ascii?Q?txQsKfKAx2VrzaIvpIt2Cf5OGtL+gBfSkDFibDhCy0Jf/ai43YGcW+dMZb5u?=
 =?us-ascii?Q?zFXK+8rQwjCAOyhhxpafaV6ATRraUUsMheKGu0d+MLbg2sYLsm1KKn41NC+9?=
 =?us-ascii?Q?EEef34o5o32uQpHwO5cbxgf/1EN32otxKYn+jWSOZ0HDWSGg6uRlwVrVQkwf?=
 =?us-ascii?Q?ItBa4fyZU6DoR9Up7QG+vN7XLOGkb3namywCxg3AYg48t26T2JVGbbI+hGwG?=
 =?us-ascii?Q?fQLR9AvYnPfUSx+710ceW5Z54701hX+S9uT6SIpvR84VPcxJiZNAU8OZmR02?=
 =?us-ascii?Q?K7a7tr/R5qQfnJn1wAyhffdkhYolxmfnc2plKfC0/H3P0/r3GeAQkPZL+Bti?=
 =?us-ascii?Q?2rrNr3H58lzxGESJWnIrxr6JyHPBjR+7zZn/93n3C/uUKqNsGloxeneeV2Ln?=
 =?us-ascii?Q?bxiM6LqvJdYgvEoK1xFyzP83kjZfKuqW+PbybgU+8y86SBpBa7RFQKfsltAN?=
 =?us-ascii?Q?0h+/lL9gCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415155a1-b40e-4590-f2c8-08dec7ec7e46
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:06:07.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezNk73IL6mGXEYh+66uoNbimgKMW0EL0fC781X+vwUrJ4lpyBCiUZJKAbzpxh8pfm+D08POUetMKHpohIStK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

On Thu, 11 Jun 2026 18:44:28 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] VGA Arbiter NULL Pointer Dereference on Error Path
> 
> Pre-existing issues:
> - [High] Bitfield data race breaking device interrupts and Runtime PM
> --
> 
> commit 26787ee0fbb65453cacc903b9b0170155208490a
> Author: Alex Williamson <alex.williamson@nvidia.com>
> 
> vfio/pci: Latch all module parameters per device
> 
> The vfio-pci module parameters of disable_idle_d3, nointxmask, and
> disable_vga latch vfio-pci policy into vfio-pci-core globals each time
> the vfio-pci module is initialized. The disable_idle_d3 parameter has
> already migrated to a per-device flag in order to provide consistency
> for refcounted PM operations for the lifetime of the device registration.
> 
> Pull the remaining vfio-pci module-parameter policy out of vfio-pci-core
> into per-device flags set at device initialization.
> 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 9f71eae0cc947..61cf1a1996b0d 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c  
> 
> [ ... ]
> 
> > @@ -111,11 +107,12 @@ static inline bool vfio_vga_disabled(void)
> >   */
> >  static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
> >  {
> > +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> >  	struct pci_dev *tmp = NULL;
> >  	unsigned char max_busnr;
> >  	unsigned int decodes;
> >  
> > -	if (single_vga || !vfio_vga_disabled() || pci_is_root_bus(pdev->bus))
> > +	if (single_vga || !vfio_vga_disabled(vdev) || pci_is_root_bus(pdev->bus))  
> 
> [Severity: High]
> If vfio_pci_core_register_device() fails on vfio_register_group_dev(), the
> error path skips calling vfio_pci_vga_uninit():
> 
> 	out_power:
> 		if (!vdev->disable_idle_d3)
> 			pm_runtime_get_noresume(dev);
> 
> 		pm_runtime_forbid(dev);
> 	out_vf:
> 		vfio_pci_vf_uninit(vdev);
> 		return ret;
> 
> This leaves the device registered with the VGA arbiter. After the probe fails,
> the driver core clears the drvdata.
> 
> Will the VGA arbiter later invoke this callback, causing dev_get_drvdata() to
> return NULL and vfio_vga_disabled(vdev) to panic when dereferencing vdev?

Tricky, preexisting lack of unwind becomes a NULL deref with per device
flags.  Will fix.
 
> > diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> > index 27aab3fdbb91d..74b950d73aef0 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h  
> 
> [ ... ]
> 
> > @@ -128,6 +128,8 @@ struct vfio_pci_core_device {
> >  	bool			pm_intx_masked:1;
> >  	bool			pm_runtime_engaged:1;
> >  	bool			disable_idle_d3:1;
> > +	bool			nointxmask:1;
> > +	bool			disable_vga:1;
> >  	bool			sriov_active;  
> 
> [Severity: High]
> This is a pre-existing issue, but this patch extends the bitfield block that
> has a data race.
> 
> vdev->pm_intx_masked and vdev->pm_runtime_engaged are adjacent bitfields.
> 
> In vfio_pci_core_runtime_suspend(), pm_intx_masked is updated without holding
> vdev->memory_lock:
> 
> 	vdev->pm_intx_masked = ((vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX) &&
> 				vfio_pci_intx_mask(vdev));
> 
> Concurrently, userspace can call __vfio_pci_runtime_pm_exit(), which takes
> vdev->memory_lock and updates pm_runtime_engaged:
> 
> 	if (vdev->pm_runtime_engaged) {
> 		vdev->pm_runtime_engaged = false;
> 
> Because these bitfields share the same memory byte and are updated without a
> shared lock, will the read-modify-write operations race and potentially lose
> one of the updates, permanently breaking device interrupts or low-power state
> entry?
> 

Sigh, yes, I need to get back to this too.  Thanks,

Alex
