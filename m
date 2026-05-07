Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9009847F2DF
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181746; cv=fail; b=H14V7Ku/F0xgod0FAWRE1dP2tcuwPu096eoSOqoiIax1kvoypc98BNIcDotOE+XmLZHv7ryrtAxD5B9AfJbGvC4vy92TVBNWOYuY4H5HGcL3xuBwlmosW0U5kCq/v/gr8DehzEHFBsSf/v4qQtqkBk575lNo9YXNtg5Lgws3kVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181746; c=relaxed/simple;
	bh=8R4ZQRQm53k6uDWLVkxMgEL2hOYmnx9h3X6GOFqsPfU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E8CV7ENAHwv9T+mRNQIwofjCLDuNF2UY7/kE9y7wit1R6VYRthgXdoSzSOGSOgyhbzzIJn1gCCVyZHrAYZ4oBmTjZs6ty/XWUENzjcM3i4dGo3XQ097Mw2YBJXcR2p1ZHAVjzvsl4RD6fbq2iOZc9RX9/+OLvG7uUcoSUxwvnIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fUImZFKx; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fUImZFKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZWTJ7Hl258JXew0hddGFbfRpfMfJcnSzbijVm4xs9YxAojm3MWVkw+1tg1W17Ycd9Rn7AerQTdkCF2poCQ1NFl+gVFEVXzto+lF+L/uxULN//OvVTumfcIbXpFtXx7ob+5UJVXMx+fVwHPlYVqaKSzfnZ3C/VCt9RVWXaO5r1Z0lAIwuG7Qu7mpRdlHSr2NEUWcUPcUHbgJG/Z5Rz7flKmaxPjqy2mREhS0mAcEuUofi7vjp7vkog1X9Xl0neJ2cEKfNKzymd+9EqTwbtTg0NwLZpTFjxLgZes1IMbQveq++DDN4Wj6zqKT55zj6dxnXYZL1+Y7EFL6zSjaDotSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3btMDCaufN9/MX/rfRbthcn+439gmt9FgYgCOWAqYQ=;
 b=U6vGMbFO2J18IOeq4sq5m+P8G6iALY210eGx/pudsN1OReW57f3OoRgNpTvejU2gWxyF89ixPviEtlc2+XJ254i55v7KtsQpVjkv8QbvQwT3O4gCF3f3uK5oGsLWjZIa2/m0Swws4LwwuLz4PRxaRDIUqw8GBN1B1a44Y0ZBmiCH655FGAQSVAlUlRnNsqKQ0kmHr3e1KwpDCsbxAcvGDoF6GUPm8dGwhHTNZY5694BM31biEKhfxelFjhcqKnMlZ0lAl67YVNDU5nTnSPQHGeJQOB7Ifpu7rkSfrADiw7qzUnyU07vGc89W7wme3yGZ9LyKrzj1olzFOP8AM7sFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3btMDCaufN9/MX/rfRbthcn+439gmt9FgYgCOWAqYQ=;
 b=fUImZFKxkPf5K9cYhLPYAJfsIiE0XvbxpJUyb23HRBBzB7r9WNVjQ3//zsTrSNEXuWme7qD4Zabwg3VawSZO+lEJYdkhB8EYuFTn80+xaVanXb0meCZE0rCShHJsLLfJCcVdEbOEtBrN2wNmqzi2HIQceqI82QypiThnfNs8YloeOodHIIllaW2CqukP4QSmJaPI3Q9+Z8UbljIP8bZVNIB1KwGcZp8rVU8yd22Vhnr85BeNuJPzbCh6xWrD/ZLAFj7NxC//QpinplBzhrXEMs4G3/SYgHUbsFkqzuA7XU5NEN4YYURLYS1+uDMygPIiW2qhlowD6YPn2es8Pnlu+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 19:22:18 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:22:16 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: alex@shazbot.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	kvm@vger.kernel.org,
	jgg@ziepe.ca,
	rananta@google.com,
	yishaih@nvidia.com
