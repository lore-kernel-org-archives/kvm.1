Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939683;
	b=PESEgfK3L5lVPf756PCbxMzIYnMoi1vSGQejdI+DYst07lmz7i82V9wWAb4AmAqPWIsB
	 giLoJEntlXF/AB+JagmFDGQ2MUdLnjdQzSM00TQ+uvlGOH4F8o2BbWs2n5DXxrrkrufpT
	 ngUmpkE25U2QlqHbB4nUgnQhvGaL4nFPtiMvqPP/lUSohC4Rq0p9h4XegcivOdlo1kxJY
	 tnNDd1k5Th82wbDkzomqES3P0S0uPbQAXAzmlz3Pd+bJqDb+/nG7qifNOszjT8kynWCLD
	 Lx78W+yG8Px5Q3/V9n2oJKWkriFPsZlZB3aUyV+vN7TUbJXb1RLNlcOH2NXKcKVXzIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GTWpSOIrW/I0u+o69vNXQD1in08W0Oj8xg0zoxTU70I=;
	b=rFEoIxTfp1PDWRLAf/6+fmrt8FFU87U8WUjhBtAxtG3UJdZUWZKmlHY5LMiTmJfXE9Xg
	 /kxw/IFb8WLwe9TR/M8S6cGYH+oMriNU4vHicJnV9oj2ePqKupkkdAtRfPki08MHDZmeG
	 UYcRRKwMxYzcCfWThA+On57xMSq1N19LPWNSmQfltQmjCLjg4CRX/ctl8wB186s8qHSwp
	 o+iaCGvOCVW3A7jVKlZS1RN2A0XBqrgMN6JmbbO44twxOFPorMeolTifmpJbV0hDpyyUb
	 SfS2qpmH5fAbeK7sAgZjsLnTt51YJ/pSoTPJ8yB9EIamUAc+0pYZiPCR7qPQJC9HLGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehsHOBSU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE053606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 04:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE053606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehsHOBSU
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso1789a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 20:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793939681; cv=none;
        d=google.com; s=arc-20260327;
        b=j2J0tIw/XE8+Po/0bDdG8T0uckAW6bRkvnnbCScAcQG9kaaetS0BCqiiGUdBwZNP0o
         PsTq/dK4+1xJnVKmCHrCORWTM7p/l6WnxWxMxv4KrKjf+RP1umVPXo7FoE0DQHOp2AIF
         CXzF6aGNXbOwRaJEHHehgkfki7PJ5VxMTkbzqWI58XnUUxZdlxs+X/Q7bbbFIb5NnAs3
         Tx57CVdNJ/7WB7zU59NKwvDjWtk/V3JIdiWNbmGqNu7sjB7k5E38ZCDYBlE0t7nqTGV8
         kYFy+uzJgq55lb9R97SQQofWLU0qVOWzC/IVduBl6I8OruU+ToFgdG2sxGuX1ADWZ/Nk
         QPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTWpSOIrW/I0u+o69vNXQD1in08W0Oj8xg0zoxTU70I=;
        fh=Il8/wBE+InBhOm/v+psu3lTcX/6WI7/OLjuztQDbZSc=;
        b=luNxaTlGJbGjtNCKfz7xetT+v8Y25J8Ovi2GdoZmKfPX0h90xz5JwR1OiqdGwLEpRC
         +Fb+rjMhNsYtIsUhoIzh9uwNCfF7G77Y1uXCh4vbyf9IJUIr7CC92cfYtkg/4/fYy1wL
         oYYwjQCifc8D2Xj5Cup0MQUJcZevDUlgi0Vt1zd42q96iuAkpBW4wkpVrYhhf1yPjf44
         8CyFNrrdCbrLHFRlNkfOBss/EyuFdPj+L81cO88J/7Xaar+J4MXjrt6UXM2b+70WwyoK
         mnGMKV+Std/B4ljPZCBOGVBYJ75AAKD5bgXXJ84QZGlp0VsylA5/7Q5fdAN2n5xPDA/V
         Rd3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793939681; x=1794544481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTWpSOIrW/I0u+o69vNXQD1in08W0Oj8xg0zoxTU70I=;
        b=ehsHOBSUrScJ0CckZozJsURRaHwfw7o+/weAZ+Groz3G/H9UusoTeLPSkyCa55ZBnq
         ye3I+2cqUNJXW3pbYDMn6GxLfrcgGj3t8O1Lrol2OTUvARGsEcrMw64gqfqJQ7xRWwor
         zehhfIRbFU0iuG7NrlrCnCscl8FUKhl2TR/v+q+gHHiscYfQyx8lF+GlKbr1u70hxYGR
         KM7G7B3I/YsA66EcCBqqgnn+CE/k+GhcK31pNKGOOqu2QYQAgzuKs08wTCah7oA6v2zI
         qxYMEdQoFQXaZ6kspc5KXxrK8WrP8SAbd4lxWAKpLICWkTVeEhLEyrY8VThYg89y9SNs
         0CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939681; x=1794544481;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTWpSOIrW/I0u+o69vNXQD1in08W0Oj8xg0zoxTU70I=;
        b=mFMYeI+gpDQQEozvPCVYem5ekJxI7R8FTn79Z9hC2BRcJqlQ8hBkvOGWZXq+cG/MKu
         ApUrA7LabBXQd+7DTI5rc4wOG2dG/7CyXHu3r0Krxmj4zb+JenPZ/NKpxf7yqIjADvuY
         xDxcVv7DrOzCloeJLkF5Q9IcR1H6OWAMD4mpfci+3X88ESsXjwu0nFHz5UaEWSNFLX1r
         ypj2KSjhDCDgcvqiEvEXuOAXl5Cu7SiGOhKPNYnT/2rmwB+JmCu+elipxBrfQrCEzQYz
         3PgRWZ3NBc195vEOsaHTnWSuH+VMlV8Kn++8RRXO4NNkuuEooI9IBCqmODevKlX3fvon
         6rUw==
