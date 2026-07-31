Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB048987C
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481365; cv=none; b=PWh/y/XSWi8J3y3MNJUv2GbK+J5f+ZV4NkUmD2v2zo+Dir4V7aBiJ48ztTPzehlaTd+FKF8e8SuBfJWStfzDXGVbTALvfL1nISU5jEp6SRZqnbvRHNAi7fIR4+Ogqzo8p1HBuXB7e/1xTwj8n1lR/M9LeNYMdTT1GQNf2QwV3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481365; c=relaxed/simple;
	bh=q+bBhFiR/a3Yhx/IQoWPqSv6sYswYpdvscBkOWh1GY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2y0XP63PU85cxkDKRFDCAwMRdgwItqMjRR8Qn4eYjALkd+eAo66p4Lc4F5Plgk/venFUooDNdo9LHIsHbLGKQreQHXH2jr3/hcnV/d2cXT8fkr+8O/Lcj57NxW5d3lXmnhhM3QVcCinG5P9X29ILsaP7nkgMJXqVnTQEaAcjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLgF6BRt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLgF6BRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785481363; x=1817017363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=q+bBhFiR/a3Yhx/IQoWPqSv6sYswYpdvscBkOWh1GY0=;
  b=BLgF6BRtV7AJVZKVnJEpDHpcMfQqoA+xBkhvA/bkGoBFSm3TQyKCHlRw
   +xFgFiGdR4cCRhwFj3qfPjD1HHp0bJfYt+ovSXoUnIBbBL186TNiAx/+/
   JemYBNMSrFi+F/QstpsHJiYQJOgyPsq13NAGzMztd+waNph2Vu0jbyhnv
   CMeo1QjFJ/8DvXJgwtvSitvFpWoN8GDF7+NaEboY/NGkLXBHfM/EvVyV7
   EZFVFFNQK2AeCDp8cznXbVWMcesPepDAa7RF9Aez3L52r/lLZ+zs++lCd
   VKs5Uwf0pqAKsMaQjDFO9TYSmVUMg5GW8Fn23byBQiQjUwlf6sPcBEErq
   A==;
X-CSE-ConnectionGUID: Wp3lq163RmWfj3XbywzT2Q==
X-CSE-MsgGUID: HC5rFHpbTmCf6qsd/A3rQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="108897382"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="108897382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 00:02:42 -0700
X-CSE-ConnectionGUID: uDImOzGnRGO6la07l3fwJw==
X-CSE-MsgGUID: +OEGw4F1Q2OziMuRltsWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="261116799"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2026 00:02:41 -0700
Date: Fri, 31 Jul 2026 15:02:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v1 1/9] target/i386: Sync AMD CPUID aliases for Hygon
Message-ID: <amxIj+rZvDrtX7BM@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-2-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706055530.1752094-2-zhang_wei@open-hieco.net>

> -GlobalProperty pc_compat_11_0[] = {};
> +GlobalProperty pc_compat_11_0[] = {
> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
> +};

This needs rebase on v11.1 :)

>  const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>  
>  GlobalProperty pc_compat_10_2[] = {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5805d33ab9..32b8bc9ebd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8608,6 +8608,20 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
>      }
>  }
>  
> +/*
> + * AMD CPUs define CPUID[0x80000001].EDX aliases for selected CPUID[1].EDX
> + * feature bits.  Hygon Dhyana follows the same extended feature alias rules.
> + * Enable the corrected Hygon behavior only for machine types where Hygon
> + * vendor ABI fixes are on.
> + */
> +static bool x86_cpu_has_amd_cpuid_aliases(const X86CPU *cpu)
> +{
> +    const CPUX86State *env = &cpu->env;
> +
> +    return IS_AMD_CPU(env) ||
> +           (cpu->hygon_vendor_abi_fixes && IS_HYGON_CPU(env));
> +}
> +
>  void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                     uint32_t *eax, uint32_t *ebx,
>                     uint32_t *ecx, uint32_t *edx)
> @@ -10147,10 +10161,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
> -     * CPUID[1].EDX.
> +    /*
> +     * CPUs that use AMD-compatible extended CPUID aliases must keep selected
> +     * CPUID[0x80000001].EDX bits synchronized with CPUID[1].EDX.
>       */
> -    if (IS_AMD_CPU(env)) {
> +    if (x86_cpu_has_amd_cpuid_aliases(cpu)) {

Or we can omit this helper ("x86_cpu_has_amd_cpuid_aliases(cpu)") and
instead do the check directly inline?

I think we should have fewer helpers like this, unless the conditional
checks are really lengthy... Since the helpers added for each ABI is
similar, but we can¡¯t consolidate them into a single generic helper
(because while the AMD and Hygon ABIs are basically similar, there are
still differences), having too many similar helpers makes the code seem
fragmented.

> @@ -2461,6 +2467,12 @@ struct ArchCPU {
>       */
>      bool vendor_cpuid_only_v2;
>  
> +    /*
> +     * Enable Hygon vendor ABI fixes for new machine types.  Old machine
> +     * types disable this to preserve guest-visible CPU ABI.
> +     */
> +    bool hygon_vendor_abi_fixes;
> +

Maybe the following comment to emphasize this is a compat option?

/*
 * Compatibility bits for old machine types: if true, apply Hygon
 * vendor-specific ABI fixes.  Old machine types disable this to
 * preserve the guest-visible CPU ABI.
 */

>      /* Only advertise TOPOEXT features that AMD defines */
>      bool amd_topoext_features_only;
>  
> diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
> index 17c0965827..b7f8834052 100644
> --- a/tests/qtest/test-x86-cpuid-compat.c
> +++ b/tests/qtest/test-x86-cpuid-compat.c
> @@ -113,6 +113,21 @@ typedef struct FeatureTestArgs {
>      bool expected_value;
>  } FeatureTestArgs;
>  
> +typedef struct BoolPropTestArgs {
> +    /* Test name */
> +    const char *name;
> +    /* CPU type */
> +    const char *cpu;
> +    /* CPU features (may be NULL) */
> +    const char *cpufeat;
> +    /* machine type (may be NULL to use default machine) */
> +    const char *machine;
> +    /* CPU property to read */
> +    const char *property;
> +    /* expected value of the property */
> +    bool expected_value;
> +} BoolPropTestArgs;

Good test!

Regards,
Zhao

