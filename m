Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268264
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787474871; cv=none; b=Dn/FKP9OjOLB/C8YD6zSsVLKKen9pJD9E2e+0NOLEZdDeLC4GrGz6dqLjAB+46yiFv8VvFP1XSe7n0M+UL/2aACrBvGQBI5gnrG8eT02JBy62MFKz3xSct5VOFZ4TxySyFppkTL2rtOmgzcjdkEUeePVwARvNj6lxj/YqAceix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787474871; c=relaxed/simple;
	bh=V7UKv8CSb7uP/LVs/3DphfIxtGergNcv6nDGxcjSJqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeF+hsZJFZySVk0qcHi2nj+zLseUe1xTbh5Ub0pSeKhkvMronl6aYhg5bfFpAxbivshHWTrQXqw2tVXswqMLoOvSA6SyXJ/aqWU8j6RLVNCQlUADnhWhK1j/l1axwbeQ62iWWPTTphzTkaRqxJFK/po0a7SBkPJh0zHIYBJmBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoUsa6DX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoUsa6DX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787474869; x=1819010869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7UKv8CSb7uP/LVs/3DphfIxtGergNcv6nDGxcjSJqY=;
  b=AoUsa6DXOlUSq+sc36fiPgBuC+9Ct6tGZrOng0jZWBnPHu4MA1jUp9n1
   5rKIWbqaAROJ75/ZSwA3wYgB9jlxSFxuEZDpZc7eskVqh3ouBNsRqRzEJ
   QnGkuKuJ6EblgDCFhBVTg83m+2jMadfmnELulrqF4vyxxDG6ekPGXPNHV
   JjERsvZB45Et9NxWJLlUBbmiEmJ6P6+oCFyyx0y5Dj0zlb/kvjDn8jGjH
   i0SRCJoDO2DrZ2E5QXBF7MpsiAsN8XYVsOcmbiElHAKrvbV2vvpkozu0H
   7KZ7hA8L+kKyrkLZp+RBFKLb/Dhe1aBElFIZ1PGvu2GifcQXaa9Xm5zm4
   Q==;
X-CSE-ConnectionGUID: zatN4whdQd6WNeKdfxNd0g==
X-CSE-MsgGUID: ClO/8yLiQLmaQu/ZGo05ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87070490"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="87070490"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:47:48 -0700
X-CSE-ConnectionGUID: 5Azxb7IQTsm9IztPQP+mfw==
X-CSE-MsgGUID: 4pPO+FpXT3muTTr6ao2dEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="265425607"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa010.jf.intel.com with ESMTP; 23 Aug 2026 01:47:45 -0700
Date: Sun, 23 Aug 2026 16:47:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Yongwei Xu <xuyongwei@open-hieco.net>
Subject: Re: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
Message-ID: <aoqzsAC5dBBuLQ8h@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-2-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-2-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:48PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:48 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
> CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
> guest CPU vendor is AuthenticAMD.
> 
> Hygon Dhyana uses the HygonGenuine vendor string, but implements the
> same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
> advertising a feature in CPUID[1].EDX while the matching extended alias
> in CPUID[0x80000001].EDX stays clear.  This inconsistent CPUID state can
> confuse guest OS feature detection.
> 
> Apply the alias synchronization to Hygon CPUs as well.  Gate the new
> behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.0 and
                                                            ^^^^^^^
nit: pc-11.1 ?

> older machine types, because the CPUID result is guest-visible ABI and
> must remain migration-compatible.
> 
> Add qtest coverage for the Dhyana model, including the compat property.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
> ---
>  hw/i386/pc.c                        |  5 ++
>  hw/i386/pc_piix.c                   |  1 +
>  hw/i386/pc_q35.c                    |  1 +
>  include/hw/i386/pc.h                |  3 ++
>  target/i386/cpu.c                   | 10 ++--
>  target/i386/cpu.h                   | 13 +++++
>  tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
>  7 files changed, 106 insertions(+), 3 deletions(-)
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f064aa2b3e..2b4e322b2f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,11 @@
>  #include "hw/xen/xen-bus.h"
>  #endif
>  
> +GlobalProperty pc_compat_11_1[] = {
> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
> +};
> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
> +

compat machine property is already on the master branch, so this
patch need to be rebased.

>  GlobalProperty pc_compat_11_0[] = {};
>  const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb16..8e58f2a7ee 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -438,6 +438,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
>  static void pc_i440fx_machine_11_0_options(MachineClass *m)
>  {
>      pc_i440fx_machine_11_1_options(m);

pc_i440fx_machine_11_1_options() has added pc_compat_11_1...

> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);

...so taht now we don't need ao do this again.

>      compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>      compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6c1e4eff5f..fd4366f51f 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -393,6 +393,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
>  static void pc_q35_machine_11_0_options(MachineClass *m)
>  {
>      pc_q35_machine_11_1_options(m);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);

ditto.

>      compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>      compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>  }

Overall, LGTM except rebasing :).

Regards,
Zhao

