Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F1175A87
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758166; cv=none; b=QvIzk9tiiBu5twG4ep4u3T6FpHWNYdzkwLlMgdBzib0zXlTo8b69CHRrMW/o1cBGra6W7QYE7AEumX64b4GvyfUQ2AEVdTtfEkRDIbwu5uUJ4LlV0TZD1zjcf55LB3cNVRJjFubQlPSutYCxrcUgsOX64g710GIo3OtQsMyif9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758166; c=relaxed/simple;
	bh=VIN+T5XnVuGHbrqX8N+18Av3xcWV0Tci7f7EO9pmui0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHA838q/TmZFiaSN18q9OrXEkphnOQJbVmjR0DxreBz8Wywcn11rEEcwBWh+hGDVuwPP+LAt77wnAxHXOf1mIKZl6SJkNx2o0SDQu+mAGzXI5xpFShdpyE802I2yI6fl0w6Jf9iT8iIJ1wV47+VsPecTn8c9BWilmtP0Fhr/BCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRYE0Yrq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRYE0Yrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776758164; x=1808294164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VIN+T5XnVuGHbrqX8N+18Av3xcWV0Tci7f7EO9pmui0=;
  b=BRYE0Yrq02vReczsKdwpEIDtKXHOBfQkPrTuLxjEM9AZstU8NOrtf9TZ
   WDtTJKRpVrpDGYYy8WCPWYZXtte8a5vTXqStxUPGCs/uo53vO9steEIQm
   mAp0qVymdeBmOvuaRRXyM6dAK3UOjgpaqxHfSKOixGvYCcvofl04TVM2S
   Y9C1Du9MzH04ZweGqJ/LRQ67VJl1a+y6FVo/Q51TxKbfBnc770OEL45BW
   Zv1tN1szJVGY8xR9vEKHq9HNGAFzGCl46wmKk0d3hx8AS6WDXUg6KSr9O
   /VbOlcZL691IfctnnMYzHdqQp2xIkXmePu7vKCdsdr8RwhGPBdqnIN0qz
   w==;
X-CSE-ConnectionGUID: NBtNF2ZGTEu2cTq3kyBnyQ==
X-CSE-MsgGUID: zaDWvdaORAuD2/gbqAu/2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89064777"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="89064777"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:56:03 -0700
X-CSE-ConnectionGUID: ikCKoxLSR0mH9v5TwR3/4g==
X-CSE-MsgGUID: hku0xwHaTv+wDJf7sT/iPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="270046179"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 00:56:01 -0700
Message-ID: <16768449-df59-4798-948d-3be609d3942d@linux.intel.com>
Date: Tue, 21 Apr 2026 15:55:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/27] KVM: x86: Init allowed masks for extended CPUID
 range in paranoid mode
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-18-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260417073610.3246316-18-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Below are responses to issues reported by sashiko. [1]
[1] https://sashiko.dev/#/patchset/20260417073610.3246316-1-binbin.wu%40linux.intel.com?part=17

[...]

> @@ -1310,6 +1311,18 @@ void kvm_initialize_cpu_caps(void)
>  		F(AVX10_VNNI_INT, F_CPUID_DEFAULT),
>  	);
>  
> +	kvm_cpu_cap_ignore(0x80000000, 0, 0, BIT(CPUID_EAX),
> +			   F_CPUID_DEFAULT | F_CPUID_TDX);
> +	kvm_cpu_cap_ignore(0x80000000, 0, 0, BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
> +			   F_CPUID_SVM);

Issue #1:
"Does this strict zero-checking of EBX, ECX, and EDX on VMX/TDX break
userspace VMMs like QEMU?
QEMU unconditionally populates 0x80000000 EBX, ECX, and EDX with the CPU
vendor string (e.g., GenuineIntel) across all x86 architectures. When
KVM paranoid mode is enabled, KVM will reject these non-zero values.
This could cause KVM_SET_CPUID2 to fail with -EINVAL, breaking VM creation
for TDX (where paranoid mode is forced to true) or VMX.
Do these registers need to be ignored across all overlays, similar to the
explicit workaround implemented below for 0x80000001 EAX?"

The concern is valid.
Although after commit a539cd26145c
("i386/cpu: Mark EBX/ECX/EDX in CPUID 0x80000000 leaf as reserved for Intel"),
QEMU by default zeros out EBX, ECX, EDX for Intel or Zhaoxin CPUs, 

But for back compatibility (PC machine v10.0 and older), or 
vendor_cpuid_only_v2 is manually disabled, there will be problems.
Considering CPUID paranoid mode is enforced for TDX, it will cause problem
when older QEMU populates 0x80000000 EBX, ECX, and EDX unconditionally. Will
add 0x80000000 EBX/ECX/EDX to ignored set for VMX/TDX as well.


[...]

> @@ -1388,6 +1422,10 @@ void kvm_initialize_cpu_caps(void)
>  		F(AMD_IBPB_RET, F_CPUID_DEFAULT),
>  	);
>  
> +	kvm_cpu_cap_init_mf(CPUID_8000_0008_ECX, GENMASK_U32(17, 12) | GENMASK_U32(7, 0),
> +			    F_CPUID_SVM);
> +	kvm_cpu_cap_ignore(0x80000008, 0, 0, BIT(CPUID_EDX), F_CPUID_SVM);
> +
Issue #2:
"Will initializing this allowed mask exclusively for AMD cause failures for
multi-core VMs booted via QEMU on Intel?
QEMU unconditionally populates 0x80000008 ECX with the core count and
APIC ID size for any multi-core guest configuration, bypassing host vendor
checks.
Under KVM paranoid mode, KVM will reject these non-zero values on Intel
hosts, causing KVM_SET_CPUID2 to fail and preventing multi-core VMs from
booting.
Does the allowed mask or ignore rule for this register need to be expanded
to include VMX and TDX?"

Similar to issue #1, for back compatibility (PC machine v10.0 and older), will
add the allowed mask for ECX in VMX/TDX overlays and ignore EDX for VMX/TDX
overlays for CPUID 0x80000008.




