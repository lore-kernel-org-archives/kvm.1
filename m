Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793974683;
	b=QKZqYGB7+hwJdElb9y/oR9PcFFptB342HDNjYESFFcG1aTLDpGHjccdIAO1Te9Ot2F6h
	 5KQcNAyfkGGdnw4cbcRxELUY5VBXbRlhiJ6WSd6hisOY7j/J4eeWzn03sC2avg3mkuyKj
	 4gf+WSHU23fm9AEygerNn5mc4M1RjYroNCpo9tTiPkum6x8RveGewLSO9UQrpbOzhvvdH
	 IPnNyCGcCVuxdAmqlMJLtSxCC0dQnM8Su0txoSfyRsnt3ZldaWgZVamaY4s8PCS+DCd96
	 ppgW109D+4jt0ycObj1RodRnRFLQyifKRS8pWqUGoYrmFfxiwCj5Y9gncgXBxw2F5rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FIhGo8m+HNV2DZcgKzXPZ8a3iS9BYDppM0OYIjD6kZY=;
	b=bQURHm+1MqtaAObTitl7M9ry3ckE6Y5DMK1xbNP82XaYdv+IJxuCWvwyaer21YiCbWME
	 a04Q+t1Sqs7HPQg96kwFaX2uQGyBoLf+SoMyrY492UE9pVsO9bo4MRosN9TOSZ3E6XETP
	 FhH5hGwt/9usGAYbUnAcVIZ0ow7u17VvVv5FYup1pOO2BCZFrWvO+uG6b5FXb6VWww6pm
	 Z5w72f0s7G2XAwDhqYAAgHliyRNiAgGtJSF6okoTfJXJN09jXHyYkA0arDdS6bYmLd9Tp
	 gzX+x89nI6Gw+9e8vsMxVfbtV7/FDM20verD/CZEISxwiZX8+fzkyMGx9FYog45R2Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cjk0eKSy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A247606A338
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 14:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A247606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cjk0eKSy
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so5538a12.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 06:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974682; cv=none;
        d=google.com; s=arc-20260327;
        b=C3aQg4HUw6gzepHzIRmcAKSmvOhggQzdqOmMboGxlMNw1cC+eLdNICcRR/8wmz43cQ
         Eq1IwTHOcq+JJzeQr4ujL3AeNHJDqi2ox3xT44BGxk+XpnDpt4aH1/7uW3iyX/S4oDif
         xyvLHOCvtxJyCCnE06zANk2Aa9iWRhJ0uRIe5GJc9QdX97QxYa63lqXA99DiTnXOLgwP
         3MFevQTF5Mhzt7jUiMcC/ENsyijKG+cTsfz9Et/qUFTo/iHk4/AtCQFWAV0YiEve9OYY
         slDqk83n4SeBgkD64yf3HJQZtVUL0Du2MS1psMuZxYdU6168iIG9HIWMORir+7hqezEz
         6ngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FIhGo8m+HNV2DZcgKzXPZ8a3iS9BYDppM0OYIjD6kZY=;
        fh=jRYojTy2DTj0EMZDbATBdhPI/nBOhraeNDm7bKTOrMc=;
        b=sbP3adTOms6GBer0VXTp33wWvs3NPrMj5+I4uiGIAH9JN6xuowIHWUiKo3aIFsbJFu
         cqI/w18y3eM91KvazKDBzbBACbpiL01JvWr3P85lCY8N4J15tByK87bz253LmQrPeash
         aIJY4CpdrncRrR3U5ZRCo4HmxCpMjfIX7Xq+jJUiZDcccGeMsGhTlEOU/Pj1+05A0KFw
         oLY1+0ocf6PoHMvFm1dAfktwgjloWviFlO+n7QEfGUDQ73StPecS+xBS3ZSvY4+/TTO/
         D5aez3vMwl570/aNivbG9w1NYxyY/vzVbb/HvMfLo1fFoXJ/ux8bqJwgCW8xM345yASw
         9xdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793974682; x=1794579482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FIhGo8m+HNV2DZcgKzXPZ8a3iS9BYDppM0OYIjD6kZY=;
        b=cjk0eKSyqyklOm0YKf5KxT4jaq/jhyY/OwWVxg8L/X49VLPqje0op7zRxZqFNqXknG
         8mccBNkOinFKsnLdDvOTYFaAYiANpExBZVuaA2BIT7kLBITDxkTMcXikNfuLUw66vr8A
         VSrG3rnraI/wYIsWtedj2+BqhR+9uEPOautSPxSWSqkPjFjBlBHyaT3x/WhRvi7bw6zd
         BC5rsgq0h7DxgNDWFsI/pGJTv0VMMppcrAUi1awC192tXW39wj+0MWjkkv4KuJz1GOXp
         /blUiNW/hII46DMIxqNUe5jTNG572LvYtWqd9zi4wcLrtWVT/4yn9QQG9w3FVqK0wuj0
         VkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793974682; x=1794579482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIhGo8m+HNV2DZcgKzXPZ8a3iS9BYDppM0OYIjD6kZY=;
        b=Jla47ccZnrPdyYkDUJvrRSllZHI7jXSNHNt66Q3c9KBOKLxj7p6Ul4WCTKheTZ2jVW
         4JpTDs7WYEVxFpEJ0Lv6DVw/R5dtCbh26YwnzwrktbPErurptlygBIJNQUIoHHckAwf6
         k0r/6RaLtwcpiZZGv3VIkHYeCP4may1EWnSn58rQeMVjO2r3Ex885M1zeLptFoTQs4w5
         MKozJWswUnZQ1e5oLCqTN915KUws1FWPj3vhaI8owP3St92WJLqarx95s00aSsRNgNXK
         cIewuNJ035ohB5NFsOCG7H8rGCWeYJzKCOrcho51tfQGEzQ7P4rqvLrJv0Kw9SdkP6Qu
         YEXA==
