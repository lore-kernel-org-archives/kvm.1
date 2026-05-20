Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCE39D6D1
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313458; cv=pass; b=MFTGaYkEMUXDimvwoMjIph4fchoyC2u5CVngoAFlsTLSzCyey18CaYOU7aPz2w884j7NmxYOpF8wt2kkEHRztTV1dvQnyxFbJfu4f4vUKwyevxha1zbUdzta76eS8YGBZMT1+UdDsNwUYn7RuqzVTh+o1BbcQyyKjxancGaGXJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313458; c=relaxed/simple;
	bh=5vwh4tcfC1LD9NZjL0ZwGpI66Tl15UeToPVcfgSGyVE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4gSJ65/MzO/I3Vcg7mjStZL3lzp+y++UEzcGQr98DhJQDbbtFxcajmqI68KhHIeAZ/0Q27ELUt6CRWnYR0EsJozY3nnxUBTq+2+pDNoVk1pPIlESkJCNPFSGhatgOJWVsbfs6dfRJIQ2mQdV9bjIKT2wjg4tQ+4DVhmw3e6ytE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADNOJ9ot; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADNOJ9ot"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6312d29596cso3960535137.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779313456; cv=none;
        d=google.com; s=arc-20240605;
        b=g0pzcUdTRmZlqqTofoc3y6/D6d5VN1OebcojJbwFpOo23OiRunoUKST0vWOTpklzV4
         zwioz+USYDsTmo41YEwICPcCk2r0GSdR6Ln1yM0loT78LGola5jr+vBnNgXPTERkV+eN
         jgX8iy+fCURYKncpnlUQCsgMFcHjZg6f86vNl47BMkkvHsstDBxKwvzuYOHxyqFcsEt8
         GHeEXiP/K8crlkCY/+5M8b3dWpPZBUnRkp/0+FxCgMRepYNflpQZUFLBH3+k6a2vHyz6
         /w2BUkoVg4SVI6R/Th/BKHyzz9l/iWbssySLhoCM1sRyS8gdiYTua/0lOVjhnLPiQ+/4
         Uckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lzeZHICde6LC2KLtrV1UyrIn4vikEEbCZhRCg7feJeA=;
        fh=l9Tz3U9aM+t7eWe59jXhBNpknbaen5KwCD3L14dVBNU=;
        b=gDZrSr1TuWvy4rPQSlgI2ayyNXctUA23AWnEL4xJo04G741jrP/hLbsEhZ8RMHpWHN
         TSJpB+M2tccHFhTVNVg/OQHzsSBXb39zdRSD9K8/cTEGWE5WS/IMt7i/JIUsAy0rToUl
         7lCWosogsR6lVZt7YHejbyuDJbhT22OOFUSZr37rdh7IpE9Hfi5DijXaCqcjkc+6yslU
         F/YFDSBlbJCTtbWAhEQnAcqT9s3hmU4YraajVuZzLJPVRjQGHOvM2Y1wyzApsnRs/Voj
         r8S030JMaOBqR9z+2hHlZCwnHgq5JCtM/Mbq/PHZKTk6JB/85GyV1PqBZLkgdXy0NfQ7
         jNew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779313456; x=1779918256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzeZHICde6LC2KLtrV1UyrIn4vikEEbCZhRCg7feJeA=;
        b=ADNOJ9otSDzKLSEjGCHI05LGqcVyJOoXcW9EASu/7Kw+vPYwuoow6vFIR+kOptGyx2
         6NDFnxw+PTTDipeB82JByyeBm3XkEN2XsWdEo+HKvK0PXbAMBCY7AYIYMbBluhorBBBK
         ekYIDXecY5Jcx4mmBIlIK2IyF0oTicfPPUIYsi3eYq7lw6Phtvkvwchnr3K6EsIMtoY+
         ymSnboMtOWSelbRLQsXho/yT5xUnrbKrRlUPEpvJmh9Iua2GpHQdrKXgS8eZ6inolYy/
         Dfnf8zBGoNBRAp6Z5G2iwQaHiNmw77tGjz1bpQgbV7seo7nTOohLYpIJwp9EmwPxsDpb
         xZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313456; x=1779918256;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzeZHICde6LC2KLtrV1UyrIn4vikEEbCZhRCg7feJeA=;
        b=MuTBoqVBW1XDFaWvSeCjjzeXLlI2CrEteHRdAR9yNyKlWJJWJGxF48bQrPUCNj0Map
         BIAHKCyMb45I+t5MiYdAKZG4yYijAUfyDspnFw2Nm+mc2m1vk+83cQPz3VeNR67wcuFl
         rZBFcHd1kRfnXbbDD24919Dl/x0L8GtbzUR3bA9y6fNzzIf3cydz0SJUv45842kN5bKu
         6/GGRbuNuawFde7ckcHN61xpLrUUdO3SuY+gEHmEGQXyVWMcm+wpWeNEHrJ16JeLg69+
         PNFT4bvchMJU7NNze6jwGIDIXIRwnoWtdGnCwPw8lN+n+tydOs3WvX8VN1ewTBMbM3QO
         W20Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LKJR2IsWCC/+oOK8Pp0gdzoXV/F+wBAan8P0AslZIeK1uCjjc7s43HDkq8UhrbVfnrBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxngyEzTzdkiVK7wiJF2kh4uj1nysYrNm6sKW5fh+5RdYxEX40v
	DrG9quqWj9rplrLdJ828wrZx2o+VTiKwvvTdD4xh/PzGo/p78JkWCz9oqgAV2zFW2g312q0XZOy
	j+Z1GCkSmYaFOXQBS/aYXrCCFvq69plezaXixxWA1
