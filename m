Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CC3C553F
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911886; cv=pass; b=nrbg0wyAPcRAxDZAYSS98T+jrmwSbugFqB0HiL8rYkDbcjKkmgYIfx2FK0eXNaNGwgcQ/hWMO4sZxf/+Pd/Ak/78xMPI6ogpdi6+QAHh7xtmJxYO7CajSxGC2khDgw8jzJ1/YQTYemGISgzswH/dRZLHwpkhQzlKhUyBw5S4lbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911886; c=relaxed/simple;
	bh=06ezevvS+8MzQnAuRUEIb+ISnP6vqqmbhMKf32l5Yvo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIvxHQfMgbKSOHowlCc8b0m7a8xmGZ90erQTYfZciIj+v4qfcqcjSlXCw2mnu+zGm0vBSGJYkJhJG2bPUoYzYSVuM/G+1VnJnvrjhom9017X1bGZLUB84PikkdULFoN8Tgfae6ARC8zTRDTctYIR+2xvNBEPSiZ+LYpmE7+87jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2bvXKA+; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2bvXKA+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811f512167so640476a91.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784911879; cv=none;
        d=google.com; s=arc-20260327;
        b=AAw23mzRR6jGinf/2TmCtsXoPKMXfnKyYwKrPuIKxxQUnY8nvlvUBcQ47b1y/JDUNR
         bAbXSEsx07YhNC98v+3AxS2fh3Jd9nHo9BSt9kVRVUHKPucRVzaqf6uOJhx0XMrrlzLd
         Uv3nDbwpheh4TdvqAjH/lj67Dz/HuH41STfBFRii2J6wRVwmf+VHyXuR8+pHkzfEZwJW
         tNOVVmZ6SNVmDZQskX8pfPK6Z5rxgiYLKfKaaawA5cwqqM7sX0MCoGZgE0Tvg3viPQu+
         kfVsl2kFXHh1mBkC7eYkCLeLMjybk8r9UMfGOBWnc8gJd5Zkqjx0LoITiJwr4CNOiPTi
         3Rqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MGiv6Xscnmlx4gMEVXMVRTWdGJsXLR2BdXop5F2AQBE=;
        fh=j2RGQ1VdNUZvJcBB77cfBWG2S8znJJ38BfN5+7bj6JQ=;
        b=SxV8SEeh1+0GCnVqAvbWayvQGRxSx0XVdvStZHoWsyC2PiR0/3wiVwfhSkAr0paKat
         RRfDzDdJ8w+TyJawEcAph+igfTjx8byhAvHc5IXgTjU3zpDskkGQV9h7iXg1+mgFF473
         35O68YxUwFlp2s4ZZsqNHJJS8OKLAkVU4rlZopGXvJGgU/3pKJNFDsyB2uVQvr/jd7R0
         JilwayVAOZzBnf5e5qmiiLeRoEsRgI6zfKAntpvaeGfM4cYnKO8Necw5YmBywx0zTz0n
         yXJ1jeM5b5MppybcWU/x0JPuZPnjbwlcJuaZsHvSqd+08EACehebTVB5UamRLQp2Ymic
         Ikxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784911879; x=1785516679; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGiv6Xscnmlx4gMEVXMVRTWdGJsXLR2BdXop5F2AQBE=;
        b=A2bvXKA+j6bl+q/IydKaPWUyE7WvWH26dknyCUPGHPs77/hxLCjCzQlFZskk3AZWfv
         JoM/G4pJPTMRWrunqO75JJQ/24hq0JNKac+sIlXj5Gs2LLHJQhqhaoYjI7HwEloU0i15
         yIO37/dS5sjGyyTiYCSXIslkQQcgnIzhjgpH+QWXTnSRiMSpFvQWFnUvnHl7Dlrf1GjZ
         EpyhRLWjPko8FdbY5ngVEfBOQovlAXYzMM4OSiXnlfcLESsH9obAte7KEvAzMnkF8TeX
         It7ZKfZaRaq5daeeZahsLX9EqGl1rqyfXhmoaWqrsdakXff+FNko17Ix7Mjn8yKjC1y3
         /hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911879; x=1785516679;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGiv6Xscnmlx4gMEVXMVRTWdGJsXLR2BdXop5F2AQBE=;
        b=HCohJvxg7ARHvtV1bHkTdWJhAnFJCfFjHguFyklC52NASqFlx6gTH/LGYvtKShDyzE
         mcVjthIznNZcvmDytNgaomQl+ff2K9Ge+F+ARgNN1KpwAAoq0C7OVdkm8w8kjb6N23OF
         O4GuaJwItl3M2PzIllzHhmBpt70iCTGkbwLEBMvau1UgUmZyTfHHAz6lqkM1HvAu7L8r
         N7xZbcpAb9QaPEbeGxk2pQC+73oO9P+deL10CN5juZCBgg88H2G59eEjbXoqnUOghoyt
         s+5/N7NYZcTvlNaPwMD6bE2NlRwxihyIvWRn+Z+5RkAXap9P3AZfi8u2oMV8T764JOa2
         dT7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoPC8dI+UqkCYRLCLQwvTX+23lRC9gq26Zsilk6k0zYXZPor7BfUwTKxt03vR71EmcvIxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgz3cA7w8lMD8DbzZqUhvrvu77tURGz0Z28Gi3YnEpgDP7Fv8
	jxq6+wmdV6UpZ16WoHKB2R2nSgo4uj2vD6LXdIul9DWzPIKZozV7xaNYbVCvAVMlFOVfPNTFjGM
	zvWgBD7b5z1kI4YizvcT/NgooJ2oxDTv1gFftZmOyNuWHG4orjcEsQ96T
