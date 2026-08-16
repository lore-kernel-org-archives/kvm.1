Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC33BB57
	for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786922001; cv=pass; b=YK6zSyPl8hZ3tlszbviD+D2QVE/ma3qFZU/k8IX25g12Frf7ofVT3OFEtLKiHUnLP2jxURjZee0x2ZPOajqfX1yPki/JPrYKWlizycOvvf7UL1DlpBoAV5vnjK9trMHbbqbnjXaEWW+vuV+y8DyiK68UKARWhEDbg7e6t6cp7+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786922001; c=relaxed/simple;
	bh=4Q3/0/Vme3NViO+zbdqCGLReJBPhZGfXLLeXqh+3fvo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pi+qcWfiW2AptP3XO4EKxyn2fel/Tkv6RZ0tJP25kZzJQ7u9YK8SHl8Uljw5Tpn6bbiaBBptpOqLMYWKjtJJYcwoGQEJanh5MjL5h/Jcz1l06vVZkA+rRIBGsUStUNouI4ierks2dMCj8zXbyFVAmy10Y/Bb5NIrqcuOQe+ffCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZJQF4Dx; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZJQF4Dx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3407774a91.2
        for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 16:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786922000; cv=none;
        d=google.com; s=arc-20260327;
        b=cu8b4U+IwWYDAVQHGh+BzcX2jViIHpDkuxpFDN4sg9CBZ4sj7tLeGavbo9lbgMG93d
         6B64R1sN726xLTqW1pSWbO/iMCIev2WG3dvaKAXqii5ussEt1O4viwBxX2nHjInqFT50
         arAz1qSF83NX/Ep+YOjwaF0oLJ2h6IqdUO39zvQN2kpP1+pIQaqw5G1jS3SJ+VqZabyb
         loKaD6kErZzlqcRD5ZoT3JRnlAhDHDOnMDxyet7DShuYTmnoxohPyJjKRPW/8URb/FXW
         JuniP8CptIlrDs+D06VtO7QOYgxDwpxq6lkzOKE1eEM9LUhVMnZSrycJIyJdAI17/4IY
         0E3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=12JghCh0XcebURQOPBtQP8z7apq3lmuNj5BeBckCdP0=;
        fh=d1YrVgX8jwCQ//sKuDJZVQhaCOaVHhY9ZWl8InDPObs=;
        b=GB1quJN0AMWZt4NYltbci+0lnmphSvKgHtVjTWOplyoZf12AJ5WXlNkylUsR/GKFNl
         5My5DEDXnLM3O4wSBxD2ECeYXiQ/lBwHZ7njsWqNbWzg2chx49crQRlbHrZl0VhdM2WN
         EiQQKxK9IetZr83cJWo0fTzdGatsSIfxYbKuxWmA1MMjwUeCew6QmI05sJEWyobBWjjh
         Kyhapgsz3TiZH2AhZRnDB4IS+ZxBch2EEtljs36i9ZGojuikkmCr1J/sBDwh0rdKNIoj
         XpahbYH1ZkGx5TYkWWLZbCT3sZFqSaRIu3P3neZWUHxDDO7m1Y6qdxbEZSUlQuJqCDpm
         LY2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786922000; x=1787526800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12JghCh0XcebURQOPBtQP8z7apq3lmuNj5BeBckCdP0=;
        b=BZJQF4DxoyZyQETHZwYmaDiSD01BfHN0202Ksg3ewbB353AOHxY4Y+hr/BR7+MFbts
         Bc4+r2htQVyWxGMs8Yhw7eln9s395UZRL00IgIb0IvW36YPn87MvNnS7D+f6zOUIiHQe
         +6UDOUitLkVNxAAJ5fYCilTUvMsHDw0Cjy4FTfOAEe7n/Y2duzC16NBo/DbjIJBPPDU2
         3O/rMdqm3yX1U2yHAv46nHjZ9yPFOJthrRJzweYLSwRQBBsRRh3GHnWt9ORJBMHKKlvn
         5w9Z0QiDv205u//3aADSFv6U7b5ME4vVv/mD7W3alGo+cE3fOXIT5EwGXdzcIKYd14Hi
         BecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786922000; x=1787526800;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12JghCh0XcebURQOPBtQP8z7apq3lmuNj5BeBckCdP0=;
        b=dKDmnk3NJHfgmnZioc3SiFcSpQ25ZLBOHBVaR8KzfmAQoqefX2wd5zNt4+71/rJhJt
         9P7y0sU9/PvB7zOHMfwJUnFyqAb/t5hm2O6Oj5Q2h1Jx8dULkyOV8UV0jZO1ZDgvdHf5
         TMZeCPDFYeWJQpX30GwyiK2Jb1WdLQSkax7Yewsbv+d242GVPoZhqPQOIbjLyvlZN4qF
         et9NpM5s4wfp9PRX9xBB1Ytvx+z9DPU+h4XB+hvLFOfKypuOC5+8GTcSRKUSulGw10ld
         Ygj+65jQ2KmaXAZFc89fa+jjB2tUVc619TasTbdb08GW4lqr5/6psKkmlIIRHdXCef1u
         ADhg==
