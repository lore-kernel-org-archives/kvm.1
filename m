Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5393F44EE
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182075; cv=none; b=N9T/dAVljSEpsguHDfOTF4AOC7mwf1cmbQqgBUwIIatFtau/emoljABjuzrxY0ej4CXqiyp59H6AkkWWOb2QiQWEluvcu2xgj9V2TEG/dTH5EdITt5lXfIIffI9NfDVZxrwnsu08gkXu1PybboWVqA7Q1nEfUh7UYQLnvmki2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182075; c=relaxed/simple;
	bh=/42qKKr2jsg+n3Ejba/l71EEiZTkZjitwTIwqPZJYgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j6cpOaqW65egJIL9/6F4HOwRhMMQW3E66mj/A5iH9pCG9jElwuso7JKxiCjlJeTqOy3y8iD8rCGkR3RLqeFkFhqD2xAWb/kzfsN7hK6AiNoVScfXrJGxijokL6/egyWzXcQl9li+pcIRxtQE9+eSSPWL+8lnZbHoMu4a3z3qdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndRiOSv4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndRiOSv4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bba9b849dso7376864a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781182074; x=1781786874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLqFAC1FpZpyQ/rqAQDV2LVjvRpkOTsPyzevdqyhqkc=;
        b=ndRiOSv4w7jY/pQrm01tQIa8sqBnDlqpMqTSHLD6WYUdaEF91AVr1MhgbDIB/j1ebt
         Olb8aXN76yWamEam7SJ3yQ5zcsRFPoaCOksLh1RIfLZyx+u3/RB3yWILLbFndLAh0gTp
         VLi6uk0UbMLClHjQAl4pcfj4tjo9ihkn/qvgghHPB/ed++stq2LA/Q/LNvA7H5Rg+3p6
         tfgXMCU9SIxllcPVy1jZfzcoAdJSiy2lURIVuDop0lKR6g6UGYrw8jCqhRhargWNNJHd
         m+/UxnvV2PYf9ah/JiyU3XuS1wb0k1+jc5AUmUtbeXXE9jSeB15mMh/hOdQHZBrBCLNY
         k0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182074; x=1781786874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLqFAC1FpZpyQ/rqAQDV2LVjvRpkOTsPyzevdqyhqkc=;
        b=j1cURK5YBZ6Kr3DhOdzenajrhuG0K7rfmnHJCg1PhmLG8tfluTBgt1hWvHRyNR3TYI
         1qQmTqscJm4NeOQoe1APpM7ktEyCJH+E3wh6v96ML7giXVkcPJoFMv+4qdTTuUDl5s7Z
         HJxxAmZFJYx1ky0dgYtm+BPYKZ4jtTodUT3Jkr2J0/AeyINxqgoH5jRRwLBR6hxyrzRt
         gOdGVfSxUjgCk98SnG8fnAOq6TK6TZmol8GYZhSN5AhT4eLRN3TRMqEaNDHYfURAMXVP
         nmYoq1Gt+2aOHXczPk/v+kwI7SynpzzuC7KeDjhs2ivrcCPJRs46qpe2qW8NMHttuMGX
         FJmA==
X-Forwarded-Encrypted: i=1; AFNElJ9bnRxeCEPX1D5HLPzXMdElEsciHtlMCbc4zn3gGgSgS53OU8Mw4t5E8HcWihxZxXcfX4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxElG3F+oO6QktFzzOIURyOY82oq/ivd/cQpePSPfWvnwyUF2d
	qPj75nCWU8ozRBdgj9ygRoigr1LYgFnmC7t696f+w9D2T8RSdYL8chAyKk4frkxJh40rlsyBFLX
	BQlp3hg==
X-Received: from pfbgi6.prod.google.com ([2002:a05:6a00:63c6:b0:842:5a9f:1cd0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:42:b0:36b:b9c7:35fb
 with SMTP id 98e67ed59e1d1-377a3e4503amr2937052a91.14.1781182073619; Thu, 11
 Jun 2026 05:47:53 -0700 (PDT)
Date: Thu, 11 Jun 2026 05:47:52 -0700
In-Reply-To: <aiqNPBQzoU9f8RwI@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aimMWzAf5b3luM0b@v4bel> <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel>
Message-ID: <aiqueNUndQsbMNud@google.com>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the host
From: Sean Christopherson <seanjc@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> On Wed, Jun 10, 2026 at 05:16:57PM -0500, Michael Roth wrote:
> > On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> > > ---
> > >  arch/x86/kvm/svm/sev.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > index 6c6a6d663e29..8fee6ec529f9 100644
> > > --- a/arch/x86/kvm/svm/sev.c
> > > +++ b/arch/x86/kvm/svm/sev.c
> > > @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > > 
> > >                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> > >                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > > -                             pfn, rc))
> > > +                             pfn, rc)) {
> > > +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> > > +                       folio_get(page_folio(pfn_to_page(pfn)));
> > > +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> > >                         goto next_pfn;
> > > +               }
> > 
> > This roughly aligns with what would happen if snp_page_reclaim() fails
> > in sev_gmem_post_populate(), while the guest is being initialized via
> > KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().
> > 
> > However, in kvm_gmem_populate(), we still free the page. Maybe, to
> > address both cases, we should just add a parameter to snp_leak_pages()
> > to tell it to take an extra ref and use that in both of these paths.
> > 
> > Or we can just do the direct folio_get() in both cases, the above
> > formalizes the handling convention a little better though IMO.
> 
> If I understand correctly, an extra ref alone still seems to leave the
> LRU corruption that sashiko flagged:
> 
> https://lore.kernel.org/all/20260610162623.061BA1F00898@smtp.kernel.org/
> 
> A gmem folio is on the unevictable LRU, and taking a ref keeps the folio
> on the LRU. page->buddy_list, which snp_leak_pages() uses, shares the
> same union as folio->lru, so leaking the page overwrites the folio's LRU
> pointers. Both paths deal with a gmem folio, so the same applies.
> 
> To handle this properly, the folio would need to be taken off the LRU
> before leaking, with something like folio_isolate_lru(), but that is
> mm-internal and does not look usable from KVM. How should we proceed?
> Please let me know if I am missing something.

I'm inclined to do nothing.  rmp_make_shared() should only fail in this case if
there's a fatal bug somewhere, no?  Either that or do BUG_ON(), because at some
point these types of errors are simply unrecoverable.
