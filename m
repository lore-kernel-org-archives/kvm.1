Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B953362120
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781710; cv=pass; b=F52KgmokQWAn5pBKTfe4sjNoJGYg8A0wvw7wAUyLMPKuPyYe/D1PPiehOuc2D+Sx/gJJkOpCS/rp+RtBo+uGGR0yBJv/cMEfBR7H3yVQkidHqjKpyMtHslQLOM5vJY4yWI9k801BREBaBmBY5DQUEXOFa1xbXaK6C6w4yn2GTik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781710; c=relaxed/simple;
	bh=bz7VCAlC3pS/IeMmBV0BkER+XEA2HS4Ltbcv/N+3xv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh/wKBU6pVWpuR7e9tGNK1RIxHPBmU1Hny4vjjNmcaxKy6If4xkdVYsldphcJjJKmFUUj+U07o0X0TWSel1Wu9i+h3EH+KjSBTm4ARheGzUUvEMe987u287bn0sokjx34k5mWWcmoiPMMAvh3kVXX391ja310EKfwwSFaTOtJa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYWdx6Fu; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYWdx6Fu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso140a12.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 11:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778781708; cv=none;
        d=google.com; s=arc-20240605;
        b=GWTzzTjIJAb/gy7b7j7jVk5+05LJ59fsxdgWrUxOuQ7UoERxJ0CZbJmQaKbmF3jz+/
         Ib8lwSRLnHh39S8jsG4QYUlHhFihWtMXxAiV5OMdYQxzRiQeCG9qlWUjb+C3D3K2k/lB
         GVo/oL/HZ4B4jVB6/pPtvUSoqO7+8cHvs8uytmQUPbstjfaRFIRin3kKz7my2xOLpyym
         Fez3Sp1LNEAL9s9r35EJwzUDeQ23yGEKTGNmY/tLWHi4Wg7W6Fhzv3m0jbbWcgFxiaTW
         vHpjqb5M/5+Wet3vloptM5txT1bm224k7Wm2R9TogPrj+p172/ZBnYQlU27vgQ78zhXH
         0JuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuQv+2Xkz0PPaxnC48IjSJx36n2gfqEKQS5cw1hUKio=;
        fh=sU+r7rgoIhi2q5mjG517P5Dr4cUxpXLRDS2t9ZeRqB0=;
        b=NoQFQUQdfl3P6cuy3/WAXlFJIeMBlW/TeUtGO5NdFQ0xlDSqNa0CczDkaXrRGs8T/F
         9p7zycaHAn46tY+yaKalDIB304fDskOEAsiZAcII8CQTWpjQEsv4PPFn+A3AiiJl9CdE
         cLcxXHBuDM4kOVnASEkaUkobVhxStI7cZ3KxO8ARhRNU29e16paJbT6AVloqIY68ysha
         aEHa5oV5UpXWvWIOlqemJkVnskUTTOKtoSzzWGRAObBotjNd0aYOrmNnTvpeUQN8ydti
         QK2ub/KGf498RGVJ34wGaJl++vB2vbf7y3LRzDReJqWapTNPZjplT2M/rJaLNoptpexg
         sHyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778781708; x=1779386508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuQv+2Xkz0PPaxnC48IjSJx36n2gfqEKQS5cw1hUKio=;
        b=fYWdx6FuylmeL6AEPs1v1BZCWiwwYRGNMJU298q5jhhvA8uXhRsfXdKi1i2wubCysF
         iGPfzgB72+ms/uYUjkUiYdJ1ZSWCv4yGhvnCHwrVcTviS22DtMwIPCTA0a8l4MYk/03/
         EGvi744rELnAciy7Ribin1jZifIHnapJqmFNEI7teKXjV/pYgFSh1t8R5F4A3Zp9HOCo
         jEyIFEewpolulBuL747Uo03+Yb0gP7YMDDM6lNmEpKSYpiea+w4KI2ZtyqTH2wvcveK1
         bKMOur80bD6BhMdpA0/Myc3wKcWuzb7NS90Vj+ornrcEgMg5/l4l0Iie5c0SA22g5rnP
         1aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778781708; x=1779386508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EuQv+2Xkz0PPaxnC48IjSJx36n2gfqEKQS5cw1hUKio=;
        b=J4oApYTo+s3an32v1TACXNFXLBpomErHI0LfpqlMLZ8ynN9Et2r+ieECaKg//uirOz
         d8bXMPCeF4k6TR7QO7QyhdMEwJB3JBTY5zAVvxc7zkDU+A9VCfU0NG09WKCijj9TMTyG
         OsYUjse98VdIscc249OfpJ3mg1xIkXF/lJpItFttxbRZnlxdLg1fTgChlfwfr8cUb063
         MHCJAqMjwez8aeTftrfP2NvOuvwO3Et+cT32cx9qkeRpQT77rJO/msJFex34/SkX5hfp
         +GSareFup0Q+dce1HhgYHmpba54xN9i2CS6ml9oRg9ADZcnw8L+vz/gWrrjoVI2LkWjS
         ofWQ==
