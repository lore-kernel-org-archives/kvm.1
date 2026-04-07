Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586D3A4F3B
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579284; cv=pass; b=ELz0v550TpoabrgOhakGoaOyrKKR6fqlkmLDNhh7NslMhy8Rfs7rx+1J6+NSf0ygw1yFQKw6j7t/dVgSbFvl0GXiwhkaqfoS8pHY/AraS6XW4FqA0lQ4TSEKV7wR51bqZFfeSh0i9gZ00d4PRubVxDaLo74c9ZOBGXAQM+7Y+2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579284; c=relaxed/simple;
	bh=mfSDevp9b8hpUHFiMKkR6R4RMAK3vtsH4zOSKGhaxkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+qsKBEdK+aVFX6cia7zY36Aq2Y9f33YF6u96Dp9xD3qu3H2ZBGuYG/P606GyalH/rrzOSdGFpzlOPghMQrrWCz27o5/dSI/oVT0WlYjYLtvxcu8X4++njlnoGdaBcMeZ8hNYBDKYkEez6PauJuGx+pzxxafCShnzaoJPZAIkRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4Z06B+W; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4Z06B+W"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so41579a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775579280; cv=none;
        d=google.com; s=arc-20240605;
        b=eRBkgKMMHrs3gGH2raMAaqP8+0Br8VsA9J81WGDA6C9vJEn6NvtCroGG/iNvZZcsBe
         ST30iO6G8qpS2AmsL8PJzAhMAkq9HWII1Cexw/vPJ/HY8IrcsUHTppnYqUXCd1ItL8hv
         UyuHynemcemRxS2KXMpkJYbOcB7DsuVnVNnr9CnrUbeb7Qu6Q6fksJxaYNd1dZFnI94U
         SxXbfUqQ4E1bDwmD0EsCblTDPeuvwk9Jz6WXGCnhoNsWSLy5DTpq33g6gqA1g6o4T9wU
         QiSN0+SRbpDhh1ijqZaWtNcbXl5a8wmEQ76yH0/2ZYJBM3Hk4txhuoF6XGR2PCX5zeCc
         cAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yKg8r1WBmg20sHVEHfmhLlIhIakG5vXzHNYYZRS5Q9E=;
        fh=aX2Yd35b23Df8xi/Uq/MQBFWFgH9tzLA4QdrdPDdBDs=;
        b=fbTWad9On6clivISJ9QpWbrpoCZXtst6E0FVBD8ZlwpcH99/nfhSwnwOaYDriXJhr6
         VJSXpMpi2zQk/IegIxeqXn0JgDBZAmr9Z6xG02qiTSoOO2eg+j/1vfal0qd4ta2JUQpD
         eMRGJzG7m52GZwRN9Zn6PQa2e+vAGHBqvxX6CMCF4pgPQ6frnLm/X3V25V8wxa4qu9cs
         8rnjpeFizs99OAuzsYoG3lqtpPm87Mri2fH2S2JlHo5YQsI3TEW5cTNppuZc/CeU6zJa
         +4SzBcpcD1zBxUT98sWdy79gvMuY6vVV2W3THpFqJ3/xSHRTRliLqbnDLXZ62SFGQHDI
         +HuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775579280; x=1776184080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKg8r1WBmg20sHVEHfmhLlIhIakG5vXzHNYYZRS5Q9E=;
        b=A4Z06B+WfljDsz3Y3MnqR5tH92eU8jRlUBHvvr/DQRI4JIPythmJxKvzbCpTaluEcO
         Y0zvpsOIPeNywjQ7ouvyBYKeddXF9vi6gPZvtkav0N6uDf7hf2Q/31HrL2HnKuTdzvTJ
         2O4dqmpJ+zSMjkzAe+a4v7yq2iYxmA5bHqHD/xqLbzu3sWybSOOxjSj/2GfCANSkbvsM
         juv7p9h0l0uBR6A8BN+ViF31zH3LLVtnQaO5DkzvaO0jZAo5iOQ8h5TO1/IG9HBbyJ/q
         118Uk0lpXbpAOsVmmCkhC17GRj+iwSOGQh5CES5bLuOfB/4EB5dOTN8YMoQV+TuCYBY9
         nP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579280; x=1776184080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKg8r1WBmg20sHVEHfmhLlIhIakG5vXzHNYYZRS5Q9E=;
        b=fdlp397C9s4sRzuLlUl4n0fkeK6q7s5CBSqRWHEQSqaIb/ojpOCyTexVe97dbBurA9
         EJMKADH2p1NQJufyDKVHfG7yc34fM8YBPTuaM1VS4FhgpQ2hX8EKISPNGFlII7/2VrBZ
         KcYtg2Is+g6dDux2a/sqFyNDO2ONy+q/4S5uW9ycrgH2ARMWsNMh2dpdm2KtrdZJzRbd
         loK/inI0zO2LbKNV5tTQlo4zphmvQuLKmUi2oCTK4S3vhVo8ZHDY2pCyGIdEU+Ylk5q8
         UEAh2qTvLYEj+gId9+TnkvhxvapkOP57e2AQQLHXIDHsz8Sh9J5oJ/y/bfGAeB81lzeJ
         OoIA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Uk66q70rQeFVga20OaKjWIOLkqAvJoAJlEar6Ig0ayvIRWB3Z5wE15F0s0VVlYO1wiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHK6xHYYmoJ22ELTLvQUgoGrvBNgUpPlH3dEavX7Q/nr+moZuE
	KCMtFZhSmaZp5OfpXuE0Z1CW+wx0X+e7pTvhKmBNUd00Llqpxv/cFuLaWB9o4IOK/Ewcl1q8+Pu
	kpWj6y9bEBsEg0XYnqNaxwUndZY64DAwbcqggS/0R
