Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D43254AE
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320343; cv=none; b=rjn28eJFcGVByy6GM3SQt/lXndU+PUkn/AkgnimS4p2ombzWiEEM54LxVXDdG0NjG0TcIUtS/GrF/eNM5pTLXxWAArZ4iNnA1ouX1nLFwP17O6X+ePZph+F7FFWcNBqSpvsrdPYf3LPdnHgUmRLi3ghA9Gle44UZvGamdbYrma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320343; c=relaxed/simple;
	bh=/ZPuMKdYiSpLFDDj6KBd5YfXG9RrVJ/W8yRsczFgpRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdGyEf43frGHAJIAWmnyCxmsUk1bdbHpSoToPzxkb+TVc/EXL0lOr2DLf1zlOcElIy9DGXeD/LtiTolPnvmdNDNEiZayAKXy4iFevsfaJmu8FgY1rlmH39d1CfEBaUqCzpCsS6TVt7UQ8Aiy7mjIfQvW9XSJiEWpqDAs04Q/PnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4LzxSVn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4LzxSVn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso9581075e9.3
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320340; x=1787925140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKNX+Kx6HqLYYsW8IMt0XRzUyioNItYEZfBrRy9B9xA=;
        b=H4LzxSVngeAf3Wh0ntJxuV9qFGOkoRFpRooSksCwHqjuJDYqnQ79/JGg1lfifQu3P9
         Jh7H7YZ5oRo9GdYiqJliqxwuAcZC3tKe8vg48Ijx6whEIxRkO8T+1cpXIos7PGD9wGXy
         49CeUASa1xwLV+bCUpU6jnZ8+OsAntGpbhD1+NTYmvdjcnRc/lXDKr6dRvIcCVsf7ewh
         gMZl3nxsHWFBzUBlCTo02ArYRnWX/LEDAT2NjCau96tQgSlCNiin1mmYUcfLLFLR68fx
         NMfMpn0Ds8kX3cxPbPGEr3c83icZq1IsVfsVvCeMJQJCPqGO5KDet6+fxkD6m8bxXxPV
         Q3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320340; x=1787925140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RKNX+Kx6HqLYYsW8IMt0XRzUyioNItYEZfBrRy9B9xA=;
        b=eBjCyWoz2tGRSZkdSEOEx1mLADX2kQGjp56aPwri+z5RXCgL3AEgj6kFEb0px9E+S+
         VTZ76Ik//l60HiUmRqqG2rigjmpg8amgiKnaBi+3WJdZNNU5oxixbtCW6NNpxkv20xps
         MtlzNwLm8Ld56E/NdhEuG158fSvU4eAdtCyXyxiV/NXQKXxE3jO7gsjUNw6AD9L7MN9B
         qxi0f2UgxgV24HpRzGHrEGNWkrhgOXQTheJSdQrrxY5qLs/gqfBYUkptnZ1mUwVBiLAQ
         0rnGM/F45VlttJFudpm2+o0N+FUb/1rhDx1fJQeNfMDlFRUojJjPF8da2hdAsM3X0Ik7
         9AgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUFJ8Qnn1CPVWLORPGnitfp/8H18xvDrvolu8RMX2ZAvmkEss6DP3wqesgb8IKkykEUro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5X1ZwFL4b0r5KKykA9S1AwhHycA+BBci/bchR3tqZH0piNath
	aqIVuSo8TkXdPEi3WZtMvO88EKXf1ssjk9wTbYdXW2R60D+2MZ6M3FTP
X-Gm-Gg: AR+sD13NUZfHmm1y5Yy38CDomc9uHozVhVsHKr17ALrWuKE+Ov4vtX/wJokvb91drnH
	hsShf2xaYddPRyCqsFGTEFAANOG0ZAzDzEcW9qI2e0uTouN6acfqWBswrZyba2vI4vC4orXzv5w
	SViFZQoCd1/iELMZ9C6DJqfU+XzrKM0mJH1Z2Lwn7incSukJLWMPQSF0+5flTpWcTMrWFZbF9w4
	xCBRGK/ddwHQszOMxdrIcGNVa7n9JvyO3K6/QyNEgnTvspZZDRjRu4C6XpN18FcWoRdk2cJR3U2
	A3NXQDfkByfh4r9VJ56pJWf4l3Hvn1AZdFv2TtZcKMmLOMete/E2/WEWE9TK/Ja9dNRrlv/OjVm
	+ThkMEoivSRsI7jcUfnP4ZKci5WBhlKghQU7bulYjtdVQToTFNnIGaM6vZZvjaMZ+xNM2eA0p6U
	oUeC0droeayUbC4B3SxPQrmpACv8QhlhaeSjR+mv9x8tVECrOduzjIO06HRxCT9PkIN93aDqEoT
	3fq
