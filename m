Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11A1A680F
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779935280; cv=none; b=FCiVknncWQ3aIDYj8PkAMP/cJk03HCYPNwMRfP4GDJfF4L54uhCMwzULsu/HTy/zHKCVUFzH5Gmkg2ijqGGjF5OffLavenwJPuw57OLU267R5ww/3lwAlyFxG1yS90r0i83p00/PrjNvsD1bU9ELvExy8fDbjm/IR1x3EEWDmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779935280; c=relaxed/simple;
	bh=nLLPuCdNmRQZ0Oo8285nt0spZY7+o3nE86Yfg1dYGiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GoxmSbwkJCpEVflP7tt+75ZOncj+HpO6zddON0EE+FS7QDFuCXHGwPtsAE6A9a1TaIVUOBXgSkHEDqP5BaDGT23oYoldh3vzs9TcQB8so0VM6bKFvyPUDSaTNaEDN50I87Tt5Ie8o82PXFgyQjWtxYN4TJ9TN3NbS4N3wsHi3+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoeA6Sqj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoeA6Sqj"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353b042152so13470934b3a.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779935279; x=1780540079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=quuJWlyAppDPgAPcSZyEzPmuCUDWESYO2v/WDSRk9CE=;
        b=FoeA6Sqj6TlSRYx/ACOXdIAL7MMxRTGcXpkqUjtoNj83gOWr93suhJXS5z5waOXh+s
         NLcan+kpYGN1huxWOoJNFMGNMZx0IJYbZeEeRV3POsaOt/vWIJGFrKBXigRnP/vV+Fd8
         pQRAHns1YxHohOmAMGuFoXEbtlFtgKdF4QwBc3bVE4n0eL1aHJj/jQkakBzp9+uKxKvh
         PNzqVr2oMTPC8Yp30urmDZ+4EZ5Zc/9E+7MEpKP6M+n3OsMwQBLWAnJisP2rVwdeuHPG
         EtXMya0NUrk3pQh9RQKq1ejbksGvavFU4hIcOeHzZlGKl6mzuTBnwXz9lMPOluf3gbtM
         r1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779935279; x=1780540079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quuJWlyAppDPgAPcSZyEzPmuCUDWESYO2v/WDSRk9CE=;
        b=AcJ+/h1f3r2dDeRYw8lujUwHNVOJzTxlJ+BD2/dvDKlLAr2uTtvuJwYVY+A0Nz3q3w
         LKRPK4yirwx5/Z9MPrSMZ8JmN67Ib7s0ezWXzDLgDZJT+z/+P8I2KQ4ZeznXQXUDvwvL
         Jr7F+WQg6gmH+i+dTD1QKvgUGYE4d96wD2XY6Cx3klEbcWC4F6mAOL/1pl9y1TjODWj1
         C3fX2t1rKuB5+ny5Tkorhiq+3U+ddcnePm0c1s8fUpJy9v52gfLBFTgCeSNAOB6Wu5M7
         TahXfi1nUvv3nUgOMoSlq9McPej3FnMShh3TCYB+JaNpuxeLF/Uko3X7HOHeVnR0lCnG
         kkcA==
X-Forwarded-Encrypted: i=1; AFNElJ9KfMN3f+DV9vr8WY6pM2y7ER8rNTq4zJnozRESnVaFfjXpwLie16LH/9Gp/5Z9dd0VCqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMltyo+mpy+c7V6vJAMoCUsvB5jyjygeGMTNQ4Wvrk6Nfq6UiS
	YIbV5YOQRX6gfWlBSPJl7Wpyj54tbZNwT7D6IwA+k3JzzMyBUJy+DMZ/P2V5Tod+KnGsCqKF8tf
	80qpnOQ==
X-Received: from pfch18.prod.google.com ([2002:a05:6a00:1712:b0:841:c352:f7c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:66df:b0:835:3949:3c25
 with SMTP id d2e1a72fcca58-8417a84cd06mr17518553b3a.24.1779935278743; Wed, 27
 May 2026 19:27:58 -0700 (PDT)
Date: Wed, 27 May 2026 19:27:58 -0700
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-1-yosry@kernel.org>
Message-ID: <aheoLra4MFZj7ID7@google.com>
Subject: Re: [PATCH v7 00/17] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Yosry Ahmed wrote:
> Jim Mattson (2):
>   KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated
>     PMU
>   KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only
>     bits
> 
> Yosry Ahmed (15):
>   KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
>   KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
>   KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
>   KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
>   KVM: x86: Move enable_pmu/enable_mediated_pmu to pmu.h and pmu.c
>   KVM: x86/pmu: Rename reprogram_counters() to clarify usage
>   KVM: x86/pmu: Do a single atomic OR when reprogramming counters
>   KVM: x86/pmu: Check mediated PMU counter enablement before event
>     filters
>   KVM: x86/pmu: Add support for KVM_X86_PMU_OP_OPTIONAL_RET0
>   KVM: x86/pmu: Disable counters based on Host-Only/Guest-Only bits in
>     SVM
>   KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
>   KVM: x86/pmu: Reprogram Host/Guest-Only counters on nested transitions
>   KVM: selftests: Refactor allocating guest stack into a helper
>   KVM: selftests: Allocate a dedicated guest page for x86 L2 guest stack
>   KVM: selftests: Drop L1-provided stacks for L2 guests on x86

This all looks good.  I'll get the KVM changes applied and pushed (assuming they
pass testing).

For the selftests, I'm going to hold off on applying them until after the initial
pull requests for 7.2 are merged into Paolo's tree.  The (AWESOME!!!) L2 stack
changes are going to cause conflict hell, and it's easy enough for me to carry
them out of tree for a few weeks.

I'll send a refreshed version of the selftest once kvm-x86 has settled down for
7.2, e.g. to account for the gpat test as well.
