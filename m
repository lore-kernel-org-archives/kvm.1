Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8F40D56A
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947391; cv=fail; b=ofk5UhATHY1N6hJjomi7cawDIeyywhWytHV/YEuAhunCMnb1hApLDvpnaO3uCbILjKysMm3s/JIMolCWEC6LDjqils97UVQ87X7/FsaYjI8mW69H8RwViBtkQdGWcISxCaXtp/AwtIsvpR4OVReYboPSSdHtc05KSHiiv1j9xLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947391; c=relaxed/simple;
	bh=yNSnS1ZBDBA/JkLUBFttHazF+Ypd5AWNykyoilPLOW0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mXeKmRLaPRpqROEGDvYWjJcr8GcGeqr6Bir/xALncDXlJet/n/s9Rd3R9HIGMp0zdJPAc23qmDORxayFaw2hUcKLrnlb/c7VFWlAurFvaC9BHYCb3y2dLY5q1M5pQpzD8zYb5xXcsmY2ibyJWW8dDBoQtwY7iS7R4IFQsuzfHM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gQ1PXta5; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gQ1PXta5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkH4CL/5I+ZBNPYNyf+9Jq7d8+earbQoVoAlsZKmG7p2izB1er0jS09l0KsxqqnmQFYCrYgsk+HqHTMqwfQPA4beAkMlL8RvrohUMkH1yRPX1FncpTBn0dUg8SCcKdzb4gj5LPI99K7RrFaxsyhT57RZFvtCOWq1v1IxBY1VRvCgfKhBsUH7c+g0panibpoGp6HdKspcTpZEcRAJ4BicvosNSYUvubBHZXuqSQPFYemZN1CJhEZYwXPlKqk14ZYS8mnmdCKUDegXJbZZD9MmaCcgI8Y1RqJeTU7Z0aPc4KvZkzQ6cslYE09bCHK0D9JQVboFSJWkbEctXzGf9B20Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqQ5+/az/TovOov7C8YY0g/gy8oyYRsxlUnnG6hd0LQ=;
 b=PrqnlQMaC5xdf08dxyAGXJEh0GT7FeNcvskUQOdjvhKu3oq545wJcYCniaOtEdkpNH25Ri6hduY7FCffiwvfz0M9znB+RKfmxV7HL221dUK+IZCgC/TepGXOyvq24p24wodI7WQC6TdTPt8rBImrVWYJpHfL0kDJKHZ2JqFc1z2GfNllswnHHEBFgiPUmpWAcvNVvJJalSvkxBAAkt7BqG4UeFiA52pNqSS3s17oWJ47+wcUVr3+oX2PTH4LgUQc7OrCf9LbfLXXizmHr03ZEq/bjnpFuEertiRLaWaBFdGomIH01owItlW2NJIg0gy3fKN8OIeZ7nI+Jdl+B2TQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqQ5+/az/TovOov7C8YY0g/gy8oyYRsxlUnnG6hd0LQ=;
 b=gQ1PXta5orAD5YHZ7U3UOrwxQNwqMUIXALW0YDNvCVDAQedMDkvYyN4yChFl8YOhBSbsseQv6QktUsefyTeM3Pf41Cusv11vs/7+hkQbqc9PruzXsU99ukTzzeTwxHzZ11RTpiptR9rUqHevtG9oiwBMBWvhg07i92RFKWaNUqI=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 12:56:25 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::25) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 12:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 12:56:24 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 07:56:22 -0500
