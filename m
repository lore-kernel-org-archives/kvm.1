Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941023;
	b=IxCyQ71mKakC8OXDCxYZwM/2AsApqOOSPoRY6JGhufPZxVUfV9IJmptqf/dBaIJ/G7hk
	 RhxeIhM0RRwkyReVBp2N0S1g6WwTJg8oeOdJTCc+fyrKAPfNnxznXzpE62HFJKnJdvRbT
	 XLRtlyE8VN+h4nMSJWz6dLVaLBGHglqzimbg/JOwIBTLriv43aCkX/jI0wOgOEB3UB4fH
	 x2YNqeSscByRM76vx5nVPleSfy5QgXpY+//inqL86/YchhQLIgSYoBrZAkxYB4xtbvMAX
	 pdpdyCM1GgKW5QP4fAUuZ3chkNzYRwyl4mWmSUpd7JBjsPeBk8+st69gchEN9uZxQvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LomjFSiSVvN/UtH8tNxbJ7r2A7Q81k7fo1fXMCC44u8=;
	b=xBKaSRvrjW897Hnl8f/K7iwMFL/rQMdlsIf3kMFegA4r0C4uzZIagyvAQWb/JEQbBKTl
	 FP+a8pSPZv3GC+4TOf/FS3WPWJXXZSURMqADHODGWcSscPEnLqsCyo9DldxLXkpBF8/Bo
	 oxLKra0tuJZTfdoMJ2Rb+/1cu4PgqAUUFvSlJcq3NF1or561M1F+dmfvR8sjONHHedo+m
	 FkQYkHNQkiaD9iXSotwYcvvguMUtvo8PZeACUDD0J0M9rT/edovpZn3oxX6doMNO+qXZ1
	 vt71DT2Kurp4EKJMGG7vzatLiiy3gv1ESu8SH/YR2JT3YrOL5RfB6Xeem1Fj59yGCyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gSIefBqe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406B606D826
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 04:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0406B606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gSIefBqe
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5383c97c8cfso26961cf.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 20:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941022; cv=none;
        d=google.com; s=arc-20260327;
        b=AqlX0eOMm+ouSTbjDnYog6QM2yKDnqrC9ksTd+zo/OwVmDg3KZzNo2zntYZ2UbBCxp
         kFmCNt1/RSrQ3fjtdmeT0gaOigTq3sGaNkP7HzqnMKPobdB3eL0rKfUOk7NJ6/Qp77Z+
         caervxAg7xaDP72QLaXemESlLzGxMhZREXKWnUT0LS4k3NkMKIpwbnCl/cpA5FMxPuy8
         lCzegW3j4gA/Jiy0ikdCPTZ5RNwNf8XxAOU+7x5cIKEA51//fOQaaXQNaIuQC2CD3yEm
         OMq9HY12G/2SbaYWNOVJfZRy5ejTcxn/r9MbrNmnQtMX9OXJPLUL+FnAahtc+FEUOrNl
         vRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LomjFSiSVvN/UtH8tNxbJ7r2A7Q81k7fo1fXMCC44u8=;
        fh=PaRZFTn0EuvEaKfhnK7P3txRvjrY2JwePLsci0d2+WU=;
        b=bR++KYu6RwNadvZfUOOjw1lkAyt6cqDQ5jA5HvG6xOpUD93e9XhSaBVYtTSQC4Mtm2
         J/QMmNfPDRyPs4Q5xq9dc2asOVTijiBzWQXgYkOGWLJLWoPBlMSCP82OOJ1xsQgA1l5+
         RUFHVmzVqERcdyenrYldMgo3VD4zw7PFHyRoE3qeEyfvNuymh2N/qk5xvm5YJhZtgs4R
         9mGjxOeTUjT279UY9E7Y4DfmAB/BUj22/AyzUEhBC3kAGXAlrvICkioKcyVYHz50xEMK
         fIWeeeEczvnXJxVTovRj3FR7wTFCyaO5dSs/rDRxrSpPGvEjH3TMEzQ8HRe/omT3fyNv
         g1qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793941022; x=1794545822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LomjFSiSVvN/UtH8tNxbJ7r2A7Q81k7fo1fXMCC44u8=;
        b=gSIefBqe2gfWUrZf6ihmlA/of+IkmB8awyasX4q7Odlmowd0PkwDvd0tzydT+faE9g
         Rh/JfNHDiYXdqBlEGpf51OPB/Nds0OS12FklAsgLGYBvClKr7/rkKANIemYbtZ9UylBA
         wtKJxXDb8p+er7M/VFB1a3iXwaa23rbJiDh7QyEeHEX/+66EOGRBIHpGw3NLmJi66aqC
         3Km9iZi7r1YY9TAvfhnIBfonCpAAViagLMvOmft6TZgZM1th4f2z6xnR0Pn45/nbCl+6
         CxHiUiTeA+zDPaKBdPf2rvrz81sorKgrehdH4s9Rz8WD/rWb1/BzHpahybNifqiBt05q
         lZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941022; x=1794545822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LomjFSiSVvN/UtH8tNxbJ7r2A7Q81k7fo1fXMCC44u8=;
        b=C8krVpjWB7mi/6ZGTCjYlnZPJBswpB1X4HBDljfB2Bd7YmTTeiq/ClgDnEdhS5kKYn
         FAlB1vUoIRW4VIUi0C5Pq44n/Y5YyYNeP8Ir2+PkmmFqPyYcKKRpMw5HD579Iybpfb5z
         YlT0rv/bnoeq+2rIFcVLzxDIgtX9P5qvc51Lq8qm7rXROuBf7oDHYdwumSqs6qIF/Ntr
         KScaResuM8IzbkKd2LEKqiSV/MlkqTx0ZjOPf9tAVFI8+IHeAwDsoYVpZswY7KsNhB2D
         rOFD3cB7DULidxkVBToLydKIw+/OuxogEDM+8D6xAszCQNlLg1AV4KcqOwFmL+V4kxQR
         Vfow==
