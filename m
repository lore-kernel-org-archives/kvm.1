Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA349CE7
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115941; cv=none; b=dkc+g9AAW6k9AVlLqhbXW/ZEWIt69XQpzOb9G1RkNeI7eWrIqmg+CGVXjtnU+uL21SXnEN05YZM1DNC/hb0kefUcc62p/ST7vogdQMZeMTVosoKfwyekqVH91vreJT5fD9iDbG9zOvqhJGiOMA/p3jD38hITu6v4Z1SkRHGjKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115941; c=relaxed/simple;
	bh=yKq2Ui00JXDy2Up9TpO1zuormhAd0uRGnQ1pNcg5FBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nM3BCs15f2HlIxiGhr4dt6IO2AtMxZwb2MQxB8JzW1nPKw20GNi6OkcUoVpwtAik308VEtvvSqqWRYqe7IxRF14f5hFLBt96lvNfLJnpnqShI78kj8rfgJvoOl6mNTzeGVlNGq7QbVIqdq1MDgh84RuTgGjMBElo6XTeBbzoQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlAbULC7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlAbULC7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bf6904a6so104130465ad.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781115940; x=1781720740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kB5UUPePlwgpE8nklgBfMtK83uf+7umzGBRIUNT+CTg=;
        b=jlAbULC7ZbKNTBfiRh1dDpedXH3FOUxFufum/EE0XTDh9UjR8PGNrvo2i6aU3g8k4h
         /Vgh4h8CFwnrNI1fnNXYpYVu8N2jKRP0lqG+jbZ41G5D4yGIjhxckKOAR5jAo4tSvDU0
         qMrfjCor+mruG3pA92IViDc2p4A2WHqYFDq8r7ROnE3Vl70sj6JpjNyy2JDBjFTmwUSi
         jTDr7KWZp+THwVs9+yRpXCZ75z/Crqszjl74HdsiaflvCiiv6DHvEr5vCORSnOjPR9T1
         tnR/1NU095KSQO6I+tUwIqxYReN92LIRGGHjq3nGJHaB3xcYVz+sjVnL25EMXUsZU7xc
         IpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781115940; x=1781720740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB5UUPePlwgpE8nklgBfMtK83uf+7umzGBRIUNT+CTg=;
        b=euRIbTux50QyVYSk+j+KAylI9GFJfnQyjxKNmmHdC/aV756V7kghLHRY+mG+znv8Do
         uOPZqBMMRym4IIXV0JqJCE2zjXYjgWcW3HXrQdqOE/9/YGmM4wNiS7rRkJ/pZPGhJ5H9
         oe7i7zBJsA7Fb7laLmI3/vv7n2an/vqdpuBmzMWu+/osIOfP7bEZVis9h/V6yoMTYDHi
         7VT4/qXNLQtyNQoUKtqlvFl0qi2AFsFL+FHMAF0ltXu7EDhmeN7g5jBwRRZUjFU1Q5x0
         agKs/AJn3nq6D42LZZpMwAQOk2k6RCBF/+zpqCVO3qvfltvXw5u0FuTh7Z3sFbk6jLwP
         NjEA==
X-Forwarded-Encrypted: i=1; AFNElJ/Aumhzh4HevyrJvvuCTignXXWLfmTuN3CYf6upAHA9nY7cjDlTLOvm/MwY4F/d9W5jFs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWBt7zE8uVAQky1iLJYoAA8NabFHL9cjIJ4YZyTnNwjMPra1u
	29YCbR/dfWSAKVd+cQBSxX+/CvP2Wecv+o1Vt4MB57rcXop2AzBCqRYUbxmHRDxR1otHefHd7ZJ
	Jg72h4g==
X-Received: from plbmp5.prod.google.com ([2002:a17:902:fd05:b0:2bd:c925:e1dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1247:b0:2c0:b35d:ed54
 with SMTP id d9443c01a7336-2c1e85e04c7mr306277645ad.35.1781115940004; Wed, 10
 Jun 2026 11:25:40 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:25:39 -0700
In-Reply-To: <20260610162623.061BA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aimMWzAf5b3luM0b@v4bel> <20260610162623.061BA1F00898@smtp.kernel.org>
Message-ID: <aimsI-8mcO9oCq_q@google.com>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the host
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Hyunwoo Kim <imv4bel@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index f59c65abe3cfa..dbde6dce79b76 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
> > @@ -5036,8 +5036,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> >  
> >  		rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> >  		if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > -			      pfn, rc))
> > +			      pfn, rc)) {
> > +			/* Still assigned to the guest; pin and leak rather than freeing. */
> > +			folio_get(page_folio(pfn_to_page(pfn)));
> > +			snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> 
> [Severity: Critical]
> Does calling snp_leak_pages() on a pinned guest_memfd folio corrupt the
> system-wide LRU list?
> 
> Memory allocated by guest_memfd is added to the page cache, which
> unconditionally places the memory on the global unevictable LRU list. When
> guest_memfd memory is freed, the folio has been removed from the page cache
> but is still actively linked in the global LRU list until its reference
> count drops to zero.
> 
> By calling folio_get() here, the reference count is elevated, keeping the
> folio on the LRU list. Then, snp_leak_pages() unconditionally links the
> page into a tracking list via list_add_tail(&page->buddy_list, ...).
> 
> Because buddy_list and lru share the exact same union inside struct page
> and struct folio, modifying buddy_list silently overwrites the lru.next and
> lru.prev pointers of the folio, severing the global LRU linked list.

Yeah, trying to prevent a folio/page from being freed from within ->free_folio()
seems like a fool's errand.
