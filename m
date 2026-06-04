Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C03C768A;
	Thu,  4 Jun 2026 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555999; cv=none; b=sldBYYKd2Hus/A81txPZ7DuHaYif1sZOt0GSgdHKLFKc5wvKMgI9PPMynkKDvQf/QbbyQyuQhGodfZfGW6Cc9NOanepanEjaCYDBvC+fwYnjgQOs+XkEysOuJKcc3WIJlj+iQu5lQ4IoRc2zMSywL425V+qkH8pCTyg/v2OgBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555999; c=relaxed/simple;
	bh=H8Shv1IuE1+2uLqdp2Vks+cfKeAGx1PzFQf8Gz4nKOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4Ed6R7VuT4iKo7WcgW5Sj7sRuXIj0wZQD3Qn1qAKluc+L4MQBZP+25UGhHywctJV5xx3S2swoxtBPZYPBJ8iv2IUO9WRYGk5ZlDIHVaQf0dcSbzLaOPDxZL6UoCL1GQTgPhuaE8fwXxI7l1UFfQn34qRDVMJSQzAttibGqVSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YarUAfio; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YarUAfio"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780555999; x=1812091999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H8Shv1IuE1+2uLqdp2Vks+cfKeAGx1PzFQf8Gz4nKOI=;
  b=YarUAfiojqlv82YKxB3MuWX9z2H+bz7lQI8EhjxT88bhaSbA9p845BSQ
   PS86/32ZLSmkPzud2f5lnYLSY9KiwWdumRi+7VTBWXEWooRAEyzauojlq
   TW+moFvUbAKy8G3BiT8TvmNVxEngK2BD8KF24zGzeZ7tELVccqCQNBXjX
   3eZcX2iXaEW0MsHxHOLmIx0JN8NdfFyRz8GVveF9y62UHu6/ohLfbCoV1
   tihUf+5H7Pnhu2BlIlnoUUGVmSWsrxUSlVZnc07ukgmorljzETNrQLXXa
   WRbyiXOdLkvdKrYS3S+IMW+lNNrkdpJ52513rxUGriAySdDVye6Ce8XwH
   Q==;
X-CSE-ConnectionGUID: 8FqrZ/42Q/KC8BwRrzDrNA==
X-CSE-MsgGUID: NO0WIpvVR7KeQlJfYB9CYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91692486"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91692486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:53:18 -0700
X-CSE-ConnectionGUID: G3WMCL6kR3mVBCPBCZlUHQ==
X-CSE-MsgGUID: HbRZxf2qTtWgDXj+4LdcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="243391393"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:53:15 -0700
Message-ID: <883588d1-27a2-4874-b832-5b1b62db3cb9@intel.com>
Date: Thu, 4 Jun 2026 14:53:12 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: TDX: Report CORE_CAPABILITIES as
 supported
To: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, kai.huang@intel.com
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
 <20260604023314.3907511-5-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260604023314.3907511-5-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2026 10:33 AM, Binbin Wu wrote:
> Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to the TDX configurable
> CPUID allowlist to accommodate legacy TDX module behavior.
> 
> KVM doesn't support MSR_IA32_CORE_CAPS, however, some older TDX specs
> define CORE_CAPABILITIES CPUID bit as fixed-1.  As a result, userspace
> may expect this bit to be enabled in the TDX module for TDs.  When the
> CPUID bit becomes a directly configurable without reporting to the
> userspace, it can not be enabled.  To avoid confusing userspace, report
> CORE_CAPABILITIES to userspace via KVM_TDX_CAPABILITIES.
> 
> Although KVM could determine the real CPUID setting by reading the
> metadata via SEAMCALL after KVM_TDX_INIT_VM, doing so is overkill to
> cover such a corner case.  If CORE_CAPABILITIES is exposed to a TDX
> guest, and the guest reads it, simply return 0.

shouldn't this patch be put as patch 02 instead of 04?

Patch 02 and 03 in this series break the old QEMU and then patch 04 
fixes the broken. This is not friendly to the bisect.
