Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7953033DE
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689906; cv=pass; b=irnWTYD0ZaG1W3feGSDyPt+a0DRGqWIaCw0G3oPxeJc4HniPYvHxvmQECEPSstwlStvjhLZRmD/BUVBWu7N4cMIRuL58zdd1LXVoFPizgTwQFlJU2ic9ueU3r8FYlGo3e6zfrd1kvSuqaZ6i8Ee/DVTInIE+RdJyXWBHWeORsJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689906; c=relaxed/simple;
	bh=7/mWzWxPI8oQqXNv3WJswfOhn6IHE6PhTtx+2SIzYJQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juga5kk0emSRyubcCgP9PtZDQbfDUv+i/64MkBTIR/wHBkVj0kaR+aUrkxmosaPStdrZl+6WKis937OIc/M8w31UhBmLF9PZiG+9n66CQlje+DvsQGPU7DhmajGQYQA5kkTfGibJ8cTnCVdhrfxbTPSt5yjXyOM1RjRC7m3Xk6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZsIH11h; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZsIH11h"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-138129a622dso1058171c88.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 13:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689904; cv=none;
        d=google.com; s=arc-20240605;
        b=bkTkceyoNnT0n7m8vmnBR2z9AD1DIx3HpHoY6SAVeOHRJUJpOa21hiuOVEI9tdnFbh
         oBfdL8ZcpAxcTdjyoFsyDMNM+WgGrJXO4wr8eeiAbMBpMifN1vAepO0071dbeuCMKxif
         NFwcAHhtb5KwnICO8qWWqnmnuOvw+V2NV1b4MUDpj05KRBDB+n82wIxE/pw+3dYjbuIf
         RHKGMZCQjp+ViZa1CcPc8Zs9L9sfTK+NEouJVLIFMu+Mued3IBCPiMETivIPXnrDDW93
         Qlvk7pWGrchg9BWkuFc6YeLkj5EZg9curuXHzuq/dZTwyB5+WZGzsk5z2OhLYd9z/rP9
         X3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=;
        fh=mRFvqwJ68Wcy2jCqYCzVytCqW6QhRNRiTRYn9WS7xcI=;
        b=GjgZ/BG2Xzw2wjSoOnNH0iQTUK2KPhtKjiV8xW4db794jw5KnxVsrhbaiQGIpLpN8T
         Y/4AvZtBnwsyqMlQLtuP23PWmHXDoaJxEEEQNgrR09nqXu5/wf8jNyoEFAGhgxj+Y0Kg
         CyXo6wlpWirxSZlG0ub+Nj7jiZb1UgXo5IGi0vOUk/LqE8ykTI8rmW8lt8Vm1GmJzoXk
         dv929ToJLQ4NypFSpxB+5SbqtmwCS8hUUmocBxHkGK85aki/xpQ1TWZAXvpS0z+mkIZF
         32IUeUh6ihR0FLrqYhLLyWuK1k17t1Zx2d8Yay8lX+r4eh+fzUEV/rAhPpac3aC9/9L4
         e7ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780689904; x=1781294704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=;
        b=cZsIH11hl8Pdobufke957AihMbed5MXpSGt7Gff1hSgGSzEVGRz0j/viw2pa71T+tp
         4JYd1lrf8pFSqRRl10B9gl9aXbbvTlSF9omdmPjPzTzzbWtgjLbkBkq91omp2mTrYYwr
         S2hk6mlwukIOb+ogfw/l+Bc7VnMeovR5za2M64xdIIGz4TsR/ttTMZKJDeVwdW+0SUDm
         riVUAVQKgCfhPUDtzhtVjNwNgIgtXaj+8TUZXX9sw/Pc5EbZmj3hs8vh9qvOQa9odfDt
         f656oLM2SSNr6mloTWWY77N2Ydk0pQmNtAtQzGgFvNvxiUmoBvVMiVaIyGnY7LXTQ0y3
         tHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689904; x=1781294704;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=;
        b=X861VtKnhj7KcUMHStkSXN75tdrpHxZRzORerD8kQ66F/5tEO5bbWB916a7auwUTJT
         NnCNylXI3iueTEED3jt9QxUI2h+KhInZU5H0Thw4wRlA+P8EI+PesrGqD6awjfDnTgUr
         qhRiRN5R+F/kP5/IXl+5oRtwnIsGRD61vHG1XaqBQupEPBuaSM/q1COsXI5jTLZsSCQy
         NVKn/gUmaQ3QVUyOituDh1TgRnnIMqrJLI8U7+Ce9tG5bvoOz7BpSl3J2Igm4VrMD3MG
         KJ0IYKLa+Mb1GNd2XamAiW6g0/qPWCMWoSykAa4Ip4PwoWv2+TOhWYJrcCsZQGHzpmzz
         uqrw==
