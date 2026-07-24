Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083D41B8C8;
	Fri, 24 Jul 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897073; cv=none; b=Fha8AsCzebTh7oCWD4QpeUB1Q1j9rstDoBd9VCPEWqD1fZgy4sk26cs2Td8JcU+KkxoYzEmI/CtfbiGxq1T2KbUyTKs2BOp7lzw3cnen4FpGZpIVo45P+D+YT3QsBUPJLNxE+2IxegCYcPKCd+B4BRiDjfqHuGTQ27edAJ9MO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897073; c=relaxed/simple;
	bh=E8b1cLfxhhl3y9SIMMeI3i2n5qq9nPCgqz0DlTEoEJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsVbyxEyEp98SN4utJ1kt5CtmSprsWb5LgZfw4itLnMsuPJHhBUYqRE++kcnvh1TnxSFeGkgqG7hasA8AtfCWGVFuiFgca3fJJTfpUsx/0B5gxMoykK/6X27ZxdSOMID6IPrWcqewt7xMfXpEQkcUfjw109cthvvKkaGaRIHr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gJBYNxC2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJBYNxC2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lVEMUgfEWnX7KrIQBwc2fvPxeAGABcJWMxwU3Czcuzc=; b=gJBYNxC2k60KiJX6NJdA6zCvdh
	YaJNuoVQX6bSez7pvpgatwKNZs7h2/inypvRWSLFVWXwRv48qS+qxyZmJkV2xokyvrP7hXdnVI0HL
	LDhjviRXJ1Xlt3N9wNfdHdKiIACBNeQmC28r9RVILwR5kTyeWp4n0+vHdjyiu2kpzEfoV9eIzG5XA
	WNaKlL1XdRuFhY2AToIjmLBXIg4aZzr7lRef7SE54cE8ZY5t8nj15KcbgD0UBnKGT5c1u348fin6L
	rQoaMtuzc31gulokYa7zFpKC/3YwQ3+JaQhyjG/yY8/hSCfjA0E50Wihq5AZW425J4NEJIkuwTyEi
	EmoLjwDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFGL-00000003TqB-1EmP;
	Fri, 24 Jul 2026 12:44:25 +0000
Date: Fri, 24 Jul 2026 13:44:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Michael Roth <michael.roth@amd.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
Message-ID: <amNeKcDZ66VrQ5PL@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-6-willy@infradead.org>

Sashiko review:
> --- Patch [5]: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page() ---
> commit b4db4098463261fdf87a2e92b28ce2b4c9445e74
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> guest_memfd: Use folio_has_hwpoisoned_page()
> 
> This commit changes guest_memfd to use folio_has_hwpoisoned_page() instead of
> folio_test_hwpoison() to correctly detect poisoned pages on all large folios,
> not just hugetlb folios.
> 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index db57c5766ab60..94eedcc7f1a9e 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
> >  	if (IS_ERR(folio))
> >  		return folio;
> >
> > -	if (folio_test_hwpoison(folio)) {
> > +	if (folio_has_hwpoisoned_page(folio)) {
> >  		folio_unlock(folio);
> >  		folio_put(folio);
> >  		return ERR_PTR(-EHWPOISON);
> 
> This is a pre-existing issue, but while looking at hwpoison
> checks in guest_memfd.c, I noticed a missing check in
> kvm_gmem_fault_user_mapping() that might trigger a host kernel MCE panic.
> 
> If a guest_memfd folio is allocated (e.g. via fallocate) but not zeroed, it
> remains in the page cache without the uptodate flag. If a memory failure
> occurs on this page, it is marked hwpoisoned.
> 
> Later, a fault could trigger kvm_gmem_fault_user_mapping() which executes:
> 
>     folio = kvm_gmem_get_folio(inode, vmf->pgoff);
>     ...
>     if (!folio_test_uptodate(folio)) {
>         clear_highpage(folio_page(folio, 0));
>         folio_mark_uptodate(folio);
>     }
> 
> Because there is no folio_has_hwpoisoned_page() check before clearing the
> page, could the kernel-mode write in clear_highpage() to the uninitialized,
> poisoned page trigger an unrecoverable MCE panic?
> 
> Should kvm_gmem_fault_user_mapping() include the same HWPoison check as
> __kvm_gmem_get_pfn() and return VM_FAULT_HWPOISON if the page is poisoned?

I have no idea, but the purpose of this patch is to stop kvm from using
the wrong API.  This is definitely scope creep beyond my level of interest
and the aims of this patch series.  I've added the KVM people to the cc
here, but I'm not going to do anything more with this review.
