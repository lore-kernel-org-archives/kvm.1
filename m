Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32237B019
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549808; cv=none; b=cMyN/cOvt1VpIV7/gGGO6jl0ESrHvKEzD38XnwgnwBImduS5OdWc9/E+F+5zRu7M2IeY67ovAeJyaN/roPvJokUrLs/99Q5BAkBHSqNOk24vqtL96cLGqtps8+7xWd6LtscJov8ty2APUawYIoVu28CjOaVQ0yNh28LlMWFydk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549808; c=relaxed/simple;
	bh=OzBmje/LGNWvTvM0XPtRiX5VSU/TrOMTu/DYVMxTT4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgZ7ds48HGseEjNXeFRLxf9TvsTR45SXmWKqnoXZC4G6HhC3odFybRk6UnZHy2SVOMq7nzu/3Y/CvvSoD3dbqoQpyl4pfpTA5Ym2Pmn0O+Oz0R/EdwRoKxjYd07GajABlYzSuOV38cEDAPK9n/0fZbW1FC0nG1ihJYwGSpk9g7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=am654Bks; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am654Bks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787549806; x=1819085806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OzBmje/LGNWvTvM0XPtRiX5VSU/TrOMTu/DYVMxTT4Y=;
  b=am654BkswPgYkgc7bDgoyVVaSWwPEEwRjP/bIwR0QzNTSTsUVlyxKtzQ
   BH29rfoZZSyfrb2/nxkkNzL4KpdjfbfVCpn3BxLWjxL9qXzaL2G1leOYv
   dEhBUaWVBSAaxEM33oZzALb9+SrFGqbBaJQHjwO/koDVzHEXREgPuXh6y
   paNbDhzrwUpX53uUf9Nv5ifNJgGfutWk/4JgneWXS+d2A27/1YLuesshL
   p2PKCmcwUhEffOHKDANIJzKprkadNsaWLdozkhTbHjd74lKNOBrX4PlkL
   XBwwa0o4c/Rc18aC5I9i8928+4pUuq5laLn3VYunZ1S+4/f8lNsaO3V6+
   g==;
X-CSE-ConnectionGUID: bshxhuh7Q7qWstbe5NZz1g==
X-CSE-MsgGUID: aZ58ylPnSaaKk9FTpoS9Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98581933"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98581933"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:36:46 -0700
X-CSE-ConnectionGUID: WlY4WI9aQhmHFBNRoZgxyg==
X-CSE-MsgGUID: +z5jhLCXR2y83XkgdxlNag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265119094"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa006.jf.intel.com with ESMTP; 23 Aug 2026 22:36:44 -0700
Date: Mon, 24 Aug 2026 13:36:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Yongwei Xu <xuyongwei@open-hieco.net>
Subject: Re: [PATCH v3 01/10] target/i386: Sync AMD CPUID aliases for Hygon
Message-ID: <aovYayjaps1GBb7H@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-2-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-2-zhang_wei@open-hieco.net>

On Mon, Aug 24, 2026 at 12:53:05PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:05 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 01/10] target/i386: Sync AMD CPUID aliases for Hygon
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
> behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.1 and
> older machine types, because the CPUID result is guest-visible ABI and
> must remain migration-compatible.
> 
> Add qtest coverage for the Dhyana model, including the compat property.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
> ---
>  hw/i386/pc.c                        |  4 +-
>  target/i386/cpu.c                   | 10 ++--
>  target/i386/cpu.h                   | 12 +++++
>  tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
>  4 files changed, 98 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

