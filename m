Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793973219;
	b=bxHl9o6s6aqgK/AKmjTy31E2KBKt7bOr11HvJWXVphAM7jQcU+TbSWHCxheBv8+dTKQa
	 vfkM/G5gR7dAnSsk/g3oqW10Lur2LUgB71JQcqx0uTUx32wvKbVlYMBHpxPcE+KwappSR
	 cte8WKuB37UbElfqQH2RPPTHnWcKcILrbJM+As+9G7W8TSfFqVWtEm/hIQ4KA66CUz6zy
	 xrPqKTVeNAytk1wzPuUNEQoxWCYpkDAv9NX6fntfdmnr8YnSUXxybaOxL5dqggUGjVTNe
	 uR8S9VWfwkOQ0oeh5KTVmvaCA9BTixd7svIfy/voiIoKwLRsR+1PVA17BgxH0onUzqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bmN9dVJCwoGnw20a3NXtR9b7469JAXfMmrvl3BTM5x4=;
	b=ypqSLO1im1jfanNjxVg0LfYw7clurpw8roKrbiFGMi5kb5DftWQ30ESNsKV9PGmG/lwg
	 7T6it2owHQZmxjtVwOL8JT08ZdHNq8SA+PeIp+mkdtSOydgo/H/H6I6ryPddaRsD7M9jm
	 DRf5cccsY8HalN/I2nba6EYSetEna2wFKwR62ctvsgagixQDfpDacBRg8m2GIBB2ofr8x
	 LeL+U7KzQV7BqMr+hePh9F3gsEZMQTziibiqvfBajnWoGzmDwXD/cLAD7czBplnG0Sk3D
	 UpXdfDlec+wtL6LcjpWj7Ido5e9uuhryHcTj0OIYlJ+/xrmoXewBGjEHMoezzqTfQ2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Is1zqaHR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A3606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C06A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Is1zqaHR
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso6925a12.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 05:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793973217; cv=none;
        d=google.com; s=arc-20260327;
        b=d5sW6AiwPu2+ihKk12N/ZC0hE23IjVxGbS7tRl9xvpycHl1grYLAuLvsGgWagWQxcN
         jhUBk6SqFDx732oCs+DxoFDN2vgLA3znqhDeliofTSHDNeEA5QTvy/2u5IyrgyiATXAX
         kMtnajZ8YYnZTfvAnroszr7EHU2ReotvzXgysrx+P+i6WsCs0z9gteBNeEQRZzuEXL2f
         MvroA4bCwVPRU5wSFPrAXId51d7rEsr5RBO9q3qT1BB1xXt+/Kg/fXIjzipEh4B970WM
         i9VCoRZkoGIXh6tSWsOtMHBLR55CLrLlta4G3ng68Pa44PeYM0k3QjTgFC4bdefzjweX
         EHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmN9dVJCwoGnw20a3NXtR9b7469JAXfMmrvl3BTM5x4=;
        fh=RxSMeYZDRLRs7qR9um94QNAY9U7kw95CCytpBHpIeA8=;
        b=OVH59CKGTrZzqdhpnHkxvlraZOXj60sfA14rbbbyxdYnawkUKMg4jmlsEXfkkjqgy0
         Cap2IEmajf/4PEkP9+5cP3IX2Fw8obOPxrlra9iIIRZRSVisS8bvRMgLfcrAr1M4ZyHt
         et/BzT1A7eVcQeK4FzlJDaJsWx4VTQZ3fwJhuN1iBwk4llTw5h7zV96P4Ut3XiBVfgHY
         7XRcJYfD9DMxY+HV3OYm2Lqac6xVg7u8vBVHS5wCTiS+bDpUmYhQhY9BH1BNcAiUhT03
         RkKbI0Or3E3Gcc+JDxbGGfdXFqcfbzX52pBk42PsAolGEyHHIPuRssDKrIgQkPfLJJKW
         d+dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793973217; x=1794578017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bmN9dVJCwoGnw20a3NXtR9b7469JAXfMmrvl3BTM5x4=;
        b=Is1zqaHRR3Tq6L0seIYcoJUJemNfBcTATHWSM+lHyqce2K+g9cgkgwT9FL1Bowzlcv
         U6QoVvwNeZBnPHlKH9grvrvKDGn5rnhA3yh04ZUWuNyuHdIohg6Y0tDoHfBWX7z75z+5
         7FaEMS0ug7c/lc96dLu7BTzWzmuFAbhu6dv1yy83gKZIHEpGAfxAh4O9pLgNQwanHO15
         OAcmrtHM8srZfrWcn86M9XfuhOxftxj37Svvk5VKhX39klsBAn452MF2bUaAYjQisMGs
         VPyV4k4NhEsLPuc3+gkE3Xlq/73EqMeqxyINWxlL/hvBh/xaly9TAc2KWDtOQrUESGzC
         xP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973217; x=1794578017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmN9dVJCwoGnw20a3NXtR9b7469JAXfMmrvl3BTM5x4=;
        b=UbbmYkSoTylx1rUrNuZKichuVBUQn8+/G/+NvNHLBR3nTz8fsjYeDLFZqaP8OeTHJQ
         Ba2m/Yr3fRKrCwCn6jJr9TYJawmJ8uN5WUXinPw4bCCCfVTgwPZhey/iJ5UtMQNn4SOi
         dfDTbG2ZCaBi/9DTU2pKeHI0aOw9W8yXpGiAAZ81OPWl478exOdXLuxCJhp1gcauSgdN
         dxG8aVadYegOSvu/Lfkb62gccRqvaMSqfb4LiFCteGoSQVH8F1V9+bhi0vXAr7DE6vhU
         AL+IZnrtGcgyV6pId4GKNkRGB84DqaLkt3+UGozZzvlB4utyrrGWqd7HXYpbj43SGlY9
         3djg==