X-Forwarded-Encrypted: i=1; AKwUvBwnC+Z7G8W9MSmxnsQmSYBtHO6ngHAE/V8iLmsfbm6ZT4L68L09HhHaEYqD8YVYXVLbIEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z974QF6Q7cmtHv3Ta8DM/zWIPMxudh4p7E0ZMbuaZlXdMvrdJrq
	UqEVdn+KRlJZZ9JcYMH4Eq0RWjszjjxBr7YXVJKILhaIGCASSBzatEitZWDYYdzhFzvUpWpC97l
	5ZvOLQxjokP5TnzMJlFf3AvvYfnFzMorO2S2df4hF
X-Gm-Gg: AYBFou04Q8l0WjieI6biRjQ8z0BVpAbFyDzRWSD4//nzGXpEi4fisY66FJWhCgjSSto
	kduBZhk/SpTAsQj01Zp6Z49MsqTMyQTSfbvD1Fu82x69BIjlKarSGOUg66tRhQnUmJ3Z3KmUjMO
	9m7W8Z3cCkS300Se0rXTEkco7/jiOPIM9KdYgxpd0XsSbrWFeUm063YW0z5+hgLWW9s5IkXf5ev
	o6wbmtPntpOccDkSsz7fyvYHnaWyQQ22lZjxqfZ4jj35wGpI/H5igHdlpPTXuQ+2it2gVyhZZXI
	SgH3Q5DRZoEF1DMjpgLHOaMkpoVr5+da12LAltBxxdmPEphvCcOsSy6m4U3MFpZtCKvzc1QX5ak
	DOpU8ljqHL484LR19Bhc539O2RVf7ZmQRukPqqtWHu4ccQ6tlBSyO8t7wKJc3FCoUGHLemOKyZw
	JUEKBjUewswjhqPUX2DCXoZsP0
