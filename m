Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66763590CD;
	Thu, 12 Mar 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324694; cv=fail; b=kOdNHUWHxnynvQ9iYdv0Ze2TS3U6ZRZtapPhURw5uqy9qE09SV0Fqc11gjlEtcHz87Beh+YL3yevilanD3t7sACYJpuaJJytB19cIwSwOFAFJt47m/+x9VPpeT2RgHP8gfudk3YxLCcD9y2rK1jfXStO4SfDvxu19/AxzyALSoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324694; c=relaxed/simple;
	bh=y7wWD1cypFywNGNKhDCyOShnaY4gq52ahemRuyFNOwM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ikHLBr10iD5jkwRheoL6/PjGZTcyZXmI/Uwpx8nlwGKOa/bSjq9J2EHBUQ4ja3qyn6BwTi2ecz7zpUr35cYxgy4sCNCWttQHdy/g4pONonjkFxuvufMeWI+G1pFOPgoyNvXQxj34cN/9Qxw+XOoz0pkl04UN03lr0T/ljNT9bZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xchiCotj; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xchiCotj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybka1ivcw4kpEfSEnsKETBEu+e75rgPLqV+485PkFszh5GvGDZCD1W3dvyDxtX4FQ+QuWYiyG6bW0lj1nyqYgbHejpbqSgwU13HuV4P/mln9W0U/hKA43/NraB6hYnbqDACTD9JxgXvYYHyju/bQyQ8EUys75EW3II7zgadhDgglAN0Fpod8cdJ3sz26us9i5Ukn4ZPgo2yLkQcTN4YZdtMr3jo4qLPDhiLlWm2DSyDHv2AjvbN3QAi48yfzu+NsRnWyg6ZtK5mQLpfIedWTfD/iv/0BhPvRTPQc/jzliyqlDXyMGJvN7+mc4tSd/eCt6mtrUaJ2LjJdBncIb6k8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXqTs6M3zxKgXy/M4FAx+CHLIseQrCqXKX6a5JlyXO4=;
 b=jz0+RTUhc6tX1l4vNbgs9XcUz6yB4w0aHfZzcxRax3/GU8j8fhXs1Qm4ny3bvPHMnUQ3vL45qMhVZaktiGXzEqFFAH5Ws5DCGMZE6jCnlE4RCy4JWEcotAuuJVFYz5kkeMHMCmebg3cLGqDsKv8x8r8WDTOeKsrPHrIp9bWNeKCAk97wAM/WpfB8w/WOY4BchH5zH5NypM0QMhwrMf2tfLTHlTmWRKeU/vFGjNEVn3JF+dAEu5dlh7NHrNNZUh8UWTYoJNUklAib8ZuSRNf/7532IgSECxGf9MfkdMPLe0GuNHLTYkkYaKG285gCzmKIOOBRL7fgtdmd58pk7MCEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXqTs6M3zxKgXy/M4FAx+CHLIseQrCqXKX6a5JlyXO4=;
 b=xchiCotjP1x4xROr37adRaVVwPWt/H5R7VJDEO8ujRC43EVePQojdU0ZzyBZtH6fnCZpmsCzm7OOxiT7T5w4cP2HYQ8dX5nPdXIozIZYx6y80SKACWEuSBwR+qKu5+nyJVvnlkFPwzBxVa9fh7NWg5hiN+Cr+YaZqqfATHQehsU=