X-Forwarded-Encrypted: i=1; AL+hErFyhnHP68iPt2Fcf66DolMuoQD0uDgRMBVyjxIOthGQ0FJ+IL9jgZSBCRCJ2inHXWqxJ7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/e1ylIo303rkTvglburOv45ckepu9nMEa+XXdNN/zBdtnGBqI
	obfZSkU8JvLJiE6GWlJ+ehYIrZS/zyo5r//nTkMjmvt32QE1cl/qdChPWV3VSmhR5iBU7cMCVJs
	NoM/xAQD0FGjzynqhYtzFNZtDfj4pqBDDGMm/H6ei
X-Gm-Gg: AYBFou0mvS6ncA6qivTffneO8tjLNTinoyKTB/NhI7YBFTkEAT1zPOU1JMnFqYw9oyY
	fbX2aTuW1kTab7RUXOTCd/RCgH8bhSPsguIjG0gt2cgUayamAQpJuXpxgyrBWC+sXuCjFLV13mj
	x/IBfotE95PeYO2/TWCkUI+4H4TGSmlhOcaaHpKkIco3nY48NGooflz6GJZueXMiT8qTQ0draZw
	/MU5JHfOehD96r9ojgNQaxS7u44Y5O5wdf1pZlswcCcgIuWwuiGHzIIYDpY0vcDz4u9i4yveo3M
	UnX9mrRS3mWeqCN5oYNpvvzdHBLy3Un1t5eStpsOSKSa0X8cl/IyIyLpJVga9X1Q512Z7ooGzlR
	I2tyLP5FKkRV0DoG3MHwOILfOfM9UeFtuiU+Srzs7wru6ORB8iucQSS7GygBpTbxI9PbpkUaCCA
	==
X-Received: by 2002:a05:6402:1009:b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b6e69f57c5mr30914a12.5.1793973216633; Fri, 06 Nov 2026
 05:53:36 -0800 (PST)
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
 <20260930210750.1487547-12-chang.seok.bae@intel.com> <CALMp9eSqUV64WbzZ0xbAc42+nyBJLN7CQ-ark5j-4P8PNPwC5g@mail.gmail.com>
In-Reply-To: <CALMp9eSqUV64WbzZ0xbAc42+nyBJLN7CQ-ark5j-4P8PNPwC5g@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 6 Nov 2026 05:53:24 -0800
X-Gm-Features: AclHuK_WXZB1ikwPyYjbCiukjUEtl-A2aKNAC4gETdImy8IerSmaJcDJFAVCnWg
Message-ID: <CALMp9eQGqbFz1kKF7Hh+vLanMqYX3KTn0ieCW1hYsJ7xrjcm+w@mail.gmail.com>
Subject: Re: [PATCH v8 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:34=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Wed, Sep 30, 2026 at 4:38=E2=80=AFPM Chang S. Bae <chang.seok.bae@inte=
l.com> wrote:
> >
[ ... ]
> > @@ -4385,12 +4396,12 @@ static const struct opcode twobyte_table[256] =
=3D {
> >         N, GP(ModRM | DstMem | SrcReg | Mov | Sse | Avx, &pfx_0f_2b),
> >         N, N, N, N,
> >         /* 0x30 - 0x3F */
> > -       II(ImplicitOps | Priv, em_wrmsr, wrmsr),
> > -       IIP(ImplicitOps, em_rdtsc, rdtsc, check_rdtsc),
> > -       II(ImplicitOps | Priv, em_rdmsr, rdmsr),
> > -       IIP(ImplicitOps, em_rdpmc, rdpmc, check_rdpmc),
> > -       I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack, em_sysent=
er),
> > -       I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack, em=
_sysexit),
> > +       II(ImplicitOps | Priv | NoRex2, em_wrmsr, wrmsr),
> > +       IIP(ImplicitOps | NoRex2, em_rdtsc, rdtsc, check_rdtsc),
> > +       II(ImplicitOps | Priv | NoRex2, em_rdmsr, rdmsr),
> > +       IIP(ImplicitOps | NoRex2, em_rdpmc, rdpmc, check_rdpmc),
> > +       I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack | NoRex2, =
em_sysenter),
> > +       I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack | N=
oRex2, em_sysexit),
> >         N, N,
> >         N, N, N, N, N, N, N, N,
>
> Per Section 3.1.2.1 of the Intel APX specification, all opcodes in row 0x=
3*
> of legacy map 1 trigger #UD when prefixed with REX2. Leaving 0x36..0x3F a=
s
> N (NotImpl) causes KVM to return EMULATION_FAILED to userspace instead of
> raising #UD when they are prefixed with REX2.

Of course, this is utter nonsense. On EMULATION_FAILED,
x86_emulate_instruction() will raise #UD, as it always has for N
(NotImpl), with or without REX2.
