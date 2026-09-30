Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812A4BE43B
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805292; cv=none; b=JE4CaGk/2lTqPqlK8gq2KK8ObUfnVpofyeJQ00rRan5u5SVJzlj6a3X5Ob3V19t7BgZ7KqSdtS9RWldepSSq0+KeoyQzQjElbXf4juHxqxT7TU19ucFDfZlf+lKjdPTqd42fao15e5qqp5BVrgo+4de3tcMFvrdLcoFiYy3Kp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805292; c=relaxed/simple;
	bh=lsYWOUAYS1Z7KZjTaG4a/FT8RdPaT432f48aVIIH698=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0C1c+sqFkpWx6QkK8XLHNbH6RejudgA8Q33fZAX9k1jrl9Bd+sjcKM4z11y+3jllIVd8RGPth8t+FU34nLz7b6dqxIwh7+s844GNi9vy1QmkX9LCnZ50K6kcQ78liJ1ED8xEHAF2RD4ryFJGvu9aaLzXWIWB6s4yA/i/K/UIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgrem9SQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgrem9SQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DF01F00899;
	Wed, 30 Sep 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805290;
	bh=b4C6e/6usgLCUPqZAaKDkgmwHln+x89rYZTquwIVdj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgrem9SQM/WNgNFYzooRZ2Y3FWaL7jRsYP1DmIXQZCUavHBI+ev61IllvhMs8xcns
	 qkA2NqXHJC0RkoYBMabPDtNPXmCRLQwxg8W3nAprOPE3hwDvG0rUpGZ+WWE46HjhOO
	 EMsV5FAvsalvT6pvRNh5sBhlNxK4Z/SNXSYcOkHETfYrc4fB4CZ6W2Hr0ZlooD6l6F
	 fe6n5cj159y70+r19DJDQ44L9hpdSNbu4Mcm3DlqUHyVXeH5MxBppPasHcC8G5fudC
	 EePmD26KMWmRgKznzPnQtkioOFJ7fzYSfXn3rIPDMMwPCxQbb+torp63gP5sWfHv6b
	 VtMcnBumzXbAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/20] KVM: x86: Support REX2-prefixed opcode decode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-13-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-13-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:54:50 +0000
Message-Id: <20260930215450.B8DF01F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: x86: guest-triggerable host panic via REX2-prefixed vecto=
r instructions
--

commit a843761e784b5038177694143d4c70279320d66e
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Support REX2-prefixed opcode decode

This commit extends the KVM x86 instruction decoder to recognize and handle
the REX2 prefix, including validation of prefix sequences and correct opcode
table selection.

Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNchLZuK=
FU+MMA@mail.gmail.com

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index a1a567fd03780..eba4e9b7cd5cf 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
[ ... ]
> @@ -4980,6 +5002,12 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>  	if (ctxt->rex_bits & REX_W)
>  		ctxt->op_bytes =3D 8;
> =20
> +	/* REX2 opcode is one byte unless M-bit selects the two-byte map */
> +	if (ctxt->rex_bits & REX_M)
> +		goto decode_twobytes;

[Severity: Critical]
Could this jump to decode_twobytes allow a malicious guest to trigger a host
kernel panic?

If a guest constructs an SSE or vector instruction (such as MOVUPS in the
0x0F map) prefixed with a REX2 byte (0xD5) where the REX2 payload sets the
M-bit and an extended register bit like R4, this will jump to
decode_twobytes and look up the opcode in twobyte_table.

Because vector instructions in twobyte_table lack the NoRex2 flag, the
validation check for NoRex2 further down in x86_decode_insn() will pass
instead of raising #UD.

The payload bit R4 causes the register index to be >=3D 16. When evaluating
the Sse flag:

arch/x86/kvm/emulate.c:__decode_register_operand() {
...
	if (ctxt->d & (Avx|Sse)) {
		op->type =3D OP_XMM;
		op->bytes =3D 16;
		op->addr.xmm =3D reg;
		kvm_read_sse_reg(reg, &op->vec_val);
		return;
	}
...
}

It unconditionally calls kvm_read_sse_reg() with this extended index. The
index >=3D 16 falls into the default case in KVM's fpu handling:

arch/x86/kvm/fpu.h:_kvm_read_sse_reg() {
...
	case 15: asm("movdqa %%xmm15, %0" : "=3Dm"(*data)); break;
#endif
	default: BUG();
}

Does the NoRex2 flag need to be added to vector instructions in twobyte_tab=
le
to prevent this BUG() from being reachable?

> +	else if (ctxt->rex_prefix =3D=3D REX2_PREFIX)
> +		goto decode_onebyte;
> +
>  	/* Opcode byte(s). */
>  	if (ctxt->b =3D=3D 0xc4 || ctxt->b =3D=3D 0xc5) {
>  		/* VEX or LDS/LES */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D12
