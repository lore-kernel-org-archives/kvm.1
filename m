Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6E1A9FB7
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123466; cv=fail; b=FChKVTI2AV8qdAAU0hmIQ4VOFbzZ7MvriYwdXZHvl4fH29JXK/3cIvnaXNcQbok3f6raiwUfdPWKCDaRAEkieTdB4Zd9ozrtaie1HkOo5gdxnIZ+iH1sL2+pJVXPrTuirPmNqb9j223CADn7IcK/sehoSASnHkH2lae2tvZ7Af0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123466; c=relaxed/simple;
	bh=rjiO/Nx7yHqwtMZXItO7F6Zb6xOpIy/YlmRCtN4LTPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cNiho2QXvBBfKAkcrpIuvTMiqIA2FfZdi23tgv7hhU5YkPdGI2zK0jaz5ss/Ilz2pJ+G0x8lhwCOtpBkAS6pSYrfFiU5nQfFxq9JsoXzvT9dPi/j0mHw99jBBPMbxm2Io/fNrpVIj8udrRU1YZOYH6QHMI0kBkoT47yDkBLtC2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E+KXBrlQ; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E+KXBrlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixuDzFTu3o3cLhDLxAXw9k36ajpWBQcElWs2KF7poV4i31se9bnq1Ib+1RBOLhqOTaFl55Eu9hwhXN18OAwYhXsTITSEAbiBqa6HKbmYB6vH3E2gkD/MRgBbka/HSsu6orkl6pQ+gDquJ26UmHftA+w656bp+Onk858w9bu+KH5KWpYtqVxJNrEJ1yxDGDEE4RNxxXsT3l3+QLFcdEKpA19gqaOWkzpuc3fEJHPrjh2KbVfNTDN3nvvc1m85T7k80qnZBblyVS1SzC4M9oe6sx1tS4WtyyrEgM9U0x8ltoWGPHp6mLFiMW0p8fe7qZFhjJc2OCatBjYM8cSaZ6PosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCWFu4amVIxmXIBcf5KEkUitagPlG2sTyC0lEmmZMtY=;
 b=Fp8GrQYm8xeOtqFZl3NRkJnYxPaVLUKIF7vui0oZK9J99TbHjG7g5Ad+4sFsY+YooPWfoX1/xx1oUlprbfMJEEwX88dvxVqkfGnsoG4b45PjsdBKCa9HriiN6sag3+V+sq9AFnpAQB6C4OKrXYgZXmHPO3rViPi1zgl5ptyEeWzK7rZYz/AZxiUaqdg5x7Vx9pSGb0F+95+tEnIP29hLj1q574yfYDqu+Lh8IpUjwEjzDD3ZWGYyKvS5/19a8twIxvgPqyZ3PnXdunzUB2YzURM3rXbL78i9P315o1L8OzhizOqpiRdmQW9Jd76oUEkLJV/jWAXtde31DrGZMGbvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCWFu4amVIxmXIBcf5KEkUitagPlG2sTyC0lEmmZMtY=;
 b=E+KXBrlQeCW768chc34C0NYYnNkj8oq/DL06rlcNPFmgiFDp2PBcAux0uWQMLyJrzOGh4mFUpW0HmeFxxPdSbcWPUQ8sJLTpewtJ1h+vcOw9hmftOjlUVLGiawPRyS17J3HhVJA3i3J+6v8jkHgPk5YXug/cNUSt6OAUZqnE9Mk=
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:17:41 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::eb) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 06:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:17:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:17:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:17:40 -0500
Received: from [10.143.193.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 01:17:37 -0500
Message-ID: <0a9b715c-0476-469d-a09e-b56cb9f41455@amd.com>
Date: Tue, 10 Mar 2026 11:47:31 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] KVM: x86: Add support for AMD Extended APIC
 registers
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <santosh.shukla@amd.com>,
	<nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>
References: <20260204074452.55453-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20260204074452.55453-1-manali.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9911a3-ad0b-4791-5373-08de7e6cbc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info:
	YUD2ap7dtbs+MhxSa/P5FqXOTq2YRIsS7EtlGw/GKOKvUGIYYMlCEn43cnVMfW6lmuKejqPDG6VTxdl1LC93haN+WR4yMimcvGRHcDiirFdBoWkmsRL0Oab6uUPi1Z3jLi94iW6iBT4lhNzXWaIwYdps8Qs1WocfVqZTHmEakD63Hb/5jYhJ6diM2aB7adnqjE6MtAiWzd5itkpsYto2rqAkZ8dcDTNZ/+Kbp0pVU+mbXfTTHXCavYxqqj+JCdLqVPm9dDexe0ee8v9o+U09CWFC/JySx/2IY9YmA+C20Yr0gzB082iaH9CqTLVF8QOXdzZ4OoudaRUkRLeO8eUfnQABXGgiErQxs6KKAaO+7+lExOJuWaDSR8htqrAX0aEpLwabeUH8R6PrP2jFEMnc1osT+ACNk/aMoPtRru30KSZanjMuUn6l34DGW57ozKM9aONd7iUpVQTC/tiZDbc4LD5EsEhWilCErSWZrB+oTDifa4J1dpKJsDIwGI7Zy9WXT123mKEvcpnEMv/7Vz7NMFqfqAEgPxIvtrI/bUOcwrtS6oPm4BNz/rW4QK9CjwYO0JRaMHzg7sajonav3M9n34OYWKggvIM5Cz9l5MnPl76SqY9abeO0UfjeBxWCrB902qSxPls+bLWLOZ4tW4bkWUjwEOq47MIJpkm8K8oU8ZzwQ3JdIeHKeC/FtXYTbVYkRD1Dy3BaAjzdO7QZb7AL+9n98ApENiLpZsgcJN4F9QY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wi92LoRQRqpdPHUW9HfNR48Dd3yFeUe6BqE4NPJOa+RvIL4Qwx7i6WnbtLrNSYLWr0G8u2g8Bw22+DqyotjtDb+zSYHuvYWrIzoxCgQYbnzqzmat3JHhgmCQe2Txlv0hiixjbuhSCPoGVHD/XnqgvS1cPhJBrNBHV4B2r18YwV7Zt1DOXL4rV2XJgqJQelt4KhK2i5tR3cDiqdWMZnMFSj73AuXGtSlvV63SeCbuvLTfmogUqAIONKKE+lY3wDcDAmISIyceh0Dx10XEldc0wEOL6vpFOPTAyzaYLizuxmEjnsbYHwHo4YTb3iD3Peuq3TsF9r2no7TBIgq0kLAVuzE52JPrsSztpRlN60A4BCSpx7CuVlilPl4f6pd8OjsgC/9BQ/N33NMDMg8iKso5tsUfVv7+SbGPl2U62ygZR+nlMmeXsdgNjfb1UC/gCvP+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:17:41.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9911a3-ad0b-4791-5373-08de7e6cbc3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

