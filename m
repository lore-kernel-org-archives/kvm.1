Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42593783D5
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324071; cv=none; b=jopth76dRMd4RZglYmF1aGUtM7pzTg78ct6cqXz20kIESOSKiZBxSYvLwxUBtZWkUbl5TuA10sbLNtbpCeAUnsF+D1DBi/v7zkWsLlrW6pPLYBY0ITNFfeE1By+ywEi/HandbfUfC0nyTV2C3GPwCjGbr6rcIyKaSIra+z9rQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324071; c=relaxed/simple;
	bh=naWDN0pyZLWNc93EvdZ1r5h5QJkl363qtBoJNanvnAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvo6xiJab0vszZ5vQbo6Z/BjWp6LRRCYssjQgZzvHTUoaHsqpqtqMGlj1otuL5TiQUu/ljmUPv41FHFP2pbDIsuHXgAmSUpAmtfZHzlaJ050iTxpJRd2Uu6elPgxLhgnSfC+tEKn1wajy17SCxXvHsULo5BepBLMQj6JdQDO3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0lU3OQB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=or+hivlm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0lU3OQB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="or+hivlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791324068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX1nDoHfY9wIaK7n+kTY5G9GqR52mFVKGv7vDMVDhYE=;
	b=X0lU3OQBohx+0Z3dE0ZwlXL7oCCQq03cSQz7fgrNca0NIQLnj7BsBLDGZ2FNM+5GRXq240
	YYU/DdZmkXPLwb8CGdfQWZ+Lsjjf5X9fwK3Q5l3VTkM8r7x6BzkR3LYGYwc2K+18ptCpj6
	Bzt37KvggLGkddwafzrjM5mntUdlz7Y=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-of3kdfV5NPm2G3UY34pGKA-1; Tue, 06 Oct 2026 18:01:06 -0400
X-MC-Unique: of3kdfV5NPm2G3UY34pGKA-1
X-Mimecast-MFC-AGG-ID: of3kdfV5NPm2G3UY34pGKA_1791324065
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14fed306427so12096443c88.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791324065; x=1791928865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BX1nDoHfY9wIaK7n+kTY5G9GqR52mFVKGv7vDMVDhYE=;
        b=or+hivlmbAGGysnowcr8WUnjhpaVD+dWjpgoh5Vmx0U3FaJu/iVrNxofFRxPe6bcfX
         Fme/Y9fPGSRSh7pi7dM+glSFFbnWtk46RB9+kpNBX1LaP86v/hqqw/oWN7Uv3OIZl7s5
         qC9s6l7L1OI8luMdXnUts2ueaBdVbPPsRB/zUUb1yl+2mBIHLXKfesnaHYDtUoKcp5vb
         rbv4cnGhu0wQs4/Hi2HIYLlSNKtm9HQuFZJUmuL2HpeGkY6h3uZplawyZj9INGj91ABr
         1wJvWPHQUjibrAWjTBUyb8Rwbza8tDTWIfp5vcipSzNAsfxRv5XHzb2yMz24Avm+K+gc
         jKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324065; x=1791928865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BX1nDoHfY9wIaK7n+kTY5G9GqR52mFVKGv7vDMVDhYE=;
        b=Af8ZFEvS16GqrYQtz47/P6K6sFxG0dQ8yj99wT0YLT022cTbwWAit6B4X3ujsE7w8Z
         gaflt/TBQXN3xaeZEML7Nx/6wq3DA1CLSYuIPmL9vsZjhOGc4gd08jvSutk+46lXkGUb
         PokTe0Y+QlmCetU/oXcBAOEixcxUaOvS8wP6IexqjPlY0smrPNQCFKkFln1WeBjAnT7q
         8oyw4nG03Gqg0zcNO53TXCZSEfdGL/H4wecPAdWJF8IFjUSaC2eoQRdrFO8QZDoPcVR6
         v6vFa2xq2c+9PkVcTlVRwU+3H0fnJyyG3Zq1FeGvNmFeV0p8DRl/gluFOA23jh2TTfH6
         +1Bw==
