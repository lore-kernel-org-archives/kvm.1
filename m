Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B38350D74
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844658; cv=none; b=iPIXqgJC7TCGRRaHD8SD/t/vJrmraui93tdLBwJOFYrrBbU0liBPygtxacsy8gnrjwZaPV4sL+EkDYSSXDkuBjoS0gF/oNHa/KI8wj1aOJC25SCCkr/V7E/dF4+MPWkbeLjpYKUCgujsEc0HeT1MsjvDf7FPZoVHMfXyTdQ6n0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844658; c=relaxed/simple;
	bh=mt6mEXq0iZAnrgAdBcIXMLtGZeXbdGVTLm3KSeh240M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKsbHGhJzliJAu6SHpFk59sTaCx5+no+c3wPOIQJ2HN7QBRUYvqhZMNLMhBe7Swr7CG3qLCWYte1CInB5ZCnTBG9uhmbacnDHKfERFmijPnBNhdUVtnEn8sRbpAOMtM6WNFlh06HvFgE1i9fWuCx3iKuiomQoA9A7IZhyhhxNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZimGRQEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZimGRQEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD281F00A3A
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784844657;
	bh=HP/nmVEdreNVrFPSuC0oWkeoRu4+bHVeW98mjc+pLHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZimGRQEAiV/7meS5tnF8A5Cq/8v5aW5NI2mkcsQrH1CMU9KwY9ocXQeAo6zl19h+7
	 P18QJN/VQhRNEnziCmSwZpsbV62l/6Tepy5g0hIW4JhssQA2Mh8lg76PoG7EeQTFRI
	 FbDcelESZ4qgMBl8AHSyDMJT5OZGQAjPnNvLhRSIW5VcBmi6Ui5FmRZ8imjfHoT3O6
	 mNC6b9NBZHelqpe1JbjeH9fZxmZ7VpYDcIqQM9Vugxuu4RgtAuNzJ4HOsakgepPVUn
	 7v9G7fy7KQ2FiMC9ri3lE+LKm7KGyOyzvtqiaWoE4deBWkpbtgJI1DXxJWcXk3sr6+
	 fpkEyiFW4eQPQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso141680966b.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:10:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqVjK41ZHwzLN3l7xjC6/HfyJFc8EjfRH7TxIx8qeUM7A2tDxJO1IgZ5yPtPwweDglAIfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTsY7GOayWBoI6bsQdHjZDFXdaFziLrUGl6CvIWodKF8t82jO
	A1YAIRm7KBhMG28yem+CxAFSmSkAq5A+n2UcA+077LMPrEIUHQH04FJQ8B89iiSDcSKaSOFQnL1
	dAhzzAx4nRUgshaMhkFDTNbdlXfza92s=
X-Received: by 2002:a17:906:730f:b0:c19:82fb:e6d6 with SMTP id
 a640c23a62f3a-c1c50d780cdmr219396666b.48.1784844656421; Thu, 23 Jul 2026
 15:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com>
 <CAO9r8zOd6vLA+rYwQx9n86Hc+4wZUZNO+0EPeDry-GDhG8OLTw@mail.gmail.com> <amKPwsAprgG_Pntg@google.com>
In-Reply-To: <amKPwsAprgG_Pntg@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 15:10:44 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPCcBjZcsgm+aD4qnEVOf51wESbGLq9rRdTO0FTz39ijA@mail.gmail.com>
X-Gm-Features: AUfX_mzICL9xIDSM1b_A_Oehqgh9p2oE1wV7EwLN2G8X6Zm0T-bN-vRMvVB_YQo
Message-ID: <CAO9r8zPCcBjZcsgm+aD4qnEVOf51wESbGLq9rRdTO0FTz39ijA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:03=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> > > Actually, isn't there a pre-existing over-flush when handling kvm_mmu=
_invpcid_gva()?
> > > Oof, and a missed flush?
> > >
> > > To fix the over-flush, I think we want this?
> > >
> > > diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> > > index 6c13da942bfc..7f3e0eb33b29 100644
> > > --- arch/x86/kvm/mmu/mmu.c
> > > +++ arch/x86/kvm/mmu/mmu.c
> > > @@ -6672,7 +6672,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *v=
cpu, struct kvm_pagewalk *w,
> > >                 if (is_noncanonical_invlpg_address(addr, vcpu))
> > >                         return;
> > >
> > > -               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> > > +               if (roots & KVM_MMU_ROOT_CURRENT)
> > > +                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> >
> > Hmmm why?
> >
> > AFAICT, if the gva has a shadow mapping, then the rest of
> > kvm_mmu_invalidate_addr() will make sure the shadow mapping is
> > up-to-date and do any necessary TLB flushes in the process. So I am
> > assuming the flush here is intended to cover some cases where the gva
> > does not have a shadow mapping. Not sure how this could happen, I
> > assume we always flush the TLB when a shadow PTE is freed.
> >
> > If there are cases where we can have TLB entries but no shadow
> > mappings, then shouldn't we flush regardless of which cached roots
> > match the target PCID? I assume if none of the cached roots match the
> > PCID it's not an issue because KVM will create a new root and flush
> > the TLB before switching into the new PCID.
>
> Gah, I conflated PCIDs and VPIDs.

Disregarding the alleged over-flush, I am actually trying to figure
out why flush_tlb_gva here is needed in the INVLPG and INVPCID
emulation paths. I think understanding this will help us figure out
how to best handle it for INVLPGA.