X-Received: by 2002:a05:600c:a087:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-499b8324b09mr117557705e9.4.1787320339715;
        Fri, 21 Aug 2026 06:52:19 -0700 (PDT)
Received: from [10.45.28.226] ([15.248.3.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b80a5sm17753598f8f.24.2026.08.21.06.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:52:19 -0700 (PDT)
Message-ID: <0365d77d-616b-47f7-a5f2-3388bad692a1@gmail.com>
Date: Fri, 21 Aug 2026 14:52:17 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] KVM: arm64: Add pre_fault_memory implementation
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com,
 joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, corbet@lwn.net, vladimir.murzin@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 isaku.yamahata@intel.com, Jack Thomson <jackabt@amazon.com>
References: <20260612162354.73378-1-jackabt.amazon@gmail.com>
 <20260612162354.73378-3-jackabt.amazon@gmail.com> <alEXtW7w-rqlNG09@raptor>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <alEXtW7w-rqlNG09@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 10/07/2026 5:03 pm, Alexandru Elisei wrote:
>> +	unsigned long		*page_size;
> 
> As far as I know, fault handling was reworked to use struct
> kvm_s2_fault_desc to store the fault information that user_mem_abort()
> needs to handle the fault.  Adding a 'page_size' field, that represents the
> result of the gpa mapping process, might not be desirable.
> 

Yeah agreed, Vincent suggested a separate output struct that
kvm_s2_fault_map() fills with what was actually mapped. I'll do that in
v6 thanks!

>> +	struct kvm_vcpu_fault_info *fault_info = &vcpu->arch.fault;
>> +	struct kvm_vcpu_fault_info fault_backup = *fault_info;
> 
> I'm not sure you need to make a backup here. vcpu->arch.fault is populated
> each time the CPU takes a fault.
> 

So this was actually flagged up by sashiko when I ran it before
submission, it suggested handling this for the case in which the vCPU
exited for MMIO, the next KVM_RUN calls kvm_handle_mmio_return which
uses the vcu->arch.fault.esr_el2. I'll add some comments to this maybe
to explain why this would be needed.

>> +	if (memslot->flags & KVM_MEMSLOT_INVALID) {
> 
> I don't think that's something we should care about, the flag can be set
> immediately after the check as the function doesn't take kvm->slots_lock.
> kvm_vcpu_prefault_memory() takes the srcu lock in read mode, so the
> function is safe to run even if userspace does something silly like
> deleting a memslot at the same time that it's prefaulting the guest memory
> it represents.

I was there not as much for safety, but rather to pick up that error.
This way rather than userspace getting an -EFAULT it can just retry.
This is the same way it is handled in x86 as well.

> 
> It might not be obvious, but taking kvm->mmu_lock in read mode does not
> guarantee that gpa will be mapped when kvm_pgtable_get_leaf() returns.
> That's because a concurrent kvm_pgtable_stage2_map() for a different gpa
> can destroy the mapping of the current gpa.
[ ... ]
> The kvm->mmu_lock is dropped here, which means that it is possible for a
> MMU notifier callback to have just unmapped the entire stage 2 for the VM.
> 

Yeah as we mentioned in the other thread, this is best effort and we
can't guarantee that is survives the return. We do this for forward
progression, reporting the correct advance size for ranges which are
already mapped, instead of repeating the full dance for every page of them.

> 
> handle_access_fault() will fail if the mapping is gone. But I guess that's
> fine if the ioctl does not guarantee that memory is still mapped after it
> completes.


Yeah I think it's fine and will degrade to a no-op in this case.

> 
> Also, the documentation that this patch adds says: 'On arm64, newly created
> stage-2 PTEs are marked Accessed'. Does not say anything about marking
> **existing** ptes as accessed. Would be useful to explain the code does it.
> 

Ack, will do thanks!

>> +		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
> 
> There's gfn_to_hva_memslot(memslot, gfn), is that what you are looking for?
> 

I think gfn_to_hva_memslot() resolves the hva for write, so would fail
on KVM_MEM_READONLY slots, and prefualting is a read. Also this mirrors
the guest abort path so matches the way the run path resolves the HVA.

-- 
Thanks,
Jack
