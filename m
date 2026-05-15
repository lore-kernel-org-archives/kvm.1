Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2E387378;
	Fri, 15 May 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827585; cv=none; b=bcfnmvDTFUMspQVmPNlHOd/WWVW+OyW094uStE5hSC5Nh12819+LthPVsKJWYWOttAzQkPFhTdscUTAGDq8ZyXKUMDKWvG3MouPorh7Rc46uFGY0sQzhFyQOyb30X+Q7XvNMYrP/V0KVjl9nG8snG3uwkleIg6l6xhGwGBC+g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827585; c=relaxed/simple;
	bh=EDy7WM2EPZMdkVajN/C+7NtSFN1OXHBuRnNXGvFYtfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPftFE8f8jd1Fe5J7cba/bjO4ztMr8JGymGlvGVLvMafyz3u+TIiOVkqB+7NnWbQZWp7dOpB1jrQhXld3gNnVWuct1bkRWoH/eVp/w2eCr8spdHj83OQ0PdNFP8rzOEwLtCD5F6kNE/uPffkaXxIHPAsryAX0t0kF5Hhupz2fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfJzE7cC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfJzE7cC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778827583; x=1810363583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EDy7WM2EPZMdkVajN/C+7NtSFN1OXHBuRnNXGvFYtfg=;
  b=gfJzE7cCzcPaEB7bhBD9lUAaXBFa7WcNmmwTi4rW/iHtjKbXaNp3MNTX
   c5leWdmXB/krgG/delfg8cv0U5OMSxlY4cRrbRxqdPkhhVYWurKM9fpmS
   Fc8iREqh+X+n+hcoYcnsLcc+GGjfkWe2U0bLB0tF+HvElDzLdAdT8UT6L
   /sO6Ju+2g1vqgzd+3w4RIsUe4tazbA4Hh4VK5m2lpEH5tpkJgviYAGQLa
   VJWmSVwpLpqrYh5fpjFG5qm3V1DmxjYoIsUP9ISG+xinb1TzMWkYsAfw/
   y9uW8SEZsSyaw3duk6DyYzlQYxcZS/cV3cKBlKCHxmvN/5ihQ5+8X+gmf
   A==;
X-CSE-ConnectionGUID: AZGnF0JWShGjfUc9noCcgA==
X-CSE-MsgGUID: N+NRhVC0SKKXneyQv8F7gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79674105"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79674105"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:46:23 -0700
X-CSE-ConnectionGUID: 234uUvIkTV+YfgBeTmh5FQ==
X-CSE-MsgGUID: e/SZAEWjRwmj6Pi0YKa5PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="232219352"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:46:20 -0700
Message-ID: <90011488-83ba-4aa5-a753-28fa5fd4024d@linux.intel.com>
Date: Fri, 15 May 2026 14:46:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] KVM: x86/xen: Bug the VM if 32-bit KVM observes
 a 64-bit mode hypercall
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-3-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Bug the VM if 32-bit KVM attempts to handle a 64-bit hypercall, primarily
> so that a future change to set "input" in mode-specific code doesn't
> trigger a false positive warn=>error:
> 
>   arch/x86/kvm/xen.c:1687:6: error: variable 'input' is used uninitialized
>                                     whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>    1687 |         if (!longmode) {
>         |             ^~~~~~~~~
>   arch/x86/kvm/xen.c:1708:31: note: uninitialized use occurs here
>    1708 |         trace_kvm_xen_hypercall(cpl, input, params[0], params[1], params[2],
>         |                                      ^~~~~
>   x86/kvm/xen.c:1687:2: note: remove the 'if' if its condition is always true
>    1687 |         if (!longmode) {
>         |         ^~~~~~~~~~~~~~
>   arch/x86/kvm/xen.c:1677:11: note: initialize the variable 'input' to silence this warning
>    1677 |         u64 input, params[6], r = -ENOSYS;
>         |                  ^
>   1 error generated.
> 
> Note, params[] also has the same flaw, but -Wsometimes-uninitialized
> doesn't seem to be enforced for arrays, presumably because it's difficult
> to avoid false positives on specific entries.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/kvm/xen.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 91fd3673c09a..6d9be74bb673 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1694,16 +1694,19 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>  		params[4] = (u32)kvm_rdi_read(vcpu);
>  		params[5] = (u32)kvm_rbp_read(vcpu);
>  	}
> -#ifdef CONFIG_X86_64
>  	else {
> +#ifdef CONFIG_X86_64
>  		params[0] = (u64)kvm_rdi_read(vcpu);
>  		params[1] = (u64)kvm_rsi_read(vcpu);
>  		params[2] = (u64)kvm_rdx_read(vcpu);
>  		params[3] = (u64)kvm_r10_read(vcpu);
>  		params[4] = (u64)kvm_r8_read(vcpu);
>  		params[5] = (u64)kvm_r9_read(vcpu);
> -	}
> +#else
> +		KVM_BUG_ON(1, vcpu->kvm);
> +		return -EIO;
>  #endif
> +	}
>  	cpl = kvm_x86_call(get_cpl)(vcpu);
>  	trace_kvm_xen_hypercall(cpl, input, params[0], params[1], params[2],
>  				params[3], params[4], params[5]);

