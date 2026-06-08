Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5A296BCC
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923414; cv=none; b=LUDsnmtGcHqCU0T002yzNUgh5WuYm0dsgEn2zQwxq2aB3X4iLqeAxl9vqw5GKNhJxul0fgdUCsfzRk7bQFuiFx8UJa92K7FREKUm2UytA8lBSCwCTYxKAkrAtKatL/zMKlF9MzjInklsdN9PYEIezGAs6J0v9k1KBDqyObiJmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923414; c=relaxed/simple;
	bh=D2WQwl802CwbmcBhdB9NAEsp8BhH8aco1xLmTDGTxyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0VdD5TMujCkE7L2J7FujqPo33YVN4ULe3gApnJSHjIE5gWFuCtAjPzT+/8saImx4/PSUnIt9iHYkzntA/waac60k6PNCCLiY9K/x9LBMbsy3iuzaWCoLawHdA4pfryKqhBuKmNr6BvMv1SXwRojwi9gzrSYF2hI5/LhCJIFM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnd6OJFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnd6OJFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F231F00893;
	Mon,  8 Jun 2026 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780923413;
	bh=Im3OKLzMWrqPf5OnIoe07sxccEQNoj9GMPGw/o5oOZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnd6OJFjG7V/DNm+92cXz82y18fxaorWlNE4FYFfkzZXYu1wLRpHAzgxshtCaOJhu
	 1I7kQS7XvnfKxQF0ytb+63/JE9SN3Ttt48BU9VfzOiJzKuklQ0KYBup6DHKEXhxDpA
	 P6xbjKqpEgjYkWdf5gOXhCVnu5bhFX9biIvrio44HAHKwgTi9GzeblL9MIVkFTRZKX
	 5Au9gb7A8rt2jCjoSezEGAvM2IQsKgZpqErcbmrJf2oKYkmqW7Ukq7+GX3zubEdPip
	 f1qxBgENksaesWce0lqwvEaH63fZoQ/B8wQ9XpZ0fZOH95ukTpsLV5UE0NTcBW5aCu
	 k8dvX1plcL7rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Add IDT limit check in __emulate_int_real()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kayra Cizmeci" <kayracizmeci@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608123503.23298-1-kayracizmeci@gmail.com>
References: <20260608123503.23298-1-kayracizmeci@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 12:56:52 +0000
Message-Id: <20260608125653.48F231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IDT limit check is bypassed for software interrupt vectors >=3D 12=
8 due to sign-extension, leaving an out-of-bounds memory read and undefined=
 behavior unaddressed.
--

commit 1d15914e95742042e4c5113eceda0a57155cbdd4
Author: Kayra Cizmeci <kayracizmeci@gmail.com>

KVM: x86: Add IDT limit check in __emulate_int_real()

During real mode interrupt emulation, KVM currently pushes data to the
stack before checking IDT limits. This commit fetches the IDT early and
injects a #GP if the limit is exceeded.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8e292e9a24df..ca9685a778c56 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2009,7 +2009,11 @@ static int __emulate_int_real(struct x86_emulate_c=
txt *ctxt, int irq)
>  	gva_t eip_addr;
>  	u16 cs, eip;
> =20
> -	/* TODO: Add limit checks */
> +	ops->get_idt(ctxt, &dt);
> +
> +	if (dt.size < (irq << 2) + 3)
> +		return emulate_gp(ctxt, 0);

[Severity: High]
This is a pre-existing issue, but does this check protect against software
interrupt vectors >=3D 128?

The KVM instruction decoder treats the immediate operand of the INT n
instruction (opcode 0xcd) as a sign-extended byte (SrcImmByte in the opcode
table). This causes the decoder to sign-extend vectors like INT 0x80 to a
negative number.

When a negative vector is passed to __emulate_int_real() as the irq
parameter, (irq << 2) results in undefined behavior due to left-shifting a
negative integer.

Furthermore, dt.size is an unsigned short, which promotes to a signed int
during the comparison. If irq is negative, the right-hand side of the
comparison is negative, causing the dt.size check to evaluate to false and
silently bypass the intended protection.

This would then allow the emulator to calculate a negative offset for
dt.address + (irq << 2) and read out-of-bounds memory.

Could the decoder be updated to use SrcImmUByte for opcode 0xcd, or could
the irq parameter be handled as an unsigned value to prevent this bypass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608123503.2329=
8-1-kayracizmeci@gmail.com?part=3D1
