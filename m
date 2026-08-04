Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAC46AF08
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857220; cv=pass; b=fs6NsQkURCK8ZrjTTgBalaDZEDz9NObk/6YE20Uf9YHncGxmrsMZlmecE7JEd0VYIc3Ly4bYlFwQXiN8WQzsaexLy7DdqGseorxZLHShS7XhEwnQf7Nu+eSxCr7KvjXenmN+pF792PrzwlbfXpdSlG0T5A2lRUoyCw+qjmdMg+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857220; c=relaxed/simple;
	bh=PGOfUIjmK2sLYUpnc50+oNliPpC3bMJvepqZe67VyTY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5MVLBVE6mhe+cJecza3teGFjv2EbSkNateq5e30CfJFHfQBwgfhkD10+dX+A8l8cfwZMrI2PHWCFQpXSb3BtK2boTJah/ndsAUhsEKsyJ+4M57+m2qlzGw6fX4fCMFJwIbbq6Jhkjppo9j3xyMhj6OIoLq3Lqp2TgAQDgw83hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDMjDWik; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDMjDWik"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso2688262a12.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 08:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857217; cv=none;
        d=google.com; s=arc-20260327;
        b=gjXwQLAGXZ+y4pzT5AYzZt5T93mkjjDwjZx75Rto5dDh7Pj1zf5AGk+hXj1pVe8xWd
         mSAXGYOdornHgBqnpB0LkotlXBq/hz5QG1mtK7sjqHVTNy8IVvdRH6XqfBbkevwqZj/S
         B0sSOc4vuUnAKqg71mVZpydzDqJmaeT2NUi5mxQvHo0vfp8x6/Ijy3u10j+P/z0Npufv
         V7lMiKsPyp0RfpWzTDocPaMr+B/4YeJ2fViAhBWdhagffMTznvh32ktR7n4FN61HFWAQ
         uvvu41q/mwANJ25VdyWsqKClRs59IdcbDF4LrlyCcqT7LM7hevb9KeN8BoUKMF+bhUlW
         jFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=xHMbjbISSQ14Q5mScQWUAkMvgB0AbxoRu++R0znInKM=;
        fh=5aFbzTNjeuq2mGdUjsbJnW7FLOKLzkiXfj8+ytZqmNM=;
        b=fzeSRareSyOD6AuN2Rq2bdlYd9ot0mr3ISADA0umJa+1oZvuH9jWslJZwTOvedJaKZ
         eVNm8zbDrCm1DJp/4UkjgiC3h+9sXHm4FZf2JnQ4HQo1Ssl18GH1q4+Zn1Tug7cvf8Dm
         +hjpIcZW9a3Q8iKyaNh+Ww6B2gZZBJ6dWsBhTbhDzDB8n6CGO8Y5LYlbPw2x9FCCYvrs
         eFhGizHEH2nyItR36xCPOkQPLx/Z27HODbo4OLX1PV5c0GKflmcszcss1wmkxWhQW63S
         qdqTPzxX5MDcxlAOc0Y8VENHLfIe8DENH0iDsmgfFg81IVXzHSXKabNEFqwNxg5THik/
         TrIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785857217; x=1786462017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHMbjbISSQ14Q5mScQWUAkMvgB0AbxoRu++R0znInKM=;
        b=PDMjDWik/eZliY/FKDi+5xK0CCxl9aGVMJT7rvsdFTfk94ev2GSUXzKySURsNCUGcQ
         ad9QEcobYc9Tk8oHTJsfSF4Sf1xM00VBiDqgA0hEKs+WD9NAbpeKaQHPEX1uDLGJzMmy
         zpsukHSXtfIL/Vjd//dHPdhMX/9GTxntI7/c07LS+U1+tM9BaeUb+HW++nAfAodUxPrm
         6wBBX44pj32iewzyH88NQGK9EeFzov1pvvOFoi7hG0RMqN6InR4y7UECqZrs0fEYANqA
         7xyFOzV7Nvu21gNfQ45z7mfdoFwfaVyl66YDJ3FLb3Ogbcz5PS4t4oho7z2zUULKx+uH
         /dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857217; x=1786462017;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHMbjbISSQ14Q5mScQWUAkMvgB0AbxoRu++R0znInKM=;
        b=eXPfeEQY7EHeUPvwdPol8SVHPTsRQLP92L5L2it+1OxyWhWy+tVPMzqKiIrHQvAh3t
         ROGCAyUtHKUyY/u+3EnaLKYUtLDZLBoJKsothqEcJRITQOtyPtfG3a0EzhZfpJwYAjb6
         R0KcU3A/tn3u3wmGS64Oa7ApPiFwYvZ8ccVNCku8yWKMT/nusioyjKZi/tqOH7kIQszr
         wecQWj+bMiJHLwTTqXi/OKuqF9gOSPVp45uQLGQtlHnZhC1hBGl6k2a7oAkmozi38Sfk
         NL4t+fakGXYfdDr0HCDQp1puuww7RA5hx0C13Qgy+/jVuziO+MTYyMB4V+mXcfbqjrNv
         7gZg==
