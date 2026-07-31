Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF435E929
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477325; cv=none; b=LmTXAU49SqlKo3Guzvzwwbyfh3kIlOdT97R4HH5orBKRH04vBi2dhaX3e7W8tiiUhN8epuXmR++U+xkhtzyohP4V/WCWq5kfj9uqMdil3Jlja+YO1f/u6XBA1iuBUCGOZnJ8d6Di2Rs9VDbFpOgmGVHPQXNxdK6t2xCGItzNGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477325; c=relaxed/simple;
	bh=ELP27T7CzJ7pekqWXnrxNQUz7POvRwTX+9GwDoK/zbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQYryAKVX87MachmaW1WZIXw4iNsuc3zQzCcOFNPFJlFGpW3vil2/t1szi/x8zKQM30cHsQLypknPq9FoQXp4+TYjrE1M/er+9mQicD0XOfRz4egKrtC8SujpZPidvpnSMC2BZGw3bTJKhjNr1HRXuWW6PE9arq7NAIK7Y1jvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jip04RGC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jip04RGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477324; x=1817013324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ELP27T7CzJ7pekqWXnrxNQUz7POvRwTX+9GwDoK/zbE=;
  b=Jip04RGCUkNpqE2U+I0sGJms6j3iTZMEv/92CMzmpb4jZsjDXu/AhHrR
   JofnbwBzl9+FmV/NKiIenX+CW1TpAhv5hRx7Z8rAmYi0WKPgThwOINgN/
   7GZihJWQhxQdZ+9k1Tw746OWMYeKydFEOYzSukJLat6cimIto9iw8Zg8N
   IjHfW4LVF2V++D2Dju3WQYkNVGwRr3FCW8zHvgIIfz/a/KyauZol+iLKv
   m+Lg4PnK0vFE+vy5BMnTsKqrpXZuS8tnWJn7sVgTXus9RsqGjLl6MgbBv
   fz3nBHQ8qOk9GpDL5/MkKg78uHstqMrdgtwdxy05iuRoedJnb2762W8uk
   w==;
X-CSE-ConnectionGUID: Lh4xGm7mTKOsYK6tMLfZnA==
X-CSE-MsgGUID: JicJRPwVSXuw56LyPojOjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89781925"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89781925"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:55:23 -0700
X-CSE-ConnectionGUID: gL3LxDFUQGqam9BTzI7Ekw==
X-CSE-MsgGUID: vazUCHOIR4mqV+a7lYocZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="262463620"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jul 2026 22:55:21 -0700
Date: Fri, 31 Jul 2026 13:55:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v1 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Message-ID: <amw4x/BFXEJMwbI9@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-6-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-6-zhang_wei@open-hieco.net>

Hello Tina,

> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8e2bfbbe1d..215e0c8f03 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2175,6 +2175,21 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
>      }
>  }
>  
> +/*
> + * KVM exposes the AMD PMU CPUID/MSR layout for Hygon guests, so QEMU must
> + * use the AMD PMU setup and MSR state paths for Hygon too.
> + */
> +static bool kvm_pmu_uses_amd_msrs(const CPUX86State *env)
> +{
> +    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
> +}
> +
> +static bool host_cpu_uses_amd_pmu_msrs(const char *host_vendor)
> +{
> +    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
> +           g_str_equal(host_vendor, CPUID_VENDOR_HYGON);
> +}
>
>  static bool is_host_compat_vendor(CPUX86State *env)
>  {
>      char host_vendor[CPUID_VENDOR_SZ + 1];
> @@ -2191,8 +2206,8 @@ static bool is_host_compat_vendor(CPUX86State *env)
>          return true;
>      }
>
> -    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
> -           IS_AMD_CPU(env);
> +    return host_cpu_uses_amd_pmu_msrs(host_vendor) &&
> +           kvm_pmu_uses_amd_msrs(env);
>  }

It seems to be doing the same thing as the previous Intel & Zhaoxin
compatibility check.

To unify similar checks, how about we abstract them into the "PMU vendor
family"?

For example,

typedef enum {
    X86_PMU_VENDOR_UNKNOWN,
    X86_PMU_VENDOR_INTEL,
    X86_PMU_VENDOR_AMD,
} X86PMUVendor;

static X86PMUVendor x86_cpu_pmu_vendor(const CPUX86State *env)
{
    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
        return X86_PMU_VENDOR_INTEL;
    }
    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
        return X86_PMU_VENDOR_AMD;
    }
    return X86_PMU_VENDOR_UNKNOWN;
}

static X86PMUVendor x86_host_pmu_vendor(void)
{
    char host_vendor[CPUID_VENDOR_SZ + 1];

    host_cpu_vendor_fms(host_vendor, NULL, NULL, NULL);

    if (g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) {
        return X86_PMU_VENDOR_INTEL;
    }

    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
        g_str_equal(host_vendor, CPUID_VENDOR_HYGON)) {
        return X86_PMU_VENDOR_AMD;
    }
    return X86_PMU_VENDOR_UNKNOWN;
}

/*
 * The guest vPMU can be virtualized only when the host and guest's PMU
 * architectures are compatible.
 */
static bool is_host_compat_vendor(CPUX86State *env)
{
    X86PMUVendor guest = x86_cpu_pmu_vendor(env);

    return guest != X86_PMU_VENDOR_UNKNOWN && guest == x86_host_pmu_vendor();
}

>  static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
> @@ -2222,7 +2237,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
>  
>      if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
>          kvm_init_pmu_info_intel(cpuid);
> -    } else if (IS_AMD_CPU(env)) {
> +    } else if (kvm_pmu_uses_amd_msrs(env)) {
>          kvm_init_pmu_info_amd(cpuid, cpu);
>      }
>  }

Then such CPU check can be replaced with:

    switch (x86_cpu_pmu_vendor(env)) {
    case X86_PMU_VENDOR_INTEL:
        kvm_init_pmu_info_intel(cpuid);
        break;
    case X86_PMU_VENDOR_AMD:
        kvm_init_pmu_info_amd(cpuid, cpu);
        break;
    default:
        g_assert_not_reached();
    }

The latter can also be replaced with "x86_cpu_pmu_vendor(env) ==
X86_PMU_VENDOR_AMD" instead of the "kvm_pmu_uses_amd_msrs(env)" you're
currently using.

What do you think?

Regards,
Zhao
