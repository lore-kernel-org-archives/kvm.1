Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10017E0FF
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477049; cv=none; b=PvnReVLMUsWRtzFjbVFRuhKg1XLw6K87ghrrKLi0d9fE6h8ba9uhwVKEbYQS+YxtYxL5sD8OvOI77uHDbT3eWVCXl0sZi3FvrRaSdCVLpncvQbs506lDvYCgMm3QHPtDTNZdIxY3CgLyDUTS6E34trRgKjB0Hh1NqmOyV43bkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477049; c=relaxed/simple;
	bh=IelsqnBOvxhCL8J8K8c1AsA7S6o9JNKpAOXHCvwiBk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQlpfea/IDorX6dduG7C0O76NnQfIpnvDeuGq6kpCah/W8FZJDxORax3/gr3eA8bjpnLCh+CHd2PfJirK1dC+pIwyKFkBoc6a9cyOOf+k+u6tziIgwNlYzRiDkhE/liyK7V0C6/FPsh6Lmnj6Pgnq/UkgMmj7OxBmn4yvLJQlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dr5x12zD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr5x12zD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787477046; x=1819013046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IelsqnBOvxhCL8J8K8c1AsA7S6o9JNKpAOXHCvwiBk8=;
  b=dr5x12zDqJvtediw8QY1aTbySDlYwTmbL3rbafAJYjgXXJ94KT/HLTPo
   +BseTTjyu2pDNMezM9jVk53TxoMvjgaUxh2iBi9VjMKFIr8/3Qi8gVBvJ
   B1VKsPKpLztzGpnzRHZW4J/t1ZgN9PTxEMfYrZYa1Qa2UwNGH5dd79nXY
   glWVQAFKPJ8iIxil/DleiTNEtnoZdqgHullqhAgpqIuLbOWPcw/KzbHJh
   1wY62ggDwZ7SLJdxhgYSvdREPVXGVo9+NBkBH2boZbdasj8/IdWwxWcQm
   KDdSUFgV9a/YM/QQcZRZ2vLlxT7HuUjGvKvmmyLUa8vQUqWhmiAEko5+b
   w==;
X-CSE-ConnectionGUID: rvc9T2HERQuWiX1diiuUyQ==
X-CSE-MsgGUID: Eg+eNTsqTiSIdmoVeePsJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87969327"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="87969327"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 02:24:06 -0700
X-CSE-ConnectionGUID: znbtUwrPQZubnGB8V1ed7g==
X-CSE-MsgGUID: ffEmwVWmTE2LHGQLuG/Umw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="266780240"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa007.jf.intel.com with ESMTP; 23 Aug 2026 02:24:04 -0700
Date: Sun, 23 Aug 2026 17:24:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 9/9] target/i386: Use AMD ucode-rev default for Hygon
Message-ID: <aoq8M9lQKGywIOIu@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-10-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-10-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:56PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:56 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 9/9] target/i386: Use AMD ucode-rev default for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> QEMU currently gives named Hygon Dhyana CPUs the non-AMD default
> ucode-rev value, 0x100000000.  That is the Intel/KVM-VMX-shaped
> encoding, where the visible revision is in the high 32 bits.
> 
> Linux reads MSR 0x8b for Hygon CPUs through the AMD patch-level path,
> using MSR_AMD64_PATCH_LEVEL and storing the low 32 bits as
> cpuinfo_x86.microcode.  With the old QEMU default, a Dhyana guest sees
> microcode revision 0.
> 
> Use the AMD/KVM-SVM-shaped default, 0x01000065, for Hygon on this
> specific MSR 0x8b default path.  This does not route Hygon through AMD
> microcode loading and does not claim that Hygon CPUs are otherwise
> identical to AMD CPUs.
> 
> Preserve migration ABI through the vendor CPU ABI compatibility gate used
> by this Hygon bug-fix group.  pc-11.0 and older machine types leave that
> gate off, so they retain the previous ucode-rev default.  Explicit
> user-provided ucode-rev values still override the default.
> 
> Add qtest coverage for the new default, the compatibility cases, and an
> explicit user override.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c                   |  8 ++++++--
>  tests/qtest/test-x86-cpuid-compat.c | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> +         * Hygon uses the AMD patch-level MSR 0x8b encoding, where the visible
> +         * microcode revision is in the low 32 bits.

I feel like this description is redundant regarding the commit message
is already self-explanatory. Adding one for each vendor might clutter
the comments.

Others, LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

