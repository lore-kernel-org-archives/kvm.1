Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5663DEADC
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843498; cv=pass; b=eZvazzbD3epSkpcCAJPALXAI0LoLowlbQ9Mj3h7u6hZ3F1M5xYpDJ6t3zeP/Twyv7U9G9g2Ca6eY8Qy6hoj50pDK++9AHpFHXO2ZQdCjofFIGjvz8rz6dF3GGSQD3On54YqZYTkHwGt3qi/THQunQmEFsKtvAZ8GaG9lrioypDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843498; c=relaxed/simple;
	bh=uyUPA3g5JaVFIdW6+eNaI4XKeB9g+sCUKwxpwq7LcqY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7KgSMaIjC23TQHHmgjzCQNcTymFCuGSwKp1adZHGvyo1FjyCv37Oj/HX/nc8YYVHZPdboTH3ajjcWLjrU7GgF5BhQOuPCBKJkRIndeZ6FYcBxzonDxA7jpcrdHc0dWgxXbh3C9P0CaHiiGnH51KqR7TuRuJaUcO3uepQOHlCCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUz7YJfX; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUz7YJfX"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13b30f3d1e5so423149c88.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 11:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782843496; cv=none;
        d=google.com; s=arc-20260327;
        b=Jr3Jkmngq96inFVFiWJd6U8I6u9UPgPVozfXouN56XivaKQVlrUoD5YIvDOxHUr2sf
         Zp5TZGItIYeDseu519StGQ9l3vspCVFzCjsDVwZMsF72fXp6uJO8r684KAbSMAroDwQb
         zKSPnmhiJitJuGZ75tgpQv4ZDfn7j3IIVuFc3mYwDS8YeDbiyFSMfr+vfTsDeV+YnAEp
         mCgX6VAizKYuMMBFL9TpPT/MCl7aHhZvDOwQdtt1tmy6UOjqIEzPoKIjUzePttiVhaWv
         dIP8RKLfbVEvhfYYeUnH/GXCc252c1qE9eSLI/NyezF/C9hR3pI0ayv3/hewVX9Uedfa
         TfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=70nUlSqxu0vMKYHD8svN4B2jvX9LwngvnuRYACmSwYQ=;
        fh=CSnfY//5Qz/FkHzH10fvO+TN9+vmux54Ho/iU86ob6I=;
        b=YsKTPkXG7gKI12uzDxYXQWhR9SShzErD5ZBVwvW+GZ98NuILVhHAH7HkzPr/O1Xe60
         snEZTZ+wSJP23KZkU7pFrFRVm28s2BWXVQOf1YuL49ukDzWTSn3hOq3AOlnkE0dRjCzN
         tp2hMbhjJKgVly2f1wvtjNVBoNqTKW2cwlzeLtxoFmHq1S1b/AZ+j5+McaTls608RJd3
         gGTtMsd9MvbWGaE5DXHJN4vmgDwwqCryF5E3frbUpDbFm1c/CVbnslFfvRNk9EkS+MAk
         8EM2QQpISLlYLBje5EY3A8ljoPXKc21BCv2ussJW5N9yCctJpvbY1OFUL/K1ux01wCEb
         3kYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782843496; x=1783448296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=70nUlSqxu0vMKYHD8svN4B2jvX9LwngvnuRYACmSwYQ=;
        b=YUz7YJfX6QzZR9ZBo8+MHcecOsGyowlpNmxVzmeDm9v58r78WAp7m6qqrrVQehiUeF
         Ik/Bz7+ZfLFKddgPJ/LVNkk6kn4DMvPNmCykweE895LX1Rwa9YtfMyHSQuuo7xYQkbOX
         TVCqHzTBvv226aqGnqphBwVE7ZPgkC0B33SzPd76p9ilpSS9APCkeziauYHYoTxM+PX0
         0GQwXqd5/yUq/HzmqWe8iOOOQh8m8N6uFeaC1YjzlYDsyTtbdGSvo8dQLfsTpcd+E6NO
         4KFl+P9BCOsNpUR5RdcWfN1id7ONug/A2+/u7PrmXe2/vlI5+/jphrjptdfscQF43Ze4
         +8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843496; x=1783448296;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70nUlSqxu0vMKYHD8svN4B2jvX9LwngvnuRYACmSwYQ=;
        b=FmDzBo4J9vWiNlhXtnQTDADn8GLoTiy2m4sCPHggCiYcFenRbKdkx++GIC6DZkjmex
         YEOvXiNMK1bc1jIj1eoAzmAfr9t2sPbqnF4npayl/Jnlxga9Wa1U4pl2rSFOb68FAOZy
         CGilUIXtJcJ8sQC8AfKGSlwU/ih8+pt8SmJn0qHXpky3He4Aq2zFFpNad16KlHfmFR76
         KWuTfSf6NbSBXDQen4dL6lKI3SeOadA7QAeCtGcxmXXNFAXm0ZtGB4qiM+bI89u59AHk
         h43hhjAM1udL1XNYwi84zmKmUw1tcv3HulbWizt5IH67Vk7pvFFWXvM/oGwxTzXqNo0E
         Frfg==