Message-ID: <6adaf312-84ff-4fea-b072-61588fd73b40@amd.com>
Date: Mon, 13 Jul 2026 18:26:19 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260713111119.EC35E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 934a0e9e-5244-4e11-e41e-08dee0de257e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WHIAFKNZXGMi5R+Oh2uiHp2aRObmciHlRdbFH1TPz3HzKcBYTkRKqWf8SaVXtnlDxB+cAaatwk4m4QgLG0JE7U+eMI0LmxNFY3VYH3SelV19I1IF8PIX42qAS1uv65eBc0YrHhqTZFFLkn8SqDzviDeNWtIGFo0bGpGB+HFZY0XtmdKwQK+rvx1yKqkh+IXUcGXfv7WXz+9blhQ1sRFLb3GWTyugr8Snf2S2k2RaMHH7qutPhWXHPTzLC14vNhnzT2R3YarnZLCE02478ql5zL/G6rN5fTIx99+gbPQ5lVG1Mo6MJJRV8qfTXxYmPM9Mt18IGBC4zVPEPU2ON5q/Uihj/++S7XWGiF2F7oBpvt6cQj8K/Wjaz4TtpktCWgg9vZlzu53Qx/mkzEdPzh4X8fNh4EkbpKJmwjD7SBAd3klJsR90f9VOUUI7tDgpeLZEa0EACupzR6ehZiBTBqLhy5ELGhM8zonmX1Av6fob6zxPPxA+9M4+3g9UK8SfO7XBueNUH6GylDoOMYud518NQUidqgHHfvtpV/WWK09+c+JJbfyDfkosnThYWuCwV6JcwkbUgXRwQNA3MTIRpOZoSkjWz8daQ/zuLn0KW5JmRcdGm6LCWc5qAkJwhzSP5LVuU1pZAA1wg/tTimjfvdR1B0q5YiRkMVMcbC4ASe7zWVQGXKqR7KfL9k9/f38pjLg37VrINwvWrTEpVZ96OwtfTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xtRhzrSTTiOcPY63z6vSo1oeO9nLyxnZPyW8b/VZ+fu5/jt46Lqq7qiLI6jiaRdS0ZOnGc48CtkDgHCVJD4NmyAPgOk9Mr/Wz+0HhwuF+ZAMladkqr2yqwZ+V/S+q2NBSey1HxdhdSOkW6+b7sNcJ7q5vf1qUY4bJLXfLtH3tFFfNs+D6BtLVKFMIUykTEnGOMrAyvPrVp9KmsJRl+cwWIfKmbaYyjUoJ/Ts7GwZocHf7j4vTYVui3iXsHn7GTNTFnoxqNyTcPiXwgcrl0XNt4b0nNTYZbUv3RIbnlvriqenVF/A33q9yh+JLuBGYcUa0N54SxiYXOTBSuzLQ1amP6buhOI7veZ7TsVPJBJj1hf8fBONlBYqp6AVM2SU4dxj+/AOk5/dO8tId0cMhAsq50MHsTws8LZjtMkLPZnbexrTOp2ZgZI2GyXtywfIkGRm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:56:24.8604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a0e9e-5244-4e11-e41e-08dee0de257e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823



