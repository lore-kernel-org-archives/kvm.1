Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793974081;
	b=vmowNt+yuJsZnTMi+7JPqbPBhmXQGEoO+/Jz37W47DurOLOZNUJREXJJ3+ch3n23q5Xt
	 j4OVFyUxsDfduUQkK0kQXtg1IO/XalpDkpNS8MbQX9mFtv4E70jYpMqTFqQApIwmW8FVC
	 ACxMjJDnAgZE7tnyWQkhS51Xab53nj1/Lyooj7zwoHHg0IiN4ZusT2hzyXEGlEnXu+YIm
	 9DvTgCF91vl2o9g7zpn/1WE8qYtZSgFHAKl40JnA0bvZbPv/WsfZKF2T4fLLam4l0RxjT
	 aVV3GqoYxxKNlD6uVONolRtxm5a0iJJxZUiTj3RZDUKLzpY2kLdUzxSsQqIQhZgbJpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o0on77fT9cqdEenyVrlGJWJcAv5h/tUj6mGefibL4bI=;
	b=s1I1O7W8W5kFjxGcudiYvZR9/Xkn9UXixeTsnP22lxtZpNfrWRALvEG68D1JCe9N2bqN
	 0gy5qK+kLEqSnXo+FKk+EZxdZO11RrAWWcpjc3I2bp+LW5/HeLHK/OBz9RIQZez+Hrqnq
	 8I4vK3ntdyPiq1RjwmiRyh7pw8jUB26v+eMeackrpkkgRJlliEHPwPdad2+K8a8XR/UFn
	 8Rir8qWaFPBQzX9x2eL3jBzOkICdRGt9nVx8uRg59oq14z3dQX+bGgSshbLePPBXVDUGf
	 2sCcpGQ1VDHQg8t9vso/5M3a5nnpkEVcMrTo4LadAhB6HxUL5Kd+BAyIsXmG/zD1MWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aa6gxFGh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414B606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 14:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D414B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aa6gxFGh
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso7188a12.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 06:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974079; cv=none;
        d=google.com; s=arc-20260327;
        b=W6gsoMvhm9ZyZyey6CaAXxvV1L2SAhaW7qfaeVklPlNMNCMrL/8/SJOQbkNRA2txCk
         L1BfMhaCMrJm0d77JTqEc8vr8Js9VIdMzuXNskJeaICoQHnli6mx+MH1s/ceO8zbUBDG
         egbQy6XY/FtkE3egHMSIktmqPCQ6GALssclrswQ5HhwfeVK6S5UvE2od7GApUpArbWzl
         eSRvUm0H6kQQeSIg15gs9VJUkMeCe8/OSnLYkjXy023evBFuGxslzk6rQCsfnpuVPnVe
         aO+HpquW8QdF88/76xxTjL7QWdN0Z38eIx5x8jso6bP6ot8kZJPw7EgQCwjOal2hcd4U
         yxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o0on77fT9cqdEenyVrlGJWJcAv5h/tUj6mGefibL4bI=;
        fh=lkyjQ3kqUmJPc0GzyyHtnM+ykENCSNMcBwEs11vOPKs=;
        b=hTVU/LGDnoQqq+pe3OLKaSGWBQNhhqO6jw6Q5qsRA8m9M8ov0S+YoC1K4/e1N8z9UD
         BSz9SsGst0IcLEaph6RRO23JNwKR+IJOwHfxd+2i7kQSimzTy+2RCW7waUtUc+yJxl2Z
         GXdRYBbaB6zCdtiofY8me0Pi5XraSzfpEs3YpJfGAu/QVlgp294Np8d/dv0uTBuPmPIE
         4Eh3ooQdFIo7JlA5tT9lY/FWE6OOAAmQgCLjbr/XmPkMWDGh0xwDuekmMh//tvC8JBL+
         /FXeBEVBnH3J06Dm5vBiduu04P9vpyw53TaQCWzZ/ycBGiVtDjCxKxMTDw8pjJzFxmgp
         Jb6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793974079; x=1794578879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o0on77fT9cqdEenyVrlGJWJcAv5h/tUj6mGefibL4bI=;
        b=aa6gxFGhvb2UWZsRedcf7rghniRGHP5ZBpm+KRqG8m/EQ7v3jAyZ3NDAscezqBSJMk
         chiNJhv4sM6RGck9jFJAGVS9T/Sv5XJDDl8Ak5f0AezAMK3un9me+1kJbbnvQ89mYiQ7
         GuAtya0AhPxKnrzYFp8pXOT4V+NYPtKelypECKrJr9vbvj/ognpMgAvFENC9gG9Pbb1f
         WHrtYn6Ieysst3JN+hLf8o3bHGW5OWRYlgeb7BtrNbp9M0RtW97xopHySPxSR79syOEv
         1fbFhjKUlgR80KY2KADcDTnA9AsAgnQZ2z+7l2tP5CtvstGqSv82pmuCJTUniMreA1hD
         L5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793974079; x=1794578879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0on77fT9cqdEenyVrlGJWJcAv5h/tUj6mGefibL4bI=;
        b=1/su+m5b6zW08zijCQstiNXKhRy6shXbwTQUqPSYfKocIu6g2L61s7QT6RBUbQ9rAj
         krQRvhV8t4gr05JKP+sDUn0gDhLBV3I/GdAxt3OiUTSWqI5iv1f95B/vusL6/YdGTUEa
         ZCynUKq0nP+tbzOsgqFle2Yp29Y2K36seJy6wzKl14APrjeWDkqz8QNT4vbwIQc4cMoB
         ZJLQ7/oB9Qb9DteoS9M8V+uDkTxg7/l07RxUAxBHR7YA27hNnduUVhC1+CyCFOjYusTS
         gmsGDW4jRLqNSDvRfoXth3BEY8A9PPMPVvQOz6LLjpELhEjEOqCDwMIPzScDnH1QbG9Z
         t+rA==
