Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A049362F
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505127; cv=none; b=uQydxx6UJaANoonoAGBxjpeLoQiWl46ww4rn/K7wy0hXjst1AgZc7l4kkCxGVNrxMr3syBagn2sWpCfhh7ha7oRSpRXQ8bAHKRWn63PEbDnD87GA+6Bul0xOoTDpfre3w9cPX2QYnnlI7jTMAIZjulpanwHMuDNrZy4b36Gry1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505127; c=relaxed/simple;
	bh=KmmEwfS4uV1chnx4KwblZnBTCEFSvEBDK1TaGvhKhGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q6uxYUEPZLEfjhWrOELXWOz4dIoWkwwIT7Ram8H2L4GYXef/QB2mAwvaLS6U17Wc079HxtcXCdAMBI5GacbAdktP8Ei16D1vuXyxC1Gfvr0jEYTNe2/EN9winQ/Lfamxak03J/X3LHyvsXirS5Zs6ZEeraAqcbvJLhBndOoqsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS3y6yVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS3y6yVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB231F000FF;
	Tue, 15 Sep 2026 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505123;
	bh=DLGNOMgg565/FSt9aShismrxFbCgj18HvDs8PEmP+Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QS3y6yVgVXXxF7FV0BqmnGzkGZyt+RhjrZIw4X+kUIka3bBy22zQp4yKeT3lU35lL
	 B/wM37BOp4kgvH0I2OdWlODZLuk94jNzkBz42RdG/VklMwH/hXth94UTE6xiR+gD/N
	 tIYhvVUITgivvmuGAFabGg+wMEydBd2v55ykoDScVMweK/XHgk4VMxbrvJQT7SjDwc
	 W7VVfVNa8gROyaG749JyXkR1eqqdzjdi7ajB+fl4ImejN2JOPoMPt5Un1EhYSNVZWe
	 RA/mvk5bukPJWlw9i+wtD9Y8tZ/4w6yOGiSrWW6iUv9bJZ77aO44gCFRs/2R5Nx7tF
	 F7IuwmsdVLF3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Fix NX page unaccounting for TDP MMU
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260915203511.1808028-1-clopez@suse.de>
References: <20260915203511.1808028-1-clopez@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:45:22 +0000
Message-Id: <20260915204522.EFB231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mmu: build failure on 32-bit x86 due to undeclared KVM_TDP_MMU
--

commit c2443a58667359b4d898625aee21d7fa954accfd
Author: Carlos L=C3=B3pez <clopez@suse.de>
KVM: x86/mmu: Fix NX page unaccounting for TDP MMU pages

This commit fixes unaccounting of NX huge pages for TDP MMU pages by passing
the correct MMU type to untrack_possible_nx_huge_page() instead of always
hardcoding KVM_SHADOW_MMU.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 9788ff1803740..61996669b6f6a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
[ ... ]
> @@ -866,9 +866,11 @@ void untrack_possible_nx_huge_page(struct kvm *kvm, =
struct kvm_mmu_page *sp,
> =20
>  static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page =
*sp)
>  {
> +	enum kvm_mmu_type mmu_type =3D is_tdp_mmu_page(sp) ? KVM_TDP_MMU : KVM_=
SHADOW_MMU;

[Severity: Low]
Will this break the build on 32-bit x86 systems? KVM_TDP_MMU is only define=
d=20
when CONFIG_X86_64 is enabled. Unconditionally referencing it here in=20
unaccount_nx_huge_page() will result in an undeclared identifier error when=
=20
compiling KVM with CONFIG_X86_32=3Dy.

> +
>  	sp->nx_huge_page_disallowed =3D false;
> =20
> -	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
> +	untrack_possible_nx_huge_page(kvm, sp, mmu_type);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915203511.1808=
028-1-clopez@suse.de?part=3D1
