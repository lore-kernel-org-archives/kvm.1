Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793940546;
	b=cYfXacMd5yoeZ/wXDFTUppqj52UqtJWd7ejmncvRmm97QgZWNJ0FUVYl6/f6u73KGbqg
	 HoFPOfOB1n1G59EHbBBuzXVMV8fUzhJxeGsr38SogjjfTgJtDEeHs1LmLbjWHb4RfvEqB
	 T7wK1KzPWNDBo8vd2KREXIFA5I7iVGHxEgsZWyPuM6VvM30FFuUzcU4VVIgFbmCBqdXql
	 KH/wLBfgLnrdVrVfyLPgkF/eyzyyEY4X+JYSENP06oxtE+xz8/xW3DYipJBe2xxYlkIPR
	 KoqC6nL7HrPW3oQi4fuLhKmy2JN7QONiyWaNw20954fqQU10hddQvsoX9keFFwuYYuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AXgtC+uzvBL8URbn++UYMD0lFRYfFcx1u0QqN2Fgjus=;
	b=r8qn0ePdnh3u8kWpmh0h47TTWBBcUCvideTX75R3u5XMA4EsvkpEcVLNqi0osAhtkD8i
	 SAxEaUQKIEYGWkT2Tnm77354XkAtCJEXmNbXJSrIr8Vj0hMv4M2XzuRJTaiEaL4kkAMdM
	 cZwWNK/mVG6NgaNFl5IXK+MlaV3GvyIKPLduoL/Lm7bHhkNf5i+NzC14YhL7npLg5GJPA
	 8S3PXszZK1auJPMTWLNKokTvKE6Vvz+E/okDPcKNAJUAY8EXa9KLjhKMgs/TZlt1nV3az
	 BUG/0G4aCcH63pJYIdjwz/k1/SjZzVwFnRy8ytPXGB75y/SbFbKN9UnpM2vCepT0LYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qj9hSY3E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54101606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 04:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54101606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Qj9hSY3E
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so808a12.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 20:49:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793940545; cv=none;
        d=google.com; s=arc-20260327;
        b=nnz8AnTZUbkw+fWc2FXiaTi6KkY8aASOzzAeunTFq6AMazJORFV93HIddc44eyDLCO
         oZ/EUJS9bgLiJB/RFSUMYIPOlhBDSkEvtGOfbVjF6xX3DNg23XULBvuwPzPxlIsZI3Tx
         TJ705SlHdWnLJ2L3ZTVFD/rsd1Jg8pwxn58uQqzDxjCporHADmq97O76dRRP+e6Egx77
         wynF91nf5tvDDeU7GAOXuYrJeEnhiYogGRHpKqdrNGb5wv9dv7FLINVfrtAB5iPUlM36
         PlhJ3BYjahemXiO3nuIdjniYB0qaUVHkDMvgXGSfT307t/3LtD6BE0glwSm1s9AYwkFV
         JiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXgtC+uzvBL8URbn++UYMD0lFRYfFcx1u0QqN2Fgjus=;
        fh=kjjJdrSR9cWsmRPIvM/ycp0X0OSwC7asWH7XJtJ1kbM=;
        b=WLjKNLm3t2sA5+aOcdHlNXqhsxOmKE2sGYoGaFA1nK9mZhaQkaRUlZUx4M6S7x2unT
         cL8jW7QCGMwUZv4Am2ibmaUfM3CM4OqJ+3YDbZvXoRFIf1YLyjjTkGG1APoE2sOxgRnS
         j54hGVeF7GQ3Ls84jXfmPoZvEHReJfuJyQx7Bq3ZsIq+ZwepEEwoEzPQKblmaRPO79lo
         3h0wZ0k4OrD0AMkfNyrlb7umtWLJOmnVQXj+VQZVGisgACKkZDWTRJy0SfcuVKW/jOXe
         FhCfr++eAlX/hkjK3vmuFKKwzH7nkWJF5Y/EgY/RyYTaJvfQE1taRsYMgqEtSvqM0r0K
         UUAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793940545; x=1794545345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AXgtC+uzvBL8URbn++UYMD0lFRYfFcx1u0QqN2Fgjus=;
        b=Qj9hSY3E6uneZFB1f/IDKRKoWHY0lyC2i9I794X9ValaeCAhhwh1r4KZAAQMVnQThN
         AwOtxeP/hYvWt/w2kMt1dVVcZCxVKfbeajKMV8hx2lwCBnY0D3Ep9d6TlDWMvYQOb90R
         zT+sdPdEc5/R/8uMEj/fj10wGoUgBnrZ/0C7ztRnbYV4z0UgetnGChm59OO4KsQNtJ/6
         WDXSIxi01qkEFCJoE7WCg/9SNS9qbLRBLCBCg0n/7I43qTJCvVGjVI/IaB3e+r59qZLg
         4O1HLf5tNdfsT8Q584ePbclSfWG/4gcc9pObT7j2Gm/W052V0AT4jLzuyLXTWA/pLMU2
         bLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793940545; x=1794545345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXgtC+uzvBL8URbn++UYMD0lFRYfFcx1u0QqN2Fgjus=;
        b=guOhehQrGIiqbrudME15rr0XTK1zSXdHWveYlOBVntqfXqUnQT9KPJRdu+0XaQXzii
         VfcDik0haqsyd71xwoXZENwbEptosRkCQyO78P94YRqules5wnvRD5piodiB0APfpAl9
         I838dMYdSxciBIcXQsx+UwY1sMSW/r35L+jJsMK9RWXEaPy/P3xfTXmfe/CyOPP9qRZ9
         3xNiDkQwohgdP3LQ5ywPc9ABrNslEM5yOQiFcRwn2B0q9dl83yR7XX5XTvi+dgiHKi6U
         8AUKTK/MhpvstJuJyM9PqH8KIziO9c9MiinlX31E2ujd/R/c2kv2738Iof/i7InvsGUR
         E+Yg==
