Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715C34F241
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777266528; cv=fail; b=Y2vHBo21chK2277rBlZzha2h8wZtUcTgLKaWmaRNLEmz7suJBBVCKp4eryvqcshtilCIqpweMcMf/tww8ETsBxUzgEl9ySpY1Vn07FO7HeYUH1QgwqbxjAlLSECvVl6sd/5MIsjZsluyg9y/BZhjIyLoSoWEVch5XaqiViAG23Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777266528; c=relaxed/simple;
	bh=RQmIJTWtcYq/npfKqBTlo+24TZmKgQw8vecedFRzbhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iCTukKiIW8/LWh37StUbclWjFYYvW7FKnm4EYernMAgtZlFalEfS6u7Y8oa+tT+WCTfHByyTwgbAZQDubjHaiwYRQhxvRMZ4ahdboSCvfci0DYBsFwvZX9xKUrGkit4uaxpYIsbYGV6zUnW3KsJCIiSZ7XDvoggtfojuTq6Ignc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rSY4CPRC; arc=fail smtp.client-ip=52.101.193.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rSY4CPRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWH/ab3tADRjNd9m2vHl3VI9yGVUcUBBZ7HnYOqWG14QP7f6Tas5UIBTsAw/9te2gl02Gzg83z94PcmlCDVq4p94bQxpca9PBaG2WZbyOcinufWOiifPHjLlS/kAPPqJjArmecO66ccEjol20CF3JZaILpumhzoBUT7lV3y0JUTY4r7x9Gpn0XEkTUl1+NU4jwhMlk0wyBW9Nu7oex+RHC6RvqsS3GZitc1MbKogORc4HUewRjdo4wJls016M+96B92VercYCGRYdO1EQbUrBu2HwlL6TC0Tfsld/cdSABa1GxWzrmMvkDsI+1zJBvnXwvwb8S1JbejbAojjjNbBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuBcPCfWem0LfmSH4uDHrkgz5QiPh5qgbxL+uzB1p60=;
 b=bhQuNMTNSxY7NUJchdszFhP9qD7vAAAnvJeaOSxWcSrtugcK10Wsz340Er0JHVE40afUfp2+njic8b8AhLQSn/KcxmfNJBBTZkxDYmVSRJRWjs8SmoFofunR/EFbxOr4JvF56bhwY6KAj4hMgBK9x9m2Vfjeq3kiNVkmh8qy8HzgiHYgfuJ15wd0hDZAruk75W02xHwy88ZyZ9qBXprHURIIeGJE3hV5CCTrLRGnduOSK0jIskz7S6fp7iknJY24wziyWS3MPzvTQFePq3CccH8HumRHJdeEbz2CRn9FUSeHJRxD9njr4VdRc5wiw9HVdsYDje1SxYuikaKijQ3fHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuBcPCfWem0LfmSH4uDHrkgz5QiPh5qgbxL+uzB1p60=;
 b=rSY4CPRCQgik8zyvyLWUL8ses1UQ9p57bS3NV211a/1qCNXnzsRn4Yn2v2OeP0byJd8+u77TpTJTezuH2gtY4CQEnTpF1KYCUo1LLCG6YjTANFKQ6wfv8zawX0po2E0hI20clNiojRrz918TyGqDR034GgrPaWPwUPh3GCEx7JY=
Received: from SJ0PR05CA0152.namprd05.prod.outlook.com (2603:10b6:a03:339::7)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 05:08:41 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::16) by SJ0PR05CA0152.outlook.office365.com
 (2603:10b6:a03:339::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:08:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Apr
 2026 00:08:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Apr
 2026 00:08:39 -0500
Received: from [10.252.198.192] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 00:08:36 -0500
Message-ID: <fc10c7fe-b55a-4d68-ac3b-6fb49a953794@amd.com>
Date: Mon, 27 Apr 2026 10:38:30 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] i386/kvm: Add support for extended APIC register
 space
To: <qemu-devel@nongnu.org>
CC: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	<kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	Richard Henderson <richard.henderson@linaro.org>, "Naveen N Rao"
	<naveen@kernel.org>, Nikunj Dadhaniya <nikunj@amd.com>
