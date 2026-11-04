Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799140;
	b=CFEGj+yxQpVKC1EfMY+1E0BxJONpEAOJ0BQox+pozQ4t7Zdtg3djqHZneFHJMGiP0WHA
	 CLxkML1C3Hy21veYgD40C2NLU5YPjRUMi9BUwsrzhvG5i+ZzsGAhd08hNtfV3hQcx1q7/
	 oBnmRmO/tZ63t1Q8Tsw4MUWwDSHHAeTX7Bgt5EPWGxp4WMmWz2cgUXqkN+xIjPMbpZ77N
	 FFRWFzYXHuWwzbgIw01eD2J6OI4tIj/oSLg3VfrHLWWhYzC90h5FJ8zyGesjqorwyRBYJ
	 PWidp663L94raZX9Sbz+cgczkKnYfEA4dvKexKzH98bjXK8cbwBvILNTc9gSO7eb8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=f1NHckFTNi2t+UBr6oPHAijnd3s0vFDpOBlB6WEYt+4=;
	b=2iNn8b6wIqQPj21aWtZ15XT3FIq0tD2LNuAGOX3WZXae1K3yOS4M5kkMl2pF6YwS6l0n
	 /Ao4dVZtk1fKmIAS34L22too4fxZCzvrY9rgYUZZVmPGe+YdmZGJoPcPh52a+yAJn+JBU
	 dRnB8BR2QPnQ02zyanZ9YNVFOWuGs5Y3oKDqyYm4pee4RACOHkgtCSBVyemCJYNLYP472
	 /bm4vad3A18faagEctB0pXgBFmgCCF9iJwufcZmhBFaT3+Ad5rclMZ61QhYf7hptUkqis
	 naVGaOWqQrsb2mqh1k1gOL5dvxUEOeBkQzESUjNynh8wuEW3qgvemc7yL0ROXpoKR6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RapW6WWc;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C6606A335
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 13:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 836C6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RapW6WWc
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e987ec84afso8279805ad.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 05:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793799140; x=1794403940; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1NHckFTNi2t+UBr6oPHAijnd3s0vFDpOBlB6WEYt+4=;
        b=RapW6WWceSFqeyficEW7bv9aaNqLgMPyTle9BGVgeXlYhdodchBm2sA0U0ZSBEji2k
         uuzoQAEfTBz7xKrQTMWHL17UdGnavPvIxJsbL6euM3mWc9HMWVWG0rRpL/bJFRdTgFYk
         v1H0uq7++thqvkwEte/2TClXuU1qj1QjtWmrev5RnQxUSg3zDChWIHzuiaW1nBdX41Yf
         Zo4o9K5Shny0AqL0N2RY4OWvMWdnk1GhJS5FtRj64JUgrOczXiSeL0E4GlgANOlrzmQQ
         j/8mtAznvBgAeV9sMNgDCGvshz8T6mR8m05JWauW9KeH/w/v71rUrvTBq8YnIpFh+JqQ
         IuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799140; x=1794403940;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1NHckFTNi2t+UBr6oPHAijnd3s0vFDpOBlB6WEYt+4=;
        b=St5Kl1oBFBnudd++yN+5NIZexVMsl7jymIA/Zb6DiZjJTnjGFSjP5ynYQWmS9nlLHR
         CDcgmg22imJhUx0VvtqKss6rM0z0GUU93YafEidMuFmywjOssYzKJNR0jYRkErnUX64V
         cUKIxPCtMGdQrFgjDeA9T0L/8TajBSKqs7MVDA2oAhJlBRkKnESQ85nGy038vPeCcHt5
         aQP/oX3OPOblPOohqVsC4Qg/TSgCBSdgq3uB5tCy7OMtAwSDZi4mLH1+/QJz9QeZbZS5
         7xrLRa5lbhcLI8jPJQd55Ps6CxEz2Y6Y4kxuczTQY4+DG09bSFsrs6xv3SjoSafMh8Na
         GxoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIeS2r2VQlQmeynbeK+nZWD4BqMFz/p9xr+nmtKDRytgG4enomJrG2dYlg9cpn9xBL32o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xV5qcM6ZzkRoPmcuVXBv1vpbD4ScOvqWadIy2Ji73mamiQ5ey
	UphE/pJxLp6djv6ccBJ68NPRhdht8lJK6hOMXBC5ogLG8fQsh7myz4xxuHCt8VVAd44QZabkAm+
	rEfNV8Q==
