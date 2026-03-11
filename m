Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8FD346FB7;
	Wed, 11 Mar 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250078; cv=none; b=GDM70MZFQLR81ydY+Azjpc9+rQSx7I+y71+opDeeoh2gLmnsRjKwXeyrAa0rv7UIoOocDpgvjZgwFNXWsVym81ZDPy3fVHLTZ2fRwDPcYjf0ZIz0fBQr8Or2ZFu2VUOiv403qK/0dz6Plnzn0+imCG6PjgqvevZZlMCqWoQgdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250078; c=relaxed/simple;
	bh=WUYnYiKE9cGCy2RocdOT1zvMHRjHAOTv+riMVOrsBYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m09/vPWnkhKtkJZlzc/BV/YeRs8L1+bSh+qvCeQ+rELYb7zNpIZfaloNBjYZoqgXeDmPxLhQfBt5fUmd0g2ws4YywurBoCY2/7pgNO+ku7z3bH6R2n8XbAdKvUnCFkFrJe+n2e7cdqXob5YLS9XraZO3q70ylF2M+FgC0MGgfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Clzd1r0n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Clzd1r0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773250076; x=1804786076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WUYnYiKE9cGCy2RocdOT1zvMHRjHAOTv+riMVOrsBYs=;
  b=Clzd1r0nw0e9GHTqrQcq+CplaD3wZlMTlDjsrStgBpT96Y1ylB746+tz
   QbW8wXY5kyb4LO0x4gztyG1JW7BFd++XProz6M6DI2e4xSRIGHW4CtTlw
   HWRQa/om4rRizoUQzPVjgcBSXInzcPsN6HwnlxFvdHrdpM37HBi7r5JUy
   D0VHS0quxs3pnpiRgHqpiF2UsvsVJH0a0eVGAAJItbXczKJTLACqvoUBC
   8zmXehaUDmG590vatTqJtsYp0/4dmkitK15HMm//zULX2zl3znrr+Zjim
   KiAn9b3GyG82yLi7Yuw/RH4RS6vc8fW/cbyA20eJy9jHu00SjadBaPr4Y
   A==;
X-CSE-ConnectionGUID: vQOhqhocQOWkvB0vk3OJ+A==
X-CSE-MsgGUID: 3+nblDKORa2z0B2aUrpwMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="77933598"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="77933598"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:27:56 -0700
X-CSE-ConnectionGUID: /h6cunJFTLKvGaPvkCGgKg==
X-CSE-MsgGUID: kjOrQwWSR72wtVQtuEWaDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="224686305"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.84]) ([10.125.110.84])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:27:56 -0700
Message-ID: <cb492a37-3517-4738-b435-73311402e820@intel.com>
Date: Wed, 11 Mar 2026 10:28:09 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/cpu: Disable CR pinning during CPU bringup
To: "Nikunj A. Dadhania" <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com, xin@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, x86@kernel.org,
 sohil.mehta@intel.com, jon.grimm@amd.com
References: <20260226092349.803491-1-nikunj@amd.com>
 <20260226092349.803491-2-nikunj@amd.com>
 <20260309134640.GOaa7PQJli_C9QATGB@fat_crate.local>
 <cde957ba-3579-4063-9d17-3630e79ea388@intel.com>
 <20260309161516.GAaa7yFMulhdzNQ-pt@fat_crate.local>
 <70644e1d-dd0e-4f0f-81c0-fd095e46e50b@intel.com>
 <7ca205d6-b01b-4ed3-959d-db31a6496d79@amd.com>
 <505a6bbd-3ecf-4de9-8fb9-0b21c3435a96@intel.com>
 <9fa61b80-0e16-4a87-a0e7-3c3dfcda8f7e@amd.com>
 <55a98b6d-e831-47a6-aa5a-8fe357334f67@intel.com>
 <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <d0eba3fe-2938-4856-bd9b-0e13972e8313@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/26 08:42, Nikunj A. Dadhania wrote:
> -void cr4_init(void)
> +void cr4_init(bool boot_cpu)

I think the "pass a bool to a function" pattern is really not great.

The problem isn't actually setting CR4 twice. The problem is having two
different code paths to set it. Doing the 'bool' doesn't eliminate the
code path, it just makes the whole thing more complicated to reason
about and further bifurcates the boot and secondary CPU bringup paths.

We want to unify those, not bifurcate them.

Why don't we just universally set X86_CR4_FSGSBASE in cr4_init()?

BTW, commit c7ad5ad297e tells some of the tales of woe around CR4 and
boot vs. secondary CPUs:

	cpu_init() is weird: it's called rather late (after early
	identification and after most MMU state is initialized) on the
	boot CPU but is called extremely early (before identification)
	on secondary CPUs.

This weirdness is still biting us today. CR4 pinning just made things
worse (or at least harder to understand).

I have the feeling we need to bite the bullet here and actually start
thinking about this holistically. I _think_ 'mmu_cr4_features' is
conceptually pretty close to what we need. It's just named wrong.

/*
 * Current system-wide configuration information for CR4 register.
 * All of the bits in these feature masks are supported by the current
 * running CPU.
 */
struct cr4_config {
	/*
	 * Features that are needed in early assembly like the
	 * trampoline. These should not have side effects or interact
	 * with other features.
	 *
	 * Only written by the boot CPU. Establishes bringup value on
	 * secondary CPUs.
	 */
	unsigned long early_features;

	/*
	 * Features that get enabled from C code: cr4_late_init().
	 * Anything with early side-effects that can't be in the
	 * early set.
	 */
	unsigned long late_features;

	/*
	 * Features that do not work in real-mode.
	 */
	unsigned long realmode_incompat_features;

	/*
	 * Points into the real mode trampoline header. Write to this
	 * every time 'early_features' is updated. (maybe??)
	 */
	unsigned long *trampoline_features_target;

	/*
	 * Features that are always on when userspace is running.
	 * CR4 manipulation functions will notice if these bits get
	 * cleared, restore them and WARN().
	 */
	unsigned long pinned_features;
};


Then instead of sprinkling code around like:

        /*
         * This function is called before exiting to real-mode and that
	 * will
         * fail with CR4.PCIDE still set.
         */
        if (boot_cpu_has(X86_FEATURE_PCID))
                cr4_clear_bits(X86_CR4_PCIDE);

We can do *ALL* the PCID setup in one place:

void boot_cpu_setup_pcid()
{
	if (!boot_cpu_has(X86_FEATURE_PCID))
		return;

	/* PCID is not needed in early bringup, only enable it late: */
	cr4_config.late_features |= X86_CR4_PCIDE;

	/*
	 * PCIDE needs CR0.PG=1, which is not true in real mode.
	 * Ensure it is disabled in real mode:
	 */
	cr4_config.realmode_incompat_features |= X86_CR4_PCIDE;

	__write_cr4(cr4);
        /* Initialize cr4 shadow for this CPU. */
        this_cpu_write(cpu_tlbstate.cr4, cr4);
}

and the read-mode entry becomes:

	cr4_clear_bits(cr4_config.realmode_incompat_features);

What do folks think? Can we expand the 'mmu_cr4_features' to more than
MMU features?
