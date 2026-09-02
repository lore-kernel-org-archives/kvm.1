Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FD309EF2
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317968; cv=none; b=L7sgfDnuFMIv7PmTry5fmQUlEk/pfxXJEe6JME+ML8ONOWebFQXTFHrtuDH127jgypxegedFU/iMDESKxvX9pNwt50fzPgJlSy6jIF3Tk8+9b7mWLFlyXbebEBEMcikYLUHAsHh6E7aLRKN8n3feB4BOCltbf7ZUKOW1pfCQIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317968; c=relaxed/simple;
	bh=NKWuFCbdwg0smELJIhVb06N1MNuL5NT5egAtHPHMBFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPk9bMepVgjEDZsU/cek6fZRpL9lEXXjksN+K8EYkc2uk023ta+p88GwOs7BfFKvVmDexXRYWVppV9QbreSDfRhFyzS3FGi3d0KWL7mRTi5lR4qvtYZEUQoLRZ86EQrff5gqFURHjWvmA3dyfzB9rL9U0VCuAavWMFs96OoxiN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXwHNweN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXwHNweN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33F61F000E9;
	Wed,  2 Sep 2026 02:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788317965;
	bh=2uxvw3DE2AMO7JS0TNcaPtAwvwFAEOmVbiLoWcrc/J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXwHNweNpNFfx9NhC/BqaLkB/Mb7437AKo7xenFh0kXSCUAnNX7AU6muleEg/deTp
	 ywCmSs/nmIvX/ZrNiEDf3wchOt/rpfIFBE40IbuqT53XD5R5XpTp+Ft7ODLylPG06N
	 YOOb2dvQwKMmlIl6y0B34QuacSNdnM/yIV/JCxlt4+zOEBQxo6I7n0Z2VM90jFzNFa
	 HtBO+d+KLsJDvBe94pvKCDXUF5tYpawXTI4WiMvfcITH0TzXTnGmZCSwM40wBEr9JQ
	 jHmACIhoR8843ObdkJUJN+MrmQ1TzKFlabWIvHjVzdoLdQ/mX0gH3MK4oH/bcNgalX
	 riv0IqD+BzuDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/20] KVM: x86: Reject EVEX-prefixed instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-14-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-14-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 02:59:24 +0000
Message-Id: <20260902025924.D33F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The EVEX prefix check reads `ctxt->modrm` without fetching it, r=
esulting in the use of a stale value from a previously emulated instruction.
--

commit 01b255a08e34ec61090bf09c90c37d94d681cde4
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Reject EVEX-prefixed instructions

Explicitly mark EVEX-prefixed opcodes (0x62) as unsupported.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index eba4e9b7cd5cf..f0d5a40eba27f 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5052,6 +5052,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>  	if (opcode.flags & ModRM)
>  		ctxt->modrm =3D insn_fetch(u8, ctxt);
> =20
> +	/* EVEX-prefixed instructions are not implemented */
> +	if (ctxt->opcode_len =3D=3D 1 && ctxt->b =3D=3D 0x62 &&
> +	    (mode =3D=3D X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) =3D=3D 0xc=
0))
> +		opcode.flags =3D NotImpl;
> +

[Severity: Medium]
Does this EVEX prefix check read a stale ctxt->modrm value?

In x86_decode_insn(), opcode 0x62 is mapped to NotImpl in the 1-byte opcode
table, which lacks the ModRM flag. This means ctxt->modrm is not fetched
by the check right above this new block.

As a result, if a guest executes opcode 0x62 in 16-bit or 32-bit mode, this
condition evaluates (ctxt->modrm & 0xc0) =3D=3D 0xc0 using a leftover value=
 from
a previously emulated instruction.

It was previously suggested this might trigger KMSAN warnings and cause a
host denial of service. Since ctxt is allocated via kmem_cache_zalloc(),
KMSAN sees the memory as initialized, which makes the DoS concern inaccurat=
e.

However, does this logic flaw still break the intended EVEX detection? Since
0x62 already evaluates to NotImpl during the opcode table lookup, it seems
the subsequent opcode.flags =3D NotImpl assignment here is a no-op with no
functional impact.

>  done_modrm:
>  	ctxt->d =3D opcode.flags;
>  	while (ctxt->d & GroupMask) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D13