X-Received: from pjbmj22.prod.google.com ([2002:a17:90b:3696:b0:3ad:ce09:ff3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a82:b0:3b0:9f53:e8a8
 with SMTP id 98e67ed59e1d1-3b09f53f231mr985002a91.52.1793799139505; Wed, 04
 Nov 2026 05:32:19 -0800 (PST)
Date: Wed, 4 Nov 2026 05:32:17 -0800
In-Reply-To: <5bd7e8e9-3614-4006-a3d7-a51416ba5507@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com> <20261030212112.2598640-4-seanjc@google.com>
 <5bd7e8e9-3614-4006-a3d7-a51416ba5507@linux.ibm.com>
Message-ID: <ausz4VZWa_4Vr03v@google.com>
Subject: Re: [PATCH v4 03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
From: Sean Christopherson <seanjc@google.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 04, 2026, Narayana Murty N wrote:
> Hi Sean,
> 
> On 31/10/26 2:50 AM, Sean Christopherson wrote:
> > Flush/zap every memslot in kvm_arch_flush_shadow_all(), i.e. when the
> > owning userspace process is exiting, as KVM must ensure all associated
> > memory is unmapped from the guest.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/powerpc/include/asm/kvm_host.h |  1 -
> >   arch/powerpc/kvm/powerpc.c          | 11 +++++++++++
> >   2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> > index 708a32f89776..50a42f80e5f1 100644
> > --- a/arch/powerpc/include/asm/kvm_host.h
> > +++ b/arch/powerpc/include/asm/kvm_host.h
> > @@ -910,7 +910,6 @@ struct kvm_vcpu_arch {
> >   #define __KVM_HAVE_CREATE_DEVICE
> >   static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
> > -static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
> >   static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
> >   static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 9194cf492d1c..9e9d0865c2f6 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -764,6 +764,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
> >   	kvmppc_core_commit_memory_region(kvm, old, new, change);
> >   }
> > +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> > +{
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm_memslots *slots;
> > +	int bkt;
> > +
> > +	slots = kvm_memslots(kvm);
> > +	kvm_for_each_memslot(slot, bkt, slots)
> > +		kvmppc_core_flush_memslot(kvm, slot);
> 
> For Book3S HV/hash, I am not sure the existing flush_memslot helper can
> be used on an active memslot like this.
> 
> The normal memslot invalidation path seems to deliberately establish
> the opposite ordering.  kvm_invalidate_memslot() first installs an
> INVALID slot and makes it active:
> 
> 	invalid_slot->flags |= KVM_MEMSLOT_INVALID;
> 	kvm_replace_memslot(kvm, old, invalid_slot);
> 	kvm_swap_active_memslots(kvm, old->as_id);
> and only then does kvm_arch_flush_shadow_memslot(kvm, old);.
> 
> The comment there explicitly states:
> /*
>  * From this point no new shadow pages pointing to a deleted,
>  * or moved, memslot will be created.
>  */
> 
> Similarly, kvmppc_core_flush_memslot_hv() in
> arch/powerpc/kvm/book3s_64_mmu_hv.c relies on the memslot already being
> invalid when testing KVMPPC_RMAP_PRESENT without locking, as no new HPTEs
> can be created.
> 
> However, kvm_arch_flush_shadow_all() in arch/powerpc/kvm/powerpc.c now
> invokes the same helper while walking active memslots.
> 
> Is there any serialization in the mmu_notifier.release() path that provides
> the same guarantee against new HPTE creation?

There can't be any outstanding *usable* references to vCPUs at this point.
mmu_notifier.release() is only invoked if the process is exiting or the VM is
dying (which requires the associated file to have been released).

If the process is existing, KVM_RUN (and most ioctls) are unreachable due to the
"dev->kvm->mm != current->mm" checks.  Not to mention that if the process is
exiting, doing anything with a memslot is completely broken because it means
things like hva_to_pfn() are somehow operating on the wrong mm.

If the VM is dying, there can't be any references to vCPU FDs, because each vCPU
holds a reference to the VM.

> Otherwise, couldn't an H_ENTER or fault path create a new HPTE while the
> rmap is being scanned, or after it has already been examined?
