Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55B4ED1A1;
	Mon, 12 Oct 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836164; cv=fail; b=Om0pPHL43icGKh3LSaCI8ptp6OerbJcLwFtAFk9OUkfqBMDy1o2bTThnIRtAfeOXcAA9hA9qP6LmibhglhPC72ZOlzIfdX+CwQmfhsJlAv9E8uqDgL2YmnS/qth2MsYvH12v1RAD8V1em48qAsEWvBBXcn8GB9WWCeCrOWy494s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836164; c=relaxed/simple;
	bh=jMmOQFqC2LmQ3gEfaXplCi9z4BfJqXkixnqhle5Zd/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih8LxfNhr/pNUGv+TQFNBf1FDaNgrfUl3sEvU05Sls+Pcjc7R6Mexs6Wqr68hlj6rqilIYoHFbyCx8yWEO8nobsHDxH+jZaLGUsQsW8n9xe2U0uAfcvJZYiPb4uB8aBPdZ2AdWEK0E6XOBDfgHUqaL18vneiVVKzONpczljGmmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SPwn3OmK; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SPwn3OmK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iulCtp9ITa+0O0jx9n8/jISv4sJxIpSRAjOLFl1s4pG6Wzgpzw+ssCUxWwlpFYhSi+YA+UXgKu8dTPxLUBkvjTWDPQebJS+7KMQsArzg2wTk1WViFHjpoN8kJSlpxo7CWi0XYw6I96BO4j8Kq+BwuszUUDxloHYOv5Khz0nLTKe+ItEAD+JZtLKtZm41DQYSw4u8jwp0qy89RDspZPjJadQRzmjttlcQKL1xGqugmTyuzsgTVX8X/lPIvGg7zL5vCO+GQrIZS+IfMr1akanxDbPXWsrPEDuK9+lkteeTAj3UY3ylqoB7a6WPQHeIirq/R2p8tF5LxteY1z0NCCOutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcfgIwGx6+qcyvn1+3QmddTeP7ComeiEXUdULXX7kxc=;
 b=YlGMnn+XraV6I8nV+th1KsBZ457SZ2ToaemCeCDa21gb6zphYkmtHFghbVJ4y0sj0P2tDWIAElXgbBuv43RFsEMj3NUqFtQMhp9PedkNyc+Nvhui3KF7mtldXu6jgJVuIIOO4lceKrWpfCcFQiTm0z+/eC2p2VlR5Vs72DQLfmNeIJ31TyFQYlStVQ1gxaoXUVf8PL66MiAh8DUpME+q5rthYTPxMUk4NncCAwYdCBJ6eg0lfOWV2LM8u6nGsXxkw2GSvlvNeRQ/nT/dbEGksfFhvJcdSQToT/Y1pJ7Dko+9zxrF4OLu/G8JAjZ1XHNGpelC/i14dHq76FGpaisL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcfgIwGx6+qcyvn1+3QmddTeP7ComeiEXUdULXX7kxc=;
 b=SPwn3OmKF7FNy+ZJrDiExLKlKLJKCGnJ41cvy1MJGxYs4q4z4Of9ZPqa8xsVg8/Y3+X6cGENW60RbNyqbLGrPxcf2d6Kli/piC3URabol46r7wE2JATRL16E6kC0X21L3PJsE2dV2yEvXNeLVppKSF57jGMphzCkopO5vLp7JAI=
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 20:15:51 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 20:15:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 20:15:51 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 12 Oct
 2026 15:15:45 -0500
Date: Mon, 12 Oct 2026 15:15:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>,
	"Ackerley Tng" <ackerleytng@google.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, Erdem Aktas <erdemaktas@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ashish Kalra
	<ashish.kalra@amd.com>, "Tom Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place
 conversion
