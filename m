Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999672E737E
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267413; cv=none; b=B0FA1brF6HetTxe6wLppNEQ89qmWh4k15ssoEMkggvpg7oVrUbe8uUbnKjep+FF2tAw9NWVR+jXIT99qdLjT7pkKuCc19NwmVzWoWAowmPqoSDJM2asTr/oxXCvEJg4gxDNyLZMFwc700wO4Aqswuk03pjznLFdDc1bFbw4MTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267413; c=relaxed/simple;
	bh=9sfxC1+KgE1nDpW3pcZvcn/al45MEVpLjYPt9I1uPWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRw+1Y9yQx+abAt13uKTRyfHaPOTTiDGLYeJzWMEM2UO3XdqxAr7LAANUVLgNo6P2iJMwT43y3iQ5XblI/94GetTTZzqo5CMQ2iP69xKrzSIdvGPMete+1k04JG8cj+9buSPyuP49hOLXWghK5bCQ9aDo9E6t4F3cSCYeL/kCco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIuEGIxP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIr3//gB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIuEGIxP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIr3//gB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791267410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndLbXF3FabNtb+dQsv+BJtM4Aj2t7FSPtRaAHVuld68=;
	b=cIuEGIxPJGEZUDfQWJKooVBhH/RvDOVF+Lb+XvMi9KMN5HIDy3OWfR40ZTZAAGBs2NPGFr
	7NLQnJ1qV99Tzx2BNMknPSHI0y3TubEMRZ5EyAp8gaMahUcyX5TUbALG/J6Ok8aJwSvVa1
	xSxkOVgVbhHrj6Yw3zGbZp+kONRGY/E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-JJwLhS1PM_q1pS7wxlvc9Q-1; Tue, 06 Oct 2026 02:16:49 -0400
X-MC-Unique: JJwLhS1PM_q1pS7wxlvc9Q-1
X-Mimecast-MFC-AGG-ID: JJwLhS1PM_q1pS7wxlvc9Q_1791267408
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a6d95d6e08so2007865a91.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791267408; x=1791872208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndLbXF3FabNtb+dQsv+BJtM4Aj2t7FSPtRaAHVuld68=;
        b=EIr3//gBAGI8GXUcp/BVc3FohW/K+qgfpaBrWHcce7bgxstg/MysEHW80fBDX9CSGY
         zGLvcmhznd0BhhPoY2sjQKqmfjtfBPRrcVoMb21he6GR8ARFb0XUNnPwfiOhCOJk+o2i
         6ihet1haDhkVHYyDkEU5G/hNXlALtWbJKPVwLYPt18NPDQIlPQ61NWTj+ROY9DpZSUf/
         D0RHPdBq1aBJ+YeAjNaDYSYf3TF0IGUBpK0krZYoW3eSFL5+kbK9bqKW5zWynGHCZs+y
         4YyLBhIbCxIoMQca2H8zbLHB8k+o6W9tZzM/BZv7nBBZUm9DyjKKVix4bh+BzndJcVAO
         V4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267408; x=1791872208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndLbXF3FabNtb+dQsv+BJtM4Aj2t7FSPtRaAHVuld68=;
        b=BPUwYVZJJ5D/JL6OnedbJGHV0/OTqdHHHXLLI6ZftbrXyX5zOlglLBBiUM8QZN2Y41
         LPW4UwKg8beXRVWntxYU+9N8+Ve66JlUI0CXgnGKA4RIRAtg7ZuzK1nR6ZlzbI+pfk34
         xTcC+QGt9+43P1uBGzDVD2D8aDA5SNjGHdhbAS0fOmjG/3A+gv0U5oKnz6of+O4i68Yl
         tFDfdcg3m2TBqlxSMYujwcD8giWpCULaPlBtcfBUer1adB0DWySc6S2rjdAP9k5ba4xC
         Q25fXs5mi6y2r7ObAMsf6VTkWZn/VluSHgvoCcNz3JgUWUspG0eBDRRSTzezzytXANMN
         UcOg==
X-Forwarded-Encrypted: i=1; AKwUvBy6XKaL6qAv+hKa9j3ZqQl0MRAnchbBL7jK5CIYmo06hEhExaVO7dYpSW7dlGqncRVeya8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSjkqS/Szc4qUabfN6RWANUtKx3EOR/pb+Bc25w0ES0JFqi8jQ
	XQxa+tg/ShI5T2UxY25NaJe18PEDXZjrUWs/vJ9UN8lplQr9/g+TILjhoCJlUZU854/t6Qcx3Ur
	erM8bJq6hOqdiGweGd4gVcY+ig3H6O6FRzvce1EPBy4e31vaGcVsZAA==
X-Gm-Gg: AYBFou1sx/ooPRIzDFYs3kzHsW/vrQD3ZSxtI50+PzXvXztWDxrQ7OoGI3uzlC1tsSB
	kaHYD39inMMk2epvN6qM8945IyTXCoPf7fp8SRH6RX7wp3uhx51lWFs+SZ7hfCPhEbqxckqKAHd
	4yYZ461rDDiI8vxQpPE8tiTFsriq7qVp6NLuGNAIDnpKdxaSzojqCh9J370jbMaQabvX+RGuDe0
	6FvK+RnVpF+4c3DRVp0dDawUgjL0QP3Ra0lVS/Op1N367HLT8aPa3zbkmR9U+Dwbg1F1ar9O6eG
	pDe7wuacLGucV4mimb6W0wUWW0KvY2qCoKts5MU1rjFOgulRj7isfyyi2KteAYbOD00ZcWnsTvx
	54jKiyB+WFktpGWpvZxlBOea+q4y8j2k6giyBKAkVIQ==
X-Received: by 2002:a17:90b:28c6:b0:3a4:b30b:b50a with SMTP id 98e67ed59e1d1-3a873697b55mr247333a91.25.1791267408204;
        Mon, 05 Oct 2026 23:16:48 -0700 (PDT)
X-Received: by 2002:a17:90b:28c6:b0:3a4:b30b:b50a with SMTP id 98e67ed59e1d1-3a873697b55mr247306a91.25.1791267407661;
        Mon, 05 Oct 2026 23:16:47 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8211b74c8sm3504720a91.0.2026.10.05.23.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 23:16:47 -0700 (PDT)
Message-ID: <6bd785aa-4693-407d-b70a-39b1d0eda63e@redhat.com>
Date: Tue, 6 Oct 2026 16:16:37 +1000
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

num_sve_regs() can be called for 3 cases: (a) non-finalized RECs; (b) finalized
RECs; (c) Other finalized vCPUs, correct? "if (kvm_vm_is_realm(vcpu->kvm))", which
would be "if (vcpu_is_rec(vcpu))", covers (a) and (b). We needn't the excessive
check "if (!kvm_arm_vcpu_sve_finalized(vcpu))". So the check would be something
as below after this series is applied:

	/*
	 * KVM_REG_ARM64_SVE_VLS is visible on realm vCPU no matter if it
	 * has been finalized.
	 */
	if (vcpu_is_rec(vcpu))
		return 1;

This check "if (vcpu_is_rec(vcpu))" belongs to PATCH[22]. Hope I make myself
clear this time :)

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

