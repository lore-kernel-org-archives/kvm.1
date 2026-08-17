Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454843AF65F
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948021; cv=fail; b=npSQEVCfb67aasceRP4ojD5wpBGqu3vQZJHvOhrxqmUb2hDHQKjkguN4Vt7rS94i9zcizbMitCzZEgJ2VnEEstpVDexXqG2cSLXqTbJDYMra2IFEuSu+S+gZkOuRo++cjsg1FCukourIG30N3+R/hoza9o7US59jW6JCE4mYyVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948021; c=relaxed/simple;
	bh=ZouZZrT8JPMyZVUQAqIgvv4g53460g03fs/uY6OtaCc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZvR9ZwUyF9U/YHFe6BDAsZfI9JzvdZoTvv1Tvk0OUm8rZi032qxcJKDJRyNEXf2EMoPhkTcFKARjiEl+jtF3sg15hZUE+JhHHRUiRYiIBhSgEHQTPGbumjdceFRdhT9NL2sEt+teBMUH3EzZZhcM/bwFk5o61wV8V0BJMigpT8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x+nY6tEL; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x+nY6tEL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9CwgkS5TPkPttY3K89Of20KPqruRtmjBpr1KgGcnGFGP7pPA+6HbmurwnGjTpp3/D9A783Q/Mnh7nUixF50nmfy4f18PihH+jrBA4oRSsV+5ta/RUxj5cbttuXJWRC5cPouC2I/alTjxuYGQx/pkHyJjlqnAa5ptSja9MFYc8mMt91F52gPEoBP6HtOgjTRT/Wdwiyb7S557a0iOSu2MmIWvs5akPU0jG8mVclO4CH52VU+v4wZG8n2q563K4jQJsKr469iXteIhk9fhzVFW093mFhYK3FIJvPqpMX92x6KggU1t1dlXt4AC3rQQuMNyUxEJT7w4OnhQ4czGfEfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JmZNE0OTjOpJRTpRGbc8X23vJm37o7dpyuWfO7+QuA=;
 b=bDvXb2jRJIQtWaJROYLxZa+aU+4Y7xj0quKwzb92q0mdHN5huLUldRc4ghlUmx9hHULJj2nMY2TBWhFK1ntKldut5pE4d0DZLH1eOgygbmdzbgI1lIIm9dX7IXXXf8Abu1uLOpZnNySdbuw6R/INmriKcI05ssUKcgbk1wsLEKr6U0i6UD3Z47chFIItf0Ck7CPlza3CdiuWvWUMs6/W/1Sz+b53TYFrb4yOSH7xBD6I4hWgCvYV17goIl3l1a2mTg0tVgfNlzjb7afmm/Ss2Df+DLuOFNhiB2/DanGg/BF7r4EIx24DEOQkPMeKV6WXGHxQb4T7zk/seqa6SZVBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JmZNE0OTjOpJRTpRGbc8X23vJm37o7dpyuWfO7+QuA=;
 b=x+nY6tEL7PwqDXcW+CWsvhV/EXzpU3kL9bA0U8XAlH1xnPfrrebbzojFoauknmtChsXwuxfO9X4OXidFWKtIKPDT/dSbXjw1UaEdQ9Ezaj1mL3IOdFhfYaBko6s7qqMTE+iTZyCL3vjimU8dKsAKxKAc/dRtdk5ic49i6t0xxvY=
