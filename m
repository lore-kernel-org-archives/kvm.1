Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681D3DB33C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449858; cv=pass; b=YrKwxTyvHzrsyRSuLrhyjnK/lZNCjkEUIhv36Du10UyOlo5N8Sb6n49FGUNT57DCl1OLaGPOpiGEG8pwVcuV6OGiCjQZiMgU2SpHJGUnxO5j3BE8T4c/Sac4H+TnaCHb58J8hf58xJ5QkHj2+thE66m/kQMWP+D6oJWxP9VwD9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449858; c=relaxed/simple;
	bh=57c67HfqGEc4ABSRRXrKQ9o+/mAKtpgqLjjD8LsUqTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0P5j2teuC0tEj37cJJi5f2QI8jlOF9jBd4YOKetYOtk/iKx+xjiIZkqNGxGne4EZmguGXTU/pPIR3WJ2SAhrJMg/Up/o5PHu2iw07DKN5D4+5hFebWtQdzBFz6dTHJ621yM7FJxfPn4i+9F8aMGHOhV7tlvEGZF16dPDHUg4/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pc8Kcpet; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pc8Kcpet"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so4327a12.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785449853; cv=none;
        d=google.com; s=arc-20260327;
        b=jFPPPwP+HrRHkDW3U9rowKYmUtUWYEiAFlyQeWdj5ANT7auSfnsfxbaYpg+XlVLBOB
         eEbUSxmQnLzWtadYMrWr0GGvpDjIvOwP2MweVs6dqmtoXZNeZ/x06Nxw3wYPJDFr40Yz
         b2zdwJCRVhs2GZCzHRBy19hmHfn2/qzM2V2DDRgWvifRwa6MvJIx7Akom1LJwpPgxg9d
         pM2F0aMAOBIOiKUs/HZCLVJ/N0oJBqbe7XNfX3OHGvT9nt69tJPaia9CdQ4ebSa5khaA
         /ZxAXlMEmP0qsd2NzmK298ZIgfxJ7PCxXPz5YGoVJ5C1B1EBnGCp+KEC5HwVi7hBs19Y
         zYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVgmt1HAAJy0HvX2pTLoMc2jfwgsl01WDT4LK1PT8Lg=;
        fh=eO27+00LkdtXrNCY92p/RSZGPWQ+0SCY+qN3fy2PqBY=;
        b=OwOKy0A0YfWORx3mqzMJaYqCYXzmlEoY4f88W/Ng0mqWVKOaD98P9F7h7oqNy8QT4Z
         fU4uMi/8iyQe+sVpbM7qt2v2AzmBpSmPL/mM2uNjZdLEp2x7YKv5pWp31ja4J4XkEY5F
         7PxiNxRJWl4No2+l/vtYBen+9pUSNYOGgTe3irWARpjWdIkzJGjIAghBqayeXj28cNpl
         OCzZZfVVMLd36H7tLsNqT+9rnTd/izKupFCUjFVa7Y/x86QZPBgprZpoUllfpa1Dh0V9
         LLCZwhtLsav/RTosYQvXRt6Toh+D217fy7RWgAxzsVJb03zMvUnHe3sX/MOOLT9nAi8o
         ixZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785449853; x=1786054653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mVgmt1HAAJy0HvX2pTLoMc2jfwgsl01WDT4LK1PT8Lg=;
        b=Pc8KcpetyONx/hmFphWorzBindkxdId5L8AtSgJYBa0TiRSS1Ih+pae6KK9yVM6q+m
         VI8E8u8ofZyfn2TPrJJaXftDkvUSsou2xcamsSEdzA3kPIpJL8u+QUCURZxiz0qVL9rB
         6ZtuTuT9WfWCHlZSCuWAIdfS8lJ/OKE5J6N7wKmaTntO4qahO22LLLL7diI/AiuuBnqW
         rC4Yv5oUqr8icm8N2Rce+Ex8j4NWI+ckAH51+arW3tsiRmySNULPn57FSKUp9zPLJLYw
         kDoi7F2e7Qd9wFTCvgloPHyvVFoFfKgpv6WwFBR31qBUjEfUZqCKRIGl/gOfKtFyAVXU
         hPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449853; x=1786054653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVgmt1HAAJy0HvX2pTLoMc2jfwgsl01WDT4LK1PT8Lg=;
        b=ZgaDdPUXiJ5k6LMiHPH0co1Zh2XKlNeCB0ErnTgjFPT+Fcu5Qzyp2NJPLd06MpSY7M
         VYJad7G0OElijp6gnL9eqJwzR2uG4HtF8z1gPjPKjRcTWYh4nSCRwlxcma8StAuBaWgL
         Pkpz4b2ibgVT4XEslvdw19cPRGdWPIauVLweTa9zXEHUlwxr3/eWYdwbF76aqun1J+Hl
         9eyF9lMRxye/nyDQGOxHqWhTAkBZkckva+Y1d2Q2c/HYtQG6c3DT8D20LbhJMJT52Ren
         f9E5Mzm9CX3jO3B0trOgfnv5U2HVWu70qzbMiEDMzu/IEMnrW/TihSDnlzJSDCr8R4yx
         B4wQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCK+EbbiCkDi3+xvaGS0bLQ2hdjZB8VxHYS55ID6adDbgZehIFWJG8WCdkXeuCFzXkbkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP91eO3KXW+qYyuSVIw2zT7yCzzHhgvZiwTROpLO8G5UZJUZHc
	7x+LqmssFwFe4c5tdTRqKJJF384WOUuFf/5VRcMXrSaObrJNDVaayxkYbBr+ALVXu7dCDfZSJXF
	0FFDSZZ71EmHJp419kc+ow/8lJsjn1yrar51k28qJ0eJwF4wjMfhGsYmQ
