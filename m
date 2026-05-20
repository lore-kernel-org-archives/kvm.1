Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2936A35F
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308755; cv=pass; b=IXlRtNooUVeIH2QGVemTRNJglEFdhbjRcMwbRPwS6PzSPY/p0OuqYTOX0RETui96UFkThar7Lw6YpGeKJbfAy7MD24kX31ebvd3OgUAPVL83xh0JlyobBScMEkEB9WY4P4h5rhvzE17qCsB8kPpYPg0K3a9TqtS2NO7YRH6eUBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308755; c=relaxed/simple;
	bh=0y54nFg7E7TaoQP1DdnZ3Kd8izilERRAcK4RB5V7BZY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzdHZ3O/kETjA4cXMPnzbvVKC3bNRYYKNWNHYbV7dZcCJPpD4aPycKPLNmhYsfrdOodFzebchRvb6aKb0123bMhIk5qJDNRkVbiiWfkbP67rqTvvtjSBIpElEJ4LT13lQ+vcGf3SFpjrP/twsSxyAn4zBwZjHGuMo+gJsJmxgTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwbOvfxx; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwbOvfxx"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-631ca15d35aso4862407137.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308752; cv=none;
        d=google.com; s=arc-20240605;
        b=YeX2BXllyDqa6Y+I+VnlxCQ5XLdELYiz3iT8cavo3yQ3GlzW2vWcsP9XY81a2CHthD
         S5u1UboriFf+S6XphW1idIh/2F6dqNHpjCK6lSE7gWJrnwi8oB+GRe0ZErhNKZyghoGY
         1CEyzteuuvKECc3MSHLsjgxVmdNxBBjoW4K/l0zlhmGacAhpLtX8iBI/yTCQPWF1ID8P
         jQtod3Ix525zMifGnZlIoZlOW/4dI/Zvj/3RetZp2M+uRB8mV5CQouOwLzhoAWdzyIyZ
         OYujHDe7nbCWbFViHZGE+tPsMVAmAN1kFTaw1LtjznzchEKt02WKA+p+dnBpHr6pWIgx
         Etwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ANitp46w7gSSv/gOMNKZIor35cJdYj41rSqFN5gAzAs=;
        fh=MuPrd8heHNwc1Sm0G0gYL1vXlZTQuasGIG5fBaft5ik=;
        b=i0YL+f8sbzzVrOx5NzYbjOHM6THwAVvpdTqGq/DUDtyEL2t0A+lX8l7+WeisDqfXWX
         k+8mDsHg43zcTpSydEF4EFJRzd+EHwN/0cXkEqLfX0tIIBqwYT3L4xt6mxVIHQFnIiBj
         krspidz8Gr42ReArbjpGkvvI3x4Ck0ifMHIthJYDhReWLsU0o5DrPOBQ7y3kbkU1F4t4
         EH84IAeIJm5I/0Ek1SjqQt9kx+8GtK4xysM7NUExrO7TUgjXC1+PfWeKi25EtryWFOMc
         8eoiVS5hUQPz8wLwuMeNedxZTl680xNiuTLvrU6pehJFEiEpVgh9BUULvbBEpqmhl4Yy
         bhTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779308752; x=1779913552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANitp46w7gSSv/gOMNKZIor35cJdYj41rSqFN5gAzAs=;
        b=XwbOvfxxojNTaZZg5xc85ejdAJLXOGIhj/ihtMbe8SNH7QL1VPADFRhf2ZTOAtHqFV
         4k7u1P39PnV25R6VstbsKpEE4wyX0JhVZqvNJ8buaI6G2q2H87BuGLzAO2nbgYCxH5Ft
         GnRlujwb7rxQbKACZqw87Jpo8dHQ7+08omse+HqQur9nmbbQbcYBGsu6Lt95kx29nZ8H
         oiskX7kcTOn14ZXsouLohobxRDb0u/MaDuHoHkfQpRcCjf3Xaun8eVFfJz7WA98ch44F
         epcFLiYRTMix2UmAxWj2gy1brAg77X3TksdbyI3HnBAOQPRug4fxELrHdLfrSuRtRNJl
         7tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308752; x=1779913552;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANitp46w7gSSv/gOMNKZIor35cJdYj41rSqFN5gAzAs=;
        b=p12+TVdn+Fdq6v6Zvh8YdkEZ0Okzhz122wk9I8VDqe2Sl5nOaF8DZV3EFkMwnfkHcw
         7XNzB5qWrnFcU5UxjuslrfpsXbxgZM25E51gsLTRQCZ9Lt7HfrRL2S3+lsZVfNOeKVG1
         vP/qazJjmDJZWPN0c0iNjV8FiH2J+nLW5N+B1kqZ34Ezx2/RbIAvNQY9GiskyFM6Em0s
         z9ScO6o923KgrQT7tFu93dVPQtSkNpBlpgXy1ihTrzh2NHddWndeFyv2spTBQzmCNwZ+
         kJZiGQqb3bGNvbMNsuy2bbk2GkQDSlAB2zNuOQQZ6nFEcBxdgM0rEhRTnT9dG285VrHb
         mNcQ==
