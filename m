Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194569;
	b=M6FIiwl5r3x8hhyBC2J5a3n56/X66IiaucCOAfirXSpZqr1GgFS+ftajeQQWvcxkHocg
	 pzlCzEHdWxoSis5kmyVAWIaSqN8GF/f7nPHIxgnzG6xWvVYoTK/afj2DvlZSEDdV+SQkA
	 m6FcBSzRvtG04eLdftJNprnG2MvG5Mk2xs2kRwcDMrZEvfob8NsyogPaCsN9BjuqBFyUM
	 73LYKkAYfQJZR82AjGrXDpnLMR8kZbxVdCQqxAnguEHya35C6VtYuTKRGy1KrGwxYO/fv
	 aXZbKgQ2QbiBBOksSMQpWytdeAo+92TzZA6hy4Gay+EcvfUt0+J//um3mnN/LQs54lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=dt3rSnBB6NYuH76zM0DgX0aBcI7Km/ORd63J5MEsc2g=;
	b=Ez2MVi2V6cE/SA4cb7vuTtN/Jh9XdVaooU6+mBg1039Da9kEr6zxTvAEotWBe+SReM8e
	 LPQ9/eCrgBVLJ0d0hKe/1gGj/2T/NvRVb6OJoZyLqXaJ1xOt/cxi6DnvfHk4rgXvmLOuX
	 iOjZMGmcqXk+1WTtHQkaYIK1tsOhDakxFMGkoMLbq7I/5YgxvIEPpogQ27P2fxeln5T63
	 s+hn0cJxCSnh3ZEnx4zDxWjVuzprQDyq/6SKwVtV466gxWdRuWuK+XvRSvu4r6zf5DWRw
	 8c37udWJwwRaMO1c7zY/USpz5H7vNXTYUSjQl9l5WkLbnAdFMvP19ZeK5zlSEmTAn5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UaBdrW1s;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD570606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD570606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UaBdrW1s
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e601800e58so16112245ad.2
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793194568; x=1793799368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dt3rSnBB6NYuH76zM0DgX0aBcI7Km/ORd63J5MEsc2g=;
        b=UaBdrW1sWlHQAcS/+N+c2Il1L+5MLovpqJX789BQ/xpzIfBFJx9z5JX2zMYe2QQ+mL
         BKX/tIADBTZVCqJlYqKapebToVv2JtavgaGKrGpGr3LIkvQ3kUa1zAf2nn8pwpeQ+Fug
         0SfP0X90X36ukAPwUZ2926UqpkV2VP2uH/0A3iYU0hpoLccvKo27JqIqU/V0TYqgZcZk
         ijtf2yPDj/0eUy1u2qFu3aisyLYWvitHTjgTuFCkSARm9+0aLc4FzEO4PzXPn4ZVecjt
         ve2BHSRNr1ITz4sMeLzRrYiBr2KHRggO1vLf98b0K4sefcg9f6WxchzBltiiDd9qIA0/
         K9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194568; x=1793799368;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dt3rSnBB6NYuH76zM0DgX0aBcI7Km/ORd63J5MEsc2g=;
        b=QWwTUrrV2wMgatVEL21cnaVTQuKwVjXSMSWAH9mk86xfiRsNqyP+sFFXQXbjwkxb09
         /MXfFDGdNk6Lhs1S+QHUHeLIMoNc+jB4t6mgiqqauRnTEo1P8VZC94U/+KHnbyj0JeOD
         MmvKdQuNBZTCNHgQn2Xqi3x23BNn3ODydmuhh21D8U6Cbdwk1INq7gerXnxU/IExoOZb
         vtzUVbCkjlF4vEBo+nVSfPC/Cc3HT+BMwCuTHid+Qkj72nTWgZwlvD8f9vNuTkWW1xOo
         ydsiJcTu9y3QxePW35lezUFHimMLl4RHptfiTLPKy5Qzd2d5+U3wv0Y7JPzgP7olqqAv
         6r4g==
X-Forwarded-Encrypted: i=1; AKwUvBzr2oBGo6D9UFZcH/u1HC7lmIcNaCb4SQ+oUZApWj0PtIqByDsS2r+jgHzAQyKb8Lo26xM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZP/nZ9cNELhWNkA+KieMKkesKE8Dmh/vo+JECoaG4N1DbCJEL
	JMV0JtuRh+52y/RlBdi0ztWr6bntIBAhUAxG6XSczVhxBXZkxqZz9ZfSnE7fP+0Phx0Kjf8TzN7
	Q0urGLw==