X-Forwarded-Encrypted: i=1; AHgh+RovR8VX7LT5urZS95oUNfb0K4Ct5AERQMfElgxOL/lE9T8E2bekPamY1CrKcU6s9TpSb/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeeke0yIU/Ru5r3bYt721Sp0GNtL4Pr8zsolcS1Jc/uKvu5zbr
	ZX1IpbRo9az3MYGvNznsRzpWyZ8VpyJxL40FWrApXNk07gI4/BEpMzC7sycEthwFAQicmeu++hB
	Krwl09jcBVIWs0wd0v6uVVfgO+7JZeSTpRwJi6mqA
X-Gm-Gg: AR+sD13BlNhqpKD6VnG2myjG6LConI5jxyB3K3w1Ye2iAySlA7iCUxPHaQSwl3+cMhe
	kUtb8S2uVzfM6Bf5a+L1PZoTxDf8rn3+vzb2nuQBLxTq9VzNZdH7xQcdOJ/aX+F8Alujzj+h0Dn
	svCFOqIEfm0M6EOgC1qv4LmIpSq8Qjksx/oClAFQjBmLBZh66p6iXE/Sq/5r6GEA9+OPIUjZIrs
	m7p3bmtpZYYRgLV+Tjq3kZA93NqEJEGXpkJmOUaMdPJcQgLflPe/UQrKtUune0cz5ZYWNNYyft7
	CrqJZVAIcDhij/PwHwitU5l2lmtQzr+MqsVh7X/0WbJD+9AlUwxSsMb5lAXSR/yamfjIjVzjV8F
	H
X-Received: by 2002:a05:6a21:10d:b0:3c3:fb32:a004 with SMTP id
 adf61e73a8af0-3c92a7b762fmr14007551637.34.1785857216492; Tue, 04 Aug 2026
 08:26:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 08:26:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 08:26:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <99037993-ee13-4160-8c87-b6642faea554@kernel.org>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-14-35f9aec2aed2@google.com>
 <4460e252-b6de-4df3-bea8-0368a9d0f4ff@kernel.org> <CAEvNRgEUQSju2tW_1zMk2=QmveZNtmkjjCZdqVBgBD2JPh0k4Q@mail.gmail.com>
 <a823e3d2-8acf-49d9-a812-ac1bb2136d7f@kernel.org> <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
 <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
 <60552bee-3326-4917-b00f-5fb7ba3b8adb@kernel.org> <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
 <anCtzQrUkFSSq8De@google.com> <99037993-ee13-4160-8c87-b6642faea554@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 08:26:55 -0700
