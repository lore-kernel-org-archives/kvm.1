Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BBD397E62
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668989; cv=none; b=QVAdTEa1bEpGpc11gR8Z2gptFsWapIKEKX/gjoUHxLDLNQw/k2yDbHSRl0XlKDn9VSOgNk0nhJrtRJzSO/s56GNaYY2OaSNJGHgoMymeO+U7HBDv23zDEQMUTcoTZVr4WgeWyPKMvsuyBfBqsiZf17nWmzQ1TEJpQ84YUQOatqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668989; c=relaxed/simple;
	bh=tsf0pPDcneA3+oiE8aIRJmb6TnmeXYjWKpj9HeQJhZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbtzrkPSFLTcuqJam8BrOQMhV0SkbSVEQRmUrIpFx0WdqHioxYpNprOEMPaDi6o0XS0Gd3brO/uu+Isf00I4n2r6udwUEH2DKXtMOH+xdAjkptqtPsDxLh9deZyX4IawRCKVvSgvNUW5cTc9iq3XtSvrWQgSse4KLjFjygYuKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti9oM9zS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti9oM9zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFC7C19425
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773668989;
	bh=tsf0pPDcneA3+oiE8aIRJmb6TnmeXYjWKpj9HeQJhZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ti9oM9zSkKqSCxkPEpUKHe94J6N4onqDbaRpK+HDPN150VzXyWUc7mvQ6i0Y658Ww
	 ek/0xAlFescpKeAR/T/+V7ObwaGW9ITXzHNm+ubVHqqv1O08Y1O/3eRK9AUKOsYr4q
	 fxBsEKmrwMuUk/k2qpr/5AsHUtxqjPucVjot0PmFxmgl/G5ElspL4Iq9/axi4SyVPU
	 MUZvgfk0VylSAHec/35ZQ+BMl8bEusJpcYlJFPwAuXp1bDbrVSAAhN0ZchaEGFE8Tv
	 gHYuV4hS6DaqwZnpQNfrzR4qGtKksdUul2uDTwybGv4c9Oh8xKgCOf33PlD6BaVlQH
	 RsDKRtIDYXQAQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b93698bb57aso861251266b.0
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 06:49:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjP3FTicYllBfsaoT3JYeZA3YE4+IR8nvEW9wZqXfNAnCLDUv9Cn46ZXnm9WlmyjIqaEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2XtE73hn/3CFBU43yJ35uedfx+2v5aSCCJfxFvtr2gRAkbjG
	8omPX6rAmoT4mLE2lpcYR/0KaagkIWgDm+G0X3fMr4Yspv0/UwKuLLiyDygZ3Exghyjao8F34hv
	Zn+xcu2by5bFxYbYAzNZXdUPd1nZZcI8=
X-Received: by 2002:a17:907:9285:b0:b97:73ae:e2e with SMTP id
 a640c23a62f3a-b9773ae119bmr619068266b.18.1773668987887; Mon, 16 Mar 2026
 06:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001024.136619-1-yosry@kernel.org> <20260313001024.136619-2-yosry@kernel.org>
 <181d8563-14a2-4429-9e18-ede7a6aeb030@redhat.com>
In-Reply-To: <181d8563-14a2-4429-9e18-ede7a6aeb030@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 16 Mar 2026 06:49:35 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
X-Gm-Features: AaiRm50sCN8lTTxsCjuiWXKC52bGOtfV1zHz9ZcEaGj-GIfCiRb-Gat0g8eMFK0
Message-ID: <CAO9r8zMxLx7fGGp1JPWatGNauY8fZvSECNGzC+o-p41BZrRGFg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] KVM: SVM: Drop RAX check for SVM instructions from
 the emulator
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 5:55=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 3/13/26 01:10, Yosry Ahmed wrote:
> > Outside of forced emulation or code stream rewriting,
>
> But isn't that the point? Due to code stream rewriting or intentional
> usage of stale TLBs (so that the processor executes one instruction and
> the emulator another), the emulator cannot assume that it will "never be
> invoked with an actually illegal RAX".
>
> I realize that I'm late to the show, so I apologize in advance if this
> has been discussed before.

Thanks for chiming in. FWIW, I initially intended to fix this check
instead of removing it, the removal came after a discussion with Sean,
see https://lore.kernel.org/kvm/abH0RdnM29Xyh_4G@google.com for more
context.

TL;DR is that the emulator support for VMRUN/VMLOAD/VMSAVE is
broken/unsupported anyway, beyond checking for intercepts and
pre-intercept exceptions (well, even that is broken), and the RAX
check should be after that architecturally.

The emulator isn't wired up to actually emulate these instructions.
Also, it performs the #GP on CPL check before the #UD on EFER.SVME
check, which is wrong. The right thing to do for the illegal RAX check
would be to move it after the intercept check, but we don't have an
execute() callback to put it in. I think what we really should do is
actually wire up the emulator to call into the intercept handlers for
VMRUN/VMLOAD/VMSAVE, such that it actually supports these
instructions, and the RAX check is done in this intercept handlers (or
at least will be after this series).

Given that the goal of this series is actually to stop injecting a
non-architectural #GP when KVM fails to read vmcb12, I didn't really
want to derail it anymore by making it emulator-focused. We can
probably do a follow-up on just improving the emulator support for
these instructions as I mentioned above, as that would take its own
series AFAICT.

The only reason this patch exists here is because the buggy RAX check
in the emulator results in injecting a non-architectural #GP on 52-bit
MAXPHYADDR platforms (the #NPF scenario described in the changelog).
So the check is blocking the goal of the series. I didn't really care
much whether we fixed it or removed it, but Sean did not want to fix
it and have the emulator directly peek into vCPU state, so removal it
was.

I hope this makes things clearer.
