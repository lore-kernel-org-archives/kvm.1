Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC835FF6C
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481470; cv=none; b=Ys3tZ0HzbDLFRUbiO08B9sjoMX3ViKmHd6m0JvIIzsHiqtIEQWaNCU7F8v/quPayKt5zITw0xsY/X4Knx4P8dABf1yV1jHrf+Yl89/be3HZL9KVIQK1kEH+gtfJZSmZuBDvxiy7dB20vbfQ8PjL8ecZ2XU0aeZuIhAIa2W9iP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481470; c=relaxed/simple;
	bh=YoJwQJQOm9Np1RMH1W95qUBbV0oI5XFL55aQ2Dp2Qdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sD14B9PbUZv1d33C5/QL4DzGS6ZT8bF+OSXzRX6q2QDW+11rMG2saYjXCnc08XsJxgT9X4r1ebU+pVIZkUE7fRbxTlTwqWSdFpExwXAb8Cg/eiwrjKqs8T7mqXRWpx07pgAJfYceuItd4TwuevBeJ3hUj95bUi6ZZiUolKuZhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAKyOAp4; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAKyOAp4"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so65557565ad.3
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791481469; x=1792086269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1B2oS1QUHbKrUWqJeUz/lexvA1e4Zfv5Z+36DAHQXPk=;
        b=AAKyOAp4ogkJOf16rQVzeeKJbHfu4MFGs2Vgf1+mKutwwac4kAdKALsUhOA9+nX55x
         lKQYcMVAqgftlZZbCpUpkoLXGgJQs90sXMp5p/WPIPdS5wHYmex3zT5FF0h7bOe56mcg
         iRBAsxGgCZxedK076VDwW68FONqbawlUxMh9yBt1fqwUfvyAKMQWtHiSZ1bC4y/9U1yC
         4MVC3iJ6GkcfI6t6CcNzE4k4+8f2NtcgIS21GtSe8UgEyI1+ry8bhiPfRxWdWQrIBtL2
         bfS21+cMhoc6wCkdCOSDGJtiDisALxjy2IIf/pOZv88dskSRRQA3ytRbZNkNLMlD5JVf
         27PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481469; x=1792086269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1B2oS1QUHbKrUWqJeUz/lexvA1e4Zfv5Z+36DAHQXPk=;
        b=r9T84C1xL6lZfGhflOxQxhounfBhxZEKcBqxYiN24PUl/umMGP3MLIbsYG4Ttnksjl
         fGokS0Ib10q6guGqJZzWUSfH1Tmjqt5rniIh4LVOGstn0inJ591dixlGc6rNfJ8UzdTS
         xkguz/Gxwdge5EnzmfFI2zVYUs6jpuKKVlHAmrUvV5ytunESOOR1I/vtlQy15y68FdAQ
         VGi1wjV0u94Pi89uQ7Die2vhlam/bVY0t0pSpEPA3DyDXtKMafSE0NmK8Li/vBjySwML
         WP8GdrXA6FWsv7zq7I3I9wLDFwot45bNH5Lt2fMTqfxFxBpZVmZFLvkE/wGKJaMQYZft
         tDtQ==
X-Forwarded-Encrypted: i=1; AKwUvBzy9Z0w5KyhPhyGArSxHR6CRS7wAJfx0nkRLJs1kOAF9XgsVru41yZDn0Cu2KFqG03eqWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJizhEulfZ53kHmuocV6ukYpoBVDzGObhw8Eps0/6cZSgMIWp1s
	V90TVhF9u2fJS+dzLnlT1yb4ZCxdHJBsEUQdfMGoCbH1CP922M3/y6gkALlPaR0ajUmGqxeMJlW
	2BlC/GmAUz70TPg==
X-Received: from plzt2.prod.google.com ([2002:a17:902:bc42:b0:2e2:d03f:eed])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0d:b0:2e5:a355:56e4 with SMTP id d9443c01a7336-2e60036c486mr51428145ad.11.1791481468733;
 Thu, 08 Oct 2026 10:44:28 -0700 (PDT)
