Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794774793;
	b=tPr/mHNXj4kEBXg4VnaiTx68L0edejWBKBKH0ywnDk1A4Rjkcp6tzpBJ/3CieixlHZLX
	 UDowB4bQ7UN6xQFEFZL2L/kzwu/Ip+iN5gu33BEtiWcP2FE8AUTvPRt3s0v53qdfhvPc0
	 dvuHJB8y6frs3jB/+wkZsZcFNNg4p21XzlmUU85VnpyJaQn6h47E2AgawtBQsR+f99ieA
	 RCjBsEUWKE5f/jbnEn0g0Dbe29BPSXfm5XycJzTTGWs5V3eUmJr8J7LeQwAN8O5Wpsoet
	 W1zXoJv5R6CouW628FwnIQIq7NuUAm4Zb9eSI3vPsriEwhgd8i4y/h37/Q8mNyenq/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774793;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=421rdtOPXpiuuJ0gwUJhfBxmz4SIDHYGBLrfPWm/DP4=;
	b=lUFOYKiYocVDr+FIB/JRS+6AFx3OvrR+25n53g6Tg2ZL0Pq5PUPp9d81tnCi8tbC2W52
	 cHIQnExAl/OLlCJGuHB5L0DiEiJRLZ4ohDujxGzDl6t6cEGHVrI03w0VqnZYnnLPQy7Ec
	 3CV+JqWwPBjzseuPWC/0WjT/VotIBNTi7zUKpHwoNxufb4Z5ptdVlQ7wkS4Lv9HBh6Vpk
	 ixBkZ4vRFwN5AFQ0907PbjkW+8Un5esVOd68AtgNYU6gDPRzODnjT/60rXSresSx226iu
	 yBFE+f2p5pf6nOin172nIqgWTk5rTJNxhlwdIvsreiiTK1x3mS48dPTg0DbTjIIDYow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ebbjwb9t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.36
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249B606A338
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 20:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4249B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ebbjwb9t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHWic7Qn5HENW6JyxtcHnbNEsLSUVhfD1bO7sC0coRoL22ZBYJNdc6w9PGMlgFUUL8jUQdFRhp5xHMgoXqpvCAMO3pAu/fOMBb88NMw0vZKS1kCG1UF9yEd521uV+Rzpo7Gd/VFlXdErG8l91xft3pcoC7OmoDTGiA52r3ATivTGkth99311AJkue+3uqLZi+EoxYfHlBhJmHmAvGIap2nK2Gr2isRMUovTOMVDGxS5H0nM0EzQJLJWNK4ebxMuMYGtrp+cZnkAtq1hN2uYhmLlKwEGvKiU8RcwebRS8z7sIwM7hUlFVtzroK4o8wJCyyH1BRfFA375eH/NBJjabRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=421rdtOPXpiuuJ0gwUJhfBxmz4SIDHYGBLrfPWm/DP4=;
 b=WmIo02y6wgV8GFD3o0n1ykHd0GaNNGMjfpO8EWiW97qyggvrFOrz/X/SqIMm3b9IN2V8mM5Ut9FyNOm5pe1PWT9GxNiRrGItF6GlLdlnqcIPYFrdZc8w+wa2sbgBeImVv3a8qS/CFbHgfPB9v6Q3ACOxC2jSePX8kOqx1psi1lqhmom5jFh2ops87e3Ve98fZrKEGZ3r2lr6lJWpLUkGZvHmiOji48X2xKAOGRnLZsj1SnrSJmCySYk04PHqVSHLbRjQ3YdLiqIBDfdvj3N+jpR8zN8z97COR+Hle5X0kgct7PyVDkWSC5zQyPuIFgizbueEaqYnVA7WPoAOcysa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=421rdtOPXpiuuJ0gwUJhfBxmz4SIDHYGBLrfPWm/DP4=;
 b=ebbjwb9tU3Gfjgx1wmISwP8+OE9QibUMdiwyEVnSr6FlxPIYhDyW7QFzyt3fq7b4Et77Xoz36cU9dvr4C3+hiaEq8j1e4Ytnh2cvhvxUPtFmHurlCn/7dOhyTEVKcAgyY1yftWhDNXE5+vdlR1doNPfAIM6HCVsZhDfJh+mghrY=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 15 Nov
 2026 20:33:05 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::7d) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 20:33:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 20:33:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 14:33:04 -0600
Received: from [192.168.29.217] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 14:32:59 -0600
Message-ID: <e09b97b3-7439-4b33-8c2b-033ba131a0a8@amd.com>
Date: Mon, 16 Nov 2026 02:02:58 +0530
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
Subject: Re: [PATCH v2 04/12] KVM: SVM: Enable hardware-assisted LBRv2
 virtualization
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <peterz@infradead.org>, <acme@kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <yosry@kernel.org>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, Shivansh Dhiman
	<shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-5-shivansh.dhiman@amd.com>
 <CALMp9eS+vfR=Gk5QhLFrCZ4MyCq1YrunViB=tB5OLo+L8Ka+OA@mail.gmail.com>
