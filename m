Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009161;
	b=WrKmWpZBuqbdnnYUHR+EHhCIHS+LG1K41965F5zBIEYfyCQK3QkvHP6C1ua/pcOwbQ5c
	 Qjy2WU0Z91DCB13hFn6ieu4WZOHtpzlwU/Y3xV1TQCHM5Mo2YpFPDuOqicVNaIg/MkUkl
	 4Gs8T2M2AusjwMCPm2fewfUVnsiaLPnzSMbGyr62mUnkHuSHAae8R9PIB+eFWy4xyatsa
	 B4/M3UmAQh7BM+B0RH/bC2W9bug95jxOhp/exZYlTQGguwu0p9vPl0/9IBznboO0WOvFd
	 of3PNchB4wHKnQqBimis6tjfKL9cqrQ6JyYalX6sSyxUQKxq8ZR9h/Yr3NmW87qM6Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009161;
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
	bh=4Z3NiHdCcNf8i1iwKx/nEKnJ8ZxW2RGAgoEA9V5WqSs=;
	b=3FTWytSKjlYBmQRbIK6catF7mR0msOxYImxbkl2HFj0IjLC8OIumBy99QzXfKuBVDBC0
	 bQGRJJzNLD3UDmcbcQniun88zaqaoQEAa/5tK8S5tTn6BlVYIecthdS24mbmUzOXHDhlG
	 l78Lf5A6bGBdR87GTBd2QKc1CTSFsziBdGn0JJPFYukZi9BrmCLY0wQlwwOvxUbWzQlQp
	 dUhB9tR9Ga2S4rw+G6GtExgHuSRb7Y7CfxfXOd/dUgO5OhNgW1a/E81mE4EPKrYMNvNRw
	 MYDRg6FHKiIlM8HtBDMd2+4gwhuh5X2DuG2gZLTstKAss3o0miPu6ViXu+XuwqDuobA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PdNy4APj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83309606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 13:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83309606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PdNy4APj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X733XEhrokeRd2WyRBEWKNRhn89OVB4SMH3/XWgZalqvO1LctBaYzrRzM2wTKg6W2dj1xYkDo4jIwRcJBTHI/2LT9Induihnff2H6Yt2WrOLz/v907AT6dgtgu+yvPt0sMTIiXtZbMyJnxRMpKxVxGrCv3eX+l0oTygl1WIbWodtUyp60jjWJL2DvgcxJyULtL+SkTQnFHxfugfrLdA9ZERErV5fVJYBpnNmfPblKV8ljmMFyoi0deC86XVYYHZdc75KCxg3ftq0GFCuh5rltO2GAO4Q6gOW0MNyzq/a7OEuOm/95Vw4YgKvAQsW3A7HAVaCglEupUrROmCQDL1OIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z3NiHdCcNf8i1iwKx/nEKnJ8ZxW2RGAgoEA9V5WqSs=;
 b=qaB+/Ru2FbXPOI6Kh3BjuA/WcyXBiHaYdukNL6yML1RrHvHaF9/szmDpfKprmwrfLbRF8k5KJ+OcjJhYlzl5JmHM0GvUHE9epYazfHoyPsFzkd3aNarj0cYq5BiaWmUmXAzP4jDdEFTBb7tQCRu7/y1gqJHvldF1ulDvAOLhEvovAOcQ5H2CxMPlt5wKbjvl7j3KsKStY3BDjIOTaFtTJ5eCibQD/wDpDHBu8yXokGp59T03hLPlkieEaMHb0+3lanw2dNKO9L02iijZNnzZzM1sALo2vflNRxRYOJoDhdMOVSHtczcRsSq8rSvJAoW6IZZ1MDbRGCcJRTdc9wVM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z3NiHdCcNf8i1iwKx/nEKnJ8ZxW2RGAgoEA9V5WqSs=;
 b=PdNy4APjAFn9A6/89YPpmH5tg3rVl2wHmVjpui1bjT9yRREAbsI/DrZ1SozaWUDTH1dhHa6yp6gbb8ILeieu8UO1Ks+mHPCOdAGZIr/ZYhWYbRpU/ANqv0Mo3DsZywvmYTyzIyNO6AF/kIfaNKKIs4ONj4TIM6AkO72TH3loc88=