X-Forwarded-Encrypted: i=1; AL+hErFjqPM/dd8sHKCWxLlcMZnYCwkAjJ3ZsLKmGfjEK2p9Hd25rz1NUgDo966CUkVTv+IsXXY=@vger.kernel.org
X-Gm-Message-State: APuU4Z95qYfvyWQIA19BNXV02PWchtl1KX92gjtfqNR5YTelfVJNsBoP
	dsuFpwdwZQXva1rDn0RYFu17BXwHsJaYSSipu2vqiUiyidcQJOECQ6smUJxEx7On5Zuc2WEVkiu
	EpVFWizn4S2baDsqjnP3OKNGnlLDHzvMGUYWX4IM6
X-Gm-Gg: AYBFou3LqfI6K6EDGxaKvY+lTemuVScj8BwdAHd3SX25f8jvJFLVML7T9ixK2Xat8qa
	PzkeectkrafcUGJ10hrqhLh8grlYxiiSTKlKYOFUxDQ3fmbCTIXUM+0WTeNrXBsZkZPZBmjiovp
	ziR45D97+oX53hRCiVqWpCTWkzfC4R4SLkw7gSo0ueDiN8YIYuvEaVZjiM3VPlOWqZTgh0xCpwp
	cT76gpD6w1gT+usLf8Z/2UJ8xwmjZfzL0j2g/wDmmIsHCIkvFILrMW0X1ppHnWSylP5GMJa+y1h
	MIKmEBGKC33CaEK1SKzByPgwF3uLEKowqhjlPZdEDz1scAy8cxJcge/ImOJR1HDwqvIxz1CKFC7
	IJGQELfGlwpegOniCneN70p+ptZViH2lkVm1N+c5k9HOwPApIHz5P5J+UeLukDzw/5Dn+cAVq
X-Received: by 2002:a05:6402:7d7:b0:6b6:eccd:ce77 with SMTP id
 4fb4d7f45d1cf-6b6ecdd19f9mr22514a12.9.1793974078570; Fri, 06 Nov 2026
 06:07:58 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-13-chang.seok.bae@intel.com> <CALMp9eS_NHtj--citTS_PhrSSfUG=nfLNLDcDFBX9rhY2CqF=A@mail.gmail.com>
