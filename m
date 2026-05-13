Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CA265606
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677405; cv=none; b=ew8dSv/dY6TUhKA9mHkN8wTnpbk8YkqKyqS1Jf+/a3TNalmIp6ewXdjbWAgS5UPnnQy/DyxA184Fa6WBvE6BZlTAHivLB/2OqCpb6SV624bkSjf+k0nKkaSK/rj5Y4yCpb7EmkbVHVurShGcMDgX4TxLTNgoPCCHZqlNwtKVkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677405; c=relaxed/simple;
	bh=47RwooVING59/ooQWdA7SNr7Zs32TKeNO1snt4GymBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T02v7LUvxDhGMFsiCB7A0nNps/2WgVlrxIXl3MIdQcBbCdet3Q38gBxgwaEg9xWnqiBsmHzMrGyeYQDtLqhUpUKBMieUGCN5RDg9jIx7jX+sR6WnjNYr9xiwJc1YxWDmZSv+N8BLo2aKBmOdJMAp6cfJPxz6OPJq2uSJrkSLutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INskhyC+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INskhyC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778677403;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47RwooVING59/ooQWdA7SNr7Zs32TKeNO1snt4GymBg=;
	b=INskhyC+G9Rth486b91VBn2P2guHoxLCyPXDfAC7xh1VShIQrF32VSIx29k8TQ1Mi5IrSp
	Ozvt6fm1MrA9FRzymRty6Z+2xhcstkCp8kOQ3SDgQ5IfyJqemo2xyxT5CuyMPchhVCxI/q
	q9D30C2GzXGcL3/1T26Sw+0Xpaac+4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-G5RJxaTtONm6243BTEdi2A-1; Wed, 13 May 2026 09:03:22 -0400
X-MC-Unique: G5RJxaTtONm6243BTEdi2A-1
X-Mimecast-MFC-AGG-ID: G5RJxaTtONm6243BTEdi2A_1778677401
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd0f1ef7dso4648475e9.3
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 06:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677401; x=1779282201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47RwooVING59/ooQWdA7SNr7Zs32TKeNO1snt4GymBg=;
        b=RWCahQr5PeMx4IibNgq4oNUG4L5ZIf7z4eNUy++NQlCISHWSbLR0aFnk+QDIYJOcoQ
         kO/934J6V+3UakIb1DZ50Jtf1jeJMXPRiM32lodOCC+H+K+uzv84KKqEk+Z+1FE2E9cf
         Wln8Hb5mToKnUBosnYougmFB3T7y7doxrJWEYqf6WJ2vicUJ7ECRg295dVAXq1GrJiFJ
         3Z92e7FoEE/PO1GXiYsEJcl8ORu0YRYtJzm0DUf/5+zDa1zvd8rD/MCREd4ffEnFpxnV
         wmmajTQMoPLUYXO7Qb/CN/1K7/Kb5WvmTdonVMbRGf9ZavHpFlX64xjVvtJo5wXW5n/F
         9VZQ==
X-Forwarded-Encrypted: i=1; AFNElJ//g7o59z3w+rLgAAcDQW/xJzMHDyVUybB7LIu9npee928Sio4dBuHNVxQUD3mBVgMZKJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHEPO0CuvaGGyKKzyKD1uNRdLb5IMG6yg49qDjCuEYN54+A/Qe
	Vxf6rIp8MOMageUuU3P9MJAsfSJCjkQeMNH6mnyG1BSUn23lf4Qd85Ea+ERrhFV6di66wL8kmNj
	5456k+onVdgKtPLtZMM1dSChGNwEIl7M1A8VZALu1U0DJuz6b7iV5DQ==
X-Gm-Gg: Acq92OHz3SYAjQMO1D8UKKmg6kDaKRVmkJcvp/uIJWo88Xo56eKtgkBdzz2mMvpvRMV
	K0/pi1lGBD5ci/n3/VmZk5GT+F4RGi84YvCPt0b6AcAj2SY0u4rcwUTKnxYevLBGg5KQx2KHOgb
	W46NUMFgBwV+SId1MILRmqUclFYyDhPnuAMd6qQdgFhogQAY3VNzv/n23Plkv8ZXS6JUZh9cEQg
	80wTW0o37QDb6zvT6RtDRKGDQOTaPM7jDbAaDxdSzavLYuAInDJIIpWQDRXjMGVMb4uvWkH3VOA
	tcqWmX+x17dWVp1t4Q3l25ZCL7DxeVZdEmksGCwd5bdNmWQLx1jEJ8H78hhawCzLn6WAZgnxrV3
	WSIKFSKx40Gx/IUakx2YybY0X5fG3MLZUm9yOHf+Kj0OIl7N3PYl/0/+li/1r1lIYowroag==
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr42450365e9.19.1778677400520;
        Wed, 13 May 2026 06:03:20 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr42449655e9.19.1778677399778;
        Wed, 13 May 2026 06:03:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm41638565f8f.24.2026.05.13.06.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 06:03:19 -0700 (PDT)
