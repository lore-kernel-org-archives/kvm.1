Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8D442105
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990832; cv=none; b=kPvo7JqnRByKTSoZiAkAhfyhmRCNCsNF2xl5np7CG2L2WX+/Gl41TE7fX9PI0wV2tDWJIf05F03lR0TtIHCc6QANCY+uLtIwetZqwgGMJCKBDhENWIfZTPx65r2jtwGIt32p68bFe9gcm2o8C5IM2ZDD9M2g+AJyb8YnslhvJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990832; c=relaxed/simple;
	bh=0/fvsUiPrwSradNfHPbewbh86ElFh0GYdyKxkNvocQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YUOU3LlJoZbrexH2Chm+ktoOUcOmRp4scJwL5V7NC7wrgrbxsUmuhgfyBOc+y1Ax4uTZcDayHtDSifqyhmMZNIw9ue2tKMz1pzagW+Ijlk1z1zmQBtPyGuQBN2KlG4rRR2mL7cEwT6A5QbPTU5G/eZ+PDg6kcYNm0WRl5E3ll0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuSsoGAz; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuSsoGAz"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc132709c76so8736720a12.3
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788990822; x=1789595622; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S0GhsBKioJjDRrC3kQo/MvHb6RZ/KMlhVtpCXE0/7VQ=;
        b=UuSsoGAzOxW0v0Q1GjJJlVA1BFy4910AJUA5vyeiekdJYXfhD56s7EJWTnKSgmJp+y
         zPoO9vaJEoFvdll5J3ZKQLdH05WEzqsjPCyRDUEeBU96sQMvpyI2HdE9aRC1gU70yCfl
         AFqogndIx1BohYm2aCCUjdH5e5XT6bi/4vUuSp5POyYrtIWDyYVccTr9NH8koBzj4e9E
         E/nLt/X+1NlJu6fPfRAPfvmUYw6ZDvfFiUhWzDBrfbEbg8TC6ILXfCPlr9VWpxHO1/k7
         IkyTQiiDpVtsbmcX6EOyDT60gFKTpcRsxdKvpIUZvk15xgiWy+hMmDdU+IxkCbzG08BC
         fQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990822; x=1789595622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S0GhsBKioJjDRrC3kQo/MvHb6RZ/KMlhVtpCXE0/7VQ=;
        b=H1T+y3Xk+pNP+NMu/fcG5O/uQrdweHThUaGZ+PIld5DxkWkBlIe5AYQzX2PnBauZHF
         oqxv9rjw/xgZy4pkdYwg2r9jsARZM2W4w2gpeWmmDbjgSTxwf5UhnuNXbtaySV/A7ri6
         K7Gg+AAgCFlufoIMv/SHRYikI3sWsCsqPmN8ShZA67SMh/vv/RZcV1VTcUcezOzcbE8E
         BOGjAZk7/ch/qKMo4nF6GDjY1eNceBQF0bicjgqBUY0xc3vReyNTq9Zj9FVy1vRyt4Jt
         iYOmLMWwpVPsJ0RlvHuySIAqvCPGKAhFv9vCeqlky29x+3L4pW8paELkP09GCdlI/H73
         ZTiw==
X-Forwarded-Encrypted: i=1; AKwUvBzxuNV/axDVPu7tLP/jL20wgRQ0b4Iylz04LtnxhrT5SmCt/+XxAjmf7qQpDIFe9Ri6Ws8=@vger.kernel.org
X-Gm-Message-State: AFuF++mWyUw9pFz/df+V9wLzgUFwWN+eg4P4uiSU+8VvbCEKLCwwTE+e
	SpPl358Czd+DYu7sTApJCyH+lnpaDo40dV37Z+q9fnUAvBE0oPIrEXjAz4un8BDEaBr2KsDHr8v
	Ef0bO0A==
X-Received: from pgar19.prod.google.com ([2002:a05:6a02:2e93:b0:cc4:3485:76b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:93a1:b0:3da:c10c:6aa6
 with SMTP id adf61e73a8af0-3dacbd6eacdmr5805086637.1.1788990822413; Wed, 09
 Sep 2026 14:53:42 -0700 (PDT)
Date: Wed, 9 Sep 2026 14:53:41 -0700
In-Reply-To: <b0035ada-8760-4c43-aac5-264d6b1d0099@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904004342.3162959-1-seanjc@google.com> <20260904004342.3162959-4-seanjc@google.com>
 <b0035ada-8760-4c43-aac5-264d6b1d0099@kernel.org>
Message-ID: <aqHVZdnf28ZuSNLA@google.com>
Subject: Re: [PATCH v3 3/4] KVM: guest_memfd: Establish memslot<=>guest_memfd
 bindings *after* memslot is ready
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 07, 2026, David Hildenbrand (Arm) wrote:
> On 9/4/26 02:43, Sean Christopherson wrote:
> 
> > +		if (WARN_ON_ONCE(change != KVM_MR_CREATE))
> > +			goto err_bind;

This is buggy, it fails to set 'r', i.e. will signal success but not actually do
anything (or worse, half-do something?).  I'm just going to delete this sanity
check, as there are already existing sanity checks that save KVM from the worst
case scenario.  More below.

> > +
> > +		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
> > +		if (r)
> > +			goto err_bind;
> > +	}
> > +
> >  	/*
> >  	 * For DELETE and MOVE, the working slot is now active as the INVALID
> >  	 * version of the old slot.  MOVE is particularly special as it reuses
> > @@ -1965,6 +1975,13 @@ static int kvm_set_memslot(struct kvm *kvm,
> >  
> >  	return 0;
> >  
> > +err_bind:
> > +	if (new) {
> 
> We'd never end up here with !new, right?

Correct.  I added the check on "new" partly because it felt so wrong to not have
such a check, but also to guard against any future usage of the unwinding.

Oof, but calling kvm_arch_free_memslot() is safe only for CREATE operations.  For
FLAGS_ONLY operations, x86 and PPC reuse arch metadata, i.e. trying to unwind
prepartion for FLAGS_ONLY would do more harm than good.

So rather than try to provide a goto sequence, I'll add a prep patch to restrict
the kvm_gmem_bind() call to CREATE (which is a nop because it's dead code for
MOVE and FLAGS_ONLY), and then this patch can do:

	if (change == KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
		r = kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);
		if (r) {
			kvm_arch_free_memslot(kvm, new);
			kvm_destroy_dirty_bitmap(new);
			goto err;
		}
	}

That addresses the new-can't-be-NULL concern as well as the duplicate code concern,
and can also address the bad sanity check above by adjusting the TODO comment in
kvm_commit_memory_region() about what needs to happen if/when dirty logging is
supported (KVM needs to rebind() here, not do separate bind()+unbind() calls).

And of course calling kvm_destroy_dirty_bitmap() is dead code until dirty logging
of guest_memfd memslots is supported, but it's harmless and IMO far less risky than
hoping future us remembers to add the call when dirty logging support comes along.

> > +		kvm_arch_free_memslot(kvm, new);
> > +
> > +		if (new->dirty_bitmap && (!old || !old->dirty_bitmap))
> > +			kvm_destroy_dirty_bitmap(new);
> 
> That's essentially the cleanup path in kvm_prepare_memory_region().
> 
> I guess with some more reshuffling we could have a single dirty bitmap cleanup
> path in this code.
