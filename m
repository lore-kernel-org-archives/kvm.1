Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036236;
	b=RWulM/Jl2nBsEeZr15WmpPEyOw0GCz1jPj31LzI7Gdqij7Ra9KKAOK81RFIE3OWqVM4O
	 dbycMghiWq2P0MJtOMTgNBiFwT0m82H45olLAcvxuAiG2qADNQ0OWC8vQm9M5xkCdLra1
	 cO+EpRTrJ0ltageSn+ZcONDW9W1nJTEERU7JE1Lwf8lC7M5y/WTkrsGb11G08bQBT+WAB
	 efuegXIV/9qIMfFqU0jXc70Yy0bGbVXPeTuF++Xbr2utSrit6n5wGS5mqQYHDF1yN7cY5
	 /5fICxWcsMWBRQZSbDbYIjWVcWo/j7HYFlx8yE0IFe6BHWIrqNWNNy27+CyfrItLEAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=u3uDBAF1Ovkb0RC2KTlASMQ4Rd8WYJb+WLyWCC0Ty9k=;
	b=f7B363bZ89fYT0rmjFZaTCrx8ZFL0fznbUl17tNcF3JWivJOMy+VKvb+/d6ioU8C+21a
	 t/e2YVxTOXw6h9XUPoyFy1LA+48emLGyJjpzMKOsu0Td7M0z7ESibO+Xgj34vlSML6HtX
	 cEENmqvuXJuN6bS3pS7O0z2vewe2MoCA+AU3gSNZxmUzXlWLHb422EHm2hxhreZ3X2nzr
	 JaSU0TWS7rfgY/tLr0P31ngFpCqYK50PEpYb3SPahH9DiLGcXPGrnaNNtbP5iDgi7bv/e
	 jeaN6aXO6cEBqPKBik2uB8ZyVX6yVt/L4HFBvWC3r7+BI9G06aQtQBQ6Cp3JhOSL0ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=P02yuksC;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2A606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C2A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=P02yuksC
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea446ea8c9so829805ad.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793036236; x=1793641036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u3uDBAF1Ovkb0RC2KTlASMQ4Rd8WYJb+WLyWCC0Ty9k=;
        b=P02yuksC3DvUK68oipBNIgX+rOQVFqmFViaa3wC8WfAKmnslU0xkePJYWNtE1kRXus
         8hTv94aeZCNTC+Vip/VcqniQmXZnNk9B59MH18/lL3pnSZyTVwKUjORBEP+LBUSB4Cy/
         doTdKpFYXjgoaKLdukQwUy/MVat7OQ2lgZ8lz/Za3CiKR6IsDK9OtGYquwvtlP2pgUVO
         0uHQ3pZ96NpE5c6L8Z32hjznLu8lZzLeIMU1uacsGDFLNQNQFYopyPd1uZpjjrfyyuOl
         gEOU/Qt+SKhEyNpTBsP7eM9890DaZaX9TDHCAi2jOMQIPS22T1KxNBN1p8YJi/rbp+Mq
         RH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036236; x=1793641036;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3uDBAF1Ovkb0RC2KTlASMQ4Rd8WYJb+WLyWCC0Ty9k=;
        b=cGkWQz5b11R0d9A9giFwNvSKkPDSzQBoVJ/QGaBYfFUSKg1xJ+kxqtzf7nU/rdz0ZL
         YZagQOnF1pLz90OfOqw4TeDbiWCfMDFzQBOtiB2b8ahpz6RZSmYqQnY7/iTrOFTg+Nov
         ca9d0Qb3MVZELmpG8IW9Y0rulGb1+DAkPahYyFiDCvcQ9QKvixW8HwsQG7N4GRk5xTkM
         v5MdBS+a9Xp7lFJ0s8V15Dz5HdHueNKu+o2hui+8BkXrk1hPssk504CrC6Pmi7fl+JDE
         RyUFGdHZ0bga9nNff6BiDMQV05XQ3wDqUs2FdxWfmpZmFQebX8P06LB6ODOdTjk/yQYU
         Mv0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxUxSRA6u09LrtyjPrGx0O1L0va2ed8fmlyhljKQyFAFJHgxWvFyW2yAQwMH3dA1KneyDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJc20U3UfMkW/XiNybie8lxPH9T3isz6QpOEyuekEHL+TREYD6f
	ghUhx4xnR5fTlt9SRHHtE0q4Qljvhk9pJ/EvFw1Sq2rQN7XqGvwWkER7e7DyAIRXQ8KRG7Qrb/p
	csBGJWQ==
X-Received: from plkq2.prod.google.com ([2002:a17:902:edc2:b0:2dd:bff7:1e38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1109:b0:2e9:b831:29ea
 with SMTP id d9443c01a7336-2eae40c9849mr1522565ad.40.1793036235657; Mon, 26
 Oct 2026 10:37:15 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:37:14 -0700
In-Reply-To: <CAO9r8zNbieeCQKLjfC4vhaeS_mgFJc3Ex9xKKmKQHL_43j9axw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com> <20261022223052.646891-4-seanjc@google.com>
 <CAO9r8zNbieeCQKLjfC4vhaeS_mgFJc3Ex9xKKmKQHL_43j9axw@mail.gmail.com>
Message-ID: <at-Pyu-tvtPEXOxT@google.com>
Subject: Re: [PATCH 3/4] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, Yosry Ahmed wrote:
> On Thu, Oct 22, 2026 at 3:31=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Recompute EFER.LMA on bare writes to EFER (via WRMSR or KVM_SET_MSRS)
> > instead of carrying forward the current EFER.LMA.  While it _should_ be
> > impossible for EFER.LMA to end up in an inconsistent state on such a wr=
ite,
> > KVM has had a rash of exactly those bugs, mostly because SVM is quite l=
ax
> > when it comes to consistenty checks, which in turn bleeds into KVM's ne=
sted
> > SVM implementation.  Retaining the existing EFER is also rather confusi=
ng,
> > as understanding why keeping EFER.LMA is correct requires a lot of a pr=
iori
> > knowledge of both x86-64 and KVM.
> >
> > Keep the core concept of the existing logic as a sanity check: WARN and
> > reject the write if the computed EFER.LMA would be toggled, because as
> > described above, that _should_ be impossible.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/msrs.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > index c3cb1575fe66..41f3ec6eb286 100644
> > --- a/arch/x86/kvm/msrs.c
> > +++ b/arch/x86/kvm/msrs.c
> > @@ -638,8 +638,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efe=
r)
> >             (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
> >                 return 1;
> >
> > -       efer &=3D ~EFER_LMA;
> > -       efer |=3D vcpu->arch.efer & EFER_LMA;
> > +       if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
> > +               efer |=3D EFER_LMA;
> > +       else
> > +               efer &=3D ~EFER_LMA;
>=20
> Does this mean we can effectively revert this patch:
> https://lore.kernel.org/kvm/20260902232028.2767071-3-seanjc@google.com/?

No, because that flow goes straight through svm_set_efer(), i.e. doesn't hi=
t this
path:

+	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
+	if (!(svm->nested.save.efer & EFER_LME))
+		svm->nested.save.efer &=3D ~EFER_LMA;
+
 	svm_set_efer(vcpu, svm->nested.save.efer);