X-Forwarded-Encrypted: i=1; AFNElJ/bG0buAvO+WGul98eqltJ2QKsL81P13KMKDPH7nqhIfbzL45ztJOZ+zeWG80Xgf2gfMA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIv2lUdYBr5yv84HflOyLiqphe3Wrz0U4IRzrBlzG7zSLY3nl
	NbCPnRvdS7EhfkGJk/QZyLaJKGlDqDtcLK8MfGYFAlWNpilnteZ4AqtvxPJeEevy+Zf2buL7RHZ
	GdL1CHm0cdI6+goiiW0MayWNda+B2wTR1bkSrYqJJ
X-Gm-Gg: AfdE7ckJs/tDeuxgLuiI/ps1sXSUtwg1TjNm+hzR2mp0chSlC+AqbWtQs9wjh4xp2W0
	63bKeLPAXNcy5LJZtsuLBLB9U40W2WleF5dFsNTb3uRlZKYYfl/aKWx5mbgcD+vcKAjTuCcZLc/
	vZl+Bl5JDD8IAdH5KdOp+JT62nKkyJnUCXODZlcM6qR0Zv6Bwx/oC3CvaB1kRUa2Uan1RHwE3cz
	OAlxtRhIHoe8XBlQd7ztcjvvbyDYelyT3B6D+s+IcG9GPKrZe47KXzNMDrbQpJMludIYYcPwTmk
	o2YqNTzZCFXcm1W4gswDF9b5IPZI6d84JZD1317xwltqECY4u1oUD0G3XXY=
X-Received: by 2002:a05:7022:69a8:b0:134:d3bc:b4b4 with SMTP id
 a92af1059eb24-13b2e297d9cmr2024216c88.4.1782843495523; Tue, 30 Jun 2026
 11:18:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 11:18:14 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 11:18:14 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <f8937d16-4aed-44d9-a058-beff56eac4ad@intel.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
 <CAEvNRgEBiivp9tOHZnFmWvF6ek-Ar-m2B+hb=-H0dgAcM2=z8Q@mail.gmail.com> <f8937d16-4aed-44d9-a058-beff56eac4ad@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jun 2026 11:18:14 -0700
X-Gm-Features: AVVi8Cem8-UowhLlk7c1ovclqrg2M3qRhpAj-mMpux06fGqtT2DmMJG-urIjBYo
Message-ID: <CAEvNRgFLjt+-cO-XT0s8uW2xXgyd+VVZ0g0Os6V0+LBFQzx8cQ@mail.gmail.com>
Subject: Re: [PATCH v13 13/22] KVM: selftests: Set first memory region as
 shared if guest_memfd
To: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 6/16/2026 7:46 AM, Ackerley Tng wrote:
>> Lisa Wang <wyihan@google.com> writes:
>>
>>> Set the initial state of the first memory region as shared if it is
>>> backed by guest_memfd, so that the KVM selftest framework functions can
>>> populate mmap()-ed guest_memfd memory the same way memory from other
>>> memory providers are populated.
>>>
>>> For CoCo VMs, pages that need to be private are explicitly set to
>>> private before executing the VM.
>>>
>>>
>>> [...snip...]
>>>
>>> @@ -495,14 +497,16 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>>>   	vm = ____vm_create(shape);
>>>
>>>   	/*
>>> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
>>> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
>>> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
>>> +	 * initialize it as shared so the selftest framework can populate it
>>> +	 * exactly like other memory providers.
>>>   	 */
>>> -	flags = 0;
>>> -	if (is_guest_memfd_required(shape))
>>> +	if (is_guest_memfd_required(shape)) {
>>>   		flags |= KVM_MEM_GUEST_MEMFD;
>>> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>>> +	}
>>>
>>
>> Just noticed this while hacking some SNP tests.
>>
>>> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
>>> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
>>>   	for (i = 0; i < NR_MEM_REGIONS; i++)
>>>   		vm->memslots[i] = 0;
>>>
>>>
>>> --
>>> 2.54.0.746.g67dd491aae-goog
>>
>> I think this patch should fully buy into in-place conversions, so we
>> need to also set GUEST_MEMFD_FLAG_MMAP:
>>
>> @@ -483,6 +483,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape,
>> u32 nr_runnable_vcpus,
>>   {
>>   	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>>   						 nr_extra_pages);
>> +	enum vm_mem_backing_src_type src_type = VM_MEM_SRC_ANONYMOUS;
>>   	struct userspace_mem_region *slot0;
>>   	u64 gmem_flags = 0;
>>   	struct kvm_vm *vm;
>> @@ -503,10 +504,16 @@ struct kvm_vm *__vm_create(struct vm_shape
>> shape, u32 nr_runnable_vcpus,
>>   	 */
>>   	if (is_guest_memfd_required(shape)) {
>>   		flags |= KVM_MEM_GUEST_MEMFD;
>> -		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
>> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
>
> GUEST_MEMFD_FLAG_INIT_SHARED is valid only when the memory attributes is
> per-gmem.
>

GUEST_MEMFD_FLAG_INIT_SHARED was introduced before guest_memfd in-place
conversions, so I think it's orthogonal to whether memory attributes is
per-gmem.

> we need to check KVM_CAP_GUEST_MEMFD_FLAGS or kvm_has_gmem_attributes.

I think we do want to deprecate the non-in-place-conversions setup, so
how about inserting a TEST_REQIRE(kvm_has_gmem_attributes) here?
