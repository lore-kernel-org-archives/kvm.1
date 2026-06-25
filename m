Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CA361DB8;
	Thu, 25 Jun 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368929; cv=none; b=o3MnB7oHBjxUe1GzV9rMfp/VnKoKF4puZONHHNj5Buv8ZUvp5ZYEFjtWjruhRUhZHPTMRHvrhWEm4FWmtPlD+EYPn5LlKSwZhgngfNVN2P+f8RgdmcYJvNW0LTAwt3s5pYTKAKe/i/Gk5iziWKiUfYNDzl8PXZHxFCj3c6Wt87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368929; c=relaxed/simple;
	bh=6wg23TjWncPjLAjTDzCi/AKSejVqmCI1OjE0MKYHtN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYeE1MuE7/oW8+q7bnrN9rLKiaXC22mmKyOcRI7ESt85i0ZESCdh8JgBYZq1dSQL1vZj9xTQ5+Gcx4T+MuXNWsRBQZxPt3lOczRA2qMxZXzV5zzFEm6hN+7Z4FpmwSvjgFHMQaUiNr7ecplqPOpIRtfy4r4hNnJJlry89qGOM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJw19+aX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJw19+aX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782368927; x=1813904927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wg23TjWncPjLAjTDzCi/AKSejVqmCI1OjE0MKYHtN8=;
  b=WJw19+aXzzzN61zv4NCemxNekmFBzoApy5cyaI/vUFWNwYu8C/C01WuF
   BR8kN9XpSNfEDwvs2zuOWTC2nEdKSFMMAJEfkUPxXvP05enQNMf7RD0v/
   SS34inbJrRPK/aTGX2vpvUl7q3b+i2qC2MfeepKvfZGp0RcLR6sxJ10VB
   9lyEZ0loVeauvpa3W/QTN/oZfKA5ITpEgXJpVIGSZvRvr0w5IWyoGsKMT
   tBWEO6hvPteUCDNVxgsHagUhs/YtkdnZQNRauEcK41PPNyyDvD1CPXVNc
   8I+Kzcz1i0GiGsdwaqiocbxCsRZMmzEFuq9NlJW+H8DvHVjBDfc5V03hu
   Q==;
X-CSE-ConnectionGUID: eAKh1lNtSJChtwjdV/axEg==
X-CSE-MsgGUID: LVxBPwlqRTKFDDDJKigDJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83144928"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83144928"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:28:47 -0700
X-CSE-ConnectionGUID: RLioKOoVT0y1+0PDAGf2+A==
X-CSE-MsgGUID: 4AudWYIbQFGvuhY7Wsl+pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="255306715"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:28:42 -0700
Date: Thu, 25 Jun 2026 09:28:39 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 17/17] KVM: TDX: Support event-notify interrupts only
 with userspace Quoting
Message-ID: <ajzKl4Ov0jdXvH-o@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-18-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-18-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:55PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -202,8 +202,15 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
>  
>  	caps->cpuid.nent = td_conf->num_cpuid_config;
>  
> -	caps->user_tdvmcallinfo_1_r11 =
> -		TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
> +	/*
> +	 * Don't advertise userspace event-notify interrupt support if TDX
> +	 * quoting service is enabled, as quote generation will be handled
> +	 * entirely in the kernel. Support in the kernel can be added later.
> +	 */
> +	if (!tdx_quote_enabled()) {
> +		caps->user_tdvmcallinfo_1_r11 |=
> +			TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
> +	}

Can you use kvm_tdx->get_quote_in_kernel also above? Or should it maybe
be initialized here if not used earlier?
  
> @@ -1684,9 +1691,16 @@ static int tdx_get_quote(struct kvm_vcpu *vcpu)
>  
>  static int tdx_setup_event_notify_interrupt(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
>  	struct vcpu_tdx *tdx = to_tdx(vcpu);
>  	u64 vector = tdx->vp_enter_args.r12;
>  
> +	/* See comment in init_kvm_tdx_caps() */
> +	if (kvm_tdx->get_quote_in_kernel) {
> +		tdvmcall_set_return_code(vcpu, TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED);
> +		return 1;
> +	}
> +

Since you're using kvm_tdx->get_quote_in_kernel here.