X-Received: by 2002:aa7:d691:0:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b6e76232abmr107a12.14.1793939680539; Thu, 05 Nov 2026 20:34:40
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
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-12-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-12-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 20:34:28 -0800
X-Gm-Features: AclHuK8Cx6t65NL8zYNN-6JjRZdlWwlMy8grczsKPGO2ySINkfgIV4cdy6ZZwi0
Message-ID: <CALMp9eSqUV64WbzZ0xbAc42+nyBJLN7CQ-ark5j-4P8PNPwC5g@mail.gmail.com>
Subject: Re: [PATCH v8 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:38=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Prepare the emulator for REX2 handling by introducing the NoRex2 opcode
> flag and supporting extended register indices. For the latter, factor out
> common logic for calculating register IDs.
>
> REX2 does not support three-byte opcodes. Instead, the REX2.M bit selects
> between one- and two-byte opcode tables, which were previously
> distinguished by the 0x0F escape byte.
>
> Some legacy instructions in those tables never reference extended
> registers. When prefixed with REX, such instructions are treated as if
> the prefix were absent. In contrast, a REX2 prefix causes a #UD, which
> should be handled explicitly.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat=
.com
> ---

[ ... ]

> @@ -1119,9 +1130,9 @@ static int decode_modrm(struct x86_emulate_ctxt *ct=
xt,
>         int rc =3D X86EMUL_CONTINUE;
>         ulong modrm_ea =3D 0;
>
> -       ctxt->modrm_reg =3D (ctxt->rex_bits & REX_R ? 8 : 0);
> -       index_reg =3D (ctxt->rex_bits & REX_X ? 8 : 0);
> -       base_reg =3D (ctxt->rex_bits & REX_B ? 8 : 0);
> +       ctxt->modrm_reg =3D rex_get_rxb(ctxt->rex_bits, REX_R);
> +       index_reg       =3D rex_get_rxb(ctxt->rex_bits, REX_X);
> +       base_reg        =3D rex_get_rxb(ctxt->rex_bits, REX_B);

Per Section 3.1.2.1 ("REX2 Prefix") of the Intel APX Architecture
Specification (rev. 9.0):

  Note that the R, X and B register identifiers can also address
  non-GPR register types, such as vector registers, segment registers,
  control registers and debug registers. When any of them does, the
  highest-order bits REX2.R4, REX2.X4 or REX2.B4 are generally
  ignored, except when the register being addressed is a control or
  debug register. Furthermore, if ModRM.Reg addresses a segment
  register, both REX2.R4 and REX2.R3 are ignored. For example, using
  the REX2 prefix, the instruction "ADDPD xmm1, xmm2/m128" can use all
  32 GPRs as the base and/or index registers in its memory operand,
  but it still cannot access XMM16 to XMM31 because REX2.R4 and
  REX2.B4 are ignored when the R and B register identifiers address
  vector registers.

In __decode_register_operand(), unlike the Mmx case (which masks
"reg &=3D 7;"), the Avx | Sse cases do not mask reg to 15 before setting
op->addr.xmm and calling kvm_read_sse_reg(). If a guest executes a
REX2-prefixed SSE instruction in twobyte_table (e.g., MOVAPS with
REX2.M0=3D1 and REX2.R4=3D1 or REX2.B4=3D1) that traps into the emulator,
reg will be in the range 16..31, hitting the default BUG() in
_kvm_read_sse_reg() / _kvm_write_sse_reg() and crashing the host.

Similarly, em_mov_rm_sreg() and em_mov_sreg_rm() use ctxt->modrm_reg
directly without masking off REX.R / REX2.R3 and REX2.R4, so setting
R3=3D1 or R4=3D1 on opcode 0x8C or 0x8E will erroneously inject #UD.

[ ... ]

> @@ -4297,15 +4308,15 @@ static const struct opcode opcode_table[256] =3D =
{
>         II(ImplicitOps | Stack, em_popf, popf),
>         I(ImplicitOps, em_sahf), I(ImplicitOps, em_lahf),
>         /* 0xA0 - 0xA7 */
> -       I2bv(DstAcc | SrcMem | Mov | MemAbs, em_mov),
> -       I2bv(DstMem | SrcAcc | Mov | MemAbs | PageTable, em_mov),
> -       I2bv(SrcSI | DstDI | Mov | String | TwoMemOp, em_mov),
> -       I2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp, em_cmp_r),
> +       I2bv(DstAcc | SrcMem | Mov | MemAbs | NoRex2, em_mov),
> +       I2bv(DstMem | SrcAcc | Mov | MemAbs | PageTable | NoRex2, em_mov)=
,
> +       I2bv(SrcSI | DstDI | Mov | String | TwoMemOp | NoRex2, em_mov),
> +       I2bv(SrcSI | DstDI | String | NoWrite | TwoMemOp | NoRex2, em_cmp=
_r),

Per Section 3.1.2.1 and Section 3.1.3.3 ("64-Bit Absolute Direct Jump
(JMPABS)") of the Intel APX specification, opcode 0xA1 in legacy map 0 is
an exception to row 0xA* being reserved under REX2; REX2 (with M0=3D0 and
W=3D0) followed by 0xA1 encodes JMPABS. Marking 0xA1 with NoRex2 causes KVM
to raise a bogus #UD on a valid JMPABS instruction.

[ ... ]

> @@ -4385,12 +4396,12 @@ static const struct opcode twobyte_table[256] =3D=
 {
>         N, GP(ModRM | DstMem | SrcReg | Mov | Sse | Avx, &pfx_0f_2b),
>         N, N, N, N,
>         /* 0x30 - 0x3F */
> -       II(ImplicitOps | Priv, em_wrmsr, wrmsr),
> -       IIP(ImplicitOps, em_rdtsc, rdtsc, check_rdtsc),
> -       II(ImplicitOps | Priv, em_rdmsr, rdmsr),
> -       IIP(ImplicitOps, em_rdpmc, rdpmc, check_rdpmc),
> -       I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack, em_sysenter=
),
> -       I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack, em_s=
ysexit),
> +       II(ImplicitOps | Priv | NoRex2, em_wrmsr, wrmsr),
> +       IIP(ImplicitOps | NoRex2, em_rdtsc, rdtsc, check_rdtsc),
> +       II(ImplicitOps | Priv | NoRex2, em_rdmsr, rdmsr),
> +       IIP(ImplicitOps | NoRex2, em_rdpmc, rdpmc, check_rdpmc),
> +       I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack | NoRex2, em=
_sysenter),
> +       I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack | NoR=
ex2, em_sysexit),
>         N, N,
>         N, N, N, N, N, N, N, N,

Per Section 3.1.2.1 of the Intel APX specification, all opcodes in row 0x3*
of legacy map 1 trigger #UD when prefixed with REX2. Leaving 0x36..0x3F as
N (NotImpl) causes KVM to return EMULATION_FAILED to userspace instead of
raising #UD when they are prefixed with REX2.

[ ... ]

> @@ -5001,6 +5012,13 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>                 opcode =3D opcode_table[ctxt->b];
>         }
>
> +       /*
> +        * Instructions marked with NoRex2 ignore a legacy REX prefix, bu=
t #UD
> +        * should be raised when prefixed with REX2.
> +        */
> +       if (opcode.flags & NoRex2 && ctxt->rex_prefix =3D=3D REX2_PREFIX)
> +               opcode.flags =3D Undefined;

All other opcode attribute checks in x86_decode_insn() are performed on
ctxt->d after the "while (ctxt->d & GroupMask)" loop. Checking NoRex2
before group expansion means NoRex2 will be silently ignored if it is ever
placed on a group table entry. Should this check be moved right after the
GroupMask loop?
