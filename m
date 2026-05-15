Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8833FF8A1
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833726; cv=none; b=C73e30XZ/ELVbnVxtrROD1aw0ZuGGWC3gSrSlZZijl3FAnxrEmZIq4r6+ZXAL/mxvHHsPqsgM7IzT1VrZoG9olpv7cjBySq3ebRk/Vizqo3GwCRX0WQlGucwJUlbHsjrjgFtAjVdYuApZhip8UzgK9//LY+qqc9vIwRNDWDIZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833726; c=relaxed/simple;
	bh=VjM1sDIwoUP6qi68BiA3PqSUNQtFlaJkLbn2w6NF95w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6HDKJKj7+x/gDtxBkgbSrE9RWXIufXfJS+Sln3sF/tQSaD+mMctY8Nvzo6ZKYessYquQaPoyA/+o+dDF+Rvl/WCcWawk5UlhF7HL+TcI+bqD12Q118HWqKifrEXwlZC3/NNNkQlWll3Xf9t3xsbrO7wf8vrsOyvBtxC1xYYeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BatIa1gc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BatIa1gc"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44509921fbcso4554477f8f.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778833722; x=1779438522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9sH8Q4QjX83trp+YQQ6QbWlIhiR2CnSj4K2FVOvEtA=;
        b=BatIa1gcYN/3Pq5VcVtdUgifJqGYkH8EXs7wEMcfSL5IljTl4Cq1uQ2lk5wehbA5wQ
         fOyx3eOCodmJtBRnZUZXu8b+pGptsXS773Mpx7zjWj0pEUpMeppRDVqGRff3f6YetNs9
         kVzjkgM/aEupCWlq/JPLJ3/ywwVhAz4rsqdW0X5STQaZn2LxO/ZMR/1fQn4rFL77YYyS
         Rfi/+H4+GfeI28z9Sx7yqZdKnuQN9+DC/9tk6ZotXzT7aQiJPla3Yj6He/gufKrYl+6Y
         NvpY+Cmwi5jaYfiVPnDRM/pNSeyzQm32GRCLxRRLEVIJcaFtIK/XBOlhooiKqCgWJP6D
         S0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833722; x=1779438522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9sH8Q4QjX83trp+YQQ6QbWlIhiR2CnSj4K2FVOvEtA=;
        b=ajwpILASLTEBiVDyhh9ktcuzlbxYfoNYqoqT+OuQ7OGBf6oLtLS3V12HvTAbxjBou+
         VskGmlxvF2DhS/tm2/JBxUP+sZiMtLnlTSn6liKBr29CHXdZnocwJLMl7gVI3FfTOKsN
         w9gpvpZj+9q4tI51TJYT1ogz2UTFD1xwIZeKzZG1lPXzGqHMNIrGyWHf4krR0d7ua/rI
         cVCRV4ZJsHds1MJYPZ8QiZHR5AhTwStGaduw6RpCw/TswqXvoU/dgXZZ3tA3V2K8TQHf
         YGDueQd2no23h8D1G01+DXa+4ayMtMNKc4TXQhbaIVBRjjkwlHELv+67afPsQCT9sdvc
         tkBw==
X-Forwarded-Encrypted: i=1; AFNElJ+kYeSrpT59y6ITsBtFpIcbK1yzYrSVfME1HSf0xw+8R/ER4Sj3dez/+sOEK7Hn/vQYRxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUS5E4Vzi9cZaS1zoNy0pLoaDCzWKFrvjTG+LgL4tfiu9fz+9
	G0KoM8K43BXKJZ4EQEmdSBLzVCTGf5YR0AOcHUrtsfUmxvdWG37MNBJHFWNwaAMj+O8=
X-Gm-Gg: Acq92OEhm1lrGB8ERLhpjjE9cn1r9ZxY8+HC690vPOOMDMAkyUyzQHthlV91R22WNS3
	IjHyMVw7I2PuG0kWUDMU2z1puZvw7Ydt9ghujgr/mTBcUH1yydcFWO526baxxjg8v+78likfvHa
	HQNSwMKgzKAJgnZqPKv+kqsLgj8ag5KX+7ThhEAE2jQAs79eou2gUHCN6/jlZKFwZFDSetkltc2
	Emzy5iwDzL1PghfULPwtwfEk7N1BtGbqCP0GZEfi7/4Afm/FWYJkbx2LY8eVcpL8JDhRWE/OuWy
	bfLxjyfqjkVaUIGKcZ52DxaUEdFRR3wUB2W8RLK4SyLbqf/Qo9uHhcuFEt+Xg+xFWddvO43eHU4
	wY0SrMwYHQKPqsAP6y7aj+B80yLKzKoS4ZtnAo9xrNNzV5voORlU17ivokdcGcQxrryN2jYcIs2
	EyzYRTLt7VqTyu5gqVTcs5xlKCuk6k