X-Forwarded-Encrypted: i=1; AKwUvByuHirYgUsHKb4OXVwE1iurKDyWKjIDJlmLDscjDd+uCH9QXClrRk5ETZf4x5HqPsZ+30I=@vger.kernel.org
X-Gm-Message-State: AFuF++kt/tPHk1cdJHZCv8zjqbzcx8U2XeLBCBYCZjva+DgQ0jPSp/9Y
	ioRILbDPAnzK8RzOItN++qVf2l5ArRU3zT+nJ7ORLrXgpVbf0ff5ypnrg7fzNLZpNs7iaoXNVli
	bqgvZA2NG9cKipfZrtkiPkypM3NIvdI2ZZdzD7mnTD/2shGlbUob1ow==
X-Gm-Gg: AYBFou1NVCS4zgQf66Y7O5fRsGrjFdgOoJbVuUNOlu32c885Tnxz2JG4XYhQ66lPsYB
	GSqoh5HYfXtlkzQ3tGRNXosSS0AZDk/5iXqXQByUaPNehSOzOpuiY0hvFmEm+mmuhxF1cDla1Cw
	DJ0NP7bl2EfU9SDSE/tsfDi7XRSt+7yEPZ+Grwcu9wZGnsVXvwp7F5WJUDjryfaAexaawFr2X7v
	+2D1NL9AmePEyR5sz2swTwyb9ez5T5LBR29xfAThusy/7ZbA8HWZzsIyoVrQaFDGGcfzH+BJXS7
	7Pce65Dl4H5yolmRKVgg7Cw+ppgYi42BlZ/9C8tBJBlppB/Bd41bbf0RkEn20YDX7dlYSvGARsL
	mKdQiqBwTH5ZUEdbKUt/pq8hh5y6Kas4IF4gbxFCjHw==
X-Received: by 2002:a05:701b:2618:b0:145:7a:7765 with SMTP id a92af1059eb24-162092950d9mr130466c88.36.1791324064790;
        Tue, 06 Oct 2026 15:01:04 -0700 (PDT)
X-Received: by 2002:a05:701b:2618:b0:145:7a:7765 with SMTP id a92af1059eb24-162092950d9mr130376c88.36.1791324062351;
        Tue, 06 Oct 2026 15:01:02 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16167463910sm1401330c88.9.2026.10.06.15.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 15:01:01 -0700 (PDT)
Message-ID: <e854517f-b364-4c64-b542-7546afadbda3@redhat.com>
Date: Wed, 7 Oct 2026 08:00:45 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 23/23] KVM: arm64: CCA: Control user register access
 for Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-24-suzuki.poulose@arm.com>
 <52e3e45a-751e-40b2-8dd3-3db589ddebee@redhat.com>
 <7b6ed626-eca4-41f2-ae56-0af59a931b29@arm.com>
 <6bd785aa-4693-407d-b70a-39b1d0eda63e@redhat.com>
 <71ceb680-e168-450e-99e0-7a8cf4160bba@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <71ceb680-e168-450e-99e0-7a8cf4160bba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/26 10:36 PM, Suzuki K Poulose wrote:
