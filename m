Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962A3EFFB5;
	Tue,  9 Jun 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996920; cv=none; b=Bn/FNAQ2eWCWDur9kZj/l26PMGXzgOY9IqAYxBZvVEZB05OPpVZ0fzFfgPJEoQdSnGDP44TW14nlm1dogClA2UQ/tUkdlOJt5D8NobzqhCOlhmEevNanTQTNQhOu4PH1Ggsnh9IgBJfyvhEdEz10aSa4sPsk5oUAishzsN4wYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996920; c=relaxed/simple;
	bh=VHm52sKD+VDklY3E1DSqUA75nSR6RP3jQmR1IrunSK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dr64Z53YdVlM98j4JUC/YQXMYYsWvMFaf4ABCnN8Zliihtaclo9vr3sLqIGL6CzWhi7L2gL4T0GVfUxOGGNUuNy2gOOFR01sePhw/QDtrPR8Six/YnnQLSblXaVTOcfdt8v4w5VaAN4U04EDThSMY5RRLP/kcyjPoTM27s//xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjK7RioY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjK7RioY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780996917; x=1812532917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VHm52sKD+VDklY3E1DSqUA75nSR6RP3jQmR1IrunSK0=;
  b=fjK7RioYlyVt6R3ja+O3Qv9aS67zm5GptYVJIOll6MfPyps8PadMQyLt
   MIIpiVWtXVRcmSX6CG3vzhODs7fYYAAUJkWDEFiJbx6tRX15oArX5l2hf
   I1ti9MGx2YGYijGYZK20I9NKPFNZzYm8hVIV6CMqXhdEGOlQbEXqjj8n1
   MvaHCr//GDrmQGSfTjo3MI2i0edmcUWI3dKujhXXDKg+zDvRLp7oMfRAd
   OTrakALN1MR/N16Mfrq5mPBvWqFPfQVOhcy6YdTqbiZUt36GWHZcnIpje
   OTI7cCIz35SXyUm6sFejXxhiGha3QvW5T8PKQj3jlzB3vDS/jn89SlkFy
   w==;
X-CSE-ConnectionGUID: M6vYnIY6Q+KSUeAoKGEkuw==
X-CSE-MsgGUID: tcHhHMOMQXyZK+G3UaA7OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92315663"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="92315663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:21:56 -0700
X-CSE-ConnectionGUID: /JicYptxQvGMrLpGFoLC+g==
X-CSE-MsgGUID: bMulaPfIQmapcMUffqFK1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="241363545"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:21:53 -0700
Message-ID: <1f01b105-afaa-4e00-bea8-4ce2e004f6e0@intel.com>
Date: Tue, 9 Jun 2026 17:21:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Fix emulated CPUID features being applied to
 wrong sub-leaf
To: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, kai.huang@intel.com
References: <20260609075748.612704-1-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260609075748.612704-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/2026 3:57 PM, Binbin Wu wrote:
> Pass the CPUID index into cpuid_func_emulated() and return no emulated
> features for indexed CPUID leaves with a non-zero index.
> 
> KVM currently emulates CPUID features only for index 0, but
> kvm_vcpu_after_set_cpuid() looks up emulated features by function alone.
> As a result, reverse_cpuid[] entries that share a function but use a
> non-zero index, e.g. CPUID.7.1:ECX, can inherit emulated features that
> belong to index 0.  For example, RDPID, which is CPUID.7.0:ECX[22], can
> be incorrectly OR'd into CPUID.7.1:ECX.
> 
> This is benign today because the affected bits do not correspond to
> features KVM cares about, but it can become a real bug as new CPUID
> features are defined.  Make the helper index-aware so emulated features
> are applied only to the CPUID entry they actually describe.
> 
> Fixes: e592ec657d84 ("KVM: x86: Initialize guest cpu_caps based on KVM support")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
