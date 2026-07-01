Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EE3A3826
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893919; cv=fail; b=b6AmcOlbZsGptLk1xBo32t5l0lbmPJxrwTIeGFqwv//YUAYMp1lRp8OC2p/FaBKecjPX/uHYk0YwQAisZ/YglF7zp2PQi1o7ghKwpwYEcalfQEqsdzM62FHOxmaeLYd107SsKmK6z5MzRZFvOiMeLS4HvauRUoGuZJZXGPzEu9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893919; c=relaxed/simple;
	bh=bl3RTdZuOjL6GcfYOOL0du1/IuI6jLILGje/gGnOkCU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sTVxbFEVFC2TY2Ps1FxuaTyqdFx4itE3Ce6t8814N20Gv3R2mDwvS4nEZBGHkOVMDWwq1J/bsnTSAwwQtQ35pKJn3Qs21KkZ1twJmeX1tyJMi7ZvgXqYux/+wipFt6jZ2RdL60I9rUA5xgOc7mSQLoa9s+gFmAoYF01K0bjVxqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/orCNns; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/orCNns"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI8YsUgcYGZBurXDQwZuWlDU4nn/JHVjSuq2efvP5S4zyc7eCmn4GiMaub2ruzCrD0hT/J/giqmywK3mfw2fjoTMtnJcTsLm7wLXc7Tgc4yqZUiDr0mmuMCZni7KW9cC1u3JsLvcekjdAcQYRlxjEJaMCOWtFeQTZ4SrAQUG+7iULBNGkWYFNrbGJN1GhXvLIvGj2HGAJK6r0yifA9fVcP2O+8vEpvVv6gyjjQ+RIXgdIslEPrwrLq9Pr0A0hBIGbnEwW4QL8SKVbw+c4G4j8Lx3PJ6n9fTzIEwq6c7hSk5DRUEguiEKNgvCZToYptLPjp8f+0rBG0L01PoMmLSwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFzsrBYLUeGAIqR7AwssOHEmVVgW+/RVfRtC+e/WUjE=;
 b=A5hievFKJh5QHFysgduZXOl29wJrJKQqcTJzsNgo8LHwPc5VsNEwwklmvup4esVuolGGMLPyDCwOrXORp7AqJzhXV+kUtFeFIBWMqwX4cncvdB/PwaIFnqRb/B8SDgYpjF2D7bG06ryKYhJCJS2n0B6GsAoPe6NtDvcsD4x1aW5y1kpjsWsbUOthmumbRv2QgvzkuYUnCFGNRsiWxJpjqSxopRxf2aTmt2uDllJoG1y4+AAMNv+wMi0Ek6sQQkNrXtqgeRQyWHk0I4b8EvTT5ShdUt/J/aGLGVr1bTkxDAQwxKWRYeKXqhOCkOtHW9pd2Iu7GBF4EYs0V6pm4QSIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFzsrBYLUeGAIqR7AwssOHEmVVgW+/RVfRtC+e/WUjE=;
 b=s/orCNnsXuvyss+oPwa79/1OcUFzz13zOpZXIbg+aviz/aK3xdTx8TMbzNnc2qXZBImTVvFRcfgo6PkTYT7xfVmK3xWTBm1AEd2j/VVXjL8uEQEN98H5UrtmNlWQYKscG2OAXh6gwXTELhV1/4+d1MeJ60SpDvRSeCH8Au6NI8c=
