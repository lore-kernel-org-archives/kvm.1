Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4839DBF2;
	Wed, 29 Apr 2026 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453800; cv=none; b=JbG9+zi32OOigsIrE80TI0pPv++K/twO0yndWWncRoTxa2TsWk9SHwmkImKmwXdp01v5/1Hav+rtMkhUzjswdedZyfo39gO7RNce0P7ZlEtQ2GFxr0qOTagoNRMoRDM+63Ht/C4v4IMXFhbp9LigWWLo3q4XR0C6KxF/MPOovgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453800; c=relaxed/simple;
	bh=goswaaK94mq6B453JKApwrx2TL9pEZS98qyOerXtYjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubB2UGZkJ6S2ZDTX/N7aDB8H6f6hNhWy/COCF6G7GSgW6B4v83k6+Aj4jB+bnWWVNpGEBZ4ENWGR2XDJ3Ygh1LFq/8WWUhAi7ABWGJcR9BaS6QZD5kXRlCatYnBC0M9HeFhCXD0AmrhcLfvlrKRE/gkwaDUzch25N8kmGl2Baao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/QmZaU6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/QmZaU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777453799; x=1808989799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=goswaaK94mq6B453JKApwrx2TL9pEZS98qyOerXtYjo=;
  b=V/QmZaU6Vpp9/eTXmxFP5GNd4og8jRWuQDqJ1t6WVOgeuqGx+I5J7EHQ
   Z890iQlSTIjgKonjupYf1Y0bGR7pnftOKkwgWuptX8t0ofondDtqsMaPB
   D0s6AR2CZBBVPF7Dr3/Uft7vsR05OE9FWPy4Es2WXJqJnCdcHLGY+A+68
   bDMUAC8vEFkXaF1k3PyqkMDCRg12OXhrzbQ8nfBanpqUrD3Hub4DSKEWw
   Cpk5mMtYlb1dAHX6+xvF8bdvAgnjCs8TldrHSuwE4W+agaYIrr7T6KM9V
   FQjWvy3SJd5wFwK8Yrt7q8OibRmIk38j9rh0OtYi0Jm+lwP9gK/rf4Kej
   w==;
X-CSE-ConnectionGUID: HVY7yfVPQVeTBEGPYukByQ==
X-CSE-MsgGUID: 7ts30uH+SZSdDd6etJx1/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="103833056"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="103833056"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:09:58 -0700
X-CSE-ConnectionGUID: 2y/hYtwhQ3iX/q9Gi83pxA==
X-CSE-MsgGUID: axgm0o6rQ/KQa2PjOOYFRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="229862305"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:09:56 -0700
Message-ID: <c69630c5-2608-4c3c-8a3b-d4477abecde4@linux.intel.com>
Date: Wed, 29 Apr 2026 17:09:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Allow TDs to read MSR_IA32_PLATFORM_ID
To: Dave Hansen <dave.hansen@intel.com>, rick.p.edgecombe@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 pbonzini@redhat.com, seanjc@google.com, kas@kernel.org,
 vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-2-binbin.wu@linux.intel.com>
 <0fa94f46-4cd8-4e28-a080-1517fccb1578@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <0fa94f46-4cd8-4e28-a080-1517fccb1578@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/2026 2:49 AM, Dave Hansen wrote:
> On 4/27/26 19:47, Binbin Wu wrote:
>> Linux kernel reads MSR_IA32_PLATFORM_ID during init since commit
>> d8630b67ca1e ("x86/cpu: Add platform ID to CPU info structure").  KVM
>> already supports this MSR on read for normal VMs by returning 0.
>> Without support for this MSR, TDs get unchecked MSR access errors.
> 
> NAK from me on this.

Based on the discussions, I will drop this patch.

> 
> The platform ID is used for one thing and one thing only: microcode
> updates. Those updates are solely the domain of the bare-metal OS.
> 
> The (guest) kernel code that's even trying to touch this MSR is buggy
> and insane. We need to turn that code it off when
> X86_FEATURE_HYPERVISOR==1. There's already a patch floating around to do
> that.

I guess it's the second patch in this patch set.

The second patch checks hypervisor bit via native_cpuid_ecx(1) instead of
boot_cpu_has(X86_FEATURE_HYPERVISOR) since intel_get_platform_id() could be
called in ucode load path even in virtualized environment when
CONFIG_MICROCODE_DBG is set.

But using native_cpuid_ecx(1) will have an issue for XEN PV guest.
intel_get_platform_id() can be called by XEN PV guest and the
native_cpuid_ecx(1) doesn't have the hypervisor bit for XEN PV guest.

There could be two options:
- Use cpuid_ecx(1) in intel_get_platform_id() and drop the helper.
- Use boot_cpu_has(X86_FEATURE_HYPERVISOR) directly since CONFIG_MICROCODE_DBG
  is just a debug config option. Maybe add some comments to avoid confusion
  due to the pre-existing comments for intel_cpuid_vfm().


> 
> Please don't add more smoke and mirrors.
> 