X-Gm-Gg: AR+sD11tf1uGeXAvMrzOONwWOPy7dUpntqxhMPFtxAkRxKY/aTutMZQy/KHCM3e8ees
	SeMSTC9+lefp5flMCZZ3oh4jw9nB+zgEr4Fp9VmqeKXSG9BLgqFugQnFILs2Y7W+/Fbucre5x+M
	7G/fLImlkNH+w2/c8Ql2YSksw/t9uZN92KTWylFiYGIJJyc13/xrnad5OkXmMhIRR4A7GfH1kS0
	Dl3GKUgKP3jg7PdUEn29Z6O4jeAixYV7ytfAJeIL6HJEfK9oFnaQZd99TgvxtyO1mk3Z/JFf/gd
	mu26N+HuUyKp7hwXl1tPJxb0C3rTCtJdPxZuXRBKY0fJ
X-Received: by 2002:a05:6402:a41a:b0:69c:83f3:4831 with SMTP id
 4fb4d7f45d1cf-6a096387c5fmr10509a12.7.1785449852190; Thu, 30 Jul 2026
 15:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com> <CALMp9eRRMga2zMrAK8-bbxcjWwyW-W+F1KE5bJqXLQN6eR8bog@mail.gmail.com>
 <CALMp9eSjp6r6WwfOt4PPzVZ+QZmfbSHZzn-m0kRYToy8kK9MjA@mail.gmail.com> <52ddfff0-f2e4-4302-94d5-aa4f2c5ba3fe@redhat.com>
In-Reply-To: <52ddfff0-f2e4-4302-94d5-aa4f2c5ba3fe@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 30 Jul 2026 15:17:20 -0700
X-Gm-Features: AUfX_mxyLcKL9NLt30OxZAgfD66qasCmrGvivSZR0NR0qPwAQCGXDhmRqQbOM6Y
Message-ID: <CALMp9eTR2xborKef6wuc=vqcrw0nXuhK=nBAjmsd0WDzPMD0iw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 0/5] x86/apic: PV IPI robustness and
 subtest selection
To: Thomas Huth <thuth@redhat.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo,

Is this a silent NAK?

On Mon, Jul 20, 2026 at 10:22=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 21/07/2026 01.07, Jim Mattson wrote:
> > On Mon, Jul 6, 2026 at 2:54=E2=80=AFPM Jim Mattson <jmattson@google.com=
> wrote:
> >>
> >> On Fri, Jun 19, 2026 at 8:20=E2=80=AFAM Jim Mattson <jmattson@google.c=
om> wrote:
> >>>
> >>> This series improves the robustness of the APIC test suite, introduce=
s
> >>> generic subtest selection, and adds a new test case for a PV IPI boun=
dary
> >>> condition.
> >>
> >> Ping.
> >
> > Adding Thomas Huth.
> >
>
> x86 is handled by Paolo, so I hope he will finally respond.
>
>   Thomas
>