Received: from PH8PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:2d0::20)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:39:13 +0000
Received: from PH4PEPF0000B60F.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::81) by PH8PR02CA0017.outlook.office365.com
 (2603:10b6:510:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 13:39:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH4PEPF0000B60F.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 18 Nov 2026 13:39:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 07:39:13 -0600
Received: from [192.168.1.98] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 07:39:08 -0600
Message-ID: <ac0cf3d7-7547-40e1-b3cd-10dfd8ee2b78@amd.com>
Date: Wed, 18 Nov 2026 19:09:07 +0530
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
Subject: Re: [PATCH v3 7/9] perf/x86/amd: Enable VPMU passthrough capability
 for IBS PMU
To: Jim Mattson <jmattson@google.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>, <Naveen.Rao@amd.com>,
	<dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, Yosry Ahmed <yosry@kernel.org>,
	<manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
 <20260310060022.15120-8-manali.shukla@amd.com>
 <20261008193208.832031-1-jmattson@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20261008193208.832031-1-jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60F:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: aa48ece2-9258-4e7a-f6bb-08df4579555c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|261022105027099003|261021121427099003|261102123227099003|4143699003|11063799006|56012099006|10067099003|261026140227099003|261022075727099003|261028144727099003|261026121527099003|261009223027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i8+fM0kjksOivyWFY0zuIMykNV1PK2zIgp6fX8k8FKNZPgtRU7qXklGUk3m+JGnA+ebuR74CV63T+bnYAkN4Mh/vciQ0HWMtHbB08ZFLvgr5pQkxXZeYp9nZDBEvvWAnQnLbnCe2vrM7ylUbY7c1xLq1NwPavhcAr5Cm/kWrBHbM/hTHVmG0GvEJ1y6sG8uZbBmaGK0db/aEl9csmnW1Kn1rC9BMTnqlOLkNup1Kg+cbGFQ6z3LT2+J0pQGIrGriZsUUS59qObv2oWWwpPn0nI1h065zzwmjSj+JuQBWh+XeNhd2bLOq1aesrswtzHTG2Cu5RI6VYpPzn1LwzOCQpe7JL3Qa1+WL9CK9DhgZBJdHCu9rMQ+x8GmsuUx74srZDFaRdtRifDZZeD0FAIcxA1QwZUqYeqk/u2k79D4scwJNs9wkCPIJ9GkIE4P2tegYVY3JmK1mYNf9iNf+La9Yp9IrBD2wXerNh/Bk+QCOZ/Sx6bvAGZlaY2HIojcyx4OHk6SmMcWRaLHeqzOawq718FRVXmN8Kjuyjg11I6ZJAto25ShBpUdWtg/nrIqOnDd+TRaJGf9BWO4uzVR2A9RdWK5Yrr5wgCCD1/fI4bi1hX1ueGMfoiQlaxscwox3JEBX5/roldeavvWeK7Y588L4ZeM/lMw+xOieKXTRwM7xrPJI/wnJQmphaMv63JP/xwbBdhDg96ag6tfSVFYvcy5YQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(261022105027099003)(261021121427099003)(261102123227099003)(4143699003)(11063799006)(56012099006)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261026121527099003)(261009223027099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cS1Fu1iSpIdmfgBxJ9PJIZK+XTpyOeHDFnEmJXrOXRg0iJsY7xS+8x5AqpqjUF8QFvD32zxNCLp0gCZcWwD4XGlLBI//rgs75xeLnp+RPGgOa9rhggm9M6Y1OIAN45aOVEQjdM63qnrAE6t3uZ1Jn7eYPY6JIWjHpPpjzIKyqMnWl5kljeED0JV0m9nDPCIjpClkUeYYguJVfVxtsRRzKyCcGN5X7fGp3CAWMC19Q5bhJIMHe4Fd6ilwE6/jeO/vea1rAB++KlN3OVcO8MlgxrWLnbxOyuAai0RlOYR6T30o5Bi1k6GJwUkiQ4ZGYQGW7xjQZ3G2XyyhyTXBBx2MtQjTIzq1at6D/V0b+G1R7wHK5jokS1BNB3SaWqDI3YEsoIoYumD8VFz2e4Osc1N7U+2X1N2ac+hO9ggdmYXxht5Q7aON89bA0iLiVVqpi9/p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:39:13.4470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa48ece2-9258-4e7a-f6bb-08df4579555c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

On 10/9/2026 1:02 AM, Jim Mattson wrote:
> On Tue, Mar 10, 2026 at 06:00:19AM +0000, Manali Shukla wrote:
>> IBS MSRs are classified as Swap Type C, which requires the hypervisor
>> to save and restore its own IBS state before VMENTRY and after VMEXIT.
>>
>> To support this, set the ibs_op and ibs_fetch PMUs with the
>> PERF_PMU_CAP_MEDIATED_VPMU capability. This ensures that these PMUs are
>> exclusively owned by the guest while it is running, allowing the
>> hypervisor to manage IBS state transitions correctly.
>>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index 6d230e417b61..e075c5ed136c 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -978,6 +978,7 @@ static struct perf_ibs perf_ibs_fetch = {
>>  		.stop		= perf_ibs_stop,
>>  		.read		= perf_ibs_read,
>>  		.check_period	= perf_ibs_check_period,
>> +		.capabilities	= PERF_PMU_CAP_MEDIATED_VPMU,
> 
> At this point in the series, perf_ibs_init() still rejects events with
> exclude_guest set, so every IBS event is an "include guest" event, as
> defined by is_include_guest_event(). With this capability:
> 
> - If any IBS event exists, perf_create_mediated_pmu() returns -EBUSY, so
>   KVM cannot create a vCPU in a VM with a mediated PMU.
> 
> - If any VM with a mediated PMU exists, mediated_pmu_account_event()
>   returns -EOPNOTSUPP, so no IBS event can be created.
> 
> Patch 8/9 removes the exclude_guest check. Please squash patches 7/9 and
> 8/9 together, so that the series does not have this regression at any
> commit.
> 

Agreed. I will squash them.

> Do we really want to set this capability when the CPU does not support IBS
> virtualization (or when kvm_amd.vibs=0)? In that case, the guest cannot use
> IBS, but host IBS events that do not set exclude_guest still block mediated
> PMU VMs, and vice versa.
> 

I agree that we should enable PERF_PMU_CAP_MEDIATED_VPMU capability only
when boot CPU has VIBS support. Something like this in perf_ibs_pmu_init():

        if (boot_cpu_has(X86_FEATURE_VIBS))
               perf_ibs->pmu.capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;


Without the capability, exclude_guest IBS events will be handled by the
software switch I have proposed in my reply to patch 8/9.

Doing the same for kvm_amd.vibs=0 is difficult. The capability is fixed
when the IBS PMU registers, which happens before kvm_amd loads. It is
checked when the event is created and again when the event is freed. If
it changes in between, nr_include_guest_events can go wrong, and a
mediated PMU VM can start while an include-guest event is running, or
it might never start at all.


> When the guest context is loaded, perf_load_guest_context() schedules
> out the exclude_guest IBS events through perf_ibs_stop(). On hardware
> with IBS_CAPS_DIS, perf_ibs_stop() does not clear IbsFetchEn or IbsOpEn.
> See my comment on patch 6/9.
> 

I have already answered this in patch 6/9.

>>  	},
>>  	.msr			= MSR_AMD64_IBSFETCHCTL,
>>  	.msr2			= MSR_AMD64_IBSFETCHCTL2,