Date: Thu,  8 Oct 2026 10:44:21 -0700
In-Reply-To: <20260310060022.15120-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310060022.15120-1-manali.shukla@amd.com> <20260310060022.15120-4-manali.shukla@amd.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008174424.717033-1-jmattson@google.com>
Subject: Re: [PATCH v3 3/9] KVM: x86/cpuid: Add a KVM-only leaf for IBS capabilities
From: Jim Mattson <jmattson@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: Jim Mattson <jmattson@google.com>, seanjc@google.com, pbonzini@redhat.com, 
	mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, x86@kernel.org, 
	santosh.shukla@amd.com, nikunj.dadhania@amd.com, Naveen.Rao@amd.com, 
	dapeng1.mi@linux.intel.com, ravi.bangoria@amd.com, peterz@infradead.org, 
	Sandipan.Das@amd.com, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 10, 2026 at 06:00:15AM +0000, Manali Shukla wrote:
> Add a KVM-only leaf for AMD's Instruction Based Sampling capabilities.
> Multiple IBS related capabilities are added to KVM-only leaf, so that KVM
> can set these capabilities for the guest, when IBS feature bit is
> enabled on the guest.
>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/reverse_cpuid.h    | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 32dd2d55e6f0..01abdf7f112b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -782,6 +782,7 @@ enum kvm_only_cpuid_leafs {
>  	CPUID_12_EAX	 = NCAPINTS,
>  	CPUID_7_1_EDX,
>  	CPUID_8000_0007_EDX,
> +	CPUID_8000_001B_EAX,
>  	CPUID_8000_0022_EAX,
>  	CPUID_7_2_EDX,
>  	CPUID_24_0_EBX,

The other KVM-only leaves are in the order in which they were added, and
reverse_cpuid[] uses the same order. This patch puts the new leaf in the
middle of the enum, but near the end of reverse_cpuid[].  Please add it at
the end of the enum, after the last existing leaf, and in the same place in
reverse_cpuid[].

> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 657f5f743ed9..22cfdb331e9e 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -76,6 +76,21 @@
>  #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
>  #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
>
> +/* AMD defined Instruction-base Sampling capabilities. CPUID level 0x8000001B (EAX). */

Nit: "Instruction-base" should be "Instruction-Based."

> +#define X86_FEATURE_IBS_AVAIL			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 0)
> +#define X86_FEATURE_IBS_FETCHSAM		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 1)
> +#define X86_FEATURE_IBS_OPSAM			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 2)
> +#define X86_FEATURE_IBS_RDWROPCNT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 3)
> +#define X86_FEATURE_IBS_OPCNT			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 4)
> +#define X86_FEATURE_IBS_BRNTRGT			KVM_X86_FEATURE(CPUID_8000_001B_EAX, 5)
> +#define X86_FEATURE_IBS_OPCNTEXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 6)
> +#define X86_FEATURE_IBS_RIPINVALIDCHK		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 7)
> +#define X86_FEATURE_IBS_OPBRNFUSE		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 8)
> +#define X86_FEATURE_IBS_FETCHCTLEXTD		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 9)
> +#define X86_FEATURE_IBS_ZEN4_EXT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 11)
> +#define X86_FEATURE_IBS_LOADLATFIL		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 12)
> +#define X86_FEATURE_IBS_ZEN4_DTLBSTAT		KVM_X86_FEATURE(CPUID_8000_001B_EAX, 19)

Bit 10 (IBS_CAPS_OPDATA4 in asm/perf_event.h) is not defined here or later
in the series. Is that an oversight?

Three of these names are different from the IBS_CAPS_* names for the same
bits in asm/perf_event.h: ZEN4_EXT (IBS_CAPS_ZEN4), LOADLATFIL
(IBS_CAPS_OPLDLAT), and ZEN4_DTLBSTAT (IBS_CAPS_OPDTLBPGSIZE). Please
standardize on the existing names.

> +
>  struct cpuid_reg {
>  	u32 function;
>  	u32 index;
> @@ -105,6 +120,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>  	[CPUID_8000_0022_EAX] = {0x80000022, 0, CPUID_EAX},
>  	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
>  	[CPUID_24_0_EBX]      = {      0x24, 0, CPUID_EBX},
> +	[CPUID_8000_001B_EAX] = {0x8000001b, 0, CPUID_EAX},
>  	[CPUID_8000_0021_ECX] = {0x80000021, 0, CPUID_ECX},
>  	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
>  	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