X-Forwarded-Encrypted: i=1; AFNElJ98o0oSUFU3AZW+ztEivfvYtwYElv56LMV2c8VTnwPcOrQGTXMTtbfPuQpGJjnr8RRBQsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLz4zmgavNe56d8mYucxfqjEuMpfm7Y47EVYEQdsP8jRS4Hdm
	JVnCM0lc/PTCltqVISrtgnJKvfLQdDXmuYNFgX+a1CT1FIALnw45mWrTqBFu5ztbzNeD56S8Rqc
	Od3YJHZ/gXT7tv5F33DF6akCH5XKUAzcsqs+9w9um
X-Gm-Gg: Acq92OHfd6QtYSWprxZH+ipH5UpUqH5zjJZaiOsZmq5f3xQdCkVpQ/aXWgcBNe3OoKn
	FD7hd0rfquZHTuw7Kl+OBcSN3zrkBdIQCsW2KY4vfRZENYmCAI4m7cQGbDr26v4Ftya6KVPlixf
	5TMbvPJrLO7bsUKC7eUYHCSTbOEOxVzhuAHSWXeKErn9725ibizNnbChBDXpy3IHZAhxrKwBkWf
	ugl7BbtvUTkOMwwFfPwvZ6+Bc49KCE/vcR4XWL4baCqsjJ0upzVw+zC/fcc7Q3HENv+ddu+yw85
	W7doxi11Qip6uf6x68aYiSO48g8t7pUkI13iutX0nYudRwSQVPueDMo9qLgQah8U9Tyi4g3CUfQ
	Mq2hY
X-Received: by 2002:a05:6102:2583:10b0:631:a34d:b671 with SMTP id
 ada2fe7eead31-673bf885fcfmr10043137.5.1779308751281; Wed, 20 May 2026
 13:25:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:25:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:25:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ag3DawWCcrpCkD0e@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
 <CA+EHjTxvLU4XDPXDXYXXWJES1OFQgN8VTRLMgCCNMwBE6Hk8tQ@mail.gmail.com> <ag3DawWCcrpCkD0e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 13:25:50 -0700
X-Gm-Features: AVHnY4IBlIN9DzOr96NZ1ZZdFo1tnLv8pC5ZAKQh-hjUOng4U7q5IXabnxVwwpI
Message-ID: <CAEvNRgGHHkvfJ-mn9rfDvS+_1ht08YatFWo-Swt+5wFSPnC9Nw@mail.gmail.com>
Subject: Re: [PATCH v6 06/43] KVM: x86/mmu: Bug the VM if gmem attributes are
 queried to determine max mapping level
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> > @@ -3357,6 +3357,15 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
>> >                 max_level = fault->max_level;
>> >                 is_private = fault->is_private;
>> >         } else {
>> > +               /*
>> > +                * Memory attributes cannot be obtained from guest_memfd while
>> > +                * the MMU lock is held.
>> > +                */
>> > +               if (KVM_BUG_ON(static_call_query(__kvm_get_memory_attributes) ==
>> > +                              kvm_gmem_get_memory_attributes, kvm)) {
>> > +                       return 0;
>> > +               }
>> > +
>>
>> This directly takes the address of kvm_gmem_get_memory_attributes,
>> which is only compiled if CONFIG_KVM_GUEST_MEMFD=y. This breaks
>> ARCH=i386.
>
> And this bleeds guest_memfd implementation details into places they don't belong.
> The right way to deal with this is to use lockdep_assert_not_held() in whatever
> code mustn't run with mmu_lock held.  E.g.
>
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index c9f155c2dc5c..3bea9c1137ef 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -547,6 +547,9 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
>         struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>         struct inode *inode;
>
> +       /* Comment goes here. */
> +       lockdep_assert_not_held(&kvm->mmu_lock);
> +
>         /*
>          * If this gfn has no associated memslot, there's no chance of the gfn
>          * being backed by private memory, since guest_memfd must be used for
>
> But I'm confused, because kvm_gmem_get_memory_attributes() doesn't actually take
> filemap_invalidate_lock(), so what exactly is the problem?
>

Ahh I can drop this patch now. kvm_gmem_get_memory_attributes() used to
take the filemap_invalidate_lock(), but after Liam pointed out that
the attributes maple tree should be using MT_FLAGS_USE_RCU, I stopped
taking filemap_invalidate_lock() and forgot to undo this.

I'll wait a bit for more reviews and then put out another revision
without this patch.

>> >                 max_level = PG_LEVEL_NUM;
>> >                 is_private = kvm_mem_is_private(kvm, gfn);
>> >         }
>> >
>> > --
>> > 2.54.0.563.g4f69b47b94-goog
>> >
>> >