Received: from CH0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:33::28)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 14:11:26 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::5) by CH0PR08CA0023.outlook.office365.com
 (2603:10b6:610:33::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 14:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 14:11:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 09:11:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 07:08:21 -0700
Received: from [10.252.210.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 09:08:16 -0500
Message-ID: <ddf407e9-359d-4d4e-827d-98f212589e9f@amd.com>
Date: Thu, 12 Mar 2026 19:38:15 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Nikunj A. Dadhania" <nikunj@amd.com>
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: Dave Hansen <dave.hansen@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<xin@zytor.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <jon.grimm@amd.com>
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
 <cb492a37-3517-4738-b435-73311402e820@intel.com>
Content-Language: en-US
In-Reply-To: <cb492a37-3517-4738-b435-73311402e820@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: d59896d7-0b0a-4554-1fa1-08de80413fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|82310400026|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	69vY5OBVcaVQWUyhn78UX66lwZzooN/b0Qn/Jx0KHw+6VpN49xSmyWvmA9AjXzZM1LKX8DtnVzCGlL+ZVctTEYTbMsuwuqPmleUgeUXLWhPbZ2GdNtvShFa7oeHS/+lzFPm7Zef/Wo1ePTcgKUjHHX12Zcsq2MvLe6UofuGqyU4dHO2w9BxupJ/3iVfBQ70zfDo8A/3Bkrpn1rDZN08qOHyQP89YJ5vkOe+20HPpPqZvdvaHDH5UqTd0ruF2EcM9SoAtJ1dB2L/pbFCffdoRYMBjAFK7gg49biVNGrr3xhkdXNtUO/YVw5NhtGfq0wFD5wpA8HnkQ91eRICxM7b32/HS0lI9RC5JRj43BdXCb+Wj3D/BWTos/rsZb38UrjiPO2fGnPOyQMhTCPZW7804ZSvX4zVs90v+SZVd5Xs2DzMCd+RDai2lP6/k0WvzbXOoFX1gILYpn6HdKSZLs9drdCxTtYw9V9/U+v/RvibxnN5loec9lKEj7Hd9as0cgIDcNldAuAIKDUwYnne+PTeCECVHdwchCNPdth2scC8eVUB3X8PUIkJhW1aUK26ewxoK/S2ZugkrDH6+uT39t9+m1gl22ngzsWi1K2OlryfPk8xCAUM+qn+z6SVlZEtsPFRqWtcN1PVIHlwjJCi80Q1MQ9x7QGWRNNrzsIhHuF267Giw0EdIjdO4O94yYXvRwt7OkRIn+dbZMsXR47vbOPLzxgVHwrkwPEHjx8lDooY8qEnLaUdzUni1Y/g06GO2bqHWYuJXkzSPzHwqbj1B2XfWVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(82310400026)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0rWNd1co2x8gOwrqnUA1bKoJssu0lp/vuEzzMJ3rGYS2Fc4e6wnDPfuE+/JbY88JXSTzMpaJVBiVknqiu13eR7NkaRsniZxDhaAryhdGMNGoQqfhpDERzqtrHCpxJ/hIJPpaK+L+Csdx2meA/tsaHtaM1W+VyzdY3/pbPy1zPRZxJ2JzzR9ITbhBnbYF7rKmZt04D7jCtyJS8VDqr5lj3oq9dSuHKIp1+NrJEGB/fOiL5gXLJ5wbtWVZcOdUX/zjyQTlmLD1m3AlSJTn3RLmSmM9dxZYtyXkskP2VObTDse18DNqMH60TqgoE2BMQL+EUK/2VfJ9sgFy/Zoj5zm+Gccc0nA4znjZR/egDEGy9Vuj5lOlNfYpnoye0qjV1a3RY9D+zBW0+IZ9vaeXgHYxSn8tzq3wL9piHMl32VTSZH7gsfnYjkg0RZpPpRp8TuCF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:11:26.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d59896d7-0b0a-4554-1fa1-08de80413fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788


On 3/11/2026 10:58 PM, Dave Hansen wrote:
> On 3/11/26 08:42, Nikunj A. Dadhania wrote:

> BTW, commit c7ad5ad297e tells some of the tales of woe around CR4 and
> boot vs. secondary CPUs:
> 
> 	cpu_init() is weird: it's called rather late (after early
> 	identification and after most MMU state is initialized) on the
> 	boot CPU but is called extremely early (before identification)
> 	on secondary CPUs.
> 
> This weirdness is still biting us today. CR4 pinning just made things
> worse (or at least harder to understand).
> 
> I have the feeling we need to bite the bullet here and actually start
> thinking about this holistically. I _think_ 'mmu_cr4_features' is
> conceptually pretty close to what we need. It's just named wrong.
> 
> /*
>  * Current system-wide configuration information for CR4 register.
>  * All of the bits in these feature masks are supported by the current
>  * running CPU.
>  */
> struct cr4_config {
...
> 
> What do folks think? Can we expand the 'mmu_cr4_features' to more than
> MMU features?

I'll let you and the other x86 maintainers decide on the cr4_config 
approach. However, I have two concerns for the immediate fix:

1) Back-porting complexity: The current issue affects kernels (6.9+) 
   where SEV-SNP guests fail to boot with FRED enabled. A simpler fix would
   be easier to backport and verify across stable branches.

2) Scope and risk: The cr4_config refactoring touches core x86 boot paths 
   and would need careful analysis of all CR4 feature interactions 
   (PCID, FSGSBASE, SMEP, SMAP, etc.) across different boot scenarios 
   (boot CPU, secondary CPUs, real-mode transitions, kexec, etc.). 

Would it make sense to take a two-phase approach:

Phase 1 (suitable for stable as well):
  1) Universally set X86_CR4_FSGSBASE in cr4_init() and call cr4_init()
     from trap_init() on the boot CPU
  2) Disable CR pinning during secondary CPU bringup
  3) Add #VC handler for FRED and use boot_ghcb during early boot

Phase 2:
  - Build consensus among x86 maintainers on the cr4_config approach
  - Implement the refactoring once the design is agreed upon

I'm happy to work on Phase 2 with guidance from the maintainers, but would 
prefer to decouple it from the urgent boot failure fix.

Thanks,
Nikunj