X-Forwarded-Encrypted: i=1; AHgh+RpdBekoM88xqXJpgAe+4En2qZq+kxKu/7nASOJ3Pd4oN0uriodUnnQAWotsi36HYMqWpOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZlpAgz8egyeJ88YrP+58neOng00JKRjGoXZmRwZLHrZmJBP3
	V1jyKSGRZvNvAmKjVxvWdwrO7lhCHwCqudLeJ7T1VsIxqWdef89bg3WM5HTbPRK/N4IafxV5Tt2
	ay87UjmUL3Ow3sdUnC2UFuQZ34PUNQsAvTCGijJQm
X-Gm-Gg: AR+sD13jcaSMSsMFmPy74tRl4+yEVgsTFuIXwtfiEtNPRtHFNcJSWEe/b4vVuYO1ubI
	W/mAqZWg90JscsAT3wuOphxwHnxBpnfdbFGAV1G+d54VEGSoacaTf846feDlzdUSq2FCA8QBL5l
	6c6EIoQWF2F+RRvyt/l3fGh9gV3PPphshu9/Wk2EvlxJaWuswBg6SIPBnZEBvlHUiyozb6pIK8M
	jidsdbhP+ajKZdKuE+hleZHEv+UHbDNAMswteNHewyNGh7Rkw543sPN6YicHe6FnpFKIUyPGaax
	bB5q1sBM8oAYBfyWtQL57RYAk19fnrN1B7nFzPbJw8+ym4FfMHXGbDEgPrk0NBQWY9SQUNgGAkN
	Q2g==
X-Received: by 2002:a17:90b:4a4b:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-3933b6ea12fmr20468357a91.1.1786921998920; Sun, 16 Aug 2026
 16:13:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 16:13:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 16:13:17 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <4c638fc5-5a74-43d0-b5bf-d7ef893cb994@kernel.org>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <eb1b5763-37bc-4cb3-890c-1e619e5a8ae4@kernel.org> <CAEvNRgHyRdt7rp=5e5FMbTT=fXNfB=np7VWd_GdmJcPOQgps4g@mail.gmail.com>
 <anpQJvFw9s-XP3pW@google.com> <4c638fc5-5a74-43d0-b5bf-d7ef893cb994@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 16:13:17 -0700
X-Gm-Features: AcwNN1X3sou7ibuklgbqVQOQa1awc-4sUeU5l1gDhhG2qaPtSC5Jq-Du8Zaqh3M
Message-ID: <CAEvNRgGzqYQLC9ThxcHCQ7KJm7rRMvqzGoznCz1d4dxAkiLkxQ@mail.gmail.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

