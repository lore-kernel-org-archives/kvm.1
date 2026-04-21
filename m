Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB6276041
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754313; cv=none; b=tKjSB5omqjjHzbBRoppM9eOpE7jo5XpWkCYqPauq0vbqrepMuCXBt7P3iE2L4TsROdebZrSFUUQE03KOECaZXDTA6NMS4bA5cQWNcHBEtrxRaFvFwIzAuoEVPSF5nyDWhMxtZ37ShM4aBBCGklO/nh6vpAMGd2tc1zF9Uwb9VzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754313; c=relaxed/simple;
	bh=qQP/IXH+32LKMlART61QVe5qfyOaR4fMMlkLAKyD3BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpHqpyjxOkNsnP15omiG/Eaxcf7YNIv0F/c3TNFf/+yHamTkUaVuCaDQ1p1NukeyqVEo1aKB/fglO7aMr/9/aXo7IC/H4iYw3Q4/vQZgq1OPBvKGTqK84YNA/0Dl5ysBOu7OlSgEm4JS9KJlsKZFXcTlwQtgyt4NORQb1omhJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUKc42t9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUKc42t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776754311; x=1808290311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qQP/IXH+32LKMlART61QVe5qfyOaR4fMMlkLAKyD3BM=;
  b=LUKc42t9wLlUZsoEUdDvX0tM/tGdo+n1W8k+fxVImauSPthLOH3QaMH6
   G55knFqVQcm87Xfvg4qPf6U0Z5ULa8QKXSeVwBHV+eW9kHvjzll3KyJtJ
   VFy8uACtszWkCsrkrO4wdY6NOZf2A3RUBQ6LszJzLZXPksfSN2Lx2O+e3
   9oJbmMm8o+6q7e4bKjyaRbgWYAWloiGUegRLBWF0bi/USpglOKiLIT9ed
   w1fgkFp+MSVeZv46HtkeQ2AKcDEHjIf4zrCxIgvVSw+6B7gyCrRRL05Qh
   42hBSUqbyiqdQIEeXRd13ustvTn0tFwGbz1Eq53XQo1qC3fjioWLrCBqn
   w==;
X-CSE-ConnectionGUID: P5c37NmqRJ2kTKqswqbY4Q==
X-CSE-MsgGUID: lX9uavdNT0ipqc7GD/cnkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="80267921"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="80267921"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:51:51 -0700
X-CSE-ConnectionGUID: //ZvWT7+RYW1mPkVyhM9RQ==
X-CSE-MsgGUID: 7Ub+Kn0xTsaD1kk09YPmRQ==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 23:51:49 -0700
Message-ID: <bf7b1fee-af6e-42b2-914d-0ad496a696d8@linux.intel.com>
Date: Tue, 21 Apr 2026 14:51:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/27] KVM: x86: Init allowed masks for basic CPUID
 range in paranoid mode
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-17-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-17-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]

[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=16

[...]

> @@ -876,6 +905,14 @@ void kvm_initialize_cpu_caps(void)
>  	BUILD_BUG_ON(sizeof(kvm_cpu_caps)/NR_CPUID_OL - (NKVMCAPINTS * sizeof(**kvm_cpu_caps)) >
>  		     sizeof(boot_cpu_data.x86_capability));
>  
> +	kvm_cpu_cap_ignore(0, 0, 0,
> +			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
> +			   F_CPUID_DEFAULT | F_CPUID_TDX);
> +

"Could this cause an array overflow if the vendor module is reloaded?
kvm_initialize_cpu_caps() is called during vendor module initialization (e.g.,
from vmx_set_cpu_caps() when kvm-intel.ko is loaded). It zeroes out
kvm_cpu_caps, but does not reset ignored_set.nr to 0.
If the vendor module is repeatedly unloaded and reloaded, ignored_set.nr
will continually grow until it exceeds KVM_MAX_CPUID_ENTRIES. At that point,
the WARN_ON_ONCE in kvm_cpu_cap_ignore() will trigger, and all subsequent
ignored CPUID entries will be dropped.
This could cause valid userspace CPUID inputs to be rejected and break VM
creation.
Should ignored_set.nr = 0; be added to the beginning of
kvm_initialize_cpu_caps()?"

Yes, ignored_set.nr should be reset at the beginning of
kvm_initialize_cpu_caps().

