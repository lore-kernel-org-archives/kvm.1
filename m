Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE740861F
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686746; cv=none; b=bHnY17G2r7g17wXxrxhkWerAiXyelw2Uktjf7cg9bwy/f1aExx981L6vPkNerdDHuPD2IT9EKEF/aH15x+vRpSfhTU6S48nljolRqaE4L8VrGRwduiqqsU7qOn8FTADgPPSr6P2ULCvf3AglwhJfPm2HTXWFAdhMxl+yG3PCuXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686746; c=relaxed/simple;
	bh=4aIVUcwRHuiC4cNVKh5w5JN4XCjj8bevckmZt8zM52Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+qjAofzGpBCUyqqX2QfEXm6JAVs1HmZgMqFVRk94zJsi1uwpU1BwkfKM2BwppTk9jP8VHVkcgF8eXHVRXmHoKJT666w0XP85sCZR66FNpymlSGRxcecCJBh8wG3Tbf+bSSTN4P9FT0SVXbI2D6GUxv8cMsse5EIkFPJ8jvPW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtU2Xxv3; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtU2Xxv3"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68d23404bd2so411541a12.2
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686744; x=1781291544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJLAr1VP/c4bf762M8SOjS2IK8uV+iAanaOJxy7ql2U=;
        b=ZtU2Xxv3f7OloFsK8NtF0J8JXKQXDm5vCJyEk2fFmywYcSmWZAsDf5Tpz3XZFN1RrD
         9v2UN5CTIHeA7lEY1L0pSDXLkComLfuFLQrwHxSvTgIb1/CAavwT8euiCQZGg8Gdb1qH
         qW7QznuPlFpdg+uRe5bSaImdjzEk4M9KwLAI11DtkZZdxTuZ5mcNL3zO1OKdvRPWSSpZ
         D3/Ifo9vVJI8UwOVAnnTQMeemrC8fOTRcEtVh58lXib2Ha3VxhYKt2AB/4yWdvBRO06t
         8Th0rRwtXxDI1NG3Kdk2hHzoe0vOx03/JMLvmg1rB7H4BDOTU7AtDVqkOzGVqqgcAgYe
         JyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686744; x=1781291544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJLAr1VP/c4bf762M8SOjS2IK8uV+iAanaOJxy7ql2U=;
        b=V6vH58uYjMjSV6UkLlsdBxq9yXE7KAHdFKsiQClieqnVK54FEALTYNhHwALjjvTY5W
         O9xurgrPLYd9cE2+UCmLq945MqKCUsIjqgV7CU6J7AGZT+I6W0TGqpnjwy2d3amUMmnm
         19UT+YCxAlaEKpSkS3FO3SyxjpKcFXpWXpKuP6qGLnYhdAWSPqjfWE+jJL2dy081bPSB
         TvDFw0dROzPt58F99Ej+6yirL8SaP1UcwxswjAnn6V7adSO18gLMAqzRpC62Wfv0ksqN
         Y5G8+UiMPlgLDDNvVlwKJaHD5VfOLKHiS8TERJ75FOXY2gqM+y400D/PrYieHbwBgNWo
         fF/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+SsgK/x7TFfKX8jWLxeCM3shfzBB+p4l9O4IKSnu0OtGd7OjKwgI1/twjeiHDgrUgiD4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVkG4UvQ0AnGA7ZJO7tjRwvWCvW7DGp18BTPVkIXNO0HC20U6
	8wxLJzWBnHBDu88P6hwBv4Xg2vPNSvbfTgFHe9UFqxYQ7WE9saZMlruqS600gT9eUCsVrEcnL/T
	D9s9r4uEy38+zoRgdZA==
