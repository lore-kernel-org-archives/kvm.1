Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDD33EB06
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756489; cv=pass; b=AW/qaemfSZAtXQ1/jY2TAndImbi8JVpW5BQWyj+ql02skZeDvi6CvGV+2ftcHR1gcQVwWImyzCBwAABxhVCf8knKIY7jUT193H+TaNopQ4TIwVVuXdU1WBOTIMSbsKkiQZ+Erq+hjTEQoFQGMmOj/Kp6+iFAd/Q1MT/T5MuJ+9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756489; c=relaxed/simple;
	bh=avOnL3A8aTp+SytE+H4A/lkLT0DTp3jf42S0BlB4Sjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iw093dav8XehmHXxowbxjhqLMVxUTKRh0WN/ImbHZDCy0JZNntjii4JNc4HHQWCon/L822v56NdEoRlC69q94d9DZ054s15zW7MHEabhMM/VBNH+Zzf8jgyRS0VTEHZP/PZDp7X8H7BmQ6RwAS0pEl8k4BH3boSQvpYoH71Ewww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0WwiVgv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBLTUe1Y; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0WwiVgv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBLTUe1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782756486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THLii+AuvMtyVQW0et/j6izh4HdLW1xzxGPITOaWX44=;
	b=G0WwiVgvRU+amRbvdG63RJcTMmT4dcbcA0ajyaESeXaYoBD2ZwIr/Tc4tCtOOdFcAcFzRo
	wYsMPzP1qxVliqJF52V2o038SDPM4ZiuH25Fwpw0+cBuintDFXMy2MrI5cvJZzHLM5fUw1
	IPV9eOYeSOuztIcz3P9/p88dmDu29vY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-n1jaJ-FnMQ-X48BoKSsQbQ-1; Mon, 29 Jun 2026 14:08:04 -0400
X-MC-Unique: n1jaJ-FnMQ-X48BoKSsQbQ-1
X-Mimecast-MFC-AGG-ID: n1jaJ-FnMQ-X48BoKSsQbQ_1782756484
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493b0a5e636so10129245e9.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782756483; cv=none;
        d=google.com; s=arc-20260327;
        b=F2I0HqV0xgd45N1hSGKELryDMWrW7+tnUgotvYr/jXO62Cw8vhB7+3HD/RmR0qPtsh
         m+glE0kLx3DyB4gHadmKfUoBghpf5oY8n7BwvGx+lJ1184EvUo1NJT8/ZJ2h5lI1Xu9G
         x2SZvqEAQzv8Tqzhy/FaVSc2MTKdUs64wwLb8L6b9LqiOCIGIknE8YKOsbRlvNO0X5lI
         t99XiBPWRgH8uG+mML1JuhNNfUUQDrL6dpg4dShYThfAeS4y6gPKIVipx3lf3KmXj3pz
         Lj9+L4BHl7iuLNFQ3DNvFQOwerdvgWESkh/vLULKWWZhmDMWFIPd/tTMBEemylhzcqHL
         yEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THLii+AuvMtyVQW0et/j6izh4HdLW1xzxGPITOaWX44=;
        fh=TYdZ/2wiZyEfNHYnY2l1MvlyLmy/tv7MNvM3TPhuMzM=;
        b=O/QZBR1JWWSyajTSZ1GN/pgRYYtAm6mvs2bBKmVKzJ0TWG6MJNE24IHrJi3Imecpf7
         MQvQgvM6pRjOELx5hsu4S4x1O5S/Sg2Qm0R/0RTXVhf1GJMgK0sAz0xP2uDtKPj5G4JL
         MngWdPczHUDx7JMxXIxAm8B7mqlGyzHLqyDIcOxUS7DlgGFEC17lzn595xZ+TOkkLIQf
         oxfa3AfFhmaUmD6N554vYk2l7utzZB4bAqbPFgh6rfEdp+owYvtYnmg3FDmqkwJQIM1P
         JxZG6sJysthH0MMveSeOFCVNqt/7qjpmDlmibG0To8pl4foPhLIDCCZR24DlBoOm4zFm
         o1Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782756483; x=1783361283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THLii+AuvMtyVQW0et/j6izh4HdLW1xzxGPITOaWX44=;
        b=NBLTUe1Yhowxzu/44WWPCSVA5sJ+PxVNP3CB4mImvhKrSjHnNhU3A6eg+ej+3MO3JU
         ikBMsvEH4agOn3wyihq0i0QYO5vRdjfabjYAIYrlJ2P5ZXgZLMpdXD1ykPTAOqzMsJUB
         ELr8nXLiNXqyZnrtTAHKrtkpBbRcAHvwflQoWxtjdN7b9+BorITgbKcp+8a9dOr0ogBC
         c1IcYyQgxAPvvb4zQCasw0lnYPy26PgEkXn0p7dp0F/6W+O/JDIHPy7VQhNIuRUo1r1D
         nAPeyH7/OMtN6wJ0w3+u+Avt3Ea3ASzvOupp5+MLv2batp4GQuhK8+2VZmJ5kZvH+//x
         8iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756483; x=1783361283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THLii+AuvMtyVQW0et/j6izh4HdLW1xzxGPITOaWX44=;
        b=naCVKRhIFbesjY4WBGl1Ip0jwTPezHghEdaNcoZReNIup0mzQnyvycvmdQKiMXlwnh
         +F7onGa2Hi9idiwjYwdrHclMg21NLG2OAbDSDZ94/vr9wcB/ivi5XV/KF+Nb5tFLqe0K
         po4Fm5A0p3YWB/7dA3qygno7a5FlKfUV1IGFThpERWPDTtD6HmgfEwu+gUdTATMEO5qE
         ty7UKxCXewxPTX6YHeLB1+OJfXLEcGGeKszWc/SLFh9d6eh4CrHw0Q6k9qwuPvnyGrm9
         kamlDaTvts82HrJMyG5qQgvG3gJejbv7RzFkFP5CticlP15ecXwB2E0Xm/wZzQyH/IZe
         v1MA==