X-Gm-Gg: AR+sD11riV/ACOIvshFlIRw97NmXR5aBBNCW49ODRIm+zA8L/2GxACuPe6AdUA+iMRl
	+G3uO7VPGAGJONU5DHWyA97JoJLWehws57cJvaUE54LwlGKn/dd2YRl2q0Rx4VsPZOYv0bG09o/
	r9lpwAHTp1YXytAkoo0nqGv/FfzOaYPmiDOqK2mDVvzjoAsn8xzu3H2UyJ9yPHru5JNJ0Ruc4Zj
	dk/MK3yWSreJhkUnX2twj3aV6z6AyTWNSymwmGkah3w0+tkbMr6oxag1Rq2aQTY9XpzyGAKgLpm
	r10K9KpcFDxfkrefV3zd22ZF8kYxQe6um3OSkFW7fuzlOy4K
X-Received: by 2002:a17:90b:4c0e:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-38ec648af5bmr7316123a91.6.1784911878269; Fri, 24 Jul 2026
 09:51:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 09:51:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 09:51:17 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amOByZH4oWzmO3Zj@google.com>
References: <20260723143034.175661-1-willy@infradead.org> <20260723143034.175661-6-willy@infradead.org>
 <amNeKcDZ66VrQ5PL@casper.infradead.org> <amOByZH4oWzmO3Zj@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 09:51:17 -0700
X-Gm-Features: AUfX_mwyv48CMhJeCiSTsLkrFrJx83-q7QT7s4fVGWdzAx4oC8CARZPYON4lVII
Message-ID: <CAEvNRgGs4Y_A6FAAnyrdUY2icmZ=iVPit31VWo0vxZiHFcyeYQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
To: Sean Christopherson <seanjc@google.com>, Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jul 24, 2026, Matthew Wilcox wrote:
>> Sashiko review:
>> > --- Patch [5]: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page() ---
>> > commit b4db4098463261fdf87a2e92b28ce2b4c9445e74
>> > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>> > guest_memfd: Use folio_has_hwpoisoned_page()
>> >
>> > This commit changes guest_memfd to use folio_has_hwpoisoned_page() instead of
>> > folio_test_hwpoison() to correctly detect poisoned pages on all large folios,
>> > not just hugetlb folios.
>> >
>> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> > > index db57c5766ab60..94eedcc7f1a9e 100644
>> > > --- a/virt/kvm/guest_memfd.c
>> > > +++ b/virt/kvm/guest_memfd.c
>> > > @@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>> > >  	if (IS_ERR(folio))
>> > >  		return folio;
>> > >
>> > > -	if (folio_test_hwpoison(folio)) {
>> > > +	if (folio_has_hwpoisoned_page(folio)) {
>> > >  		folio_unlock(folio);
>> > >  		folio_put(folio);
>> > >  		return ERR_PTR(-EHWPOISON);
>> >
>> > This is a pre-existing issue, but while looking at hwpoison
>> > checks in guest_memfd.c, I noticed a missing check in
>> > kvm_gmem_fault_user_mapping() that might trigger a host kernel MCE panic.
>> >
>> > If a guest_memfd folio is allocated (e.g. via fallocate) but not zeroed, it
>> > remains in the page cache without the uptodate flag. If a memory failure
>> > occurs on this page, it is marked hwpoisoned.
>> >
>> > Later, a fault could trigger kvm_gmem_fault_user_mapping() which executes:
>> >
>> >     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>> >     ...
>> >     if (!folio_test_uptodate(folio)) {
>> >         clear_highpage(folio_page(folio, 0));
>> >         folio_mark_uptodate(folio);
>> >     }
>> >
>> > Because there is no folio_has_hwpoisoned_page() check before clearing the
>> > page, could the kernel-mode write in clear_highpage() to the uninitialized,
>> > poisoned page trigger an unrecoverable MCE panic?
>> >
>> > Should kvm_gmem_fault_user_mapping() include the same HWPoison check as
>> > __kvm_gmem_get_pfn() and return VM_FAULT_HWPOISON if the page is poisoned?
>>
>> I have no idea, but the purpose of this patch is to stop kvm from using
>> the wrong API.  This is definitely scope creep beyond my level of interest
>> and the aims of this patch series.  I've added the KVM people to the cc
>> here, but I'm not going to do anything more with this review.
>
> Heh, you don't want to sign up for a week or two of onion peeling?
>

Looks like Sashiko is right, we should fix this separately.

>
> [...snip...]
>
