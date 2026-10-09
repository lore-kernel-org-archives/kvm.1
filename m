Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7B3932E8;
	Fri,  9 Oct 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569181; cv=none; b=S3OVsnQhFASEMGzS18YvNFR+Xv1Fg8m81nyt9MgTXRU/exNzWEaY0CcxI92gVkSPnuP40viE5gy4zYG5XHxV/ro6Fp8TGVrj8oB2k8QI2cUoFVkgqgII/B7SYVaZ2K8w8v87atYo+xAUnAhX0Ymp+jZqvWVWAQnlCP3ryZ9GWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569181; c=relaxed/simple;
	bh=C9Q5hU4ku+0Hikd5pgxNzMWxrzl3TUuLyju5+BhZIso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TND7CDLSZv0WkQoLybgY6jSBMfhsfAIg26JAnkwYeBa8DdwhjEqcdM6vLW+q90BviCriDbPqKOqMyEfv7Aq7ZXZiCX2/ouYZlU/Pms17mCInLrF5NlnEy8CY4Xwf0n904pHTsuhAdZdfzNpujyHDSqiuvxDbldu7Ki1+7UPIxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejh9neJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejh9neJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B70B1F000FF;
	Fri,  9 Oct 2026 18:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791569180;
	bh=7UO7u3Rlks4Xr0m9WPSJaXncgWxsa4cYwD0eG14r0Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejh9neJvdyQj8ItYF4rvDxJV5UjixafgroU3YI8IEAnEe0cwxB7MWlQqJQ0bz6AJx
	 bo8wkuaX+SVma3godgiWiq00qiXr3PxBOxtRPdPcSwrS3Pcbc0NKoe4oxtgpjCkUkx
	 KSeWVKFDw2h1dqyEzzG0KXWPZLmxtMmehJcmd3II7JU0heFk3DBCb/eUVwmcYuQHm2
	 0S68NaBxJG3DheM0bMU+CZvOxB9DSYVQOA4CW6t7L19BuYhMBnyDPf9+slLHzA+XSJ
	 oJcA5VW5uc8FA4RCSYCnzkp57Z64EVQb/MeWSLW3fIQsZJuxjPLiEZVgPZbVXm5n/t
	 g0WAhvbiAPatA==
Date: Fri, 9 Oct 2026 18:06:18 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 29/29] KVM: selftests: Add a test for nested TLB
 flushes
Message-ID: <asktCBk0LcdYGdDW@google.com>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-30-yosry@kernel.org>
 <sashiko-outbox-163475@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163475@kernel.org>

On Thu, Oct 08, 2026 at 12:35:35AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: selftests: missing memory clobber in invlpga() allows reordering
> --
> 
> commit c21865242d0952d01a007708f2fbf08ce2550486
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: selftests: Add a test for nested TLB flushes
> 
> Add a test that exercises most common scenarios for TLB flushes. The
> test is split into guest-triggered and KVM-triggered TLB flushes.
> 
> > diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
> > index c8539166270ea..7644e37c7042c 100644
> > --- a/tools/testing/selftests/kvm/include/x86/svm.h
> > +++ b/tools/testing/selftests/kvm/include/x86/svm.h
> [ ... ]
> > @@ -316,4 +316,9 @@ struct __attribute__ ((__packed__)) vmcb {
> >  
> >  #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
> >  
> > +static inline void invlpga(unsigned long addr, u32 asid)
> > +{
> > +	asm volatile("invlpga %0, %1" : : "a"(addr), "c"(asid));
> > +}
> > +
> >  #endif /* SELFTEST_KVM_SVM_H */
> 
> [Severity: Medium]
> Does this inline assembly need a "memory" clobber?
> 
> Unlike the VMX counterparts invvpid and invept introduced in this patch, this
> inline assembly lacks a "memory" clobber. This might allow the compiler to
> reorder prior memory stores past the TLB flush instruction.
> 
> > diff --git a/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
> > new file mode 100644
> > index 0000000000000..fb32b7bf6b19f
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
> [ ... ]
> > +static void l1_guest_code(void *data)
> > +{
> > +	gpa_t gpa;
> > +	int i;
> > +
> > +	prepare_l2(data, l2_guest_code);
> > +
> > +	/*
> > +	 * Alternately switch the PTE (or TDP PTE) mapping TEST_VADDR between
> > +	 * two pages containing VAL1 and VAL2, flush TLBs, and verify that L2
> > +	 * reads the expected value.
> > +	 */
> > +	for (i = 0; i < NR_ITERATIONS; i++) {
> > +		gpa = test_gpa[i % 2];
> > +
> > +		*pte_gva &= ~PHYSICAL_PAGE_MASK;
> > +		*pte_gva |= gpa & PHYSICAL_PAGE_MASK;
> > +
> > +		WRITE_ONCE(l2_expected_val, (i % 2 == 0) ? VAL1 : VAL2);
> > +		run_l2(data, i == 0);
> 
> [Severity: Medium]
> Can the compiler execute the *pte_gva assignments after the TLB flush inside
> run_l2()?
> 
> Because the invlpga() inline assembly lacks a "memory" clobber, and there is no
> other compiler barrier between the assignment and invlpga(), the compiler is
> legally permitted to reorder the memory store to execute after the invlpga()
> instruction.
> 
> If this reordering occurs, the hardware will flush the TLB while the old PTE is
> still in memory, which could allow a speculative hardware page walk to re-cache
> the old PTE before the store completes. When L2 resumes, it may use the stale
> TLB entry, causing the test to spuriously fail. The "memory" clobber in the
> run_guest() wrapper only ensures both operations complete prior to VM-entry; it
> does not enforce their relative execution order.

Will add the "memory" clobber.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008001425.2458927-1-yosry@kernel.org?part=29