Message-ID: <c3848d24-f924-497b-b5e7-3ef3a07c3a6b@redhat.com>
Date: Wed, 13 May 2026 15:03:16 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] Documentation: KVM: Document guest-visible compatibility
 expectations
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Marc Zyngier <maz@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Jim Mattson <jmattson@google.com>, Oliver Upton <oupton@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>, Kees Cook <kees@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <6856b269d2af706eae397e0cf9c1231f89d9a932.camel@infradead.org>
 <6afc4b95-3c15-4d71-877d-19b84e91ce05@redhat.com>
 <57bc082f4824d6114d3156744c25986effc29aca.camel@infradead.org>
 <baff82ca-6321-4b16-aa61-b2d6d60b6535@redhat.com>
 <86h5obya2r.wl-maz@kernel.org>
 <48b06e5655d56ff6eda30e563b34894fa0eb2f07.camel@infradead.org>
 <ba08dfe9-932b-40c3-9fdf-fc891d52e1d8@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ba08dfe9-932b-40c3-9fdf-fc891d52e1d8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/13/26 2:43 PM, Paolo Bonzini wrote:
> On 5/13/26 11:24, David Woodhouse wrote:
>> On Wed, 2026-05-13 at 09:42 +0100, Marc Zyngier wrote:
>>> If userspace is not a total joke, it will read all the ID registers,
>>> and configure what it wants to see, assuming it is a feature that can
>>> be configured (not everything can, because the architecture itself is
>>> not fully backward compatible).
>>>
>>> Yes, this is buggy at times, because the combinatorial explosion of
>>> CPU capabilities and supported features makes it pretty hard to test
>>> (and really nobody actually does). But overall, it works, and QEMU is
>>> growing an infrastructure to manage it in a "user friendly" way.
>>
>> Yes, that is precisely what I'm asking for. I'm prepared to deal with
>> the fact that KVM/Arm64 is not a stable and mature platform like x86
>> is, and that userspace has to find all the random changes from one
>> version to the next, and explicitly pin things down to be compatible.
>>
>> All I'm asking for is that KVM makes it *possible* to pin things down
>> to the behaviour of previously released Linux/KVM kernels.
>>
>>> But really, this isn't what David is asking. He's demanding "bug for
>>> bug" compatibility. For that, we have two possible cases:
>>
>> No, I am not asking you to meet that bar. I merely observed that x86
>> does and that it would be nice. But we are a *long* way from that.
>
> x86 doesn't do bug-for-bug compatibility, thankfully - we have quirks
> but only 11 of them, or about one per year since we started adding
> them.  We only add quirks, generally speaking, when 1) we change the
> way file descriptors are initialized, 2) guests in the wild were
> relying on it, or 3) it prevends restoring state saved from an old
> kernel.  Is there anything else?
>
> So you're asking something not really far from this:
>
>>> - this is a behaviour that is not allowed by the architecture: we fix
>>>    it for good. We do that on every release. Some minor, some much more
>>>    visible. And there is no way we will add this sort of "bring the
>>>    bugs back" type of behaviours. Specially when it is really obvious
>>>    that no SW can make any reasonable use of the defect. We allow
>>>    userspace to keep behaving as before, but the guest will not see a
>>>    non-compliant behaviour.
>
> ... where for example
> https://lore.kernel.org/kvm/e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org/
> is an example of a bug that "no SW can make any reasonable use of".
>
>> Marc, this is complete nonsense and you should know better.
>> Once a behaviour is present in a released version of Linux/KVM, we
>> can't just declare it "wrong" and unilaterally impose a change in
>> guest-visible behaviour on *running* guests as a side-effect of a
>> kernel upgrade.
>>
>> The criterion for *KVM* to remain compatible is "once it has been in a
>> released version of the kernel". Not "once it is in the architecture".
>
> That is *also* obviously nonsense though, isn't it (see example
> above)? The truth is in the middle, "once it is in the architecture"
> is likely too narrow but "once it is in a Linux release" is way too
> broad.  And besides, both miss the point of *configurability* which is
> the basis of it all.
>
> The main difference between x86 and Arm is the default state at
> creation; x86 defaults to a blank slate, mostly; and when we didn't do
> that, we regretted it later (cue the STUFF_FEATURE_MSRS quirk).  It's
> too late to change the behavior for Arm, but I think we can agree that
> patches such as
> https://lore.kernel.org/kvm/20260511113558.3325004-2-dwmw2@infradead.org/
> ("KVM: arm64: vgic: Allow userspace to set IIDR revision 1") are what
> the letter and spirit of this proposal is about.
>
> Marc did not mention having to deal with guests in the wild.  Let's
> ignore it for now because even defining "guests in the wild" is hard;
> and anyway it's not related to the patch that triggered the discussion.
>
> So we have the third case, "restoring state saved from an old kernel".
> If this case arises, I do believe that Arm will have to deal with it
> and introduce quirks or KVM_GET/SET_REG hacks.  Maybe it hasn't
> happened yet, lucky you. 

for info, this qemu series was merged laterly.

[PATCH v10 0/7] Mitigation of "failed to load
cpu:cpreg_vmstate_array_len" migration failures <https://lore.kernel.org/all/20260420140552.104369-1-eric.auger@redhat.com/#r>
https://lore.kernel.org/all/20260420140552.104369-1-eric.auger@redhat.com/#r

It brings an infrastructure to mitigate some migration failures accross different kernel versions.

Also there is [PATCH v4 00/17] kvm/arm: Introduce a customizable aarch64 KVM host model, under review
https://lore.kernel.org/all/20260503073541.790215-1-eric.auger@redhat.com/

This series aims at beeing able to offer the capacity to set writable ID regs on the host passthrough vcpu model.

Thanks

Eric


>
> Overall, even if we may disagree about the details, are we really on
> terribly distant grounds, or are we not?
>
> Paolo
>