X-Forwarded-Encrypted: i=1; AKwUvBx64LfnGX3AGnRvf86IPJCkyq5aGTIGH/hRG9Crtr1MqR1M+5JISPJZJ/odXAl3+YpgWk0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wjNsG2kHwpGqlmkwDI7s1R9tZVXHciS6XdsD3do5qGUYQq+dD
	Y7FMfxSjvJq9chhxmbiDWeUez9fRBxHPA6DE1rjJuLGFb3ChtI8J4c0lIKITMkkFP44in8plotO
	6yuPxoCkU9yK0jFXo4BvWnSSWh3YKzun9KqYTOMgIH/mxr5Tlwr5xbfzW2yo=
X-Gm-Gg: AYBFou1/rggoa/lvTjZXFObgIfvNaRho2JZm/LZ/EV99EJrpj/JOqjd27n2nuhHlLg+
	y9EZEngL6hLBV3DssA3dOSTxQ8R83mRdYx9JZ51jb4cN9naKUgUk66N3mwAES3fiw3RFqRUVj+b
	QmTnpr1rZHT9sl26IhMVCIYG04a24fAxo+B7TJA/gs7iRpsa4FSlxbA8SWYCaTU++4aU3WrDYLG
	utTQxzZjLTB4CjBtp5XFkhfKy6f/179dr+b7Nlt2yZeHV5W0Xpyw7pbC36DgDzl7ibcE8TXkGW1
	19UoWifLlE/d27rCwSlfie9FFuiQA38ebSiEek+0YDWtCDAsRTwFrVRyMo6yR22EJSb/qHt0kMM
	vs6+zwhVe1Cq0NjwcvNUG7q4Wf3ic4EcyfplFt5x4zRvisCFeZ+K14oU87P4WAtoH1PJJiplEgR
	cTEgj/sBQPkzk2az7ctAoor6MQ
X-Received: by 2002:aa7:d80b:0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b6e762aad6mr686a12.15.1793940544242; Thu, 05 Nov 2026 20:49:04
 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-13-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-13-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 20:48:51 -0800
