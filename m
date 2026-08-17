Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD533C3C08
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974780; cv=pass; b=iaOw7yFMRSJShhV2tYMu5aTuXI6nCfq6wu4lEgdHpu2K5CvetKjhw2hDHz8U1BMQSFoHF3IWzUCc57DyfCNVqyA2oNfd6SLUWsliog6/g+FwM9yMPhjKW9ZvbrcF4Y9ixJ9vGvpSuqx+pQ6CAODVSmH6k/Z6jqcukki4VbGwZHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974780; c=relaxed/simple;
	bh=/NIweOu34CW2pFg29jrI6uvH5WNUNRSHaH/sZYONA68=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEBOF9z0F+cKQD2CGe8e5c3Xg3pJWWCldORgtUn5fLfwJt4SB13c8DuxEd9DUpZZrHm6o42awxmS+sOxC0ZuODzjfylsUD/2iudiw88oWzMvo+aFvVmQCfbn/eIZVDdZAsqCJa+mlZp2xqYp2/1QUWnvUatpB9k+l/w/IPaKZJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLZSiei/; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLZSiei/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dcbade417so3442862a91.1
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 06:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786974769; cv=none;
        d=google.com; s=arc-20260327;
        b=Njjcl7db67iGzkMpl6D4aIDBtLPUiO36Xo6F6emj2DbJxP1Qk3W74bxtT6aVQJpUyy
         H/XX1ScAHZjubuQBatjb4v1z0boOvp0liRTy+5qMwV96wZG6KCq5Lb5iK+1S2ilqYWmD
         efF5F0+yl5CZe2EghOp5HpHNCY1Rp3Xh14R7zu5SBdlq2hNL/5gKy9bEgz+w7o5HntNF
         zdZzRm8uNCkSnhxD/lTUTLgaW3YtSp/52inriUFLAAebWAVebGYG51dfn0rUyvioXIsV
         9K6+0y6J1tmQu+S3pa/u/t37X24DR3zTLNSOgu9jpdAN6uJSWsSTXGtW7s0+xZuR27+m
         6Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=IX1KvI43fNPQ1XsnxDVHr/UZAXUksiAOakXpX5TJKNw=;
        fh=9rKEZ6HOW8pzM4ZVRdQ0EeodmMxHmj3SMC2Vf+D+b08=;
        b=S/kjD2mNNlmCtH+g0DkQiJHJ6TohmoJjels42kglndLLla+BPv987nnpKVpom06zav
         JI62dFwGWRX383yrPNCqJeh1bVKi/I5z0T91CJ94iTjDEf/R+ha+GdqVo169dnHEJcOT
         0yuRAexQb+j6KVVS6j+CYDxwuIIjODUrT2NSPVfwntlqK7Y9UVO0RucgtZQEJmu45j0Q
         HOmg4yGtchhp5Pd/oUYtLmLsYFx7IhNBuSV1Q8L9HdVrFmZjWl7xQzLnSQ51nJbjpi6P
         aOvAXFKsWe+B2ZHIcRwaDjDbNPTOOFd7oNIb3OKRJxxyIyWQTWZGyxJbBd/GYggnXDIr
         dO5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974769; x=1787579569; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IX1KvI43fNPQ1XsnxDVHr/UZAXUksiAOakXpX5TJKNw=;
        b=sLZSiei/bJW+t/XpI9PA4AEglb9dDudmjPJCeHSZKuu9Pl8w6khVwpc5u7tIGik3Nc
         i8yDjdneyHWnqIe2ck5NRkkBS+4oqvL60S+WnHvJjrL4RIPAlKjQYQ20b/sJxdFmBKL7
         JY9WPe2jLPqUQ7/aq7WZKPQP82D5eh2qechllK+aIePPStGulPHt/hIxl3mfOay7p5Si
         vPBawvz5C1U2o29hY5d24ylaI9/7Q5xA7CZ+t+RinaAjjHATDm957qPMcyMyus880imb
         ZbOrY/G/mhGv/1BsF/E/zXKo+Gte7rrD2j8v7KtsxMwOD+1/DDamnDgvvVQS0KW3jbDK
         jbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974769; x=1787579569;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IX1KvI43fNPQ1XsnxDVHr/UZAXUksiAOakXpX5TJKNw=;
        b=psYIsZJc3DMFAAnYxeQhEKXCbOHY6Rl4BHGIDgCO0Kt7RR0OY1MjY1h+m7BvJLK5ko
         HKKBBT4RV7T1eMTufIsTu3LWlmnE04i+lEbkWhD2jbsgB3375BBey4qbDa7j18Hmd6cw
         ualSMKc/u4PHeMpnRhDqfUZ9OWprtc0KNCFChV3ClspmXrAZ/5cDOiyp5WQ34nu9pAMC
         smmQFj8nZ5uzWYsrRZGKUfM0WXY6RuDMj8nM4Zj58oeuPNKwg92Vh+JgOVSVgGA8z/KQ
         +B+SyygjZoUAeOdltJNXgeVlD7ZZYk4K39onDG19v9Hscr0ifX7BZYkX0sfIBy60+/4f
         D3Eg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6ShiOxSM38DAdf7QFSb/MJ2t7PVPMsecI3psHv6ZMJisoH4mGjLpmXUIey7UZ5SPf7ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pcRwbCUBrep/j/49qiuNt8Gkam1fGhrVPEqHLDNsO94u+fgU
	wRSdI94Fk5Rtrjle2YZujENjzETiY4y7mZwV8rMBHoXmtSygkP8JMmgU+4dxF9RGYbewweuXlWQ
	JWBocM3qOo6jbvBJMw92370rtyoySROF0+fAiEMiT