X-Forwarded-Encrypted: i=1; AFNElJ824FTtAJuNhp7xCUYusIREairEA2u5M5vle2zRjviltvDUJ8LeiKlX3kVYxVLSDs/wLzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKhTW+eBH9qFOGMqJbcZnEsr2/YH0HtE76A9twvr3/fHkP+ad
	0AdW9QG9C9I2DaPbq+r3PjY/zwEHWF5jgJ4OGMcIpNH5kmIIR1gxN52R5Rr9ZqMG1/aqUy2jR3z
	dTg4bOt8d1zl7STJ8wGM2L6Byi82xqG9DzA4wmBIz
X-Gm-Gg: Acq92OGzl+SBo1nj+lA83j+hgfVqBsPS+sJCdGoWqrGGBEfMmFrSetmYm9811qRsqiH
	aMHizUGPhulvbaHjHlWkZEsRyBg+h3i2H6NF58/9IJO2HNfsZWF3tBtnzTZipc7ssrbIbnWGJ9x
	Rib3CWeKRYt1KwEayxK7q7Pjr/wC+ayCpc9LS0SgbS+GM8P+Q/2VfN9rfSsobRIILbzJDRjfoEN
	gaGZLvm9Powr09gZ7ECJoiS+GtoAMjozcIRoGIl9xwOVMB7Xg+btUkMxD5E6yigkFr9ikvPCbMG
	46aBgpGkalHR/VC2zAUhQ9i+BVOa
X-Received: by 2002:a05:6402:46c9:b0:67b:6d1c:9585 with SMTP id
 4fb4d7f45d1cf-683c02f0f2amr4920a12.8.1778781707399; Thu, 14 May 2026 11:01:47
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com> <20260513224608.1859737-4-jmattson@google.com>
 <CALMp9eS4s9tsOmvDUDeqS7oph0mSHyhxBiULQdwHVaG+7gXLSQ@mail.gmail.com>
 <agXcKDjnJc9DPcyr@google.com> <CALMp9eS831M153QmAgjzJcR2dFY_wCCCzDisd7_T6GyS3-gAFw@mail.gmail.com>
 <agX2SJF3rJSkIqDe@google.com> <CALMp9eQTSxFkVf4vV83yNYvv2AjseHYiD3M68mcc951L4U1Jxw@mail.gmail.com>
 <agX5v1utAfyMadPm@google.com>
In-Reply-To: <agX5v1utAfyMadPm@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 14 May 2026 11:01:33 -0700
X-Gm-Features: AVHnY4LLIpTGXClPtZ3NIuJ5IjxRpd6GGNfBMTLD-JMB8crD1vsnQ7OTTrR2bno
Message-ID: <CALMp9eQqbHrcV1_WM+5xUR16OpGk+unxoZGi+=t55cqVhFgAfQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] KVM: x86: Virtualize AMD CPUID faulting
To: Sean Christopherson <seanjc@google.com>, "Kaplan, David" <David.Kaplan@amd.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:35=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 14, 2026, Jim Mattson wrote:
> > On Thu, May 14, 2026 at 9:20=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > Oooh, this is based on the generic CPL rules.  I didn't think about i=
t from that
> > > perspective.  So yeah, addressing that does make sense.  What a pain.
> >
> > When I fix this in version 4, what's the correct footer for Sashiko att=
ribution:
> >
> > Assisted-by: Sashiko:gemini/gemini-3.1-pro-preview
> >
> > or
> >
> > Reported-by: Sashiko:gemini/gemini-3.1-pro-preview
>
> This, or even just:
>
>   Reported-by: Sashiko
>
> is good enough for me.  I don't expect random developers to know or care =
what
> model was used, at least not when it comes to reporting bugs.  If you use=
 AI to
> help write the code, then maybe I'd care?

I had Jetski write an empirical test to see how the hardware behaves.
On the first userspace CPUID VM-exit, temporarily set #GP on userspace
CPUID per the appropriate vendor's mechanism, make sure that we
intercept #GP, and re-enter the guest without advancing RIP. Then, see
what the next VM-exit is.

Surprise!

kvm_intel: KVM: EMPIRICAL TEST RESULT: #GP took precedence over CPUID VM-ex=
it
kvm_amd: KVM: EMPIRICAL TEST RESULT (SVM): CPUID VM-exit took
precedence over #GP!

LOL!

David: Is this intentional or a bug?