Received: from BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::23)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:26:55 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::3f) by BN9P220CA0018.outlook.office365.com
 (2603:10b6:408:13e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 06:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 06:26:55 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 01:26:53 -0500
Message-ID: <32c405c0-a05d-49e7-9cc5-3e5918c27df1@amd.com>
Date: Mon, 17 Aug 2026 11:56:53 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <sashiko-reviews@lists.linux.dev>,
	<kvm@vger.kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
To: Sean Christopherson <seanjc@google.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org>
 <b50b3535-eaa1-4944-914d-0eea8dac0e06@amd.com> <anpwS3C2UIHFz_Uf@google.com>
 <5149127b-32ce-4409-a443-02b5a9600e14@amd.com> <anzsptZlkU4VOKGi@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <anzsptZlkU4VOKGi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a58a5f-6ccc-4bfa-e535-08defc2888a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|6133799003|5023799004|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	gG0ihYAMu1WrquQvPTl7WL/SNcSiIyq/CVm4acj3NqOC0KjPONcAemvGdwyr+uFMuY4MyOyU++xyI+bULzqBBf4wegstdfmVUylGrG44dATWkdtVhnFChejyPsmOngiSSkJ2mDPNMUvgB0AQNzbIh9tEoADOtN9zU7v5kLwOmkXU6rUdnUMC74YMXel9noeIbpRG4xkfZ9faGReOTgfqUMDr4nS4t7M2dB5pqzEyRQLX/N5UMR5vf2TvnmkSmdlvTUPHXRzT9CPYjTBLJObjZ0HBc14Fu3MRo5qLfouWvCTx0OXjGZIQ/5Hc45D76g9dtiKEXbgLaaS2kGeo2x83JoMnvdVAQkpusIBngoHdpGq7CMQc7feCB/VFw+oCpWeI1X81cBPp5js6nATBCBBt1BUNPoSiaXmr4FWtvruOKdEvTyVCKxqIZ0ZCA+ZhzMkKtSDHKZ3Ks93RgPORt67fUvffcu2e+fG+GzD8HhPZ3WvYgxrJ9MMm9wEiOGhr8pMUL0TqS0M1pDBSPI1lmKIpqdZXZTJC+/+GXwNwJM0tna0ssT7XF9GCZWmwYpzQr9zW+eVrX9lyHaGinm0Zgvz/fKtn+BK+dtyuasmREzwfz2xcOAkuo++oa1Csj6DPc2YddcPGI2JW3LaZhWhS9YL6vJWvQ2LvuSCURsyns3rxUEdaLTAOd3EPii+iVHwQl675PWnS4iin0irDaxCsi1MuGA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v8z/UMk8KCcuzPDhAv1w6MWyVWkFn6IGZmpkVrmG0KBw53qwK8+xbJp0gQgx5GvsUhBwnBZiKTOPowGs/MMgTq1jlZXpDDA9HpekQ1wa3izBX1PDdKYJtl3Q6V44M+Q405usEsRLEhZbXbsMx/Kx1H6ABPC+BqVKfwNxjiAsPBlFGBUhQMhOj3KceSfg49YIQ71zmnJDt0T0GEGtBe5g9HvN/+s8MNjrKHIPJlzB1KUF9tYuAJVbY3pry8KHFzm6YKZqTmr4JTkLT5pY2C1VXR9gYwa2a1b9NFU0vbDhPS744UHoqb3EzyqMwcQ+ZoxzUr4UPE3/apq6bV6nm1Ma2wnVpDVpxqxZS1cMWKudAJ9QQ6CNPlwoFFO8TEsAkgvHTO5KmWQLltf/yo6j3AfrkHYZ3cF5HKeJYnEVlmk9F0HR1Tt+54OM8olGigU1FXJ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:26:55.3889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a58a5f-6ccc-4bfa-e535-08defc2888a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354



On 8/13/2026 3:29 AM, Sean Christopherson wrote:
> On Wed, Aug 12, 2026, Sairaj Kodilkar wrote:
>>
>>
>> On 8/11/2026 6:13 AM, Sean Christopherson wrote:
>>> On Mon, Aug 10, 2026, Sairaj Kodilkar wrote:
>>>> On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
>>>>> [Severity: High]
>>>>> Can an unprivileged user-space process trigger this WARN_ON?
>>>>>
>>>>> When a vCPU is created, svm->gappi_cpu is initialized to -1 in
>>>>> avic_init_vcpu(). It is only set to a valid CPU ID later during
>>>>> __avic_vcpu_load().
>>>>>
>>>>> If host user-space configures device interrupt routing via the KVM_IRQFD ioctl
>>>>> before the vCPU runs, avic_pi_update_irte() is invoked. This will pass the
>>>>> uninitialized svm->gappi_cpu (-1) down to this function, hitting the WARN_ON.
>>>>> If the host has panic_on_warn enabled, this allows host userspace to trigger
>>>>> a kernel panic.
>>>>
>>>> This is a valid concern.
>>>>
>>>> If host userspace attaches a bypass IRQ targeting a vCPU that has never
>>>> been loaded. Functionally, there is nothing to do in that window. A vCPU
>>>> that has never been loaded cannot be blocking, so no GAPPI wakeup is
>>>> required. The IOMMU still posts the interrupt into the vAPIC backing
>>>> page, and the pending IRR is evaluated at the first VMRUN after
>>>> avic_vcpu_load(), which is also where the IRTE gets a valid Destination
>>>> and IsRun = 1.
>>>>
>>>> This can be resolved by assigning a arbitrary gappi destination, without
>>>> actually updating the gappi wakeup list of that CPU.
>>>
>>> With the disclaimer that I haven't look super closely at this series, and haven't
>>> thought too deeply about the feature itself either...
>>>
>>> Why are we doing anything different than what VMX does?  vCPUs on the wakeup
>>> list when they block, and come off the list when they wakeup.  It's literally
>>> one flow that's guarantee to pair put()+load(), and the logic for manipulating
>>> the list is quite simple as a result.
>>
>> I was trying to manipulate the vCPU list after is_empty(ir_list) check
>> in put() and load() path. Which complicated the things, since
>> pi_update_irte() will have to add the vCPU to the list if it was a first
>> interrupt assigned to given vCPU.
> 
> No, there are other options.  Specifically, the solution VMX uses is to put the
> vCPU on the wakeup list if it *might* get a posted IRQ.  Again, why reinvent the
> wheel?
>  
>> I think its better to keep the list operations before is_empty(ir_list)
>> check in order to simplify things a little bit.Note that it may increase
>> the list size and potentially increasing time for gappi_wakeup_handler.
>>
>>> Going a step further, why is GAPPI not sharing code with VMX Posted Interupts?
>>> At a glance, the only meaningful difference in the wakeup flow is the "should
>>> this particular vCPU be awakened".
>>
>> On Intel there is a level of indirection: KVM hands the IOMMU the
>> physical address of the PI descriptor once, at IRQ affinity setup time
>> (vmx_pi_update_irte()). After that the descriptor is the only thing that
>> needs updating, so vcpu_load()/vcpu_put() just write NDST/NV/SN in
>> memory and never call into the IOMMU driver again.
>>
>> AMD has no such indirection. The destination APIC ID, IsRun and GATag
>> live directly in the IRTE, and there is no per-vCPU structure that the
>> IOMMU dereferences. So every vcpu_load()/vcpu_put() has to call into the
>> AMD IOMMU driver to update each IRTE targeting the vCPU, via
>> avic_update_iommu_vcpu_affinity() -> amd_iommu_update_ga().
>>
>> That difference leaks into the wakeup list handling. On Intel, putting a
>> vCPU on the per-pCPU list is self-contained. On AMD it has to happen in
>> the same ir_list_lock critical section as the IRTE update, and it is
>> conditional on the vCPU actually having posted IRQs (ir_list being non
>> empty), because the pCPU that the vCPU is enqueued on is also what gets
>> programmed into IRTE[Destination].
> 
> And?  That's literally calling one function from a slightly difference location
> on Intel vs. AMD.  E.g. unless I'm missing something, the handling should be
> something like this, sans actual code movement:
> 
> diff --git arch/x86/kvm/svm/avic.c arch/x86/kvm/svm/avic.c
> index c5b1d294b15a..c9a6da646c8e 100644
> --- arch/x86/kvm/svm/avic.c
> +++ arch/x86/kvm/svm/avic.c
> @@ -1020,6 +1020,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
>  
>         lockdep_assert_held(&svm->ir_list_lock);
>  
> +       if (ga_log_intr && gappi && kvm_can_use_device_posted_irqs(vcpu->kvm))
> +               kvm_pi_enable_wakeup_handler(vcpu);
> +

I am not sure what you mean here, because pi_enable_wakeup_handler does
more than just manipulating the wakeup list, it also updates pi
descriptor which is Intel specific, We have following two options:

Option A:
Adding a new x86_ops

avic_update_iommu_vcpu_affinity
	kvm_pi_enable_wakeup_handler
		list handling
		kvm_x86_callback(configure_pi)
			IOMMU callbacks


The new x86_ops makes sure that irte and pi descriptor are configured
correctly.

Option B:
Common list handling

The svm and vmx will share function for list handling but IRTE/PI setup
code will remain same.

avic_update_iommu_vcpu_affinity/pi_enable_wakeup_handler
	kvm_add_to_wakeup_list
		list handling
	IOMMU callbacks


Thanks
Sairaj

>         /*
>          * Here, we go through the per-vcpu ir_list to update all existing
>          * interrupt remapping table entry targeting this vcpu.
> diff --git arch/x86/kvm/vmx/posted_intr.c arch/x86/kvm/vmx/posted_intr.c
> index 4a6d9a17da23..f6e3fea11baa 100644
> --- arch/x86/kvm/vmx/posted_intr.c
> +++ arch/x86/kvm/vmx/posted_intr.c
> @@ -144,7 +144,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
>                 pi_set_on(pi_desc);
>  }
>  
> -static bool vmx_can_use_vtd_pi(struct kvm *kvm)
> +static bool kvm_can_use_device_posted_irqs(struct kvm *kvm)
>  {
>         /*
>          * Note, reading the number of possible bypass IRQs can race with a
> @@ -217,7 +217,7 @@ static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vcpu)
>          * back to the pi_wakeup_handler() function.
>          */
>         return (vmx_can_use_ipiv(vcpu) && !is_td_vcpu(vcpu)) ||
> -               vmx_can_use_vtd_pi(vcpu->kvm);
> +               kvm_can_use_device_posted_irqs(vcpu->kvm);
>  }
>  
>  void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
> @@ -242,7 +242,7 @@ void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
>         if (!vcpu->preempted && kvm_vcpu_is_blocking(vcpu) &&
>             ((is_td_vcpu(vcpu) && tdx_interrupt_allowed(vcpu)) ||
>              (!is_td_vcpu(vcpu) && !vmx_interrupt_blocked(vcpu))))
> -               pi_enable_wakeup_handler(vcpu);
> +               kvm_pi_enable_wakeup_handler(vcpu);
>         else
>                 pi_set_sn(pi_desc);
>  }

