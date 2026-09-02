Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833E439351
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344096; cv=none; b=VnklJpCSsOH9T8Eql2Y3qXwfCVcyI+KkahWxhGsU80ShCASQvCXV0waB0GYgfcNEnZLpBG3hGNB1dZm/1ei6t9lHOfTHOhOkm4oxO7msCL3cdIzlnHLPzfiz8IkmYe21pa/ihy5LAWggjh0oCJz+YVuXDs1LrykoZ8sRfV/471Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344096; c=relaxed/simple;
	bh=0oo1wqzF82q5JQZfuhwF7jpKIwtqpn8i98POmVLmVu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbPq/1U3qskybI1qNfRFjlBlfNplyleX0oDtktu2+AchNl68Q9vGtHFOy7L28+uMDPflUsnKOYnDHYoWHn4yehp/0CP0eXCIMwOTp3F+4gnjNpbQFUq/HqWjgGIaJPwRfofBToWX7oNDI/qIVbVIY2clRr4iLIpr1PHXyehPg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5kXt+DL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5kXt+DL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788344092; x=1819880092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oo1wqzF82q5JQZfuhwF7jpKIwtqpn8i98POmVLmVu0=;
  b=A5kXt+DLOcI9i1xL4G2eUNiLX7m0W+RH62N5RKZm3OiTWG0AqSvoR3NN
   BtSybV74jIj2YzeeNTE34pZi4lQcrvcdNTfeTysJWnRLcyrYWaI+AZtPc
   7plqXs8UrFKPABhjLwuvP5n26KZNLTCyYUbXACw91YyzYKMHrQgkA9/ce
   zsuKxhvvkx1R4APrcgHG3fFpz1H7P7ktvJL14fE2wl71cNKu+Jnww8Sp3
   i3F/zodGRcURirWmJq0I7P4EaVNGcETdjIGFjOwGPG2HfCeEqxuM6vj87
   nXXt6j6AxXSoIvwNyvyJoKgldcrSchFPB7Cp7Am4PTt8c+dSYK98gQ1qC
   w==;
X-CSE-ConnectionGUID: WIVs+in6T2y3D8T4qXQVGg==
X-CSE-MsgGUID: kKbUtc+tR6aCEPz7qpUEDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100311453"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="100311453"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:14:50 -0700
X-CSE-ConnectionGUID: SnSMoeG5QHaAuL91f2HrOw==
X-CSE-MsgGUID: O5H/GUblT5CzyATb7XafNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="269389650"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa007.jf.intel.com with ESMTP; 02 Sep 2026 03:14:49 -0700
Date: Wed, 2 Sep 2026 18:14:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
	sohil.mehta@intel.com, xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 1/5] target/i386: Add support for LASS in CPUID
 enumeration
Message-ID: <apf3FycK5uWh+yq5@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-2-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-2-kishen.maloor@intel.com>

On Tue, Aug 25, 2026 at 08:57:30PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:30 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 1/5] target/i386: Add support for LASS in CPUID enumeration
> X-Mailer: git-send-email 2.47.1
> 
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Linear Address Space Separation (LASS) is a security feature that
> prevents a class of side-channel attacks relying on speculative
> accesses across the user/kernel boundary. Paging, along with SMEP
> and SMAP, already provides mode-based access protection, but
> enforcing it requires a page walk whose timing can leak the
> layout of kernel memory.
> 
> LASS applies the equivalent protections during linear-address
> pre-processing, before any page walk. Given the usual partitioning of
> the linear address space into a user half (bit 63 clear) and a
> supervisor half (bit 63 set), an access targeting the opposite half is
> rejected on the basis of bit 63 alone, raising a #GP. LASS is enabled
> via CR4.LASS[bit 27] and applies only in IA-32e mode.
> 
> Feature bit:
>   CPUID.(EAX=7,ECX=1):EAX[6]
> 
> A CPUID_7_1_EAX_LASS macro was previously added in commit 31df29c532a9
> ("i386/tdx: Add supported CPUID bits related to TD Attributes"), but the
> bit was left unnamed in feature_word_info[FEAT_7_1_EAX]. Add the "lass"
> feature name to expose it via -cpu host, -cpu max, or an explicit +lass.
> 
> Exposing LASS to a guest also requires KVM support: KVM must validate
> the CPUID bit and CR4.LASS, and enforce LASS violations in its
> instruction emulator.
> 
> LASS is not implemented in TCG, so the bit is not added to
> TCG_7_1_EAX_FEATURES.
> 
> More details can be found in the Intel 64 and IA-32 Architectures
> Software Developer's Manual, Volume 3A, Section 4.3,
> "Linear-Address-Space Separation (LASS)".
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> [kishen: rewrote commit message, rebased]
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> KVM support for LASS is currently under review:
> https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/
> 
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

