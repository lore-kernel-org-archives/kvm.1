Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794398246;
	b=2YERFk9n9l3WwHdY0Ao0nJW4Z50T0WDk/uRqm2EGiflAUXGdUUZbCW6rKh6IzWbFV6Lx
	 QGo8TLpXXS1Ueh9cB7/1X8OP93xozQTS2H9luQOkUDAQLZlu9h7uVZpZtu3nMxOgTWSoF
	 RLwwGTF/qwhBHfQ8wS+5CgQJJflIgQDoTkDIbI8z8Tvg50IlqCah2quJM+jPIZTgdr+nU
	 t3OrEA8O8XbfMhPwzSHIPsXJF+gKmQ7LutrwWgUu951LUn+/nC1IqN3fk2U+jygDXi4k1
	 pJt4BTC41yLGuILmqAVq0rTjsDzwUcqY2L3qfFGjPDuwpcmLYe6X26XahvhdFkJT4lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398246;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:CC:Subject:Content-Language:
	 To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
	bh=UJObeX0hpu3z0Fe2b6YL+3MKJg28upvLTa8enX3NTuU=;
	b=g5D64PQbnOx9IrzMJ3bf6vOTHEC7UA6hDyskgMFl2HlRTXqUscy3scCQAVGtJIoQ8Ysk
	 m0iIowzL7/69NSSihy8Z05mzPhR/lOkfKRBhiplLGxdJIZJf4Bn5Ll5vhylmLFE+FUad5
	 GsliqCkNgwR7ugg8bzuy+LUNk4xl08M9c1UHFyFj5AErICK/J8c/QFltFDVAF8s3oX7y1
	 LGbH9w6oqxj1jJE6r02ybHKxJ3syj+OUySyp6anyXGQgQNReqyxqW/E22/ut/J4bUZPLZ
	 LPXcgDYlXqqetN32CTuNHDRZ8YCjk+IxHRFl7la2UaErI/+q/ynqbVsr06AXLleOr+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BdTXENaJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.10
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86D606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E86D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BdTXENaJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imS5auzoGlRd9AlqBxJJAE4z2U3/+eMABT+PSZdAyuJRbt0sRGUtRgavzwbtAYMZOBzaz8sTnf1gs4Yh9dTnTAld0+NHwQ0zzekBGMxOGjV03nSh2vSSxymUf8FE7vd1QSTfzo0W5+UAHqvUTHOaxpgMfoK0mot6RSdHgMQgtIvh/ey2YoRb1nuCSsALbgUaVtc7YRcoGoRJn1Hsw1h9RSX/HYSr3cB8xN/BZz38eTDQdihbLIXpdnS/fV30IxWJFzX0ipADlz0NqCGa5A8wlltUseM31nmW88YyLyCcQ84wMj6IbJbwUbu52N61VoH8fVoYnHS3E85GoabcRgDc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJObeX0hpu3z0Fe2b6YL+3MKJg28upvLTa8enX3NTuU=;
 b=IwvFBk1GNgRSd3MvS6YE0RsJp2EGv4kKw+obSoGmlu5d+PFMQD6UGyDoAvpR4X24S7uB09ocp25YK+4M41RJudH+Wt7R8DvgTYZLKF4B7QsOLIj5rwqU1coFn4yiw4X0Vux7sG7VqIwoMsxAkoOx+W6V5NzzlAuNalfQsVUSsyuBTYSxJ7Z7Q0X7bmCa1DVgWPgcWreIvxzl6lySQXm6PhYIos4qumejPcsMID9i9icotBEB+OmDcwD56J/sJG1Nr+ZunWAIpVJkglaG2FrVl9rGCxWc1Q85S3o6lsF1duGOx17cmLHoynz36TMYgVxO18KYZdPmeRTjcFTmarO/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJObeX0hpu3z0Fe2b6YL+3MKJg28upvLTa8enX3NTuU=;
 b=BdTXENaJyrikq9PFGRnjaFSPoqX9qdaFkVqhL4Ti0P0MWIyqZLacf22LlI83My4KbCT7QCl70ldxcBQ+zyj54qDYi9hTb4Mo+IQ4wu7fNWC29/9ufdAl6DePx7TsIxsTRTlN1w+qmHxb0mnkAUvefIy9TAB36M+wOn1fHOWWz4Q=
