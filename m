Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6E37E2ED
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382311; cv=none; b=WRK2tAhKyTG81qtN+5I0Nv1fLwt8ziWHitCNnbBuMYbZO/ReW0sOqsoFgqb9mlV0CajBjVrUVVyJNQvNreLrTi27sq3q36josJ3f69E9ekamWu9BHuqwfs/D1ysDOWihxpE/psfdG+AToCyMU1z/i8qARkiTbuyE8y8jJRlTXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382311; c=relaxed/simple;
	bh=Krvm+sFopZ6qGwSWl9rqo/3ynF840XrDj1AyZIHWH3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhctBT4zWiOd7n918UltQ/XgSelFJt8+tgkR7vp8lA0BgRfygYKKsRlapOQIJMTwFlqEyoDu2K1eTQ0q4VeBaCtDTZrSziX0ipahgth8tWweYEkA4yYbFdWYu8gSH+GbWCsxt0NT2g554dlKi/OnAee701USCuYAPFwLSlLxDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFQGYINR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFQGYINR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249521F00A3B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779382310;
	bh=TETGt/RT8Kchr3RCq01/yC5FW3WRIspjF6ezT/Sj8/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fFQGYINRUTiTkPRIh0JTR5ASjRUotSK9JR1ig4RfXIUrEYlWSZdoellUUPmVZWeYg
	 mC629pufxJQJ84R1gHGUnDBCOmqDKJcvy/mucGoCVaH9FXTLY/20OkTIwZnZs68AIL
	 twSJFozy7fx1youz9buAsq/yy+I7g/mNBGwDUco09cu8wRFbr99+4/GFLDZ7lnKgwf
	 g0Wr/qhASFqG0jVfWUQsElUiOaRbD9UcBC1rBtrdXTWFkzIBq5t5S7pLYyHU9jC+TH
	 btiZuY++nurx3EQehcs4c4Dq8IPs3H9FfmccLtkBk4EERW8de0uD4S2Oqlyo8vmyU5
	 dlsYdBU2fBOmQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd0209f25c1so1077023266b.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 09:51:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/R2soFJ71la439E6FUd5tNCB8U+4ff64BCcBQeIVYIiolVBvUTxhJ/ZonZZn5XShtRdas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPE31F1Oq2k3CVQK+eLChRWC1N0UaYswWCjjT7Gg47G4Oyhbl1
	egGCp7wLE8BB4PLEAPplxzvjTGW6SisNQVWmiWu+zdg1LCxYS71i+ByNbr8ERkDdGD9Lr9O3yKv
	le9whow+diArTZOp5UmZGsspfOtEYNe8=
X-Received: by 2002:a17:907:75cd:b0:bd6:7a7f:66da with SMTP id
 a640c23a62f3a-bdd28b78aa3mr3715366b.20.1779382309059; Thu, 21 May 2026
 09:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <20260514210500.1626871-4-seanjc@google.com>
In-Reply-To: <20260514210500.1626871-4-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 21 May 2026 09:51:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNW+dwWykUsALO-BKTg_dX8rT8cFBCR+Y9z2NjXoGJGtA@mail.gmail.com>
X-Gm-Features: AVHnY4IKHGzplyAaeLF4bIOTDX23Gr360UrjbbvNGIYd5Cp__TZQW2xokWZ9968
Message-ID: <CAO9r8zNW+dwWykUsALO-BKTg_dX8rT8cFBCR+Y9z2NjXoGJGtA@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 03/20] x86/svm: Sort (and swap) GPRs by
 their index, not alphabetically
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:05=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Sort all GPRs in the nested SVM infrastructure by their index, not
> alphabetically.  This will allow sharing code between SVM and VMX for
> context switching GPRs between guest and host.

Potentially a naive question, why do we sort them by index if the xchg
instructions just use the offset for each register anyway?

I ask because I have a patch [*] undoing this for selftests (and
removing the 'rsp' spot), so I think I am missing something.

[*] https://lore.kernel.org/kvm/20260518202514.2037078-2-yosry@kernel.org/

>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  x86/svm.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/x86/svm.h b/x86/svm.h
> index 385c1289..d9f7c731 100644
> --- a/x86/svm.h
> +++ b/x86/svm.h
> @@ -392,9 +392,9 @@ struct svm_test {
>
>  struct regs {
>         u64 rax;
> -       u64 rbx;
>         u64 rcx;
>         u64 rdx;
> +       u64 rbx;
>         u64 cr2;
>         u64 rbp;
>         u64 rsi;
> @@ -457,9 +457,9 @@ static inline void clgi(void)
>
>
>  #define SAVE_GPR_C                              \
> -        "xchg %%rbx, regs+0x8\n\t"              \
> -        "xchg %%rcx, regs+0x10\n\t"             \
> -        "xchg %%rdx, regs+0x18\n\t"             \
> +        "xchg %%rcx, regs+0x8\n\t"              \
> +        "xchg %%rdx, regs+0x10\n\t"             \
> +        "xchg %%rbx, regs+0x18\n\t"             \
>          "xchg %%rbp, regs+0x28\n\t"             \
>          "xchg %%rsi, regs+0x30\n\t"             \
>          "xchg %%rdi, regs+0x38\n\t"             \
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
