Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4588BE9
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749470; cv=none; b=bf7a8sPHjdMVOhltwJvU1EC8oPDGOEwuxR2iNHE6j0fZtXq3N5q1+5gCUuq/Yft6tzIGwAfYLppUkjoHlog1Os1TJcl/FNBHwqdZGf2J1oipdcv+rI3Zmt+ViYiEfD4tJPPGaoo9fY9wqfYc/f6gai3ZxGyspa0jfDMkrQ9d1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749470; c=relaxed/simple;
	bh=1dDssTwuaTyuCcRXbe6D193WveE0XdnoeFshoYqxJzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwCcuM/RSuKwykH5qyXEvFuSE9y2dW2GQI5GTiaAICK02tXhGwsT6KhjgPPYLIbOaj3IhbLrVVygmRsVPSEdA+ehLSNieREM/7VrZ52OKdRLsP3QM6bPwKV3JHS1+s7e/gkZXlQwYxcQe+XZBNrruhuxHHInpr+tnj/9vXmtBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCCtDvYL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCCtDvYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776749469; x=1808285469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1dDssTwuaTyuCcRXbe6D193WveE0XdnoeFshoYqxJzM=;
  b=GCCtDvYLYc68AvTguTjjiyq6ssVL1wuMAQCFGOU4y8fpGMj+j+ZFqj4S
   0NR8Q+z6Mo/HKxlharoNmj+V5qoiV8UcEdV97wRhe2SGb183Nr1MPQaoT
   bI7kBGUsTWq1qK0XwpHVD+KCsOVewZVtZ5SyFA4Ti2+nXluQdzrjTyj1F
   mVlw2G7iZorSx9/M6ORzc6kLZkJDQPJpfmGnwzYGpwlKZOvCATnhdI76S
   HYvlKsLPUnEo1gGSqhVaDbhc+VC8/qiDj+iPBfcMi6jJ3m+qofdEGea2k
   vRS9hPZgtaSpwavjFEFyTs9fdxBKnUezKeKRDJk22i/H+qz5jB1geX2in
   w==;
X-CSE-ConnectionGUID: WXuNqUlzSxGM9ZtmsnkQvA==
X-CSE-MsgGUID: pJNw2mJ2RRSoatPdpMhG/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="87977357"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="87977357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:31:09 -0700
X-CSE-ConnectionGUID: gU5QndD1RgW8WNDoM1zXJQ==
X-CSE-MsgGUID: GBl9dpLATCiiy5fnFmyrRA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:31:06 -0700
Message-ID: <965663ee-a146-4962-ad01-a6e8a7de62ea@linux.intel.com>
Date: Tue, 21 Apr 2026 13:31:04 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/27] KVM: x86: Use overlays of KVM CPU capabilities
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-10-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-10-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]

[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=9

>  
>  /*
> @@ -1414,6 +1415,10 @@ static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
>  	entry->index = 0;
>  	entry->flags = 0;
>  
> +	/* KVM can't do the following emulations for TDX guests. */
> +	if (get_cpuid_overlay(kvm) == CPUID_OL_TDX)
> +		return 0;

Issue:
"
Could this early return cause an out-of-bounds array read and a potential
CPU hang?
When userspace calls KVM_GET_EMULATED_CPUID as a VM scope ioctl on a TDX VM,
kvm_vm_ioctl_get_cpuid() initializes array.nent = 0 and calls
get_cpuid_func() for function 0.
With this change, cpuid_func_emulated() unconditionally returns 0 for TDX
without adding any entries, leaving array.nent at 0.
After do_cpuid_func() returns success, get_cpuid_func() executes:
    limit = array->entries[array->nent - 1].eax;
Since array->nent is 0, does this result in an out-of-bounds read at index
-1? 
This out-of-bounds access might trigger a panic if it faults into an
unmapped page guard. If it instead reads garbage memory into limit, the
subsequent loop:
    for (func = func + 1; func <= limit; ++func)
could spin up to 4 billion times per base function, resulting in a CPU hang.
"

This is a valid concern.
KVM_GET_EMULATED_CPUID assumes that function 0 should always be valid.
For TDX overly, function 0 should return 1 while eax is zeroed out.

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2c4e64aa14c4..c2fde2fa1be3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1417,7 +1417,7 @@ static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
 
        /* KVM can't do the following emulations for TDX guests. */
        if (get_cpuid_overlay(kvm) == CPUID_OL_TDX)
-               return 0;
+               return func == 0 ? 1 : 0;
 
        switch (func) {
        case 0:


> +
>  	switch (func) {
>  	case 0:
>  		entry->eax = 7;

