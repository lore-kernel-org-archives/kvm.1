Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770535;
	b=e/2BjUtaWkR9VQzoFCrUZJilLzAoNb5lp+GXPxgyDwI2LF9jz3o538kzFnmCmS4rAfq0
	 /ofUluy9be2kVa1rRymndB4bloBPbATKuXT1v6KOUT8MibcXbv/nEqrKfHc2J6W4RQSy1
	 FiQrEaB4rCmfMC1o3/RmB0PG2jxP6/XHUHAR3XcD3a7WmunCWqpziH37MQZS/4ekpFh4x
	 8TOt1LNltskor/ddOVpfTJGC8+cIWDj9F7V4uhCzbGnS8almfmTddLsYCurWuirW2wUD7
	 j9SVZqp9MAP4DIztRZqZOZXCRnMmu8bNCNey1JBC5SWYF0fmjzKAYj5XrDUsQLdN9gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JF3UN1kRxJtn08yiPLt98scNIxRJBp+OMlmCkWuMdjw=;
	b=VLrltmeF0CNsI1kO4JjaPUe0Uy3GsvU0earqrsXNjpN37vjBk2kXW55qg90ZKywvznf8
	 0smnowgh0sJXjnHSJs/mB0AkjSkCPYtqYoNaAJBUoKTfL0yGKhO8erqMGmQwcbmHDkB9F
	 6LOM+YF4MMvjUoAxVnlQfD01EYpWVqoM5WQW+3mcpF9yiwEklythvCrH85C97kVRdF2Sh
	 ZDINbaB5CmkSh+8dWHDCKIAqu2KYAAJApNDT/Xkm/l0Sk8qIe5/CAB4kWLAPMKijDNwsW
	 SdUTPXq32nZQemB/SB8jsXtAl0JO9/6qvmFaM1wXSzOl6VYSQ3iLfyzrXXFKXrB9O4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP86md6N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE89606A31B;
	Fri, 23 Oct 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KP86md6N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95641F01825;
	Fri, 23 Oct 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792770534;
	bh=JF3UN1kRxJtn08yiPLt98scNIxRJBp+OMlmCkWuMdjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KP86md6NaScZuCl6YTCgY0Xr8v5vABqnQaOAc+izbq2+s17gkmTEfSsTkjRN2xSol
	 wpzEObz3dV2PY5pLntGv2zBZIpJtw2AZti6+hjsmJiaqpLzMVWgeUj5OHdNcb9IzHC
	 W+Ke96PJmCmFs8qsMCdt6bDm+zfpcieuEcrVNaQwJ5PMWfKn7XSr5fX9ZnSgEfAIqj
	 wuX69hSYx9tCwrMs7MkqxrUHQC9XWCyvj9kcnO8dlLe+T8L2JxK6KCdmXZCd/pf4XQ
	 adzMcOPSxvDq6aYKBDU8YP8+pAPwJtbH9mFGta2zR+S2XMesX61O9q0rcfrLZbl/rX
	 iI8kwvaQdZb8Q==
Date: Fri, 23 Oct 2026 15:48:53 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jmattson@google.com
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02
 on every nested VMRUN
Message-ID: <att-Epjatf5sw-ba@google.com>
References: <atpGGKVAL3bAnmnk@google.com>
 <atqdBFgoztW0nhoC@google.com>
 <20261023090924.9685-1-amirmohammad.eftekhar@cispa.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023090924.9685-1-amirmohammad.eftekhar@cispa.de>

