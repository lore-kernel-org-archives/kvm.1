Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795042975;
	b=bbjdNAnhTMeovd/ltR1ugkVOLeI8xHmOvkF8vYX7eKFZvBg5lyCiADIxoqX7Ey3gQiLB
	 AWHEmsqWPjce4Lics0gSMMYT22m353jdf75PSPRi4TtSKoONK7aO2Js0xeAopl1S9y3mg
	 0K3PlhleGG2aISZwACRRWqJFiKB4PyZHXwYvSP2Gn6XHPAXi0pEA8LLT5G4xaPzwCvXDj
	 segmLbMT3bFtJjkqooXDUQe/N/JxRa/id1+/fCwPbfQHSXwuI0d5uFMJcWRUnH6q9q/YK
	 GUGg0jtnMXI9u6aA63YxLiARGdIuZ31k32rOJex8eo9BwDxFmypaB5Bl3sYl7h7ZN0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7FzA+ke/n3Erd5b/H6QPMWZ41fDmL1p0bOBQCwwbtzE=;
	b=bLcknIQo7b5dmk6/dYpROjziPgsi2nRbJl/lUSx9VD35qhQjoNZJsK7hAdKPPGSisZoU
	 hNAhYt8jUTbnSxA+1FNku6zYltLIlvlMlB7m00abZtjsShmdgZlXSBTPKSxvck+2wIfvS
	 uUJjQ8BwPBhcyYujixEtJ9KurFeckgv02dwHeAExgqybpXS3utgFPHLCkl+C/hN7cuUTZ
	 t+ayUHLls1cmV6Gg+tkzZ0pbUBDldGxXzqTlnzlwHyhOLa/MzBAldTZLCwzHcb2QwNM05
	 EHmw2Hft1Z+NByzjmTnGH9VK8+4UUwxk16cXkK+PQGDj2UsUzrMsTg/seLTxxbTKHQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CZqX2iQ2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B2606A320
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CZqX2iQ2
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso1861a12.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:02:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795042973; cv=none;
        d=google.com; s=arc-20260327;
        b=hsaCqxoaKNH0bANHBNN7VdPvAhwIT5p9nEkg7+Z6nN20n99927fVyXn3B3TVw7wnVE
         SO01Vtzc9ERwPa4RYwN+fzGNy+/I/sXEOZeRqMc3H45kgnoKENc9ciVxcpoXFXX2DkzL
         1JLRxjeDrlvr+Q8dsUF2CJXcdTy+St17kDTm3kyMIWf6U5Fad727VUY2Glgt8CdU+/3m
         /WMxqadcRS4/gAUt4Y8FQVuhVVu3n5zK3xGW/GJfPx+V69EjQaGDcmkcgGB0e5fVodtg
         MNkwlIoC4r6YeIBFvSrCWkLfsnmC8Q6fLZ6USYDcNIWbexkUQcpJa8sr4KhTpnpAdXnQ
         Btag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7FzA+ke/n3Erd5b/H6QPMWZ41fDmL1p0bOBQCwwbtzE=;
        fh=ozOPCrDPX3NLWdpq63E2+P4Jy0nXiJj5KiGyxhsPrzg=;
        b=LVVy8KdSQRV+Tu9lEWkPiO4IonwsMQAospxoK5/XMd/+bXre0HF8tGRikknAxwbeSV
         J0LiuOkaC8I0eSDVXBaPuo4sl76o92Je9n62yGUeYJffbdLa7PhwdPviw0Uqn1UV9lND
         Rg5Mfn+c10x9mA6UTTEGlFQq4vYhsxM5g/uQbiGV/YhlGnI+GSmk6HZKk1KvqTLNerql
         O85r4dXbLurYly+244e32JuLUf57vvqw6qKs+c6OL/vu+XpPFSYtxEWHgiaPx461TDiJ
         PaZQRPlvr3hlVrs454eEwtI7KcsNvxr0x4NSiI5NkefwBWEOXLUdUTonM/IinP/80Hiw
         UjFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795042973; x=1795647773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7FzA+ke/n3Erd5b/H6QPMWZ41fDmL1p0bOBQCwwbtzE=;
        b=CZqX2iQ2BM8t8zm5yp1v5G9j8TdEgxOQJ2N4wFNRg1XeVpiG0SeJoD1BX6uZYjfNrT
         MNROBsgw135xaJmowVch4HX29CQBwWdMl4Dv/AAXormG/NxOVHnbtGDgxBsH9gPDhg9d
         3b8d3DEyewYfesszv/oIgPc6KTUUDsUSQDuEAowEjaNsLdfaNdB1jOHCRXPgg7P7bLx9
         KmL7nEosQKTErhadG/08fkGT4eEHvLL1eWzpnIVm0tSIipbifPFgOj5cVRnliBD7vKlb
         On2/4Wq41lZMA9l0aT5S0u8CPcLkSMNeuMePuryJhou0JG6bLDGNcTLTO3ioEEFbPvbe
         rUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795042973; x=1795647773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7FzA+ke/n3Erd5b/H6QPMWZ41fDmL1p0bOBQCwwbtzE=;
        b=U+bEUNUaHl2v2mD/eNQ1A0L19fJvX82Bhx73up7Sabl525b2vPwjIl5fapWGjxc+zP
         BMLvRQtLeFEhD0FKL+nODZrbFQqsfH1Vq8fDUij7fjDFp8M7Dd7iULhsGq1n3unWoZ2z
         8ZO7StMhZ8ESBx7iifykHCrELoC8NpnXlXu9i1RnCf6Gv2LI6RcIPI04l815l+SdJvN+
         RVj/3M5MXN4ipnSBHbSzOgaMtfUjJWBobV6BZv3UVtPAG+lTX6vCX9T9mRMZzaThI3v5
         oafP2P7ZO8XWIMz7thCmt2ot83GHPODTxfXjs3Hn6da706TQfTi82Kr9wzQzkK7VXjjH
         NtMQ==