Message-ID: <f5o47betsz74ahmirsymgipqdccpuodnz3ywktogsg42d5negu@j2wmff7y423m>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com>
 <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
 <asz8GKNO9aQANr5E@google.com>
 <as0FedYcvJvdOaq2@google.com>
 <qyykjxnxek73ddhbdexwz7jabjso33hdqzpf4syhrbrlh4eo5q@f4hwiuluzvgi>
 <as0-ayBpM44YxOHo@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <as0-ayBpM44YxOHo@google.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 51459522-2e6a-41c1-e61d-08df289d9cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|22082099003|18002099003|56012099006|6133799003|10067099003|4143699003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	96nHUivWlugUs7ViBLviUC3QbpaizZ04XH4hWNyKEvTjqbbSd14yD1VzMeTpK+BnC7Qfr6LsvNelfs6HyVbf5PyPw5mPSstmNzLzRmjRJVv9/n2IV1iRXVMckW2mPKJ66bBTyWsWnvrUK8X0zTDkdH+9Z1wYMBUsdAQogtdW0JRJYMa+CivyTbDNWILe8vk39Am1tly8DQ3x38Kcq3VjJuuQgMX1CePLBkQ/5aDRt2enM2hex4NrXvBYPaEkDuA4vHiI8bViDbHWh1MG2mrdvnI5hCOYs28sjAoNwoQbaSYeVfMoI4yC+tYqDM+cvFjVWhHIqcWu9ux1JJIyeLEm42IIBTB4rn8n8MFRh6DZ8ob+qBMYhlPwKiTX1LhQL9AkGtroiuPfjUWxkuCDXMv9ZyYUH0Yw6zPVT5I+uA+a1o42cCRFr3KJY75gt7Z2dQxhfJSqljizu7/axu9bd2jEyDx5tnF1g3I1StqJtiCHbVlbthwvI8cqa6hbzjNPXWNfEvoOopFtkV5xp71JNFsKFmMcNVtliFDmHbBG6rx2ftZ+F6VDokQj5d9e5pkK5rwOfo2/JGB4zIVajr2FZ479m8x2Nr/ViXSh0JZpFwitwxh5ntA4nTL7IrZys8AnEXKk6sOqI9a1ThA0/PfWWaWuIjiAJKzmdvCtXzC6/eQSbXjOLDRqTu52GeQbcuffmjucQik0DGgvm57AiGzpG+wBrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(4143699003)(11063799006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lIS/C27R04N/CbsD7orudEObAC2oq0pXHcDiy+Ho254qwjzwQwpCZLl4Qlc9ytylht2PDRc97DpoHNg2GdV2i912Ih53D9ZT6hgCCh4hkUwRF5t1FpomDRoRgnVXH+CaB2b9Hh/8Wbzc8L/Z17EU/MZYiUV3ngw0f8Rsbjxk8FSZ8dSn+MLKxbz+MkAjdkxFRyzoPfl4s4lemh7JDwd3iiQkbKAmbbuf20gEwG1iXkSlik1+Y/PNcdGI3HOWZ4AeNlyeEC2kegKtWfYwwUQe8C6mPp0KdVKiOUwVG1HUlxz456P8SzTumHbOKPh0GceuuFPjsuwGbgoO/tmK6psjFIBOy10UXA2tbeaa2CRjarHTSrlUMna12E7EgYrSls+ZWnddHHEy0FFO2Ni3LcbIA3RZIPJ13YrGmnyrS5MEmv9furSLYtOrZbtOEv9/zOXS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:15:51.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51459522-2e6a-41c1-e61d-08df289d9cbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

On Mon, Oct 12, 2026 at 01:09:15PM -0700, Sean Christopherson wrote:
> On Mon, Oct 12, 2026, Michael Roth wrote:
> > I don't have a reproducer for the specific ABBA in question though; I'm
> > confused at why sev_ioctl_do_platform_status() / SEV_CMD_PLATFORM_STATUS
> > would trigger a gmem fault (outside of malicious/intentional case) since
> > it is just querying status on behalf of host userspace and storing the
> > result in userspace buffer where there's no reason to use a guest/gmem
> > page. Was this test specifically set up to do this or was this reachable
> > from a normal path? Just trying to see if there are interactions I'm
> > failing to consider here.
> 
> I was just running KVM selftests, although I was running all of them at once.
> 
> The condition doesn't require an actual gmem fault.  The uaccess APIs have a
> __might_fault() to communicate that a page fault may occur, and lockdep is smart
> enough to piece together the problematic chain of locks.
> 
>   -> #1 (&mm->mmap_lock){++++}-{4:4}:
>          __might_fault+0x59/0x80  <===================
>          _copy_to_user+0x23/0x60
>          sev_ioctl_do_platform_status+0x50/0x80 [ccp]
>          sev_ioctl+0x220/0x2b0 [ccp]
>          __se_sys_ioctl+0x6d/0xb0
>          do_syscall_64+0xfe/0x460
>          entry_SYSCALL_64_after_hwframe+0x4b/0x53

Ok, that's pretty spiffy. I'll try that on my end as well.

Thanks!

-Mike
