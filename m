Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CE22083
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525945; cv=none; b=TzT2ByZLFjMioAFvwIsvZv+/gi/XsN2P/ujJzsCI0AyyiUCiaL19rZZvI2UGxSjwP9rcQlJRQfwwVSMDI4iG33P2JBIecDWYDB/6pONM+FFub1DCGW9jmS9dnaxdX6PXPgI+9kFSjH7XnxqDfF8s+u5Dfg+7+eAyXU6EkC7CvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525945; c=relaxed/simple;
	bh=J7z7mdVgiH4VlzTWnGP1MFTGe4qvqdZ46gBfBOPOKj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjPARpuwPSdpAAY26jYHWpmBpb/FYnBrbWHjbd0smvv+zJcoTaFk1hoFGPDeU/htwXt4cPWMrbtiyhkJlKrDOjjLAlCKWVZBg/VA+Ar3MuPngzIlPS8LeIqPrwupJ1l8eccBtA75EdFxh41eSGoK1jqBIrCNYydVuG9Ka7UGY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsaCgFc8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsaCgFc8"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso1706773a12.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 18:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775525944; x=1776130744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8JGCunGyefHsKQtmWXK1+xazxkkoaVbzvvZew5RTic=;
        b=lsaCgFc8Lu7TWxtI0ucP0qLaUT5Un16RDcyZJUQgMCxBQ3Nd84lsSiZT63wFIeRZ5o
         ZhlQBSz1DgVNVZsw+in7jwROVmLdxPXt1NQ6NMsYfKjOsTzOd5xZalADkh5Td6pt5OFl
         l8MKYuBedw6mnLiObIR4AGeyRaidxhkjl17BEmaF2LbO2F0RHJj8jnO30y3atNbs39PL
         WTBkfFdXpKhH1rIwIvcVTGE8YdAJ1Th7Kw/Z4bQ4MdS6agI7RDsKDHb5uRMYkQII2caA
         ga6GYivwUV1zDAHCJmdguJhfjn7ZrtmSGJRldEO9Nqzp7yK832a8JXBJuXhNg7emxZNb
         UhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525944; x=1776130744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8JGCunGyefHsKQtmWXK1+xazxkkoaVbzvvZew5RTic=;
        b=WoYXAgFcjQxG2MQ6l9dPuvVFfJoPZb26dfO4oyAXbYQZx+M6Yv8svsAAjsh/9yZzTr
         h45EYxNnpCdNm3i4dNVlxxsqT2HxE9+C8S306eT/Yl1AOJdf2wdw7aJuagx5L9ApQa8M
         FYUIvwbN3h/GRuVQZ/jk1zbdJHqAHKgqNL9f+eGBYsLeH6rAFCQkIzvBPw9w7PVJqw0m
         eCJOe91HxP8+yFqyZ5pDlFONgWzwUe7ku265Pud8JjbQmGQpfw2QrwJ/J6jDecLBvvUm
         UJUjSR/PSn1LRx3R5p4XoJpOkw15Dr1m+Lw6xUTmpWAlqe8ONrLQKD1fYr+Kjk1aTpD7
         9IAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/sQesKqF9/HB+gGvb70gAJAh0CxwHdQXqRTYjV8LWY7GdEzpzJiwZ298boVgMcSWl5Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRAArczgBzSqrverLWxlbYiVUtPJjPzgP1RrCUhcWPu0Ilc7j
	C7ooOjQJYYtDtPzvDbX6jKoW2kQrEc9pHixbxpYzewFboEbyfIOOWr3IEWnKZdcT7SM8WnmNC7E
	8cs62Yw==
X-Received: from pfbhx8.prod.google.com ([2002:a05:6a00:8988:b0:82c:99fb:e874])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8f:b0:39b:d9f1:6d05
 with SMTP id adf61e73a8af0-39f2f2b0043mr14551527637.53.1775525943569; Mon, 06
 Apr 2026 18:39:03 -0700 (PDT)
Date: Mon, 6 Apr 2026 18:39:02 -0700
In-Reply-To: <20260326031150.3774017-7-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-7-yosry@kernel.org>
Message-ID: <adRgNinmj0V0h6nH@google.com>
Subject: Re: [PATCH v4 6/6] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 26, 2026, Yosry Ahmed wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> Add a selftest to verify KVM correctly virtualizes the AMD PMU Host-Only
> (bit 41) and Guest-Only (bit 40) event selector bits across all relevant
> SVM state transitions.
> 
> The test programs 4 PMCs simultaneously with all combinations of the
> Host-Only and Guest-Only bits, then verifies correct counting behavior:
>   1. SVME=0: all counters count (Host-Only/Guest-Only bits ignored)
>   2. Set SVME=1: Host-Only and neither/both count; Guest-Only stops
>   3. VMRUN to L2: Guest-Only and neither/both count; Host-Only stops
>   4. VMEXIT to L1: Host-Only and neither/both count; Guest-Only stops
>   5. Clear SVME=0: all counters count (bits ignored again)
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
>  .../selftests/kvm/include/x86/processor.h     |   2 +
>  .../kvm/x86/svm_pmu_host_guest_test.c         | 199 ++++++++++++++++++
>  4 files changed, 208 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 3d372d78a2756..9418c45291231 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_invalid_vmcb12_gpa
>  TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
>  TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
>  TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
> +TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
>  TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
>  TEST_GEN_PROGS_x86 += x86/sync_regs_test
>  TEST_GEN_PROGS_x86 += x86/ucna_injection_test
> diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
> index 72575eadb63a0..af9b279c78df4 100644
> --- a/tools/testing/selftests/kvm/include/x86/pmu.h
> +++ b/tools/testing/selftests/kvm/include/x86/pmu.h
> @@ -38,6 +38,12 @@
>  #define ARCH_PERFMON_EVENTSEL_INV		BIT_ULL(23)
>  #define ARCH_PERFMON_EVENTSEL_CMASK		GENMASK_ULL(31, 24)
>  
> +/*
> + * These are AMD-specific bits.
> + */
> +#define AMD64_EVENTSEL_GUESTONLY		BIT_ULL(40)
> +#define AMD64_EVENTSEL_HOSTONLY			BIT_ULL(41)
> +
>  /* RDPMC control flags, Intel only. */
>  #define INTEL_RDPMC_METRICS			BIT_ULL(29)
>  #define INTEL_RDPMC_FIXED			BIT_ULL(30)
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index d8634a760a609..4cc1ba8752347 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -19,6 +19,8 @@
>  #include "kvm_util.h"
>  #include "ucall_common.h"
>  
> +#define __stack_aligned__	__aligned(16)

I would much prefer to provide a macro helper to declare the stack in a prep patch,
and update the bajillion instances of "unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE]"
through KVM selftests.

A blurb in the changelog explaining why _this_ test needs to honor alignment
while we've managed to squeak by without problems in other tests would also be
helpful

> +
>  extern bool host_cpu_is_intel;
>  extern bool host_cpu_is_amd;
>  extern bool host_cpu_is_hygon;
