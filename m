Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221A212F89
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767051; cv=none; b=ij1N7O9zy/9IaqrgM+2kQ4ow+SW+pzHHs/kAGqZq1gn98ghodvXwym+wZ2YhRa71FcZbmWYrra3WxJWG7xG2oRhdi4VqOlOI8bXD9AdW3lREaa+A4aFNAXgvP2Y09vam/at+IUIDtNSxiJhVb09XkCci+pwAqSdEyhzRyQWjpDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767051; c=relaxed/simple;
	bh=Yt5hbkRC9PjOkXytqszGtz6pUpPWAwfKd2toK8ODUDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+fyIbFT/AX8lWZz2lmK8XcUDfNDb9aa3laXyhUpeDBQIDGBFti50W6yoN/vKNujJcyThCqzk9I3lOdZsXA4f4wzfaNT4/wWIjXR9+BfFx/sWw1PLmd82FcdfpSlz2pfTKq7umbx/YOZ41htpGojKaoebGJwoECiw71ew+JY8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iv/EOv7w; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iv/EOv7w"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cccfa32670so1309975ad.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784767049; x=1785371849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BHbGiVuZLUHACML0nqP9iDubHlU79isIZOnCNGhwIGA=;
        b=Iv/EOv7wOtDP+HSB+xzKGvINPAChBoMLQ8eapwAE/Dsa+6IW/PuKyLLAatonnNB7pM
         NPyhKibNqUHtHuFQJjew34vx0swWIV3zzBG32X/nATajmppfcyOdpCWtGkjZFs8YwJhc
         wdJTCx8kD1OSQmY2J62jZ1EIid1TZjijYQ7mgOIO7OduzisB8f4itJmvbnzjmj6l7o32
         lsOfKRvwzzaA3jwTYECwZotCrCZn4YrrOdX9gNBKbGcpnYKv3isGAFQ4CYWoVSBtDTSx
         JviExFv9+Gyijfejq4NrwuCKWJpjcU2so2XUInpnOdeekTGIzcfexYMjxZwOQlHgLSLs
         4bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784767049; x=1785371849;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BHbGiVuZLUHACML0nqP9iDubHlU79isIZOnCNGhwIGA=;
        b=sdBdvb9UMFnqSzObwxebCU17G6p7BTUvcGYyvBxSrrFE+1nz6fObuQ6ksgpBSme4nv
         FM5GwP3ixLPFT0B1DqWvrmaHqsbf02Zp8+S+xMpGhk7TyEjlazXNurqVsBmnc4cEjZzF
         za9ShMNrK4ht9in3I1IuYaw/YCszqQrBcvn8LU/EOgapspcjrk6HgBgt9YB5clbS8Wrt
         rrobbRXHPD8I2rzaxmg3gIoODEJ+ScWZczukolk4CRY8wCjlvOp7rZZJG0pjuZLg3tbm
         zn0UxtVvtvi3tXY8ZtZNEy5JowrhjPfMeIC8lPkrQbLwWv648kZrMhiVxI7XNCyKv/KY
         97/w==
X-Forwarded-Encrypted: i=1; AHgh+RrzpmVmXrmo1tP/FOW23Xxczy0VKn4dEboWN+m+2FlInYQ66jiUObyGBNRhRszb8tfG96M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8OAYUsFRzqlCeF51n4wiX83MQEe6r89o+F8RK+n/noLMBKnV
	xDSouraV8Ple4f1gF2hcGKhIwC4YaI4P9Vm7hD82oGVFW48SehqTxVs64m3GBQbjuRjyv33Uykk
	ilku4Dg==
X-Received: from plhi3.prod.google.com ([2002:a17:903:2ec3:b0:2cf:3e66:d26c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac7:b0:2c7:ebfb:618f
 with SMTP id d9443c01a7336-2cfa6b73a76mr12595425ad.14.1784767049125; Wed, 22
 Jul 2026 17:37:29 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:37:28 -0700
In-Reply-To: <CAO9r8zNVPAeeiporS5aYFxdRUciaGwZGbnSg7Dr2XVpNFCvOmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-14-yosry@kernel.org> <20260616010534.2C8511F000E9@smtp.kernel.org>
 <CAO9r8zNVPAeeiporS5aYFxdRUciaGwZGbnSg7Dr2XVpNFCvOmw@mail.gmail.com>
Message-ID: <amFiSICO8Hqit7SY@google.com>
Subject: Re: [RFC PATCH v2 13/25] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> On Mon, Jun 15, 2026 at 6:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index dac3d0098bb77..4f13c3456a5d7 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > [ ... ]
> > > @@ -4213,7 +4215,11 @@ static void svm_flush_tlb_all(struct kvm_vcpu =
*vcpu)
> > >       if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
> > >               hv_flush_remote_tlbs(vcpu->kvm);
> > >
> > > -     svm_flush_tlb_asid(vcpu);
> > > +     kvm_hv_purge_all_tlb_flush_fifos(vcpu);
> > > +
> > > +     vmcb_set_flush_asid(svm->vmcb01.ptr);
> > > +     if (svm->nested.vmcb02.ptr)
> > > +             vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
> >
> > [Severity: High]
> > Could this dereference of svm->nested.vmcb02.ptr cause a use-after-free=
?
> >
> > If svm_allocate_nested() successfully allocates vmcb02_page and assigns=
 it
> > to svm->nested.vmcb02.ptr, but a subsequent allocation (such as msrpm)
> > fails, the error path frees the page but does not clear the pointer:
> >
> > arch/x86/kvm/svm/nested.c:svm_allocate_nested() {
> >     ...
> > err_free_vmcb02:
> >     __free_page(vmcb02_page);
> >     return -ENOMEM;
> > }
> >
> > If a TLB flush is later triggered and calls svm_flush_tlb_all(), the ch=
eck
> > for if (svm->nested.vmcb02.ptr) would evaluate to true on the dangling
> > pointer, and vmcb_set_flush_asid() would write to freed memory.
> >
> > Would it be safer to check svm->nested.initialized here instead, to ens=
ure
> > the nested state is fully allocated and valid?
>=20
> Yes. But if no one objects, I'd rather add a patch to drop
> svm->nested.initialized completely, and properly NULLify
> svm->nested.vmcb02.ptr in the destruction paths. Keying off the
> pointer makes more sense semantically imo.

+1
