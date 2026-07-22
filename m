Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8603806CE
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741469; cv=none; b=EDlKfY83ylrc5RZsRGim6gTG1eMI7Nsecam/naSBeFcPo6IIuux3RNhZ6G9k8EjNW8VQ+1VsfFrJXvbHzoNhT9phFLrPSlk59Q5KnvBSfm30nQMrAFMei34g1J1ytjv0jJrTP26iTJ3J8W1rPbZ/AI+ettCqd5BsBw64NaYtX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741469; c=relaxed/simple;
	bh=yh3nwxxty+42EDVurx7iROkKSxeEI7Rnpv8icJAAzBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PXPboQCQGWpydp8EIC9z6f/PIv2igf2eM7WsjOXxQWpYBHGtgVEad+vgV7xVBoU1aHHyb6qFAigFQeLiQld1M/YjOpmOSe96sPflz7dYVbyISU2rl1adUiCptxZi3S3Or4rMVhv1ans8iLchsZkzje34waC+p8x4FzuZ/ynsJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ6hJiA4; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ6hJiA4"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so278198575ad.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784741468; x=1785346268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e0sTtp1Aj6Ox8W1SalC52QZ59OwsL2hIx36ZjzuLNzY=;
        b=pQ6hJiA4+2lJpT6ak31+He2RaaoheOceBtpXKwm2He2sDslC8zpi96lbKL7L/lKVXG
         YxVNge0nBEm3nTM86mN4vYdzwVwUUOzO0XERiwu4sQLicaArv5GthAuBv7RvjJqV5fnt
         6PU49jcXcTR/qRelw1QI5tj/HXeO3m3XczQGiCjubyNDdEXOHem8QkEjwVcXNEoJ6vVo
         7D6s0Wlo0t2PYpyzrkQqQaCysayxbWRkw/FQxfB2gmEhzaCCFTZw8Ubt8j5ppkUQStBi
         rg4OXacLfhE+r0rXnuy2VdJaG0oQNN4yP1Q4OPObtib5YO0Tl9DawViazU5Gmb7je2FA
         iSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784741468; x=1785346268;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0sTtp1Aj6Ox8W1SalC52QZ59OwsL2hIx36ZjzuLNzY=;
        b=ZhpQRj6tmDRlT9TAJ5FYK4NY3WD1vSs/5DJDIUy1Uz6bSfgiIPOVGq52FXtzKmLtIa
         W/7/+jo8zMmZYcCANMRXq9UjmImVSAlBF2WIZjIakHFCzIS1Q+CNLazm3Dv4+5ttSGPj
         hhsfMd8k6DypZj+cwpLk+bpNihIbtkCLpQaQOOWk4f5f/+H493sJSimafQmosPVjVjNx
         9KREEdcuUTKzdlAonzNPf4JCqnChoxloPhQ50Klanc3DB0htEWfflgs8ys8s9u3rmTjo
         yaFJvDiRSBdSzACUXltC3F21qRrfu+EmibgX5biarLF/yo69eK/tMHtaGXIWbwQWpHcF
         e1zA==
X-Gm-Message-State: AOJu0YwbHfzCdz2SAV/K7hIHWfqVVhoBLFDNtTBbCZf7QWOGOct/8cl+
	mSXfqFt7OGriVvAfwsjc976inDLYAX2i6LWsJO60YoWUjXb0/NIEURAuk62MgGn1htgwVWcMQwN
	uSTYgUQ==
X-Received: from plbke5.prod.google.com ([2002:a17:903:3405:b0:2c8:1ded:d061])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:988:b0:2cc:f5aa:9513
 with SMTP id d9443c01a7336-2cf34821a87mr273375475ad.10.1784741467498; Wed, 22
 Jul 2026 10:31:07 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:31:06 -0700
In-Reply-To: <5ef176573157b595d674cfca28923d919e54ad73.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com> <20260718061050.E17B01F000E9@smtp.kernel.org>
 <1417841720b8435f8fb95ac0bd95be6e0e9390d4.camel@intel.com>
 <amDd1Ip3XTvKSTcb@google.com> <5ef176573157b595d674cfca28923d919e54ad73.camel@intel.com>
Message-ID: <amD-WjxP05qKdK-t@google.com>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chao Gao <chao.gao@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-07-22 at 08:12 -0700, Sean Christopherson wrote:
> > Hmm, yeah, I think I agree.=C2=A0 Super duper technically, that's a fix=
 for an
> > existing flaw.=C2=A0 Because very, very, VERY theoretically, the cache =
of page
> > table pages could be exhausted.=C2=A0 E.g. if some other task managed t=
o free non-
> > leaf page tables while mmu_lock was dropped, thus forcing
> > kvm_tdp_mmu_map_private_pfn() to allocate from its cache over and over.=
=C2=A0 In
> > practice, that's likely impossible thanks to holding slots_lock, but gi=
ven
> > that (a) retry should be rare and (b) kvm_mmu_topup_memory_cache()
> > is basically free if no work needs to be done, I don't see any reason t=
o do
> > topup outside of the retry loop.
> >=20
> > The other thing we should address is the call to kvm_mmu_reload().=C2=
=A0 Like cache
> > exhaustion, it *should* be impossible for the root to be
> > invalidated/obsoleted, thanks to holding slots lock.=C2=A0 But as evide=
nced by the
> > rash of recent shadow MMU bugs, we don't always get things perfect, and=
 lack
