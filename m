Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AB3033FE
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784990964; cv=pass; b=lq6N7rt1r+j89i7S0nxLit8fyvITKAIzl2I8cw/6nxvBfMROYtpth+p5OBSBKX8NKFKa9eRSbtWc3Kr8qa+Ga9l3JClxwhBozlwV3CaOo5g2aZJH1YKXDlC8mTZ5PavtH/i7RrCI3hvf+sSqovQml1x0Uf0+4EUuW/GuNkr2LUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784990964; c=relaxed/simple;
	bh=PJlzbYoU2Zu/ilJaZBW+itq6d70puCUStjY33RaR0YI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XP7Lt636dnG8VwgmIbmWleH9P0+yZPoZLaBUpaMeZxvsBeoWUeVn5MfeEl1h/ogKojXLxtDBHVWhPEmV2u+rNfcl9R8SK0tlCpFiBf+QeaYpB6BLSIDabVoE8YryEVjAYJ1W0FCCFskVJbGm26xiIxFCFwcEA/Jq3FWncsbPdw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riuDPU0D; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riuDPU0D"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1030299a91.1
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 07:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784990962; cv=none;
        d=google.com; s=arc-20260327;
        b=AlaQokRdjm8lFp+USsCJkUMmgGePGCHBu7QCoDsyiBt6a1gD/TGdJKp+warU+dnwnx
         FvhrilJYYtXTQtH3uOjnSh+r64vJEGQu+GYm3iwNe++WAnmjiVc8p8cwvRAGKphS2zAF
         XOjapx4scvEHEHR3yNgemYhPo+MrArabelQibhLjA+GcBmkRGo2wfjqSQXIjbEV/Q/m2
         jpu/OAOX4mWUYnvuUTBRqCenFLj/g1d60aeo9/4u8Z73S1kKk2kZRKaRZxKZcoDjyZhp
         XP8z4FHBfJFJ1u3OAn8ESKYf6bY5PQ1N6EWSXxUR1FIUncMag47VKzMqS71Xezh1nOpL
         Rgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EkD2W3YasFcCtvmMTHZ2R5s2b3BtOhhVBv8y/Tn1MIw=;
        fh=rwrYbFwf24hPID3nkl5yfZOxQTZWd//7Gp7H1M5VNFc=;
        b=QTkLvkGSBnYhTqr4kcs49DsVdM2QBKQa06JmfjngWRrlC0gtR60istOgD/9biGvpGT
         zKTt7JT5LM8Jw3nA4ZIcPGgG+Tp+u/KFQeeX5nXJh1XmqmPFZbzOAtW4xUl+FhA4V6f9
         pInF9j2y1lTGPWgaSnyUxrDcm2vpChU9TT2/L00evSAYTSd3sVJRYas5nOIsnf/L4xCJ
         jCO//Gl1+wWp0Q3UGA+5CtIJkW/owiTsrexYS7RjM+llyZL7fKLZxdmQNTwVefO7wEiS
         DyLDkizVqmsePBO1hpBrTys9g1Ki5HWQxyey7wOGjtwStLw/asJDYkFxUvZ2LmQlz7YS
         y25Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784990962; x=1785595762; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EkD2W3YasFcCtvmMTHZ2R5s2b3BtOhhVBv8y/Tn1MIw=;
        b=riuDPU0DIL7Q1JZETo5UmGi5ewJqXpEHTLRf4SlpoOQVvhZo2EPa3Pz7DHIGrccoZq
         oPQGQ26QA9GjeZ9xB6+ofVef6BYVmvWs2IKnFTe0hj0A4Pg2ZN76uPt2fVwQWZb7eYdQ
         A+ctSKBCJpFgfPMOLZhFfwssylIrD1fhRK/Z0YJtBDo/8XWKJC6DVld5z64c7wuvEPbz
         MxhGttMS0e6VZ4LKJygeolPSYtJ2s65B8UYdNifgQAgqTsqKdzdmnbKQHtW0GepBUncf
         t8iG1NDgbQj+OhqWQNDndXbKkldqwfBrI6Kx6D5VAUEEiG+Q7iAb+DL69WPovaDeLMh+
         Qepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784990962; x=1785595762;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EkD2W3YasFcCtvmMTHZ2R5s2b3BtOhhVBv8y/Tn1MIw=;
        b=EyTdCQ1Su0z68LZVVslbfpoVOuS89z3/L+doVEENrL6B3zQ/V+nGZO+CkzfCZ/HfAR
         YfPH+oTVYLjPAtw1pd8ikMswcfewJBGkvlKAvnTm+jjQOfuKjFMyq1Izk9cqtFmnuQbb
         gF6BkrQ2Aiz9uRDfo9Ph+NGEXHK0TNDs3a5KTon2JPtf48qMIuoZKw8trU2NuWgBr/ny
         JTZLcZmI4VKpveLcNfsPs9GZbzGOESUeCrTOj3aYu6sCwzjCKJOFQ/oCSVQXo+e0qlLf
         UrlYzI44l0cIG0WjCwE+J6acSZPasHDKn1UstniAFtsdUuUCE/nbFKqWKtvht9aODTiZ
         ssgQ==