X-Forwarded-Encrypted: i=1; AFNElJ9g/2pY23Dn49kwlnAMyDlxRVl6JCiGOxRhxwnK+lHq6V4+I03oQqCOeLeMvkoepWw7bFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EMQyt+eaxrkyeD7U6T7LrUDcIYg9EU+fSviJBv8yF/Arv1n9
	Z8Wbacao4fwU04rWbwmJaulmNmFwEXvyr6YmArxCjVXWRRc0gx9X4m5HWsqafPbkQRTUY1d77LF
	ZYhWvgX+9oiedhRQwZO+wBA3LQdn2/R4xXlyDU2WdxWZFnckdS2uY0lcT6h5B+1RiGoToS8TR5F
	HxEj/Mnsk3BriV6eqcG/5YpLCMQwfN
X-Gm-Gg: AfdE7ckWtq/AQm/LHSUNaAKP0WLZAH0iBwTXFBPAGzhEy7t1E5JJqxnTRoZ+bKrWtBC
	ljWUoPtL7ryeUMKRVyFnOe8gNGnCcAvdQvTrc6UwFwow1+il5EwcoTLDIjJnKrHGKMHkfuAjQsE
	pwmcx67qgD+dfMPOYDwqbU+2obecuF38WkKkLuWaiAYBOrZLi3Qf7O2ie99nxFo8i0Ygu/XmXtB
	J6JQKhUm/5in8vvYTIx5qtVWwCk
X-Received: by 2002:a05:600c:4712:b0:492:523f:a3df with SMTP id 5b1f17b1804b1-493b827fa6dmr11407695e9.5.1782756483468;
        Mon, 29 Jun 2026 11:08:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:492:523f:a3df with SMTP id
 5b1f17b1804b1-493b827fa6dmr11407205e9.5.1782756483021; Mon, 29 Jun 2026
 11:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com> <20260621-riscv_insn_table-v2-2-7f0810ee2274@gmail.com>
In-Reply-To: <20260621-riscv_insn_table-v2-2-7f0810ee2274@gmail.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 29 Jun 2026 14:07:51 -0400
X-Gm-Features: AVVi8CdEQG7Qxlxta4-nm3blkK4c7RnQNE8PBBgxHxyXyoKpWdAVunc0FesI1v8
Message-ID: <CADRr4bc4HC-z9MjuD4CFWCSsdPqJ+=M++J_kCHfztx=rdUXYFA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] riscv: alternatives: Use generated instruction
 headers for patching code
