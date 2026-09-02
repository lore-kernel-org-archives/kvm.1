Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CD4A0EF1
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357017; cv=none; b=C6sgR3ePW3A3QQTfIYXW292cTVakzoJFAx+8l40UsXR8ZHuy6RL+7UuMSHMHhfs8K1gt4MohQEPGBXGlyuyq4JNf1oglCutKr+Rt8G92Mx2FdGWrvURo4hnMkA24NFsW72zk+5e9m3SlRhGgBfJ+BDqETmLotncVRYO5kTc8bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357017; c=relaxed/simple;
	bh=lVBUy29Lovq/9lF9JYxhU0RPMbu/BbWRh8ol8JCIQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzoCLBBb/t6RB08M9Sj/aPvQcq1B5qEVDLDN4CY21IwJ8m79NI66clWYWZlActBh4xbrxGTz+GD7xTediUt3nYop6OYUbuM4mQgg9uU6BJoiP7bebI8Sp3AjUgCbCPOAUolKX/3FNjqy8bGYxutvHiWlHVjtHw4b7hhWd1+qXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjkCfPwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjkCfPwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4497D1F000E9;
	Wed,  2 Sep 2026 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357016;
	bh=aU8HCTs3+Q0nCMoVjkIUPDsB0SP7yghfDt3ozZSSOyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjkCfPwlbdjfzMauVdPJjHWPVqmNitVIHtnp1iVygZWIJJcIL7yVwXnqFSxV6J9as
	 B+PPw4ddaf//EnV+WlIc3EPalQGv2LGvblbh9aBcO0OtnT5mdtxo6b6rtyZTMRHTw+
	 p4gaoPyXJgKpEWHGH3eiV0YZn7Hvg1rA8cvUq3tv9husiJRO+fTxlXj+vRGpdevSEB
	 2MeuY9arZukyI6bgwx8lQQIS3/ev9WkTsohToNgUMcZtFB7khGvhV0+qkwhdFZqg2y
	 cCRPIafITkCQTvgSu5Y8njc31uYzq1MtoVyv2z3jnayZacuN0s8rOGGkekWX604RcU
	 O/zPpzcoFn8ig==
Date: Wed, 2 Sep 2026 19:13:46 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jean-Christophe Guillain <jean-christophe@guillain.net>, 
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in vmx.c
Message-ID: <apgj5l7DZGsScsNc@blrnaveerao1>
References: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
 <apIf7eoMxdfV_7kE@google.com>
 <apYh4GDHD3Tdb8t4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apYh4GDHD3Tdb8t4@google.com>

On Mon, Aug 31, 2026 at 05:52:48PM -0700, Sean Christopherson wrote:
> On Fri, Aug 28, 2026, Sean Christopherson wrote:
> > On Thu, Aug 27, 2026, Jean-Christophe Guillain wrote:
> 
> So, rather than trying to come up with a scheme that is performant without being
> too complex, I'm planning on fixing this by simply holding kvm->lock for the entire
> duration of vCPU creation, so that KVM doesn't need to do extra tracking and can
> instead rely purely on the array of online vCPUs.  Then we can revert 97d65b544f48
> and do more cleanups on top.

I was going to report the below lockdep splat I am seeing when trying to 
enable Secure TSC due to commit ba903f738249 ("KVM: SEV: Assert that 
kvm->lock is held when querying SEV+ support"). I believe this will also 
be addressed if we continue to hold kvm->lock during vCPU creation:

  WARNING: arch/x86/kvm/svm/sev.c:136 at sev_snp_guest+0xb2/0xc0 [kvm_amd], CPU#170: CPU 0/KVM/5532
  ...
  Call Trace:
   <TASK>
   snp_is_secure_tsc_enabled+0x1a/0x40 [kvm_amd]
   sev_vcpu_create+0x77/0xc0 [kvm_amd]
   svm_vcpu_create+0x5f/0x160 [kvm_amd]
   kvm_arch_vcpu_create+0x234/0x2f0 [kvm]
   kvm_vm_ioctl+0x232/0x1c10 [kvm]
   ? __lock_acquire+0x465/0x1b10
   ? lock_acquire+0xbf/0x2f0
   ? __fget_files+0x2b/0x190
   ? find_held_lock+0x2b/0x80
   __x64_sys_ioctl+0x97/0xe0
   do_syscall_64+0xf3/0x880
   ? exc_page_fault+0x128/0x270
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


- Naveen