X-Forwarded-Encrypted: i=1; AL+hErGqQPODvydd3X+M588KU/v/iEl+oLx6UZ9KCANSErdOA5niw/AB28vzakRm1oGEVeBtoUI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R2/OvqIfI1Ya87hMo4kBQ8FPXWSp1byXUpQxjkt7OT6TycT0C
	o7LTm8nmDwBTpjSR7UvVcc4Xq9k/+GhlZGbWW5VGY/ZgnraBCfD8VJ7Cv3Lhv0tDDlx1GolWIyr
	YcQBuyYvgRg3WEmcpGuxAXt6egTLJzrzhi60Z200cz2XnX4CinH85aa2+eDY=
X-Gm-Gg: AYBFou3sO+aVzhxugHobYSFE8PZjd4EBg2GEFysTE99txCK9r+Bp/1H3MDIu6ctbKyI
	Sje3JhGsR+LM7MS6IilQBI2pksGomnNJBRG8SzuOXmqkRw1J/bVp/npZ4fQOOewu3ZuU9ih80aw
	KEsNqxIA+JSYHRY6nxmN9psuUen5ULMxHsLL5SGV97sOFc4IpOt/yNC4EATGyau1gQ9+6WuxTK1
	2+nyNxvVq0AY67DvLT5nfeIrLGidsot0QadEati2UZLpe5rc8KfrHYQzlYinfhDgOB/JPIm243l
	xgvhqkkJ/9WxeWCi03RfdsD3OSUCFkcxWjle4dfplQv/6+G06P+IILbSd5J2kDELtRFtWfbLInc
	oOGwbjnzkkPy5u89NjBrsz6iD9mgsXWqp0OzBJSkWiftHyf9qxQKXYmBh7p2St3iQtjDn6oWIWi
	mfyTWwfGQ7m3UXGYev82NoXp35mABP6NmpHMi97Kl3wwZJiM1e/74Qow==
X-Received: by 2002:a05:6402:789:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6ba10d4641dmr17515a12.12.1795042972709; Wed, 18 Nov 2026
 15:02:52 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-13-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-13-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Nov 2026 15:02:40 -0800
X-Gm-Features: AclHuK-LygAKr8qFmGx5XYSpKbdRaRYB2A8JlX05beTuE1ipf7fbbP2n4g6Zmys
Message-ID: <CALMp9eQBQnitBu0ybMz7uidz1KLvMUi6GChyrp=45Qw1j=1i=g@mail.gmail.com>
Subject: Re: [PATCH v9 12/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
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
> JMPABS (0xA1) is an exception: it is defined for REX2 but mark it as not
> implemented, since emulating non-memory operation isn't practically
> that useful here.
>
> Also, ignore the high-order register index bits when accessing vector
> registers (XMM and YMM).
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat=
.com
> ---
> V8 -> V9:
>  * Fix the vector register ID (Jim Mattson)
>  * Clarify that JMPABS is not implemented (Jim Mattson)
>  * Move the NoRex2 check below group flag handling (Jim Mattson)
> ---

[ ... ]

>  static void __decode_register_operand(struct x86_emulate_ctxt *ctxt,
>                                       struct operand *op, int reg)
>  {
>         if ((ctxt->d & Avx) && ctxt->op_bytes =3D=3D 32) {
> +               reg &=3D 0xf;

Thanks. That takes care of the BUG() in _kvm_read_sse_reg(). However,
you didn't respond to the other half of that comment on v8:

  Similarly, em_mov_rm_sreg() and em_mov_sreg_rm() use ctxt->modrm_reg
  directly without masking off REX.R / REX2.R3 and REX2.R4, so setting
  R3=3D1 or R4=3D1 on opcode 0x8C or 0x8E will erroneously inject #UD.

Per Section 3.1.2.1 ("REX2 Prefix") of the Intel APX Architecture
Specification (rev. 9.0):

  Furthermore, if ModRM.Reg addresses a segment register, both REX2.R4
  and REX2.R3 are ignored.