> > of defense-in-depth can be *extremely* painful.
>=20
> Should we assert that we are holding slots lock then? Otherwise the reaso=
n for
> the warnings would be confusing. To me at least.

It's already there:

int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t=
 pfn)
{
	struct kvm_page_fault fault =3D {
		.addr =3D gfn_to_gpa(gfn),
		.error_code =3D PFERR_GUEST_FINAL_MASK | PFERR_PRIVATE_ACCESS,
		.prefetch =3D true,
		.is_tdp =3D true,
		.nx_huge_page_workaround_enabled =3D is_nx_huge_page_enabled(vcpu->kvm),

		.max_level =3D PG_LEVEL_4K,
		.req_level =3D PG_LEVEL_4K,
		.goal_level =3D PG_LEVEL_4K,
		.is_private =3D true,

		.gfn =3D gfn,
		.slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn),
		.pfn =3D pfn,
		.map_writable =3D true,
	};
	struct kvm *kvm =3D vcpu->kvm;
	int r;

	lockdep_assert_held(&kvm->slots_lock);  <=3D=3D=3D=3D=3D

> > I don't think I want to just move kvm_mmu_reload() into the loop, becau=
se KVM
> > should provide stronger guarantees with respect to the validity of the =
loop,
> > versus the population of the caches.=C2=A0 I.e. I want to WARN if the r=
oot becomes
> > obsolete after the initial reload.=C2=A0 And more importantly, KVM real=
ly should
> > check the validity of the root after acquiring mmu_lock.
> >=20
> > We can't simply call is_page_fault_stale(), because mmu_invalidate_retr=
y_gfn()
> > is inherently fuzzy, i.e. could get false positives, even though the pf=
n
> > provided by guest_memfd is guaranteed to be valid.=C2=A0 E.g. if shared=
 gfns
> > surrounding the to-be-mapped gfn are concurrently invalidated.
> >=20
> > So, this?
> >=20
> > 	r =3D kvm_mmu_reload(vcpu);
> > 	if (r)
> > 		return r;
> >=20
> > 	do {
> > 		if (signal_pending(current))
> > 			return -EINTR;
> >=20
> > 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> > 			return -EIO;
> >=20
> > 		r =3D mmu_topup_memory_caches(vcpu, false);
> > 		if (r)
> > 			return r;
> >=20
> > 		cond_resched();
> > =09
> > 		guard(read_lock)(&kvm->mmu_lock);
> >=20
> > 		if
> > (WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu)))
> > 			return -EIO;
> >=20
> > 		r =3D kvm_tdp_mmu_map(vcpu, &fault);
> > 	} while (r =3D=3D RET_PF_RETRY);
> >=20
>=20
> Ok. Is there something we can add to connect the slots lock to the root f=
reeing?
> Like maybe a helper to encode that rule? Or better to not wrap the delica=
te
> details? A comment instead...

Ya, a comment.

LOL, hilarious.  I just discovered a (not fully functional) patch sitting i=
n one
of my many branches that adds the is_page_fault_stale() check, with this as=
 the
changelog:

    KVM: x86/mmu: Ensure page fault isn't stale/obsolete when mapping priva=
te PFN
   =20
    Add a sanity check in the helper used to map private pages into a TDX g=
uest
    to ensure KVM isn't attempting to map memory into an invalid/obsolete r=
oot.
    It _should_ be impossible for the root to be invalid, as the only flow =
that
    marks TDP MMU roots as invalid is "fast all zap", and doing a "fast zap=
" is
    mutually exclusive with populating TDX memory thanks to slots_lock (thi=
s is
    also why KVM doesn't retry kvm_mmu_reload()).
   =20
    Note, KVM will already WARN on an invalid root if CONFIG_KVM_PROVE_MMU=
=3Dy,
    but the check is inexpensive compared to the cost of populating memory =
into
    a TDX guest, and not having a is_page_fault_stale() check _looks_ wrong=
.

I'll munge that into a mini-series to add the sanity checks.  No need to ho=
ld
the D-PAMT series, I see this as orthogonal hardening.  I'm leaning towards=
 the
"have our cake and eat it too" option as the final resting state:

        do {
                if (signal_pending(current))
                        return -EINTR;

                if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
                        return -EIO;

                r =3D kvm_mmu_reload(vcpu);
                if (r)
                        return r;

                r =3D mmu_topup_memory_caches(vcpu, false);
                if (r)
                        return r;

                cond_resched();

                guard(read_lock)(&kvm->mmu_lock);

		/* Comment goes here. */
                WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROO=
TS, vcpu));

                /*
                 * Snapshot the invalidation sequence counter after acquiri=
ng
                 * mmu_lock, as guest_memfd guarantees the validity of the =
pfn,
                 * i.e. any concurrent invalidations are guaranteed to be
                 * irrelevant.
                 */
                fault.mmu_seq =3D vcpu->kvm->mmu_invalidate_seq;
                if (is_page_fault_stale(vcpu, &fault))
                        continue;

                r =3D kvm_tdp_mmu_map(vcpu, &fault);
        } while (r =3D=3D RET_PF_RETRY);
