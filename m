Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DC3F5BF3
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796498; cv=none; b=QjVKSUGLbr7HG5IrExx7u/Cp5eJQo+44FwjSqXdtT7T1gILNa0lI/g3/Ml6WySvBAQQ/cq+Q9oh+jHDyvpJIjdHBGflzzLOXz/WcyLvfL0mpznzsS+mN67YBHkvcBU9/LscJmOwe7R8VdwdombLtPfeMdBSmbxL0eNcNDdJSr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796498; c=relaxed/simple;
	bh=P94Z702/lwPf9YzSQ+QPXlwtHz4U2+fGCTzIk5DgTU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEHc0fKAjP1q4PPNwHDoy033InX1Ab49WOVFRUdMmLAFyYvHt2MdMHpulmrZ/nc66dHoECgZzPEApcKnd3PNcD9yVt2V+n21bwuC33Y+/afI3AFwQ2AvGGb7bFgfn01f/hiGBdeuH233AimMgomTzW3zp3R7taLdOgJAfq8qFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chcxUpqT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chcxUpqT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784796497; x=1816332497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P94Z702/lwPf9YzSQ+QPXlwtHz4U2+fGCTzIk5DgTU4=;
  b=chcxUpqT2+o373elcWSSFkmbdyxE1yj+ADHg8vZ6oIwMZlmRD1cgyBFK
   DQpJKWM58VvcyDgw7P95T2AzMgEZQmmA0hu6wnIsFEgptHdxt/ajVsvXf
   2jRKRPZY4KclN6YQA875UNcIOlUEc/caC+QoubTDBbJ6hopZJe2suFx+D
   G0fIltMWstfxUuVQAjsfssjn1sxnmNFkFP64gyd57ys9nUMxoQUgKlFxa
   +4BPapghgU4iGrKk627vxyZ77/XttTxR6hpxiYT5Cd/lay2hu/tg0+ofW
   ne5TOnm0S5GJ0YfuF18gkXb9W2JMZ0HQ7CoJlFkIRbbwwLOY8ffbVVC9w
   Q==;
X-CSE-ConnectionGUID: UFhU2qmXSMSqmD7MpOGlCQ==
X-CSE-MsgGUID: 0Tsmu9gqTJ2Bk7gumqs2tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85206689"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85206689"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 01:48:17 -0700
X-CSE-ConnectionGUID: DvXs+p4UTPm63hKvdODYOQ==
X-CSE-MsgGUID: V4pe5TlwRyGRLavmfbGm8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="253997478"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa006.fm.intel.com with ESMTP; 23 Jul 2026 01:48:15 -0700
Date: Thu, 23 Jul 2026 16:48:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
	mtosatti@redhat.com
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
Message-ID: <amHVTvcDeQXdrIbg@intel.com>
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602140348.774203-2-anderson@allelesecurity.com>

Hi Anderson,

> +    [FEAT_6_ECX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            "aperfmperf", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = { .eax = 6, .reg = R_ECX, },
> +        .tcg_features = 0,
> +        .unmigratable_flags = CPUID_6_ECX_APERFMPERF,

Considerring APER/MPERF passthrough have many specific restrictions
(listed in KVM's api.rst, "7.13 KVM_CAP_X86_DISABLE_EXITS"), I think
we also need not to enable it by default for max/host CPUs:

.no_autoenable_flags = CPUID_6_ECX_APERFMPERF

This indicates that users must manually enable this feature, and it is
assumed that they are aware of its limitations and have implemented
appropriate policies (such as no preemption, vCPU affinity, no idle or
C state in the guest, etc.).

> +    },

...

>  /* CPUID[0x80000007].EDX flags: */
>  #define CPUID_APM_INVTSC       (1U << 8)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9e352882c8..ca722ff9e9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          }
>      } else if (function == 6 && reg == R_EAX) {
>          ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
> +    } else if (function == 6 && reg == R_ECX) {
> +        ret |= CPUID_6_ECX_APERFMPERF;

if we bind this feature to cpu-pm, then we should check enable_cpu_pm
before setting CPUID. Otherwise, if this CPUID is present but
cpu-pm=off, Guest may try to access related MSRs and triggers #GP.

        if (enable_cpu_pm) {
            int disable_exits = kvm_check_extension(s,
                                                    KVM_CAP_X86_DISABLE_EXITS);

            if (disable_exits & KVM_X86_DISABLE_EXITS_APERFMPERF) {
                ret |= CPUID_6_ECX_APERFMPERF;
            }
        }

But on the other hande, maybe we don't need to bind this feature to
cpu-pm?

For example, a compute-intensive workload doesn't allow the Guest to
enter idle, then it still seems make sense to estimate performance
using aperf and mperf?

Thanks,
Zhao

