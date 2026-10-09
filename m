Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A21346AED
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534058; cv=none; b=h0qoqEVxX9gcSt1yp1A+4+Z1uJmRRIDkVG2o8CuP8xgwdtI1Xo+BI+4+VyOqhcF2G786RAO/26djre1nF0JRq4ZiG25lp8LJdq4+MgnZ2FN6clF49QLLSa/oU0nX/W8cohrIooKgk5YnGRJXnCY7WtnzOhxEwFAhI4Q6C2yFemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534058; c=relaxed/simple;
	bh=j7WnDfxVsVCZ+R+TijatL/V/erIwMEXwUD5GEj/ZE1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoBowvQ7QA47DznuUBADyTJFp8/kpMk8B0Jlw+JAC6vpUwcwZFGDUDKT1+NZ2hndtMku+yvPpBIWHoOFvY7+Vj1Vr/Q/HvfAtXWVA7zmWdc+IZgDozQhzQJJ2pXGxVo8FyIcHd9HhAc1bao9ZqC8xoW4JjHh8yEPUtGt6VhOIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEr7DdK8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEr7DdK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791534057; x=1823070057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j7WnDfxVsVCZ+R+TijatL/V/erIwMEXwUD5GEj/ZE1w=;
  b=AEr7DdK8Mi4ukvxrpFxSKkZ4DCrwNGBrFPmvS52AGtqk+f32tH+7Z173
   5bpCWuaynVSKdONg49AKd718VvAz5gsdtmbFpUVRIJ5baa8jiKtpjAIpS
   UcO4XnPqgYxKkqWSZoAfLfrkLJ9Kk7d6Ntd8UeuwPMexeTZTkMSP+362I
   76xf0KXWAVOaitYdx121SyXv+9hF9yAtSAQ22QAZ9QDeuyiAFGG9jWsld
   bsgG5w7ezFMvZzUtr5YNjkHtBsSYBA2Nf8J5TCSkDvyiS284QVZ9A8b6R
   tlQZhkDm/R7sc5G8O+qHOQolz51Uw8G5HRazs0siX9eCuc4jrvWgO6c7s
   g==;
X-CSE-ConnectionGUID: E+CvZzL7RcS8O/mGZMiR/g==
X-CSE-MsgGUID: iR7PaPRNTfClnjHN1lcg8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="226346"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="226346"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:20:56 -0700
X-CSE-ConnectionGUID: ysq5bCgHRxy7+VCMUHOycg==
X-CSE-MsgGUID: sqa6jfWBTRGj1BwMvZu20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="201749"
Received: from yizheliu-ivm.ccr.corp.intel.com (HELO [10.238.208.114]) ([10.238.208.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 01:20:55 -0700
Message-ID: <abc8e273-90ce-4357-b16d-9d0af88dc654@intel.com>
Date: Fri, 9 Oct 2026 16:20:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 20/23] KVM: selftests: Add a helper to issue TDVMCALLs
 from the TDX vm
To: sashiko-reviews@lists.linux.dev, Lisa Wang <wyihan@google.com>
Cc: kvm@vger.kernel.org
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
 <20261002091334.3553E1F00893@smtp.kernel.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261002091334.3553E1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 5:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kvm: selftests: __tdvmcall silently masks TDCALL hardware failures
> --
> 
> commit 7709c4e900a0fe6433017aebbf708ee2946d3f19
> Author: Erdem Aktas <erdemaktas@google.com>
> 
> KVM: selftests: Add a helper to issue TDVMCALLs from the TDX vm
> 
> This commit introduces a helper function __tdvmcall() to allow TDX VMs
> to issue TDG.VP.VMCALL with a single function call, abstracting the
> register setup. The function passes the GHCI sub-function and arguments,
> and returns the TDVMCALL status.
> 
>> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
>> new file mode 100644
>> index 0000000000000..e3f0f7f2232bf
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
>> @@ -0,0 +1,39 @@
> [ ... ]
>> +	mov $0, %rax		/* TDCALL leaf 0: TDG.VP.VMCALL */
>> +	mov $0xFC00, %rcx	/* Expose R10-R15 */
>> +	mov $0, %r10		/* Standard GHCI call */
>> +
>> +	/* TDCALL instruction */
>> +	.byte 0x66, 0x0f, 0x01, 0xcc
>> +
>> +	/* Extract status */
>> +	mov %r10, %rax
> 
> [Severity: Medium]
> Does this code inadvertently discard the TDCALL hardware failure status?
> 
> The TDCALL instruction returns its module-level execution status in %rax.
> If TDCALL fails (e.g., due to invalid arguments or incorrect VM state), %rax
> contains a non-zero error code and output registers like %r10 are left
> unmodified (which was initialized to 0 prior to the call).
> 
> By unconditionally overwriting %rax with %r10, any TDCALL failure status
> appears to be silently masked and converted into a false success. Should
> this code check or preserve the error code in %rax before overwriting it?

This is a wrong comment from Sashiko. RAX returned from TDG.VP.VMCALL is always 0.

>> +
>> +	pop %r15
>> +	pop %r14
>> +	pop %r13
>> +	pop %r12
>> +	ret
> 

