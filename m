Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E637C930;
	Mon, 29 Jun 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764764; cv=none; b=oVLSyChGdJFbDTLpp/49u1AzPBX5wRY6n5g08tArNROGMnpPG/p8ZCo5esuk1/JZPiKncmfyZNkLQHmhmNQychB1UBZtY0jeAm275aYbUjNnQNxYS837Y72Nfhww5W6JiWO+AsHXGOvu/CJeAW7ZNw0ylFnp3MC+f5tNW/7Xxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764764; c=relaxed/simple;
	bh=72EfKXbpMfG1CuuESPj7eBDgrBSqUvnN1lLV2sSL1MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzrfvGE0RH21WTCUVm1wh/8qtnXz5bUgeIxwSDO2N9O3Nriuhq+u64SVN9DPg86vAYQpbArrnUikln6JchMr+54JW4QhabTv9GSlQmr2AcNGt/D6/jESnSrRYjeKyKwYHTLSO6jUrAqYPSIxSjqRVmr3CHMF9n/X9GWi/Mj9bEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6DgZxlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6DgZxlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19321F000E9;
	Mon, 29 Jun 2026 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782764762;
	bh=onLZDZMcTlO4TEIuhHie61iOchqDX4z2IhGHn95Ci5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F6DgZxlWWASiK5iXZZW8cycy4rou1r8yd0kJ6ct/wWKnAKw3Log6rBPfgcoxxDoDM
	 Hh3ivEc+5NXJW/sxTJ5f6nS1/9p4PvUed4h2E5L5a2b/aYQHU9x4+kSJy23QMnCoGw
	 hW0p2o0MHZbXIKCgdRapCCTct85dC2SfOWk/Uy8rKyUx5GQN3pNQMpOprTskDEsOe2
	 F4SteXDM3A2PyCi9g8U6vSk60mfHx4h7E/Me8IbQmvum4rkzM46NEXYalirovp6TV4
	 /RYeqShRH2zQaTrF9/+0SLEdBEH96MotPj1uMI2sW47JZDL2qj1LyvQEGhtseoWFS5
	 In4WHmbefD3CQ==
Date: Mon, 29 Jun 2026 20:26:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 05/10] KVM: selftests: Reuse GPR switching logic for
 nVMX
Message-ID: <akLTk3geAmXIc-My@google.com>
References: <20260629183746.699840-1-yosry@kernel.org>
 <20260629183746.699840-6-yosry@kernel.org>
 <20260629184932.550311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629184932.550311F00A3A@smtp.kernel.org>

On Mon, Jun 29, 2026 at 06:49:31PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly introduced VMX_SWITCH_GPRS_ASM logic makes vmlaunch and vmresume thread-unsafe, corrupting L1 host and L2 guest register state in multi-vCPU nested tests.
> --
> 
> commit f53344a36faa652dd7b5c7d1e749a4bffbc5242b
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: selftests: Reuse GPR switching logic for nVMX
> 
> This commit introduces VMX_SWITCH_GPRS_ASM to reuse the GPR switching logic
> from SVM for nVMX. It replaces the push/pop of registers with
> VMX_SWITCH_GPRS_ASM during vmlaunch and vmresume operations for both standard
> and enlightened VMCS.
> 
> > diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
> > index 4bcfd60e3aecb..a808dc21c9f21 100644
> > --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> > +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> [ ... ]
> > @@ -373,34 +387,23 @@ static inline int vmlaunch(void)
> >  	if (enable_evmcs)
> >  		return evmcs_vmlaunch();
> >  
> > -	__asm__ __volatile__("push %%rbp;"
> > -			     "push %%rcx;"
> > -			     "push %%rdx;"
> > -			     "push %%rsi;"
> > -			     "push %%rdi;"
> > -			     "push $0;"
> > +	__asm__ __volatile__("push $0;"
> >  			     "vmwrite %%rsp, %[host_rsp];"
> >  			     "lea 1f(%%rip), %%rax;"
> >  			     "vmwrite %%rax, %[host_rip];"
> > +			     VMX_SWITCH_GPRS_ASM
> >  			     "vmlaunch;"
> 
> [Severity: Medium]
> Will this replacement make vmlaunch() thread-unsafe in multi-vCPU nested
> tests?
> 
> Since VMX_SWITCH_GPRS_ASM uses GUEST_SWITCH_GPR_ASM which operates on a
> single shared guest_regs array in L1 memory, concurrent executions by
> multiple vCPUs (e.g., via memstress_l2_guest_entry) could clobber the saved
> host state and L2 initial state for all but one vCPU.
> 
> The previous push/pop sequence was thread-safe since it used the stack.
> Does this same thread-safety issue apply to vmresume() and the evmcs variants
> that also adopted this macro?

Yes, I should have explicitly called this out. This replaces the
apparently thread-safe push/pop sequence with reusing the GPR switching
logic in SVM, which isn't thread-safe at all (uses a global array).

However this is still an improvement imo because:
- The logic here is half-baked and prompts the UCALL clobber hack as it
  doesn't properly save/restore everything. Reusing the GPR switching
  logic used by SVM allows us to drop that hack.

- It's more likely (imo) that we hit a problem due to the half-baked
  GPR save/restore logic than thread-safety. This is evidently true by
  the fact that the stress test added in this series fails on VMX with
  the existing push/pop sequence. OTOH, no tests are failing on SVM due
  to lack of thread-safety. There is only one test that uses more than
  one vCPU with nested anyway (the memstress test).

I think the logical next step is to move the GPR array to be per-vCPU,
making it thread-safe for both VMX and SVM in a proper way, but this is
outside the scope of this series.

> 
> >  			     "incq (%%rsp);"
> > -			     "1: pop %%rax;"
> > -			     "pop %%rdi;"
> > -			     "pop %%rsi;"
> > -			     "pop %%rdx;"
> > -			     "pop %%rcx;"
> > -			     "pop %%rbp;"
> > +			     "1: ;"
> > +			     VMX_SWITCH_GPRS_ASM
> > +			     "pop %%rax;"
> >  			     : [ret]"=&a"(ret)
> >  			     : [host_rsp]"r"((u64)HOST_RSP),
> >  			       [host_rip]"r"((u64)HOST_RIP)
> > -			     : "memory", "cc", "rbx", "r8", "r9", "r10",
> > -			       "r11", "r12", "r13", "r14", "r15");
> > +			     : "memory", "cc");
> >  	return ret;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260629183746.699840-1-yosry@kernel.org?part=5