Received: from SN7P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::10)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 08:18:32 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::63) by SN7P222CA0020.outlook.office365.com
 (2603:10b6:806:124::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 08:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 08:18:32 +0000
Received: from [10.252.216.131] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:18:29 -0500
Message-ID: <0472d252-e8d6-4e97-b737-76be6936a92f@amd.com>
Date: Wed, 1 Jul 2026 13:48:26 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] kvm/svm: Update the per-CPU wakeup-list during
 vCPU load and unload
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>
References: <20260626105906.14577-1-sarunkod@amd.com>
 <20260626105906.14577-5-sarunkod@amd.com>
 <20260626112519.6A59C1F000E9@smtp.kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260626112519.6A59C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7b29eb-298b-4cba-74f8-08ded74956c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|22082099003|18002099003|13003099007|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	HkZ8B+hsVtnIIp1ALVR9YL0z3EWYRCxX/9iizWRaeYh4u7/XMT5b08n0yrNFI/Phbn+BXZM1uIEOuE1wdG8Um4OxxC8FvYDbQM8G0533WHEcUMdJqPTKcWkF8Z/yfs9YV7nMIHfaSpmeuHv2fEKjx56jJNYAavlDC9Yla2Ew0QC2NZjGFYhImujx5409O6BiK6PmXuzqA1lpFNq4YqW5TpOVfrfGHzqAAxekT6eMQXUY+QgOAFcB8CScCq/shJ/mmrg2Vysrr7DcohzS2CEUVx1OejNvbQTctralC1XQbyXOCS6+NKe9XkH7BD9ydwe9AbfXCjr7ftVd1jJqhLvvDUdBaLUGZWHba4tMYbBzhNB6UGs0VAqWzFha55Du6I4vdNbzoyhALyscDfAy3yiL5a4S0z/Sw7bpcMfykRkIFzn195KlyapXfPMU/8oeR8aosMBD/ZYddCBQXkRHlyMrBWOz5VgtQyJyN94rLGCLmlt/BWeOHIStmYXX9GtBjso0ZQNg+ttxcuUWKTnhtKeTuYxdFq8zMyOytzFcSCbYcf8Y46t53YRgaRGuyiFKJsDxAl97u9atF7RJ0zex4lQgWLBErky4kI5C0PQchyWOHQhlUAvwtyk9/nAFjPRnCuT4gRvuJ1HXE2HDp5s0pf//sQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(13003099007)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p1843Lwrgug+xVH7pdWRyvh1zK3kxyuTYkcNPOaj7jTSE6+2rfWDh+/sXRn+qiTQo1OJMPTeCCpPY1lcMqKJuZfTciOGTEAa+6zU1+zAzgXcF5Vk6ex/tll/700kUQrO0HpozRDY+zShHkzOC1pfY/gVJDpLV7P7o2QQXXqV80kBIKWgPkf8boHQeyyNoVpHE8Mqm1D8PiKp1oM72mta/VychS3us3DZ+qPvlr6g8y9nCaRcm+yfQ4xu/uKlV9lsj1gyYipMoiFuoSb9cf66qplHuHXLBUodsTwZnkYEBMMTMv1mJT3tLwm8LPqYm8WpZSDrY0chiRQXZem0uzozp17Q9LWtCVoUFkL+XRvbZRp/4G16qURS3hVm4n2UWl+XR53EL/BSz9tjKufNKkzCDRIxIHGv3l8Fcp2w4hcZxpPl9XtKIwM8mEDzoJlxiU+p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:18:32.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7b29eb-298b-4cba-74f8-08ded74956c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096



