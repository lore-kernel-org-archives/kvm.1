Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996F3769E6
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267841; cv=none; b=oWweVtPWo+m7kduzTiP8pL5RWk7oo/x08JmK37WKiAgLGnXhfgUMm893TpoVlrh7HP6BiBlzM230aia9rW2OwXeQt/2UTT5kpZdRhdD0qrfNHtWtWKIqkGMOKExSKxUci1ZfRq2MNWJ0XT2hwfLgYjeKSBxuah8mj5+kZ0CKiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267841; c=relaxed/simple;
	bh=SMeDTIX8jSBWXiQnBBwSiyWPRzAqbGBsla0efRqXLEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krN2kD1WQoO9tLc538BZpNPLUeceIRqgC9geEYSJDVgAD6tGdN8y27keIXyyqYgMuBFzvT05g/D5AKLpLSyz7RujQReF6+F9C8ZSkRTObpZrKf24MfM4Rpt2PZEWey17q52B0gvun+iig2SQmorn96xwBoG9r70dZXlBjKMqcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+525Zx7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhWzaHt6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+525Zx7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhWzaHt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791267837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLLq1R13uyDoTfMnvHZDH/2dbxOMckf2plTOpZS7OhQ=;
	b=d+525Zx7h/e+KpJVNOOAPUkoMx0+Y+i3LIadOdKs8TpdkroQ2E2Ub/evfGQa4h6wjrU/XI
	ZivwCuzVEWoW2StqVvHxcArRMgLT2yVOWa5pngfIUkbo3k7ZmhNy0pPBCYUQJ8oNlbjR3w
	VMXDHzeCwPViPeKBDq8raqFYrBg8P7s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-A0xEYfG0OqyubIOI6Q0HZg-1; Tue, 06 Oct 2026 02:23:55 -0400
X-MC-Unique: A0xEYfG0OqyubIOI6Q0HZg-1
X-Mimecast-MFC-AGG-ID: A0xEYfG0OqyubIOI6Q0HZg_1791267835
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so468096a12.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791267835; x=1791872635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLLq1R13uyDoTfMnvHZDH/2dbxOMckf2plTOpZS7OhQ=;
        b=WhWzaHt6g8uvg7CQ+7kCadvuQ9mX19Hb2OPZ+xguSx5xuAVVSwLzWIIxxPnfWugtvl
         N7x8iZXvJLDFqnXhXWbIbRDBD7d2c3CrX9/+J38d+sL9v47tS3SRA7rwk+NUr8ySobhS
         TSxeeYiXBKTBd18GAPv1EIS5wbw2Lthbb58h046q0XzTF0m+n6FyXaDOJ9X8vL+DqCiE
         hA1HN7I0/R4sbRxJlmY5Pkf6EaIFEpULIiZszOZBjpm2tzQOl4QwcVWzFt/1F2L7t8+C
         w1LMrJwRQu6mEPM8O+zEU/jYt2hb5ED81Z7gX53zqEQmkoVzxnSKiA2aVEOeoFsc36iD
         HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267835; x=1791872635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLLq1R13uyDoTfMnvHZDH/2dbxOMckf2plTOpZS7OhQ=;
        b=vQk3JluPpb5yYgKvHB87dNVrp3h+D7NyzQz6Z8x/WNZequWQQL2wLJoTUzpeqnT53+
         QXgF3B67ht2qNEk+/QjJ/xmiVrXlNgyHB0VQadIqZDRbFkMKKUiLakHL3ruhYY/YVNOL
         e3VFx26ghiObNttENXgMYA8dAdSSOy//RzPjBp22BRm6N98CKzUbEdPgPMSzXPG7Hi6e
         wlsT9bv0QEJO0t/X+T8qPmU+c3ad7NMDfqJV9OCb88a3nrMyxPL8xEcjGdGekDIR+Mjl
         K5CJ+Y7QSXYM2Eirbzs3qrQ/q8kLv9Szp95D7fgzAsrRkkqzaB9X1pq8ogdAE9JGAX+M
         hl1w==
X-Forwarded-Encrypted: i=1; AKwUvBxLVSPb/OvfJw6lHCRPtCPbn2ajo+U8TazywL6Hjs16DNxMtocgLYRtBgbgrYMayDU0hlo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIItlGU4jRaVgUNH6f7OfCCrMGb7x1Foa6K0pWISbO+7TIEeFo4
	xecDEsHAwzjAlxVFHeFBowf945v/gIIB+Xnq3PK466fhhCmzeSawqfv7fk2c2f8e32aNLAmU8rG
	xiY8WfsVAUZ/exw66PWN9kSA2JSMzwwsu186YtJmTLdNEGbaIesZXpD8wuW2pqw==
X-Gm-Gg: AYBFou2Lr6xQ/oB7PoWJR9n0LEL5GuCAcChJLU+0uj859GcVJ40jP5c2N+RsUWh5DtD
	Sq54CZHTTe0p0bVxikUfi5d7+KwDShKQFMtqjYXJ1awY2xWgZlgyD1M/28lTzBwqIFYOkiDGFhk
	B4WHOXO4IAW4rhwR51u2ZOg/cM2zXDz5nzvMY4wUhmZY+tVJX9ZyqGZ8N/qDgLibnkXmI3K+zxB
	8fs2p6S6vIJHF85NYti8O6Uy5j8NLjEB2ot7r7ZxWMCxcVV/c2t+5M832R7QKSZs18CLM3qj4wG
	waWLDyOOJWZNQ9xELdUL8Os/HSBd6fal5omJFID9JRbwNC17mtDytmKAEwrLM0QRLnp+hwQhRVt
	BCHtGFm9D/avcmicfxYrkxgasq4OqMmk+xJJpyYLggQ==
