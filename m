Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8465908BB
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655472; cv=pass; b=jlAzM3eFo/pc258IrdUVbvLSw2vLTDQWRqkVfDHVn1w4dmYflvsssOTSm/OVZNyrO1GlHl95U5UDGovXNJO4a3LXYbVW1tS6N/YsPxoF7h3Ngz7IV9cjmIifuEeAz/ghfeqN0WTP4G/ae0uDwKeEqyyqNcCBUWrESZREJMcyU7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655472; c=relaxed/simple;
	bh=E3oZRD9yG/RjtC4yF5B0bl+SmXgC13bgt8t7IT2/g5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhkwAbiSN8CFMZUHXPCmWFifxBM8+/ARavhRiXyWCpJC5HCUmkLVdV1nsCxppIPy+SQp8HZc1yluLd3EpMhoCBD+Y/itfzBJGriRwZ346APBypWAoyvyVya6AUOglRdAOnnVjbBzQRvsDlUEuTcbctkElGARyi6zgsNr5Jt4tt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKjnxFbJ; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKjnxFbJ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52faa58bff5so102481cf.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 07:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789655470; cv=none;
        d=google.com; s=arc-20260327;
        b=amRZZxXYldYWnXmA1VevbvV3FMOhducpx2ip/2iQpetn6rpD/1r5Awblyl87xsqyAs
         VtGg6waloAb5Ziw6+hmHRB8hIkj3+WIv+vwnLy5pV9NGCqqxg4HbsQ+HfAi65CS/AO4F
         +pGcQSpZNf6OEOe6MCWzm53ZrYdhPexXzO8BUd/kbD9aiMEitMLg4MeAOJLaflElTK5P
         zVm0ZNeJZm1jzub6ABlZWn9g8wehNC7FELiHWFcmb9Gyq4Tj2dG8G4WUWNcpV0cXGxlU
         T3bLGxqbusr5pxYN7MfobKqZeejLivRRqT8NsI5Y3TlMUj2QGP07N8G0YQFTSApv3J2K
         qpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E3oZRD9yG/RjtC4yF5B0bl+SmXgC13bgt8t7IT2/g5Y=;
        fh=librOfr7brqDg58N9cjaHsKeeuswcsWuAlx+P3ABLuk=;
        b=FQie/t3n7L9kqzCEYFEE8dgAkCBzrHUmU+PFVpWRd8GZJgkXlRUzzoadqlrA8DL1TB
         hjMam3WTjCdlxgk6md5GKzNk5vXloH+mmJE3PnDXaF4HMcfPER7g+AqiqorxD3qBfhIy
         i2fEEXERTqSjdJ2tybLxjldbrD8HO994UVM9oBtUtDDd4HeFBAtnKhrG0P5RlEI6oq2B
         /XrO7CVn4ETITCSKH3eUvXwwexM0h0IVmRSL7eWRSogx+1dNQJyvA7JwCHiqs2sNcVms
         6bNR4EAcfQxBv/LIIU1ECY8eDQVyE/teO8DCNxdu5/TX+pPSO9WwvGbv7n8aTMV74NiR
         Rp6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789655470; x=1790260270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3oZRD9yG/RjtC4yF5B0bl+SmXgC13bgt8t7IT2/g5Y=;
        b=rKjnxFbJS2MhhAPcVRGEkOhipASSkLDPVfKni9GP3WTRKdID4oW/hSEZJQInOik6n0
         dB0Pcxcg1GURjGNYveby8cmzlXk6l4YjiI6Konl5/RWffjsGFKr/Bq7yNfxY6SWcLhyk
         NSwlhmUEmq68asAOMmHxv9POrKyX66zUZ4PJvkR5Fojgmu4sB0XQiidKf9B7lf/wYEkq
         3KkjmjjpKXf42sPP5CgfbN1oFB/nshGdrohA712pons/jWHrNoOro/14wgfh0Q38TZiK
         BQxMOkAcy8C1s0u5MoGoUepb79lcU4ZBtcNl+Gy707RVnJH6MIkRHq3vLfcxSOnK3Hi1
         kX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655470; x=1790260270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3oZRD9yG/RjtC4yF5B0bl+SmXgC13bgt8t7IT2/g5Y=;
        b=E+L5ClhCgaBraAygkNixP1kce5MfMM/kRtVtfocCIw+NNbBzWglS+G08C/0zsSUi1u
         sojQ968mqjGxeYJAucXABg+dReQS1FDJ0KTx7vxo/Rn4bGv8khTPJsKiU5JodDIYgmdK
         /zQ++gzioOYM6RytLFGFkDnG0grg0yeGJ+xJoEOb+GDWw6zsdj4W11K4aYR9IRqcvcXh
         yew+YmUmaewEsWGuQ0RW77+9XNGtKdlmrOJoAfXFPMA9r5oZCbdrxogcZ2oLhO9FCdjG
         DNL3rcbEgVMTCYLGagAaik8ZxUHve6yt/zvRmR1Mho+DZWNm4S2SqRWBGfOzn1Ep/hun
         i86w==
