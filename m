Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DC4746AC
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763603; cv=none; b=Gfncu0PcWsWRz2zNMoQgzeP/fK/i+YOpZ7pF7+eAYN0WQ3WlLyLglB/V0SZsqa2eTuFdxmpp7KyNxDNQ4Ix/MOIPNwsx4Uh7cjTaq2jUeBWdfWajOWOwlA0aK1kFSdZwwaCYYM/aDa5mhbczWq+hUsWNMY7g2gFSDyyVjo7lxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763603; c=relaxed/simple;
	bh=8dUd/HDfvfgRhjsU94X4bPMVHWE3aNOLd4v5yUbRZAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QxtFyZ/OStwNmmFNR1rf2Z98sX/yFE7zCcdI3CnQPMFtu520glhjkB59qciFRasHXHh3BtfnPFcqRXJh1CXQ5VVl2wcnLVEyfoV4/Z6i/maBCNhiPOWWf0oZTB4ZmSmFgJ+Hu95x+6YZjRpIBwU6qzIimHbwq/TGOedkrBV13T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSCN7qOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSCN7qOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EBA1F000E9;
	Wed, 26 Aug 2026 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787763588;
	bh=mgy/1HoIdQE5uxLRGuFFFmkxa7c0IcNBwMXEyXcG5KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BSCN7qOg4aW8TUo2WEFzGvqrhc6kxEMtzNmZpwceh3qtiRMcJwpt50+DJxm0He25g
	 mbhKqAlY8MRC2FSNxpDyx6eejiHnHzsVwjE30EZjNS7Oi8XcA7vY2XyPReeFPsOlia
	 Zm8//JaxHtvMCEUjBDBRCqtqZy8JSqq7Uixq2rGHsqkZ7Q/qGP1q5ELn9jBoVwN4uM
	 w5Xi2RZod/QmfOvTpfLaRPKME8VpB0yHrUHhFozw/ec60JyB6LEYk1/tBLJDtzvQot
	 n8zxLt8ihNN6ibQEzQRV4dRUzIVsE4T6/JS0SnNy0b2KSeYOIMgTlUjzN0HBjBQpPM
	 Fegf96vCT4h2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826164214.756512-3-seanjc@google.com>
References: <20260826164214.756512-1-seanjc@google.com>
 <20260826164214.756512-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:59:47 +0000
Message-Id: <20260826165948.31EBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The WARN_ON_ONCE diagnostic to detect unexpected root invalidati=
ons evaluates after the request bit is silently cleared by kvm_mmu_reload()=
, rendering it effectively useless.
--

commit 5bfe54f32e3516c8d2a1f4dc3a29739732e31eb5
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Harden "map private PFN" against unexpected root invalidation

This commit moves the MMU reload inside the tight loop in
kvm_tdp_mmu_map_private_pfn() to better handle unexpected root invalidation=
s.
It also adds a warning to detect unexpected invalidations that break KVM
expectations.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3220f05387b58..1969c26861e5a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -5224,10 +5220,22 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *=
vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
>  			return -EIO;
> =20
> +		r =3D kvm_mmu_reload(vcpu);
> +		if (r)
> +			return r;
> +
>  		cond_resched();
> =20
>  		guard(read_lock)(&kvm->mmu_lock);
> =20
> +		/*
> +		 * Because slots_lock is held, it should be impossible for *any*
> +		 * roots to be invalidated after the initial MMU reload.  WARN,
> +		 * but continue on; the above MMU reload will do the right thing
> +		 * if the current root is actually invalid.
> +		 */
> +		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));

[Severity: Medium]
Will this WARN_ON_ONCE ever trigger?

Looking at kvm_mmu_reload(), it calls kvm_check_request() which consumes and
clears the request bit:

static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
{
        if (kvm_check_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu))
                kvm_mmu_free_obsolete_roots(vcpu);
...

Since kvm_mmu_reload() is called unconditionally just above in the same loo=
p,
won't the KVM_REQ_MMU_FREE_OBSOLETE_ROOTS bit always be cleared by the time
execution reaches this check in kvm_tdp_mmu_map_private_pfn()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826164214.7565=
12-1-seanjc@google.com?part=3D2
