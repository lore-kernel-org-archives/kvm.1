Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CF13D8B1
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792258; cv=none; b=g0bN+LhzM3qTn+Zkbn3hdeoccld6T7X5XQovDntkfEVJZg/Um1sGObdr7Oh9OglT1ExFMPiedSS3faKZvOL32ZsOyF9B90yeR6YtsIj+zcPI/w+LvgYy57GmGcdlM3AQkktim2a8pg23+prhHGcxpgVrAor/yx4q+sPM5GXjat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792258; c=relaxed/simple;
	bh=eP1gW2j37KAprnBEwViIsHf5eC5/x620M8MZLpnvZh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEnSWlBgJFfO5/i1dCOXqsL+28tGvwI6Mivjh2Z1fPSaFsMUEhbUkPLUyIPtPGDi0F01IDNtAJRD2UpEuZGQQEsjoELeekotZt+nH605+Ex34bpKjM9OdOYC3qBn2uLRQA8IItYbKGz8m8WSKrEGN49atezMe58StnhCez7knaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLG6tqe8; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLG6tqe8"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bf4ba05fd18so115085666b.1
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780792255; x=1781397055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnUUCXZJSSezsNhIoSCoYnkWRzWUK1TZUzSaS2Q+eGY=;
        b=lLG6tqe8HYNqOoJQ7CleMukYf5qMpFd19PuPZE5LcVLWwF3JZ56hDKnAI5amkoJyG9
         bIO4uT35P5iEWz/HHuZJNf6muRV6L9OW51CTcuEfCqDJVvno1OKFqgHHmImaE38EE6LD
         lP/sFM3sns/fTdDuoIvCLAzdWfc+D7R3y6H6/iF1cnulXC397zm15AsDRAcbEU3C8iBX
         o2iNh/cWpUuFPAHzJMwjPXYeTNXcHHA1LARdYlVzee9ZkK8zLyKGaK1xi1lOiMFwTHvv
         UX6O8B9mEliBzG6bdArS4UmfBsBpfl9ZUb2/v8N+G65spkrBFmYsGY+Ih3Q6Ppwn9mTi
         ZwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792255; x=1781397055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnUUCXZJSSezsNhIoSCoYnkWRzWUK1TZUzSaS2Q+eGY=;
        b=D0EtPAHlpUVA1Wnlb2kJAYA3RnRiK+llKjf1igJshvSBkMX0Dj7vHmFBL0Z9LiMbuw
         fyvvLfENfYD2q1calDUCYSQWemtcMgg7xKXpSPU/0fXXNA0MC6KI3vqLuPQbIRGig25J
         1V8YWOL7Iy6HcJidR7dYw2f9O2l854gvOAWO5c6wZUOTKGrPQc/YQjTTevGN/lFTpsAA
         wmtlMMqzvdb+433ZkcRMjJnMLz9QlMAH91UELBGjJ2GTB5JcL8+yewJhEjTlLd3AqRLY
         DVz+FRaWnVOdpgf4UzrodWTN9FIUj8xTKn+hLoDMian66riSTeU4YJor61dnaEK3QAwc
         RQJg==
X-Forwarded-Encrypted: i=1; AFNElJ8XYs4FteCjhSRFu0sojD7yp2zjd5KvcP4GYRovuhvdBaEvl7BcbtlBBrmF0ccXxYqeChY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgmBES9kry+HruG27LfAapuv++zAqMf0wVrnCoqNG4FbXNKJK
	i4wI8JF81tn+UixMhbHOo6BsOfYrVnihvaHxGOXRe1lkXFF939iuDyVuKGxXxkZbt2hv3EDZiXV
	KfREG0IqM7B8BLLIHgw==
X-Received: from ejri14.prod.google.com ([2002:a17:906:698e:b0:bec:674f:724a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94c6:b0:bd5:27b7:adaf with SMTP id a640c23a62f3a-bf372933d1emr494159766b.33.1780792255269;
 Sat, 06 Jun 2026 17:30:55 -0700 (PDT)
Date: Sun, 07 Jun 2026 00:30:54 +0000
In-Reply-To: <CAEvNRgEQ8SbqOL3yAri2NO7BoPd=-tqura9O5MKq57m1OLwkGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com> <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
 <9huz33z06bu1.fsf@tarunix.c.googlers.com> <CAEvNRgEQ8SbqOL3yAri2NO7BoPd=-tqura9O5MKq57m1OLwkGw@mail.gmail.com>
Message-ID: <9huzldcrxkch.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>
Cc: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, corbet@lwn.net, dmatlack@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"


Hi,

Ackerley Tng <ackerleytng@google.com> writes:

> tarunsahu@google.com writes:
>
>> Hi,
>>
>> Ackerley Tng <ackerleytng@google.com> writes:
>>
>>> Sean Christopherson <seanjc@google.com> writes:
>>>
>>>>>
>>>>> [...snip...]
>>>>>
>>>>> we have one open Question left:
>>>>> 1. How to check guest_memfd is fully shared.
>>>>>
>>>>> [...snip...]
>>>>>
>>>>
>>>> Given that lack of support isn't going to be limited to _just_ guest_memfd,
>>>> simply disallow preservation if the VM supports private memory:
>>>>
>>>> 	if (kvm_arch_has_private_mem(kvm))
>>>> 		return -EOPNOTSUPP;
>>>
>> This is a good idea, I have implemented it in V2 (sent it recently).
>>
>
> Will look at RFC v2 in a bit :) Thanks!
>
Thankyou.

>> Below, I have mentioned a detailed analysis. Please let me know your thoughts.
>>
>>> Makes sense. Tarun this was the other option that I was suggesting when
>>> we discussed offline.
>>>
>>> I think (?) it is possible to create a fully-private guest_memfd for a
>>> non-Confidential VM, and even after conversion lands, for both
>>> vm_memory_attributes=true and vm_memory_attributes=false.
>>>
>>> In that case, your preservation series can still preserve memory tracked
>>> as private by guest_memfd but not used as private, right?
>>>
>>> I don't think anyone will use this combination before guest_memfd
>>> write() support lands, we just need to make sure there's no kernel crash
>>> or corruption in this case.
>>
>> IIUC, currently, private memory definition is where cocovm with HW based
>> private memory is supported. Which is directly checked by
>> kvm_arch_has_private_mem and this return false incase ARCH does not
>> support it in HW (SEV/SNP, TDX).
>>
>> So about the combination where a guest_memfd is tracked as private but
>> not actually private. (Created without the INIT_SHARED flags). Even
>> though kvm_arch_has_private_mem is false.
>>
>> In this case the luo will preserve the guest_memfd. But it will not
>> preserve any attributes, because
>> 1. during creation, we dont populate any attributes, so by default
>> guest_memfd memory always considered to be shared. (Even though no
>> INIT_SHARED is passed). Conversion to private IOCTL will fail as
>> kvm_arch_has_private_mem check will fail for non-COCOVM.
>> for COCOVM,
>> presevation will not be supported and conversion to private memory will
>> be succeded. (No corruption and kernel crash in this case)
>>
>>
>> ==== WHAT IF CONVERSION SERIES LANDS =========
>>
>
> I think there are quite many cases to consider if we consider both
> before and after conversion series lands. For preservation, shall we
> assume it will go after conversion? :) This way we can avoid discussing
> some cases.
>