On 6/26/2026 4:55 PM, sashiko-bot@kernel.org wrote:
> [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] `avic_remove_vcpu_from_gappi_wakeup_list` and `avic_add_vcpu_to_gappi_wakeup_list` acquire a raw spinlock without disabling interrupts, leading to a hard deadlock with the GAPPI IPI hardirq handler.
> - [High] Uninitialized `svm->gappi_cpu` (-1) is unconditionally passed to `kvm_cpu_get_apicid()` and `avic_add_vcpu_to_gappi_wakeup_list()`, causing an out-of-bounds array read and a userspace-triggerable `WARN_ON`.
> - [High] The GAPPI wakeup handler is registered with the core kernel but never unregistered, leading to a dangling pointer if the KVM module is unloaded.
> - [Medium] The per-CPU GAPPI wakeup lists lack CPU hotplug support, resulting in permanently lost device interrupts and hanging vCPUs if a CPU is offlined.
> --
>
> commit 3af48ba2bd8326c04b2aa47ac47a9f53e0cd61a3
> Author: Sairaj Kodilkar <sarunkod@amd.com>
>
> kvm/svm: Update the per-CPU wakeup-list during vCPU load and unload
>
> When a vCPU is unloaded from a physical CPU enqueue it on that CPU's
> GAPPI wakeup list. Remove the vCPU from the wakeup list when it is loaded
> on to a CPU again.
>
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index e7a4c0e90e7a7..d238f65a8172b 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
>> @@ -889,6 +892,44 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>>        return ret;
>>   }
>>
>> +static void avic_add_vcpu_to_gappi_wakeup_list(struct vcpu_svm *svm, int cpu)
>> +{
>> +     struct list_head *wakeup_list;
>> +     raw_spinlock_t *spinlock;
>> +
>> +     if (WARN_ON(cpu < 0))
>> +             return;
>> +
>> +     wakeup_list = &per_cpu(gappi_vcpu_wakeup_list, cpu);
>> +     spinlock = &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
>> +     raw_spin_lock(spinlock);
>> +     if (list_empty(&svm->gappi_vcpu_wakeup_list))
>> +             list_add_tail(&svm->gappi_vcpu_wakeup_list, wakeup_list);
>> +     raw_spin_unlock(spinlock);
>> +}
>> +
>> +static void avic_remove_vcpu_from_gappi_wakeup_list(struct vcpu_svm *svm, int cpu)
>> +{
>> +     raw_spinlock_t *spinlock;
>> +
>> +     if (WARN_ON(cpu < 0))
>> +             return;
>> +
>> +     spinlock = &per_cpu(gappi_vcpu_wakeup_list_lock, cpu);
>> +     raw_spin_lock(spinlock);
>> +     if (!list_empty(&svm->gappi_vcpu_wakeup_list))
>> +             list_del_init(&svm->gappi_vcpu_wakeup_list);
>> +     raw_spin_unlock(spinlock);
>> +}
> [Severity: High]
> Can this cause a hard deadlock with the GAPPI IPI hardirq handler?
>
> When a user process destroys a VM, avic_destroy_vcpu() is called from
> svm_vcpu_free() in normal thread context with interrupts enabled. If the
> POSTED_INTR_WAKEUP_VECTOR IPI fires on the same CPU while this thread holds
> the gappi_vcpu_wakeup_list_lock non-recursive raw spinlock, the interrupt
> handler will spin forever attempting to acquire it.
>
> Should these functions use raw_spin_lock_irqsave() to disable interrupts
> during lock acquisition?
Yes, you are right, it is quite possible to receive an GAPPI interrupt 
during avic_destroy_vcpu(), hence we need to disable the interrupts 
before holding the lock during avic_destroy_vcpu() path Note that other 
paths that call avic_remove_vcpu_from_gappi_wakeup_listare safe since 
hold the irqfd lock with interrupts disabled.
> [ ... ]
>
>> @@ -958,16 +1005,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>                } else {
>>                        posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
>>                        pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;
>> -                     /* GAPPI is disabled at this point (amd_iommu_gappi is
>> -                      * enabled in the following patches) hence keep the
>> -                      * apicid as 0.
>> -                      */
>> -                     pi_data.apicid = 0;
>> +                     if (amd_iommu_gappi) {
>> +                             pi_data.apicid = kvm_cpu_get_apicid(svm->gappi_cpu);
>> +                             if (list_empty(&svm->ir_list)) {
>> +                                     avic_add_vcpu_to_gappi_wakeup_list(svm, svm->gappi_cpu);
>> +                                     is_vcpu_waiting = true;
>> +                             }
>> +                     }
>>                }
> [Severity: High]
> Is it possible for svm->gappi_cpu to still be -1 here?
>
> If userspace creates a VM but inhibits AVIC (for example, via an invalid
> APIC ID), avic_vcpu_load() bails out early leaving svm->gappi_cpu as -1.
> If userspace later assigns a device interrupt via KVM_IRQFD,
> avic_pi_update_irte() will pass -1 to kvm_cpu_get_apicid().
>
> This triggers a negative index array read yielding a garbage APIC ID, and
> also hits the WARN_ON(cpu < 0) inside avic_add_vcpu_to_gappi_wakeup_list().
>
> [ ... ]

No, its not possible for svm->gappi_cpu to be -1. The avic_pi_update_irte
is called to assign the affinity of the interrupt to the given vCPU.
Which is only possible when all the vCPUs are online and are loaded at
least once (avic_vcpu_load() --> 
avic_remove_vcpu_from_gappi_wakeup_list()), ensuring gappi_cpu is not -1.
>> @@ -1353,6 +1436,7 @@ bool __init avic_hardware_setup(void)
>>                enable_ipiv = false;
>>
>>        amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
>> +     kvm_set_posted_intr_wakeup_handler(&avic_gappi_wakeup_handler);
>>
>>        return true;
>>   }
> [Severity: Medium]
> Does the per-CPU GAPPI wakeup list need CPU hotplug coordination?
>
> If a physical CPU is taken offline while a VM is running, any blocked
> vCPUs queued on that offlined CPU's gappi_vcpu_wakeup_list might permanently
> miss their GAPPI wakeups. Without a hotplug state notifier to migrate these
> vCPUs, will they hang indefinitely?

The concern is valid. However this behaviour currently matches the existing
intel VT-d model, which also lacks CPU hotplug migration. The failure 
requires
hotunplug of the physical CPU, which is uncommon in production environment.

As of now, we don't support hotunplug of physical CPU with the GAPPI.

>
>
> [Severity: High]
> Is there a missing module unload teardown for the wakeup handler?
>
> This registers avic_gappi_wakeup_handler with the core kernel, but it
> doesn't seem to be unregistered (via kvm_set_posted_intr_wakeup_handler(NULL))
> during module teardown in avic_hardware_unsetup(). If the kvm-amd module
> is unloaded, could a subsequent POSTED_INTR_WAKEUP_VECTOR jump to unmapped
> memory and cause a kernel panic?

Yes, module unload should unregister the kvm callback. Will include this
in the next version of the patch series.

Thanks
Sairaj

> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626105906.14577-1-sarunkod@amd.com?part=4