X-Gm-Features: AclHuK_o9i4JZ8lB8IjHuT1J30DQE0_pIpPmIAYaAPQPWqapU0-9RXh80TZCrBg
Message-ID: <CALMp9eS_NHtj--citTS_PhrSSfUG=nfLNLDcDFBX9rhY2CqF=A@mail.gmail.com>
Subject: Re: [PATCH v8 12/20] KVM: x86: Support REX2-prefixed opcode decode
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:32=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Extend the instruction decoder to recognize and handle the REX2 prefix,
> including validation of prefix sequences and correct opcode table
> selection.
>
> REX2 is a terminal prefix: once 0xD5 is encountered, the following byte
> is the opcode. When REX.M=3D0, most prefix bytes are invalid after REX2,
> including REX, VEX, EVEX, and another REX2. Also, REX2-prefixed
> instructions are only valid in 64-bit mode.
>
> All of the invalid prefix combinations after REX2 coincide with opcodes
> that are architecturally invalid in 64-bit mode. Thus, marking such
> opcodes with No64 in opcode_table[] naturally disallows those illegal
> prefix sequences.

This is only true for 0x40..0x4F, 0xC4, 0xC5, and 0xD5.

Per Section 3.1.2.1 ("REX2 Prefix") of the Intel APX Architecture
Specification (rev. 9.0):

  Furthermore, since the byte following a REX2 prefix is always
  interpreted as the main opcode byte, any legacy prefix byte (namely,
  0x66, 0x67, 0xF0, 0xF2, 0xF3, and segment overrides), a REX prefix
  byte (0x4*), a VEX prefix byte (0xC4 or 0xC5), an EVEX prefix byte
  (0x62), or another REX2 prefix byte (0xD5) following a REX2 prefix
  with REX2.M0 =3D 0 must #UD, because none of those bytes is the opcode
  of a valid instruction in legacy map 0 in 64-bit mode.

and:

  The 0x0F escape byte is neither needed nor allowed. (That is, the
  REX2 prefix followed by 0x0F triggers #UD.)

In opcode_table[], 0x0F, 0x26, 0x2E, 0x36, 0x3E, 0x62, 0x64, 0x65, 0x66,
0x67, 0xF0, 0xF2, and 0xF3 are all N (NotImpl), not No64. When any of these
bytes follows REX2 with M0=3D0, KVM will return EMULATION_FAILED to userspa=
ce
instead of raising #UD.

> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNchLZ=
uKFU+MMA@mail.gmail.com
> ---

[ ... ]

> @@ -4958,6 +4969,17 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>                         ctxt->rex_prefix =3D REX_PREFIX;
>                         ctxt->rex_bits   =3D ctxt->b & 0xf;
>                         continue;
> +               case 0xd5: /* REX2 */
> +                       if (mode !=3D X86EMUL_MODE_PROT64)
> +                               goto done_prefixes;
> +                       if (rex2_invalid(ctxt)) {
> +                               opcode =3D ud;
> +                               goto done_modrm;
> +                       }

"ud" is defined as I(SrcNone, emulate_ud), and SrcNone is 0. Jumping to
done_modrm with opcode.flags =3D=3D 0 sets ctxt->d =3D 0, which then hits:

        /* Unrecognised? */
        if (ctxt->d =3D=3D 0)
                return EMULATION_FAILED;

before ctxt->execute is ever set. As a result, rex2_invalid() always
returns EMULATION_FAILED instead of injecting #UD.

Also, because any legacy prefix after a REX prefix resets ctxt->rex_prefix
to REX_NONE at the bottom of the prefix loop, a sequence such as 0x48 0x66
0xD5 will not be caught by rex2_invalid().  Table 3.1 ("Legacy Prefix
Applicability with REX2") lists 0x4* (REX) under "Prefix before REX2" as
"Illegal", whereas the accompanying text says, "A REX prefix (0x4*)
immediately preceding the REX2 prefix is not allowed and triggers #UD."
Does hardware raise #UD on 0x48 0x66 0xD5, or does the intervening legacy
prefix nullify the REX prefix as in legacy encodings?