In-Reply-To: <CALMp9eS_NHtj--citTS_PhrSSfUG=nfLNLDcDFBX9rhY2CqF=A@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 6 Nov 2026 06:07:46 -0800
X-Gm-Features: AclHuK_pQnHXIrAahfsAJ_BwTSTy_UF_hV02UanDHo6mauvJGquBLULaAFPOnyg
Message-ID: <CALMp9eSZ7V=rOByRveQqCgAgnj_AwRKFa19X4_+4xRJh88H4sQ@mail.gmail.com>
Subject: Re: [PATCH v8 12/20] KVM: x86: Support REX2-prefixed opcode decode
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:48=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Wed, Sep 30, 2026 at 3:32=E2=80=AFPM Chang S. Bae <chang.seok.bae@inte=
l.com> wrote:
> >
> > Extend the instruction decoder to recognize and handle the REX2 prefix,
> > including validation of prefix sequences and correct opcode table
> > selection.
> >
> > REX2 is a terminal prefix: once 0xD5 is encountered, the following byte
> > is the opcode. When REX.M=3D0, most prefix bytes are invalid after REX2=
,
> > including REX, VEX, EVEX, and another REX2. Also, REX2-prefixed
> > instructions are only valid in 64-bit mode.
> >
> > All of the invalid prefix combinations after REX2 coincide with opcodes
> > that are architecturally invalid in 64-bit mode. Thus, marking such
> > opcodes with No64 in opcode_table[] naturally disallows those illegal
> > prefix sequences.
>
> This is only true for 0x40..0x4F, 0xC4, 0xC5, and 0xD5.

"This" being a No64 entry in opcode_table[]. However, N (NotImpl)
certainly subsumes No64.

> Per Section 3.1.2.1 ("REX2 Prefix") of the Intel APX Architecture
> Specification (rev. 9.0):
>
>   Furthermore, since the byte following a REX2 prefix is always
>   interpreted as the main opcode byte, any legacy prefix byte (namely,
>   0x66, 0x67, 0xF0, 0xF2, 0xF3, and segment overrides), a REX prefix
>   byte (0x4*), a VEX prefix byte (0xC4 or 0xC5), an EVEX prefix byte
>   (0x62), or another REX2 prefix byte (0xD5) following a REX2 prefix
>   with REX2.M0 =3D 0 must #UD, because none of those bytes is the opcode
>   of a valid instruction in legacy map 0 in 64-bit mode.
>
> and:
>
>   The 0x0F escape byte is neither needed nor allowed. (That is, the
>   REX2 prefix followed by 0x0F triggers #UD.)
>
> In opcode_table[], 0x0F, 0x26, 0x2E, 0x36, 0x3E, 0x62, 0x64, 0x65, 0x66,
> 0x67, 0xF0, 0xF2, and 0xF3 are all N (NotImpl), not No64. When any of the=
se
> bytes follows REX2 with M0=3D0, KVM will return EMULATION_FAILED to users=
pace
> instead of raising #UD.

As in 11/20, this is utter nonsense. On EMULATION_FAILED,
x86_emulate_instruction() will raise #UD, as it always has for N
(NotImpl), with or without REX2.

> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Tested-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> > Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNch=
LZuKFU+MMA@mail.gmail.com
> > ---
>
> [ ... ]
>
> > @@ -4958,6 +4969,17 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctx=
t, void *insn, int insn_len, int
> >                         ctxt->rex_prefix =3D REX_PREFIX;
> >                         ctxt->rex_bits   =3D ctxt->b & 0xf;
> >                         continue;
> > +               case 0xd5: /* REX2 */
> > +                       if (mode !=3D X86EMUL_MODE_PROT64)
> > +                               goto done_prefixes;
> > +                       if (rex2_invalid(ctxt)) {
> > +                               opcode =3D ud;
> > +                               goto done_modrm;
> > +                       }
>
> "ud" is defined as I(SrcNone, emulate_ud), and SrcNone is 0. Jumping to
> done_modrm with opcode.flags =3D=3D 0 sets ctxt->d =3D 0, which then hits=
:
>
>         /* Unrecognised? */
>         if (ctxt->d =3D=3D 0)
>                 return EMULATION_FAILED;
>
> before ctxt->execute is ever set. As a result, rex2_invalid() always
> returns EMULATION_FAILED instead of injecting #UD.

Once again, on EMULATION_FAILED,  x86_emulate_instruction() will raise #UD.

That leaves only this question on this patch...

> Also, because any legacy prefix after a REX prefix resets ctxt->rex_prefi=
x
> to REX_NONE at the bottom of the prefix loop, a sequence such as 0x48 0x6=
6
> 0xD5 will not be caught by rex2_invalid().  Table 3.1 ("Legacy Prefix
> Applicability with REX2") lists 0x4* (REX) under "Prefix before REX2" as
> "Illegal", whereas the accompanying text says, "A REX prefix (0x4*)
> immediately preceding the REX2 prefix is not allowed and triggers #UD."
> Does hardware raise #UD on 0x48 0x66 0xD5, or does the intervening legacy
> prefix nullify the REX prefix as in legacy encodings?

The text clearly permits 0x48 0x66 0xD5, since the REX prefix doesn't
*immediately* precede the REX2 prefix. The table is unclear.