Content-Language: en-US
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
In-Reply-To: <CALMp9eS+vfR=Gk5QhLFrCZ4MyCq1YrunViB=tB5OLo+L8Ka+OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bcac1e-21d0-4444-2583-08df4357a6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|23010399003|13003099007|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261021123027099003|261026140227099003|261009223027099003|261021135927099003|261026121527099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	cxdGIY/Ko7e9eqbQE3UibKlFihi9iE2lZUDlXHusgw4frua2iAXpozTCdz179bv6GJ0mXA3dgRedkRV8Qh356MORlAqDoO7vf6xG9OT3GSqsV32w5kqZTfePUqD/I/fs2P7EP1UMfYJdwlm/erGfpOJgcwFbXING+JK+CP7/M5XEagkB/pTNfPo6CoxihTjkA8krGlTxuY63WDU4q6RYAQ9KsTWKNSKIzu+JAw/xy0kIKymPl8AcGQy4P3atQc5hnc3q8QmVx2sGBqPGhnvVlTrQk0MjHe6+VO78PC7P426RftghxjKm/enXY6x5MBt8awof4o6DnuzQqBtW374njHOxb+KCypEhIuB30U0xkUNxXw0grXYktYwnrVAtkxBPWMJ9S54314YFNAK58kp1L2uc/6ouyoRQftjDR6Cgy1VTIuCl70WJBnOggwiAp1f4DGyfDxYt2nqnyJS/P14JGf6nXSdekCu0grMQJ/an4GBcpxzSVlXGgQNIIHb4C6x/oD8/e0LoIhXFsiSiEkNr5apEETsXPsXWJ4FBfAneVTehMtCYc7AcFMVVDEtktXxsnCpGpvtdupu9krpf1mnxXCu5Oxamnju2xWbjdaCd0dmHvT9Pf0b4WyTpH+FifP3/YAFTcLSnLr3mQqUc7DNQBqOypHUXGvbqVWUP9cF1mN0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(13003099007)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261026140227099003)(261009223027099003)(261021135927099003)(261026121527099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zCZd0c4+V4yjQu9qeY8lXodPEBWfVU+FBeqi8EFWwF39541YzE/ZpF1XyWbZ79hhvNJYfaHVe5LsNzaX9YKKELExVuKiR0yAenuV2qIEvr/0GB4Rs1AWx9HIpCRKY9dXtHvoVHkqouEbygx1qH2jJNqZ2bYoZkjaSS3dmpcRGIoiQ/MZrKegYTMJXPl+k+pZuAFODp53hjeUOFPLDZxyT+aJKDn7D0Xg1gIX/MfvOeuFAaKtsvIHYPuZ5Zgp4x46NL7yob1IXcCY0wZLYiQijycXaQ8T47nYJObfxyvg4JYt1ytvd+S70wWdkAQtakLXChhUBm5E7EyWRjVOCLNxLYVA41VvJJRlQ3/7Y6tkWntWLaTIFiYlei8OctwHgGkoBKtyzLq7db2U+AhalhBCZ56IP4sBaPZxnncGvtKpApL48pMn3GX/PIJXHfl63EKR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 20:33:04.8720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bcac1e-21d0-4444-2583-08df4357a6cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895



On 22-10-26 05:04, Jim Mattson wrote:
> On Mon, Oct 19, 2026 at 2:07 PM Shivansh Dhiman <shivansh.dhiman@amd.com> wrote:
>>
>> Enable V_LBR so hardware saves and restores the guest's LBRv2 state in
>> the VMCB, and pass the LBRv2 MSRs through (by disabling interception)
>> to the guest while it is set. V_LBR is enabled lazily, only once the
>> guest turns on branch recording, just like legacy LBR keys off DEBUGCTL.
> 
> For a Linux guest, I think lazy V_LBR toggling is a bad idea for guest
> context-switch when LBR is in use:
> 
> Context-switch calls perf_pmu_disable() -> amd_pmu_lbr_reset() ->
> perf_pmu_enable().
> 
> The PMU disable clears LBRV2EN, so V_LBR is cleared. As a result, KVM
> intercepts all of the LBR MSRs written in amd_pmu_lbr_reset(): 32
> stack writes plus LBR_SELECT.

Thanks for this. You are right, and I've been spending time experimenting
with it.

I profiled the guest context switch and counted the intercepted MSRs on
the host. With lazy V_LBR, each switch into an LBR user causes a VM-Exit
for all 32 stack writes and for LBR_SELECT. The reset then becomes the
largest part of the guest context switch.

When I kept V_LBR on, these VM-Exits disappeared, and the reset took
about the same time as on bare metal. The same workloads ran several
times faster. For a guest that has LbrExtV2 but does not use it, V_LBR
on adds a fixed cost to each VM-Exit, because the CPU saves and loads
the LBR stack.

I can see two ways forward:

  A) Turn V_LBR on at KVM_SET_CPUID whenever LbrExtV2 is exposed, and
     keep it on. This is the simplest. But a guest that never uses
     LBRv2 pays the cost on each VM-Exit.

  B) Turn V_LBR on when the guest first sets LBRV2EN, and keep it on
     until vCPU RESET. A guest that never uses LBRv2 pays nothing, and
     a guest that uses LBRv2 has no VM-Exits in the reset.