Subject: [PATCH 0/2] vfio: Fix racy bitfields and tighten struct layout
Date: Thu,  7 May 2026 13:22:00 -0600
Message-ID: <20260507192206.1350046-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: a0701353-ec9b-4d99-8389-08deac6df32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TZio+1jfUv6ClZ/Ebweakz2e3gEahkkyvOQDfk8Pjymoup2/fG/AS3IzKGhhDKHX1EapX5M6iqepAdqMN37Bs2adA64P2y2XzszztFm9z56RaJBhlLznQxkpLzedME3unYBYN/erog3ZQip3RFu9cbH/yJi06sFTwQxIw/kpM9N46/0x2MdbdskjYE7LzOgBlDCAubKAddJaP3WxsiHOT8D0htPIRPd1FNTuZZkO1SKduOCXx8qNP4BAUE9SwMFWV4KfTPJ2iW/NJQMzEmpmMnW8ObMZnbDaPxrPkXqZckNYge8yhEpn1DctJ0BLxDP4/e6AfrlhEPN3Cxq72xuzxR95n1Yq2iML16i4u/EFGnJH4xW5KdrfZgDb75jpPw7ojoGzrizWrwbjLLyuYrezfj7UaJsWckFR2sWxzbMBwBMpahowECoXMouIOIBFUOWQIFrnYR8Qc6TktlX2fTtHjqEIS33gCAowZVivZhyWDntwTTHvFqC+3mosVW5qgMHM4+dVhJGx6Ozb0wQBmr72MtYBfXx+oUmzEEunRRp3CCFl3waMX0jxF7faqUhCZaN5T+I4A1fveXU150PBETvKShwN2YcpmN6GlqXncCmvl5uoNXBDApnX9ZbHzygp75SxTxs0s2LifglSEWncPtn34deRtCmHx0WLWCY/RQmcWNqpWhYiNg2HGCcRyTHGFHEy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wq4PRhbf8D+MY6pQUgdxxSPTar+lTn6Z0KnFqXBr5lm6cjyTOMWKd/Tdif/X?=
 =?us-ascii?Q?Fu61b/gllZfHN1LpkAxeuzk9MdYamvJCNApKrtmSXT154xGUarmw6VatVQbQ?=
 =?us-ascii?Q?MD46y/tnm5It4PPSsHAWHHb9wuuFvvHQvkeM7T0NwmXCn6Dg/LED8EBq1p4u?=
 =?us-ascii?Q?sZpe9YFkd32Vpu7dnBftL75AHF80OYhhbz02HAAwrZTAube59AkY0L8ptcrX?=
 =?us-ascii?Q?Y4dWSANfBQQzgqcaj+1S1n1aNWflqbOMtbX8QWK4aea9Z7uytMwP5l1irVAP?=
 =?us-ascii?Q?U5Pn18Lj5U2eWRnXndDvSWqoCNbcUKVtnX+7CJ9jClWVtMdKsY4MGEfHZQn/?=
 =?us-ascii?Q?+jq9+9IiRwZJdJKSuFTaLSH5aaqhVreVHx/tzBgj1MBo69f5plyLKopKbmRb?=
 =?us-ascii?Q?+/wssHcm+zrPvwoJgloF/s32IPeQZcxp/xzp+2F8PSIvyTSLszUDyPxjp/zD?=
 =?us-ascii?Q?SXq0phS8PUOktbB5znvRF2Phir4vxUF2VxmblGyvfSTwwfSiG5hR/IDiQQKV?=
 =?us-ascii?Q?xCFaxEVZUpLFqYa6zdM++j8cQuwtMN60cLVE3IItbF5C0q1tZYzvQaXFbjXi?=
 =?us-ascii?Q?JuJm5n8YI4lOJ1k6y5j5+gPMBLDCc3yP2ZtU1G6RKSfPy90IIsTmyE/HT9+e?=
 =?us-ascii?Q?tXNAjnKTmAhq+OIhcQBfSlf2MKGXGD3/GARbhevzBXHpJc1YsRZjdwR37MBa?=
 =?us-ascii?Q?vkebXHPUG5l5cZkmZMvdltmL23Tsppgys0SizKT88v9Ghfhv1GBmW0vsiV/q?=
 =?us-ascii?Q?TB1zsDhXdK7vvHSJKqUbYgK8NLcsidoVY+yng7Nzc2f2LaLbDg5J0+QtEbVF?=
 =?us-ascii?Q?yhA7b6FZgr59a5nkNNQ3KJ17Dwx5pGXedSknfUexR+n0ruFt6rpwXrVpjTGB?=
 =?us-ascii?Q?3LNffa+yoNLTRhOmbJ12we1iZmauopj8k9SMldK32qSz4BX3uFQ2tLrdrlzK?=
 =?us-ascii?Q?OhfUYtuCbr/7IFGxbjS2/sDYZcunUJtUQmf/10YT++qcBloyIyTzxE8gE22z?=
 =?us-ascii?Q?pRmu7jC/OdCbRbBMekoaOlZRKPwd2NiZWDotNCj2lhyjRDpaVoERELJbew1f?=
 =?us-ascii?Q?X5I8wfrDEywhSUYPacj25V7ZQC6fN2ces3MW9q8oHZIruHy5tDHK4BOrctXC?=
 =?us-ascii?Q?dgn8lpNlnQ55kuaD05NrXzJkgFfg446NuPUwgDllgbrBGWlLNglqQj6QYQUx?=
 =?us-ascii?Q?GthWJ1rjmLFzf8YplnRTVnIBAMz6R+ZDM0rPKBicCbA9xNNcNbgVg79RQjBT?=
 =?us-ascii?Q?zeioV9ysccOF27KBdBTvHtfvJrop9T/ZbqiLZlczldxSKj9FZlYBmcaWTjzK?=
 =?us-ascii?Q?6vtY+7H90C9KHEocR1B6JkHlbiTP3MUQzdZumd31UuzhzIzS0lvHXm7/QP6h?=
 =?us-ascii?Q?RXbAVMh7IrT8eGLDcTSWDgz3vB8C14uD7aCDcxxSZ6Yh6nVYu1fNR63WMXVF?=
 =?us-ascii?Q?Z1b8Bi3seDf4nMhtOgxRHSJ3eEy1GMLThEP6oz2AgKtGx/VP0dHX/4reInrW?=
 =?us-ascii?Q?kuds97oCOl6leoEqZaubby8TsXxg19OEizJp9+daiR5BB5lkqxA3ICK2v32f?=
 =?us-ascii?Q?lOSCrWxL8VcE61ZqvfyjlonF92cgeSJ6kbIJLXTblmsNpcRMR5NRKihLQqvA?=
 =?us-ascii?Q?Zelb17CdJ4Z1qQFXa7Co1OEW8VG9ZN9dwDLd172i/q64ODNF6vYjf6B9q0KA?=
 =?us-ascii?Q?A4uVd7gpAUnX5qSflr2mIbwgx5LZKbixNSgUIAwGNJvrjISs8sVxaYS7O88C?=
 =?us-ascii?Q?GFxmgUOXkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0701353-ec9b-4d99-8389-08deac6df32e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 19:22:16.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L2QbowkW8P3VkZTAYTe5/wLHGMJzSFIkYPKgk0340nF1P8G0FF5yqUVBEZUNCW5UbQMNksMvw8agLQnPRf5uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758

This follows Raghavendra's "vfio/pci: Use a private flag to prevent
power state change with VFs"[1] and addresses a portion of the
Sashiko review[2].  The review flagged that the new sriov_pwr_active:1
bitfield shares storage with concurrently-updated neighbors so a
bitfield RMW could clobber an adjacent field's update.
                                                            
Auditing bitfield users in vfio_pci_core_device finds several
pre-existing fields with the same hazard, and an analogous pattern in
mlx5_vhca_page_tracker / mlx5vf_pci_core_device.  This series splits
all such fields out of their shared storage words, resolving both the
existing and proposed cases.  Applies on top of [1].

Thanks,
Alex

[1] https://lore.kernel.org/all/20260504224142.1041477-1-rananta@google.com/
[2] https://sashiko.dev/#/patchset/20260504224142.1041477-1-rananta@google.com

Alex Williamson (2):
  vfio/pci: Fix racy bitfields and tighten struct layout
  vfio/mlx5: Fix racy bitfields and tighten struct layout

 drivers/vfio/pci/mlx5/cmd.h   |  8 ++++----
 include/linux/vfio_pci_core.h | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.51.0