X-Gm-Gg: Acq92OEco1UkLhPE6UScdm02mZ1OlJNPwrYeaXb4lJfLc7Pfp2/Ocd3Xqdz5eV+vHfS
	1ftlRJfIDskVVlbeuM3mbY6bA2Hj4zAfFfftcxGAYh8LwdlNv0mV9zjU6NDB5GbOXG/vCtuVJKZ
	nvQxmdagcVL66T0ld7xTOqdUh6wNJ0c3NVjMtlyUtmRNg3AKIsuAMtcF24o0epXaZQnJ+DM2Jnj
	Xapg2/pbKt7S1dtVL+9HxEkQf77lKB86ki2c0c9UkQ8krOoXvW/WJuPJANbRuHCiGFfFzSy64hY
	M+oWX4LpcPMB4fLibG5GfRieTlhFaKq3AAYnq4Sx+GV64BMxgU3n7vyruZy0+9t8a/qYURc+a5E
	aVTts
X-Received: by 2002:a05:6102:32ca:b0:631:8665:3510 with SMTP id
 ada2fe7eead31-6739e54982dmr235113137.31.1779313454629; Wed, 20 May 2026
 14:44:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 14:44:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 14:44:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com> <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 14:44:13 -0700
X-Gm-Features: AVHnY4KMeQgcJsvqoO4sP8lu-TRiPVeIaM4bWX0cqtV0EsssjCZBV_2_Gq2a7HM
Message-ID: <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
To: Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

>
> [...snip...]
>
>> +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
>> +{
>> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>> +       struct inode *inode;
>> +
>> +       /*
>> +        * If this gfn has no associated memslot, there's no chance of the gfn
>> +        * being backed by private memory, since guest_memfd must be used for
>> +        * private memory, and guest_memfd must be associated with some memslot.
>> +        */
>> +       if (!slot)
>> +               return 0;
>> +
>> +       CLASS(gmem_get_file, file)(slot);
>> +       if (!file)
>> +               return 0;
>> +
>> +       inode = file_inode(file);
>> +
>> +       /*
>> +        * Rely on the maple tree's internal RCU lock to ensure a
>> +        * stable result. This result can become stale as soon as the
>> +        * lock is dropped, so the caller _must_ still protect
>> +        * consumption of private vs. shared by checking
>> +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
>> +        * against ongoing attribute updates.
>> +        */
>> +       return kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
>> +}
>
> Doesn't this imply that all consumers of kvm_mem_is_private() should
> validate the result using mmu_lock and the invalidation sequence?

Let me know how I can improve the comment.

I think the "consumption" of private vs shared here actually means
something like "don't commit a page being faulted into page tables based
on the result of kvm_gmem_get_memory_attributes() without checking
kvm->mmu_invalidate_in_progress.", since a racing conversion may
complete before you commit.

kvm_mem_is_private() is used from these places:

1. Fault handling in KVM, like page_fault_can_be_fast(),
   kvm_mmu_faultin_pfn(), kvm_mmu_page_fault(): this already handles the
   entire mmu_lock and invalidation dance. No fault will be committed if
   a racing conversion happened after kvm_mem_is_private() but before
   the commit.

2. kvm_mmu_max_mapping_level() from recovering huge pages after
   disabling dirty logging: Other than that it can't be used with
   guest_memfd now since dirty logging can't be used with guest_memfd
   and guest_memfd memslots are not updatable, this holds mmu_lock
   throughout until the huge page recovery is done. invalidate_begin
   also involves zapping the pages in the range, so if the order of
   events is

   | Thread A                     | Thread B          |
   |------------------------------|-------------------|
   | invalidate_begin + zap       |                   |
   | update attributes maple_tree | recover huge page |
   | invalidate_end               |                   |

   Then recovering will never see the zapped pages, nothing to
   recover, no kvm_mem_is_private() lookup.

3. kvm_arch_vcpu_pre_fault_memory()

   This eventually calls kvm_tdp_mmu_page_fault(), which checks
   is_page_fault_stale(), so it does check before committing.

Were there any other calls I missed?

> sev_handle_rmp_fault() calls kvm_mem_is_private() without holding
> mmu_lock and without any retry mechanism. Is that a problem?
>

Sean already replied on your actual question separately :)

> Cheers,
> /fuad
>
>
>>
>> [...snip...]
>>
