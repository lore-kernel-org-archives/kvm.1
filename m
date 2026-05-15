Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DA3EF0AC
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832521; cv=none; b=RpFJuXvQNnMdUidzOO5ewTDs/T3EqUxmfeZjK8ulMw1GWrVyqjPWWwniCWgDaL2A+rLtFP6X3Lbj04YdWDGxj7d4Y+DGfD2jAuqzZ9GiiBxE2qTEH/9j6UDuDHtfmSfQxvub0yey3YKv/IK8TcDUfzvHA2ASAzeiVEpacGrI6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832521; c=relaxed/simple;
	bh=9G5LxlQr8qkNLG/O7OM/GEjfZwz6PPJaDsQR6RvxM68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oki+Gkk/UG6EoLUzyiB7vY88dQBeaLv7V0uU7N8wCs/NpXlHufaHlbgtgOKNg/Ummnv8WLocFZviXAnsj9FDHxGOGO816DSwR3RfaMORvv5qAKV2HVYfsOGgOpEGyYXbiLHxZ+HXyiccTUNi5tkVi/1VxbCvGm2CoZjFvRywggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoGLfu65; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoGLfu65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778832519; x=1810368519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9G5LxlQr8qkNLG/O7OM/GEjfZwz6PPJaDsQR6RvxM68=;
  b=FoGLfu65XDjtLpxO1kTbo8GyjlgHDecVyrIcqW2f1Iag1tnlIzQUyG6O
   cUpnrjtu39kxOL1L3cqyhRWJ5fLnO/hbewZ7CuVlV56dVMblUlO/X95kf
   oKTP71A+6dVL++aW65Mz5Y2Vz+YEELE9soXtJKgrIYKmkDtGAVg3RyMq1
   AdoEicNNc5KOmrb22Pyt6Tn1UJBw8HfMdItucQ4RP3QF28e5DFGLdU0Lm
   ZSV1OA+WLa48gMXjYUd+cpOi0ap4P2co8oNytKuqR5LbrzolT8csp85Nq
   q7FF+TOJq4znTuULS4+DI4qDQ/1GLRUJPgClYUhdjVH/NSDbxLZDUDwH4
   A==;
X-CSE-ConnectionGUID: xefemVuwQ6+qOit60/Tu3A==
X-CSE-MsgGUID: 9Ee0Fs2jSIajFnAx6oeshA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="67314672"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="67314672"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 01:08:38 -0700
X-CSE-ConnectionGUID: jzqUl9wUQFC+FsGYtTnYsw==
X-CSE-MsgGUID: 9a5nbT4oShuvk247OUqeJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="242971090"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.18]) ([10.124.240.18])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 01:08:36 -0700
Message-ID: <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com>
Date: Fri, 15 May 2026 16:08:33 +0800
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
Content-Transfer-Encoding: 8bit

On 4/17/2026 3:35 PM, Binbin Wu wrote:
> Hi,
> 
> This RFC series is to allow public capture of feedback from TDX
> developers before we have too much internal conversations on it and to
> initiate code review of Sashiko. It is not yet intended for review by
> KVM maintainers. Sean and Paolo, please feel free to ignore this version.
> 
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
> normal VMs as well. 

It will be better if some detailed example of problems on normal VMs can 
be provided.

> Sean suggested that KVM should introduce a more
> paranoid mode to check CPUID from userspace for VMs in general, as well
> as an opt-in interface for userspace. And TDX should use the
> infrastructure to enforce paranoid mode non-optionally.
 >
> This RFC patch series adds a paranoid CPUID verification mode for KVM on> x86, where KVM must be explicitly aware of every CPUID feature exposed
> to the guest. When the CPUID paranoid mode is opted-in by userspace or
> enforced, KVM will reject any unknown or unsupported feature from
> userspace. And it starts to enforce paranoid CPUID verification for TDX.

Regarding the opt-in interface (for normal VMs), I want to know what the 
benefit it brings for normal VMs when it's opted-in.

If it can make the host more robust or prevent potential attack from 
malicious userspace + guest, then it should certainly be forced on 
instead of userspace to opt-in.

If no good benefit, I doubt any userspace will opt it in. E.g, I can see 
one benefit without the paranoid mode: Userspace can expose the new 
simple x86 Instruction to guest before KVM supports it by adding one 
line of F(xxx) in kvm_initialize_cpu_caps()

> This patch series touches a lot of lines and involves many subtle CPUID
> details. We may not expect reviews on these CPUID leaf specific details
> yet, but feedback is welcome on the framework to build the CPUID overlays
> and how paranoid CPUID verification is implemented.
> 
> The changes are only tested on Intel platforms. Compile-tested only for
> SVM.

Regarding test, can you elaborate more? e.g., did you test the case for 
normal VMs? and what's the configuration of the normal VMs? e.g., the 
"-cpu xxx" parameter if you use QEMU. And if so, can you provide the 
QEMU branch that you used? (so that we can know how much change in QEMU 
is required to enable the paranoid mode)