X-Gm-Gg: AR+sD13VYhZAkfygTu88luez+P5uEC4B0FKZO/3aOwMBC9Z08VzJ9uSwfqpCWoJbO0R
	ya79c3d2tivPfi5+pU3xvWTeLBahKVyI7QXuH9Vkc7bw+dz/c1+EwUKZzK9ac/ZHgaIVex+aHB5
	Uvk0TFAi3dDuCq8azE4jKiGKNrSVWJa3cTxTxbB0uyfUIWxOkLdk7c5hIkF7bkfaiIFRNy2FuX8
	LvhYh1XhRbhwHfSkA0H32VLWP/woORscHeQDSEZx+hLQA26WDu1oUOKKpn5rPgzCXrkdb3rMWLm
	H3xJ9YI/Muq2DL5VrHCMSpCfLuLVjzvVcwA43zXRq7OTeLHQ8VQErNadhzGiQ+GZK2ubKRI4+f8
	=
X-Received: by 2002:a17:90b:274e:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-3955a3dd549mr974362a91.2.1786974768174; Mon, 17 Aug 2026
 06:52:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 06:52:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 06:52:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <befe73e1-3287-440e-90de-6c62f6c19d47@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-18-15ad654a50db@google.com> <befe73e1-3287-440e-90de-6c62f6c19d47@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 06:52:47 -0700
X-Gm-Features: AcwNN1UHGhzK4sYy5HwqSRuK05tzBOG6iD052SVLEabdQ5BbvTOapBvBVGicZOU
Message-ID: <CAEvNRgH00s3NWUH8EGUZq3WWweboBcUaTZs_0Cye5D=3o0OALQ@mail.gmail.com>
Subject: Re: [PATCH v14 18/22] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
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

>
> [...snip...]
>
>> +static void tdx_load_private_memory(struct kvm_vm *vm)
>> +{
>> +	struct userspace_mem_region *region;
>> +	int ctr;
>> +
>> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
>> +		const struct sparsebit *protected_pages = region->protected_phy_pages;
>> +		const gpa_t gpa_base = region->region.guest_phys_addr;
>> +		const u64 hva_base = region->region.userspace_addr;
>> +		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
>> +		void *source_pages = NULL;
>> +		sparsebit_idx_t i, j;
>> +
>> +		if (!sparsebit_any_set(protected_pages))
>
> sparebit_any_set() doens't check if the input is NULL. So we need to
> check it here.
>
>> +			continue;
>> +
>> +		TEST_ASSERT(region->region.guest_memfd != -1,
>> +			    "TD private memory must be backed by guest_memfd");
>> +
>> +		sparsebit_for_each_set_range(protected_pages, i, j) {
>> +			const u64 size_to_load = (j - i + 1) * vm->page_size;
>> +			const u64 offset =
>> +				(i - lowest_page_in_region) * vm->page_size;
>> +			const u64 hva = hva_base + offset;
>> +			const u64 gpa = gpa_base + offset;
>> +
>> +			if (!kvm_has_gmem_attributes)
>> +				source_pages = (void *)hva;
>> +
>
>> +			vm_mem_set_private(vm, gpa, size_to_load);
>
> So vm_mem_set_private() has to be called at this late stage when run
> with in-place gmem. But for non in-place gmem, we can actually call
> vm_mem_set_private() in __vm_phy_pages_alloc().
>
> Calling vm_mem_set_private() here instead of in __vm_phy_pages_alloc()
> looks like a trick to me.

I thought this is fine because __vm_phy_pages_alloc() seems to be a
rather low-level function, where the responsibility of the function is
just to allocate (for find some physical pages). Calling
vm_mem_set_private() in there seems to be doing too much.

> That is, we cannot set the page as private
> when allocating a guest physical page as protected because if doing so,
> we cannot write the initial content to it.
>

I think calling it here isn't a trick, it's a good way to reuse all the
existing code that builds up the guest image in place. In-place
conversion allows you to set stuff up in shared memory and then convert
everything when you're done and also populate the memory.

> This is the topic about how to implement the infras for in-place gmem,
> not the issue of this series. Let me go read the selftest patches of
> gmem in-place series and we can discuss there.
>
>> +			tdx_init_mem_region(vm, source_pages, gpa, size_to_load);
>> +		}
>> +	}
>> +}
>> +
>> +void tdx_vm_finalize(struct kvm_vm *vm)
>> +{
>> +	tdx_load_private_memory(vm);
>> +	tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
>> +}
>>
