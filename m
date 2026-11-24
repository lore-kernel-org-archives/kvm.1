Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795499781;
	b=mMZDaHr4PWCetr/CFH1ffdVwY8Z/LuD0P8q0HWsGef/TyMqETJf7zF5UncKY36nqipXU
	 +wtWg5Pq03Mh9TvvN1L0co8djUucEQvqTwaC9109fXzw/lnICHMox8lTYHFXrcHsGUcvA
	 kGtsx57ZvbPgAk5ygibgxGQ2UALLLDeVHrn+gU/jNkJUAOzFEmdP2MS3UxcxroG2gm1TC
	 Ks/lISEn7NhKxf9qqfkSK4ad1fiKPGHNPLKjclAH53QJSFojzQRkquggCnZEnHm+Aj4Va
	 noW8Fao7QAjuMYLSZKhn5SL3+xYsadDhby3PnONF/aRJOWwzKvN7S7XyYOuBVMdLX3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499781;
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
	bh=IFYayFcdNCpI7rLG50SnaMrkHSoxyBC9i8m2gvMVrvA=;
	b=xrAYmHTButYKwgVnaCDCb2eh+ayiNy7t5h8hrr7Rl5a82ssc9Khbr89s8vfudNWQYldf
	 HiLBUyqHeuB1zLGeoODPbhLRbPRQidfMI9eUZlr4r+KH2JJEUsDNE/1j4NPqvSnkw+BbQ
	 Y+1mG0VRLHRq3FJ4XiGZbn93+6APz9tr5i3tjg3rfOYQEQrCtPECJZz0atZrB8KSO+ORE
	 lNNTDX7tgcEZRGO/aucM7taFiEYFfe1B6ptypmPkSvohDzVmHQRGd6aOQPLDz+NV63ajQ
	 jT0YCb8ZDXi/6WTgBEWdmUMLA0BgO6qAiuFlvuJUvRkW3H3L8wxlfjy4+zjhLsKgC9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F4nk6aHp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.18
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF8606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FAF8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F4nk6aHp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOqDimubsi4L12JIIGkAB4srHEgc+EpWd2eyiKLXMMMJ3kaI90b/23lohz4mJmh+2btasbfyJ3L1dBFY3YgmG1GfwU+IDKY6Czq2dw5A980n75JyXxZUdxJdWRDU47hhpLa2/b8jbm+sbpEPpVSlzTOLX0L6VSmnEMNW1ePM0zs/C0op8WHpCIlxwZbh3JA/68qCv6oXWfgvabqf9ZWG628mz95PWc3KDXkfj5sAbqKHhaDdtisXbnHBaPErX4amVQ+9LvOCPAU5DhZZdZ+VHH6WwGoCMUGkUOdTLciwBvUxvisgaRePa6FTyt5YLbZYw/Qu6zXUO345EGDEQp+j7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFYayFcdNCpI7rLG50SnaMrkHSoxyBC9i8m2gvMVrvA=;
 b=Zdxo7u0YYTczraGszv4K5OG3kKnCWyuTalZq7GgcUoyxQypLkykm7eeY1dtqX0sQWvXr4m2E5Xf7IIntG9Q+jwKt0JeV6ixBLFPCf2e2I9T9wREmoeom4jokO9JrgwnLxNdR6jG5ijXfBSJeA34NFlJMMDQiqSAjojTVaEywmdczv1SvRx6efQjEVhTJJpDptw6qRH8oIDDB2f2avH/4fcp1fR7g65rVVDJP8W0yeCP+L5IHc17bmdk5kUOFEjszHGH0tATvd/8wMg3wmtVXPPy9Dk++3Mpniw/pu7bqo178oKTgmsI5+RNYJP9eAtP3ntyBn1ajCEscASIRWf0Ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFYayFcdNCpI7rLG50SnaMrkHSoxyBC9i8m2gvMVrvA=;
 b=F4nk6aHpVUI9AdL6J2JVc9MuHFClsi0ElS9KoXXjtKT1XrmOq8RoWTTh0SWu06TTRsmwzmbAtA5ktMruEIURvMgC2QjOLUL7NG7p3ajyUqmK/DCW7w83SK6/ELP2gMEauwkv0fZIZBr1TUYwjXrgnCpo9PcV2FjLFahNp06RYRc=
Received: from DM6PR04CA0002.namprd04.prod.outlook.com (2603:10b6:5:334::7) by
 SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 05:56:17 +0000
