Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B6188CC9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855567; cv=none; b=tV3Yo7aRWw1b0cB6fcQddfMcYQGUm9JFQ2a3v7qrPBhCh7M8s6nCdelm+hFHinQubwdYWm5SozJPfCP6auCYR69cnK1eUn/2bU9mcHiSDBliHotb8M8YV/KDO7U+W96Kh9JKO/iyjYQYaIgITXHNOw6dXlGhII+SieJaBcP+iGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855567; c=relaxed/simple;
	bh=/mhnRNSnLBDMjExs1PH67ByFdgbYgoty3Np4kdyTypU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QrpsEZ1FltCmmieEZNx3Q5dlP9c/qzzBGoi6OLi+HdpQ0YkPhGO5k5x7tGWWqrtMnqlqg2wpnP1W7IL2sCvjK0S01Q1JCNVzxStnq/0aW6dTWmV6SZ/UgyFQ6zRiSlm0uINTxKjkoHuikuExIMdsUINwSZS8o6fwO4RsMSKt9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vE2gv3LJ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vE2gv3LJ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so2392695a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784855566; x=1785460366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fhwy4P5UTqAyY62fJ3HHPirUxt0rCfq7RQLtlvv/2F0=;
        b=vE2gv3LJEHtOM63AqxiLqLDECxq1DsUop4KBO5Qs3McdPcA18RM6P6GZmwkTPsYu+i
         d48hTNcp1s7IIjz9XMaJcEq4IvhBxG3bafqVAlqX7XOGZzBJ+O1tI2fUr9pVBCJ2Rr48
         rCY7bdFLFYgHT5dVZd/bb83UoiJraZewIjEul0C52BXiP3QevvtP6mIf16b2oANRH9xB
         +DbhaAL7cZ1K9CEMDUgjDwwrLdSAaKYlM51NTLhb6e3zvxbMfjZ/2wyodMza9f6h+Gn+
         cAAH7FSwzSsaCvog3guoWxK/xE4yjfdEtnpAsCGczEMSrO0VwZ1uoI8+PHADrLYYg4xE
         CQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784855566; x=1785460366;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fhwy4P5UTqAyY62fJ3HHPirUxt0rCfq7RQLtlvv/2F0=;
        b=d39u+dDW9OvW9iRf7xHb6oyk/wSKo1f0G5p+UBD5EXujv4vVGZNYG9qjuFaAMOgoZ0
         arDu5gnJcTXdzVFg1YGQd72HxXSBCXDVFgnPAYw/vIMIy5GDRRs5Ry6djO3tZHekVlEf
         iC4g7xzxa93wx66mJDzOb1p6lCucWvJ4Vs3wd/JImhWnn4ibsKGvepXlNJe6OZpQf7zc
         UCSvabTP+pTjUYP20Z0CejHnmmDRanksZdAuwxOdC5mv41PP+deK2qe8T1avKz6vK0d5
         268tq1z284kYq+A6jOCsQVjJCTA9yg16+ZNdxATrHTiy2kj2/7i+F5XHrfYGQuUTSbsL
         IPEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFqEOMQzoGWrtzwdSWTfMlBLFsxZoPJbW+08XC6SCd+ALXezVEy0YoiwUyOqQHkht8Mm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNPOKYdXs3wsqf0yJkrzagzRMOUMzRXSTwfol9D/ilQzvB9Bk
	N+rHkwAGKhxriF+IgJDHAeYjr15DLbTjW0isJB6izd1IDJMQcNSbPXla9Fxpm0nsWQHVC4BQC7F
	4LOyN1w==
X-Received: from pgbcr2.prod.google.com ([2002:a05:6a02:4102:b0:c96:a49d:98ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d02:b0:3c4:396d:4a6c
 with SMTP id adf61e73a8af0-3c44afb90b4mr5628190637.5.1784855565462; Thu, 23
 Jul 2026 18:12:45 -0700 (PDT)
Date: Thu, 23 Jul 2026 18:12:44 -0700
In-Reply-To: <CAO9r8zPCcBjZcsgm+aD4qnEVOf51wESbGLq9rRdTO0FTz39ijA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com>
 <CAO9r8zOd6vLA+rYwQx9n86Hc+4wZUZNO+0EPeDry-GDhG8OLTw@mail.gmail.com>
 <amKPwsAprgG_Pntg@google.com> <CAO9r8zPCcBjZcsgm+aD4qnEVOf51wESbGLq9rRdTO0FTz39ijA@mail.gmail.com>
Message-ID: <amK8DNIbm1ZAvW4e@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> On Thu, Jul 23, 2026 at 3:03=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> > > > Actually, isn't there a pre-existing over-flush when handling kvm_m=
mu_invpcid_gva()?
> > > > Oof, and a missed flush?
> > > >
> > > > To fix the over-flush, I think we want this?
> > > >
> > > > diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> > > > index 6c13da942bfc..7f3e0eb33b29 100644
> > > > --- arch/x86/kvm/mmu/mmu.c
> > > > +++ arch/x86/kvm/mmu/mmu.c
> > > > @@ -6672,7 +6672,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu =
*vcpu, struct kvm_pagewalk *w,
> > > >                 if (is_noncanonical_invlpg_address(addr, vcpu))
> > > >                         return;
> > > >
> > > > -               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> > > > +               if (roots & KVM_MMU_ROOT_CURRENT)
> > > > +                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> > >
> > > Hmmm why?
> > >
> > > AFAICT, if the gva has a shadow mapping, then the rest of
> > > kvm_mmu_invalidate_addr() will make sure the shadow mapping is
> > > up-to-date and do any necessary TLB flushes in the process. So I am
> > > assuming the flush here is intended to cover some cases where the gva
> > > does not have a shadow mapping. Not sure how this could happen, I
> > > assume we always flush the TLB when a shadow PTE is freed.
> > >
> > > If there are cases where we can have TLB entries but no shadow
> > > mappings, then shouldn't we flush regardless of which cached roots
> > > match the target PCID? I assume if none of the cached roots match the
> > > PCID it's not an issue because KVM will create a new root and flush
> > > the TLB before switching into the new PCID.
> >
> > Gah, I conflated PCIDs and VPIDs.
>=20
> Disregarding the alleged over-flush, I am actually trying to figure
> out why flush_tlb_gva here is needed in the INVLPG and INVPCID
> emulation paths. I think understanding this will help us figure out
> how to best handle it for INVLPGA.

That emits an actual hardware TLB flush if there are no unsync SPTEs.  Ever=
ything
below this point:

	/* Invalidate shadow pages, whether GPA->GVA or nGPA->GPA.  */
	if (!mmu->sync_spte)
		return;

is specific to unsync SPTEs.  __kvm_mmu_invalidate_addr() is one big nop if=
 there
aren't any unsync SPTEs.  E.g. before unsync support came along, KVM didn't
intercept INVLPG: a7052897b3bc ("KVM: x86: trap invlpg").

Wwith TDP enabled, KVM definitely needs to flush guest mappings, e.g. if KV=
M
synthesizes a #PF (which are architecturally guaranteed to flush any releva=
nt
mappings), because KVM isn't controlling GVA=3D>GPA (obviously).  When usin=
g
shadow paging, it's less obvious when KVM would need to flush hardware TLBs=
 even
if KVM's SPTEs haven't changed since the last flush.  The only things that =
jumps
to mind are TLB entries that were preserved across a MOV CR3 switch, e.g. g=
lobal
entries or MOV CR3 with X86_CR3_PCID_NOFLUSH, and the new CR3 contains a st=
ale
mapping (or none at all).
