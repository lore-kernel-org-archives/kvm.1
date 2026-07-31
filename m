Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C036D9FE
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481739; cv=none; b=C+ZLvGj+xXdL3vDE2qnjkXtlsGcKUoF0RtgUEds4gp56Q2AjO1kpacSgNpNItcT8776fvU7VumfKsU5XK8veHMVS6XdYD1HHgyknCgLUdbFb5TVKLD0Mn2eDvYGjp4m7bwB0CmJhedHUSBh9CoiQW+00v9P9qDHx1beNcGqjm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481739; c=relaxed/simple;
	bh=ZfkmrXDF8nASwD6vtOWXhAlfiFwV9JT2BPLpEGdXUbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoKA8iVeRoJehuaNhSH/INitJ6MiTQG9+L70+gyityupw/FJCWAkyrssg8AaHg2iCeD5zGgxRK18kZ+PfxUGe59A5EqKvWdKQnTkQCCOm0sRIJ9YuiJ1pa1pmEgyJM1gL94W8k4OWaK3AzXLgVfpj3LAK+ErSeHRWOye+PJJgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iV2I4GGi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iV2I4GGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785481738; x=1817017738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfkmrXDF8nASwD6vtOWXhAlfiFwV9JT2BPLpEGdXUbw=;
  b=iV2I4GGiJphWQ4iCwNdEJb9c/p6qK90VrQaOmHp0SKMj8rTKUiaRML2E
   pGzrd/6amNkO9Fz8A+ERK8jtcgPdjYWOnNsxtTlhaM1U3/yKiqgj4reN9
   HvXOhyRI1VRUvqIKEVAJhiZ55Bgx2XGrULOwbcoVYR8d+zogIeEpEAnFN
   rtUuAJ+3nbJCrXbwugnjlNPr1j/53Yzi5pz14+jUqcG+KRNxPfC9WmYQj
   bzroYW1tQcNQlY7bLK+YqmcM92KIABzj8zyy7FdJfGZa29mmjqKLIdJoK
   ab7f0sPh7M5gGB1nN0bgSwzVdyDSFoMEs7mPZxa3xMtEKhaa+l3TyoZdI
   w==;
X-CSE-ConnectionGUID: tF84b4V2TbKV1KJ+HmPIKA==
X-CSE-MsgGUID: G6dlk0FbTL6xncTZHuX97Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85978975"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="85978975"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 00:08:57 -0700
X-CSE-ConnectionGUID: aoHWJ+x5T3+SbffF+QVMYA==
X-CSE-MsgGUID: QRd2/T6LTtaZq6qP9/6r9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="259928929"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa008.jf.intel.com with ESMTP; 31 Jul 2026 00:08:56 -0700
Date: Fri, 31 Jul 2026 15:08:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 8/9] target/i386: Use AMD legacy cache fallback for
 Hygon
Message-ID: <amxKB6CmYaAvk/CX@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-9-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-9-zhang_wei@open-hieco.net>

On Mon, Jul 06, 2026 at 01:55:29PM +0800, zhang_wei@open-hieco.net wrote:
> Date: Mon,  6 Jul 2026 13:55:29 +0800
> From: zhang_wei@open-hieco.net
> Subject: [PATCH v1 8/9] target/i386: Use AMD legacy cache fallback for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> From: Tina Zhang <zhang_wei@open-hieco.net>
> 
> When legacy-cache=on, x86_cpu_realizefn() builds a hardcoded cache
> model.  It selected the AMD legacy cache table only for CPUs with the
> AuthenticAMD vendor ID.  Dhyana uses the HygonGenuine vendor ID, so this
> explicit compatibility path fell back to QEMU's old Intel legacy cache
> table.
> 
> The wrong table is visible through AMD extended cache leaves.  With the
> Intel legacy table, Dhyana reports 32 KiB, 8-way L1 caches in CPUID
> 0x80000005 and a 4 MiB, 16-way L2 cache in CPUID 0x80000006.  Linux
> uses the AMD/Hygon cache enumeration path for Hygon and reads these AMD
> extended cache leaves.
> 
> Use the AMD legacy cache table for Hygon in this fallback path when the
> new Hygon vendor ABI fixes are enabled.
> Keep the old fallback for pc-11.0 and
> older machine types through x-hygon-vendor-abi-fixes=false.
> 
> The default Dhyana model is unchanged because it provides EPYC cache_info
> and therefore defaults legacy-cache to off.  The guest-visible change is
> limited to users who explicitly configure legacy-cache=on on new machine
> types.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

