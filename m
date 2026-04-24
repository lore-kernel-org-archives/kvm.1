Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06F3EFD0B
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054842; cv=none; b=Bh/KVAtCsC6syk37FXPfiMlZEX9dG8KAdK92NGKIxJD9v0EYYVLnE/D4WjwsZ+dVIJT9lkHfuKxc3quDsnenu2Lwexxv+Tvkg8kgHrcvpQwRatc90qK46NMARMSFs6ZbVP+T+wTpJ/92T+F02vMYQD7IvrwV/fPuE2N3QHlbuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054842; c=relaxed/simple;
	bh=b68WVtnKyNXVgz5IpZquuOaUPnNYbHk3xlQM+t3lxGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nD26Z+WnFRaLVYbChFHpdTLNF54hLcpB5DWCkkRVywVpjB85QEA2jhdUMJec5zROuBIzsh8gg/zn25s0PwGWPOVqYDHI4vK5giuFXyOkl+DhIE53+zj823aiNByfVTYozSwa9l9fF7+bM6wZf4odMH6UjCPavAR+URvEFh67EOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cdMmO/Ep; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdMmO/Ep"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so4506607f8f.1
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777054837; x=1777659637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ3ffUmyrezSY/rh/pt0nrkBPeHVspjmLRhtqz3CZrg=;
        b=cdMmO/EpcWjUIe/GNLKOVAtkdGHCTMRJq+pTyNn1mhuTz+BpCPPrVItG7RtgsqG5oO
         NeL2VjccVtm5bNNWFE3RhEouWCRbFuz2NVvhvHgi0v27jzgnwtLDDbX80MghoFKH+NGi
         sIz0W4yxO9QbryF2E7uGLKJidJxKfTh/V6SKnjdlxAc9Z7d8HsqYrH2zExn/qyfNhb8p
         lMu2jW8kEuFD2+jsSuLGZVpx/VggisfwkvbLK3bd/6E/0420KTVG3kTl4qnepPALba3w
         F3P1LjFZwklIOmXZr3PCgHQed6adrrOcME6B3i/vC8SmP8Eu63hPHHYPvcvRHP0aJUtd
         NyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777054837; x=1777659637;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ3ffUmyrezSY/rh/pt0nrkBPeHVspjmLRhtqz3CZrg=;
        b=fOMoSxnM8zhA+ZKZwWnJpGiLFWAVQ9YysIEVxXZVIbGXtZltdLkyj2yjPnb8P2Z3mn
         ULGQ2aBwi9vf3aNAWKx/pO+RdPbgBod6eJQ6vKYvfapTNTrs3Lenn2f7XScGitzbCi2Q
         HbWbCv+t6yA3ho9s5wDPX6Fh+6ExFBF0E7xG0uGWYr3jKNMTDLt1qf+j7zSRvHwRiuRn
         TpzsxD7wD1eBFWvmkb6KRqZ+No9N9x9FFdBPtARo7ItATI+bnd2+OmUX1EMHN8qKlUjR
         +OKfpcB5WVg5XnbfqAYnLtj9L4u5jU8O6yNeH78+uZoJGlOGxemJmjNxPrJVj58hRYeZ
         VkDw==
X-Forwarded-Encrypted: i=1; AFNElJ+mwQ9ibrWutllD7vmvK3NXW5rxG+ZxlY7bov3PoKtRbVW8yK1NrUnzmAIvuLCOC4/+Rkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/fg3Z2uU9PizoBl5mVzymA2ranuPXh+CXXaa/p/vmBLDL/YD
	KjiviBZ7T8Rt1buFGOJaB2zedAUhBY50GeqB8QLiAHz61cDvAxMdLtV8lRQ5tLXdP6kfJzzOFPk
	OpeeT6A8oKA==
X-Gm-Gg: AeBDiestSLFiuABv7g2rHvM2RRfcrkAojTZcmd190wF8vnJjbRv98FDjf8PlFiuC7ch
	EZflrl0Ydiri2bUUxgPTvF6HCiyUlrcFw04J8C3t5uVpEMzpuFzAhtYCT5s2uh77581aCbazw/j
	g6DLZ5jCNo9/spI0AWfEC+ptN/aFx4VpAIsaLM5k1gIo3v2awT2I6oURN1SxabAWq9sL2tOSImU
	OALG9ZFHJZ9VRXMnuOXyPhr4uGqC12MroTVkdE5raINiCTnrT/7qR563YWu5Wcus2x9N2hJdOFo
	mwWj+Dwk+cMaNUGsB28ZpT/muVYk67bk4wMCNQOft9/bh+VW7PFqPTAjmYA8Z8eLeqCXc8YxjVI
	cH93q4y/4EYMydYgb69I7BE1lHNonpMm1fzW7TzEniUnzAz46REJctM2n49IFFc9aImrYpTQsqW
	r66y0s4YmQziaQEM4LLJrGDQNrsgGmM+yRzQ==
