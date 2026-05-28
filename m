Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE66EEA8
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991033; cv=none; b=SoEeyDjOr3L3/g2Yw+4n0tNEInE02CkmFh2f0peKLdkROQVsm+Aky003XA+ByeuK045UpHnRxKKljLjr7y7lv9yEVqLrPy2498wVno/lsMQbT70YemwXE8JHHp8wOXDr/YQdjQGXN0IwuhzoG8CDkd/VVtTr8vX3ffM+Y968Nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991033; c=relaxed/simple;
	bh=ebEs6UlwDXpwVS/9E0xMnRBc1cCeBxMSXmp1KUZ8q6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eSanLvXRZlrZO/SslYtSj2TyF6Jc/dz+X3/m3XRshivH2Y15pX1fAnLpwFxYtKAb3ZqDcVrhhOxhqPNhi+G/TvjFjsxo3VVccFzUbty/ca8hMpNKmgrLDhXiR80BazAEBpfjbpVZo6ozOUe78210uHeW+a9WX62JKATir5HkyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8DqJXFE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8DqJXFE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so6217687a12.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779991032; x=1780595832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEMSSn0T8rB37WhRL7Ut7EvjCk5z+cpcWvTEziBYfA0=;
        b=c8DqJXFElKpHm4i4UMw0B54DaW9Q/hrFF0mxnvbxLjg2DS9eDBZ7YQMzGKihppa546
         qrdjmsQJFF5ZtCTDmYv/Xt7sjh8PrtJTToggOkYymRSjFL2EHmblnpwnMmQP7Tjrmy3r
         hVlT04XvRlKQz4fIpU3WEiiIPI6kgrzdkUFauf2gxOnck3Yo7ZEEaCNvV47YFBRjKnSk
         HFeTQvIRLMKEb1d1mckgyau25q0xNN1ZaHohL3U8WUSerlH0QmkBnzNlxN2P7eHUzF0w
         X3B/oedCgvnlguQTMH6A0yNBvjI4fJVm9fHrSzr6NWsWpFpczcuSuhEnPKdpSsP5T25/
         oJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991032; x=1780595832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEMSSn0T8rB37WhRL7Ut7EvjCk5z+cpcWvTEziBYfA0=;
        b=KMFw9zzsc2jp0jasCo6jwtRiR3VfVlgfEgHh+y6mXLH8thwymgXoj4JTzZj81jXA1q
         M4TbaJ2O5AVrermaTdO/8b2N8ZNcgz6T5jQh1rvFC3h/D15DUj/jv8133MVCx+GworVx
         GgbjzEVsjiqM/2BUNllaUZSlVWWO8wUEzRLZf7/a94IkWepX0XqgCDqy4nbavvrvcdTf
         HBAju0V1qZ0IOX8w9QlfciH2RqDb/jenrngQqXgTl9c/uvwED8dLE0LIStrH1ZmfH3hi
         rStB1inlLOeZ/igOf7le5ahtQR5IPtJnFsP8RMEI7OAgzHQ9HOlKPEbVY+zL7ec4EPRb
         OanA==
X-Forwarded-Encrypted: i=1; AFNElJ9/EP8xAc2MnKm55mLPx0gYcg641wWfEFZokL0MIXiQuTxjY5qq8D+EEOIoc8OkZRJG0+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0iN4nmeMQA6X8VL95ISC0iyr5o2EDCrFdc7/vx1VaYVOg1l4
	63Ca//YpTMNctcO182AjQKfU1lcWRTMLR9ps4Qb68vb0dcifRFk167URxIzngW2u4jpizVKW64U
	9ThjIiA==
X-Received: from pffy28.prod.google.com ([2002:aa7:93dc:0:b0:83e:ae1d:a060])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4392:b0:82c:e692:1f91
 with SMTP id d2e1a72fcca58-8420c1d8aabmr39627b3a.39.1779991031400; Thu, 28
 May 2026 10:57:11 -0700 (PDT)
Date: Thu, 28 May 2026 10:57:10 -0700
In-Reply-To: <CAEvNRgFAt2NSbK91Oc95iKA7eLo-3Pw==2X0PQvbonhVM_bZ7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528021117.107984-1-seanjc@google.com> <20260528021117.107984-2-seanjc@google.com>
 <CAEvNRgFAt2NSbK91Oc95iKA7eLo-3Pw==2X0PQvbonhVM_bZ7Q@mail.gmail.com>
Message-ID: <ahiB9uD1aeWt4H7P@google.com>
Subject: Re: [PATCH v3 1/3] KVM: guest_memfd: Treat memslot binding
 offset+size as unsigned values
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >
> > [...snip...]
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index bf9659a7b0f6..a1cb72e66288 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -640,15 +640,16 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
> >  }
> >
> >  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> > -		  unsigned int fd, loff_t offset)
> > +		  unsigned int fd, uoff_t offset)
> >  {
> > -	loff_t size = slot->npages << PAGE_SHIFT;
> > +	uoff_t size = slot->npages << PAGE_SHIFT;
> 
> I get why uoff_t is chosen for byte offset, but why is uoff_t also
> picked for size, over size_t?

Because size describes the max offset.

> Not trying to nitpick, guest_memfd deals with lots of sizes, byte and
> page offsets so I'd like to derive a mental model for using these types
> in functions.

Earlier you asked what I meant by "same domain", and I forgot to respond.  What
I meant by "domain" is that both "size" and "offset" operate in the "number of
bytes in the file" domain, and so should use the same type.

E.g. size_t isn't literally just for sizes, it's also used when comparing against
a size, e.g. 

  $ git grep "size_t i;" | wc -l
  476

Changing all of those to uoff_t because their effectively offsets, not sizes,
would be nonsensical.

> >  	unsigned long start, end;
> >  	struct gmem_file *f;
> >  	struct inode *inode;
> >  	struct file *file;
> >  	int r = -EINVAL;
> >
> > +	BUILD_BUG_ON(sizeof(gpa_t) != sizeof(offset));
> >  	BUILD_BUG_ON(sizeof(gfn_t) != sizeof(slot->gmem.pgoff));
> >
> 
> I never knew this was meant to show the concept/typing relationship
> between gpa_t and byte offset, gfn_t and page offset. Can we add a
> comment to explain the presence of BUILD_BUG_ON()?

Eh, I'd honestly rather not.  I agree that on the whole, the kernel tends to be
far too stingy with comments.  However, at some point a baseline of knowledge is
required.  For me, understanding trunctation falls well below that line.  It
does require the reader to know that guest_memfd bindings are gpa:offset, but
that too is core/basic knowledge that the reader needs to have to make any sense
of this code.

> Also, what's the rationale for picking BUILD_BUG_ON() over
> static_assert()? 

https://lore.kernel.org/all/aI05DvQlMWJXewUi@google.com

> static_assert() could be placed outside block scope which makes this
> relationship declaration more general/global. Putting it in the function
> makes it seem local (seems to suggest trying to assert some guard for just
> this function).

Well, yeah, because it is local.  _This_ code relies on the sizes being the same,
otherwise we'd have to deal with potential truncation, whereas overall KVM does
NOT.  The purpose of adding asserts like this is to document an assumption and
guard against future breakage.

Just because we _can_ put the assertion in a global location doesn't mean we
should.

KVM does use static_assert().  But without exception (at least in x86, haven't
checked other architectures), every usage is still co-located with the exact code
that relies on the assumption that's guarded by the assertion.
