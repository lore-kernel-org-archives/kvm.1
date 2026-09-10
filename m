Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686563E0C47
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033237; cv=none; b=BgVCsIvBXgjGUTQJ2EIo9KJLTTuoCJB/+lRvZ3b1dd9k+ZaeOuRpj6mn1kTMFOk7CARrbjOrmU/NR0BTlWTsz+PeItiFcLVQ1/LBluJcXKtJTYpvCo1u9O53lOhCF32GVSMOnJ5e1dX7Svs885deksF0A0G74FgodeXtwmX7Zpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033237; c=relaxed/simple;
	bh=2U05edltdc65w78+ZV5IWr4TVwXUEOtUfX+tKTehz0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYg/EG5U/V0M05Yz7hOGV+ixeex7ELhZ5kh+KnI0BZWQSUiD7XkHm1/d2XXwQlM3MPkauBU06jWMDP/I5CSXsEhT2AWmnPsoUg72fGwkGsv7WVyLI/sLffMCzYa0FPYEp3Rvo9X4k8L7Lm1CT0rvD241/K2VSRT0cGAizOXcS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKZ5cacA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0uJv6DC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKZ5cacA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0uJv6DC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789033232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/H7/x7jrZUwe3gjvxEalG5iN9U5i6+Y9YANROw43qY=;
	b=NKZ5cacAcuN7mbpNR4iCohIwEwYtwjhyns25Kft60c9AryPxgSIDVnK8pc1JboskiqBWA7
	qktrlSsfDTePoUwiq9eHeUwwDcgUV56eHKcZzUCG7GV6H6nIqpKepM4OVpe5FG4NMbe5GS
	VpgXBPPA0e55OVHxkA0M6TJYslBrXs0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-O0dNc8e7PC2ktNF2QRVd_w-1; Thu, 10 Sep 2026 05:40:29 -0400
X-MC-Unique: O0dNc8e7PC2ktNF2QRVd_w-1
X-Mimecast-MFC-AGG-ID: O0dNc8e7PC2ktNF2QRVd_w_1789033228
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db050d469fso12266775ad.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789033228; x=1789638028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/H7/x7jrZUwe3gjvxEalG5iN9U5i6+Y9YANROw43qY=;
        b=c0uJv6DClKjJoMAyAxZHU7xVKL8bv6skzLXafrrrdmpEyq3FG+LauladmMQDN3gCgs
         QFNJ5gRdTUdw+yDcs6CCLpN/dPPMDjHfyAmO+N+taJT/qUW6R+ybwwGp3bWjteKNmYam
         mRBUyp+kV1G9PL0N8AUHCmiZDnzun/Nc/PcmX6+v4B/GGKEpzXMllad2abKX0SnSod7y
         KtoB6Lw2tujPfxQCnf9A5/Wf1XQJI0s+hBBOVrrTbnMfhKVOweOicKztoyKHNeQ4FldQ
         mIWaJ8ak+mLcaEjUBwfWH6ddKSo4a5TwfqZxUXh3EOOrqGlkIo+RavA+wqQN86wWSdA0
         VxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789033228; x=1789638028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/H7/x7jrZUwe3gjvxEalG5iN9U5i6+Y9YANROw43qY=;
        b=QSjjpE1fibcIGXrBm5EJyNQcnfZ+Kq2h0h28l9sRP07yklESfDTlNfnrvbTFptE0zM
         IcECXilAacoO1TRJeT3cF6PmhwgF0Btu7TDfG/gmJnAcQIts3HXt0px6jA7IGPStC54S
         jjNV5b79Wou6Ds6SqX1SuUFbWaKzZC9zMC1x+GAbgJgoevpp6O7j+BcWyWHAQUlORORj
         WbNHLmTuhRhbg7LN76t/aL6BqbOA6b1HKNSOE0a6L8TcbWAQglfM3exRr+M0n43cKY1A
         WqL2N36iX0VBByyxyo5WB62bNaZZQ0CI+bRg8NOuSVK8YzQIBDH7qmyHEpms7U5g9giq
         tfxw==
X-Forwarded-Encrypted: i=1; AKwUvBzjjkcBakRBdavMFZpnxPXgT+3dncEXN3CjTHUWYrn2XP1ytiCeCV+cuM/nh5BaOoNPJuM=@vger.kernel.org
X-Gm-Message-State: AFuF++mNFDU9w649Sq2YudA9r8T8/DQGcT/+90hP0vHFadBMQW0IsTvo
	Tyrn1NIwtpyN2nT86wOXLp8CQIjhO9QjQ76D590XaoYUX09KWxRY/bYyjxTiafE8B/udbYgdfjn
	CxfLyWqhZX/9U3Zqurdtk15yo0l1/n2bR8n7MIH03GkcSJMkwza1Qlg==
