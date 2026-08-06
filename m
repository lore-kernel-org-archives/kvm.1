Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E4430CE1
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054042; cv=none; b=c4UNs+1Hl1YO6iiKy4igIGONWoGW4iUEtJ78Zgt2qAfPlwWo0RToPdMrqKrrxGXTIB99XcQCpkCsbKmVwLJ44W0I+EZK0AW0JxvwrN6CkBlhycFCHHE+WI9b81WXgaM2w9uoeoz/k/eK1ru48Pt9tU4YZX0NChnjgeTjdjjcYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054042; c=relaxed/simple;
	bh=z5+u0ZTKK1IWAvSdwIK7la7ZGB+vmDtLWwCaTDv1RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDyfu5tSmab4OGLElfyTYWiyFv2NXMHjH4PY8GLwLJbuzd2IU0RnwtqnhqHoENjXm8dL6lj4YFxLYnD4zF4Rqvgq+qL3UlXPOYSFg8C3GtcnlwYvE5z/dDPNUBkva/u/q4mQdaxRRcG7Up1HecLJYcwwBBA+XHiW8MosNgS7XA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlYqzKjy; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlYqzKjy"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84870e7f498so2903049b3a.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786054040; x=1786658840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C8CmYhuc2bh32FqesWElv5k82mZb2LRrDBoTy6XOIGg=;
        b=UlYqzKjyKyHPeCFHDIxNlvrPzJ8O2Sd89NMgjgAFSgMZq3mVUq9M1UJ3+Lj83q3zyD
         o3aaHFuHyQAdKllfiY+xgwE3RodEqMMLPCzSDlhrEnwbx5Rg+75r/o3Y1xjYOZDEHfut
         79TpdWJQPvqNoOZWXusTnesVe7NClJeR6QGRU6RckEh2CwSapMUPLnrLJ0sZ5+T4+bvp
         gwm0m59rs9JDqLjYvXfJykcg6VcED8mpOOUd81vEidoWZRVoleqR1IruYXjUXNR0gMMg
         PRM0y98gW8rh4kT/xRA5/AsQj2qeEwei15HgSs9E26qnEnhx9c1RCodqQ/cReXgMZZd2
         mrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054040; x=1786658840;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8CmYhuc2bh32FqesWElv5k82mZb2LRrDBoTy6XOIGg=;
        b=tQ6nYClI4IEqyXY8pPOkxew3sPpOVpox70RkvwhNN73spDbznhpWpyZnplv88LmybC
         JdxQdDKla3+rjKVtnpWknugBFerWtKXSUNulkoVBEXOm063f1QyvKQ/iOyiqKVXMt24h
         cm5WjVRaL2lWdqv22yY+l5irIXiW1zNnBZfU++6j/LwWNGPQ4Y/wEa0q3ZBRxjh/v+My
         h0caEx0B1SxCMvXBJSU5ihzqrlRtbOBr90FKqBI8PHDmOf2cNSdeJmK3Sngxssd6rqdb
         pm771xj9th8EtjvTXkQzLXeRcr9NobzT8QiTMoE3ETLu4jUppctZLKospUwr1PAIYXg8
         jrfw==
X-Gm-Message-State: AOJu0Yw86+I5yam9jeSuNK++xLvvdS4CYKuVe0iPZPzbuC9EdTfYkulO
	8iWt+OXW/QENiaQAFcaNQw5OkXYPEpQuocX/LXc022UB5kObqRg1LWizxRKeBy1Gmrapo2/O8cU
	ynrC3Kg==
X-Received: from pgnb22.prod.google.com ([2002:a63:7156:0:b0:c9e:63b8:11b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8d81:b0:845:e9ff:5d97
 with SMTP id d2e1a72fcca58-84f2e025254mr23092206b3a.12.1786054040202; Thu, 06
 Aug 2026 15:07:20 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:07:19 -0700
In-Reply-To: <20260806215614.36B4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-4-seanjc@google.com>
 <20260806215614.36B4F1F000E9@smtp.kernel.org>
Message-ID: <anUFl4hBfq-bgz4c@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index c6cac893cbad8..379f570ef04f8 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu =
*vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
> >  		return -EPERM;
> > =20
> > -	r =3D mmu_topup_memory_caches(vcpu, false);
> > -	if (r)
> > -		return r;
> > -
> >  	do {
> >  		if (signal_pending(current))
> >  			return -EINTR;
>=20
> [ ... ]
>=20
> > @@ -5199,6 +5195,10 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu =
*vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		if (r)
> >  			return r;
> > =20
> > +		r =3D mmu_topup_memory_caches(vcpu, false);
> > +		if (r)
> > +			return r;
> > +
> >  		cond_resched();
> > =20
> >  		guard(read_lock)(&kvm->mmu_lock);
>=20
> [Severity: Medium]
> In kvm_tdp_mmu_map_private_pfn(), is the WARN_ON_ONCE() check for
> obsolete roots still effective here?
>=20
> Just a few lines down from this chunk:
>=20
>     WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu))=
;
>=20
> Because kvm_mmu_reload() is called higher up in the loop, which internall=
y
> invokes kvm_check_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu), it will
> clear the request bit.
>=20
> If an invalidation occurs during the kvm_tdp_mmu_map() execution, the loo=
p
> correctly retries, but the next iteration's kvm_mmu_reload() will silentl=
y
> clear the request bit before execution reaches the WARN_ON_ONCE() stateme=
nt.
>=20
> This seems to leave the assertion only covering the small window between =
the
> reload and the WARN itself, masking potential regressions where roots are
> unexpectedly invalidated during the map operation.

Yep.  It's honestly more for documentation than it is for actually catching=
 bugs.
Though I do think that if a bug were introduced, there would actually be a =
decent
chance of catching it because KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is set while =
holding
mmu_lock for write.

Moving the WARN up isn't an option, because it could get a false positive o=
n the
first iteration.  And the odds of this firing are stupidly low, i.e. it's n=
ot
worth reworking the code to skip the WARN on the first iteration.

>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806214050.78=
058-1-seanjc@google.com?part=3D3
