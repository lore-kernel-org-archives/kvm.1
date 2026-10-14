Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2549B5B7
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792018249; cv=none; b=Ety8416IEYMPpZlzuRBPf0UfwOvut5ozDC7YRRTwcNHPeRv7iG45P2OKrvSwWrvTTu/lASPygVPm5+2U3pAO9wfswUapXBlEnA6jYJRjc0t6lqYgxaqFhsp2cqwi5zCfvHu1gRFO7Hhx2Jf4GPmXV5OvzpPcA+V7MciNHyUdjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792018249; c=relaxed/simple;
	bh=sNWSUNEWYSzFTQdPXzbXHnNs2hssQisZGMz94U2GI+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzI1KalVYafDp3GzTL2GxrVhIz+ptFxqiD5PeRc7kSQLaBTEfkFdHa6zzXS+HXmuRWSwM2s14ESIH7qY7wHcQ5xfQiWPiThbncI4r+wIebJvQNGuo0qQVZLqGXVkjWaLuEJ3taGZ/toTIBb6hbAXBnBwrWE+hpIZEuNKJmnYmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5/qUqNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5/qUqNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106A71F000C5
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792018247;
	bh=NA3GZ/iqfIKKTOb5FvBosFUvqe1ZDVXt95Ijm3QAFvE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K5/qUqNgRX/6VowgTl20vWBdzIU3UV4i1FYwjthelA7Ut6efIQ2AbELqGz3W//OUx
	 rRPylqMw++n5iw18g4K9f32ISVM1zFQ/yyLAimK+kZUSCXZlHU+/unSbU1A7LpwJYQ
	 lW4e4oD2sjlGpoEjg0LDCbzR17AoDOPnWouCy5fUE7gzQYk8bdMCjr/WSHyhi3b1qD
	 ZupnkOvwYMOtubpU7H1brI0a9bf2phHy293C3v4dWHDdh5H6sRlq6YY9SSi/htn6qr
	 I1wFU+ryZzu+QXLbUcroXQg2oqcp1eVWdXVZcBbBHbRmqax92E9z/VZPxJULPGJdXY
	 bfkGMV3XHGOLA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c3ee49054ecso44829266b.3
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:50:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBywuu4NEB87AkwtOO94tjFJXhvBOnJB1Kpsiap/ifHVFlru41lXcFke+0xAdZgt0M4nMFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRUcbSHTRV0FFj7zDHgZg6lCx/sEQvasjDS39Lt6eZfTKPEjDt
	2iTBUtHmf4ylptl8711pUh5zOVCC0W9w+052xyp66AedxLu0MObCwTwjh3vFZ+1XthFmdRIdvBt
	hC8MVAHA5sHOmtDFsnrGCYkG31F2SXtM=
X-Received: by 2002:a17:907:cf93:b0:c2a:8d00:f8d0 with SMTP id
 a640c23a62f3a-c31a9a052c1mr1531899766b.4.1792018246026; Wed, 14 Oct 2026
 15:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-7-yosry@kernel.org>
 <CALMp9eSZoXs8vAswymwdiX-0ge-EOef8TR2nZw814wa63LpR-A@mail.gmail.com>
In-Reply-To: <CALMp9eSZoXs8vAswymwdiX-0ge-EOef8TR2nZw814wa63LpR-A@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 15:50:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM8S=VFjpbA5c7vLdzkQPJPM=YBFJ4Or9QKrOd37xTWGg@mail.gmail.com>
X-Gm-Features: AclHuK9omT0WScgNU6Co1HwqzEYPp0R6Qqcj779KshUYlOLBUoupZVq5-IxVYC8
Message-ID: <CAO9r8zM8S=VFjpbA5c7vLdzkQPJPM=YBFJ4Or9QKrOd37xTWGg@mail.gmail.com>
Subject: Re: [PATCH v3 06/27] KVM: SVM: Fallback to flush everything if
 FLUSHBYASID is not available
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 3:45=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > Currently, if FLUSHBYASID is not available when performing a TLB flush,
> > the fallback is decrementing the ASID generation to trigger allocating =
a
> > new ASID. In preparation for using a static ASID per vCPU (like VMX),
> > just fallback to flushing everything if FLUSHBYASID is not available.
> > This is probably worse from a performance perspective, but FLUSHBYASID
> > has been around for ~15 years and it's not worth carrying the
> > complexity.
> >
> > Move the fallback logic into vmcb_set_flush_asid(), as more callers wil=
l
> > be added and will need the fallback as well. The only other current
> > caller is from SEV code, and no CPUs support SEV but not FLUSHBYASID (a=
t
> > least according to AI).
>
> A more compelling argument is that sev_hardware_setup() requires FLUSHBYA=
SID.

Huh, I didn't realize this.

>
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/svm.c | 5 +----
> >  arch/x86/kvm/svm/svm.h | 5 ++++-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index ad4f172f170d9..0c3befd9bc850 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4326,10 +4326,7 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *=
vcpu)
> >          * unconditionally does a TLB flush on both nested VM-Enter and=
 nested
> >          * VM-Exit (via kvm_mmu_reset_context()).
> >          */
> > -       if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
> > -               vmcb_set_flush_asid(svm->vmcb);
> > -       else
> > -               svm->current_vmcb->asid_generation--;
> > +       vmcb_set_flush_asid(svm->vmcb);
> >  }
> >
> >  static void svm_flush_tlb_current(struct kvm_vcpu *vcpu)
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index ba5077b9838c0..3b59561d6cc2c 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -482,7 +482,10 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb=
, u64 data)
> >
> >  static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
> >  {
> > -       vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> > +       if (cpu_feature_enabled(X86_FEATURE_FLUSHBYASID))
> > +               vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> > +       else
> > +               vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ALL_ASID;
>
> This is unnecessary. Hardware that doesn't have FLUSHBYASID only looks
> at tlb_ctl bit 0 to decide whether or not to flush the entire TLB.
> The other bits are ignored.

I think it's clearer to do the fallback since the APM doesn't
specifically call this out, or maybe it does but I can't find it.

>
> >  }
> >
> >  static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
> > --
> > 2.56.0.385.gd3acb90ef8-goog
> >
