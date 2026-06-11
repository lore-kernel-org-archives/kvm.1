Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112134EF1F
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188998; cv=none; b=ZNjh8Hyyd6p/dKeYfT4fderokjHtSrK+HUoJExm3146OVaDsdEjbqS0ajezep7ZfkGavQd73qLSWwRBs1R+KnINKkISnpSPAA7QaRKmq4FTXTnYpp3DYjdBlwu6O9GRImwYuKIUIHMc1aHBUOWzvnbMjTqYASCMpbT4OM1ogIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188998; c=relaxed/simple;
	bh=bRofaJRsnksH8cATrOOkcwxqID3f5J5np/Wz2r+wzaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxlEzJu4Ev1080mtybwFN5UeTHsL/wHg2JIbUz2X/vhI4ItIVrJleG7Duu7p7yYpjgiw+Q73GCi3JBug7ovqJOhh+CUH9wK8qKQf+zG3W4QVemnTw2EiibuDeYUPeXe4yzDhiE1+mFKtBcKJNwbIeKWPDf4lvO+vSyooWDbjCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C42341C1C3A;
	Thu, 11 Jun 2026 16:43:13 +0200 (CEST)
Date: Thu, 11 Jun 2026 16:43:12 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH 3/4] kvm: svm: Support guest-provided VMSA for launching
Message-ID: <airHPsVxHlAsUiFc@8bytes.org>
References: <20260611123528.572255-4-joro@8bytes.org>
 <20260611130537.216371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611130537.216371F00893@smtp.kernel.org>

On Thu, Jun 11, 2026 at 01:05:36PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Critical]
> This is a pre-existing issue, but can unprivileged userspace panic the host
> kernel by punching a hole in the guest_memfd file backing the guest-provided
> VMSA pages?
> 
> Guest-provided VMSA pages are placed into the VMSA (Firmware) RMP state.
> However, KVM drops its page reference immediately after lookup:
> 
> arch/x86/kvm/svm/sev.c:sev_es_vmsa_pa() {
>     ...
>     kvm_release_page_clean(page);
>     ...
> }

There is at least not a reference counting issue here, as GMEM still holds a
reference to the page.

> If userspace triggers a page release, the page is freed by the core MM
> subsystem. During freeing, sev_gmem_invalidate() attempts to transition the
> page via rmp_make_shared(), which architecturally fails on VMSA-state pages:

Not sure about that, I havn't checked whether GMEM allows these kinds of
page-state changes before LAUNCH_FINISH. After LAUNCH_FINISH it is not problem
anymore because VMSA address in the VMCB does not point to a valid VMSA page,
then VMRUN will fail.

> [Severity: High]
> This is a pre-existing issue, but does KVM permanently leak successfully 
> launched SNP VM VMSA pages during VM teardown?
> 
> During normal teardown of an SNP guest, KVM attempts to transition its
> allocated VMSA pages to shared state via kvm_rmp_make_shared():
> 
> arch/x86/kvm/svm/sev.c:sev_es_vcpu_free_vmsa() {
>     ...
>     if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K)) {
>         pr_err("Failed to make VMSA page shared - leaking it to avoid re-use\n");
>         goto out;
>     }
>     ...
> }
> 
> kvm_rmp_make_shared() uses the RMPUPDATE instruction, which architecturally
> fails on pages that are in the VMSA state. The function detects the failure,
> logs the error, and permanently leaks the page. Because VMs are destroyed
> routinely, this will eventually exhaust host memory. KVM must use
> snp_page_reclaim() instead of kvm_rmp_make_shared() for pages in the VMSA
> state.

Wrong, VMSA pages are freed when they are KVM owned, when they are guest owned
they are freed via gmem. This is all fine if it happens after LAUNCH_FINISH and
no VCPU of the VM is still running.

> [Severity: High]
> Does this code call sev_es_vmsa_pa() without holding kvm->srcu or 
> kvm->slots_lock?
> 
> Looking at the execution path immediately following this comment in 
> snp_launch_update_vmsa():
> 
>         /* VMSA encrypted - put it into the VMCB */
>         svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(vcpu);
> 
> arch/x86/kvm/svm/sev.c:sev_es_vmsa_pa() {
>     ...
>     slot = gfn_to_memslot(vcpu->kvm, gfn);
>     ...
> }
> 
> gfn_to_memslot() dereferences the KVM memslots array. Since this is called 
> without SRCU or slots_lock, a concurrent thread executing 
> KVM_SET_USER_MEMORY_REGION can swap and free the memslots array while 
> gfn_to_memslot() is accessing it, leading to a use-after-free.

Not sure if this is an issue. If it is then it is pre-existing. I think the
worst that can happen is a failed VMRUN because the VMSAs become invalid, no?

-Joerg
