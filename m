Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C33594A
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477557; cv=none; b=ZYDv9JusoxuF/KOPccPPmNVMIB3w7tHq+Ax5omt740DwFXsaVq+lhgL9xnNRzRRoPOVWvu3d9RkEnvtbcPJwJVgpOcIpXDaG20jRETRjqaWXBJ+/MzgGjp3Ufz9HpSU0HG9879DgkBIQ7k1VbEYq+a063wvAcECmBNL86y0rD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477557; c=relaxed/simple;
	bh=01RrAipA0GaR7ET5aVOCa94Ac18sfLeoD/WThIyyHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r///iVHZF9IX9bDGQTdJ3MULO5PNbXFP4e+SgR9KJrTDfab+C8vl1bJ5hKAGbb29akRQ8ZQJX74YupibXMJm6ptEXxPV4IKsy7ABEimkmB0TKnbIakJ7jUi17xnPO2rbfzAp99amZnk3+1hCXOg5x5EEEddgPiHzpAUd7FHHCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkqO7Llk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkqO7Llk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787477555; x=1819013555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=01RrAipA0GaR7ET5aVOCa94Ac18sfLeoD/WThIyyHPA=;
  b=IkqO7LlkOpon/9KvXZzPw+b6WsI1rz7t3N7xqQU32Dith/eyethGa38Y
   z28KhGky5MyPamo1QohOlLKZPh5A2dbN4HDi3187Vlexitl+jr9nrExzE
   A03qR3wySwgT5JccG0VyQ5eOoRWaZmvdZSgeu+aFrjeBghl2bRIU2b83V
   wo+mYt/cn+pBzkrr/v0YL1Kw4If+qfckh8bSzjNGw9f/WJnzakjO01QzK
   779j0efEKQesduW8hhI7xbBZLM62Jr1dmeBnJhXLoOmnVdRh4ZaB/w+zT
   YrMWU4JIr7otRl70dMIlUCv8swjpOIDr/V2ovTICyElkaIhDSzsSqTtVG
   A==;
X-CSE-ConnectionGUID: Vjm3vzFnQralzZWS8/1WRA==
X-CSE-MsgGUID: 1+Ib+9EFTfOQqZl4cu0QTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="87817150"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="87817150"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 02:32:35 -0700
X-CSE-ConnectionGUID: EdXeU6IdRTqNDDN0fpCR1A==
X-CSE-MsgGUID: CTLnzO+WR7OmLLr7xaXXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="270946660"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa005.jf.intel.com with ESMTP; 23 Aug 2026 02:32:33 -0700
Date: Sun, 23 Aug 2026 17:32:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Message-ID: <aoq+MK8Vbvr1wA2c@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-6-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-6-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:52PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:52 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
> layout.  Hygon guests that enable PMU and request AMD PMU CPUID
> features such as perfctr-core need QEMU's KVM PMU setup and MSR state
> paths to use that layout too.
> 
> The relevant QEMU KVM PMU paths are currently restricted to
> AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
> information initialization, and AMD PMU MSR save/restore.  For a Hygon
> Dhyana guest with pmu=on, the compatibility check reports vPMU as
> unsupported solely because the guest vendor is HygonGenuine rather than
> AuthenticAMD.  If the VM continues, QEMU still skips AMD PMU setup and
> never saves or restores the AMD PMU MSRs for the Hygon guest.
> 
> Treat Hygon as using the AMD PMU CPUID/MSR layout for these KVM PMU
> paths.  Because the PMU MSR layout is shared, accept both AMD and Hygon
> hosts for guests using that layout.  This intentionally allows the PMU
> compatibility check to pass for AMD-host/Hygon-guest and
> Hygon-host/AMD-guest combinations.
> 
> This does not enable PMU, perfctr-core, or perfmon-v2 by default for the
> Dhyana CPU model.  On backward migration to older QEMU, Hygon PMU MSR
> state may still be dropped because older QEMU did not write that state
> back through the AMD PMU MSR KVM paths for Hygon guests.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 73 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 17 deletions(-)

The code looks good to me! It would be even better if this could be
split into two patches - one dedicated to refactoring the vendor checks
first, and another to add Hygon as a new AMD-compatible vendor.

This would make it easier for maintainers to review, and the current
commit message would more directly correspond to the Hygon-specific
changes. :)

Thanks,
Zhao