X-Gm-Gg: AeBDietwTuMcjOwxPnmxr67n7dKwwFwemuidOQOVJTs4yi045fB1RFboAOtsXsMykz6
	drLOW+k9VLGAPKW/3RP8MQRTbE3twClWMwA2xrYUUms9tS4VrHiq4j/ttFEimM6R62UWmKM/Fgq
	eOO1XaVMvwuREzEArbUpTzLXntKzLZBrKbjNzZiD+JXmMPDzllXxuWRXzXqBmkm5Ki0VXeUKSf+
	B55pEVrHJMxVb5I8MLpJ0ErgT/Ag/GiLtu0lu0RMqB2WD2u1GlTs8xvVbszSsqeNR7O/wMYKveK
	0pkdU/cfl2QCW2ZSBEpmNbsGcGF6JV/LqzQ=
X-Received: by 2002:aa7:d14b:0:b0:66b:e078:5934 with SMTP id
 4fb4d7f45d1cf-66e4181ffcamr155534a12.12.1775579279867; Tue, 07 Apr 2026
 09:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-2-jmattson@google.com>
 <adRBZuqNlBozaDrK@google.com>
In-Reply-To: <adRBZuqNlBozaDrK@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 09:27:47 -0700
X-Gm-Features: AQROBzDfpgRU66Y-o07i73DU_xVQhhMm8EOnCI-usfps8N1_AZv5hiiifJSUv6Y
Message-ID: <CALMp9eQR_ZivpcARLyvDK3w+frpwU8bj2Z+ZvA_fLdCtTq3Vhg@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Mar 27, 2026, Jim Mattson wrote:
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index ff1e4b4dc998..74014110b550 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -616,6 +616,17 @@ static inline bool nested_npt_enabled(struct vcpu_=
svm *svm)
> >       return svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_NP;
> >  }
> >
> > +static inline bool l2_has_separate_pat(struct vcpu_svm *svm)
>
> Take @vcpu instead of @svm.  All of the callers have a "vcpu", but not al=
l have
> a local "svm".  That will shorten the quirk check far enough to let it po=
ke out.

What is the actual line length limit?

> > +{
> > +     /*
> > +      * If KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled while a vCP=
U
> > +      * is running, the L2 IA32_PAT semantics for that vCPU are undefi=
ned.
> > +      */
> > +     return nested_npt_enabled(svm) &&
> > +             !kvm_check_has_quirk(svm->vcpu.kvm,
> > +                                  KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)=
;
>
> Align indentation.  With the @svm =3D> @vcpu change, this becomes:
>
>         return nested_npt_enabled(to_svm(vcpu)) &&
>                !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_S=
HARED_PAT);

You wouldn't happen to know the Emacs configuration for the alignment
you like, would you? I asked Gemini, but it lied to me.

> > +}
> > +
> >  static inline bool nested_vnmi_enabled(struct vcpu_svm *svm)
> >  {
> >       return guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_VNMI) &&
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
