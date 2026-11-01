Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544832;
	b=FzbA08woCUV8zp6InFqzYz5Z1gcMN0WOpmI7jMxI5dGPIBgQ+zTplLo96yFHiyYnnVIq
	 sgbTiHTujcdH2g61qobZz5ESCoP7DcfJkOnJicPlpgpPSx1RESW3IEJZlS+ZNN8vY5hiT
	 b9qdleM24EP05Y82WOR5teC4RuulUkJuoGfXCiE6hPIoqhJEFgTC9koe3oXxoGK86kjfq
	 agXdrIAV8doNzNvHtjhjy29z+8DgF+HEROeik6SyV3mVEmUvIjs8bpQB/YiJYQu7G4ZPa
	 GJRvdO8XsDlzxjeacGd9h5M0smmGWNukiaHOX6TSey9ZlyGzBz1Zz79SnhqqEwU3www==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544832;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NPJv3U8PiDbUbRVv58nJOB2Jfe0XUqE86cda904I4jk=;
	b=NW4vp2DepbJmmS3BuT32INGMFyGx11EDH4dnaKcuD4PpxX5ZgXNc+yxE319rovMAPbJq
	 TqwfYRU1ZvG9UzpuSi2fprPO9nGqhhuZdfvb0ZpTSdYOpL/zvpN568vtULgNS1/3rc6/h
	 Xs9tuyIU2qXOH7VaVKvxpyPCi5lUtFOQV5ECuMaBdy9CJF+GpELkqzEumzTwsjIIzKy0k
	 Sy/DRMsb2hadlMPjWZ1P3CjRvDJC5pmx7qSFHfaiyVgcnJqFOunqq/CkVuApFmxDph2IV
	 ctNwAW4FNQBVHLiolf6DIz4IP1AxozCA0+Od3nUx5lqA2FHZL/3CovD1e+FYRG3605Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5NC+tDw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC1606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5NC+tDw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A9A1F000C1;
	Sun,  1 Nov 2026 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793544832;
	bh=NPJv3U8PiDbUbRVv58nJOB2Jfe0XUqE86cda904I4jk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5NC+tDwtkmUHlZ2VkmlCYt1+3vTDL0+oafRsXgXi1jvUys6E5BKCuFELeT6elVmo
	 RsfLPGc7qZA9EPTuf2gnk5GA20I75N9vF8vSiibBJwJ0LpmXgmzfWg4QbQnj3cA6IH
	 cyIPRi4C41ieYICaM7NAqkAY36f1fxhAMavvnb8+B7HDTUaXJS1lPP4trSJhsBYHPl
	 MilaxHVWTIxVL92tc4u1omI4bJcAYVVdhlUEdwtvbbC53KWnpzbs/QYUSxwQMHfBe6
	 AfWf4RHF++eJGQ06wySJPNOvwsqXnkGr5sC/frnufIXbPwgG33nd8j+jmb3Makk6JB
	 sT2lN/Mo4p7rg==
Message-ID: <sashiko-outbox-192458@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 2/7] KVM: PPC: Book3S: Don't call __ffs() on an empty
 pending_exceptions bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <b985cc12b0ed62599815ddf87e612bc8b6b2813c.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
 <b985cc12b0ed62599815ddf87e612bc8b6b2813c.1793543627.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 14:53:50 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: PPC: Book3S: out-of-bounds read in kvmppc_core_prepare_to_ent=
er()
--

commit 05f5afe597ebfa07475ccb012aebebd6487a463b
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap

This commit replaces __ffs(*pending) with find_first_bit() in
kvmppc_core_prepare_to_enter() so that an empty pending_exceptions bitmap
does not invoke undefined behavior and deliver a bogus interrupt to the
guest.

> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 2efbe05caed76..38816578d002e 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -401,7 +401,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcp=
u)
>  	if (vcpu->arch.pending_exceptions)
>  		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exce=
ptions);
>  #endif
> -	priority =3D __ffs(*pending);
> +	priority =3D find_first_bit(pending, BITS_PER_LONG * sizeof(*pending));

[Severity: High]
Does passing BITS_PER_LONG * sizeof(*pending) as the bit size to
find_first_bit() in kvmppc_core_prepare_to_enter() (in
arch/powerpc/kvm/book3s.c) cause an out-of-bounds read past
vcpu->arch.pending_exceptions when no exceptions are pending?

vcpu->arch.pending_exceptions is a single unsigned long in struct
kvm_vcpu_arch (arch/powerpc/include/asm/kvm_host.h):

	unsigned long pending_exceptions;

Because BITS_PER_LONG is already the number of bits in an unsigned long and
sizeof(*pending) is the byte size, BITS_PER_LONG * sizeof(*pending)
evaluates to 512 bits (8 unsigned longs) on 64-bit PowerPC or 128 bits (4
unsigned longs) on 32-bit PowerPC.

Since that size exceeds BITS_PER_LONG, small_const_nbits(size) in
find_first_bit() (include/linux/find.h) evaluates to false and calls
_find_first_bit() in lib/find_bit.c, which iterates across multiple words
and reads pending[1..7] (or pending[1..3]) out of bounds into adjacent
fields of struct kvm_vcpu_arch whenever vcpu->arch.pending_exceptions is 0.

Note that the find_next_bit() call later in the same loop uses
BITS_PER_BYTE:

		priority =3D find_next_bit(pending,
					 BITS_PER_BYTE * sizeof(*pending),
					 priority + 1);

Should find_first_bit() use BITS_PER_BYTE * sizeof(*pending) (or simply
BITS_PER_LONG) here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b985cc12b0ed6259981=
5ddf87e612bc8b6b2813c.1793543627.git.ritesh.list@gmail.com?part=3D1