On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Host-userspace-reachable WARN_ON due to uninitialized `svm->gappi_cpu` (-1) when configuring IRQ routing before a vCPU runs.
> - [High] Missing CPU hotplug handling causes blocked vCPUs to hang if their last-run physical CPU goes offline.
> - [High] ABBA deadlock between scheduler `rq_lock` and `gappi_vcpu_wakeup_list_lock` due to manipulating the wakeup list during vCPU preemption.
> - [Low] Mixing scoped `guard()` cleanup with `goto` error handling violates architectural guidelines.
> --
> 
> --- Patch [5]: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI) ---
> commit c3bb8845bd944e9a327f36d68b70032d436f727c
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
>     KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
>     
>     With AVIC guest-mode interrupt remapping, device interrupts are posted into
>     the guest vAPIC backing page by the IOMMU. When the vCPU is not running
>     (IRTE[IsRun] = 0), KVM must still be notified to schedule it. The legacy
>     path uses the GA log.
> 
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index 3b2d92a587098..982a5988532ff 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
>> @@ -886,6 +892,42 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>>  	return ret;
>>  }
>>  
>> +static void avic_add_vcpu_to_gappi_wakeup_list(struct vcpu_svm *svm, int cpu)
>> +{
>> +	struct list_head *wakeup_list;
>> +	raw_spinlock_t *spinlock;
>> +
>> +	if (WARN_ON(unlikely(cpu < 0)))
>> +		return;
> 
> [Severity: High]
> Can an unprivileged user-space process trigger this WARN_ON?
> 
> When a vCPU is created, svm->gappi_cpu is initialized to -1 in
> avic_init_vcpu(). It is only set to a valid CPU ID later during
> __avic_vcpu_load().
> 
> If host user-space configures device interrupt routing via the KVM_IRQFD ioctl
> before the vCPU runs, avic_pi_update_irte() is invoked. This will pass the
> uninitialized svm->gappi_cpu (-1) down to this function, hitting the WARN_ON.
> If the host has panic_on_warn enabled, this allows host userspace to trigger
> a kernel panic.
> 
> [ ... ]
>> @@ -947,6 +993,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>  		 * scheduled out, KVM will update the pCPU info when the vCPU
>>  		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
>>  		 */
>> +		if (amd_iommu_gappi)
>> +			pi_data.ga_tag = POSTED_INTR_WAKEUP_VECTOR;
>> +		else
>> +			pi_data.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
>> +						    vcpu->vcpu_idx);
>> +
>>  		entry = svm->avic_physical_id_entry;
>>  		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
>>  			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
>> @@ -955,11 +1007,19 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>  			pi_data.apicid = -1;
>>  			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
>>  			pi_data.is_running = false;
>> +
>> +			if (amd_iommu_gappi) {
>> +				pi_data.apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
>> +				if (list_empty(&svm->ir_list)) {
>> +					avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
>> +					is_vcpu_waiting = true;
>> +				}
>> +			}
>>  		}
>>  
>>  		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
>>  		if (ret)
>> -			return ret;
>> +			goto gappi_err_out;
> 
> [Severity: Low]
> Is it safe to mix goto-based error handling in a function that uses guard()?
> 
> Earlier in avic_pi_update_irte(),
> guard(raw_spinlock_irqsave)(&svm->ir_list_lock) is used. According to
> include/linux/cleanup.h, mixing goto with guard() in the same function creates
> confusing ownership semantics and violates the subsystem's cleanup rules.
> 
>>  
>>  		/*
>>  		 * Revert to legacy mode if the IOMMU didn't provide metadata
>> @@ -968,12 +1028,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>  		 */
>>  		if (WARN_ON_ONCE(!pi_data.ir_data)) {
>>  			irq_set_vcpu_affinity(host_irq, NULL);
>> -			return -EIO;
>> +			ret = -EIO;
>> +			goto gappi_err_out;
>>  		}
>>  
>>  		irqfd->irq_bypass_data = pi_data.ir_data;
>>  		list_add(&irqfd->vcpu_list, &svm->ir_list);
>>  		return 0;
>> +gappi_err_out:
>> +		if (is_vcpu_waiting)
>> +			avic_remove_vcpu_from_gappi_wakeup_list(svm, svm->gappi_cpu);
>> +		return ret;
>>  	}
>>  	return irq_set_vcpu_affinity(host_irq, NULL);
>>  }
> [ ... ]
>> @@ -1300,6 +1382,21 @@ static bool __init avic_want_avic_enabled(void)
>>  	return true;
>>  }
>>  
>> +static void avic_gappi_wakeup_handler(void)
>> +{
>> +	int cpu = smp_processor_id();
>> +	struct list_head *vcpu_wakeup_list = &per_cpu(gappi_vcpu_wakeup_list, cpu);
>> +	raw_spinlock_t *spinlock = &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
>> +	struct vcpu_svm *svm;
>> +
>> +	raw_spin_lock(spinlock);
>> +	list_for_each_entry(svm, vcpu_wakeup_list, gappi_vcpu_wakeup_list) {
>> +		if (kvm_lapic_find_highest_irr(&svm->vcpu) >= 0)
>> +			kvm_vcpu_wake_up(&svm->vcpu);
>> +	}
>> +	raw_spin_unlock(spinlock);
>> +}
> 
> [Severity: High]
> Does this lock ordering create an ABBA deadlock?
> 
> When a vCPU is preempted, the scheduler executes kvm_sched_out() while holding
> the runqueue lock (rq_lock). KVM then calls __avic_vcpu_put(), which in turn
> calls avic_add_vcpu_to_gappi_wakeup_list(). This acquires the
> gappi_vcpu_wakeup_list_lock, establishing an ordering of rq_lock ->
> gappi_vcpu_wakeup_list_lock.
> 
> Conversely, when a GAPPI interrupt arrives, avic_gappi_wakeup_handler()
> acquires gappi_vcpu_wakeup_list_lock and calls kvm_vcpu_wake_up(). The wakeup
> path then attempts to acquire the target task's runqueue lock, establishing
> the reverse order: gappi_vcpu_wakeup_list_lock -> rq_lock.
> 
> This inversion will likely trigger a lockdep ABBA deadlock splat and violates
> the scheduler locking hierarchy.

For this condition to exist, Following two conditions must be true.
1. avic_vcpu_put() and gappi interrupt handler() must be on same
physical CPU.
2. GAPPI must preempt the __avic_vcpu_put() once it has acquired
gappi_vcpu_wakeup_list_lock().

The second condition is not possible since __avic_vcpu_put() disables
the interrupt while aquiring the ir_list lock.

Hence ABBA deadlock is not possible

Thanks
Sairaj

> 
> [ ... ]
>> @@ -1308,12 +1405,18 @@ static bool __init avic_want_avic_enabled(void)
>>   */
>>  bool __init avic_hardware_setup(void)
>>  {
>> +	int cpu;
>>  	avic = avic_want_avic_enabled();
>>  	if (!avic)
>>  		return false;
>>  
>>  	pr_info("AVIC enabled\n");
>>  
>> +	for_each_possible_cpu(cpu) {
>> +		INIT_LIST_HEAD(&per_cpu(gappi_vcpu_wakeup_list, cpu));
>> +		raw_spin_lock_init(&per_cpu(gappi_vcpu_wakeup_list_lock, cpu));
>> +	}
> 
> [Severity: High]
> Are blocked vCPUs left stranded if their physical CPU is taken offline?
> 
> The per-CPU wakeup lists queue blocked vCPUs on the physical CPU they last ran
> on. However, there are no CPU hotplug callbacks registered. If a physical CPU
> is taken offline, the IOMMU hardware will not deliver GAPPI interrupts for
> that offlined CPU's APIC ID.
> 
> Since there is no mechanism to migrate the stranded vCPUs to an online CPU's
> wakeup list during the offline event, these vCPUs could hang indefinitely.
> 

