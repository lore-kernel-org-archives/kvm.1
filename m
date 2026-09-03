Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35986329
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394243; cv=none; b=i+DPOXatGIwW0N+JKxdzjGrbz5B6S37hYEM/49rnH46BOcej6DI6qniPCjxhSJA1PCAtgrHt0HWQmww2Ts+gdSHe82GNU6FfrCdApsNEg3pKRwTRNADP4HEmWqZIMos6tsiUTCSnMu3H1pxKKmKIz1UcoUBUoAtPheID+Bcm6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394243; c=relaxed/simple;
	bh=zEVE4VkRXoGtq5FLEuRQNOYsVnaBElMxxCZxBZwqS34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZQdf6KFnTbINc4EsbhRVmzEOvAdIOYqunHVqih9nhT2aWC5X4i//I7XxD91UMPbVbuG4szWuueAbAMdJhiM9izYs8+H1JfoDWMVa87ANYpuIxk+nctW71ow7Jx/KTfDDS6ZzGlolzRhRfuOhMC3N0uJnc9F+wSM1v22ywS1Oe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5LaSGJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5LaSGJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A56F1F00A3D
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788394242;
	bh=1HG4jQs0H27MEa+W+zQe3T3ePi8+ljHDYVpGxBtOdVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q5LaSGJCe2idLRH2WJZZO6S54oc4NaoPX3sEAidEG/0o58oOz+g+jXRWiXem9sHOC
	 9a4G9FbrtMyuqhTWzMTTQ5AsHcwpJ28othvNREwSoaop4dv8XUGCs7yF0DGOwkatYD
	 mAC7kmwcGI1Dp1UOihJJQQ9RwfCt+mfC+gaTjj4KvZJnSYnhgRhL2MLUkF2R7VQkwV
	 KGk9A9ZFEmqbycmgy8nbnugMYQxbA5MxxRpOSzSs9z+/Y1skurocAHZAj5zJtATVPg
	 EqreB2S5euSqK85oAgV8q8X19pzzoSN5JN9KBKsaNxdqF8mFEAhwQm4jQiJpBJMe95
	 ADZPrWwMM2PyQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2531f453eeso240113866b.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:10:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxRXKn3nVztpVodP+4rWQugKlyNCJl48BKzQbr+dRadZIWCPbIIPcXKM7Eof8oU0dvmY8g=@vger.kernel.org
X-Gm-Message-State: AFuF++n0GthCPqxmg8sOxHLJ8F/740gnjfxKIVAF4Lh6/W7joWf5oKMS
	LJURVwJ+q3z+fD+wIjsZ6DgcOR2HLV6eVFSHmTIJI269BVuKbHZANEVehT6XsXJCfwrtNWnJrNy
	cSyfQvbPXyqW85KYQHG57sXAJ1AERRw4=
X-Received: by 2002:a17:907:928b:b0:c16:12ff:dc93 with SMTP id
 a640c23a62f3a-c25d5509d65mr490835466b.18.1788394241271; Wed, 02 Sep 2026
 17:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com> <20260902232028.2767071-3-seanjc@google.com>
 <CAO9r8zPEqnp6Hcs9M8dz_n1MwSvH4H+kfr7EJfrMMqLgQ7fM4w@mail.gmail.com> <api5AjDG2dByAnXi@google.com>
In-Reply-To: <api5AjDG2dByAnXi@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 2 Sep 2026 17:10:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMWdNLDot27LxM=j4ijXSYariMHtkFYwtd6eObp5LFa8g@mail.gmail.com>
X-Gm-Features: AcwNN1VHRefv4Wo9edOaW6QwykwSjr0USw1UZG0JP6FPppQiuOQ6yXSUJvHDbhA
Message-ID: <CAO9r8zMWdNLDot27LxM=j4ijXSYariMHtkFYwtd6eObp5LFa8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: nSVM: Ignore EFER.LMA if EFER.LME=0 when
 preparing L2 state
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Sep 02, 2026, Yosry Ahmed wrote:
> > On Wed, Sep 2, 2026 at 4:20=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > Force EFER.LMA=3D0 if EFER.LME=3D0 when preparing L2 state for VMRUN,=
 i.e.
> > > mimic real hardware's behavior of ignoring EFER.LMA if EFER.LME=3D0. =
 VMRUN
> > > unfortunately allows the nonsensical combination, i.e. doesn't fail, =
but
> > > KVM itself has an invariant EFER.LMA can be set et if and only if EFE=
R.LME
> > > is set.   Breaking that invariant can lead to a variety of issue,
> > > particularly in MMU code that keys off EFER.LMA when determining whet=
her to
> > > emulate/virtualization 4/5-level paging versus PAE paging.
> > >
> > > Cc: stable@vger.kernel.org
> > > Cc: Yosry Ahmed <yosry@kernel.org>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 49fb10ad1f9f..23d29597d6bf 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vc=
pu_svm *svm)
> > >
> > >         kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
> > >
> > > +       /* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing V=
MRUN). */
> > > +       if (!(svm->nested.save.efer & EFER_LME))
> > > +               svm->nested.save.efer &=3D ~EFER_LMA;
> >
> > We sanitize control fields in __nested_copy_vmcb_control_to_cache().
> > Should we similarly sanitize this in __nested_copy_vmcb_save_to_cache()=
?
>
> Ideally, yes?  In practice, it doesn't work because svm_set_nested_state(=
) loads
> state from "save", not from "save_cached".

I was gonna say let's just pass save_cached to svm_copy_vmrun_state()
instead of "save", but then I realized the SMM Code also uses it. We
can make it work for both (macro time!), but maybe that's not worth
doing. Sigh.

> And even if we fixed that, it would
> then allow userspace to pass in garbage (that is then ignored), i.e. woul=
d undo
> patch 1, and I don't want to do that.

I don't think so, patch 1 specifically performs the check on "save".
