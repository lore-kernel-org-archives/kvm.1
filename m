Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858D302140
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178718; cv=pass; b=rHFx2EMrOnWgaOH1IqrKwHpqPmfxHEZnOjm9G5Rt1r0euma7gVMNTcPnJzxwtnMReSWA9ZjO335EVmTgzLEp67uYN/VIfCZyxU8caRPZ3w0fFWgUsyWCeH2U6osuOsCRqkwWAX6ZV0lDQy3sLLxT++6HAByp3LBrDgS3mZkCnH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178718; c=relaxed/simple;
	bh=9Gtd+5W8SMTR25ZmPIeA+8FPrVOqTlN7XkJgDdQpNlk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIqW1t6ZaQme5wOUnaBm8XMglKb1JQSxQ1fA34Zx8PAC514V3PD/abk1sdBPYRuokoeCgfiZtcXK67XDR4pgdj8V101zklYGIhz3uWeiqvu2Tmtu/eG4JYuP9gSWKcOYC5ap3Emie1aaaufLOoxW2NPHm3E1a8crSAcWNllmaxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9cxe9a7; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9cxe9a7"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-95d18b33f93so658209241.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 11:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778178716; cv=none;
        d=google.com; s=arc-20240605;
        b=JBWAOkDpTAuoqo/NI92T0669r6cPnPH8W/wbJ+bQOQYUnn+/OMXw8xFR5DT3wmHhQw
         WlhXA3+zHAvAd8plO77fOfbMhrhFD2JhQrSC/dAbfKeAHraDN/OgntggoSSgddf/oZcw
         TFX6O7lKZDvt4KRYxSSUzGFNs43iuZ86iqI1qNM+rfPUZypScrLx6l7X2qhZqGHgDQkp
         rmHnp2WEfnq4dVpFJoclumRNSDHeYKeDpW0zOh/LUBPX0Ur4ly51gjVrucUJZYBW2eo7
         W/f8Mq7czw1YcVUrHArI4oYXReAkQb4JFoB6ldTQRb06SKx+QBVqMx0a1/4AsivRwURn
         GE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=goCC1MXS8+Hmwnd2WWRAT4Rp01B0ycJCM1C1lBpTnIs=;
        fh=/z3/89cpe0gXCe+TDzQXxJbsptUrjYH8c1VFti5WAU8=;
        b=lXdpu0TsCwHwfmyHsTG03Y9I1UNEDwxutvyJFRs4o8MkPTJCDCbqkpJ4KhGZ0WdK7X
         2QHB1xo/0ZXKC/zv7v2wQnKJZ8Ueltszs9FNYdonf+u6Fa33lNI1W2JoxZB8XTbpalcH
         qFxdl9l6xzFxx1/IFSrgzSmSJSLOz+uhW1eK/IcgajVzfEra+sJGzN6trMAABa1JxutL
         d0gnG/NrI8UlS/joJz7BQ66gynLnFCR1hBy4jWODVoysXG/7qgh8hb45HBa433wJdSW5
         Thstmx1cKPW3D9s/j0s5e7AgnkPKgRBgkTeGvYsQ8WbJtpZqV2Wix2Lh3bSBJOpqRn40
         SgeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778178716; x=1778783516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=goCC1MXS8+Hmwnd2WWRAT4Rp01B0ycJCM1C1lBpTnIs=;
        b=Y9cxe9a7HFizfWlIgAijSTg+sNOKPTCIfD5vBOU8y8Mz/QzE/FeerqQ/A2UvBuNAw2
         SBJCjy2e9x+XrkotisFuXDN1fRpLDdslnUKMz7KTp+mWIp5ZjnvluGkicFwv0WLNLI5k
         W521Q4uM1HXHMZDeGy4rTjT3wadbifQg1CiGsO9Sg+r07nzPaM9y1jf99mIjsHCP/qlx
         eAQwh3MNgEfls42ChDhMIMwg1OxbbKaY/0UCXoxdsH1YSSv+/YKUdiT/XB1WlHklBfW2
         gwgP37FB3EkaYPkfJ/o0nlF6PrzisFdCh5IOg1DrZctdmHN1lrUn6ml/EJIZzIjwRbAG
         6MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178716; x=1778783516;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goCC1MXS8+Hmwnd2WWRAT4Rp01B0ycJCM1C1lBpTnIs=;
        b=qkC940m9QTtjXhiDjAVwBKFJxcoOZ3l7ta0OH+YEz6VWe5Am8P/+B0xY8UGNKLQs1+
         rNuKb0jvfNq2VaZcnXGCLL3MZt/856bMfS0nojkzuWkGP6b+ml2nbmRXmDnnUOR90Yuq
         i2khupGNoBVMFOcsMXVi49oAO1ufdRUYl9geJcOahCd7F4QxUH84DKXoeZ10g3XsCd5C
         fHWZOAnS1fq0w18JJNlEUiObnoIb1JZ+HrqlOtTlPGcC4trIZUuE/4kbhNITgYZ5ru0c
         +ZWfdKmuUpYl9Sd8iy09HuuTHLx3ZgrLNaomVWT7ddMlGxG7RMnzR165tatO6nFk4QNi
         NoZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vUU3irSYDfbq0Zg2WNnoKxt7NGxqnpeFphIHA4dWkFoFgwzWdTXOt/6brH+3hNLOqGtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEQRsUZsPpSEZLvJMIjAj6Ry0cyE3LNUxIHUur4zq9k1q6HKE
	cgHZFSYA4j+UHmszF9574PxiiAGkeV0ao70cbAVgVSK19pTJEicHo8DnYNzdgm5ViWLv8T7aKnD
	w4FFhxo3fKmOTWLpPlv+RWmGqAXeY2mpuRiVyz0dn
