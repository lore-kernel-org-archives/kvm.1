Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CD3EFD00
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979123; cv=none; b=Qi/9gCiCj+KRuL5XZzhzFrPVBWyt6ja9qNNWO7hftxNGqBWCiwxgXDvf0N5m1Oe9pJWPN0VNYkci9cmNe3HlWY5X/Wvm1w8p+C0FCLM5vv8q3v+NFlt9ty6pWe2VZt4kYHKmbYhA99aFtPqSOQvp8z4/hE4v5iWtRGUiucxJE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979123; c=relaxed/simple;
	bh=b9Mzxd1L/I8CKxifUqxYIDZshZwnGrvOOX8MpbbO3H0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eAxC51rE4i7F10HqqRmzTHDyyGYnYsMGWL2JKIins06RtF4vZ0P0mjSuQYzxJquDYADor35vqlpJpYulwSjQWgbV7bHSqWuK/b94cAH5TwXz2/oQxDNSLFhVXP14FvFGTs/RSpzAjLIJCGvIzNgV6bkl/NZy4+Hea1YjQ4QZDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6KlcgRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6KlcgRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5131F000E9;
	Thu, 28 May 2026 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779979121;
	bh=/bgYGWcfVwhL1qLaZVuoTQfs/MA6NCx4JMtfIagWzsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6KlcgRJf0qPbPhRWBi1uZIrd0De3jRyWlTKlmjUHcJPbBqiXEmcc369uoVX1Ttdp
	 a+RQUn5HHX53g5xkyzhlpj14Hi4ludw6mkgZ7M3wufgZv18bh9AyDBLEEDTNpsJNh8
	 Eq8BgntJ3m9BbCnVpxQJWPoe6eLhgtjet11poOouOEmxJHUMhBpOdVbWHUBVKq2ZB8
	 ktf+jNP4RjAJvhki7Lh1F4XIJQmfKCyCoNWTinjNyddT1Lk26Zx3Ixr9ZodXxwnc9+
	 z8LYPOMugqvXZ2uDwtUiYcmoTeQfCBxUd9UbKyQCJJev5MNiTdG4IwFhk87ji0WC/e
	 H0sFMrpMBFIAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] LoongArch: KVM: Add PV TLB flush support via
 steal-time shared memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cuitao@kylinos.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528133558.2196416-3-cuitao@kylinos.cn>
References: <20260528133558.2196416-3-cuitao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 14:38:40 +0000
Message-Id: <20260528143841.8D5131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The 32-bit atomic swap instruction amswap_db.w clobbers reserved p=
adding bytes in the UAPI kvm_steal_time struct.
--

commit d4000d1116a018c602e41566e436903cda12c70f
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Add PV TLB flush support via steal-time shared memory

This commit implements paravirtualized TLB flush for LoongArch KVM guests
using the existing steal-time shared memory page. It uses the preempted
byte in struct kvm_steal_time with an additional KVM_VCPU_FLUSH_TLB flag bi=
t.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index d82782b90457b..3b505a1c0a9f6 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c

[ ... ]

> @@ -173,7 +173,37 @@ static void kvm_update_stolen_time(struct kvm_vcpu *=
vcpu)
>  	}
> =20
>  	st =3D (struct kvm_steal_time __user *)ghc->hva;
> -	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
> +	if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
> +		u32 old =3D 0;
> +		int err =3D 0;
> +
> +		/*
> +		 * Atomically read and clear st->preempted.  amswap_db.w
> +		 * provides full barrier semantics and avoids the race with
> +		 * guest-side try_cmpxchg().  Operates on the 32-bit aligned
> +		 * word containing preempted (pad bytes are always zero).
> +		 */
> +		asm volatile(
> +		"1: amswap_db.w %1, %z3, %2	\n"
> +		"2:				\n"
> +		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)
> +		: "+r" (err), "+&r" (old),
> +		  "+ZB" (*(u32 *)&st->preempted)

[Severity: High]
Does this 32-bit atomic swap clobber the UAPI padding bytes?

st->preempted is defined as a 1-byte __u8 field in struct kvm_steal_time,
followed by a 47-byte pad array.

By using amswap_db.w with a value of 0, it seems this writes a 32-bit zero =
into
guest memory, which unconditionally zeroes out pad[0], pad[1], and pad[2].

This would prevent future KVM features from safely using those padding byte=
s,
as older hosts would continuously overwrite them.

Could this be done using an atomic AND (amand_db.w) with a mask of 0xffffff=
00
(since LoongArch is little-endian) or an ll.w/sc.w loop to clear only the
preempted byte?

> +		: "Jr" (0)
> +		: "memory");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528133558.2196=
416-1-cuitao@kylinos.cn?part=3D2
