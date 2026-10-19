Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3203A6F00
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391755; cv=fail; b=kL202lo8J+gs9bVsyuWfZA7bkGd/JCdva6NzurAE3sQEUX4Eh1fmmIO7d20ZYEkxUpt9TC5nCkKKHaZhVBTNcQo0JDjgo2G3Z7pdOwq4bIA140SGE1S2K02paN7iZjBq7DHnrrY++8CNz14Vgkfhtm5bC1dUcsetKZtlFCPYg/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391755; c=relaxed/simple;
	bh=RcO4OF0dHYrXJHzRen2AQm3Puz3isEMXW1dEsnQ4k7A=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=twoE4ex7veLQIsP7uJ0B09KMx7ZMHHIcTvnFF/xrk8Uzwxj9G3WA6WstiEj29fKKgJgRH/FzX7qCVS4Z4O30Vj7K0x4dXg8sQTtKB8c5CGIWQEcDjv47TQgju2ouRONw4O8jeEeJokIMB65SXDAVQXONzoCG5FF69lVTLyRU2BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DrniWPWT; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DrniWPWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2JnfKloP9n6h+kUIml+FTISPxIM+wuys4OCKhjG6OuZgHBxLS0HVkgcSjCpZxtJuvxenuPtbdXD3kqBcCd4RYzNfff6+4yuSQ7ol1KTrJuV/mK815uVeWzg/Y2HiZCCh9sY3poGZ3mXqMqXueih8zXaPcJtCNk/MKcu26v++GI6VtUHWk7LiFaryyOY3aZv4GEIr7GMmJJ6PLSsDAnzFgkoZUqszQkHFNTGRMp97lsVDMY3GTeAifj1pJvKyPxnudMJhL4pGwMu6VoCVNLicqCgdmKO2AxLTLOEcOp7ZXMh1col2ow0+CCAiIsRH3og97l38pFfcuXIjpL7aUtzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeMJ5phxwaUdi4kjVNnfJSr41jwT5kxTIEOJHF2VFVc=;
 b=oD1cd81yPfJbkLweiFuWFln8kTmHsVc832ZsAVW8yAr03YPoEiEMKeLL42/rq4faHlwaei44zaS0g1iRl+030HJMJ9KJXOp4d1TXiwrFMLbx4qM625E6KUpLC2tagdhRvywrk1DtZjjRYG72JKDvKXcPI6Q0dLT4bR8NyR0L5OhGNkbWeVdd1hGATXp3Kolk5FgEZ6+zWZ3ynAkj4M11HbwMsYrg1hmwzHTY84iaSpkBQjv4fW/6FFYs63pFNovPvYDrNMoknPwKgloTh6Aypyf+oh+Q/0IGZKEqhoxwGDENAbsM8A/2JgfjTlPaVZkzNTGoqnlZbkpuUxlKXC+5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeMJ5phxwaUdi4kjVNnfJSr41jwT5kxTIEOJHF2VFVc=;
 b=DrniWPWTVRIOUtkKnrhE1R/SOlfbzydZAhH672MaBRU3d2Gg5Qn1IaZIC4BpNK87IkMeFDmRYdinHSGH2h9zzjjXqFBAcRPVcNqQ8xNLp3GhcD5TDDYyWWUfT4+eXeFSZxoewABp1aXBa5/swKKns9NDr9EFAUUyX/EKR66YamI=