On 2/4/2026 1:14 PM, Manali Shukla wrote:
> Add support for AMD's Extended APIC registers, which reside in a 4KB
> APIC page instead of the legacy 1KB APIC register space.  Extended LVT
> registers (offsets 0x500-0x530) provide additional interrupt vectors
> for features like Instruction Based Sampling (IBS).
> 
> Introduce KVM_CAP_LAPIC2 to allow userspace to opt into the full 4KB
> APIC register space. The capability uses a bitmask to support different
> APIC extensions:
> 
>   KVM_LAPIC2_DEFAULT: 4KB APIC register space (common foundation)
>   KVM_LAPIC2_AMD_DEFAULT: Extended LVT registers (AMD-specific)
> 
> Add KVM_GET/SET_LAPIC2 ioctls that operate on a 4KB APIC register space
> accommodate extended registers.  Legacy KVM_GET/SET_LAPIC continue to
> work for backward compatibility.
> 
> Emulate extended APIC registers (APIC_EFEAT, APIC_ECTRL, APIC_EILVTn)
> when the guest has X86_FEATURE_EXTAPIC and userspace enables
> KVM_CAP_LAPIC2.  Current AMD processors support four extended LVT
> entries, future processors may support up to 255.
> 
> Integrate with AVIC to accelerate extended LVT MSR access when
> AVIC_EXTLVT is supported.  Reads are accelerated without VM-exits;
> writes trigger trap-style VM-exits.
> 
> Tested on AMD hardware with Extapic support:
> - Extended APIC register read/write emulation and AVIC acceleration
>   with IBS driver running on the guest
> - VM migration with extended APIC state and without extended APIC state
> - Backward compatibility check:
>   Fallback to legacy IOCTLs when KVM_CAP_LAPIC2 capability is not enabled
> 
> Equivalent Qemu changes can be found at:
> https://github.com/AMDESE/qemu/tree/extlvt_v1
> 
> Patches are prepared on kvm-x86/next (003f68c79227).
> 
> Manali Shukla (7):
>   KVM: x86: Refactor APIC register mask handling to support extended
>     APIC registers
>   x86/apic: Add helper to get maximum number of Extended LVT registers
>   KVM: SVM: Set kvm_caps.has_extapic when CPU supports Extended APIC
>   KVM: x86: Introduce KVM_CAP_LAPIC2 for 4KB APIC register space support
>   KVM: x86: Refactor APIC state get/set to accept variable-sized buffers
>   KVM: Add KVM_GET_LAPIC2 and KVM_SET_LAPIC2 for extended APIC
>   KVM: SVM: Add AVIC support for extended LVT MSRs
> 
> Santosh Shukla (2):
>   KVM: x86: Emulate Extended LVT registers for AMD guests
>   x86/cpufeatures: Add CPUID feature bit for Extended LVT AVIC
>     acceleration
> 
>  Documentation/virt/kvm/api.rst     |  75 +++++++++++++
>  arch/x86/include/asm/apic.h        |   1 +
>  arch/x86/include/asm/apicdef.h     |  18 +++
>  arch/x86/include/asm/cpufeatures.h |   1 +
>  arch/x86/include/asm/kvm_host.h    |  12 ++
>  arch/x86/include/uapi/asm/kvm.h    |   5 +
>  arch/x86/kernel/apic/apic.c        |  17 +++
>  arch/x86/kvm/cpuid.c               |  10 +-
>  arch/x86/kvm/lapic.c               | 169 ++++++++++++++++++++---------
>  arch/x86/kvm/lapic.h               |  14 ++-
>  arch/x86/kvm/svm/avic.c            |  14 +++
>  arch/x86/kvm/svm/svm.c             |   3 +
>  arch/x86/kvm/vmx/vmx.c             |  10 +-
>  arch/x86/kvm/x86.c                 |  93 +++++++++++++++-
>  arch/x86/kvm/x86.h                 |   2 +
>  include/uapi/linux/kvm.h           |   7 ++
>  16 files changed, 390 insertions(+), 61 deletions(-)
> 

A Gentle reminder to review.

-Manali