X-Forwarded-Encrypted: i=1; AFNElJ+vA5CISDAVcHDzQeERL7fKAiptLyKsBi+B5JWVFEyUe3obtotVdw1VIjh1hJrWUf+mcg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweYncnjzN3vB21v1nFS/QrCUesdGNMfGtIC2i2ndjB7oxwCiP1
	Fi1cBtjG0n0mbMhVWMtHVt7NQAT02p482iMDvWwTjIuM+C/KEo8wqR005s8FTMNBM+GpjVMpfQP
	ZA889LoyppdkTMBVs7Q3vcJTSR4TL/9irtj+ehbMo
X-Gm-Gg: Acq92OE66U3KXyEsAd2FZUQLi5fE0dJZxh58ooiVK/rrtwOmv3tz7KQZYLguolUpsqp
	6AueiWF8iPO4EGw9t0jEeEstCOy35k0Zy+VxyOo5mGkXuxKoueoGO5xNEyA5NR5gTVHMONtCb3N
	KAGtLVzWx7Zq2IeUkucm+a6hvcgV8LgG/oJhY0OviCIu4VmxkmIbs35e+kGKqclsIRtPsVJ7gAS
	QdKdFDG7UBPVqRL0tEgu7X4UJM50kyWEwYyrvmHaiHeBHsuborTNlzpt/mY3UD8okXOrS+b0ec5
	kMcYxB3f4GPMXtlg0hUqJ4LlbSSyIZfYegmhmRVwFjb/P/YOzWwK2zkgNsAzWlqyZo17UrVpALY
	LJzZb
X-Received: by 2002:a05:7022:6a6:b0:137:8921:4fe1 with SMTP id
 a92af1059eb24-1380674296dmr2844699c88.37.1780689903477; Fri, 05 Jun 2026
 13:05:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 13:05:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 13:05:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9huz33z06bu1.fsf@tarunix.c.googlers.com>
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com> <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
 <9huz33z06bu1.fsf@tarunix.c.googlers.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 13:05:02 -0700
X-Gm-Features: AVHnY4L2Vz8Me8pcWVFAkqKnhq9-w0SZ89mR2JAxVASVs_8LCadd0XSvG-O3nmY
Message-ID: <CAEvNRgEQ8SbqOL3yAri2NO7BoPd=-tqura9O5MKq57m1OLwkGw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
To: tarunsahu@google.com, Sean Christopherson <seanjc@google.com>
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

tarunsahu@google.com writes:

> Hi,
>
> Ackerley Tng <ackerleytng@google.com> writes:
>
>> Sean Christopherson <seanjc@google.com> writes:
>>
>>>>
>>>> [...snip...]
>>>>
>>>> we have one open Question left:
>>>> 1. How to check guest_memfd is fully shared.
>>>>
>>>> [...snip...]
>>>>
>>>
>>> Given that lack of support isn't going to be limited to _just_ guest_memfd,
>>> simply disallow preservation if the VM supports private memory:
>>>
>>> 	if (kvm_arch_has_private_mem(kvm))
>>> 		return -EOPNOTSUPP;
>>
> This is a good idea, I have implemented it in V2 (sent it recently).
>

Will look at RFC v2 in a bit :) Thanks!