X-Forwarded-Encrypted: i=1; AL+hErFPtpZwrEHIM+gUlz9WRAiRFbFTeygtBFkmXeZ4r+uVEFFxox66R2Y7RtwfN+qp1kJXGmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8k5H8h/48cvY2Tl3IyHtuoIT2JHPlE2WbPEHknczGneQi96vNu
	fQGok/ndkSYb8TaoGIsy66PSe4O6GM0o2JLY1xZV1hWoIWmJgnYOIgyWTQgoIFxlpH+X5T8gJ/n
	R0Md5JRzmLc3TztP8Eg2HHX0u6r8wZwzrvyRbxMcg
X-Gm-Gg: AYBFou3TRNIb2kcpGFe87jntfmTRct+CMSItqa0gGr1Ub+E9Wm54XacJb7Kk4998VHK
	SFTV+D6+/BlNA6qu64yJNQqdJGkYKpa1n0+f25YBVywtJxJE0qiRYBYL9dalnliug8rOe9bR3lA
	LJ6n9AjKEsSZtDrk4TYd1loaSOsvlD7zJMUXQwKNt2774EGKtdcw2VgcQZbfHoUwGQs9eB9zYyJ
	8MdBMeHktMydHL0vic2Ae+wuX1Xrk3quwD3GaVzQVc0A30ZD39m3hQxTqeZ24XBuhT4Ao/ZobtK
	yUFsk0vv0gvWFkQvaMxehnnPu3gu09wNqLtIZxM1nwyKFPjryU0wkY+dWKEQSNd6PADdRcMs7yg
	as26ZK2WpV2Zd1cpfYwWR4+FGEgM3fd0mhaJ7uieehm+ffmjtRRlAbhNUONQvNc4MbRGMbboR
X-Received: by 2002:a05:6402:6d9:b0:6b5:5cd3:5dc with SMTP id
 4fb4d7f45d1cf-6b6f6e16609mr43a12.1.1793974681196; Fri, 06 Nov 2026 06:18:01
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
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-14-chang.seok.bae@intel.com> <CALMp9eQVheLs1S=OMGmtnx+G0fX1-nwwP54oLcEeHKUh3_tRpA@mail.gmail.com>
In-Reply-To: <CALMp9eQVheLs1S=OMGmtnx+G0fX1-nwwP54oLcEeHKUh3_tRpA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 6 Nov 2026 06:17:49 -0800
X-Gm-Features: AclHuK-jOJlG6gVM1mOO4PZEBxQyAV4FmiWaZUbeD7ZW6SaNUIlIDjHa37rfvS8
Message-ID: <CALMp9eTOrO9w13Kj9exHy2fRz+3Q394b0SoQn8YLt1seNvt8gw@mail.gmail.com>
Subject: Re: [PATCH v8 13/20] KVM: x86: Reject EVEX-prefixed instructions
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:56=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Wed, Sep 30, 2026 at 4:54=E2=80=AFPM Chang S. Bae <chang.seok.bae@inte=
l.com> wrote:
> >
> > Explicitly mark EVEX-prefixed opcodes (0x62) as unsupported.
> >
> > Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> > ---
> >  arch/x86/kvm/emulate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index eba4e9b7cd5c..f0d5a40eba27 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -5052,6 +5052,11 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctx=
t, void *insn, int insn_len, int
> >         if (opcode.flags & ModRM)
> >                 ctxt->modrm =3D insn_fetch(u8, ctxt);
> >
> > +       /* EVEX-prefixed instructions are not implemented */
> > +       if (ctxt->opcode_len =3D=3D 1 && ctxt->b =3D=3D 0x62 &&
> > +           (mode =3D=3D X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) =
=3D=3D 0xc0))
> > +               opcode.flags =3D NotImpl;
>
> What is this patch actually doing? opcode_table[0x62] is already N
> (NotImpl). Moreover, because opcode_table[0x62] does not have the ModRM
> flag and init_decode_cache() does not clear ctxt->modrm, "(ctxt->modrm &
> 0xc0) =3D=3D 0xc0" in non-64-bit mode inspects a stale ctxt->modrm from
> whatever instruction was emulated previously.
>
> If the intent is to mark opcode_table[0x62] with No64 (or NoRex2) so
> that REX2 (with M0=3D0) followed by 0x62 raises #UD, then:
> 1. opcode_table[0x62] actually needs that flag, and
> 2. this EVEX check must be gated on ctxt->rex_prefix !=3D REX2_PREFIX,
>    or else it will clobber opcode.flags with NotImpl on "D5 00 62" and
>    return EMULATION_FAILED instead of injecting #UD.

Again, on EMULATION_FAILED,  x86_emulate_instruction() will raise #UD,
so this second paragraph is nonsense. However, the key point from the
first paragraph--that opcode_table[0x62] is already N
(NotImpl)--stands. As a result, this patch is a NOP.
