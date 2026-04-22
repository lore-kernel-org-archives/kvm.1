Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465F30EF90
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846143; cv=none; b=Mv03EhBU3+XX1iqq0nNCBjWMJPw3dzPH+NbYLA02tFcMV8Jq/qiP9TQ13cZyf+2vttrsjNgeTeYn2CR0TmCrE44JRb0Rg1OPGJF0sxVajaefpMwY5yw3Kw6pVcXjBMc2ulmt0nQ4dqH3z5bK2AR+mLXWJ1tPGH6wFwMTQgjDu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846143; c=relaxed/simple;
	bh=ruje3/k5RBG06rfLX6Wgxo/Cy3wjS358mjBMDyw4j8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6QKtniq0oHM73j2DwGtzHCqTSlnqtUsvAMJ7rclENfK1RPtBPiTjAPLQR8zAyQUQpyG+E0gVhV4MRFNpFFHdR81AY2cQ7upnuTc9WMaOUajqefAIMsGtVCwmi89mKP4ICKmPNx3V7NK0XDOTlMJu1w5KKDgAn1EGIhfp1HBScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/7K19b8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/7K19b8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776846141; x=1808382141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ruje3/k5RBG06rfLX6Wgxo/Cy3wjS358mjBMDyw4j8A=;
  b=Y/7K19b8j8hbzRPKPlJUwFGCQRxRoSlOQ6lBvs4fTOcbxwBqA0Kfe56O
   O3vaRH49kG+clpPVCpPpag40TmMMpy62Rl9Te9+PTczNRjDd2PEvVYkJG
   QsR4bRA/UC1IYjtzHzLcf1VBzG/Q+KfJzvIyh8sojixNuw3aeI4vHND8X
   cGRZayLme1jvA2aW+DCqj1OlN2iHR5HLifGr5yEZsyCMMzkmpTQxnTI1N
   sJN1KASi0MVtDZIHPur9T1xMHWx2vi9HT2fmo9WycS5Pn+qt5iwnQCz7g
   UseDoSyd9bQLm3Ks0EH3vfA1r0RRavTCoXe0CXXN6hJQbndxnPPw3dGJL
   g==;
X-CSE-ConnectionGUID: jMZoqjTVTfiP91d2IotbkQ==
X-CSE-MsgGUID: LFhhamTHQeOiXjuFF27DSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="88869232"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="88869232"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:22:21 -0700
X-CSE-ConnectionGUID: IN+Nqc7MTAesuHwEJMk1gw==
X-CSE-MsgGUID: MUcuXCf0Tt6HSYaFH64Bcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232156751"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:22:20 -0700
Message-ID: <1931c7d3-b21e-4704-9012-4a16597bbebf@linux.intel.com>
Date: Wed, 22 Apr 2026 16:22:16 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 21/27] KVM: x86: Make kvm_vcpu_after_set_cpuid()
 return an error code
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-22-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-22-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]
[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=21

[...]
> @@ -649,7 +651,9 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  #ifdef CONFIG_KVM_XEN
>  	vcpu->arch.xen.cpuid = kvm_get_hypervisor_cpuid(vcpu, XEN_SIGNATURE);
>  #endif
> -	kvm_vcpu_after_set_cpuid(vcpu);
> +	r = kvm_vcpu_after_set_cpuid(vcpu);
> +	if (r)
> +		goto err;
>  
>  success:
>  	kvfree(e2);

"Is vcpu->arch.xen.cpuid successfully restored when kvm_vcpu_after_set_cpuid()
fails?
Looking at the error path in kvm_set_cpuid():
err:
	memcpy(vcpu->arch.cpu_caps, vcpu_caps, sizeof(vcpu_caps));
	swap(vcpu->arch.cpuid_entries, e2);
	swap(vcpu->arch.cpuid_nent, nent);
	return r;
}
We restore cpuid_entries, cpuid_nent, and cpu_caps, but it does not look like
vcpu->arch.xen.cpuid is reverted back to its original state.
Could this leave xen.cpuid permanently out-of-sync with the restored CPUID
entries if an invalid configuration is rejected?"

This is a valid concern.

It is simple to snapshot the value of vcpu->arch.xen.cpuid and restore it if
the check fails. And after a further check, kvm_hv_vcpu_init() is also called
before CPUID paranoid check. If hv_vcpu is already allocated, nothing changed
in kvm_hv_vcpu_init(). If hv_vcpu has not been allocated, the memory allocated
in kvm_hv_vcpu_init() needs to be freed if the check fails.
 
Another option is to split paranoid CPUID verification out. As described as an
open in the cover letter, this patch series combines vCPU capability initialization
and paranoid CPUID verification inside kvm_vcpu_after_set_cpuid(). The issue is
gone if the paranoid CPUID verification is done before these changes are made, though
there will be some duplications during paranoid CPUID verification and vCPU
capability initialization.




