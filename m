Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3693E44E7
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015427; cv=none; b=EJZF1E6FgPcALDoW0iyJZr4cMnc+Qqf9nXC1cLhdVWOrSPoLU/hpTzSIuHKQia9bOf4wHcqhP5e8WRg4YsleCUh0MBlbI9/Ez3pdxOC5ULFWcM8EZcpIGrhnYIiuc/9niiqcikXE/5nHe7m6r+WV2B53HDJvz+RwJuu1A3uFP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015427; c=relaxed/simple;
	bh=Fn6DVI20NgmCdwNfyKMf/I+xS3M6RznJM1S3i14JO3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYIScWvC/mX/VR7Geu2A5Yynx3Y0veIyKk+W7LNtVRUduYarOctaOVhYyJbUS41zPV+OnWo9YI1cFos2zlVywElPQy4asM7ZLck9SGBxhDeAvQLGc5WNNwjzYLtj98owiK8OANlyENQimUD+KkAnle9pxBKYMh+RtnUhLNmx0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulak6RcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulak6RcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681101F000C7
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792015426;
	bh=NcJ+B/1ram+X1BKOW5jRlVpN7J7KKWrIliHk6GsANrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ulak6RcX83MUq9kOcohmmDTc/B0bliCug/84w+EbjsfvmJAiegl2fe16N/DecKugM
	 qRlkXt0mnxTCVzGLEyWs1oU0ODx0lspz99UidTZxj/zhBN07x/shCxobDYuY76E0T8
	 5GX9f43yJrwvzLxzC0waomFhPjsqgQUJWYBsQiOujFN2oBtM9KLuKe44o+SEpZ2WZ8
	 KsfI18UJ7W/dV1XR3Ix0/TaQ8U/QnqvOfYxXLxkk8JXxnxxGAWYUnQNtnb15QZ0NFT
	 ikzzOQaLw0TwUoCwBOOqzhNxrk+9gR6/wF5QdCNaMXi7apJoYwWzcTFBkLu32K0BUL
	 O3lJ8VEJUlsDA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2dc8cb0decso169874566b.2
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:03:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0e8WfsBDgH5/a0apXsWK9U2XCP8KzeYnz8G0j0rV1B10h6+iAIVj7YFHpltcPB6WnJCo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdsHt/sUv74jlTjQPouG6oe/KBbk/nPVslakG9YhJX4R012vxd
	pXbrBFOkxlDy9Xx4QHKZTovJmvfxpzKrkjegniKT9yuwmfa9iK88P6RjzLCCganBJ83P8v8AFdN
	N417qWz2LbQwogQ/gzEGWKV/tmBUoaRE=
X-Received: by 2002:a17:907:2d88:b0:c2e:3acb:34df with SMTP id
 a640c23a62f3a-c31aa0ae788mr1530061266b.39.1792015425354; Wed, 14 Oct 2026
 15:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-6-yosry@kernel.org>
 <CALMp9eSWazT=0tXKvGb9UNWBv62di33QgugQHOa+Bo2sq0qUCQ@mail.gmail.com>
In-Reply-To: <CALMp9eSWazT=0tXKvGb9UNWBv62di33QgugQHOa+Bo2sq0qUCQ@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 15:03:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPPR9LMtcwhH=D8gJLjmC6800mJdyV+nKT83TnMti7wJw@mail.gmail.com>
X-Gm-Features: AclHuK_cjgOO5VGEAYjtFhmwNLnG3Xti7ctD6pdrwU3G3vKiOI77BadJozAhsSE
Message-ID: <CAO9r8zPPR9LMtcwhH=D8gJLjmC6800mJdyV+nKT83TnMti7wJw@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 3:00=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > Introduce set/clear helpers to set tlb_ctl to
> > TLB_CONTROL_FLUSH_ASID or TLB_CONTROL_DO_NOTHING. Incoming changes will
> > eliminate the use of TLB_CONTROL_FLUSH_ALL_ASID except as a fallback
> > when FLUSHBYASID is not available, so the helpers will create a common
> > path for this.
>
> No functional change intended? :)
>
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c |  2 +-
> >  arch/x86/kvm/svm/sev.c    |  2 +-
> >  arch/x86/kvm/svm/svm.c    |  4 ++--
> >  arch/x86/kvm/svm/svm.h    | 10 ++++++++++
> >  4 files changed, 14 insertions(+), 4 deletions(-)
> >
> [ ... ]
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index 6d0242966dc87..ba5077b9838c0 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -480,6 +480,16 @@ static inline void vmcb_set_gpat(struct vmcb *vmcb=
, u64 data)
> >         vmcb_mark_dirty(vmcb, VMCB_NPT);
> >  }
> >
> > +static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
> > +{
> > +       vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> > +}
> > +
> > +static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
>
> The name of this function makes it sound like the inverse of
> vmcb_set_flush_asid(), which it isn't. Maybe vmcb_clr_tlb_ctl()?

Why not? vmcb_set_flush_asid() sets FLUSH_ASID and
vmcb_clr_flush_asid() clears it, right?

>
> > +{
> > +       vmcb->control.tlb_ctl =3D TLB_CONTROL_DO_NOTHING;
> > +}
> > +
> >  static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
> >  {
> >         return container_of(vcpu, struct vcpu_svm, vcpu);
> > --
> > 2.56.0.385.gd3acb90ef8-goog
> >