No, I dont prefer to make any assumption and try to make both the series
independent of each other. Landing any of the series first should not
break another. I am keeping this goal.

>> In this case, we have two scenerio
>> 1. kvm->attributes
>>    In this case, Every logic remains same as above.
>
> This is the vm_memory_attributes=true case.
>
> Since kvm_supported_mem_attributes(kvm) returns 0 when
> kvm_arch_has_private_mem(kvm) returns false, the vm's mem_attr_array
> will always say shared for any vm where kvm_arch_has_private_mem() is
> false.
>
> So yup, preservation doesn't preserve attributes but that's also
> effectively preserving always-shared attributes, so all is good.
>
>> 2. gmem->attributes
>>    if INIT_SHARED: memory is initially shared and no entry in maple tree, and if
>>    kvm_arch_has_private_mem returns false (non-COCOVM), this will just
>>    fails any conversion request. hence preserving the guest_memfd wont
>>    have any problem (fully shared case).
>>
>
> Yup, preservation doesn't preserve attributes but that's also
> effectively preserving always-shared attributes, so all is good.
>
>>    if INIT_SHARED not set: memory is initially private, and there is an
>>    entry in maple tree, marked the memory as private. During conversion:
>>    A. To private: it fails as kvm_arch_has_private_mem return false.
>>                   Preservation is safe and there will be no problem. as in preservation
>>                   we dont preserve any attributes, but on retrieval, when a new gmem
>>                   file is created, identical entry to attributes will also be assigned
>>                   as INIT_SHARED flag is not set. So we wont have any issues in this case.
>>    B. TO shared: it passes, and update the maple tree. preservation will
>>    not be preserving the attributes with current patches, and it will
>>    also allow the preservation as kvm_arch_has_private_mem is false. So
>>    in this case, on retrieval, we will lose the data regarding the
>>    private vs shared (non-cocovm). So if host want to access the shared
>>    memory, it will try MMAP and which will fail in new kernel (which was
>>    successful in old kernel as conversion happened). But I dont see any
>>    kernel crash or corruption.
>
> Perhaps it should be this way: the process of preserving should first
> freeze further conversions, then check for private/shared status, and if
> private, return error to userspace.
>
> I haven't looked at RFC v2 yet, but IIUC this is kind of in line with
> the other issue where we freeze allocations:
>
> + When preserving, freeze further allocations, preserve all pages that
>   are already allocated. If there are pages that weren't allocated, too
>   bad - allocations are frozen until unpreserve.
> + When preserving, freeze further conversions, preserve all shared
>   pages. If there are private pages, fail preservation.
>
For this series, I am strictly focusing on fully shared guest_memfd. And
any guest_memfd that supports or will support conversion to private will
not be allowed for preservation with this series.

Freezing the conversion, is requirement for guest_memfd that will
support private mapping. At this point I dont want to include this in
this base support. We will look on this when we will work on
preservation of private mapping.

> This way, there's no loss of any private/shared state, since only shared
> pages are preserved.
>
>>    This is an issue with only non-cocoVM support with conversion series
>>    having the gmem attribute enabled without INIT_SHARED flag. I am not
>>    sure, if there will be any user for this very soon (is it SW_PROTECTED_VM ?? ).
>>
>
> So if a non-CoCo VM does use an all-private guest_memfd (didn't specify
> INIT_SHARED) (don't think anyone will use this before guest_memfd
> write() support), it'll just always fail preservation unless before
> preserving everything was converted to shared.
>

yes, Also
We will never know if everything is converted to shared unless we walk
the maple tree, But for this base support, we dont want to depend on
conversion series, So depending on INIT_SHARED flag along with
kvm_arch_has_private_mem check makes this series immune to conversion series,
INIT_SHARED makes the initial mapping shared, and
kvm_arch_has_private_mem avoid any further conversion which is also true
before and after conversion series.

WDYT? V2 does not have INIT_SHARED check, it has only
kvm_arch_has_private_mem. I can comment there to be updated in next
version, if we are aligned on this.

Thanks.
