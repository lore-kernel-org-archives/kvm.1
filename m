Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794774870;
	b=VG71n+Rgb8Y0klO53z9FdXtZeadeQ33XIxl0rTBWQnCIYaAb0YpLj7H04kEw+vzGe+AC
	 8uDNL0m8aAqPR5nIXStU2/m+i3bf7Iwv4uBOZUk2F2FSgr3AfJYWG7AXJxMu+kfktC2Sc
	 uVBLgtrcNEmVmOBu2N+P1e7YJygrkzlyS7qnBRDnz/B/fEcrt1CR6uCihc9HFjQqygJEb
	 iCPXqWLaEZCqHIJpK+lH4RT35sgbFL+JTefHebaKK9fTdDEbyU4d9gfb0FThZtFKbPDPH
	 UI6XxRjOF0AQKIXls4vJrmC/++Hwh4ec5BgHbl+MKuZXNwM8bODYLxBnME4SOzOeKfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774870;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TpC7qTXFnqcRwUYe8ylvcoPAiwtAlGB9WsiI+8KZ2vU=;
	b=dE92up02Zd2+tMN7m/+nIDUp4zrHUcDbQA0JgwhTCorPlJqWwvPWgqtvRaRzgEFRfV5n
	 PoI8K69fOkKyKuCweCIm4C3+wVua6b9gDATs769gIaqdlT6bDfXpltogLMCw9nysAqeBm
	 G9vsYI0wnw9csnbmSKF7+asyKmHlp2OYG383ZnQO/QO0LxmQoJxRZcKz2sw53XlmCo5Mr
	 QZgJRE0VDm2p3/bjtH6PuaQdE0a8Zau3HBy6GeoMrq2iPdv6ouKulvuCIaV5TXOT1+LN9
	 Mwx2JzjKu1RNzCkfS5M0MubPTb3ZRiTeixd0qq1ez/LD+H1QHPXFomXSIDzMwDJOKtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="zv/Jzk2R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.48
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB8606A31F
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BAB8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zv/Jzk2R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfYI6eyGqVw9xIjnIAUYePKjuAV9N8YBTBjJADNMiWFOBx/6deipdR2wfeerxuAlBFSf8qQmhnv7Fx0mH0fJjDhy61/n5NrM/VKKty/4kVy4NASgzOqu4F9Ih9xKYSwouz4XKABQVVaRFDhH/QNktETxwO4iS6zHA4iuVnkUFsmM0Ermx7o1ptOHsMO97rOfhemSZ3vz6RPe+MYkgS82MJ3OdxJsI2fvLwPnK1LUSDnc1vQnuKlhcKE348MBBz/ZJlAs4MKYeIczcfHubtPo6aqlaE3p+VBbXqjRBmVqSCpK7XQ0MTsWd/K/cRmS6s2TZwXCALF8zKwxTbiVmbLeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpC7qTXFnqcRwUYe8ylvcoPAiwtAlGB9WsiI+8KZ2vU=;
 b=fgFAf9kvJuUXrvCSv/inKPqrqbv0IB+cObnag+SijWS847+w0/D3mKgTfQ0fFvMSoFV7+3tpm5rFVWp5t/cwaONYSt77K4Tvn0D8D9WKUQ6aKjJ1h7WHHbuyzDNgQoXM2d0ALPIIHIu+dVyMvhZpYiFDzhvuYdvttHtLDj3BNke+g71/c9zks8F/Y2pEW8jsoQIcyv0l9V0vUybP7oM+xoFAsl7/Pcy2pmzYC/poAkVsYswlPcU334A3r0Uk+7eSxmbo71bfKQ4lwqqzfewReKudtJMCF0oYQyCWJG138RVkgyEVQnqn1bK3aJMpejhhd09SoWuZGUSY/6aMjxj00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpC7qTXFnqcRwUYe8ylvcoPAiwtAlGB9WsiI+8KZ2vU=;
 b=zv/Jzk2RFiWqeMtabJUDgi9o1VcsRsaxMPvPgi+4TC4eCd8pB2Xtjh5i7UChayVvheMyDZRdBv5D8f16LRrqr1PYKLrzT7eaayjyAeJ3HPFyeUrnplui64p/KYuFTUfSbgOlUEqESPNIDhYV4CUKFsdseg6a/G5sIfN1UZAIQWg=
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by CHBPR12MB492794.namprd12.prod.outlook.com (2603:10b6:610:36a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 20:34:25 +0000
Received: from BN3PEPF00022BCA.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::4f) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Sun,
 15 Nov 2026 20:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCA.mail.protection.outlook.com (10.167.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 20:34:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:34:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:34:24 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:34:19 -0600
Message-ID: <5c1785db-94d3-4c26-a2c1-ab395ff93275@amd.com>
Date: Mon, 16 Nov 2026 02:04:13 +0530
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
Subject: Re: [PATCH v2 03/12] KVM: SVM: Emulate guest accesses to LBRv2 MSRs
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-4-shivansh.dhiman@amd.com>
 <CALMp9eSS8W0CQF4pVJmo_fcKzA19pfK6et+i3cVDLNcA2M5Esw@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eSS8W0CQF4pVJmo_fcKzA19pfK6et+i3cVDLNcA2M5Esw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCA:EE_|CHBPR12MB492794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab5bb71-90d8-4a70-fce7-08df4357d677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VXinq9uA8TX+Of+/0ZuM85+DEd07BxTIwYLKL8g+sP/Ju1rFH3BZ3Pr9fqAx9T7OxuW2XX29rp6LEX3HOv+k+mX4Dm0548ZTDd8s+3yWh85AdTOZsWHoVka8ZpKXSvn6lOAiQIxrzYSUAsUIpA+F/ZMrqbruhB+LAnWgGL0QHaxgUC9D4fLFP1aufEcpuEIP6vKp+JHlINOklIhh5lWXA6nYWVi1RUkYNKYa5ZHfoyQ1NdvJG0FkYiIhfNC4pyjEAvS8QcJ6ByjMZQv7QwJWubj896QwAGf6U+OWXgnagYnsBTrnREB9MRbJmHGNZq0Dh8emxgunKHemtFFeSRVtN+gYEex+qzcp/jrJyn1WdtLLc3To4kji68bLfsXfWx2QPqNE6MRE3qP0gpGYp1jdAOYyOI218VtPRNnZpGWKMz+fBxoATajPESiFG2iplzNbQKk4L1DCEtTyM3M0qjxTaVDBJzqLpvK5mW1VXtZyPeBB7LvPwOlyf8wa7fuKGkvTEr58Z7LIls+w+qP5AUxqAqqf9MLQXfutjAU6B4VI0q5qVjRls5usurodvyFSFshtnsbUvGV75FEsHMProHQ8vlaMjshOg0hDa+Sb4r3m5Nbu73X+vDmG9l/qFXnL5G43qZdMFj3sWyk8tM9fFLIuxi79BDyILL9p5Muob1dB9IKnPgTKdSozIrmWvhIOukKfxsCJnESjEWM4G1CsAiPHHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(10063799003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IFk44gSxs2zhsB7oqwrzYS9VmoG2jEwTdZRYYPPIRP1U8ntE3ts+LE98W353J9LIW3OpOJWTBJWROPj5m44ZjrUMCBkMr0/isJvsdtqoUU8dY/CDArIDPFvio4BmMSJUXRM4hutDLp4pERMKHuuxWsArpzwueGuQJ6ij0IvKP3qXR04RKWY0TbYS5qn6HIWj67Q5HvjnDD5JDv5Xp/V65VCNByaGpxYp7phQFkfQiaJrlIv+1gdRGwkCCnrnYpMRivQV84uf+s18f/BPv0TjmAXtpax3+TwXkZf4/ilih7wxtS7MO6RcyWzG4IaIVBzn0l9OaWAYpME9vbKWLllnA9f9p5mF3VBy1ntBN507h+v3csYu34L85LhJ7Rw3bYzbIgUeIW3Rwg3hFy3wMj7tTV6ONe6JcUQMnvHyyP4zGpCKjKhZekqlVDMMMdnPqm/+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:34:24.8875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5bb71-90d8-4a70-fce7-08df4357d677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB492794



On 20-10-26 04:56, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:06 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Back the LBRv2 MSRs with their VMCB save-area fields in
>> svm_{get,set}_msr(). This is required when guest accesses to these
>> MSRs are intercepted. This allows the guest to retain the values
>> of these MSRs on VMRUN/#VMEXIT cycle when vLBR is disabled.
>>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>
>> Changes in v2:
>> * Use KVM_BUG_ON() in svm_vmcb_lbrv2() for an out-of-range LBR stack
>>   index, and then use entry 0.
>> * Do not mark the VMCB dirty on writes to the LBRv2 MSRs since VMCB clean
>>   bit for LBR doesn't cover the LBRv2 state.
>>
>> ---
>>  arch/x86/include/asm/svm.h |  2 ++
>>  arch/x86/kvm/svm/svm.c     | 69 ++++++++++++++++++++++++++++++++++++++
>>  arch/x86/kvm/svm/svm.h     |  3 ++
>>  3 files changed, 74 insertions(+)
>>
> 
> [ ... ]
> 
>> +static u64 *svm_vmcb_lbrv2(struct vcpu_svm *svm, u32 msr)
>> +{
>> +       u32 offset = msr - MSR_AMD_SAMP_BR_FROM;
>> +       u32 idx = offset >> 1;
>> +
>> +       if (KVM_BUG_ON(idx >= SVM_LBR_V2_STACK_SIZE, svm->vcpu.kvm))
>> +               idx = 0;
> 
> This guard isn't Spectre V1 safe. Use array_index_nospec().

Thanks, I will use array_index_nospec() in the next version. The
"case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31" range already
limits the index to 0-15, so I will also remove the KVM_BUG_ON().

> 
>> +
>> +       if (offset & 1)
>> +               return &svm->vmcb->save.lbr[idx].lbr_stack_to;
>> +       return &svm->vmcb->save.lbr[idx].lbr_stack_from;
>> +}
>> +
> 
> [ ... ]
> 
>>                 *svm_vmcb_lbr(svm, ecx) = data;
>>                 vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>>                 break;
>> +       /*
>> +        * No VMCB clean bit covers the LBRv2 state, i.e. the CPU never skips
>> +        * loading it on VMRUN, so there's no need to mark the VMCB dirty.
>> +        */
>> +       case MSR_AMD_DBG_EXTN_CFG:
>> +               if (!svm_lbrv2_supported(vcpu))
>> +                       return KVM_MSR_RET_UNSUPPORTED;
>> +
>> +               if (data & DBG_EXTN_CFG_RESERVED_BITS)
>> +                       return 1;
>> +
>> +               if (svm->vmcb->save.dbg_extn_cfg == data)
>> +                       break;
>> +
>> +               svm->vmcb->save.dbg_extn_cfg = data;
>> +               svm_update_lbrv(vcpu);
>> +               break;
>> +       case MSR_AMD64_LBR_SELECT:
>> +               if (!svm_lbrv2_supported(vcpu))
>> +                       return KVM_MSR_RET_UNSUPPORTED;
>> +
>> +               if (data & LBR_SELECT_RESERVED_BITS)
>> +                       return 1;
> 
> Hardware doesn't raise #GP. It masks the reserved bits off.

Good catch. This MSR is Read As Zero (RAZ), I'll mask its reserved
bits instead of returning.

> 
>> +
>> +               if (svm->vmcb->save.lbr_select == data)
>> +                       break;
>> +
>> +               svm->vmcb->save.lbr_select = data;
>> +               break;
>> +       case MSR_AMD_SAMP_BR_FROM ... MSR_AMD_SAMP_BR_FROM + 31:
> 
> What if the guest CPUID.0x80000022:EBX[9:4] declares fewer than 16 LBRs?

Please follow my reply to Patch 4.

> 
>> +               if (!svm_lbrv2_supported(vcpu))
>> +                       return KVM_MSR_RET_UNSUPPORTED;
>> +
>> +               *svm_vmcb_lbrv2(svm, ecx) = data;
> 
> Hardware does some funky things with high bits that should (a) be
> documented, and (b) be modeled here.
> 
> On a Genoa host, I found:
> 
> - For FROM MSRs, bits 62:58 always read back as sign-extension of bit
> 57, but bit 63 reads back as stored.
> - For TO MSRs, bits 60:58 always read back as sign-extension of bit
> 57, but bits 63:61 read back as stored.

Thanks for pointing this out. I'll try to address this behavior here.

