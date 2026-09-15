Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6B390C9E;
	Tue, 15 Sep 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471848; cv=none; b=utPHLQR3LLq5yIP/v/ZJoXwshSEURCOFpVY1bovCBK6RcityVrmCOngfPOibPi7sBa/C6Srx5wiY5Xg3TCfXdyv3N08AXKg1YsIeV5kWtYMXA0T2/bvDgXrgLnYXigVDiHsFmYp0gMeb3KzZLqpFLhUDkI+VR+5dLDmv/lHTR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471848; c=relaxed/simple;
	bh=odVPNm+7LRHp0tjKuPnp4sfEi1fdkqz/WFeeAWo6QFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeW9ZZAzP4bC1O7cEf+b6GEwn6NlkNd/hDJGI5XBWERlf5er0YmIZyywF8QIJzx0+lxei5AOoxicSt8wllxAfo/Mi1cZMBGSPP3w4rCf5TsP7BRNbptxfOZUGROjIMqBD/6Bs8XosE5qtaZ3aj5XZs96NiKjkBPHcc0rJADR+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgHCyQAl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgHCyQAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789471846; x=1821007846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=odVPNm+7LRHp0tjKuPnp4sfEi1fdkqz/WFeeAWo6QFA=;
  b=jgHCyQAlFd1IU9RO337FWJ/aIZIL1T92wdb5MGeVEEBjnHEcpa381rG8
   eBTyPiL3i6KidPS4IQI9MRL8T6I6Gx74yOPN7OLZsSgfhwmzbOL1E6mTK
   pF+0YafUzr6swhjCVA9mNEAlnhk9HUHTZvogTue6Ggb3nyxfn4fN+YBFN
   GshiPEr6+BVI64iklwU+7kK4aMjKSJZkRx5IV4FGPCngGevo2oA/6qakB
   AD0tYH839L80Qw03RzhNEdx9zrqkpu/v6WYYj5vbRRb0bDoH8Uo5eNMfB
   EznSjpPqDfSaSefzlATMxtidycSL7ky9FopJGhqRHYtEauHNCA4qDALf/
   Q==;
X-CSE-ConnectionGUID: 6i3y18k2RPK5hlGN1nLxAQ==
X-CSE-MsgGUID: Bs9oq7zsR0SBmqPiWAan5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100495589"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100495589"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 04:30:45 -0700
X-CSE-ConnectionGUID: qWT5UoJmQryOQlPvSltQgg==
X-CSE-MsgGUID: EEBG6GS1QbCdK3y/0gtbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270348266"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.253])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 04:30:40 -0700
Date: Tue, 15 Sep 2026 14:30:36 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev
Subject: Re: [PATCH v2 6/8] KVM: SEV: Add SNP vCPU state get and set commands
Message-ID: <aqksXLLcmFDkM9Xj@tlindgre-MOBL1>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-7-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908103338.427254-7-joro@8bytes.org>

On Tue, Sep 08, 2026 at 12:33:36PM +0200, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
...
> +static int snp_get_vcpu_state(struct kvm_vcpu *vcpu,
> +			      struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sev_snp_vcpu_state state = {};
> +
> +	if (!is_sev_snp_guest(vcpu))
> +		return -ENOTTY;
> +	if (!to_kvm_sev_info(kvm)->snp_context)
> +		return -EINVAL;
> +
> +	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +
> +	if (VALID_PAGE(svm->sev_es.snp_guest_vmsa_gpa) &&
> +	    VALID_PAGE(svm->vmcb->control.vmsa_pa)) {
> +		state.vmsa_gpa = svm->sev_es.snp_guest_vmsa_gpa;
> +		state.valid_fields |= KVM_SEV_SNP_VCPU_STATE_VMSA_VALID;
> +	}
> +
> +	if (VALID_PAGE(svm->vmcb->control.ghcb_gpa)) {
> +		state.ghcb_gpa = svm->vmcb->control.ghcb_gpa;
> +		state.valid_fields |= KVM_SEV_SNP_VCPU_STATE_GHCB_VALID;
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(argp->data), &state, sizeof(state)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int snp_set_vcpu_state(struct kvm_vcpu *vcpu,
> +			      struct kvm_sev_cmd *argp)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
> +	struct kvm_sev_snp_vcpu_state state;
> +	int ret;
> +
> +	if (!is_sev_snp_guest(vcpu))
> +		return -ENOTTY;
> +	if (!sev->snp_direct_vmsa)
> +		return -EINVAL;
> +	if (!sev->snp_context || kvm->arch.pre_fault_allowed)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&state, u64_to_user_ptr(argp->data), sizeof(state)))
> +		return -EFAULT;
> +
> +	if (memchr_inv(state.pad, 0, sizeof(state.pad)) ||
> +	    state.valid_fields & ~(KVM_SEV_SNP_VCPU_STATE_VMSA_VALID |
> +				   KVM_SEV_SNP_VCPU_STATE_GHCB_VALID))
> +		return -EINVAL;
> +
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
> +		if (!PAGE_ALIGNED(state.vmsa_gpa) ||
> +		    !page_address_valid(vcpu, state.vmsa_gpa) ||
> +		    IS_ALIGNED(state.vmsa_gpa, PMD_SIZE))
> +			return -EINVAL;
> +	}
> +
> +	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
> +
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_VMSA_VALID) {
> +		ret = sev_snp_install_guest_vmsa(svm, state.vmsa_gpa);
> +		if (ret)
> +			return ret;
> +	} else {
> +		svm->sev_es.snp_has_guest_vmsa = true;
> +		svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
> +		svm->vmcb->control.vmsa_pa = INVALID_PAGE;
> +	}
> +
> +	if (state.valid_fields & KVM_SEV_SNP_VCPU_STATE_GHCB_VALID)
> +		svm->vmcb->control.ghcb_gpa = state.ghcb_gpa;
> +	else
> +		svm->vmcb->control.ghcb_gpa = INVALID_PAGE;
> +
> +	vmcb_mark_all_dirty(svm->vmcb);
> +	return 0;
> +}
> +

Nice, looks like snp_get/set_vcpu_state() could quite easily make use
of KVM_EXPORT/IMPORT_VCPU?