Received: from MW4PR04CA0228.namprd04.prod.outlook.com (2603:10b6:303:87::23)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:57:18 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:87:cafe::65) by MW4PR04CA0228.outlook.office365.com
 (2603:10b6:303:87::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 11:57:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 11:57:17 +0000
Received: from [192.168.0.108] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 05:57:15 -0600
Message-ID: <a2a4c5e6-8264-47e1-80de-375dc2eac048@amd.com>
Date: Wed, 11 Nov 2026 17:27:07 +0530
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
CC: <sarunkod@amd.com>
Subject: Re: [PATCH] x86/kvm: Use RCU for svm_vm_data_hash
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, <kvm@vger.kernel.org>
References: <20261111100246.4425-1-sarunkod@amd.com>
 <sashiko-outbox-208769@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <sashiko-outbox-208769@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: a59ba448-34da-49df-81ea-08df3feaef5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006|5023799004|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	TDggxe8+u3xQqAnbgidytGVAvJAf/mlT1oZrLSaSjwDx6Beaeg4Pm2ZbPZc5yrZNWwn2mzctZM6U8qJO1yjXindLgXeMAClTZf9zhh52LPCDZyHykjvjLl+ae5oPkSTXKWYTrstB9CFk+1MuFKaAFJ1Im4IjlZGhIjKIBDiLTkpNCz0Uey5gDh1Z/MVi63+aQ3TpN6i3ZdJ4T4yKUnL1odCS2gPNyLSJR6d2fusbdENrevhZrNiyxdzQgIpiOmahz98KUikcJMEGNO8Jb7f1PAkXliN3qun87Mo1FckHC5IN0w/CdlqYKhU7leo6MW3lTxHuXU9m5JzZsh2gXFvuG7yedmGEnYbdmDP+vo7OZ4HnoXLJLtbDWZSGfIgZnxbO2G3KeG7SCCPZb7hb8ZydAUhk67pMQmZZojLCXXaeUCC9clkP7CUcTPczDF/Yxfd0HRwYksV4PCF32q3fVFENgwNlGKgh6nyZQhfKw/xecJjtzFFeGnGs/HMi8gJPur+e+KK3FRgckz6r5tvqCoNtCPlEXEXDj4Od48AW+8jFHgLAHTucFRCvsPDwWQA2cKjqV2T82grCjfcI3s/DdZAL9SiPax2QrkHcrQTl1xvqW3M06du1Cre+frxp855El7DKsuWzpkXDkzzz/y2kwJR6vc0oZlvK/zAuVqQneNJBuiEYfCUILY+OeWXuZD3TD/vaZu2AcMY7vVhAW0k1fP56uQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(5023799004)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(4143699003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SlZReFrot5Qj7Jt/DeTYxPirFC9tfA5ueY18AyWFJBAgtoLC+Abv0dD9GxcXts4wY7+TTcn542hkgQvoOJUG9oRY4RvZtGWF+XUPHMx+WyUSYWW1A82bifvml8Z3L6SmRF+hc6NbABGd2dPR96cmJcwUIYquZ3lwoExalqZKMj4/prN2ikZclb3bhFZjbJpNbpi4tQcL40AIuGp0PBYW03V5SEQWPEF0+Pnp9BT5qp2GBOyu0n3wWrLvxevqNih31ZdbaSS3lKPIVScOWCUrTcx0oHr7b4d/kuBxatiS/c+EtOY48bPb8LvDF7HVD7PZrqhA6nHlSjEXli60xaitmyVkL27Z4+bYzOBQlMI74DNkIbJ5yGo1rxu887e985ZPw9zSTmKmh0alaPqA2MCO0U3fNpG/G4OxDJzI3j5Amw339qTkEpW3v6O0Ps7quLLm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:57:17.9268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59ba448-34da-49df-81ea-08df3feaef5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467



On 11/11/2026 3:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] KVM: SVM: UAF in avic_ga_log_notifier() and
>   avic_vm_pre_destroy() with RCU
> - [Low] KVM: SVM: unnecessary guard() removal in
>   avic_add_vm_to_ga_log_list()
> --
> 
> commit 460915a518276bc08e3b21ecfcfa94bc27d07493
> Author: Sairaj Kodilkar <sarunkod@amd.com>
> 
> x86/kvm: Use RCU for svm_vm_data_hash
> 
> This commit replaces the spinlock-protected lookup of svm_vm_data_hash in
> avic_ga_log_notifier() with an RCU read-side critical section, and updates
> insertion and removal to use hash_add_rcu() and hash_del_rcu().
> 
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index 3b037e3855234..ba12aa5872255 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
>> @@ -250,7 +250,6 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>>   */
>>  static int avic_ga_log_notifier(u32 ga_tag)
>>  {
>> -	unsigned long flags;
>>  	struct kvm_svm *kvm_svm;
>>  	struct kvm_vcpu *vcpu = NULL;
>>  	u32 vm_id = AVIC_GATAG_TO_VMID(ga_tag);
>> @@ -259,14 +258,14 @@ static int avic_ga_log_notifier(u32 ga_tag)
>>  	pr_debug("SVM: %s: vm_id=%#x, vcpu_idx=%#x\n", __func__, vm_id, vcpu_idx);
>>  	trace_kvm_avic_ga_log(vm_id, vcpu_idx);
>>  
>> -	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
>> -	hash_for_each_possible(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
>> +	rcu_read_lock();
>> +	hash_for_each_possible_rcu(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
>>  		if (kvm_svm->avic_vm_id != vm_id)
>>  			continue;
>>  		vcpu = kvm_get_vcpu(&kvm_svm->kvm, vcpu_idx);
>>  		break;
>>  	}
>> -	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
>> +	rcu_read_unlock();
>>  
>>  	/* Note:
>>  	 * At this point, the IOMMU should have already set the pending
>> @@ -319,13 +318,14 @@ static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
>>  	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
>>  	struct kvm_svm *k2;
>>  	u32 vm_id;
>> +	unsigned long flags;
>>  
>>  	lockdep_assert_held(&kvm->lock);
>>  
>>  	if (kvm_svm->avic_vm_id)
>>  		return;
>>  
>> -	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
>> +	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
>>   again:
>>  	vm_id = next_vm_id = (next_vm_id + 1) & AVIC_VM_ID_MASK;
>>  	if (vm_id == 0) { /* id is 1-based, zero is not okay */
>> @@ -340,7 +340,8 @@ static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
>>  		}
>>  	}
>>  	kvm_svm->avic_vm_id = vm_id;
>> -	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
>> +	hash_add_rcu(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
>> +	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
>>  }
> 
> [Severity: Low]
> This isn't a bug, but commits 4fa9a3767d1a ("KVM: SVM: Do all per-VM AVIC
> initialization during vCPU precreation phase") and 78684b65fcc0 ("KVM: SVM:
> Remove VM from the GA Log notifier list before VM destruction") switched
> avic_add_vm_to_ga_log_list() and avic_vm_pre_destroy() to
> guard(spinlock_irqsave)(&svm_vm_data_hash_lock), which can still be kept
> here instead of open-coding spin_lock_irqsave() and spin_unlock_irqrestore().
> 

Right, will remove this

>>  int avic_vcpu_precreate(struct kvm *kvm)
>> @@ -369,13 +370,14 @@ int avic_vcpu_precreate(struct kvm *kvm)
>>  void avic_vm_pre_destroy(struct kvm *kvm)
>>  {
>>  	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
>> +	unsigned long flags;
>>  
>>  	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
>>  		return;
>>  
>> -	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
>> -
>> -	hash_del(&kvm_svm->hnode);
>> +	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
>> +	hash_del_rcu(&kvm_svm->hnode);
>> +	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
>>  }
> 
> [Severity: High]
> Can this cause a use-after-free on struct kvm_svm and struct kvm_vcpu
> when a VM is destroyed concurrently with avic_ga_log_notifier()?
> 
> CPU0                              CPU1
> avic_ga_log_notifier()            kvm_destroy_vm()
>   rcu_read_lock()                   ...
>   hash_for_each_possible_rcu(...)   avic_vm_pre_destroy()
>     vcpu = kvm_get_vcpu(...)          hash_del_rcu(&kvm_svm->hnode)
>   rcu_read_unlock()                 ...
>                                     kvm_destroy_vcpus()
>                                       kmem_cache_free(..., vcpu)
>                                     kvm_arch_free_vm()
>                                       vfree(kvm)
>   kvm_vcpu_wake_up(vcpu)  <-- use-after-free
> 
> avic_vm_pre_destroy() unlinks kvm_svm->hnode with hash_del_rcu(), but
> nothing waits for an RCU grace period before kvm_destroy_vcpus() frees the
> vCPUs and kvm_arch_free_vm() frees struct kvm_svm (the intervening SRCU
> synchronizations in kvm_destroy_vm() only cover private SRCU domains). An
> in-flight reader on the same hash bucket can therefore dereference freed
> kvm_svm or vcpu memory.
> 
> In addition, avic_ga_log_notifier() calls rcu_read_unlock() before
> kvm_vcpu_wake_up(vcpu). Because kvm_get_vcpu() does not take a reference,
> dropping the RCU read lock early leaves vcpu unpinned even if
> avic_vm_pre_destroy() waits for a grace period. Calling kvm_vcpu_wake_up()
> inside the rcu_read_lock() critical section and adding synchronize_rcu()
> after hash_del_rcu() in avic_vm_pre_destroy() would close both windows.
> 

Right, will do it

Thanks
Sairaj