X-Received: by 2002:a05:6000:1889:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-43fe3e0bd8dmr49822275f8f.32.1777054836694;
        Fri, 24 Apr 2026 11:20:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm57497836f8f.22.2026.04.24.11.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 11:20:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 0E1EF5F7C7;
	Fri, 24 Apr 2026 19:20:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,  Alexander Graf
 <agraf@csgraf.de>,  Peter Maydell <peter.maydell@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mohamed Mediouni
 <mohamed@unpredictable.fr>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v3 00/32] target/arm: fully model WFxT instructions for
 A-profile
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 22 Apr 2026 13:52:17 +0100")
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 24 Apr 2026 19:20:34 +0100
Message-ID: <87y0ic43v1.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
> The series starts with some refactoring of the syndrome register
> helpers to use registerfields. We then expand the WFIT trap handling
> to report the register used. We then implement the event stream events
> for SEV, global monitor and the timer related ones before enabling WFE
> for A-profile and then finally WFET.
>
> Note on AI usage. As an experiment I previously posted an RFC series
> with the help of Gemini. This series however is a ground up
> re-implementation which takes some different approaches on modelling
> the event stream. In particular rather than running multiple timers we
> use the same wxft timer and just compute if the timeout or timer event
> will come first.
>
> v2
>   - I've kept the tests separate, see:
>
>     Message-ID: <20260417164328.1009132-1-alex.bennee@linaro.org>
>     Date: Fri, 17 Apr 2026 17:43:20 +0100
>     Subject: [PATCH 0/7] tests/tcg: more capabilities for aarch64-softmmu=
 tests
>     From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.or=
g>
>
>   - tweaks to global monitor behaviour
>   - STLR/STL will also trigger events to avoid deadlocks
>   - see under the --- in the patches for details
>
> v3
>   - fixed the WFE exception handling
>
> Alex.
>
> Alex Benn=C3=A9e (32):
>   target/arm: migrate basic syndrome helpers to registerfields
>   target/arm: migrate system/cp trap syndromes to registerfields
>   target/arm: migrate FP/SIMD trap syndromes to registerfields
>   target/arm: migrate eret trap syndromes to registerfields
>   target/arm: migrate SME trap syndromes to registerfields
>   target/arm: migrate PAC trap syndromes to registerfields
>   target/arm: migrate BTI trap syndromes to registerfields
>   target/arm: migrate BXJ trap syndromes to registerfields
>   target/arm: migrate Granule Protection traps to registerfields
>   target/arm: migrate fault syndromes to registerfields
>   target/arm: migrate debug syndromes to registerfields
>   target/arm: migrate wfx syndromes to registerfields
>   target/arm: migrate gcs syndromes to registerfields
>   target/arm: migrate memory op syndromes to registerfields
>   target/arm: migrate check_hcr_el2_trap to use syndrome helper
>   target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
>   target/arm: use syndrome helpers to set SAME_EL EC bit
>   target/arm: make whpx use syndrome helpers for decode
>   target/arm: make hvf use syndrome helpers for decode
>   target/arm: use syndrome helpers in merge_syn_data_abort
>   target/arm: use syndrome helpers to query VNCR bit
>   target/arm: remove old syndrome defines
>   target/arm: report register in WFIT syndromes

Peter,

Do you think you could take the patches up to here so I don't need to
hold the re-factoring patches in the tree?

>   target/arm: teach arm_cpu_has_work about halting reasons
>   target/arm: redefine event stream fields
>   target/arm: ensure aarch64 DISAS_WFE will exit
>   target/arm: implements SEV/SEVL for all modes
>   target/arm: hoist event broadcast code into a helper
>   target/arm: implement global monitor events
>   target/arm: enable event stream on WFE instructions
>   target/arm: handle the WFE trap case
>   target/arm: implement WFET
>
>  target/arm/cpu.h               |  27 ++
>  target/arm/internals.h         |  31 +-
>  target/arm/syndrome.h          | 595 +++++++++++++++++++++++++++------
>  target/arm/tcg/helper-defs.h   |   5 +-
>  target/arm/tcg/translate.h     |  32 ++
>  target/arm/tcg/a32.decode      |   5 +-
>  target/arm/tcg/a64.decode      |   5 +-
>  target/arm/tcg/t16.decode      |   4 +-
>  target/arm/tcg/t32.decode      |   4 +-
>  target/arm/arm-powerctl.c      |   4 +-
>  target/arm/cpu.c               |  53 ++-
>  target/arm/helper.c            |  12 +-
>  target/arm/hvf/hvf.c           |  14 +-
>  target/arm/kvm.c               |   5 +-
>  target/arm/machine.c           |   2 +-
>  target/arm/tcg/debug.c         |   2 +-
>  target/arm/tcg/op_helper.c     | 231 +++++++++++--
>  target/arm/tcg/tlb_helper.c    |   6 +-
>  target/arm/tcg/translate-a64.c |  60 +++-
>  target/arm/tcg/translate.c     |  35 +-
>  target/arm/tcg/vfp_helper.c    |   5 +-
>  target/arm/whpx/whpx-all.c     |  13 +-
>  22 files changed, 946 insertions(+), 204 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