X-Received: by 2002:a05:6000:1787:b0:455:fbb:28bb with SMTP id ffacd0b85a97d-45e5c5dd6famr3551750f8f.35.1778833722379;
        Fri, 15 May 2026 01:28:42 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19c2dsm12770884f8f.21.2026.05.15.01.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 01:28:41 -0700 (PDT)
Message-ID: <c7a68965-88e5-4808-9a75-d58c4986a3b6@linaro.org>
Date: Fri, 15 May 2026 09:28:40 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/20] KVM: arm64: Apply dynamic guest counter
 reservations
To: Colton Lewis <coltonlewis@google.com>
Cc: alexandru.elisei@arm.com, pbonzini@redhat.com, corbet@lwn.net,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org
References: <gsntlddlbylw.fsf@coltonlewis-kvm.c.googlers.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <gsntlddlbylw.fsf@coltonlewis-kvm.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/05/2026 8:05 pm, Colton Lewis wrote:
> James Clark <james.clark@linaro.org> writes:
> 
>> On 13/05/2026 5:45 pm, Colton Lewis wrote:
>>> James Clark <james.clark@linaro.org> writes:
> 
>>>> On 04/05/2026 10:18 pm, Colton Lewis wrote:
>>>>> Apply dynamic guest counter reservations by checking if the requested
>>>>> guest mask collides with any events the host has scheduled and calling
>>>>> pmu_perf_resched_update() with a hook that updates the mask of
>>>>> available counters in between schedule out and schedule in.
> 
>>>>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>>>>> ---
>>>>>    arch/arm64/kvm/pmu-direct.c  | 69 ++++++++++++++++++++++++++++++++
>>>>> ++++
>>>>>    include/linux/perf/arm_pmu.h |  1 +
>>>>>    2 files changed, 70 insertions(+)
> 
>>>>> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
>>>>> index 2252d3b905db9..14cc419dbafad 100644
>>>>> --- a/arch/arm64/kvm/pmu-direct.c
>>>>> +++ b/arch/arm64/kvm/pmu-direct.c
>>>>> @@ -100,6 +100,73 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
>>>>>        return *host_data_ptr(nr_event_counters);
>>>>>    }
> 
>>>>> +/* Callback to update counter mask between perf scheduling */
>>>>> +static void kvm_pmu_update_mask(struct pmu *pmu, void *data)
>>>>> +{
>>>>> +    struct arm_pmu *arm_pmu = to_arm_pmu(pmu);
>>>>> +    unsigned long *new_mask = data;
>>>>> +
>>>>> +    bitmap_copy(arm_pmu->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * kvm_pmu_set_guest_counters() - Handle dynamic counter reservations
>>>>> + * @cpu_pmu: struct arm_pmu to potentially modify
>>>>> + * @guest_mask: new guest mask for the pmu
>>>>> + *
>>>>> + * Check if guest counters will interfere with current host events 
>>>>> and
>>>>> + * call into perf_pmu_resched_update if a reschedule is required.
>>>>> + */
>>>>> +static void kvm_pmu_set_guest_counters(struct arm_pmu *cpu_pmu, u64
>>>>> guest_mask)
>>>>> +{
>>>>> +    struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
>>>>> +    DECLARE_BITMAP(guest_bitmap, ARMPMU_MAX_HWEVENTS);
>>>>> +    DECLARE_BITMAP(new_mask, ARMPMU_MAX_HWEVENTS);
>>>>> +    bool need_resched = false;
>>>>> +
>>>>> +    bitmap_from_arr64(guest_bitmap, &guest_mask, 
>>>>> ARMPMU_MAX_HWEVENTS);
>>>>> +    bitmap_copy(new_mask, cpu_pmu->hw_cntr_mask, 
>>>>> ARMPMU_MAX_HWEVENTS);
>>>>> +
>>>>> +    if (guest_mask) {
>>>>> +        /* Subtract guest counters from available host mask */
>>>>> +        bitmap_andnot(new_mask, new_mask, guest_bitmap,
>>>>> ARMPMU_MAX_HWEVENTS);
>>>>> +
>>>>> +        /* Did we collide with an active host event? */
>>>>> +        if (bitmap_intersects(cpuc->used_mask, guest_bitmap,
>>>>> ARMPMU_MAX_HWEVENTS)) {
>>>>> +            int idx;
>>>>> +
>>>>> +            need_resched = true;
>>>>> +            cpuc->host_squeezed = true;
>>>>> +
>>>>> +            /* Look for pinned events that are about to be 
>>>>> preempted */
>>>>> +            for_each_set_bit(idx, guest_bitmap, 
>>>>> ARMPMU_MAX_HWEVENTS) {
>>>>> +                if (test_bit(idx, cpuc->used_mask) && cpuc-
>>>>> >events[idx] &&
>>>>> +                    cpuc->events[idx]->attr.pinned) {
>>>>> +                    pr_warn_ratelimited("perf: Pinned host event
>>>>> squeezed out by KVM guest PMU partition\n");
> 
>>>> Hi Colton,
> 
>>>> I get "perf: Pinned host event squeezed out by KVM guest PMU partition"
>>>> even with arm_pmuv3.reserved_host_counters=3 for example. I would have
>>>> expected any non zero value to stop the warning.
> 
>>>> I think armv8pmu_get_single_idx() needs to be changed to allocate from
>>>> the high end host counters first. A more complicated option would be
>>>> checking to see if there are any non-pinned counters in the host
>>>> reserved half when a new pinned counter is opened, then swapping the
>>>> places of the new pinned and existing non-pinned counters so pinned
>>>> always prefer being put into the host half. But it's probably not worth
>>>> doing that.
> 
>>>> James
> 
> 
>>> I agree it makes the most sense to allocate from the top, but I'm happy
>>> the basic idea works.
> 
> 
>> Another thing I forgot to mention is that even with the ratelimited
>> warning, this spams the logs any time the host and guest are both using
>> the PMU and I'm not sure how useful that is.
> 
> I'm sure it does. I'll delete it.
> 

A warn_once might save someone a few hours of debugging, but we probably 
don't need more than that.

>>>>> +                    break;
>>>>> +                }
>>>>> +            }
>>>>> +        }
>>>>> +    } else {
>>>>> +        /*
>>>>> +         * Restoring to hw_cntr_mask.
>>>>> +         * Only resched if we previously squeezed an event.
>>>>> +         */
>>>>> +        if (cpuc->host_squeezed) {
>>>>> +            need_resched = true;
>>>>> +            cpuc->host_squeezed = false;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (need_resched) {
>>>>> +        /* Collision: run full perf reschedule */
>>>>> +        perf_pmu_resched_update(&cpu_pmu->pmu, kvm_pmu_update_mask,
>>>>> new_mask);
>>>>> +    } else {
>>>>> +        /* Host was never using guest counters anyway */
>>>>> +        bitmap_copy(cpu_pmu->cntr_mask, new_mask, 
>>>>> ARMPMU_MAX_HWEVENTS);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>    /**
>>>>>     * kvm_pmu_host_counter_mask() - Compute bitmask of host-reserved
>>>>> counters
>>>>>     * @pmu: Pointer to arm_pmu struct
>>>>> @@ -218,6 +285,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
> 
>>>>>        pmu = vcpu->kvm->arch.arm_pmu;
>>>>>        guest_counters = kvm_pmu_guest_counter_mask(pmu);
>>>>> +    kvm_pmu_set_guest_counters(pmu, guest_counters);
>>>>>        kvm_pmu_apply_event_filter(vcpu);
> 
>>>>>        for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
>>>>> @@ -319,5 +387,6 @@ void kvm_pmu_put(struct kvm_vcpu *vcpu)
>>>>>        val = read_sysreg(pmintenset_el1);
>>>>>        __vcpu_assign_sys_reg(vcpu, PMINTENSET_EL1, val & mask);
> 
>>>>> +    kvm_pmu_set_guest_counters(pmu, 0);
>>>>>        preempt_enable();
>>>>>    }
>>>>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/ 
>>>>> arm_pmu.h
>>>>> index f7b000bb3eca8..63f88fec5e80f 100644
>>>>> --- a/include/linux/perf/arm_pmu.h
>>>>> +++ b/include/linux/perf/arm_pmu.h
>>>>> @@ -75,6 +75,7 @@ struct pmu_hw_events {
> 
>>>>>        /* Active events requesting branch records */
>>>>>        unsigned int        branch_users;
>>>>> +    bool host_squeezed;
>>>>>    };
> 
>>>>>    enum armpmu_attr_groups {

