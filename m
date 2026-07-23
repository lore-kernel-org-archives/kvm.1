Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A352F83B5
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820226; cv=none; b=Os2k6xaU/bJNnqKee8OTECoI08CpSppODrGnxn0NDjVX9AV8WwsRMsKWX6xwUCsrVXCtvkm3fykP1G/GEwT07gocN6lc7mIzbmbyqhKw5T/ZT0ecYwlSnZfr/x90rzz6ETWy7PNKITeMmg65Snm2kAnazrhaAI4utKJPCWX6tb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820226; c=relaxed/simple;
	bh=wc58FnJvNGRmZB8MOWPGgiFR6U7xAj4iaYYZUVMc3vg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4NGjiOiN8Ewxg0sHr2+hw6qkmFQ/GB21p5MqnOS0zYKCAaHUPaWBaLT1hpu2GIxayTQ28YCU+iHJ8W1edfiOSlpH2kYhncl3N6mvkJXgXyvKoiU8D3Klk0r/B/+eQ3UVIXvH1Jk3W/mUG0e0cqvgcp5pzgfHP4pDMx7Joe9/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wToSXlrY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wToSXlrY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c7f385887bso15730935ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784820220; x=1785425020; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNT1RM/ZdipYTEsicJnYvAxIeXZSfUPW+JDMKIP8+oY=;
        b=wToSXlrYoHJVXi9YMKF9yN1LDuc0z7Bz2lzwogFsN04Gbet0zy6J6PFX9N1QDSlTWj
         lHbzH8b5TvDVIimt9oP8OXBot5u5vhsi6xdAT7sg4VNREini5SNtxyaD6a3CJgkicMox
         vyPR3xG39YbHA5Jacx6T69xOhdgqIirsKavYJAcSH787DDPFqr8IhuqgGKZV467RoCFo
         RGRNlaqVVuyk69Kt/NpGHLQhSkuSW9kCljEVOau1SPAfAOvx7LACTDHjFbwGTcTTLkxj
         /ejvSMKqY6dTJdfC/z7p6ujBDt5M6B9LZXxGaZ++iEn61YLMP/Pmg+mP0KKfuKqBxTyl
         XPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784820220; x=1785425020;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNT1RM/ZdipYTEsicJnYvAxIeXZSfUPW+JDMKIP8+oY=;
        b=MxM+unLZ5JKCRpXZ6JU29wPj5HJlgsGdQj1vrogsf9hTZilWsJDJMDMXENuA7tcijV
         ReQiPpE+9bHPlQubivPKqHMfY/jxSqScg/i5+GFlPA6qHWpeEgj11VmrRBCTXszYhEka
         +2LvHU6MaxqowHjT7rhj5orpK0HhuZb5lCGRmvMydRqHf6ctQNYRkuYOYLTT9r3nMSaR
         4LJ208QkI4pielUT1l0aldo+8/Gv8wE0OQuq0qDjOUQrvjrEbqPouXP3oI88Nf57np+e
         m1uUZ5KtXYHOZxy7NCxgI3Cp8V12Ck6td7HSqNgZ1jWq2fdJplrlS1RcE8hO4p3LR4HS
         eR5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq7XzQZB47zSWKlizhp7vvTcGXwazsq8m+sJ734lEHSaH1cpthajqWxpzInUofxkay6034=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlg60k4vpgds16eLjt2l2jiVtb5/JLY+xGnC1mntGKjPFNZ7gm
	XP6SBt/nNC78iMiq9BlaWP1LaEkgHRqArniwtZLPjyhHHg76bYW252GMoAJzCSy47nELkyTw2/U
	b40keKg==
