Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A41322B8C
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968887; cv=none; b=VabbnsRpdQBM0vWGHunqoj+YJHY16zoFEWxx0HM8kbj1yvkGjzhXypozdA63W27zPFw6aW5DGySwEu5kFzhEuNYU6cUXibULnBVrkal/1vVjJO+xnX03pU7kFWqnp9//6YRE2pT0UWdx0RCggkzOwVZW07p3NPRlfDzcMLdH7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968887; c=relaxed/simple;
	bh=8Aqo43b5HcFmqCxaRsPpupxPWhwBoEmRb/JAjQdogco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0go3HR1TIJEQYP+Z8tt8/SFVaSPjOHrjm4PkS0nQFuZu7LyaZB5JEwYrBOBdQVHepLatAN2Idhsp2VHTJ+szXplVUSnRvKshujPdI4PZPjrLulvBFdhdqWxmraJGZ6/5fSOsvNs/P4frxS40hfrb0qb7Y3T9bw1erxGOzw3qj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBd1ttIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBd1ttIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4A21F00A3A
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783968886;
	bh=5SYoblZzCCT1HwzF+g6fWpTbc02Fi8F61v/SMPPoUkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SBd1ttIxk6Hy+NVoo4O+QRrx64omaoxlWUTme77deVsgxV6zUeACWRitqCV65WFzb
	 QWS5nfGcNK96g+Q1hyh0fMU/LVYg1kaItn4Ec76SLLDv45A8qeXbXOf94Z+gnm2Qab
	 ycRRZ7x9UtvO+Sjh5zL7UKb22DQgtG/qkkmr1zecRbKimOvB9cN7pyaRoDFEySHLu0
	 W/Zgou3nl5VVuXoLxun9MB2mwvS8q6oi0g5qkSbyYsoPvpdDa3n/s0zx2zUauid0BF
	 jnX7PIAJjzffmcxVrj8+RQnCdTKS2RxXLOKGzhbUMzg6oPBm+k23ynty5yzhKwytMO
	 YfcZYryIviH5w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c160420289bso432402166b.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:54:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz+ZV31v8bzl5f8DCpc4Fb3s3omEZEs3K0SWExdKRfRyWyzObw9
	sHW76iETQx7PNEvYX3ICaaTOyA0cmXd6gHCEGCxlz8vk1YBt14VvM5vyPmzt3csjcSG54KFLeI5
	FzP1MCMDjO1V45Cbq8tLCVQ5O2X4CHks=
X-Received: by 2002:a17:906:ca8a:b0:c15:dd3d:c6e1 with SMTP id
 a640c23a62f3a-c161eb9ee25mr311855266b.37.1783968884970; Mon, 13 Jul 2026
 11:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
 <20260713181413.94A481F00A3D@smtp.kernel.org>
In-Reply-To: <20260713181413.94A481F00A3D@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 11:54:33 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPfZVTYQwgGhJtowcmSETUb4NHPB45_jwA=oXggUBhVQw@mail.gmail.com>
X-Gm-Features: AVVi8Ceo8HDlNN4kswAVe0YW6PXBuS2V3nJDmilOM24GeW41uQB1ya06ZVbRUDg
Message-ID: <CAO9r8zPfZVTYQwgGhJtowcmSETUb4NHPB45_jwA=oXggUBhVQw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:14=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the return val=
ue of `kvm_x86_call(set_efer)` is ignored in `__set_sregs_common()`, leadin=
g to a silent failure when nested state allocation fails.
> --
>
> --- Patch [1]: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SR=
EGS* ---
> commit 6edd9e84461af3c58ac965b84f89b7c4985ddeb3
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: x86: Check EFER validity on KVM_SET_SREGS*
>
> This commit adds checks to validate EFER against both KVM and guest caps
> during KVM_SET_SREGS* writes, preventing userspace from writing bogus val=
ues
> through the per-vendor set_efer callbacks.
>
> > diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> > index bd8147798cc3e..8f66438989e47 100644
> > --- a/arch/x86/kvm/regs.c
> > +++ b/arch/x86/kvm/regs.c
>
> [ ... ]
>
> > @@ -564,7 +564,8 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcp=
u, struct kvm_sregs *sregs)
> >       }
> >
> >       return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
> > -            kvm_is_valid_cr0(vcpu, sregs->cr0);
> > +            kvm_is_valid_cr0(vcpu, sregs->cr0) &&
> > +            kvm_valid_efer(vcpu, sregs->efer);
> >  }
> >
> >  static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs =
*sregs,
> >                             int *mmu_reset_needed, bool update_pdptrs)
> >  {
>
> [ ... ]
>
> >       vcpu->arch.cr3 =3D sregs->cr3;
> >       kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
> >       kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
> >
> >       *mmu_reset_needed |=3D vcpu->arch.efer !=3D sregs->efer;
> >       kvm_x86_call(set_efer)(vcpu, sregs->efer);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but should the return value
> of kvm_x86_call() be checked here?
>
> If a userspace process calls the KVM_SET_SREGS ioctl with EFER.SVME set,
> kvm_x86_call(set_efer) could call into svm_set_efer(), which attempts to
> allocate nested state via svm_allocate_nested().
>
> If the system is under memory pressure, this allocation can fail and retu=
rn
> -ENOMEM. Because the return value is ignored in __set_sregs_common(),
> doesn't this lead to a silent failure where KVM fails to set the guest's
> EFER register but still returns success to userspace?

This seems like a real issue, and I think it's not very easy to fix
because it seems like KVM_SET_SREGS is currently atomic, we either do
all the updates or we fail. So we can't just fail in the middle of
__set_sregs_common() if set_efer() fails, we have to either undo the
previous changes or re-order the writes to do EFER first. Re-ordering
seems like it should be fine, I don't immediately see svm_set_efer()
or vmx_set_efer() depending on any of the previous updates, but I
didn't look too closely.

Anyway, this is completely orthogonal to this patch AFAICT.
