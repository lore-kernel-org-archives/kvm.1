Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879EC1F151C
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844428; cv=none; b=jkjtTEtCnMDhX4pdqMpkY6TvtEQFvNjcTJjq7qqh/nXVjpNRNbx2x4SY9iZQSUpbVyjYdrgYVMxKKYuHznjM/ZNEHdvsQ7Wt6FgQllN6BxeoL1u0mpOh6V5kSHACH3kOGjyNoWlTGfFiN23o1DWsurUbwI5EQilZnaImgt0qs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844428; c=relaxed/simple;
	bh=r2pZ45WaoLdd62U4o1lqu1UiwYsdm9zBkrbUIa1Vv80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT3bbr5bsltuOGOL1MHEqyJYWLxPvx69UhQ7rLQwqNRu+5biWSahITG+XGE4GhHghD8rxZMTC9GBzYq+niSPpiy/uCXwVaJIuMAUADTkwIfWCm54PSaimFzNyL/3AzByNpNDgBLa3boASJSJ/sXSuxMJqsUNm1HlLiQ/XVykFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr5uGEqI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr5uGEqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776844427; x=1808380427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2pZ45WaoLdd62U4o1lqu1UiwYsdm9zBkrbUIa1Vv80=;
  b=Vr5uGEqIr43GY3ePLU0RIeW8m6gLhGNBPHQNsErhA3vJvgXY19NP9gA2
   d2c5SHMH9PCAID/Ac2FC7yMqzVjkhVTqOckWBhttEhBEmTzzxsXknZI1x
   ZhRuRW7PgZsonOQOm53KRdXi0bA4mBzLGz/2ychegRReyCm5/yADVHRLn
   Y6UrHvKNOfmmcUXI3P9AOyfFQXZPuRhvr/MinagJujiC5yYPqFJ4I3cFI
   DhZUbxpNviUJulZhNHpAVuBBuaG5xo3xGfppEQZWQQehgUbK0yrj8NX4A
   9ULwgcFFGN5JqZdLA9qQKLG+NjUqsV/RyYqg3vgsdoDESBVrxDmvkeznv
   g==;
X-CSE-ConnectionGUID: k3/eukVZTVCVJ1Br5rDwRw==
X-CSE-MsgGUID: ee9PEl0uSUWG76Ckf+9Lcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77494784"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77494784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:53:47 -0700
X-CSE-ConnectionGUID: qDdjn8KCSN29ReDAN20Xqw==
X-CSE-MsgGUID: cpN69CZ8RoKOyENbweVGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236649745"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by orviesa004.jf.intel.com with ESMTP; 22 Apr 2026 00:53:43 -0700
Date: Wed, 22 Apr 2026 16:21:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Sandipan Das <sandipan.das@amd.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
Message-ID: <aeiE9ZZ5AE+uMgmN@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-12-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304180713.360471-12-zide.chen@intel.com>

Hi Zide,

On Wed, Mar 04, 2026 at 10:07:10AM -0800, Zide Chen wrote:
> Date: Wed, 4 Mar 2026 10:07:10 -0800
> From: Zide Chen <zide.chen@intel.com>
> Subject: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
> X-Mailer: git-send-email 2.53.0
> 
> Similar to lbr-fmt, target/i386 does not support multi-bit CPU
> properties, so the PEBS record format cannot be exposed as a
> user-visible CPU feature.
> 
> Add a pebs-fmt option to allow users to specify the PEBS format via the
> command line.  Since the PEBS state is part of the vmstate, this option
> is considered migratable.
> 
> We do not support PEBS record format 0.  Although it is a valid format
> on some very old CPUs, it is unlikely to be used in practice.  This
> allows pebs-fmt=0 to be used to explicitly disable PEBS in the case of
> migratable=off.
> 
> If PEBS is not enabled, mark it as unavailable in IA32_MISC_ENABLE and
> clear the PEBS-related bits in IA32_PERF_CAPABILITIES.
> 
> If migratable=on on PEBS capable host and pmu is enabled:
> - PEBS is disabled if pebs-fmt is not specified or pebs-fmt=0.
> - PEBS is enabled if pebs-fmt is set to the same value as the host.
> 
> When migratable=off, the behavior is similar, except that omitting
> the pebs-fmt option does not disable PEBS.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>

...

>      if (user_req != -1) {
> +        if (!is_lbr_fmt && !(env->features[FEAT_1_EDX] & CPUID_DTS)) {
> +            error_setg(errp, "vPMU: %s is unsupported without Debug Store", name);
> +            return false;
> +        }
> +

This is a general code path to check user_req != -1... but

> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 1d0047d037c7..60bf3899852a 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -231,6 +231,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>      }
>  
>      cpu->lbr_fmt = -1;
> +    cpu->pebs_fmt = -1;

-1 is only set for KVM, so other accelerators have lbr_fmt=0 by default.

This will cause make check fail:

stderr:
qemu-system-x86_64: vPMU: pebs is unsupported without Debug Store
Broken pipe
../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

(test program exited with status code -6)

So I think the initialization should be placed in the general code path
as well (x86_cpu_initfn()) - and move lbr_fmt initialization back to
general x86 codes.

Thanks,
Zhao