X-Gm-Gg: AeBDiesuH350f7K9i6vmISER5XqYYjYxWU+G+aKG08o+AVAKGgVV/SB68KKQKWDcJGm
	vr+Y4G10UCC1oXM/FVQDe57QpEVWmqO4P0i5yYJzYqCZjIf/CB2Xe8iVyFYJTP3VSlcT9J+oBvA
	WAEoxDnGSItE1oS5BOeNdVKdT68Ti//XGB3qaMmSxR+phVVqpKj77KO9Om9caQUUEeR1+NnP6xu
	hVI1fB7WjApB0LafYJ9vOaADBJOeHf7r1UhS0sI0bPbZogQU6O8R6XxG3pbgyEvEW+qlep4rvBR
	sPHOv24t4WgfFwLtMBdDd6oYlKm+E8Tv++8plCw6lVVZ31KgMzkb7Kxg1E3AXPQhbOpiAAo5t2d
	9WFUC
X-Received: by 2002:a05:6122:6304:b0:56b:a7de:7129 with SMTP id
 71dfb90a1353d-575702cc825mr1528185e0c.7.1778178715530; Thu, 07 May 2026
 11:31:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 11:31:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 11:31:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <byywwfin2aenobdwuesqihm6nzxyx6ecedwgbt7f5tvaaul6fi@u7bmexpavwdn>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
 <20260428-gmem-inplace-conversion-v5-1-d8608ccfca22@google.com> <byywwfin2aenobdwuesqihm6nzxyx6ecedwgbt7f5tvaaul6fi@u7bmexpavwdn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 7 May 2026 11:31:54 -0700
X-Gm-Features: AVHnY4IrLeBlt83AneVyVg35mAkmDcan1kch_gmoyAe0Nsgg7IVb__9uDe3mtms
Message-ID: <CAEvNRgFGc7SRy_hkfSH3X=Cu00CP6wMHBJO0+55uebKTezWVnw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 01/53] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: "Liam R. Howlett" <liam@infradead.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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

"Liam R. Howlett" <liam@infradead.org> writes:

>
> [...snip...]
>
>> +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
>> +{
>> +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
>> +	void *entry = mtree_load(mt, index);
>> +
>> +	/*
>> +	 * The lock _must_ be held for lookups, as some maple tree operations,
>> +	 * e.g. append, are unsafe (return inaccurate information) with respect
>> +	 * to concurrent RCU-protected lookups.
>> +	 */
>
> Can you please elaborate how you see inaccurate information and which
> information is inaccurate?
>
> Your comment is incorrect and misleading as append will not be used in
> rcu mode.  Note that you have not set this tree up in rcu mode.
>

My bad. Thanks for clarifying about usage of rcu mode.

>> +	lockdep_assert(mt_lock_is_held(mt));
>> +

In the next revision I'll remove this lockdep and use RCU mode, and
kvm_gmem_get_memory_attributes() should get a stable result.

The other lookups using mt_for_each() in kvm_gmem_range_has_attributes()
and kvm_gmem_get_invalidate_filter() retain the lockdep since those
operate over multiple ranges. Those are called from paths that require
holding the lock to exclude other operations anyway, so the lockdep
requirement does not cost anything more.

>> +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
>> +}
>> +
>>
>> [...snip...]
>>
