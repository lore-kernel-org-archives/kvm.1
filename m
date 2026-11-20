Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795143517;
	b=UV1c3VEDWP2qpxF5U7Jl9aDtAubtGBUGcW8jxcBQiZY/dYBAdW2si3mmL7dhMWkB5ezD
	 PDVqVOdqFCw2DGMdB98i6Mb+h6Tzh1JcuXavdfSDrPFLGg4nlAeKuOFXbPdx18pFM4jmU
	 5p1zHn8msfamUTVfeljSGSkSaV0Iv6FxYDQDaL67rlezuwfrT+3JDrFnoG1JbLduAQa40
	 qkpI4FzFIYG7c/DVmbYQx8z5Uq5Z/atUpXKjgm8WR3GSiQMYELu95d2DsIlsUXxtU//mG
	 2O2H53DBkOKc6pUyW8D3s3X5KlHbXboFxzFG9zfSHVxj2l9E6HXe7NIORfYbszgZNqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9KW3KGczfpvaxyqdIN9CNSpPnZinVvhah60U0axjKx8=;
	b=dr+fyPT8XYrmamvweVjh0guTOZmk96FgTC/I0Vg9N5WPQurezx+r+6Ss9uguISk8/v+H
	 KSjgRNY8OZMdqI5VGf5TiUM6WdVnj4vfws9Ki39xn2sLhIHtQGhTkQRw9VvjaOBeccwZa
	 CGbe99+VOyvZJSesiNGAWEm9mo02shIR2Y/GzNWDzsbgHBJHK6jgoderWoPUC+uskkVxi
	 NI5t2YsF4txjhs7ozVIy8ipI6ma4/r/oU3z05HYMv8wkC5AfjaWL1Q2RNgeAnYytvjUfX
	 l+27Drud6rUHsWetxSDNVXEIdwmf6+uKE00BZxKMzYRlCtXrAi0xJCf49hwSDm2VocQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E7vHSdTs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BC606A334
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 02:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 792BC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E7vHSdTs
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso571680a12.2
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795143516; cv=none;
        d=google.com; s=arc-20260327;
        b=UY4HFJyHgxNQdYCy5u0bChKb7ht7LYFiJwUCEAB+hgU1q2yYmpAQXCL/xnGSpYeFRC
         q/f8eN5yy9BrNswsRWoe+IkVBOZ5qFAkFsvW7xWigvMNzhMqBEkSQrIUIzkvldEy6aEu
         LrUNEq7MDwdcFPPOWRMwKwIhx2jwr7YjVHPHwHESj4IHrI/rT7vmEQPDZpxxNKv5JGaI
         WV/YkzYfvkc0lQVRACfnpr6PMCX8/P3sqlWIjS4w79BWfR8oWrLQe/mwMC62tjrXMh1X
         RxMRiOZ17L4Zw09HhHPPc58mHEGhKd2iV/ElwhOzkufm5Yoj5I4WTDBw9fL4Qi8KJM42
         areQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=9KW3KGczfpvaxyqdIN9CNSpPnZinVvhah60U0axjKx8=;
        fh=XtxqYhUJ1dSVIDOJZ3sMvLoiWQOc1k50Rt1V7BNNey4=;
        b=Thcp88ebHzTAaTthlTLCoS58kig+Fj8H5KURPz//3UOcS1AqTQpDDfyQmhapU1Px7I
         ImHd+ijI9xWRomt59E9EJmLlTjTYywiHnTueXJpkJ+YvnA+/zm67bCC0Ts5T9tUNbF0O
         bP2JWP13zjJ8NXFSeAEeH+HF9Ae8qr85nRMEi0UCV3+TIe/H8oh7U40RSjNvr4gz9WeV
         FwHEL0SbkqeBcv4z9vc12/UE+gAe8lQQraCg+VOism2D4GeM03bs34R9XEWG2zfIMabZ
         QXuazs5HeZjZMrKIWfIqpCpi8BKuIUtQV236U91napIUlGT2GsXfEv8aJPQ5i9JvQaWr
         /aKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795143516; x=1795748316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9KW3KGczfpvaxyqdIN9CNSpPnZinVvhah60U0axjKx8=;
        b=E7vHSdTsUc074IhJVr+YlpwbUCdZ1SHAxZvc438hOa9DKeTRwI/mSEmV7AWK/QZ+hM
         neNnHD5kvcwvu6p/4L+O/TgFCbxaa78nrKEyf63KeB7csmsn6kAQ0R8WUzLW7lxZ5WsY
         oGiJY2Lo5n/DzeuYEAaLUiw+506VSlF2a7McDVOTPDN/XfwboM/qgtI8OCvxMeQQL1ad
         11XXPxv7pf2s5CLRL5CtNTRjTRdsxsQ+jxfHZyJAwWK4Q0PuL7f3jl9ofwM7oW0yhpJS
         AkIAzfr9jlvFRE2vb3PENc8QEvR/qK45GvpNllKncnDqd5TvmtihJcvztcP1opDiwpBA
         JiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795143516; x=1795748316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KW3KGczfpvaxyqdIN9CNSpPnZinVvhah60U0axjKx8=;
        b=ajnMmou/IcAQRaEXaNseQiQC8FOxJnvNH2p2lWpgbHegk1GsgnXa9vBleDPOFFMRsG
         reBeaMl57Kdya4awCDmWLxdlOK+PyWWq5VdhVasguRN7Su0ZknXMqajpsRpY2SRZ7VZb
         la+yugY+BympGvNOIV4106EmvZRiLgdRE3QKHrhWjRAispk4OGVHE5bgKrpw4+wak8cR
         TaRbIRk8nVJytV2K8S5pqXedT1iGv1L7Gs/fVZvkfsF94JulcKVGHlqpAQLKSa6qysLe
         Vo1p00hWTuT7JPXIbiP8tkZk4qGAE1B06KEhUbhgoPAl5U9w5pbTKqCuMxZox90gDd1X
         Uyyw==
