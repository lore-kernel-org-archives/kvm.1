Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1E3AEB2C
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967518; cv=pass; b=owzKnzMLqul1l2QY4F76Lj8Tup5KPIkus0fpJm/ZvKxIlQC2ge1hh82Ysg2zBWZUWFVpvDoLrxOVixwgTNVXwtKCf3q1VfAS60uQYMLFGqXlBUipNfcxjU0uRq7fwE/UrvdLU4AVnU91j4BSJLtiy8lIHkiOxUqeDZIfNIfVlPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967518; c=relaxed/simple;
	bh=uTvLvNOiD2VaPyg22uQpYQwhoB6nWQlo6kn+/rYg9tw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcw2wLXiXJgQj+3yv96QICQEHQs2MsjigmNFwJ94L4Ak2sx858LMUtadwySy4P943jkH0ryxpS4bLYke/83VtrPLekfjxdtdhoBucjAc1hUVseP81E4RpJ5MhicM04Q3IzZKyZn1pzD3i11XD4g0MI/+uwB9uJoTz58Hw3yM94A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2y3P8Xj; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2y3P8Xj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-871c8a36fe3so68233357b3.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 08:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788967515; cv=none;
        d=google.com; s=arc-20260327;
        b=fw5hnJdFyynA6wF/zTvLFFSmzNnC9ofLMvOo1dzKnlPfQHKlA2d1xhfvHO8UwDbB5z
         ezA7cEky/IbQgliYFQDi3OpX3oBsIKwCzVHiqUwWtq9ha7Hd6f+EY1TER2b8VtTTFNQe
         hgwPho8yDeB6T3B3qAK1f1faoiKtUXfO7Ww6NeobCOkV2PfnAWH9rLme0RWCKTmd/myJ
         IeXGTd7lv2gujhrakz7YTkUCCMK69wEU8o38FWfIJ7amgAt+0TBG7c4pkJelVq4ETwob
         yNONXiCBzR7mKy4K23kMwHQ/gpNFv+7oV2mJ9Zl94gES4LXw/zZOHw3zLKoNHD9LgCRM
         cayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=m4jJh3TX4gx98qaUfn3Q4oVt1KTvxUkS7IflLLQjx2I=;
        fh=rgPNHf7xfd7VCCuQMU9exBBpdBtXLFGAT98B3yWc09s=;
        b=aemkQE3KQuKKdaj/+mgVRgwIPJ1lMZThGlFJRWI4w5t/Lgs52wOinmA48MEpgnA9sa
         G2d2ggymiDpIVuXygAbx+s68xP1p5fI09wuJowxJHLGtL1D4dvhwhThRp6Gn11Bj1r5b
         aTpRbBPZRDmPMVXwmnqVyEidkjphbxBZdepQWUW9S7O/qiXTyf+QUIb0PiqsycBubc1x
         Tr5E4VA4b4oWZPrfTidtBCvamZ8Bq4fVC8m1R621fRmVBFtrWcY5TkYVm/KnqZx+74cw
         voEeE3oIIv1kpp7ByGUT/3zWBPtUbKxGQZSmI2t0FCxBG7DL2i3wAdPgWCZjROgcbL9I
         Ariw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788967515; x=1789572315; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4jJh3TX4gx98qaUfn3Q4oVt1KTvxUkS7IflLLQjx2I=;
        b=U2y3P8Xj3QeUVp4xZOITQEYDK9FZM0EaBg6fTTU19MJNlzeN3D1eTZXKJz3oxxW5Vx
         3txMBG7CxGTFH3KoiBcC8UmWooFrRXj+9/e705fKKaZG9JY60eA7Ct13WQuXbDCkbpMO
         67mrDhr4v25ge6UnoUokCmEHLkANhahEfDkLQ4eceLl9eFpXa+Rr4C+EtQSLe+YZr2Ed
         WAfEsb+oukc/56CLc7NOO3YvJE4rk72Y1faXOw33qKiqCK5KUghdJTj+27nNGARsHtEO
         MtPwYirQR+qBS86NS1D6lcFNvzTxYBxZFV3+u+ipEl+IysUb5HDMTkBuABnUIRJtQOU0
         0pMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967515; x=1789572315;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4jJh3TX4gx98qaUfn3Q4oVt1KTvxUkS7IflLLQjx2I=;
        b=Y8Rjd330RjarcS0yz/8xxzxpPaX1QyWnvzSJvM7gyh3Vllh851hd5RQArc7/vJWbms
         bjqN9ghJWuTTlkYfyedwFK1QxZ7SgV3D+qozpzTHr1ScSiyfGBwi6umE1GQ1fUqMIR+p
         tbaBKhzDg6MBathlSeSkOf5/+Ngtftymcdq0kAPv3crZaD2gNpbkqOi3QYo2cc/9XWnI
         loQFA7PeWPtuASjhDrWG+polvfP0gPHwiYjbzT3OzuX8zzF41jv0tGHp8gTwDn91371P
         duKbpIXR5KNdq7Fcm2bG3LHl+uvzBokTgboM63YeBoi82BpLJVCtnSWB7d83xxYtXkhe
         0XMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiaWM4OZyxrpVqlcguNSsWhyGWH1ki9W3yIQPkVynsqj+KfsnsyXkAVtzYxPoxjTC4f10=@vger.kernel.org
