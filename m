Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A940DFAF;
	Tue, 14 Apr 2026 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169902; cv=none; b=KCCiyio7yIUd2NOyDYWvhOLo8/pnMzLI4kQGI+ywClbGPAGRT9jR7VW+ECjGw+A/E8S7Pv5JEebew0i1lQAGvhrDjh7gqDWYWa4fMix1j4HYxymwjLWWXGyTFbLp741aY9iT7wLMYqVGZ83rraH/jnxfzCDJIDKNcJnJmZkI4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169902; c=relaxed/simple;
	bh=maAz6YD2RveDtZoOs3JmvpnPgk8zxD2BJkLVudhTDzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxs7i+Yt6QXzqKDigbUdiFOsCfZQ/FNj9qvOrxJgw33BUE3t+ILNtC7OTSMJ0N3dY+rgVxm90bfkgYOEOUHxEWZUCRAK8jrDWkt5vxX71QI470RlaraeLmip2XWkL0VfSWdFFio8tYM1JF0ULT7QsArNWezVBw86g2GiMDATjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYpuar0b; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYpuar0b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776169900; x=1807705900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=maAz6YD2RveDtZoOs3JmvpnPgk8zxD2BJkLVudhTDzs=;
  b=nYpuar0bDNniBrmyMEuZPT9ClDpjB0Ztu9Xo/bVU5OoEYIOcp0qTb2c6
   UOCGCf+kUSZrjrbneZfLQEyewy2DLhu3uo33n5rSBdUUSmy06rr8c0TC1
   ALpGGGo3hLrMNVW/1pVj5kZ//lw10qrx7rAbBMv/jOmbLIr09YDgzx0e8
   EcDBcmohFCzgwe4jFcAHDGaycuAnHamfGZALvhKbNR9Y16O6iiCvBig0w
   1s5RtwHjhRBPJRNSrht0MP8gUy5NvCWRmcy5/1kZcpfMKP2FsQeJbccAT
   zY/TxXv0m7gMbghvv8k1g/kSrYJwFvnF5+xSNT2hV15Q+6MfG8liWN0s+
   g==;
X-CSE-ConnectionGUID: zzwAXAIhRmatUkyWY3XJ1g==
X-CSE-MsgGUID: kM3QrHfuRaG051fG+y2W3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="80988230"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80988230"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:31:40 -0700
X-CSE-ConnectionGUID: unRBgi01REyrFCJfai/f9Q==
X-CSE-MsgGUID: 0sYBY79zQ0+bkqOmqKgorw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225776739"
Received: from unknown (HELO [10.239.158.42]) ([10.239.158.42])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:31:37 -0700
Message-ID: <20b82b65-b156-4a2c-8094-b86dccfb3025@intel.com>
Date: Tue, 14 Apr 2026 20:31:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: x86: Add dedicated storage for guest RIP
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
References: <20260409224236.2021562-1-seanjc@google.com>
 <20260409224236.2021562-2-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260409224236.2021562-2-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/2026 6:42 AM, Sean Christopherson wrote:
> Add kvm_vcpu_arch.rip to track guest RIP instead of including it in the
> generic regs[] array.  Decoupling RIP from regs[] will allow using a
> *completely* arbitrary index for RIP, as opposed to the mostly-arbitrary
> index that is currently used.  That in turn will allow using indices
> 16-31 to track R16-R31 that are coming with APX.

Even leave RIP in regs[], what is the problem by just allocating the 
index 16-31 to R16-R31 and making RIP the index 32? (I think I need go 
read the APX discussion to better understand the reason)

> Note, although RIP can used for addressing, it does NOT have an
                          ^
missing a 'be'

> architecturally defined index, and so can't be reached via flows like
> get_vmx_mem_address() where KVM "blindly" reads a general purpose register
> given the SIB information reported by hardware.  For RIP-relative
> addressing, hardware reports the full "offset" in vmcs.EXIT_QUALIFICATION.
> 
> Note #2, keep the available/dirty tracking as RSP is context switched

s/RSP/RIP

> through the VMCS, i.e. needs to be cached for VMX.
> 
> Opportunistically rename NR_VCPU_REGS to NR_VCPU_GENERAL_PURPOSE_REGS to
> better capture what it tracks, and so that KVM can slot in R16-R13 without

s/R16-R13/R16-R31

> running into weirdness where KVM's definition of "EXREG" doesn't line up
> with APX's definition of "extended reg".
> 
> No functional change intended.
> 
