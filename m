Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9937F01B;
	Thu, 24 Sep 2026 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213960; cv=none; b=mGT+cEVgHDUHrddi2bvRhn1blcwSiBocaNb/vcSJA2uSuvauqWL1pkx7PIrccEtcz2IihOegBEo7Ql/8IlvT8bFPHIqMEFER3JMAEZgAG5+Cix8kN2akwE5i2DKVYRMJvnZUuDhWclZA24BmTSMIACV29S0GGVKOxzUZVcK0L34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213960; c=relaxed/simple;
	bh=bLkM/XyEq3k8XX/D1d7iNRQQqrzpEh/3KJEhzHgsBag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHn9F69nLuDDISwwiHIvrMQGnpRgPi3Er1pV62qNGwv3N5HkAlJ7jx8jncDIEyC0TweTAatv3Ap6PNjNXnzUaL1hEg/kY/9S443cN665+DaaHRgYYwSRzAsWsT7PM3UOL1ibaczu0xDz2HRxUoWS37BCVsodiz0Wh2OBZQBCg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkZJhtAm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkZJhtAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790213957; x=1821749957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bLkM/XyEq3k8XX/D1d7iNRQQqrzpEh/3KJEhzHgsBag=;
  b=HkZJhtAmaIviJyqR4QlCTJYfCcKdv25bAh2mpclUIE5VSoddLtRjRPby
   lqeO2Gj+xC+DQ1Cf1zjA8onD6Llq0RlO1dlR/qGWU1wQ1iwbq6pK1To7a
   6Ezs9/q49WWHmBc3bzJTIKYAIe3GMmp3NLOI7eZ8hfjQtqOouSdwNvNw7
   CqXO7kcT69wcB/liOeF9Ep+YsoOY9e41xpAA08xYPpyzWhZnIFPXihh7G
   byj8F01QQtMNRWxpqMLqXAFV4lCikHVaTQEHMMu8dTi2pdDDJ4UOQAIkc
   MkbfhVK/0Tsry+xqFwmt0jyOoP0qseDDgClv+Ak/1RoAlEpc0n+/gZl/J
   Q==;
X-CSE-ConnectionGUID: cJMfQJKRQhis900sZXDWvA==
X-CSE-MsgGUID: Kgv4HsUMRXOr5RF2oLOSmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101625247"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="101625247"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 18:39:15 -0700
X-CSE-ConnectionGUID: TybbJKOuTNqF/lsGNDMwuQ==
X-CSE-MsgGUID: Bgfgx4ltREOMuDJ9KoFRTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="281950209"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 18:39:12 -0700
Message-ID: <50ccc54c-6cbb-4ae2-a84a-4dcbc958f91c@intel.com>
Date: Thu, 24 Sep 2026 09:39:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 James Houghton <jthoughton@google.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ackerley Tng
 <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>
References: <20260923163315.1580860-1-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260923163315.1580860-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/2026 12:33 AM, Sean Christopherson wrote:
> Synthesize a triple fault, i.e. exit to userspace with KVM_EXIT_SHUTDOWN,
> instead of returning -EIO from KVM_RUN if KVM encounters an EPT Violation
> due to a guest access to a pending page.  Returning -EIO implies KVM is
> buggy, and most VMMs will respond by completely terminating the VM, versus
> rebooting the VM in response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the
> option of trying to keep the VM (from the end user's perspective) alive.

But reboot isn't good, neither.

I still think a new specific exit reason[1] would be better, as I suggested before.

[1] https://lore.kernel.org/kvm/1b0ea352-c645-461b-9e19-5202791f8e2d@intel.com/

> Ideally, KVM would probably exit with KVM_EXIT_MEMORY_FAULT, but KVM would
> need to extend run->memory_fault so that userspace knows the fault can't be
> handled.  This scenario specifically occurs when the guest has deliberately
> disabled #VEs on unaccepted memory for security purposes, i.e. the guest
> literally disabled the mechanism that tells it it screwed up.  But, because
> this is fatal, and the whole point is to NOT try to fixup the fault,
> jumping through hoops to return MEMORY_FAULT instead of SHUTDOWN doesn't
> make a whole lot of sense.
> 
> Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> Cc: stable@vger.kernel.org
> Cc: James Houghton <jthoughton@google.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> Compile tested only.
> 
>  arch/x86/kvm/vmx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 7173ef3fc398..eb82f739a7c0 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1938,8 +1938,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
>  			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
>  				gpa, vcpu->vcpu_id);
> -			kvm_vm_dead(vcpu->kvm);
> -			return -EIO;
> +			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> +			return 1;
>  		}
>  		/*
>  		 * Always treat SEPT violations as write faults.  Ignore the
> 
> base-commit: 30b5175943e709911702d8a9364145e911f57e3f