X-Forwarded-Encrypted: i=1; AKwUvBwFmmKfV/LuQwq4BCoiXdM+C60zODejK0UnLZIpKGWljIyHr5soNbSOMNsQrEBR1GHFDJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TsrPoRMsY6YFSGy3ctrEcw/MYXRoQieaAVHIzQD97z7VBGWcZ
	D9PgiLjxP8ajsL3pNHA7ZiBndZn/8TBu3nj2pSK0VahrmklIimb3AG2GFT5KGAEOx/Xi1lwe5PI
	GZU8xo6XXJ/EEhEZwGuGyqhnfDCfK5uBEM/lgcMev
X-Gm-Gg: AYBFou1itgJZN3K/MbkHBqphqyBnqka2kkftWMwNlt+ub9RDev7rHBd8lcpnuxFF+HA
	UkQ0BPvW1qzbQnBAZL0ZABSR6bYdZcXh+CSPLBm+8TL7ZCkafE5EXDaeUKuXuz71fx2Ou28G5LG
	zueej1KITMLgYTuenzlX+If7OEyetx1mRPaKNCU2xHHjfOXpj0xGqc+U8lUvBYAmJwYhTkNK+E/
	qjIp2Mt3RZFKBFAW+sBI+YWxacNYSl3iAtn52oPM4Ph9FTq7qEpEjHtK/nqYl+3/Ffcpopd6Gv9
	u3m+XPW0g7WYFDGEy/0Cyo9b+Lyu1dB6WiSTCoE2wd8rkoHPH6Xqw4V5Asq6oqEYQ8BmPAcbnVo
	cKE66rAtXrad4rZ7PeZyhfbET4IVQRAnJ0nlYpX1WzYn6YEk+VRKhD3Q/YZTwLo3WHQOAwihGAV
	RP9hnL6APAOHANUriVK3LLUK/Vwa93P/yJm3hhXzx2jTtVEw==
X-Received: by 2002:a05:622a:2309:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-54eb6d71d04mr557811cf.10.1793941021395; Thu, 05 Nov 2026
 20:57:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-14-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-14-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 20:56:48 -0800
X-Gm-Features: AclHuK8Ob5_RPYQZbgWleNRVHmNswKeBEiU-wRDX7dJ4XstMk2ACaiKWzzmO9Vk
Message-ID: <CALMp9eQVheLs1S=OMGmtnx+G0fX1-nwwP54oLcEeHKUh3_tRpA@mail.gmail.com>
Subject: Re: [PATCH v8 13/20] KVM: x86: Reject EVEX-prefixed instructions
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:54=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Explicitly mark EVEX-prefixed opcodes (0x62) as unsupported.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
>  arch/x86/kvm/emulate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index eba4e9b7cd5c..f0d5a40eba27 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5052,6 +5052,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>         if (opcode.flags & ModRM)
>                 ctxt->modrm =3D insn_fetch(u8, ctxt);
>
> +       /* EVEX-prefixed instructions are not implemented */
> +       if (ctxt->opcode_len =3D=3D 1 && ctxt->b =3D=3D 0x62 &&
> +           (mode =3D=3D X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) =3D=
=3D 0xc0))
> +               opcode.flags =3D NotImpl;

What is this patch actually doing? opcode_table[0x62] is already N
(NotImpl). Moreover, because opcode_table[0x62] does not have the ModRM
flag and init_decode_cache() does not clear ctxt->modrm, "(ctxt->modrm &
0xc0) =3D=3D 0xc0" in non-64-bit mode inspects a stale ctxt->modrm from
whatever instruction was emulated previously.

If the intent is to mark opcode_table[0x62] with No64 (or NoRex2) so
that REX2 (with M0=3D0) followed by 0x62 raises #UD, then:
1. opcode_table[0x62] actually needs that flag, and
2. this EVEX check must be gated on ctxt->rex_prefix !=3D REX2_PREFIX,
   or else it will clobber opcode.flags with NotImpl on "D5 00 62" and
   return EMULATION_FAILED instead of injecting #UD.