X-Received: from edbbe11.prod.google.com ([2002:a05:6402:1a2b:b0:682:c35f:2ec0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1eca:b0:670:9ca8:1eb4 with SMTP id 4fb4d7f45d1cf-68fa503ad3amr2448684a12.12.1780686743590;
 Fri, 05 Jun 2026 12:12:23 -0700 (PDT)
Date: Fri, 05 Jun 2026 19:12:22 +0000
In-Reply-To: <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com> <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
Message-ID: <9huz33z06bu1.fsf@tarunix.c.googlers.com>
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

> Sean Christopherson <seanjc@google.com> writes:
>
>>>
>>> [...snip...]
>>>
>>> we have one open Question left:
>>> 1. How to check guest_memfd is fully shared.
>>>
>>> [...snip...]
>>>
>>
>> Given that lack of support isn't going to be limited to _just_ guest_memfd,
>> simply disallow preservation if the VM supports private memory:
>>
>> 	if (kvm_arch_has_private_mem(kvm))
>> 		return -EOPNOTSUPP;
>
This is a good idea, I have implemented it in V2 (sent it recently).

Below, I have mentioned a detailed analysis. Please let me know your thoughts.

> Makes sense. Tarun this was the other option that I was suggesting when
> we discussed offline.
>
> I think (?) it is possible to create a fully-private guest_memfd for a
> non-Confidential VM, and even after conversion lands, for both
> vm_memory_attributes=true and vm_memory_attributes=false.
>
> In that case, your preservation series can still preserve memory tracked
> as private by guest_memfd but not used as private, right?
>
> I don't think anyone will use this combination before guest_memfd
> write() support lands, we just need to make sure there's no kernel crash
> or corruption in this case.

IIUC, currently, private memory definition is where cocovm with HW based
private memory is supported. Which is directly checked by
kvm_arch_has_private_mem and this return false incase ARCH does not
support it in HW (SEV/SNP, TDX).

So about the combination where a guest_memfd is tracked as private but
not actually private. (Created without the INIT_SHARED flags). Even
though kvm_arch_has_private_mem is false.

In this case the luo will preserve the guest_memfd. But it will not
preserve any attributes, because
1. during creation, we dont populate any attributes, so by default
guest_memfd memory always considered to be shared. (Even though no
INIT_SHARED is passed). Conversion to private IOCTL will fail as
kvm_arch_has_private_mem check will fail for non-COCOVM. for COCOVM,
presevation will not be supported and conversion to private memory will
be succeded. (No corruption and kernel crash in this case)


==== WHAT IF CONVERSION SERIES LANDS =========

In this case, we have two scenerio
1. kvm->attributes
   In this case, Every logic remains same as above.
2. gmem->attributes
   if INIT_SHARED: memory is initially shared and no entry in maple tree, and if
   kvm_arch_has_private_mem returns false (non-COCOVM), this will just
   fails any conversion request. hence preserving the guest_memfd wont
   have any problem (fully shared case).

   if INIT_SHARED not set: memory is initially private, and there is an
   entry in maple tree, marked the memory as private. During conversion:
   A. To private: it fails as kvm_arch_has_private_mem return false.
                  Preservation is safe and there will be no problem. as in preservation
                  we dont preserve any attributes, but on retrieval, when a new gmem
                  file is created, identical entry to attributes will also be assigned
                  as INIT_SHARED flag is not set. So we wont have any issues in this case.
   B. TO shared: it passes, and update the maple tree. preservation will
   not be preserving the attributes with current patches, and it will
   also allow the preservation as kvm_arch_has_private_mem is false. So
   in this case, on retrieval, we will lose the data regarding the
   private vs shared (non-cocovm). So if host want to access the shared
   memory, it will try MMAP and which will fail in new kernel (which was
   successful in old kernel as conversion happened). But I dont see any
   kernel crash or corruption.
   This is an issue with only non-cocoVM support with conversion series
   having the gmem attribute enabled without INIT_SHARED flag. I am not
   sure, if there will be any user for this very soon (is it SW_PROTECTED_VM ?? ).

Let me know, If my understanding is correct. Should we add INIT_SHARED
along with kvm_arch_has_private_mem check to make Above case 2.B.
impossible in future for the current support of guest_memfd.