X-Forwarded-Encrypted: i=1; AKwUvBzw/xbSihNWEqBEe5gX9rCjy1E4rpbIbEAurGpbMJhTd/7kIznt2iN9/mgj1uSBNvT9Kak=@vger.kernel.org
X-Gm-Message-State: AFuF++mcwEEkXK50AdtZdJxGvA992PP/+fEeNWMDL+sVflPcOcQaGHp+
	S366jxPiMmmr9Qo8wBgbdhUUeOZNojfG0QO4F5fkC853ZfNSrrghCuHzEslO3fnM1Ap64YoAySt
	uuoagymv7XGT0OPWCNIyfqtLg5//0nTlJSWsMNn4A
X-Gm-Gg: AYBFou0NXwUH+LQv9gZAaNk261VpYCfbS04D2tQaJVoqDgSs035mQCCZkKJn5LreWgA
	D0AJqClzW+RVtnG8A/UAuBWa5mNypbPY4gK6sE+vkHR9rlCWiXhWBrOJw8vq7LbaGMuUYM8Vw38
	3wg5qh+mOpjJfBYHS2XHL6XrpyniPDgRTOcFgxhlABOQMNxWhjTdA7v7CKGT0NQgo7sALB+c1dp
	72rd/Xj8KrY8LQ3p0f8+3apgD/f6WFLcODG0S4n8Q0nIu1mnFCBrzcUcIfbxjqqzuamrz0Z1kHo
	+Tuk/vLVtLIRxe3pOUgJKDC4PH+aBq6pAI0mwJuqJrZi21zHrqsug1jdp3iRmnw2F/0=
X-Received: by 2002:a05:622a:400c:b0:531:129b:2dba with SMTP id
 d75a77b69052e-532998b798dmr3895331cf.3.1789655469226; Thu, 17 Sep 2026
 07:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net>
 <016ecb3a3187b20fac299f1c2cb15aac01358412.1789281096.git.zhang_wei@open-hieco.net>
 <CALMp9eSnoFAk5PN-JudLc=xB6jzKzERfTVPEeAaRbLTYqtnKKA@mail.gmail.com> <cd63935b-8239-4caf-8e97-0896ab7743f1@open-hieco.net>
In-Reply-To: <cd63935b-8239-4caf-8e97-0896ab7743f1@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 17 Sep 2026 07:30:53 -0700
X-Gm-Features: AcwNN1XpKe-CB8PQDcy6cyaywdtMnfN_H56Nu0Oy7JZUSLelJ_9kw_Ni3fDLoxE
Message-ID: <CALMp9eRGvU_zXO1FWAj9o3dECpUaK4qOCOVwenPZ0nQ9+Yk2yA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add nested SVM DecodeAssists test
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:22=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
>
>
> On 9/15/2026 6:33 AM, Jim Mattson wrote:
> > Should this be:
> >
> > .exit_info_1 =3D BIT_ULL(63),
> > .exit_info_1_mask =3D ~0ULL,
>
> Did you mean .exit_info_1 =3D 0? For CLTS, bit 63 should be clear.
>
> I tested CLTS without FEP on an EPYC 9754 and captured EXITINFO1 at
> the L0 kvm_exit tracepoint, before reflection to L1. It was zero in
> all cases, with CR0.TS both clear and set. Each case followed a
> MOV-from-CR4 exit that populated EXITINFO1 with 0x800000000000000a.
>
> The current mask checks only that bit 63 is clear. Would you prefer
> checking the entire field against zero?
>
> I'm a little unsure how to interpret the APM here: =E2=80=9CIf the instru=
ction
> is LMSW or CLTS, no additional information is provided and bit 63 is
> not set.=E2=80=9D Does =E2=80=9Cno additional information=E2=80=9D mean t=
he remaining bits
> must be zero, or simply that they contain no valid decode information
> and should be ignored?

I stand corrected, and I agree with your interpretation of the APM.
The original code is fine.
