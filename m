Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B32EE611
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632843; cv=none; b=Z0OlJ83GtWybHdFRzvEKjKHpr1JI0de90Avfyxitz4MOVHYi2dwlTZnxji/thECjCo9zf84No+JVLShfQ3pBGACOZHWEau9nUsaGr4JmT8CEN7rzUJC/GbyBnU0v+VAPz/g+i6Vtz4vTpwfMxZRpZm/wvNjCaHy1EIJtA/eFth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632843; c=relaxed/simple;
	bh=iCaOP0Ax2vc2sgI2Fmtc3HRYUD0UaxmzhZUUcdhw4YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DO00VOf9q03Zbr+EyILNPqmFq9sqT7nMKJxe/B/2SWy5dOktFcjUYd+VUso3KuGPVcad3+uyseZryUD3Ypann0Uxfi5dlxnM+auOBO2wsFFwd90GaU1cdSwKAdDjzUIYasqRovilQ07FB+QmUxQaJRhPv2ZTigPiT3iFuzQlWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnFADW8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnFADW8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84591F00A3A
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781632841;
	bh=NwZPNnIRwgCRGyzWK3KP1QnXx1j33jdNjy9Lx5YY9wY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WnFADW8kZWZDTdxp24Un5Bm48PtTRVh7WTNKBDjGMrAZ6c8I50reecT2lffTajT4N
	 LnVOCPVoS14GVGbC85vTAyEo+lGxbKvO+qwzak3ujSoX2hgGmZ2kFohiEEKkx6wTXn
	 tQaR8IUl7cXpE4SQZyzmROfrV2ndrbj244rHrfuk4U+zIAYnkGtuBLyejtkywruRey
	 d4ZixOAmy/a6Uu+ztv9g15GfT9KFU2CBlWCIIF+cOIxoO6Y+n2DJHdn/69VnPhrLIB
	 m3E+DUl0EcK3K1b3Np58a2EYTvRVgpWsxWqXqrXXhULO8jRJM8PyWm+WWURuyzowK9
	 7oY8YkU87fA0A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bebb72b845aso832238666b.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:00:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGUFxue2qoA+yRo71t23nCm/o5buTX/AJj4cNhN7wutKBXGuZ6
	Njp60GhpeMNNj4aJtuNW0mw3a+c9KaFXFDqgB8P2aODzXCRD3T/Vm3D/6qd+I8hF/w7Zn+wzCbI
	5pGf51qslPfsIZGXGijO+nUjrfzGEbNQ=
X-Received: by 2002:a17:907:25c5:b0:beb:8c28:254 with SMTP id
 a640c23a62f3a-c059e645cfcmr59192766b.0.1781632840918; Tue, 16 Jun 2026
 11:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-14-yosry@kernel.org> <20260616010534.2C8511F000E9@smtp.kernel.org>
In-Reply-To: <20260616010534.2C8511F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 16 Jun 2026 11:00:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNVPAeeiporS5aYFxdRUciaGwZGbnSg7Dr2XVpNFCvOmw@mail.gmail.com>
X-Gm-Features: AVVi8Cc-TsmqIJX20e3E1uDGzSFqJJv-kuQrTw-u4LVXvFPouTeVpZwljYutxoc
Message-ID: <CAO9r8zNVPAeeiporS5aYFxdRUciaGwZGbnSg7Dr2XVpNFCvOmw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/25] KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 6:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Dereferencing `svm->nested.vmcb02.ptr` without verifying `svm->n=
ested.initialized` causes a Use-After-Free write if `svm_allocate_nested()`=
 previously failed.
> --
>
> commit 88a69b7a032d088ddb452c91fba161d26dbed0ec
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: nSVM: Flush both L1 and L2 ASIDs on KVM_REQ_TLB_FLUSH
>
> This commit modifies svm_flush_tlb_all() to flush both L1 and L2 ASIDs
> to properly handle KVM_REQ_TLB_FLUSH across all contexts. It also purges
> all Hyper-V TLB FIFOs for both L1 and L2.
>
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index dac3d0098bb77..4f13c3456a5d7 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
> > @@ -4213,7 +4215,11 @@ static void svm_flush_tlb_all(struct kvm_vcpu *v=
cpu)
> >       if (WARN_ON_ONCE(svm_hv_is_enlightened_tlb_enabled(vcpu)))
> >               hv_flush_remote_tlbs(vcpu->kvm);
> >
> > -     svm_flush_tlb_asid(vcpu);
> > +     kvm_hv_purge_all_tlb_flush_fifos(vcpu);
> > +
> > +     vmcb_set_flush_asid(svm->vmcb01.ptr);
> > +     if (svm->nested.vmcb02.ptr)
> > +             vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
>
> [Severity: High]
> Could this dereference of svm->nested.vmcb02.ptr cause a use-after-free?
>
> If svm_allocate_nested() successfully allocates vmcb02_page and assigns i=
t
> to svm->nested.vmcb02.ptr, but a subsequent allocation (such as msrpm)
> fails, the error path frees the page but does not clear the pointer:
>
> arch/x86/kvm/svm/nested.c:svm_allocate_nested() {
>     ...
> err_free_vmcb02:
>     __free_page(vmcb02_page);
>     return -ENOMEM;
> }
>
> If a TLB flush is later triggered and calls svm_flush_tlb_all(), the chec=
k
> for if (svm->nested.vmcb02.ptr) would evaluate to true on the dangling
> pointer, and vmcb_set_flush_asid() would write to freed memory.
>
> Would it be safer to check svm->nested.initialized here instead, to ensur=
e
> the nested state is fully allocated and valid?

Yes. But if no one objects, I'd rather add a patch to drop
svm->nested.initialized completely, and properly NULLify
svm->nested.vmcb02.ptr in the destruction paths. Keying off the
pointer makes more sense semantically imo.