References: <20260219054207.471303-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20260219054207.471303-1-manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: manali.shukla@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: e5728e49-1136-446b-7cd1-08dea41b0c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/ZB+f+wSfDTSR5ptJ+8LBqcMdEhp3JyufN+Qxfu324lX4Qi4B2t6rpXpVW69OfYdjUerUFgPDkXyTQvvCoVqIPPm2b3tN0H/DOT4v7Lc7SfrBQU/CXAyormNDWcQ89GOM6VW7KPbRhFfC/eG8mB9ZE0ysT5NVhHPLcyRhQIzkD4LCUem3+ESXTfa5redOQHyvK17ztk7mY4PjEYbKr5nS3OD6stEVVIEM1wxZRVnZ+nZxruA3IrFCzATcGyxmQes7GBScV2m5UcFTu8tVNXaB4TSf21md+1yAle2q8r1OJ8e+4uKRLPjWi5OE8Ix8SrDwkOGGf09v9jNm2ENsYwhyUQ7mE5eBToMgxzjVuC6PMJYQaYaHITRBMvdzK7GDG4teZAFaRhQQgKtxKVlz6YiA9u7KfxI5WIWdMHo7A72OQoOHaU8XowuHd1GClm+LippxnsIscBstDyYA/Bwy1ykHiXesst5jvfzvHdTJZyXxEwwr3IAOr3YSvrjr0xk9kR5gv035xbLZ9MuY8XP3nPRqE1RlqQtCKIrBC9pDK+XtRbjcPZvjLN8+Umi/UnGgve2FTwTFjCx8s0f3xyqCI+yrCtOFSsMGePN17XpiYf2PkN230d7SU0tLbooeYkybQOwB5ROtxhrAXiqqYvVQO/dSfjHVr2m6X5x2yXdyrR8y70O224OflKBLp3/F2peSEmmc3wTSKIp6QOmSnYuHRnLbQV3D93078/OmSw4MRqWyIgqPAJqPjMWwnbIGZrw5C6H7Qk1EwYZVIpvVYnDWApPOreM8F/3NsHKq3rg+/QGlbE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jNMqe12Qr0FOZt+FkYkTddus0TeWRi+2iHcvIl2rCUFh0+p4ssFZQyFy6Dbl4qd144dsBdPVM9d0UdxTq9/CKbFazq6sNuTP2vZw+i+Oy5GuZP/AJhswRV5K4rZTs2jZrV7gEqKBgx4HuDjj8nJ/w4QamMWtAuCIxMx9bAb6OFGiE9k5wKEePRvUVqVTnDomZkfauilOOrHtltP57133Ex1zxAy+N7eY2tkEGOdfQ8sqh4Vst5ymQgCvd4zaX863+ao4/Nu5OotQZvvgmjoIXqIpgT/AAUa8ldd2ZoEkrTMczEML7DeQHDjkCyJXBFkFoNUWnUpdGtpisE7/dV+5dqMJsV4K0XKmNPlRdq/oKRW/LsudUStPZyrZk/ZPmSotoiu25oiAcHitx062kkfvZSH/KQ43jycyL/Bk7PiFq9CmFMK5z1/hX8+Leh7K5AHh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:08:40.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5728e49-1136-446b-7cd1-08dea41b0c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

On 2/19/2026 11:11 AM, Manali Shukla wrote:
> Add support for KVM_CAP_LAPIC2, which enables the full 4KB APIC register
> page instead of the legacy 1KB register space. The capability uses a bitmask
> design to support different APIC extensions:
> 
>   - KVM_LAPIC2_DEFAULT: Basic 4KB APIC page support
>   - KVM_LAPIC2_AMD_DEFAULT: AMD extended LVT registers within the 4KB page
> 
> The base capability (KVM_LAPIC2_DEFAULT) provides the foundation for
> exposing the full APIC register space.
> 
> AMD processors with the ExtApicSpace feature (CPUID 8000_0001h.ECX[3])
> further extend LAPIC space with additional LVT registers starting at offset
> 0x400. These extended LVT registers provide additional interrupt vectors
> for AMD-specific features like Instruction Based Sampling (IBS).
> 
> This series implements:
> 
> 1. Refactoring of existing APIC state functions to use generic pointers,
>    allowing them to work with both 1KB and 4KB APIC register spaces.
> 
> 2. Infrastructure to detect extended APIC support via arch_has_extapic()
>    and track negotiated capabilities.
> 
> 3. Extension of APICCommonState to store AMD extended APIC register state
>    (efeat, ectrl, extlvt array) with dynamic allocation based on the
>    number of extended LVT entries.
> 
> 4. Capability negotiation during vCPU pre-creation:
>    - Always request KVM_LAPIC2_DEFAULT for 4KB APIC page
>    - Additionally request KVM_LAPIC2_AMD_DEFAULT if CPU has ExtApicSpace
>    - Enable the intersection of KVM and QEMU capabilities
> 
> 5. New KVM_GET/SET_LAPIC2 ioctls operating on struct kvm_lapic_state2
>    (4KB) instead of struct kvm_lapic_state (1KB), with automatic
>    fallback to legacy ioctls for compatibility.
> 
> 6. New subsection of the vmstate (vmstate_apic_extended) of apic_common
>    module is added to make migration of extended APIC registers deterministic.
> 
> This series depends on the corresponding KVM patches:
>   https://lore.kernel.org/kvm/20260204074452.55453-1-manali.shukla@amd.com/
> 
> Patch 8 contains temporary UAPI definitions for testing and should NOT
> be merged. These definitions will be imported via update-linux-headers.sh
> once the kernel patches are merged.
> 
> Testing:
>   - Verified extended APIC state synchronization on AMD hardware with
>     ExtApicSpace support
>   - Confirmed fallback to legacy APIC ioctls on older KVM versions
>   - Validated VM migration compatibility
>   - Ran migration tests from Qemu to make sure there are no regressions due to
>     the changes done.
> 
> Repo : https://github.com/qemu/qemu.git
> branch : v10.1.0
> base commit : f8b2f64e23
> 
> Manali Shukla (8):
>   i386/kvm: Refactor APIC state functions to use generic register
>     pointer
>   i386/kvm: Pass APICCommonState directly to kvm_get_apic_state()
>   i386/apic: Add extended APIC helper functions
>   i386/kvm: Add extended APIC state to APICCommonState
>   i386/kvm: Add extended LAPIC capability negotiation
>   i386/kvm: Add KVM_GET/SET_LAPIC2 support for extended APIC state
>   apic_common: migrate extended APIC fields
>   DO NOT MERGE: Temporary EXTAPIC UAPI definitions
> 
>  hw/i386/kvm/apic.c              | 123 +++++++++++++++++++++++++-------
>  hw/intc/apic_common.c           |  21 ++++++
>  include/hw/i386/apic_internal.h |  11 +++
>  linux-headers/asm-x86/kvm.h     |   7 ++
>  linux-headers/linux/kvm.h       |   7 ++
>  target/i386/kvm/kvm.c           |  88 ++++++++++++++++++++++-
>  target/i386/kvm/kvm_i386.h      |   7 +-
>  7 files changed, 233 insertions(+), 31 deletions(-)
> 

A Gentle reminder to review.

-Manali