On Fri, Oct 23, 2026 at 11:09:24AM +0200, Amirmohammad Eftekhar wrote:
> On Wed, Oct 22, 2026, Yosry Ahmed wrote:
> > So this test case passing should be confirming my allegation that
> > intercepts take precedence over VLS.
> 
> I could be missing something, but a hardware repro points the other way,
> at least on this part (Zen 4, Ryzen 5 PRO 8500GE, mainline 7.3-rc3). The
> L2 runs "vmload; cpuid", so the exit code says whether VMLOAD was
> intercepted (SVM_EXIT_VMLOAD, 0x82) or virtualized and run on to the
> cpuid (SVM_EXIT_CPUID, 0x72):
> 
>   - Single VMRUN, vmcb12 VLS off, L1 intercepting VMLOAD: 0x82. The
>     intercept is honored, as expected.
>   - VMRUN #1 enables VLS legitimately (0x72), then VMRUN #2 with vmcb12
>     VLS=0 and L1 intercepting VMLOAD: still 0x72. 3/3.
> 
> The difference from nested_vmsave_vmload_test.c is that the test only
> looks at a single VMRUN. On VMRUN #2 vmcb12 has VLS off, so
> nested_vmcb_needs_vls_intercept() returns true and
> nested_vmcb02_recalc_intercepts() sets INTERCEPT_VMLOAD/VMSAVE in vmcb02.

I am not sure if "the test" refers to your repro or the selftest, a
standalone. A standalone repro would help.

> But vmcb02->control.misc_ctl2 still has the VLS enable bit from VMRUN #1,
> since it is only ever OR-set and never cleared, so vmcb02 enters VMRUN #2
> with both INTERCEPT_VMLOAD and VLS set and the CPU virtualizes VMLOAD
> anyway. That is the dropped intercept.
> 
> So with both bits live in the same vmcb02, VLS wins over the intercept on
> this hardware, which is why I think the stale bit is an actual
> intercept-drop (an L1 that intercepts VMLOAD/VMSAVE for its own L2 loses
> that intercept after it has used VLS even once) rather than only untidy
> state.

I tried this on 4 EPYC processors (Zen 2,3,4,5), I basically ran the
selftest with the bpftrace script below, and here are the results I got
tracing L0's svm_vcpu_run() and kvm_exit() only with guest mode on real
hardware. On all 4 microarchitectures, you will see rows with VLS and
the intercepts enabled, with SVM_EXIT_VMSAVE and SVM_EXIT_VMLOAD exit
codes:

================================================================================
Zen 5 (Turin)
CPU: AMD EPYC 9B45 128-Core Processor
================================================================================
Attached 3 probes
Random seed: 0x703a00c6
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x83 exit_rip=0x23f9ac
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9ac exit_code=0x400 exit_rip=0x24d2f0
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d2f0 exit_code=0x400 exit_rip=0x24d350
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d350 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x25be50
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x25be50 exit_code=0x400 exit_rip=0x256850
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256850 exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256854 exit_code=0x82 exit_rip=0x23f9cc
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9cc exit_code=0x83 exit_rip=0x23fa33
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23fa33 exit_code=0x81 exit_rip=0x23fa41
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa50 exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x256854 exit_code=0x81 exit_rip=0x23fb04


================================================================================
Zen 4 (Genoa)
CPU: AMD EPYC 9B14 96-Core Processor
================================================================================
Attached 3 probes
Random seed: 0x7eb8e37c
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x83 exit_rip=0x23f9ac
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9ac exit_code=0x400 exit_rip=0x24d2f0
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d2f0 exit_code=0x400 exit_rip=0x24d350
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d350 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x25be50
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x25be50 exit_code=0x400 exit_rip=0x256850
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256850 exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256854 exit_code=0x82 exit_rip=0x23f9cc
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9cc exit_code=0x83 exit_rip=0x23fa33
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23fa33 exit_code=0x81 exit_rip=0x23fa41
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa50 exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x256854 exit_code=0x81 exit_rip=0x23fb04


================================================================================
Zen 3 (Milan)
CPU: AMD EPYC 7B13 64-Core Processor
================================================================================
Attached 3 probes
Random seed: 0x5ea27b94
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x83 exit_rip=0x23f9ac
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9ac exit_code=0x400 exit_rip=0x24d2f0
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d2f0 exit_code=0x400 exit_rip=0x24d350
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d350 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x25be50
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x25be50 exit_code=0x400 exit_rip=0x256850
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256850 exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256854 exit_code=0x82 exit_rip=0x23f9cc
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9cc exit_code=0x83 exit_rip=0x23fa33
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23fa33 exit_code=0x81 exit_rip=0x23fa41
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa50 exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x256854 exit_code=0x81 exit_rip=0x23fb04