X-Received: from plwp2.prod.google.com ([2002:a17:903:2482:b0:2e8:87fd:f180])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc3:b0:2eb:5e:35d7
 with SMTP id d9443c01a7336-2eb005e3608mr21355465ad.15.1793194568038; Wed, 28
 Oct 2026 06:36:08 -0700 (PDT)
Date: Wed, 28 Oct 2026 06:36:07 -0700
In-Reply-To: <CAO9r8zOnf_AiBJfTJTO9jS6cYj6bUxhDoBsNdmbeP_jaQnLCkw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com> <20261027224914.1574319-3-seanjc@google.com>
 <CAO9r8zOnf_AiBJfTJTO9jS6cYj6bUxhDoBsNdmbeP_jaQnLCkw@mail.gmail.com>
Message-ID: <auH6RzFLvSmCKbXY@google.com>
Subject: Re: [PATCH v2 2/6] KVM: x86: Reject clearing EFER.SVME via
 KVM_SYNC_X86_SREGS if L2 is active
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026, Yosry Ahmed wrote:
> On Tue, Oct 27, 2026 at 3:49=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Disallow clearing EFER.SVME via KVM_SYNC_X86_SREGS if L2 is active so t=
hat
> > svm_set_efer() can treat yanking the vCPU out of L2 during KVM_RUN as a=
 KVM
> > bug.  Ideally, kvm_is_valid_sregs() itself would reject attempts to cle=
ar
> > SVME while L2 is active, but the risk of breaking userspace, e.g. acros=
s
> > save/restore, is too high.
>=20
> I am confused. This says we shouldn't disallow clearing SVME while L2
> is active because we may break userspace..
>=20
> > On the other hand, yanking the vCPU out of L2
> > during save/restore is already "broken" as doing so would queue a tripl=
e
> > fault for L1.
>=20
> ..and this says it's already broken.

Gah, the "save/restore" part is a goof.  KVM_SYNC_X86_SREGS is already brok=
en.
That should read:

  On the other hand, yanking the vCPU out of L2 via KVM_SYNC_X86_SREGS is
  already "broken" as doing so would queue a triple fault for L1 (because
  "wants_to_run" will be true).

> I suspect you in the first paragraph were referring to userspace
> restoring a vCPU not in guest mode on top of a vCPU in guest mode or
> similar? Might be worth clarifying what exactly we don't wanna break.
>=20
> >
> > Link: https://lore.kernel.org/all/sashiko-outbox-182127@kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/regs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> > index 3621f1a47d37..e53496fdeb82 100644
> > --- a/arch/x86/kvm/regs.c
> > +++ b/arch/x86/kvm/regs.c
> > @@ -738,6 +738,10 @@ int kvm_run_sync_regs_from_user(struct kvm_vcpu *v=
cpu)
> >         if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_SREGS) {
> >                 struct kvm_sregs sregs =3D vcpu->run->s.regs.sregs;
> >
> > +               if (is_guest_mode(vcpu) &&
> > +                   (vcpu->arch.efer & EFER_SVME) && !(sregs.efer & EFE=
R_SVME))
> > +                       return -EINVAL;
>=20
> Do we need to check (vcpu->arch.efer & EFER_SVME)?
>=20
> If that's not set, we already lost, right?

This is common code, i.e. runs for both VMX and SVM.  The vCPU could be in =
L2
via nVMX.  This could check guest_cpu_cap_has(vcpu, X86_FEATURE_SVM), but I=
 worry
that would be more confusing overall.

> IIUC, we can't be in the middle of save/restore here. Is this intended
> to check for the situation where userspace cleared SVME while L2 is
> running? Or maybe L1 cleared EFER_SVME from under L2 but the shutdown
> didn't happen yet?

It's intended to prevent syzkaller from abusing KVM_SYNC_X86_SREGS to trip =
the
KVM_BUG_ON() I want to add in the next patch.

> I suppose it makes sense for the sync to only fail if it's actually
> changing something. Mostly just thinking out loud.