X-Received: by 2002:a17:90b:1f92:b0:3a4:e635:a8c3 with SMTP id 98e67ed59e1d1-3a8545cceb1mr1330573a91.20.1791267834658;
        Mon, 05 Oct 2026 23:23:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1f92:b0:3a4:e635:a8c3 with SMTP id 98e67ed59e1d1-3a8545cceb1mr1330556a91.20.1791267834199;
        Mon, 05 Oct 2026 23:23:54 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6f734ae3dsm9932948a91.2.2026.10.05.23.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 23:23:53 -0700 (PDT)
Message-ID: <7bbee080-e8b9-4f8e-a4bd-c24f0b3b815f@redhat.com>
Date: Tue, 6 Oct 2026 16:23:44 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <7b6ed626-eca4-41f2-ae56-0af59a931b29@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/6/26 4:01 PM, Suzuki K Poulose wrote:
> On 06/10/2026 06:47, Gavin Shan wrote:
>> On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> The RMM restricts the access to the register states that the host can
>>> read/modify for a given Realm.
>>>
>>> e.g., At VCPU creation, can modify GPRS (x0-x30) and PC.
>>>        While servicing SMCCC calls via RSI_HOST_CALL or servicing PSCI
>>>        requests.
>>>        MMIO emulation in the unprotected space.
>>>
>>> Additionally we use the sysreg configuration to advertise/configure the
>>> following Realm parameters, which are required before the Realm Descriptor
>>> is created:
>>>   - SVE Vector Length
>>>   - Number of HW Breakpoints/Watchpoints
>>>   - PMU Counters.
>>>
>>> Thus KVM also additionally allows access to ID_AA64DFR0_EL1 and SVE_VLS for
>>> the configuration of Realm creation parameters. We don't support PMUs for
>>> the Realm VMs yet, so PMCR is not exposed.
>>>
>>> The RMM makes similar restrictions for reading of the guest's registers
>>> (this is *confidential* compute after all), however we don't impose the
>>> restriction here. This allows the VMM to read (stale) values from the
>>> registers which might be useful to read back the initial values even if
>>> the RMM doesn't provide the latest version. For migration of a realm VM,
>>> a new interface will be needed so that the VMM can receive an
>>> (encrypted) blob of the VM's state.
>>>
>>> Reflect the above in KVM_GET_REG_LIST, KVM_SET_ONE_REG calls.
> 
>>>   static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
>>>   {
>>>       int size;
>>> @@ -553,6 +572,9 @@ static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
>>>           u64 reg = KVM_REG_ARM64 | KVM_REG_ARM_CORE | i;
>>>           int size = core_reg_size_from_offset(vcpu, i);
>>> +        if (vcpu_is_rec(vcpu) && !kvm_realm_validate_core_reg(i))
>>> +            continue;
>>> +
>>>           if (size < 0)
>>>               continue;
>>> @@ -598,6 +620,9 @@ static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
>>>       if (!vcpu_has_sve(vcpu))
>>>           return 0;
>>> +    if (kvm_vm_is_realm(vcpu->kvm))
>>> +        return 1; /* KVM_REG_ARM64_SVE_VLS */
>>> +
>>>       if (!kvm_arm_vcpu_sve_finalized(vcpu))
>>>           return 1; /* KVM_REG_ARM64_SVE_VLS */
>>>
>>
>> Aren't above two checks conflicting to each other?
> 
> Do they? We allow SVE_VLS only for the Realms and we allow that
> before the vCPUs are finalized. For normal VMs, depending on
> whether the vcpus are finalized, we either send 1 or the full list.
> 

num_sve_regs() can be called for 3 cases: (a) non-finalized realm vCPU; (b) finalized
realm vCPU; (c) Other finalized vCPUs, correct? The check "if (kvm_vm_is_realm(vcpu->kvm))",
which would be "if (vcpu_is_rec(vcpu))", covers (a) and (b). The second check
"if (!kvm_arm_vcpu_sve_finalized(vcpu))" isn't used. The check here would be something
as below after this series is applied:

	/*
	 * Only KVM_REG_ARM64_SVE_VLS is visible on realm vCPUs no matter if
	 * they have been finalized.
	 */
	if (vcpu_is_rec(vcpu))
		return 1;

Besides, this check "if (vcpu_is_rec(vcpu))" belongs to PATCH[22]. Hope I make myself
clear :-)

>>
>>> @@ -625,6 +650,10 @@ static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu,
>>>           return -EFAULT;
>>>       ++num_regs;
>>> +    /* For Realms only support SVE_VLS */
>>> +    if (kvm_vm_is_realm(vcpu->kvm))
>>> +        return num_regs;
>>> +
>>>       if (!kvm_arm_vcpu_sve_finalized(vcpu))
>>>           return num_regs;
>>
>> Same question here.
> 
> As above.
> 
> Suzuki

Thanks,
Gavin

