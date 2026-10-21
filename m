Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566338;
	b=eGAHxWg9s5SqA6aXwEh1X/Us0v2xLbCAK6+V+PIj3niTT86OawzcAsp/GJPGWpvjFNuG
	 gvl1hh2VhmuWJ0zyA9MEQCjQxisL11Hk3rdoks5qJ91rGRfREXCpqqAzC8y1WHcqN86XY
	 PsF6Dqw1vAor3bJFiI97Zb+FWa7h49fGaGGQVBa+jXaRCH+iBfTMnYxWkUpYHk3sH0lBt
	 oGh66qGSsU8xMgByTgjvrHBt7Z0x087R6C5cqwz5hvwNk7oiJoU2pHbvUwvwIaSlM7rMi
	 upkAZ7twRQ4/karL1bL+0kClaYHW3poYvGO6t+R4HhqobXvapqfZkznZowAfrkDYnLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566338;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RGR/Jx3r3CM4i2U8b24w9V0ryLpjT9EAn8+U2VGjkao=;
	b=OM0nmtYvmEO72E7ASKOR0sy/7KHoXEJu3ZnNekpf1a2XJLHbmV3gxdCQlmmIX2Y6SWK/
	 jZ8hRY4QRpHOF9EZa56divwLtj2i4W/2ASFXvSD4M7wjFmJCrf2A9WL+iAsAMjofB2I7r
	 JZof2vFubYrRpmh5miI/pg2RlLPkiuKbL9AFc968HQhGB5z6FXcRwnBVh6zdStVZD8sBZ
	 Cx1IZrElkR4sSn/MaBuCb//RHHSaq/8VE9dXdREFdvvbPYfZG64AqSXZ+WhXmM/JDNK0D
	 K1GXHrvuoBShTyMfcOP3A2YAsu8sHV7g4xfY3YAzEtbWFFLz47r6oGXYzAGCyN8AvVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nstdDiTH;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC778606A319;
	Wed, 21 Oct 2026 07:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC778606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nstdDiTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792566338; x=1824102338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D7WN6dDMY71qfhiz6XBlibbsaCT69lO3NDprJWMVjeo=;
  b=nstdDiTHFyC7MwMJQ2Zo4GFM8fHSmO/d4uUiBuleH5F6hsodrRcZb4RM
   8qxYpk9Xo7NGybmE+9oEQu0RPkc9Yw1jBwBRJqTTlytC+kVpBpEthF1Qt
   wKuSbVH0A7cExFUjlz7lJk3GrjeT/ImM3v4XI5RvysUmG9oiCrCo/brqJ
   MCSRI6kiR2f2cxv2x6Y8Qn70ZVQRwJgjxAWN9hP7utj1dTHgqITvqBmR/
   FxQnID6U76oL/36f7ZMssMR89yFIDo0+Dce8CHpANCWFvbufwPMos2LTZ
   F/kqBRiKa6vWgn1LzCi/Tqw9SSyCvkX/CQyKBgXJ6kOoTawRmzhdWbmi8
   w==;
X-CSE-ConnectionGUID: L1QWDOD5TleQxXWAU+7PFw==
X-CSE-MsgGUID: 17RCfk68RICuemnyYlFw/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1299238"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1299238"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 00:05:38 -0700
X-CSE-ConnectionGUID: AQFjolYnQcqyK886Fti09Q==
X-CSE-MsgGUID: sn3BGS//RTicLJrXTwGuew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3027640"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 00:05:34 -0700
Message-ID: <de8b810c-1ee2-4087-927a-06f3975ba670@intel.com>
Date: Wed, 21 Oct 2026 15:05:32 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: leave the legacy private attribute in for
 TDX and SEV
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Shivank Garg <shivankg@amd.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
References: <20261020131447.122096-1-pbonzini@redhat.com>
 <20261020131447.122096-3-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261020131447.122096-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/2026 9:14 PM, Paolo Bonzini wrote:
> As of today, and presumably as of Linux 7.4's release date, there
> is hardly any VMM that supports guest_memfd attributes.  Support the
> legacy VM attribute for private memory if SEV or TDX are requested;
> default it to disabled if only the software-protected VM is requested,
> since it is only used by guest_memfd selftests.
> 
> While in-place conversion is the best option, it is way too
> early to enable it by default.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>  arch/x86/kvm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 01a683a9042a..4f7d75ec8c40 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -80,6 +80,7 @@ config KVM_PRIVATE_MEMATTR_VM
>  	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
>  	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
>  	select KVM_VM_MEMORY_ATTRIBUTES
> +	default KVM_INTEL_TDX || KVM_AMD_SEV
>  	help
>  	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
>  	  memory attributes.  Using per-VM attributes is deprecated in favor of
> @@ -87,7 +88,7 @@ config KVM_PRIVATE_MEMATTR_VM
>  	  CoCo VMs using a VMM that doesn't support guest_memfd memory
>  	  attributes.
>  
> -	  If unsure, say N.
> +	  If unsure, say "Y".

It looks the no-quote version is more popular.

          If unsure, say Y.

>  
>  config KVM_SW_PROTECTED_VM
>  	bool "Enable support for KVM software-protected VMs"