X-Gm-Gg: AYBFou1TIf4U8MZsYVOi5jUA02+wr8nEhGDB07PhwmhutNbJh9Oio0RkLBxIOMgazIE
	SJkDI2GYe7G6rZmhPU9KiDDMmPEXDRzH5Cv5f4BmX4t18n3bI6/OmkvWxU8mzlSxIViXKUD+ZUq
	lOLz8T/12SrAXKvz3EeTxgpFCJ543KCMXeKaZxo1wpX+myI5dywbPqSGxX4I827oRJzmJVZOmsK
	0ZRJvqRLMUvSfYTOirLc8f/UIlqkJQkROZKo4TjI41dFuZ4QtCILdX4OZg+HAKfSV3VokttOek/
	/CeGSIFwtcOEB7fXh5ZGsMPW876Epy42/kpYa9JI4NH61Mw55JOLfxqpAhcdDC+lqK7B7xWWHJZ
	3rzIQpNCm3wTB10ZUPw1TbU81ZyeGPZEFSkCq7Kq0pA==
X-Received: by 2002:a17:90b:4490:b0:398:baa7:4c2f with SMTP id 98e67ed59e1d1-39d77a08755mr3066637a91.5.1789033228074;
        Thu, 10 Sep 2026 02:40:28 -0700 (PDT)
X-Received: by 2002:a17:90b:4490:b0:398:baa7:4c2f with SMTP id 98e67ed59e1d1-39d77a08755mr3066617a91.5.1789033227578;
        Thu, 10 Sep 2026 02:40:27 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d80f0068esm3343502a91.10.2026.09.10.02.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 02:40:26 -0700 (PDT)
Message-ID: <472daa5d-19e5-41f1-9650-44e0245bc1f0@redhat.com>
Date: Thu, 10 Sep 2026 19:40:13 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/20] KVM: arm64: CCA: Add a new mode for supporting
 Realm guests
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260908162223.1683432-1-suzuki.poulose@arm.com>
 <20260908162223.1683432-7-suzuki.poulose@arm.com>
 <e66698e1-e582-4ff8-9881-4ddda5bc1d94@redhat.com>
 <40d3312a-c695-44ed-857a-fc6bf293f3e6@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <40d3312a-c695-44ed-857a-fc6bf293f3e6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/26 6:43 PM, Suzuki K Poulose wrote:
> On 10/09/2026 06:53, Gavin Shan wrote:
>> Hi Suzuki,
>>
>> On 9/9/26 2:22 AM, Suzuki K Poulose wrote:
>>> Add an explicit mode to support Arm CCA guests.
>>>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   Documentation/admin-guide/kernel-parameters.txt | 3 +++
>>>   arch/arm64/include/asm/kvm_host.h               | 1 +
>>>   arch/arm64/kvm/arm.c                            | 5 +++++
>>>   3 files changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/ Documentation/admin-guide/kernel-parameters.txt
>>> index 68647ff4bdd24..1afe3df3b923e 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3256,6 +3256,9 @@ Kernel parameters
>>>               nested: VHE-based mode with support for nested
>>>                   virtualization. Requires at least ARMv8.4
>>>                   hardware (with FEAT_NV2).
>>> +            rmm: Support for running confidential guests in Realm
>>> +                 world using RMM, as defined by Arm Confidential
>>> +                 Compute Architecture (CCA)
>>>
>>
>> I'm not sure, but 'realm' would be more appropriate name. rmm (Real Management Monitor) is
>> the term limited to the firmware to me. Besides, we have been using 'realm' broadly in this
>> series like kvm_vm_is_realm(), kvm_realm_state() and so on.
> 
> May be. But we use the "mode" of the hypervisor in question here, mostly. e.g., nvhe, vhe, protected etc. So, I went with RMM (in favor
> of CCA). Does that make sense ? Also, we rely on firmware/arm_rmm for
> the support. So, it kind of make sense to keep it "rmm" ?
> 

Ok, lets keep 'rmm' unless somebody else has better suggestion.

> Cheers
> Suzuki
> 

Thanks,
Gavin