> Below, I have mentioned a detailed analysis. Please let me know your thoughts.
>
>> Makes sense. Tarun this was the other option that I was suggesting when
>> we discussed offline.
>>
>> I think (?) it is possible to create a fully-private guest_memfd for a
>> non-Confidential VM, and even after conversion lands, for both
>> vm_memory_attributes=true and vm_memory_attributes=false.
>>
>> In that case, your preservation series can still preserve memory tracked
>> as private by guest_memfd but not used as private, right?
>>
>> I don't think anyone will use this combination before guest_memfd
>> write() support lands, we just need to make sure there's no kernel crash
>> or corruption in this case.
>
> IIUC, currently, private memory definition is where cocovm with HW based
> private memory is supported. Which is directly checked by
> kvm_arch_has_private_mem and this return false incase ARCH does not
> support it in HW (SEV/SNP, TDX).
>
> So about the combination where a guest_memfd is tracked as private but
> not actually private. (Created without the INIT_SHARED flags). Even
> though kvm_arch_has_private_mem is false.
>
> In this case the luo will preserve the guest_memfd. But it will not
> preserve any attributes, because
> 1. during creation, we dont populate any attributes, so by default
> guest_memfd memory always considered to be shared. (Even though no
> INIT_SHARED is passed). Conversion to private IOCTL will fail as
> kvm_arch_has_private_mem check will fail for non-COCOVM.
> for COCOVM,
> presevation will not be supported and conversion to private memory will
> be succeded. (No corruption and kernel crash in this case)
>
>
> ==== WHAT IF CONVERSION SERIES LANDS =========
>

I think there are quite many cases to consider if we consider both
before and after conversion series lands. For preservation, shall we
assume it will go after conversion? :) This way we can avoid discussing
some cases.

> In this case, we have two scenerio
> 1. kvm->attributes
>    In this case, Every logic remains same as above.

This is the vm_memory_attributes=true case.

Since kvm_supported_mem_attributes(kvm) returns 0 when
kvm_arch_has_private_mem(kvm) returns false, the vm's mem_attr_array
will always say shared for any vm where kvm_arch_has_private_mem() is
false.

So yup, preservation doesn't preserve attributes but that's also
effectively preserving always-shared attributes, so all is good.

> 2. gmem->attributes
>    if INIT_SHARED: memory is initially shared and no entry in maple tree, and if
>    kvm_arch_has_private_mem returns false (non-COCOVM), this will just
>    fails any conversion request. hence preserving the guest_memfd wont
>    have any problem (fully shared case).
>

Yup, preservation doesn't preserve attributes but that's also
effectively preserving always-shared attributes, so all is good.

>    if INIT_SHARED not set: memory is initially private, and there is an
>    entry in maple tree, marked the memory as private. During conversion:
>    A. To private: it fails as kvm_arch_has_private_mem return false.
>                   Preservation is safe and there will be no problem. as in preservation
>                   we dont preserve any attributes, but on retrieval, when a new gmem
>                   file is created, identical entry to attributes will also be assigned
>                   as INIT_SHARED flag is not set. So we wont have any issues in this case.
>    B. TO shared: it passes, and update the maple tree. preservation will
>    not be preserving the attributes with current patches, and it will
>    also allow the preservation as kvm_arch_has_private_mem is false. So
>    in this case, on retrieval, we will lose the data regarding the
>    private vs shared (non-cocovm). So if host want to access the shared
>    memory, it will try MMAP and which will fail in new kernel (which was
>    successful in old kernel as conversion happened). But I dont see any
>    kernel crash or corruption.

Perhaps it should be this way: the process of preserving should first
freeze further conversions, then check for private/shared status, and if
private, return error to userspace.

I haven't looked at RFC v2 yet, but IIUC this is kind of in line with
the other issue where we freeze allocations:

+ When preserving, freeze further allocations, preserve all pages that
  are already allocated. If there are pages that weren't allocated, too
  bad - allocations are frozen until unpreserve.
+ When preserving, freeze further conversions, preserve all shared
  pages. If there are private pages, fail preservation.

This way, there's no loss of any private/shared state, since only shared
pages are preserved.

>    This is an issue with only non-cocoVM support with conversion series
>    having the gmem attribute enabled without INIT_SHARED flag. I am not
>    sure, if there will be any user for this very soon (is it SW_PROTECTED_VM ?? ).
>

So if a non-CoCo VM does use an all-private guest_memfd (didn't specify
INIT_SHARED) (don't think anyone will use this before guest_memfd
write() support), it'll just always fail preservation unless before
preserving everything was converted to shared.

> Let me know, If my understanding is correct. Should we add INIT_SHARED
> along with kvm_arch_has_private_mem check to make Above case 2.B.
> impossible in future for the current support of guest_memfd.
