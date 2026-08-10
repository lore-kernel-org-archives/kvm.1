Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010049.outbound.protection.outlook.com [40.93.198.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7B345725
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786341269; cv=fail; b=E6bssFozoyRmWz0R8kMMuSXGGO6uAyccNm7PqPkOqfFjdQdcTSpCncnfcN0LNoVma5ex8vA3XY+mXbPNFrUInP3K451u4jJmGfNUSV9P1VOcePdxEo4Eye99o1C1H5mA63gx8RKrZxOPm9Mr7H86UtcCI8qRZJeq/E2ox9eRsag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786341269; c=relaxed/simple;
	bh=jEpn7XWzTT1U8h80ma/B0mUzu3cOpCXhS1iBdZ6oG9o=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lQIVf4EY+4/QwmKdv+3G8IUme3HDWL6VRNsRxiqfP1NqGuG/GlJCutR4RNPFcXkWOaro1An9G5JMY9VMcW7nSR08XsHhDzmOxVOpiUQ05AAf16QQj6wY8Rynlj62BKuBC25oXcAndvJfl0QPGwinB7MGGEbyzuxr9qiUl67zsZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r88EKz5i; arc=fail smtp.client-ip=40.93.198.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r88EKz5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu9oRYQpe5oFs+rHQYQhUTWeaP7qtk3V/zje5wILkrOv7WZHblr+1t2ktYfonRRD3XTXvxMs0DWdmOkNcj5cvcZRgPUS2NhP2J8f57nKFTwcnUPUIJJDrS5uTk6jNMwVdlllJ0CjkGW/mm+RHcrNL4ah4s23jNcsyP0LojWoXx76c6Jak+HD3PhJr21kM8D973OZq3Q5ZOnkuoquSm+j8RyPIb4hXUG/1vTLzaa+Z2c89dcmn9uXV/rommq7LRiBLfsUoNF2mDaukGPNgfgDuTFrEX0Sbxc968O8S6KcLiTULFz2geiu7sIUW4ZIZSJR3Bp2knMG55U2emBe6Y6dtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td1f5GcqWUT9EVPqLBJBkMeJiO+Hy4/udoBw6EgapyA=;
 b=NQPZDT/qN0QyLP/eII5bg5BvMQfDYwhtIGw/TXPevt/sGnZQjZg+FxBKIxZvpIUQaqV0Y3ZpmZ5RYYU8+hePqiZIyM/mslolIGJbP1WVfvOyBCMQ1hl9QNjt3RGv1yK1CnRjDM6aI7IXBOzj4M1yxBMefkRkflUsjGcCGgcWmI3ANnTiLLsSwTUsN6gitQkwF8r7a00DRZ1xqj8PBh79kBtnK74RWD9gTL/8Fdx289/DOiaeHPgeYhoodu7RHeh7OxAN2UbRJxjReWL2ZVusDObOEcVUhFPeDyKtfHfyZZo8WVDv5NZh7lGP2hs6dazC+IpErczJheK+WTiv+bvcQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td1f5GcqWUT9EVPqLBJBkMeJiO+Hy4/udoBw6EgapyA=;
 b=r88EKz5i+06BC7thHc3ks7x0uEWXCRXI0bbdUVRXldYU/ZLzeoKAO3pGVYR4+wpICXISR6RbTquvbkxYgRf5d5zRai+qtqyPLYy09Qn7BphS0tlyNlcdGdxD8uEWSY7072kACiViiXaPzu1ddtXD9gprkvY+SmjKGi4bW+Tq8AU=
Received: from MW4PR04CA0198.namprd04.prod.outlook.com (2603:10b6:303:86::23)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:54:23 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::49) by MW4PR04CA0198.outlook.office365.com
 (2603:10b6:303:86::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 05:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 05:54:22 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 00:54:21 -0500
Message-ID: <b50b3535-eaa1-4944-914d-0eea8dac0e06@amd.com>
Date: Mon, 10 Aug 2026 11:24:13 +0530
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e135f4-d291-4339-a3ae-08def6a3d3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|5023799004|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ugsXnV0uTCdG/C847iKxkQZbDrQCAjwRZf04yDzyJrDFku6ehr1HVA5nJoAFHKT76mpF48S5nm3HK+Mq+RQZmdnTriGu/V2uUSkPhol5G7tCdqGX3vxL/vLa/Oy7U5gZqZ2JWNfmhMfV6HqaBbRUaodxYTLvbSmzOlsRVebkbt6BvtpqUOZK/W6SCM+DWAJLlSTe7caT8ynbAnnN1HrD4I/BqzmvZraEgQYYQFKgdKcwQx5zOEmRcMqmC7t5aYFKZyin3vGyicoREECc5XxXZQXgxBm1UE173Vrix6JTKFK157CYIBthg00h/fC6bbi/rOr2G+f4b48xe30hBxuxmfVXDy255fMYy82yKg6j82uZrUGA7B3BE0KJToON4pKFwjzS+7NqjURiAG4jILwe4YOQZOY4vx2Fkdy996IPUQjITq6tjRFnuauQHQwFrD0LzdUqGyFMnk5G3gqi1Av/cQh11ch9maVTaeE914JCl1anqcBiMoTzBAA7D2AbzjFxqhFvz+ApWZa34FSZ9VbLbCEDpjnPv6tjh/kRn8kMPaaJNf7QvKsUq0ersGokpRFJYbfL0r+7sZfr5Vv4f+wWgiZHtZt8quZyBdKkDVdnlRaowen7tW6bJRu02L2P9Bu0y+rodoBximuMoJFPjuvyucSAraMt1pFCKjtZ7Wr5+X14+k1wjj08uRiyV14CWfuJTGFHwQo0kMHjQRBg5rbUWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BXoEPcoXIAZbjjX6RjsonK0/DJuCzYUuqKC70CytvJS3oSRKOHgJzfLaJ54sB2o1PGJlYzKxGJqiIWhb9mu7fDrfNqysAvLwyl3QwkRzedOlUBaGax+0+AjMyJ/OVMxicD2OYQ+1v8TZkLJHAqlHJ2/qjWYU+AOk/Mnp3sJxl+t0eTYPb3NlJIFE7fVydGC9HliDppg0aN6x71Hl5tGtVVN62KmMpBJk610Lf22GSX5AOXx91H3xPO31DLWo693GshZEqTinPaTnqxlQx0MlBGMryFNy9raVvLgzUovEUMvua+rTD2do+uBApdWFMYkz4BU086KFJiVgKvG0f6y3YlVGPmGwv5ieLm5F1lz+H2JXvhuenPwb6irgJQmEJtMiT3w853ScupFe054oA9IHp4/l/v3+dUjP9vvhm9GxKUnMCfoqHlgQyREb/1Kugl2x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 05:54:22.8495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e135f4-d291-4339-a3ae-08def6a3d3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299



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

This is a valid concern.

If host userspace attaches a bypass IRQ targeting a vCPU that has never
been loaded. Functionally, there is nothing to do in that window. A vCPU
that has never been loaded cannot be blocking, so no GAPPI wakeup is
required. The IOMMU still posts the interrupt into the vAPIC backing
page, and the pending IRR is evaluated at the first VMRUN after
avic_vcpu_load(), which is also where the IRTE gets a valid Destination
and IsRun = 1.

This can be resolved by assigning a arbitrary gappi destination, without
actually updating the gappi wakeup list of that CPU.

Thanks
Sairaj

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

Valid concern

Will remove all the gotos in this function.

Thanks
Sairaj

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