> The series is organized in following parts:
> ===========================================
> - Patch 1 ~ 2:  Cleanup patches.
> 
> - Patch 3 ~ 11: Construct CPUID overlays
>    This part extends kvm_cpu_caps[] into a 2D array indexed by an "overlay"
>    dimension (CPUID_OL_DEFAULT, CPUID_OL_SVM, CPUID_OL_TDX), allowing
>    each overlay to maintain its own set of supported CPUID features.
>    Having separate overlays for VMX and TDX helps handle cases where
>    KVM's support for certain features differs on Intel-compatible
>    platforms, e.g., HLE, RTM and WAITPKG are not supported for TDX in
>    KVM. There will be new host state clobbering features like this in
>    the future.
>    Having separate overlays for VMX and SVM helps handle cases where a
>    common feature has support on one vendor but not the other. Setting
>    the support in common code requires additional handling in vendor
>    specific code, e.g., SVM code needs to clear IBT, BUS_LOCK_DETECT
>    and MSR_IMM.
>    More overlays could be added in the future if needed.
> 
>    KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID are also promoted
>    to VM-scoped IOCTLs so that userspace can query per-VM-type CPUID
>    capabilities. CPUID overlays are a KVM internal concept; the overlay is
>    decided by VM type and/or platform vendor.
> 
> - Patch 12 ~ 19: Build allowed CPUID values for different overlays
>    This part builds a comprehensive table of allowed CPUID values covering
>    the basic, extended, Centaur, and KVM paravirt CPUID ranges.
>    For each CPUID output register, the validation follows one of three
>    rules:
>    1. Ignored: the register is added to the ignored set and KVM skips
>       validation of the userspace-provided value.
>    2. Mask/value check: a new KVM-only CPUID leaf enum is defined with a
>       corresponding reverse_cpuid[] entry, and an allowed mask or fixed
>       value is initialized per-overlay.
>    3. Zero check: for reserved registers or registers where no bits are
>       supported, userspace input is checked against zero.
> 
> - Patch 20 ~ 25: Implement paranoid CPUID verification
>    This part adds CPUID paranoid verification to reject userspace CPUID
>    configurations that set unsupported or unknown bits when paranoid mode
>    is enabled for a VM.
>    Also, it adds the opt-in interface KVM_CAP_X86_CPUID_PARANOID for
>    userspace and unconditionally enforces CPUID paranoid mode for TDs.
> 
> - Patch 26 ~ 27: Remove the hardcoded filter for TDX.
>    This part removes the hardcoded deny list for unsupported host
>    clobbering features for TDX, and relies on the allowed mask for the TDX
>    overlay to filter and check generically.
> 
> Opens:
> ======
> - CPUID overlays VS. open-code checks for specific features in vendor
>    specific callbacks.
>    Open-code checks for specific features in vendor callback will have
>    less code changes, however, it tightly couples normal VM feature
>    enablement with TDX. If a new host-state-clobbering feature is added
>    for normal VMs, the developer has to remember to update the TDX filter
>    list(s). Or when a common x86 feature is added for only VMX/SVM, the
>    developer has to remember to clear the bit for the other vendor.
>    Relying solely on mailing list reviews to catch these omissions may be
>    more error-prone than using an overlay approach.

I prefer the approach in this series. Require explicitly enabling for 
each overlay will force to provide the justification when enable it.

> - This patch series uses a 2D array in common KVM code to accommodate KVM
>    CPUID capabilities for different overlays. This avoids adding init ops
>    and runtime ops to call into vendor modules for a few reasons:
>    1. kvm_ops_update() is called after ops->hardware_setup(), inside which
>       the KVM CPU capabilities are built, runtime x86 ops can not be
>       called. Need some workaround to allow it.
>    2. These inputs to build the KVM CPU capabilities for overlays are from
>       the common KVM code or via the common KVM code helpers, which make
>       the callbacks in vendor module just duplication of similar tedious
>       code.
>    But conceptually, putting vendor-specific overlay data in the related
>    vendor module is cleaner.
> 
> - This patch combines vCPU capability initialization and paranoid CPUID
>    verification. It refactors the vCPU capability initialization to iterate
>    over userspace CPUID entries rather than reverse_cpuid[], combining the
>    paranoid check with capability setup. The purpose is to avoid iterating
>    over CPUID entries twice for vCPU capability initialization and paranoid
>    check separately. However, this can change the code for vCPU capability
>    initialization a bit even when paranoid mode is disabled. It could be
>    separated if we want to minimize the change for the non-paranoid mode.

I don't think iterate twice matters. It's not hot path anyway. And 
strictly speaking, it iterates two different ranges:

- for paranoid check, it needs to iterate on cpuid_entries[]
- for capability setup, it needs to iterate on reverse_cpuid[]

What's more, I think putting the paranoid check in kvm_check_cpuid() 
fits more naturally.

> - This patch series checks a CPUID register if part of the 32-bit range
>    is reserved. I am not sure this is necessary for all cases. It could be
>    simplified if we believe these reserved bits won’t cause problems
>    according to the property of the CPUID register, so that they can be
>    treated as ignored registers.

I'm not clear on it. Do you mean this series checks the reserved bits 
must be 0?