Personally, I think that B is better because I do not wish to increase
the current overhead of a VM-Exit. Which one do you think is better?
Or do you see a better option?

I also have two questions about this:

1. Legacy LBR. V_LBR also covers DEBUGCTL and the legacy LBR MSRs, and
   KVM toggles V_LBR lazily on DEBUGCTL.LBR. Must legacy LBR keep the
   lazy rule, or must it use the same rule as LBRv2?

2. DBG_EXTN_CFG. For non-SEV-ES guests, KVM intercepts it only to see
   LBRV2EN. With option A or B, KVM does not need to see it after
   V_LBR is on. With the reset fixed, the DBG_EXTN_CFG and DEBUGCTL
   VM-Exits are most of the remaining cost of the guest PMU disable and
   enable. Is it acceptable to pass DBG_EXTN_CFG through while V_LBR is
   on, as KVM already does for SEV-ES guests?

> 
>> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
>> ---
>>
>> Changes in v2:
>> * Check svm_lbrv2_active() in svm_need_lbr_virtualization(), which is
>>   a newly added function.
>>
>> ---
>>  arch/x86/kvm/svm/svm.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>>  arch/x86/kvm/svm/svm.h |  1 +
>>  2 files changed, 45 insertions(+), 1 deletion(-)
>>
> 
> [ ... ]
> 
>> +static void svm_recalc_lbrv2_msr_intercepts(struct kvm_vcpu *vcpu)
>> +{
>> +       struct vcpu_svm *svm = to_svm(vcpu);
>> +       bool intercept = !svm_lbrv2_active(vcpu);
>> +       int i;
>> +
>> +       if (intercept == svm->lbrv2_msrs_intercepted)
>> +               return;
> 
> This replicates the bug I just fixed in
> https://lore.kernel.org/all/20261020234535.3182385-2-jmattson@google.com/.

Sure, I'll omit this check in next version.

> 
>> +       for (i = 0; i < 32; i++)
> 
> Nit: 2 * SVM_LBR_V2_STACK_SIZE.

Will do.

> 
> As I asked on patch 3, what if the guest CPUID.0x80000022:EBX[9:4]
> declares fewer than 16 LBRs?

Thanks, this is a good point. In this version, the guest can access all
16 LBR entries, even if its CPUID declares fewer. When V_LBR is set, KVM
passes all 16 entries through.

v1 handled this in a different way. KVM cleared LbrExtV2 for the vCPU
when the depth was not 16. But the guest CPUID still showed LbrExtV2,
for example because the VMM set it. Thus, the guest used the LBR MSRs
and got #GP. KVM and the guest then had different views of the vCPU,
so I removed that check in v2.

I do not think that the current behavior is a security problem, because
the extra entries contain only the guest's own branches. Also, a guest
that follows its CPUID uses only the entries that CPUID declares.

But it does not match the hardware, where an access to an entry that
does not exist causes #GP. If you want KVM to do the same, I can read
the depth from the guest CPUID, always intercept the extra entries, and
return #GP for them. A guest that follows its CPUID never accesses these
entries, so this adds no VM-Exits. Do you think that this is the right
approach?

> 
>> +               svm_set_intercept_for_msr(vcpu, MSR_AMD_SAMP_BR_FROM + i, MSR_TYPE_RW, intercept);
>> +
>> +       svm_set_intercept_for_msr(vcpu, MSR_AMD64_LBR_SELECT, MSR_TYPE_RW, intercept);
>> +
>> +       /*
>> +        * DBG_EXTN_CFG stays permanently intercepted for non-SEV-ES guests so
>> +        * KVM can observe LBRV2EN and lazily toggle V_LBR.  SEV-ES+ guests must
>> +        * delegate LBR virtualization to the processor (per the APM), where
>> +        * intercepting LBR MSRs can be fatal, so toggle it with the rest.  See
>> +        * commit b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization to the
>> +        * processor").
> 
> Is intercepting LBR MSRs fatal, or is clearing LBRV fatal?

You are right, clearing LBRV is the fatal part. Per b7e4be0a224f, VMRUN
fails for an SEV-ES guest with LBRV cleared. I will fix the comment.