> On 06/10/2026 07:16, Gavin Shan wrote:
>> On 10/6/26 4:01 PM, Suzuki K Poulose wrote:
>>> On 06/10/2026 06:47, Gavin Shan wrote:
>>>> On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
>>>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>>
>>>>> The RMM restricts the access to the register states that the host can
>>>>> read/modify for a given Realm.
>>>>>
>>>>> e.g., At VCPU creation, can modify GPRS (x0-x30) and PC.
>>>>>        While servicing SMCCC calls via RSI_HOST_CALL or servicing PSCI
>>>>>        requests.
>>>>>        MMIO emulation in the unprotected space.
>>>>>
>>>>> Additionally we use the sysreg configuration to advertise/configure the
>>>>> following Realm parameters, which are required before the Realm Descriptor
>>>>> is created:
>>>>>   - SVE Vector Length
>>>>>   - Number of HW Breakpoints/Watchpoints
>>>>>   - PMU Counters.
>>>>>
>>>>> Thus KVM also additionally allows access to ID_AA64DFR0_EL1 and SVE_VLS for
>>>>> the configuration of Realm creation parameters. We don't support PMUs for
>>>>> the Realm VMs yet, so PMCR is not exposed.
>>>>>
>>>>> The RMM makes similar restrictions for reading of the guest's registers
>>>>> (this is *confidential* compute after all), however we don't impose the
>>>>> restriction here. This allows the VMM to read (stale) values from the
>>>>> registers which might be useful to read back the initial values even if
>>>>> the RMM doesn't provide the latest version. For migration of a realm VM,
>>>>> a new interface will be needed so that the VMM can receive an
>>>>> (encrypted) blob of the VM's state.
>>>>>
>>>>> Reflect the above in KVM_GET_REG_LIST, KVM_SET_ONE_REG calls.
>>>
>>>>>   static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
>>>>>   {
>>>>>       int size;
>>>>> @@ -553,6 +572,9 @@ static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
>>>>>           u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
>>>>>           int size = core_reg_size_from_offset(vcpu, i);
>>>>> +        if (vcpu_is_rec(vcpu) && !kvm_realm_validate_core_reg(i))
>>>>> +            continue;
>>>>> +
>>>>>           if (size < 0)
>>>>>               continue;
>>>>> @@ -598,6 +620,9 @@ static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
>>>>>       if (!vcpu_has_sve(vcpu))
>>>>>           return 0;
>>>>> +    if (kvm_vm_is_realm(vcpu->kvm))
>>>>> +        return 1; /* KVM_REG_ARM64_SVE_VLS */
>>>>> +
> 
> This could be vcpu_is_rec().

vcpu_is_rec() is preferred here.

>>>>>       if (!kvm_arm_vcpu_sve_finalized(vcpu))
>>>>>           return 1; /* KVM_REG_ARM64_SVE_VLS */
>>>>>
>>>>
>>>> Aren't above two checks conflicting to each other?
>>>
>>> Do they? We allow SVE_VLS only for the Realms and we allow that
>>> before the vCPUs are finalized. For normal VMs, depending on
>>> whether the vcpus are finalized, we either send 1 or the full list.
>>>
>>
>> num_sve_regs() can be called for 3 cases: (a) non-finalized RECs; (b) finalized
>> RECs; (c) Other finalized vCPUs, correct? "if (kvm_vm_is_realm(vcpu-  >kvm))", which
>> would be "if (vcpu_is_rec(vcpu))", covers (a) and (b). We needn't the excessive
>> check "if (!kvm_arm_vcpu_sve_finalized(vcpu))". So the check would be something
>> as below after this series is applied:
>>
>>      /*
>>       * KVM_REG_ARM64_SVE_VLS is visible on realm vCPU no matter if it
>>       * has been finalized.
>>       */
>>      if (vcpu_is_rec(vcpu))
>>          return 1;
>>
>> This check "if (vcpu_is_rec(vcpu))" belongs to PATCH[22]. Hope I make myself
>> clear this time :)
> 
> Sure, these two patches are closely related and may be even could be
> folded in. I split it out to make it easier to review.
> 
> 22: Allow exposing SVE_VLS for unfinalized VCPU RECs
> 23: Control register accesses includingthe SVE_VLS, but prevent
> everything else
> 
> Does it help ?
> 

I would suggest to fold PATCH[22] into PATCH[23].

Thanks,
Gavin

> Cheers
> Suzuki
> 
> 
>>
>>>>
>>>>> @@ -625,6 +650,10 @@ static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu,
>>>>>           return -EFAULT;
>>>>>       ++num_regs;
>>>>> +    /* For Realms only support SVE_VLS */
>>>>> +    if (kvm_vm_is_realm(vcpu->kvm))
>>>>> +        return num_regs;
>>>>> +
>>>>>       if (!kvm_arm_vcpu_sve_finalized(vcpu))
>>>>>           return num_regs;
>>>>
>>>> Same question here.
>>>
>>> As above.
>>>
>>> Suzuki
>>
>> Thanks,
>> Gavin
>>
> 