X-Gm-Features: AUfX_mw3K43XW2l_796XUZJmj5MHabkxfpPYa5bbOl_mkX2g5tRDzjfPiVyB1Lg
Message-ID: <CAEvNRgHYhKACDfx9ZZy4a-TTS4yWzEJt=Jc92=eXxS15LPnTYg@mail.gmail.com>
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
To: "David Hildenbrand (Arm)" <david@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "hughd@google.com" <hughd@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 8/3/26 17:03, Sean Christopherson wrote:
>> On Fri, Jul 31, 2026, David Hildenbrand (Arm) wrote:
>>> I sent a fix for the GUP code that always makes us drain right now:
>>>
>>> https://lore.kernel.org/r/20260731-check_and_migrate_movable_folios-v1-1-e0002d7b791e@kernel.org
>>>
>>> Would the following (agains mm-unstable + fix) work for you?
>>>
>>>
>>> I assume that you'd have to call it as
>>>
>>> 	lru_cache_drain_for_folio(folio, 0, NULL);
>>>
>>> But maybe there are indeed extra references that are not reflected in
>>> folio_expected_ref_count() that you would have to consider? I doubt it, but please check if
>>> there would be a problem.
>>>
>>> There is a small problem for merging:
>>>
>>> (1) The patch depends on the fix.
>>>
>>> (2) mm/swap.c was moved to mm/folio.c in the mm tree.
>>>
>>> We could write what I have below against Linus' tree and have the conflict be
>>> resolved when merging. Topic branches are unfortunately not yet a thing in MM
>>> land.
>>
>> Are you expecting the aforementioned fix to land in 7.2, 7.3, or 7.4?  If it's
>
> Andrew wants to give it some more time in -next, so I'm expecting it to land for 7.3.
>
>> 7.2 or 7.3, then I would strongly prefer to base v10 on linux-next (where the fix
>> will presumably land soonish), and target 7.4 for in-place conversion. Then v10> can be applied against an early 7.3-rcN and we don't need to juggle branches
>> (assuming Andrew is ok taking the proposed patch through the KVM tree).
>
> Agreed. We'd also have to get the actual preparation patch into 7.3. I can send it out
> and coordinate with Andrew.
>

Thank you!

When we were discussing this earlier at guest_memfd biweekly, before
deciding to refactor out a function like lru_cache_drain_for_folio(), we
did say that the likelihood of actually draining in practice is low,
especially on a machine with heavy load making allocations all the time.

I think the threads with Xiaoyao have resolved, I can put v10 out
tomorrow. Would it be okay to go with the following from v8, and then
clean up later when lru_cache_drain_for_folio() is available?

I added in David's suggestions to check for dma pinning and mapping
before draining to trim cases where draining happens in the version
below:

static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
					    size_t nr_pages, pgoff_t *err_index)
{
	struct address_space *mapping = inode->i_mapping;
	const int filemap_get_folios_refcount = 1;
	pgoff_t last = start + nr_pages - 1;
	struct folio_batch fbatch;
	bool lru_drained = false;
	bool safe = true;
	pgoff_t next;
	int i;

	folio_batch_init(&fbatch);

	next = start;
	while (safe && filemap_get_folios(mapping, &next, last, &fbatch)) {

		for (i = 0; i < folio_batch_count(&fbatch);) {
			struct folio *folio = fbatch.folios[i];

			safe = (folio_ref_count(folio) ==
				folio_nr_pages(folio) +
				filemap_get_folios_refcount);

			if (safe) {
				++i;
			} else if (!lru_drained &&
				   folio_may_be_lru_cached(folio) &&
				   !folio_maybe_dma_pinned(folio) &&
				   !folio_mapped(folio)) {
				lru_add_drain_all();
				lru_drained = true;
			} else {
				*err_index = max(start, folio->index);
				break;
			}
		}

		folio_batch_release(&fbatch);
		cond_resched();
	}

	return safe;
}

I'm hoping not to push this back by a full cycle to 7.4, and also hold
back other series dependent on this one.

> --
> Cheers,
>
> David