X-Gm-Message-State: AFuF++k8cjvQTc6kabZsimrT11p66cm2DAKs+8T+saOgXLWl7meRQTlS
	4aJPTLhvgpT8y7lQFtfVBkcr36FIxB/cdONNeKLs8LiX9dquVxhnQ/70i4gliK8LOgseHVCRY0k
	K9raeFKZu4QfFLfZT9HdVE1kEb9W41vqHL8taS9VH
X-Gm-Gg: AYBFou0k0sl6z24SsZWzRhJSPy8GszZMaxJscDChESFIlAZIlQFee9TkknvGJIUbOz2
	henJdeLzwne0kNTor9o3y4JGwDuHl/CVXf7Ip27NnHaq/AHfCOW0UWMTRqpkXdYzITE+m3wf238
	fMSFcOmAAbGNhzunQn89MPXma+puvCfGr9c8iOnVvsQO/M5dBE9XrVXMb2z9URZ4Zfnk54/lk1B
	UEHi/Xu6IbcLI2BrAABGEAtRup6P9yeulXGWTgziADcYaCBXSlxzLwpp1U/QhQY09yAkOJOvM1M
	CzmVcqK1G/vYujR0cBj8V3RnsoU92Kahba2a78O77plMGQ8qB7Hrpd9iPfL0dv3QxR/jKR8YCpo
	K7J4V9sGiGdoi
X-Received: by 2002:a05:690e:d0c:b0:66c:c7e4:2ff1 with SMTP id
 956f58d0204a3-66fb59519a7mr10665340d50.15.1788967513698; Wed, 09 Sep 2026
 08:25:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 08:25:12 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 08:25:12 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <bd6c9c74-e374-a9d3-ba1f-8b6f430894fc@google.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-18-85e5fd25252a@google.com> <bd6c9c74-e374-a9d3-ba1f-8b6f430894fc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 08:25:12 -0700
X-Gm-Features: AcwNN1XO0ky4otDKucsugFRBan2HEERm69mRZ8ScY2_txSdjnOuds0rILhuqOBo
Message-ID: <CAEvNRgEkkvk11_atVj9=+OBym-7SbSMB7MpHcoN6-Q5KS3Lb_A@mail.gmail.com>
Subject: Re: [PATCH v12 18/45] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hugh Dickins <hughd@google.com> writes:

>
> [...snip...]
>
>> @@ -926,6 +927,7 @@ void lru_cache_drain_for_folio(const struct folio *folio,
>>  			*drained = LRU_CACHE_DRAINED_ALL;
>>  	}
>>  }
>> +EXPORT_SYMBOL_FOR_KVM(lru_cache_drain_for_folio);
>>
>>  atomic_t lru_disable_count = ATOMIC_INIT(0);
>>
>
> I don't mind about the virt/kvm/guest_memfd.c part of it, but I'm finding
> a KVM patchset modifying mm/folio.c there hard to deal with: and notice
> Sean also suggesting to separate this part out.
>
> As you know, I've worked up a patchset "mm/fbatch: drain lru_add_drain()
> and _all()" which finally removes the problem lru_cache_drain_for_folio()
> works around. In the initial version posted a week ago, there was no
> lru_cache_drain_for_folio() in the tree. Now 7.3-rc1 has it, so I
> intended a replacement 13/25 in my series, giving you just an empty
> inline lru_cache_drain_for_folio() stub (and enum lru_cache_drained)
> in linux/swap.h.
>
> But that won't work for you, if you're adding an EXPORT_SYMBOL_FOR_KVM()
> in mm/folio.c, and of course conflicts with my removals (in context both
> above and below your EXPORT line). It's easy for me to remove what's in
> mm/gup.c and mm/folio.c, but I cannot remove what is not yet there.
>
> I've wasted hours on this, hoping not to trouble either of you; but
> seeing now that I shall have to rebase anyway (an unrelated mlock fix),
> I'm electing to take the only clean way out: I'm going to submit this
> mm/folio.c part of your patch to Andrew tonight (with a shorter Cc list!),
> in the hope that it can be accelerated into 7.3-rc2 (or at least get an
> mm-stable stable base-commit id) which we can both work off independently.
>

Thank you! Will use this in the next revision of this series.

> Whether that's acceptable to Ackerley and to Andrew, I don't know
> (just as we don't know when either of our patchsets will go further),
> but let me try.
>
> Thanks,
> Hugh
