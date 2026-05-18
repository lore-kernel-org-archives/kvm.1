Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680034F474
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124340; cv=none; b=QfKzfeLLN7e2Vch1QcLYwOZKgpV1B81XKDaBvrYK2nn0SZENuqmPodASdQzsLy3vvlR8FCp/X8E6t2tlb8iX8LLYolG4fTfeKeJL123bDymbRBGZTBT9ZDGKm+bd1fqJAt6ySekT8sAe2zvVZxjZN+rwJbLb8rXJJtW9NQQC3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124340; c=relaxed/simple;
	bh=ZOxKJLxKUpeL9u1y4xkPTqn/hUnXscJQPz2tar+n/N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clPdqGD68Aj5essBjacIBMYnOSUJy7v8b+2+R5Vd3vfIAlsOMSsHkJQtpHoMm2jkqkrrl0zuhNqRGEzQ8TkGwfvzCVqiD108xxIEPDdWVfMDcpuVgh5l83QcnnBcqBWBv/f8Fub5Xx31nl9pNxC2tQgXyhPm0LaMSpHEtUHOa28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3JmYA8L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3JmYA8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9329C2BCB7;
	Mon, 18 May 2026 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779124340;
	bh=ZOxKJLxKUpeL9u1y4xkPTqn/hUnXscJQPz2tar+n/N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3JmYA8LhijkpSRepRe88cGcEZP1misdzIJi3MvYlCPGm76Bugl2WRrVyINYQrksg
	 tFgVyY4RjCLY0EuXJjWC2hKPY56QPfJFZ9XeSdq2ZIUL+aSkgtQEvtadqAcYiFXijl
	 zG3X7kKwptN5jH1O0araRD3hEO8KTzsAWuEZXBUDdN0Tqn1o1fG0d7rtv2v2m52kl0
	 KRofd2lkLaZl4fvlNYi+VSNWVubewC3iQln9i+SQVO3+fVcqh+GUKwg79ILsnOn1O8
	 3mQBJTCnkncW16BCTlfB3n1lkl6+5evJEWSQXiHG+L7BhL96BaMY+h9HFDUbm+8zOb
	 1L+6a9markAPQ==
Date: Mon, 18 May 2026 17:12:18 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, kai.huang@intel.com
Subject: Re: [PATCH v7 7/7] KVM: SVM: Add Page modification logging support
Message-ID: <agtGh82vLu4G6pWI@google.com>
References: <20260518045916.2988667-1-nikunj@amd.com>
 <20260518045916.2988667-8-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518045916.2988667-8-nikunj@amd.com>

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 4ef9bc6a553f3..dd30aef9fc497 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -882,6 +882,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
>  	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
>  	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
>  
> +	/* Clear PML fields to avoid stale data in vmcb02. */
> +	if (pml) {
> +		vmcb02->control.pml_addr = 0;
> +		vmcb02->control.pml_index = -1;
> +	}

I think the comment here is misleading. vmcb02 is allocated with
__GFP_ZERO, and IIUC pml_index should not matter when pml_addr is zero.
This is strictly for hardening as far as I can tell, especially looking
at commit c3bb9a20834f ("KVM: nVMX: Disable PML in hardware when running
L2"), which introduced something similar for VMX.

So maybe something like:
	/*
	 * PML is never enabled in hardware for L2. Make sure that an
	 * unexpected PML write would trigger a PML_FULL VM-Exit.
	 */

Also, the above commit also hanlded a PML_FULL VM-Exit as unexpected,
maybe we want to do that here as well? Or is that too paranoid?

Annoyingly, the unexpected exit reason handling is in
svm_invoke_exit_handler(), but the guest mode check is in
svm_handle_exit(), so if we do that we may need to move some code
around.
