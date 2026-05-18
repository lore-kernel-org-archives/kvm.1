Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA231E25F9
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068317; cv=none; b=KfaGLUctfXIh4K0yIj94gPywD7BsoSI1pqo7nuD2gKpdBP61IAi0Z1IIXfaZgngFb6WQ0AEr5+vdsSpddBLrN4la2faAeAQnK26aMqFMvii1ae7zNTiKT0j9VojcVq9I+U+z5WcrPgmgZH3ehgryke+7Dq7Prt0K1kpxNHW+V+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068317; c=relaxed/simple;
	bh=eU0DUmPuLgJZDLxNyzk1GHctnSu7EyGbvbAFBjGHaTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srUBzxHbay0UEjqAdZ0oXh1fQuGEfaYw8Ob89FTvFZdYHVSblKKDEnMDs6VbMAf8fMHC/xiOpAOpuKazBNzFhqzvJAwn6S0s42uboVH3cy2trVhXccUEGjy24S29j6Tw9VITb1YV3xOJVtxHu8dHOw+WRKz9qpzWoio37gu/h2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0RhBabe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0RhBabe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779068315; x=1810604315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eU0DUmPuLgJZDLxNyzk1GHctnSu7EyGbvbAFBjGHaTw=;
  b=b0RhBabeGTBAfWqhpi4NTEeOQVCsQJ1GWjBE+npiQ1OHy9Vm4gOY9Hrt
   jIuT8jMUXRkhqHtr7fADtktWAqtU++9wuQKz4tAyZ+/8mDTTmbvspZ2dq
   2Lr0JKG3oNneRuzqFNsw/eX5ZFdLcqrgnshn9+CYbJbgmsgwbJxcsmXIX
   7bHsOY74997e/qcNsWbEGw4HJioZHeRKBGQglhJCr+tqdgah44CtBmBMS
   na8SFKEQRzWgaoLi4U3XKQciIYEeNjer1cjgxh7Iiudz/M9Ru05Nuxp/E
   4wqGxo/u8gBPUC+herlQ4DSThRYDa0VjWGa1ketHly19ueYOaZ5O3N/jW
   A==;
X-CSE-ConnectionGUID: iH0AEo+9S/GuPz9b+ufQ3A==
X-CSE-MsgGUID: Kk7eA+C3Sv6PN2MlQUq+/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91023239"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="91023239"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 18:38:35 -0700
X-CSE-ConnectionGUID: tAxlMWfkS7aX4VtzkSTQSQ==
X-CSE-MsgGUID: qDnRCbCPRr6paOYx6fg7Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="238399122"
Received: from unknown (HELO [10.239.158.26]) ([10.239.158.26])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 18:38:32 -0700
Message-ID: <c6d216fd-3ca5-4ee8-91d9-ffb088c72fa5@intel.com>
Date: Mon, 18 May 2026 09:38:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID
 verification
To: Binbin Wu <binbin.wu@linux.intel.com>, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/2026 3:35 PM, Binbin Wu wrote:
> Originally, we had issues on TDX when a new hardware feature, which is a
> host state clobbering feature, is supported by new TDX modules/platforms.
> A host state clobbering feature requires KVM to save and restore the
> feature's related MSR(s) on host/guest transitions; otherwise, if the
> feature is used by TDs, the host state will be corrupted, leading to
> unexpected behavior on the host.
> 
> Currently KVM hardcodes a deny list for unsupported host clobbering
> features for TDX, i.e. HLE, RTM and WAITPKG. However, KVM can't keep a
> list of bits that it may not know about (e.g. the upcoming FRED support
> in TDX).
> 
> We had been working internally to propose a TDX specific solution to
> solve the host state clobbering feature issue. But during a PUCK meeting,
> Sean mentioned that KVM had a more permissive CPUID configuration
> interface than desired and there were problems due to it in the past for
> normal VMs as well. Sean suggested that KVM should introduce a more
> paranoid mode to check CPUID from userspace for VMs in general, as well
> as an opt-in interface for userspace. And TDX should use the
> infrastructure to enforce paranoid mode non-optionally.
> 
> This RFC patch series adds a paranoid CPUID verification mode for KVM on
> x86, where KVM must be explicitly aware of every CPUID feature exposed
> to the guest. When the CPUID paranoid mode is opted-in by userspace or
> enforced, KVM will reject any unknown or unsupported feature from
> userspace. And it starts to enforce paranoid CPUID verification for TDX.

This series misses the (important) part to use the TDX overlay to guard 
the setup_tdparams_cpuids() (and also mask the supported configurable 
CPUIDs in init_kvm_tdx_caps), to solve the initial TDX problem.
