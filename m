Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280D38C415
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394631; cv=none; b=K1aRsqiG9syzjoo2JM4rZ/lVvv+KPWUbtSiQDhbnhKCratnnexV5ZwJ87YAmx1Sl4p0L/yx1fklm3ts6wFNaciNGX9KJHUxRJTCzL/atzxyUJO5Ump9Bl8vXmyW4TRNoxwCfB/+QaLsGijHKvvftpouh8kWgFtJB2A4bo8jLAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394631; c=relaxed/simple;
	bh=Nx2oJxCJfLY0Z/oOuMWDzpg6oQ20XnmlYnotOxoRsYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TQUtBHZpoNGMhJz3ztd3QNwW/YBqSIDdi6Mv5qp2ZAmCFmHBtKoYrJ+K5qo/pcfhO/o51uXP50GXISUqndjTrZEuap4k4EnINCr4cMpJFQozfFWYYmHsJkbY4owSQXaQRk4UdwgYYcjgDylaWmWjkbYVEPKuWN9YsxLx8JC12AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NehgtyTx; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NehgtyTx"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84885a4fcabso2573476b3a.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786394630; x=1786999430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W0CHJxMafMp5KIEbQEKj7SvQsoEqCMl/p3gQ9GclrUs=;
        b=NehgtyTxPKzJhR2opNI9hbfEJLdM0w/DFLuhbVVzDX6a5ZlqkAZpJvfPF1CnE7JpvK
         GNcTFEFu7xbH9uBBlUGRvFe8Tmovw6l8+URuCU1kdFxW4KgR/b7fTowwvEiblap9PmpV
         D+VMB2ihZgAKtrRxxbA6uAEp62w71mGpI7y5GPa0cIV0aNm/vq+5keGPVE2ygo9I1CAt
         O9l+R3tkD7+Ax2JxTyP0o449lXcRgDtlc/Endyj/QieqkgsZgN/i8nZt5/aal+quwm/C
         TbkexZR+cHELn2udc4IFSqmyFoEcUx12Ygc+7opoUo8uupAZxeYEXyOMlkZQlawwWedJ
         pwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394630; x=1786999430;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0CHJxMafMp5KIEbQEKj7SvQsoEqCMl/p3gQ9GclrUs=;
        b=hFNl/+U0Vye4VgfJ75JJP2wWk5PhAqSrwM94tFFv3M+HMwmJYLSkYIp9iD6LjhwRiT
         vXn4oUbR5+XbQIw1y2pml7Kmtvj3fTfRa2owgy7dn8RvPmbpsBE93zB9ZY/U/CVQJKId
         G9mrrH3EqiFwefvnfCxX1r10rXo0wcPfpmaznPTJMLrRpN+SIaoajvdUKcww2JBQIzpP
         QrwlLffSuQDInl1AIYMcAodcchTHFP7Zh0RAv+aJ5WN0v5kdBZv1k4qcxG6Ap6r5FXSg
         qvMhpK80vGtddTiCB+XMvw/2xAKPNYN1ReofZbQsj+xfLjNQiHFrzg/k1Lo5vIcN1eAL
         pM7w==
X-Forwarded-Encrypted: i=1; AHgh+RqXunhiLQqQilrNC6obUuewbxdzRuNXQIIj0i6KI0N+lsk0t1oQCkcqprSnpSmQowYxglQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc2lGxZ8CymHXNkcSHrRwL/LRyXM15T2QJir7zOsRxRiFdQw4M
	wHQFP6JT1FmJKAr46GvMd4EtZf9UTEZj+8FZCAAxwNmnWRMHuILqIQZROaFju87oNZnHrmoGPon
	I8TxdNw==
X-Received: from pfbfh36.prod.google.com ([2002:a05:6a00:3924:b0:84e:7be:bd38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c2:0:b0:847:9518:a6fe
 with SMTP id d2e1a72fcca58-84f4feb850fmr33135084b3a.26.1786394629381; Mon, 10
 Aug 2026 13:43:49 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:43:48 -0700
In-Reply-To: <1fc757de50acfdfac5f734a3ad1eaed4123cfbf8.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-4-seanjc@google.com>
 <7867c759880de0ea4628deccfaa077a5d1c5fce9.camel@intel.com>
 <anZYib2bADjRmxvE@google.com> <1fc757de50acfdfac5f734a3ad1eaed4123cfbf8.camel@intel.com>
Message-ID: <ano4BBXU-Y_ah4DN@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying "map
 private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026, Rick P Edgecombe wrote:
> On Fri, 2026-08-07 at 15:13 -0700, Sean Christopherson wrote:
> > > I think it is the same for the other caches consumed by the fault. I =
guess
> > > "e.g." covers it. But it's not new after DPAMT.
> >=20
> > I don't think so?=C2=A0 Especially since as you point out below, nothin=
g else can
> > muck with the SPTEs.=C2=A0 The TDP MMU only consumes an cache entry if =
it
> > successfully creates a SPTE, and since nothing can muck with SPTEs, any=
thing
> > created on the first attempt will still be there on subsequent attempts=
.=C2=A0 I.e.
> > the TDP MMU might create SPTEs that are ultimately unused, but I don't =
think
> > it can exhaust a cache.
>=20
> Functionally we won't see multiple kvm_tdp_mmu_map() calls during
> kvm_tdp_mmu_map_private_pfn() because of the locks as we discussed. But..=
. if we
> did, then I think we would have the same pattern of freeing but not toppi=
ng up
> before retrying:
>=20
> kvm_tdp_mmu_map():
> ...
> 	/*
> 	 * The SPTE is either non-present or points to a huge page that
> 	 * needs to be split.
> 	 */
> 	sp =3D tdp_mmu_alloc_sp(vcpu);
> 	tdp_mmu_init_child_sp(sp, &iter); <- shrink mirror
> 	if (is_mirror_sp(sp))
> 		kvm_mmu_alloc_external_spt(vcpu, sp); <- shrink external
>=20
> 	sp->nx_huge_page_disallowed =3D fault->huge_page_disallowed;
>=20
> 	if (is_shadow_present_pte(iter.old_spte)) {
> 		/* Don't support large page for mirrored roots (TDX) */
> 		KVM_BUG_ON(is_mirror_sptep(iter.sptep), vcpu->kvm);
> 		r =3D tdp_mmu_split_huge_page(kvm, &iter, sp, true);
> 	} else {
> 		r =3D tdp_mmu_link_sp(kvm, &iter, sp, true);<- TDX
> error(BUSY,etc)
> 	}
>=20
> 	/*
> 	 * Force the guest to retry if installing an upper level SPTE
> 	 * failed, e.g. because a different task modified the SPTE.
> 	 */
> 	if (r) {
> 		tdp_mmu_free_unused_sp(sp); <- free_page() external and mirror
> 		goto retry; <- return to kvm_tdp_mmu_map_private_pfn()
> 	}
> ...
>=20
> Without the additional top up in kvm_tdp_mmu_map_private_pfn(), the retry
> wouldn't have enough, right? The 'sp' goes back to the cache, but the
> external_pt doesn't. Actually, hmm...

Huh.  Right you are.  I completely forgot that flow existed.  Seems stupidl=
y
obvious in hindsight that something like that would have to exist.

> But that is why I thought: No functional issue with or without DPAMT. And=
 the
> brittleness is existing.

Ya, agreed.