Received: from CY5PEPF00000E77.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::7a) by DM6PR04CA0002.outlook.office365.com
 (2603:10b6:5:334::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 05:56:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E77.mail.protection.outlook.com (10.167.247.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 05:56:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 23:56:16 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 23:56:16 -0600
Received: from [10.136.37.204] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 23:56:14 -0600
Message-ID: <5e3d4551-b494-488a-a360-ace5cc9c076c@amd.com>
Date: Tue, 24 Nov 2026 11:26:08 +0530
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
Subject: Re: [PATCH 3/8] KVM: x86/pmu: Add support for hardware-switched PMU
To: <sashiko-reviews@lists.linux.dev>, Sandipan Das <sandipan.das@amd.com>
CC: <kvm@vger.kernel.org>, <manali.shukla@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <67cd3b3b8f031338d76094673d738d72caa10c31.1786345201.git.sandipan.das@amd.com>
 <20260810103623.B09F51F000E9@smtp.kernel.org>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20260810103623.B09F51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E77:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d9711a-991f-4354-bd95-08df49efa7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261009223027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	97jhLo7oeTiaKKRwnjTwceDLVrsXfra7aFZA5kNHiiHH+ZDdfVWKFx9moNlXtZMBd6M1PYdsWYW5SYRVr9UtzMRPfEqCKAiqhsH1oSiKk8a8EQ54NRwUdf1qljnLjzpDwbuir9EqJ68MAsAWyXCtW0Omer76BT3cXskM7j4fVAEh/HQZiAE0UJS3vXMEfeOPXb1/QO+04AinXBbhspnaHz6DKpooAkKJPS3i6VUn6l+Ad+5g6+gkgnM1rh6+YFuvxuhlkpHd4R31HWwIyq/qGQTj8iYmp0KHkdHMSOSf7dFQsk7I86rKJIqEVhBRZihAsjgjux7SyhUfOwaeyN82nSYlAc7Zpn7EfHoTJ0S0yO1WKyVueDOJwcCF2EP/pfvJTfZOuYgnwoxE4DRMi+rBeNMYMmp0neVCDWT0OgOb7h6lRP6moPxdn9+DwyymEzQKrK9t+rRfzMEPgP5eOQ5aF1a7nfIpceAjXvToRkJiFncmov4coHNOUVtdZRFZ7oe/kMqeyXFwLroWnaGip4QS7XY5Dobv3WlospwMA/VTTqkIktf4yYmXMfGwTPNBhp0N2tzuHA/BMgBQoXDiaLFmIJ+mVPhMHPbnlruwSPC+Qjf+9doQSI3KgcGYVuuN20LhwWBRWrsgzZrqu2mq1FOaJImQ9qieUnQqJ284KaH7EZ7hDo5UI209CHyyu66fwpHq4oP/jH4Xbh8eD9uIRr1v6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261009223027099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yOdaEkjj1GzLXdw0IcrNPqCGMhDDADDCVlOtcWNRwiH6e/dF7xkJbnBEQqInvqQjAYK8YZRub1v7p2SziggKZMD3n5+Of7xT1X9YuyFG4E3BOxOprDsi8mfzkPBYD35bz9mQdinfnuTAVjA7dcg3ZUCB2tarOVlzjSG9SZrIRsf/WCnvVl1XLzxJxlJPoyquVGSWMDvlDkhGsK2e/jzBIZSfgn9SqNEerOupe7OCWK7yzVG8X7cId1q2/ZN2Iryv+neN+jeag0Dq/PQOW+n0c73PQAE0A6Lo8zGtr2sAHQdFfYkKN8LFDJYMHLleQD3cZqKnmiiGaYQSGY99xWZbSwh2sflrILo1cIl2Ec39j4nkBxT+M+amndYv8tYQr1TGtSsf1Ca+wM/rTOMh4z79hnYkvl/yIlA/F39nxvdkDCPwP6zbny6dEcr5DFPs9kxM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 05:56:16.7674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d9711a-991f-4354-bd95-08df49efa7a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

On 8/10/2026 4:06 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Hardware-switched PMU state (PMCs, event selectors) is not synchronized with the vendor save area during MSR access, VM reset, and event emulation, causing data loss across live migration and incorrect event filtering.
> --
> 
> --- Patch [3]: [PATCH 3/8] KVM: x86/pmu: Add support for hardware-switched PMU ---
> commit 388311da6f37e672745e8b6b16a96e9812fb8ddd
> Author: Sandipan Das <sandipan.das@amd.com>
> 
> KVM: x86/pmu: Add support for hardware-switched PMU
> 
> This patch introduces the hardware-switched mode for the mediated PMU.
> It transitions the guest PMU state to reside in a vendor save area
> instead of the software kvm_pmu struct. The load and put functionality
> is simplified to schedule host events in and out.
> 
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -844,10 +890,12 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	switch (msr) {
>>  	case MSR_CORE_PERF_GLOBAL_STATUS:
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
>> +		kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_STATUS);
>>  		msr_info->data = pmu->global_status;
>>  		break;
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
>>  	case MSR_CORE_PERF_GLOBAL_CTRL:
>> +		kvm_pmu_get_vendor_state(vcpu, kvm_pmu_ops.PERF_GLOBAL_CTRL);
>>  		msr_info->data = pmu->global_ctrl;
>>  		break;
> 
> [Severity: High]
> Does this miss synchronizing the PMCs and Event Selectors in the default
> switch cases for kvm_pmu_get_msr() and kvm_pmu_set_msr()?
> 
> When userspace reads or writes the guest PMU state via KVM_GET_MSRS and
> KVM_SET_MSRS, the default block falls through to vendor code:
> 
> 	default:
> 		return kvm_pmu_call(get_msr)(vcpu, msr_info);
> 
> Without calling kvm_pmu_get_vendor_state() or kvm_pmu_set_vendor_state() for
> these MSRs, KVM might return stale software values or fail to commit restored
> values to the hardware save area. Since kvm_mediated_pmu_load() skips loading
> software state into hardware for the hardware-switched mode, could this cause
> data loss across live migration?
> 

This is already handled in patch 6. Counters are synced with VMCB in
amd_pmu_{get,set}_msr(). Event selects are always intercepted, so
pmc->eventsel is up to date, and kvm_pmu_set_vendor_state() pushes them
to VMCB from reprogram_counter() before next VMRUN.

> [ ... ]
> 
>> @@ -1140,11 +1202,17 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
>>  
>>  	idx = srcu_read_lock(&vcpu->kvm->srcu);
>>  	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
>> +		kvm_pmu_get_vendor_state(vcpu, pmc_counter_msr(pmc));
>> +
>>  		if (!pmc_is_event_allowed(pmc) || !cpl_is_matched(pmc))
>>  			continue;
>>  
>>  		kvm_pmu_incr_counter(pmc);
>> +		kvm_pmu_set_vendor_state(vcpu, pmc_counter_msr(pmc));
>>  	}
> 
> [Severity: High]
> Are we evaluating the event filter with stale event selector state here?
> 
> While we fetch the latest counter values via kvm_pmu_get_vendor_state(),
> pmc_is_event_allowed() and cpl_is_matched() still rely on pmc->eventsel
> and pmu->fixed_ctr_ctrl. Without syncing the event selector or fixed counter
> control from the vendor save area, might these checks use outdated software
> state?
> 


Not an issue. EVENTSELs are always intercepted for hardware-switched
mode too, so they are always up to date.

> Additionally, how does KVM handle VM resets and instruction emulation tracking
> with hardware-switched PMUs?
> 
> For resets, kvm_pmu_reset() zeroes out the PMCs and event selectors in the
> software structures:
> 
> 	pmc_stop_counter(pmc);
> 	pmc->counter = 0;
> 	pmc->emulated_counter = 0;
> 
> 	if (pmc_is_gp(pmc)) {
> 		pmc->eventsel = 0;
> 		pmc->eventsel_hw = 0;
> 
> It doesn't seem to push this reset state down to the vendor save area.
> 
Already handled in patch 6.
amd_pmu_reset() which resets value in VMCB area is added in patch 6.

> For emulation, MSR writes bypass KVM interception in the hardware-switched
> mode. Since KVM_REQ_PMU is never triggered, it appears that
> kvm_pmu_recalc_pmc_emulation() won't run, leaving pmc_counting_instructions
> and pmc_counting_branches empty. Could this cause KVM to silently fail to
> increment counters during instruction and branch emulation?
> 

Not an issue.
EVENTSEL writes are intercepted in hardware-switched mode too. So on an
EVENTSEL write, kvm_pmu_request_counter_reprogram() calls
kvm_pmu_recalc_pmc_emulation() directly and also raises KVM_REQ_PMU, so
the emulation bitmaps are kept up to date. KVM_REQ_PMU then calls
reprogram_counter(), and pushes filtered eventsel value into VMCB.

-Manali