>> helps the reader understand what's being checked without having to look at the
>> details, and also helps communicate the ordering dependency without needing a
>> comment.
>>
>> There are definitely times where the usage of a function bleeds into its name,
>> but usually that's because the name and the usage are on and the same.  E.g.
>> get_user() describes both the usage and the "what".  And it's easy/possible to
>> go too far in the opposite direction, e.g. by giving a play-by-play of what a
>> function is doing, but that's why we have bikshedding sessions :-)
>
> Note that the problem I have with kvm_gmem_is_safe_for_conversion() that it is
> all about *conversion to private*, not *conversion to shared*. In that sense,
> the function name is just confusing.
>
>>
>>> Perhaps a little ahead of its time,
>>
>> Ya.
>>
>>> but later with restructuring for huge pages, we also need no additional
>>> refcounts other than gmem's own so that restructuring is safe, hence this
>>> function name was meant to extend there as well.
>>
>> Given that I've read that at least five times and still don't understand the
>> nuance, I think it's safe (ha!) to say we'll need to revisit and review those
>> changes no matter what. :-)
>>
>>
>>> In this case "unexpected" (especially since the next patch adds checks
>>> for maybe dma pinned and unmapping), begs the question "unexpected in
>>> what way"?
>>
>> Ya, that's why I like "outstanding", it succinctly captures that one or more
>> references have been "loaned" but not yet "repaid".
>>
>>>>
>>>> I'd rather add a comment than have this filemap_get_folios_refcount.
>>
>> +1, the local variable just made me scratch my head.
>>
>>>>
>>>> /*
>>>>  * We expect one reference per folio-page in the pagecache and one
>>>>  * reference from filemap_get_folios().
>>
>> Nit, please no pronouns in KVM code.
>
> Whatever floats KVM's boat :)
>
>>
>>>>  */
>>>> if (folio_ref_count(folio) != folio_nr_pages(folio) + 1)
>>>>
>>>
>>> This comment explains what's "unexpected". I can do this and switch it
>>> to kvm_gmem_mem_has_unexpected_refs() unless people have other
>>> suggestions.
>>>
>>> I wish there was a folio_pagecache_refs(folio) that
>>> folio_expected_ref_count() can share with this, and also
>>> folio_swapcache_refs(), to solidify the definition of refcounts taken by
>>> the pagecache.
>>
>> ...
>>
>>>>
>>>> I'd add a comment here for the "why are we unmapping".
>>>>
>>>
>>> Does this sound right:
>>>
>>> Unmap here to ensure that userspace page tables have no mappings, which
>>> also ensures refcounts from those mappings are dropped.
>>
>> How about:
>>
>> 		/*
>> 		 * Forcefully unmap the pages from all userspace page tables,
>> 		 * and then verify there are no outstanding references, e.g.
>> 		 * acquired via GUP or similar.  Tell userspace to try again if
>> 		 * there are oustanding references and hope that whatever has
>> 		 * pinned the page will put its reference "soon".
>> 		 */
>> 		unmap_mapping_pages(mapping, start, nr_pages, false);
>>
>>                 if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
>>                                                      err_index)) {
>>                         mas_destroy(&mas);
>>                         r = -EAGAIN;
>>                         goto out;
>>                 }
>
>
> Sounds good besides the function still not being clear about *which* kind of
> conversion.
>

Circling back to this since Binbin also had a comment about the comment!

I'll drop the use of the const local variable and do

    if (folio_ref_count(folio) != folio_nr_pages(folio) + 1)

, and add a comment rephrased without the pronouns:

    No references outstanding if guest_memfd sees 1 reference per
    folio-page in the pagecache and 1 reference from
    filemap_get_folios()

, and then also take the comment and rename the function from
kvm_gmem_is_safe_for_conversion to kvm_gmem_has_outstanding_references.

	if (to_private) {
		/*
		 * Forcefully unmap the pages from all userspace page tables,
		 * and then verify there are no outstanding references, e.g.
		 * acquired via GUP or similar.	 Tell userspace to try again if
		 * there are oustanding references and hope that whatever has
		 * pinned the page will put its reference "soon".
		 */
		 unmap_mapping_pages(mapping, start, nr_pages, false);

		 if (kvm_gmem_has_outstanding_references(inode, start, nr_pages,
							 err_index)) {
			mas_destroy(&mas);
			r = -EAGAIN;
			goto out;
		 }
	}

I think renaming the function from kvm_gmem_is_safe_for_conversion to
kvm_gmem_has_outstanding_references should be better since it doesn't
really make a statement on what kind of conversion the outstanding
references are for.

>
> --
> Cheers,
>
> David