X-Gm-Message-State: AOJu0Yxge5rmyM/cu7rxv10RuTys0o2u64mW/kg+MrYHLutuQv+0xR7X
	jtHPpBCFQ6fHY47ZxFncBcIPKiIkLEG5QksEHuKf9r6PQYvfmoX3El0EYajCi3HojV4bq/wfGSq
	Ld5D84WCMt0M4Ubii5a2Mu7h9Z18cX7jTRzeLyHHOz2e6kU7IthTtpAdHffs=
X-Gm-Gg: AR+sD127dIk8r3sf/Xys4h12O+oYawKeNTQrBSSly9m+te6svU3JyWh6iJMYa7XG3Rd
	2UcxmB4KXPv82hlUQyL6mFSLDY5cMcT9ankl/OuXvLLp9r1j5a2JPUDQFcfdvMkd68WP4kspt72
	cvHcdcH8e0TrgyXP8ZPcK8TerwdfjgfxQR9Qwhz4h/9PyWje8wtXYcmR7G4sdrIp2+p96L4Almz
	G6gcEZk2p1Asm3zYCFv+sFg79kbN9n/SHCUKi8MEJhdVEnSLjjX2TJ5w2ZqNoYXTKlOtZOSDWxb
	jeJvBQqlYDj8lVRWnw==
X-Received: by 2002:a17:90b:1e46:b0:387:e0bb:57f4 with SMTP id
 98e67ed59e1d1-38f2978d427mr2706602a91.37.1784990960757; Sat, 25 Jul 2026
 07:49:20 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 07:49:19 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 07:49:19 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723210811.72720-2-seanjc@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 07:49:19 -0700
X-Gm-Features: AUfX_mwBSeCkUM9wWoNV5ZeeQQQG3i7iwxC1MZDdtkzF_AAYe1Xe_USTALvzDPk
Message-ID: <CAEvNRgEeFxa38irBgpufU5Meou28psoeCd9yxwgpiODDBvnzcA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] KVM: guest_memfd: Pass the number of pages instead
 of the end pfn into .invalidate()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Pass the number of pages to "invalidate", i.e. reclaim, instead of the end
> pfn, as a first step towards aligning the function prototypes between the
> de facto "to private" and "to shared" arch hooks.  Eventually, the goal
> is to end up with kvm_gmem_arch_make_{private,shared}(), and in both cases,
> providing the number of pages makes the call sites slightly nicer, and also
> avoids any confusion over whether the end pfn is inclusive or exclusive.
>
> Opportunistically rename "start" to "pfn", again to align with the expected
> signature of make_private() (which needs to pass a starting gfn as well, at
> which point the "start" becomes noise).
>

I like ranges being defined as "start" and "nr_pages" because it removes
the ambiguity of whether "end" is inclusive or exclusive :)

>
> [...snip...]
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 171a9da1b685..ca1d93fb2495 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -530,11 +530,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -	struct page *page = folio_page(folio, 0);
> -	kvm_pfn_t pfn = page_to_pfn(page);
> -	int order = folio_order(folio);
> -
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +	kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio));

This could be just folio_pfn(folio) instead of having to pass the 0
index. The name of this function is free_folio() after all, so we'd be
invalidating (or later, reclaiming) the entire folio.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>  }
>  #endif
>
> --
> 2.55.0.229.g6434b31f56-goog