Received: from BL1PR13CA0216.namprd13.prod.outlook.com (2603:10b6:208:2bf::11)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:35:49 +0000
Received: from BN2PEPF0000A990.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::66) by BL1PR13CA0216.outlook.office365.com
 (2603:10b6:208:2bf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:35:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A990.mail.protection.outlook.com (10.167.248.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:35:49 +0000
Received: from [10.85.34.241] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:35:40 -0500
Message-ID: <0262aa0a-1835-4359-92c2-e6b336030fe6@amd.com>
Date: Mon, 19 Oct 2026 12:05:33 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v5 5/7] KVM: VMX: Factor out wakeup list handling code to
 KVM
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-6-sarunkod@amd.com> <sashiko-outbox-172375@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <sashiko-outbox-172375@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A990:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: de101dc1-d24f-4335-6abf-08df2dab36de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Tzvf8JZ7Ya9W/u4mP7kJ18hbFpkEEGsDnGEYPba6o2Yrrkrm5EpeTlDXnLGMTYrSkFg5dbeu2rXSvHFKNCP8XFdKjv9WOxlJqKPkQIunxOwo9Q2k/xKS2YjRe9jMAvrCGbpqOhndr/UPvT22FOftqYfxe5j0NLC3GcLyU/SRqmrCFKNxGaeP76em517j827BGvrbAeitGTO8IIgRpXZKPNksb+lP1sdZdbotcSwBXre0NGQImjWk2X/OW62RzQobLnAECa2TPRaYlB2A9vjw+rkcRK3jfAgl1p5KMBzz6hixyTa0qdFEMcOYPkL01R75HrIyKvQI0vlkYkTJr+1MuAsmb3q0PQTIqR148GaYP8+YSUaerqtwbDk+Hw8t0de/tETmH8+X6X/zM0aokGM9lhmD+J24vbmamXY2Xvv/VQagouTRAf4s7pH/BDVG4TEjPZKVFWEJyHCiDPwttv2BluouROlKrJP2HVoXdqnbyKggQ5liw4FysyV7iHTGMXFWaOEFtAMzxhtjR3tVR3B8aeYbI77WnNDRj4CYrHGbt+z5xZpd/bMjVQRzabl2ULkX4JlxZgLwEz9MEoarrGlHEMr86czdM0b+jrB1vy75HOlfcrrpDH3xTxTYS1xsZLjDhu6tt1ywsO+oWKlwELBgYwRJKMRgspYw85X0R20/oqmSVeZFzbAH9xO8YG9bn11d0SPI5nhlsCKzBtpiHISt5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DhsJbYC/WVZmb0jVzrb2KAWOJ79enLL33l6E80ChWYmHCSWv3YMI2HET8O6rO+mUlqdq/NeWh2vZLVOpGDrnxwxkEx4V/IHQVOnnbvP80lkTXo4Sqw/CbcC4Hr5jmYeTESQtTaVBRh3nx+zwaK4FSP98dyY0EBddZfLHnXIlOMtZm0bEOI3CguK6liFuVBjghJYWGcDOrg/9bm2sLT6/w93Rd6Vg6IRPjfNDVWTC/jy+Blms4jIEvI7KgKkvflwZHdTS9j22hN/o42r7uCZpAvPiO2nqCud8shPBfRCqoLtPyeJ2qN5LgL7EkNiqBai5Mpxqtb7dVPRGpAgb5o8zFWoITnuOHybS8w6ie7QoFlpgG8iqNivPuxhpSIO3tuAb1lpmHkcUs61J7ixtNYhRvDDwAnDKz+eZZRj4ZFtDDIoMLuvBkruL3m3LP/ZbkkrN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:35:49.2673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de101dc1-d24f-4335-6abf-08df2dab36de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A990.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792



On 10/15/2026 12:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: uninitialized return value from vcpu_irq_pending due to KVM_X86_OP_OPTIONAL
> --
> 
> commit 56cc0b2c3b271017f40149e674efc58c033886d7
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> KVM: VMX: Factor out wakeup list handling code to KVM
> 
> This commit moves the per-pCPU list of blocked vCPUs and the wakeup
> handler from VMX to common KVM x86 code to support AMD. It introduces
> a new optional vcpu_irq_pending callback so Intel and AMD can
> determine if a queued vCPU has a notification pending.
> 
>> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
>> index e213c9ae3e301..5d337f9336c5d 100644
>> --- a/arch/x86/include/asm/kvm-x86-ops.h
>> +++ b/arch/x86/include/asm/kvm-x86-ops.h
>> @@ -30,6 +30,7 @@ KVM_X86_OP(vcpu_reset)
>>  KVM_X86_OP(prepare_switch_to_guest)
>>  KVM_X86_OP(vcpu_load)
>>  KVM_X86_OP(vcpu_put)
>> +KVM_X86_OP_OPTIONAL(vcpu_irq_pending)
> 
> [Severity: Medium]
> Since vcpu_irq_pending() returns a boolean, should this be declared with
> KVM_X86_OP_OPTIONAL_RET0 instead?
> 
> For optional KVM operations, if the active vendor module does not implement
> the callback, KVM patches the static call site to a dummy trampoline. Because
> KVM_X86_OP_OPTIONAL is used here, the trampoline does not clear the return
> register.
> 

Yes this is a valid concern, it should be OPTIONAL_RET0.

Thanks
Sairaj

> [ ... ]
> 
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index aad065d035fbb..0c637a18bcfa4 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
> 
> [ ... ]
> 
>> @@ -2688,6 +2709,79 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> 
> [ ... ]
> 
>> +/*
>> + * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
>> + */
>> +static void kvm_pi_wakeup_handler(void)
>> +{
>> +	int cpu = smp_processor_id();
>> +	struct list_head *wakeup_list = &per_cpu(wakeup_vcpus_on_cpu, cpu);
>> +	raw_spinlock_t *spinlock = &per_cpu(wakeup_vcpus_on_cpu_lock, cpu);
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	raw_spin_lock(spinlock);
>> +	list_for_each_entry(vcpu, wakeup_list, pi_wakeup_list) {
>> +		if (kvm_x86_call(vcpu_irq_pending)(vcpu))
> 
> [Severity: Medium]
> Could this evaluate uninitialized garbage if the vendor omits the callback?
> 
> Because KVM_X86_OP_OPTIONAL does not clear the return register, this check
> will read whatever was left in the register. This could lead to unpredictable
> behavior, such as spurious vCPU wakeups or missed wakeups on platforms
> lacking the implementation.
> 
>> +			kvm_vcpu_wake_up(vcpu);
>> +	}
>> +	raw_spin_unlock(spinlock);
>> +}
> 