X-Forwarded-Encrypted: i=1; AL+hErFswB9LT0yk4mygmBE1Ys+lZzgl43jQXI+uaUHGKEuRfHivCld3I9F+xtuCQX0lnro6e9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/OX0q+qzl0meslyemt7by04Z3iI1kwQ0OH1CG9CKwQ8F7gI0N
	poV/zyZcpdQeTObNjLn3chyI5iN9vi8XSpSqawAZm98jtxCZ2VgxvwszhA7njYkIuwAE+N2AvHw
	u6Ak61Xtc2zH8UqfvfbTEwFFNAtN24n4=
X-Gm-Gg: AZFdTZeCGgNwBDPeHOwyaIMKry8SDvyUvJQOumrBz8yh+fyyic/rlAkeLbPzUcm9L5c
	QU8lKOlxvxhNnciQ+aQkQgC16werOtmA8JXrhM3IIekN4v+zbLhvk/k3TSy3MQfqnTFllvqJiaw
	jJOyJp/ecsNhs718+aai1ruLpaC4qMhtPvb1Pat/7t3IKSlvL9Fzt/2Grw/jHApD4bY+xTxjHOX
	5ZGRUkHapXMno0SCuqNO/Bdl+alxUxpqeUt3H2iHWlG5r84H+weDm3JOMunKKFTxykA872DCAvk
	wtix5GVRhIHH2f4AUbzw+QYQcf6IUTL/A005PqJx0ToPY2TFnuhbeulvjh3QtaHLKu6+t1Q6GaN
	uu5COVHw4W39vH9qY+g6b0Th/hQyejeesqol/ZTziybMOBk2qpfYyeLNmpiJtFGnHCO2FlPcKn6
	ruBMGxQfpeHI3+ksNrx0ZDFv/3LQRd9HaKCeq/UIcgcdlW7+fURk9tYVXOy0/3vKOGnO9batnwG
	7Y=
X-Received: by 2002:a05:6402:210d:b0:6ac:c1fc:8a98 with SMTP id
 4fb4d7f45d1cf-6ba37ec77e3mr979866a12.42.1795143515476; Thu, 19 Nov 2026
 18:58:35 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKSQd8Wcw-DUR_JO9YFw17u691gjNyvySwfhPW_P5P3ik=_tBQ@mail.gmail.com>
 <av8LqXyAklPZ2-rD@seanjc-mac.roam.internal>
In-Reply-To: <av8LqXyAklPZ2-rD@seanjc-mac.roam.internal>
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Thu, 19 Nov 2026 18:58:24 -0800
X-Gm-Features: AclHuK8Gr4XnmRsYSA8XV77CmBOgUr8kzkgADOFOnPWpO7P6JC8YfKA0jNkbbj0
Message-ID: <CAKSQd8Vi_KExBOes-Skia_hDCLfnE_prBHGXkFMcTsZLiwsoHA@mail.gmail.com>
Subject: Re: [PATCH v9 20/20] KVM: selftests: Add APX state handling and XCR0
 sanity checks
To: Sean Christopherson <seanjc@google.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, jmattson@google.com, pbonzini@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 6:46=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Nov 18, 2026, Christian Ludloff wrote:
> > > Since APX repurposes the XSAVE area previously used by MPX in the
> > > non-compacted format, add a check to ensure that MPX state is not set
> > > when APX is enabled.
> >
> > For the sake of completeness...
>
> For the sake of my sanity, fix your mail client to set In-Reply-To proper=
ly.
> It's not a gmail problem.  I don't see this issue with mails from anyone =
else,
> and I just tested that sending a mail through the gmail web interface set=
s the
> header as expected.

True for a reply to a message that Gmail has (like here)
but not true for a reply to a message that Gmail doesn't
have (like when someone reads LKML via a web UI and
decides to reply by clicking Gmail's "Compose", pasting
the recipient(s), subject, and quoted text, etc.). There is
no way to paste an In-Reply-To into Gmail. And no sane
way to import an mbox file into Gmail either.

And yes, some mail clients fail to thread such messages
while others do not seem to have a problem.

Sorry for not having a working "git send-email" setup, as
well as for not just blindly handing it all to AI.

> > EVO processors do support simultaneously
> > enabled MPX and APX, with state that does
> > not overlap. (And several MSR control bits.)
>
> Until EVO processors are officially supported in KVM selftests, I don't c=
are.  I
> am a-ok supporting EVO processors, but if you want upstream to care about=
 them,
> then someone needs to take the time to enable support.

I care that the MPX^APX narrative gets accompanied by
the "this is an Intel implementation-specific limitation", as
it is not a general x86 architecture limitation.

What code does with the ever growing ball of VMX/SVM
duct tape, I don't care.

--
C.
