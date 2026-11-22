Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307298;
	b=VBPxDF8QrkIsVYcOTzv/YwqaWBwZ9dKNoM+V0B7yIUCWMS6/CeyOF5/pMjL5nCOu7UdR
	 rhCFQqnoPDAeGPuTLl4xhf0U9njmyeAnMcJuHQMtonaOHIiDp1ueHibIkBmnxZ3Mt/pK3
	 ICQN8tFMB6fe9GWMA+gnQeQF1zjzVF1L0Q1TGuhj2uObc5LYpnG9Y+TgrukqLiZkJlk8m
	 z7smvyx3Z4O6Ue9eejHtfSjKe6awexv0DbMg09UpyafL2nKue9WeCilKNnxnL4sqD9DMF
	 QtniaWOc1RmfJ8eVbtUt4BaIQzTyAwSjUPBHKCnEM9EnNGPutaIOeYs0RmMubp+NWOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307298;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8RhArZNo8p16GcHuh6NIuiaO1SE3vke5Fkl7bF9WXX4=;
	b=o/GG/T1zLfiGlZZbMqx3uTeEM6jVzOx4J5X5i5X/1/4QjJPHUkca5inenIG2DPymDR/p
	 yh/hflqacbs3vjUEbIM6k1HJPpdXk/VEeaVve/P24TUiSoI4okfXFda/MCfumqZ1vKBxO
	 qQLkN/a6JCaA8Fm8fUqA2HouJcH8rwYKYQHASQBTTbtNwRM2VuPGlJdp2ePTN8q92CQYX
	 oy+s177yEOiTWb01PLMyf+xEhtOTOXuVUz3y7px4Io4FUKELGCdtsAk4IvGnyonppuw16
	 mE+p/Zc/molnb+JxjfUQV1IvAh0GaSZcEZvDALBcFVqMTw2hqtlAs6XL6QlHIA6RjJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGhRLrFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5D8606A320
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGhRLrFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D151A1F000E0
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 00:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795307297;
	bh=8RhArZNo8p16GcHuh6NIuiaO1SE3vke5Fkl7bF9WXX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UGhRLrFgtuywO9ZMC+tmRQw0GrZhEJWe37Hj5LwNPGYSWfalQC+IuGbM0vR7f33cm
	 QbFU3k0iT31YsR/mr5ZQrOvtpgJuwcVSDLVtGQWZxPx+MC/vRZagmohzuwEJh4BMfk
	 VeOqpsQ+P9mxUKmCdzQyaOc8UNTFQA28tmFMMhZyg2/eU0KGlf2xjRH3+xP9pvBANe
	 h7ekRMiLhsLBcJbjAAGcBTq6emCPbJ6yVgmrOL/YNmau1hDfbSGG0hfp9JsGpeL8Am
	 q9ZmXv08zExR02+uWxG4Tsd2JZLe0OOGPDNUycMothSucpHj5Zlg8x3vTEqXQfIJGY
	 qUBaS4S5jzaOw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be47aa555cso2584977e87.3
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 16:28:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHlVlhSx/99texZwQCY/0e0Ub9xDGJVFpdAZEGSX4/pjIe74q06mJ2Ln1BfDyWREODOk4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TFAmABctxb+r0a82U+1QWMqCp+LnarW0FVWnRd1oQ3OY3uVh0
	NB1k4+nW65XU30r14PY4vW6nairgM+OIe7qA5RwYeuII4TLOGQaMnjWjIlkfdvMhkTmahn+RuqK
	lEDxvxCp2MIMaagm7RVPdL+6DeNHNVz0=
X-Received: by 2002:a05:6512:1042:b0:5c1:606b:ae8f with SMTP id
 2adb3069b0e04-5c1bc660882mr2353410e87.7.1795307296619; Sat, 21 Nov 2026
 16:28:16 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015142552.4128028-1-ryan.roberts@arm.com> <20261015142552.4128028-7-ryan.roberts@arm.com>
In-Reply-To: <20261015142552.4128028-7-ryan.roberts@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 22 Nov 2026 01:28:04 +0100
X-Gmail-Original-Message-ID: <CAD++jLkik4jJd0h2jnZFFQa_rZrnkoF6U2n69vPOoDMEFo5tgg@mail.gmail.com>
X-Gm-Features: Aa3M54o4IKo8fD9YUMMNm9Se3tMa7QPg9dEL1ZzSewcxTabcAD38a3EgY369qO4
Message-ID: <CAD++jLkik4jJd0h2jnZFFQa_rZrnkoF6U2n69vPOoDMEFo5tgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/15] misc/arm-cla: Accelerator context save and restore
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan, Jean-Philippe,

thanks for your patch!

On Thu, Oct 15, 2026 at 4:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:

> From: Jean-Philippe Brucker <jpb@kernel.org>
>
> Add helpers to save and restore CLA context for later domain switching.
> The saved state includes DATA registers, LRESP, per-accelerator SRSTATE
> and any implementation-defined internal accelerator state exposed
> through the IAS register window.
>
> Use ENTERSR to stop each accelerator and collect SRSTATE, then read the
> advertised internal register state with REGREAD. Restore by entering SR
> mode from a reset, idle accelerator, writing the saved internal state
> with REGWRITE and completing the transition with EXITSR.
>
> Reject accelerators that require SAVE/RESTORE operations during setup,
> since that path needs a DMA buffer for state storage. Allocate
> per-device save areas for all CLAs in a domain, sized from the combined
> IASSIZE discovered at setup time.
>
> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>

This just describes mechanism and not use.

I see what the code is doing but not how it is used.

E.g. part of me think: if it is technically a part of the CPU,
why is the context not stored in pt_regs?

So I assume the context change at other points than when
the process on the current CPU is preempted or scheduled
in.

This context (ha!) is needed here so we can understand
the *purpose* of this context switch.

Maybe the use of contexts and context switching need to
be in the cover letter?

Yours,
Linus Walleij