To: thecharlesjenkins@gmail.com
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Nam Cao <namcao@linutronix.de>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 12:02=E2=80=AFAM Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> wrote:
>
> From: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> Migrate the alternatives patching code to use the generated instruction
> headers instead of the hand-written instruction composition functions.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Reviewed-by: Jesse Taube <jtaubepe@redhat.vom>
> ---
>
> These function expansions are very simple and almost expand to the same
> thing in the new and old version. The main difference is
> riscv_insn_auipc_extract_imm() in the new version expands to:
>
> ((_insn >> 12 & GENMASK(19, 0)) << 12)
>
> while it expands to the following in the old version:
>
> ((_insn >> 0) & GENMASK(31, 12))
>
> These are the same thing, but GCC is unable to properly optimize the
> second one so the first one ends up using almost half as many
> instructions. With this finding and other similar examples, I made
> the generated headers construct in the first way to help GCC optimize
> all of these functions.
>
> Brute force can also be checked with this code:
>
> void check_auipc_jalr() {
>         for (unsigned int auipc =3D 0; auipc < ((1ULL << 12) - 1); auipc+=
+) {
>                 for (unsigned int jalr =3D 0; jalr < ((1ULL << 20) - 1); =
jalr++) {
>                         unsigned int auipc_t=3Driscv_insn_auipc(auipc, 0)=
, jalr_t=3Driscv_insn_jalr(jalr, 0, 0), auipc_t2=3Driscv_insn_auipc(auipc, =
0), jalr_t2=3Driscv_insn_jalr(jalr, 0, 0);
>                         riscv_alternative_fix_auipc_jalr(&auipc_t, &jalr_=
t, 0);
>                         riscv_alternative_fix_auipc_jalr2(&auipc_t2, &jal=
r_t2, 0);
>
>                         if (auipc_t !=3D auipc_t2) {
>                                 printf("auipcs don't match %u, %u: %u !=
=3D %u\n", auipc, jalr, auipc_t, auipc_t2);
>                                 return;
>                         }
>
>                         if (jalr_t !=3D jalr_t2) {
>                                 printf("jalrs don't match %u: %u !=3D %u\=
n", i, jalr_t, jalr_t2);
>                         }
>                 }
>         }
> }
> ---
>  arch/riscv/include/asm/insn.h   | 74 -----------------------------------=
------
>  arch/riscv/kernel/alternative.c | 23 +++++++++----
>  2 files changed, 17 insertions(+), 80 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.=
h
> index d562b2b40ba1..d0e137f9bcd7 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -514,78 +514,4 @@ static __always_inline bool riscv_insn_is_branch(u32=
 code)
>
>  #define RVV_EXTRACT_VL_VS_WIDTH(x) RVFDQ_EXTRACT_FL_FS_WIDTH(x)
>
> -/*
> - * Get the immediate from a J-type instruction.
> - *
> - * @insn: instruction to process
> - * Return: immediate
> - */
> -static inline s32 riscv_insn_extract_jtype_imm(u32 insn)
> -{
> -       return RV_EXTRACT_JTYPE_IMM(insn);
> -}
> -
> -/*
> - * Update a J-type instruction with an immediate value.
> - *
> - * @insn: pointer to the jtype instruction
> - * @imm: the immediate to insert into the instruction
> - */
> -static inline void riscv_insn_insert_jtype_imm(u32 *insn, s32 imm)
> -{
> -       /* drop the old IMMs, all jal IMM bits sit at 31:12 */
> -       *insn &=3D ~GENMASK(31, 12);
> -       *insn |=3D (RV_X_MASK(imm, RV_J_IMM_10_1_OFF, RV_J_IMM_10_1_MASK)=
 << RV_J_IMM_10_1_OPOFF) |
> -                (RV_X_MASK(imm, RV_J_IMM_11_OFF, RV_J_IMM_11_MASK) << RV=
_J_IMM_11_OPOFF) |
> -                (RV_X_MASK(imm, RV_J_IMM_19_12_OFF, RV_J_IMM_19_12_MASK)=
 << RV_J_IMM_19_12_OPOFF) |
> -                (RV_X_MASK(imm, RV_J_IMM_SIGN_OFF, 1) << RV_J_IMM_SIGN_O=
POFF);
> -}
> -
> -/*
> - * Put together one immediate from a U-type and I-type instruction pair.
> - *
> - * The U-type contains an upper immediate, meaning bits[31:12] with [11:=
0]
> - * being zero, while the I-type contains a 12bit immediate.
> - * Combined these can encode larger 32bit values and are used for exampl=
e
> - * in auipc + jalr pairs to allow larger jumps.
> - *
> - * @utype_insn: instruction containing the upper immediate
> - * @itype_insn: instruction
> - * Return: combined immediate
> - */
> -static inline s32 riscv_insn_extract_utype_itype_imm(u32 utype_insn, u32=
 itype_insn)
> -{
> -       s32 imm;
> -
> -       imm =3D RV_EXTRACT_UTYPE_IMM(utype_insn);
> -       imm +=3D RV_EXTRACT_ITYPE_IMM(itype_insn);
> -
> -       return imm;
> -}
> -
> -/*
> - * Update a set of two instructions (U-type + I-type) with an immediate =
value.
> - *
> - * Used for example in auipc+jalrs pairs the U-type instructions contain=
s
> - * a 20bit upper immediate representing bits[31:12], while the I-type
> - * instruction contains a 12bit immediate representing bits[11:0].
> - *
> - * This also takes into account that both separate immediates are
> - * considered as signed values, so if the I-type immediate becomes
> - * negative (BIT(11) set) the U-type part gets adjusted.
> - *
> - * @utype_insn: pointer to the utype instruction of the pair
> - * @itype_insn: pointer to the itype instruction of the pair
> - * @imm: the immediate to insert into the two instructions
> - */
> -static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u3=
2 *itype_insn, s32 imm)
> -{
> -       /* drop possible old IMM values */
> -       *utype_insn &=3D ~(RV_U_IMM_31_12_MASK);
> -       *itype_insn &=3D ~(RV_I_IMM_11_0_MASK << RV_I_IMM_11_0_OPOFF);
> -
> -       /* add the adapted IMMs */
> -       *utype_insn |=3D (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) <=
< 1);
> -       *itype_insn |=3D ((imm & RV_I_IMM_11_0_MASK) << RV_I_IMM_11_0_OPO=
FF);
> -}
>  #endif /* _ASM_RISCV_INSN_H */
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index 7642704c7f18..b26a90eb65cc 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -11,6 +11,7 @@
>  #include <linux/cpu.h>
>  #include <linux/uaccess.h>
>  #include <asm/alternative.h>
> +#include <asm/insn.h>
>  #include <asm/module.h>
>  #include <asm/sections.h>
>  #include <asm/vdso.h>
> @@ -78,14 +79,24 @@ static void riscv_alternative_fix_auipc_jalr(void *pt=
r, u32 auipc_insn,
>                                              u32 jalr_insn, int patch_off=
set)
>  {
>         u32 call[2] =3D { auipc_insn, jalr_insn };
> +       u32 auipc_imm;
>         s32 imm;
>
>         /* get and adjust new target address */
> -       imm =3D riscv_insn_extract_utype_itype_imm(auipc_insn, jalr_insn)=
;
> +       imm =3D riscv_insn_auipc_extract_imm(auipc_insn) + riscv_insn_jal=
r_extract_imm(jalr_insn);
>         imm -=3D patch_offset;
>
> +       /*
> +        * When the 32-bit immediate is split across auipc and jalr, the
> +        * constructed immediates need to be treated as individually sign
> +        * extended numbers. Add the sign bit of the lower 12 bits to the=
 upper
> +        * 20 bits to undo the bleeding of the sign.
> +        */
> +       auipc_imm =3D imm + (BIT(11) << 1);
> +
>         /* update instructions */
> -       riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
> +       riscv_insn_auipc_insert_imm(&call[0], auipc_imm);
> +       riscv_insn_jalr_insert_imm(&call[1], imm);
>
>         /* patch the call place again */
>         patch_text_nosync(ptr, call, sizeof(u32) * 2);
> @@ -96,11 +107,11 @@ static void riscv_alternative_fix_jal(void *ptr, u32=
 jal_insn, int patch_offset)
>         s32 imm;
>
>         /* get and adjust new target address */
> -       imm =3D riscv_insn_extract_jtype_imm(jal_insn);
> +       imm =3D riscv_insn_jal_extract_imm(jal_insn);
>         imm -=3D patch_offset;
>
>         /* update instruction */
> -       riscv_insn_insert_jtype_imm(&jal_insn, imm);
> +       riscv_insn_jal_insert_imm(&jal_insn, imm);
>
>         /* patch the call place again */
>         patch_text_nosync(ptr, &jal_insn, sizeof(u32));
> @@ -127,7 +138,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, uns=
igned int len,
>                                 continue;
>
>                         /* if instruction pair is a call, it will use the=
 ra register */
> -                       if (RV_EXTRACT_RD_REG(insn) !=3D 1)
> +                       if (riscv_insn_jalr_extract_xd(insn) !=3D 1)
>                                 continue;
>
>                         riscv_alternative_fix_auipc_jalr(alt_ptr + i * si=
zeof(u32),
> @@ -136,7 +147,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, uns=
igned int len,
>                 }
>
>                 if (riscv_insn_is_jal(insn)) {
> -                       s32 imm =3D riscv_insn_extract_jtype_imm(insn);
> +                       s32 imm =3D riscv_insn_jal_extract_imm(insn);
>
>                         /* Don't modify jumps inside the alternative bloc=
k */
>                         if ((alt_ptr + i * sizeof(u32) + imm) >=3D alt_pt=
r &&
>
> --
> 2.54.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>