================================================================================
Zen 2 (Rome)
CPU: AMD EPYC 7B12 64-Core Processor
================================================================================
Attached 3 probes
Random seed: 0x3c17b702
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x400 exit_rip=0x23f970
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=0 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f970 exit_code=0x83 exit_rip=0x23f975
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f980 exit_code=0x82 exit_rip=0x23f985
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x400 exit_rip=0x23f990
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f990 exit_code=0x83 exit_rip=0x23f9ac
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9ac exit_code=0x400 exit_rip=0x24d2f0
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d2f0 exit_code=0x400 exit_rip=0x24d350
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d350 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x24d363
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x24d363 exit_code=0x400 exit_rip=0x25be50
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x25be50 exit_code=0x400 exit_rip=0x256850
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256850 exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x256854 exit_code=0x82 exit_rip=0x23f9cc
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23f9cc exit_code=0x83 exit_rip=0x23fa33
is_guest_mode=1 vls=1 vmload_icpt=1 vmsave_icpt=1 entry_rip=0x23fa33 exit_code=0x81 exit_rip=0x23fa41
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa50 exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x400 exit_rip=0x23fa6c
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x23fa6c exit_code=0x7b exit_rip=0x256854
is_guest_mode=1 vls=1 vmload_icpt=0 vmsave_icpt=0 entry_rip=0x256854 exit_code=0x81 exit_rip=0x23fb04

> 
> I haven't managed to square that with your reading of the test, so it is
> entirely possible I am wrong about the precedence. If it helps I can send
> the reproducer, or dump vmcb02->control (the intercept bitmap plus
> misc_ctl2) right before the VMRUN #2 that virtualizes VMLOAD, so we can
> confirm both bits are set going in.

My bpftrace script is below, if you want to reuse it. You can just run
it while you run the selftest:

fentry:kvm_amd:svm_vcpu_run {
    $svm = (struct vcpu_svm *)args.vcpu;
    $vcpu = args.vcpu;
    $vmcb = $svm->vmcb;

    /* is_guest_mode(vcpu) == (vcpu->arch.hflags & HF_GUEST_MASK) */
    $is_guest_mode = ($vcpu->arch.hflags & 1) ? 1 : 0;

    @in_guest_mode[tid] = $is_guest_mode;
    if ($is_guest_mode) {
        $vls = ($vmcb->control.misc_ctl2 >> 1) & 1;
        $word4 = $vmcb->control.intercepts[4];
        $vmload_icpt = ($word4 >> 2) & 1;
        $vmsave_icpt = ($word4 >> 3) & 1;

        @cur_vls[tid] = $vls;
        @cur_vmload[tid] = $vmload_icpt;
        @cur_vmsave[tid] = $vmsave_icpt;
        @cur_rip[tid] = $vmcb->save.rip;
    }
}

tracepoint:kvm:kvm_exit {
    if (@in_guest_mode[tid]) {
        $vls = @cur_vls[tid];
        $vmload_icpt = @cur_vmload[tid];
        $vmsave_icpt = @cur_vmsave[tid];
        $entry_rip = @cur_rip[tid];

        printf("is_guest_mode=1 vls=%d vmload_icpt=%d vmsave_icpt=%d entry_rip=0x%lx exit_code=0x%x exit_rip=0x%lx\n",
               $vls, $vmload_icpt, $vmsave_icpt, $entry_rip, args.exit_reason, args.guest_rip);
        @in_guest_mode[tid] = 0;
    }
}

END {
    clear(@cur_vls);
    clear(@cur_vmload);
    clear(@cur_vmsave);
    clear(@cur_rip);
    clear(@in_guest_mode);
}
