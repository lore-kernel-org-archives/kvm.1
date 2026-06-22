Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7839312803;
	Mon, 22 Jun 2026 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109990; cv=none; b=ooq4gVKu8v7ZiEIwxsNxIwfeHvanVrNAB3WpXrU7HeiIabehyT7KoLz29WsRRqMTSmnrz0YFjmIz9KSGyMDOmZzdrKtQgZtu7yPNR+LNlepBmnOgny5rK1VdzPcBhnS4SpkpR2cxDZnjUojt55qINNk38BxpEkjtRdqvhwPypmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109990; c=relaxed/simple;
	bh=4IiVdHT8Pz8L2pkCFyUcQ/g3AsKMjX9hYMz80p3I+Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6nH8xAygB+g7UyxSeGVL9hY4vyZbwfnku1am3cCRYzvgR73WK73RW26fNNGSXspgoLLFIuJWJRxXF66fROLYVKIBvLG9WEtSrtFa+2wDoGMF2DCzfrefQ4+rvtmYbLhL8GVnu7c37/SMnhqIZUtNDRp2QJaBRy8HLYU+PJI2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnvFh8BE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnvFh8BE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782109989; x=1813645989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4IiVdHT8Pz8L2pkCFyUcQ/g3AsKMjX9hYMz80p3I+Ts=;
  b=mnvFh8BEb4WNpySlx1rOurYdt21hp3kG2fwRKc18argBKSdJPOg7Om9v
   SPT9sw8WBVHlbaU0t/hMdeqBocV1f02cc/L0DVbz/qp6pV5H8/7TweytO
   jQIJD6+YBJp3eQPw/j3YVzYxs6Rz8OSdO5V9BDUw9EEbTkusHjFdrCRha
   MWieJTqg9sK93oScVWMIFlD2PZHwSQ8hbv4szpyZnXeLq4b0xVT/+wzk2
   MlAheaQlY644MGyHXXmqwYM6rWk3P+gf/EYGB/iJgaV+GTa7POMZs5ciy
   ebLaAS0WxoVNdqT1o9hFN1v8opDxHYspHa0NRVR33caoYG/mjKsR0TPfQ
   A==;
X-CSE-ConnectionGUID: 3iUv3sMOQcCL8RnzIinfQw==
X-CSE-MsgGUID: 37m1zDHHRFmI2LGh1W2zGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86677636"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86677636"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 23:33:08 -0700
X-CSE-ConnectionGUID: 0/T7rKPrQyK91GlvkjVZjQ==
X-CSE-MsgGUID: JDOhiIRqSLmil2JmySDspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="287262627"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 23:33:07 -0700
Message-ID: <eba94468-2507-4c1a-8107-4d13182aed71@linux.intel.com>
Date: Mon, 22 Jun 2026 14:32:50 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] KVM: x86: TDX: Validate directly configurable
 CPUID bits
To: seanjc@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 kai.huang@intel.com
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/2026 10:33 AM, Binbin Wu wrote:
> Hi,
> 
> A host state clobbering feature on new TDX modules/platforms can lead
> to host state corruption if KVM does not explicitly save and restore
> the related MSR(s) during host/guest transitions. If such a feature is
> blindly exposed to and used by TDs, it will result in unexpected behavior
> on the host.
> 
> The v1 RFC [1] attempted to solve this by introducing a comprehensive
> CPUID paranoid verification framework across VMX, SVM, and TDX. However,
> as Sean pointed out in [2] and the discussion in the PUCK meeting, this
> approach was overly complex and bled too many TDX-specific details into
> common KVM code, creating an unnecessary maintenance burden.
> 
> This v2 takes a significantly simpler, TDX-contained approach. It strictly
> validates only the TDX directly configurable CPUID bits—those reported by
> the TDX module in CPUID_CONFIG fields that the VMM can configure for a TD.
> This is sufficient to address the host clobbering issue, as no new host
> state clobbering features will be fixed-1. All filtering and validation
> logic is entirely isolated within TDX code.
> 
> Feedback is highly appreciated, particularly on whether this contained
> approach strikes an acceptable balance regarding complexity.

Hi Sean,

Do you think this proposal is the direction to go?

> 
> Specifically, this series builds a KVM-side allowlist of supported TDX
> directly configurable CPUID bits to:
>  - Filter KVM_TDX_CAPABILITIES:
>    Replace the hardcoded denylist to only report configurable bits that
>    KVM explicitly supports.
>  - Validate KVM_TDX_INIT_VM:
>    Reject any configurable bit that the TDX module allows but KVM does
>    not yet support.
> 
> With this allowlist, newly added TDX configurable CPUID bits will not be
> exposed to userspace until KVM explicitly opts-in after fulfilling the
> necessary virtualization requirements.
> 
> Open:
> - This series doesn't implement validation for KVM_SET_CPUID2.
>   TDX has two interfaces for userspace to set CPUID bits: KVM_TDX_INIT_VM
>   and KVM_SET_CPUID2. A malicious userspace VMM could lie to KVM through
>   KVM_SET_CPUID2 by setting a TDX directly configurable CPUID bit to a
>   different value than what it set via KVM_TDX_INIT_VM. KVM does not
>   currently use its own view of vCPU capabilities to manage host clobbering
>   features for TDs. The consistency check is not a must have action so
>   far. It could be added later if KVM really relies on its own view
>   to make decisions to manage host clobbering features for TDX.
> 
> Changes from v1:
>  - Dropped the overarching CPUID paranoid verification framework across
>    VMX/SVM/TDX and the opt-in interface. (Sean)
>  - Shifted focus entirely to isolating and validating TDX directly
>    configurable CPUID bits.
> 
> [1] https://lore.kernel.org/kvm/20260417073610.3246316-1-binbin.wu@linux.intel.com/
> [2] https://lore.kernel.org/kvm/agsiQGikhZA0CGTY@google.com/
> 
> Binbin Wu (4):
>   KVM: x86: TDX: Track supported configurable CPUID bits
>   KVM: x86: TDX: Hide unsupported configurable CPUID bits
>   KVM: x86: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
>   KVM: x86: TDX: Report CORE_CAPABILITIES as supported
> 
>  arch/x86/kvm/vmx/tdx.c | 251 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 214 insertions(+), 37 deletions(-)
> 
> 
> base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34