X-Received: from plpd6.prod.google.com ([2002:a17:903:1b66:b0:2ca:5a0f:d0c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17c6:b0:2cc:8ad3:423d
 with SMTP id d9443c01a7336-2cfa6c5e3f2mr45130805ad.29.1784820219479; Thu, 23
 Jul 2026 08:23:39 -0700 (PDT)
Date: Thu, 23 Jul 2026 08:23:32 -0700
In-Reply-To: <amGiAKsC3XrF6DyA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com> <amGiAKsC3XrF6DyA@google.com>
Message-ID: <amIx9Ki6gv-wgBnX@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> On Wed, Jul 22, 2026 at 05:56:19PM -0700, Sean Christopherson wrote:
> > On Wed, Jul 22, 2026, Sean Christopherson wrote:
> > > On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > > > Refactor helpers out of kvm_mmu_invalidate_addr() and kvm_mmu_invlpg()
> > > > that take in an extra argument to skip the GVA flush.
> > > > 
> > > > This will be used when invalidating GVAs in a different context than the
> > > > correct one (i.e.  invalidating an L2 GVA from L1), so flushing the
> > > > current context would flush the wrong TLB entries.
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > > ---
> > > >  arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++------
> > > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 65c35ed8f4a01..3feb75732f7b4 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
> > > >  	write_unlock(&vcpu->kvm->mmu_lock);
> > > >  }
> > > >  
> > > > -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > -			     u64 addr, unsigned long roots)
> > > > +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > +				      u64 addr, unsigned long roots, bool flush_gva)
> > > >  {
> > > >  	int i;
> > > >  
> > > >  	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> > > >  
> > > >  	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > > > -	if (mmu != &vcpu->arch.guest_mmu) {
> > > > +	if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
> > > >  		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
> > > >  		if (is_noncanonical_invlpg_address(addr, vcpu))
> > > >  			return;
> > > > @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > >  			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
> > > >  	}
> > > >  }
> > > > +
> > > > +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > +			       u64 addr, unsigned long roots)
> > > 
> > > Rather than kvm_mmu_invalidate_addr() for the wrapper, what if we call this
> > > kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then we don't need
> > > to have the "in_root" version to a quad-underscores helper, and IMO it's more
> > > obvious what's different between the one-line wrappers and the inner helpers.
> > 
> > Hrm, or maybe I'm not understanding what "flush_gva" means.  At first glance, I
> > was assuming you were using it to differentiate between GVA and GPA, but IIUC,
> > it's literally skipping the flush for the current context, which just so happens
> > to be done only for GVAs.  I'd still like to avoid the "in_root" helper, if at
> > all possible.
> 
> Yes, it's skipping the TLB flush that is only needed for GVAs. The
> alternative I had in mind (but thought was worse) was to refactor the
> TLB flush part out of kvm_mmu_invalidate_addr() (or
> __kvm_mmu_invalidate_addr()) in this patch instead of adding a boolean,
> but this still requires adding a wrapper and the possibility of a
> quad-underscore helper.
> 
> What's the main objection to kvm_mmu_invalidate_addr_in_root()?

I don't love the __kvm_mmu_invalidate_addr() => kvm_mmu_invalidate_addr_in_root()
callchain.  It's not at all obvious that the in_root() helper shouldn't be called
directly.  I don't hate it, but I do think we need better clarity on what all this
is doing.

E.g. when looking at __kvm_inject_emulated_page_fault(), since it hardcodes a
single root, it's a bit headscratching to use kvm_mmu_invalidate_addr() instead
of kvm_mmu_invalidate_addr_in_root.

Hmm, and arguably, the way invlpga_interception() handles the ASID is flat out
wrong.  KVM doesn't need to flush *all* roots, rather it needs to flush L1 roots
for ASID=0, and L2 roots for ASID!=0.  If we can figure out an elegant way to
express and handle that, it should naturally handle the "flush GVA" aspect.

Actually, isn't there a pre-existing over-flush when handling kvm_mmu_invpcid_gva()?
Oof, and a missed flush?

To fix the over-flush, I think we want this?

diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..7f3e0eb33b29 100644
--- arch/x86/kvm/mmu/mmu.c
+++ arch/x86/kvm/mmu/mmu.c
@@ -6672,7 +6672,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
                if (is_noncanonical_invlpg_address(addr, vcpu))
                        return;
 
-               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+               if (roots & KVM_MMU_ROOT_CURRENT)
+                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);
 
                if (tdp_enabled)
                        return;


And that highlights the missed flush: if the PCID isn't the current PCID, then
flush_tlb_gva() neglects to flush the hardware TLB for the target PCID, which
could leave a stale entry in the TLB if the guest switches to the new PCID with
MOV CR3 + X86_CR3_PCID_NOFLUSH.
