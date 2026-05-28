Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2869330337;
	Thu, 28 May 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996415; cv=none; b=eukqRs+wgu3qkb3tRCCx73Bpk1P52LNtgg3IZV3pd1EkjP7Au9e/ulvW6ENMEb1MEVvmD5a7kb8rZ3m7967LsdZfXMvx0RlGvM8x3xEfcwV/TSpYGBwdtBhAewPMkvUt5nqjBVfZaSW6Hyl98g0VuoCRf0XhsXpT0NVy1+35qBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996415; c=relaxed/simple;
	bh=e1j1XB0JBB3YKg8Cq9K3uHxfYkzWi+Ax4rrdJWG6xcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/YRRtSb30UcNyUmCN6QgC38IHwKBuqi7XJWIYEwPL31vjqbUqh710xYzYQHOMVjp73mZXkIMft7B0Ta3V60mZeBkDkP6mQW2QizsBLkrmywrZKMa2ePtsHLOsxuSlAog78MWP8/S6Re1ZWgHCTVTIYabPHPZ2v/bPKb5vHbv9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvuxzIt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvuxzIt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703301F000E9;
	Thu, 28 May 2026 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996414;
	bh=/77kKjU2Unrj9PT3tCZB0lINr42cYngfvLUcPlFFBus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jvuxzIt1TfhfQcU+LVedcplEUkI7CqudY9lVsuW2thOaHgx8r9nKIbBE//r1hTNYw
	 vttuJMoOcg/03cO+Pic8b/I4xofWZinQpPvx22sxbQuuAXihQgFm1PFPjVa/Lzh6b2
	 ONnTm6KvqF05c6B6RX49NCjL4ZoMFXGYcLC/dff3R1LuVQJeZ0Nlt4gWhQfVgMDHyc
	 lFDNbLXOw0TU4DkP7x0QUdGLeKLsrii8FR9zp8cNMiyiecJwHGeOm2iwBEqdTN/FhL
	 Q3+PbrNfxT1Vcbm2ws+apQROJp7zRKh32keKPJcYeBR9NlGIMJNCvzwScaQosneG42
	 O63gfUM7OHhSg==
Date: Thu, 28 May 2026 19:26:53 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] KVM: selftests: Stress save+restore and #PF (ft.
 nested)
Message-ID: <ahiWveuSBa0NiETI@google.com>
References: <20260518202514.2037078-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518202514.2037078-1-yosry@kernel.org>

On Mon, May 18, 2026 at 08:25:06PM +0000, Yosry Ahmed wrote:
> Add a stress test for save+restore while the guest is triggering and
> handling #PFs, in both L1 and L2. The goal was to create a generic
> selftest that would catch bugs like the one fixed by 5c247d08bc81 ("KVM:
> nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT"),
> instead of relying on high-level testing (e.g. building GCC in L2) to
> catch it.
> 
> The test tries to be as generic as possible by triggering #PFs in a
> guest and installing a proper #PF handler, while the host is
> continuously doing save+restore cycles. Exiting to userspace is randomly
> triggered by a second thread that constantly signals the vCPU thread.
> 
> Patches (1-4) are prep patches, fixing GPR switching for nSVM and
> generalizing it to cover nVMX, which is needed for the test to run
> properly with nVMX. Patch 4 removes HORRIFIC_L2_UCALL_CLOBBER_HACK, as
> it is no longer needed. While this series does not have the "complete"
> fix added by commit 6783ca4105a7 ("KVM: selftests: Add a shameful hack
> to preserve/clobber GPRs across ucall"), it's a good step in the right
> direction.
> 
> Patches (5-8) add the actual test. The test is first introduced as a
> simple (read: dummy) stress test that just explicitly syncs to userspace
> after each #PF handling to do save+restore, then gradually evolves to
> add the random signaling and nested support. After the last patch, the
> test reliably reproduces the CR2 bug.
> 
> This series conflicts with reworking L2 stack allocation in [1], but the
> conflict should be trivial to fix regardless of which series lands
> first.
> 
> [1]https://lore.kernel.org/kvm/20260506015733.1671124-1-yosry@kernel.org/
> 
> Yosry Ahmed (8):
>   KVM: selftests: Fix offsets in GPR switching for nSVM

This series will need a new version with a reworked patch 1, potentially
after some TDX selftests infrastructure lands. The .equ approach to
define offsets doesn't always work. See details here:

https://lore.kernel.org/kvm/ahiVwxm2kD0TVqxj@google.com/

>   KVM: selftests: Move GPR load/save definitions outside of nSVM code
>   KVM: selftests: Reuse GPR switching logic for nVMX
>   KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
>   KVM: selftests: Add basic stress test for save+restore and #PF
>     handling
>   KVM: selftests: Trigger save+restore randomly in the #PF stress test
>   KVM: selftests: Support running stress save+restore and #PF test in L2
>   KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
> 
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/include/x86/processor.h     |  65 +++-
>  tools/testing/selftests/kvm/include/x86/vmx.h |  46 +--
>  .../testing/selftests/kvm/lib/x86/processor.c |  13 +
>  tools/testing/selftests/kvm/lib/x86/svm.c     |  29 +-
>  tools/testing/selftests/kvm/lib/x86/ucall.c   |  32 +-
>  .../kvm/x86/stress_save_restore_pf_test.c     | 320 ++++++++++++++++++
>  7 files changed, 414 insertions(+), 92 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> 
> 
> base-commit: a9512a611bd030088f13477258d1f8103cceaa40
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
> 
