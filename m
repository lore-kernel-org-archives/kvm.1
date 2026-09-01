Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9838D400;
	Tue,  1 Sep 2026 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245152; cv=none; b=nd+8cBANCcMXCTw0wkMvGotMFIqtaotpPfoP+MJWQeYSY2bgJNUVvZhMiFPyz52V1bYxLkhayJEwNE/HRTU6Qb1yKHLhFzOPF9wMvXM+rwYD6hLWiy0rgBL3v1LJTsZxP9zNpFbTD6osFtfrFhfXO+qcsFPm8wSkJEMT4zqrwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245152; c=relaxed/simple;
	bh=fvjlALAnc5ea5uD1wAQ6TMiHm8yC0xFUOuIBQ1bNXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu9DORQChdyTSYvxtFFM2JQpFboZA4A4368R1pEFVUvShBdrxqCaDPGHKEXdwIPlWVrj60ankXYIsffQQvy3IJ/jMTqKiYqzDZhgZKgi/6jFbzWYdXRhKvXonDZho9WfuCS4eDYIOsR8p0GeSmcPWFYr70wjDvuLIAAb6L2ql98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYN9E3zM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYN9E3zM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245150; x=1819781150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvjlALAnc5ea5uD1wAQ6TMiHm8yC0xFUOuIBQ1bNXLw=;
  b=CYN9E3zMGfFJ85RVe4FUyAjZnoQq2fWLIdsxUql2C/VrtrR3heM/isko
   EK1CFh81F2iwwojGpGy93lt2LbEGwGEmShtLajsyYCIuCw6jzEMcPvvMR
   nSaxOw21XZCM0nTJxIAIUIyj9sJmjyh9RmUWbhm891pvTf2jkv+837Mcz
   GKjT9o1PfNPHo1djJdEBdCqq4dlHFP/cP2nyxqf4dlrBs4WFUOwfgkbF/
   hF2Y+be+BD7oKCFPglhrW6r5cOnEOQ5LD3xRihhp22nFdmTnMxeuMtXpe
   M5gbdAJDU691B9GTFrdTyiju25Trg+tTRIts77lACkeKP9hY7gQzwQrrd
   Q==;
X-CSE-ConnectionGUID: 7nQrtdC8SMqUKGnwweT3Mw==
X-CSE-MsgGUID: BU9yfhoDQnmplOcQdAy3yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92530714"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92530714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:45:50 -0700
X-CSE-ConnectionGUID: hmSXVWSYSjWC1EgWYX7PPg==
X-CSE-MsgGUID: dsy+pJthR2WvGiI/RJHRzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="266417638"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:45:46 -0700
Date: Tue, 1 Sep 2026 09:45:43 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v3 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
Message-ID: <apZ0l95HzDYGEX-z@tlindgre-MOBL1>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-3-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827031837.2863609-3-binbin.wu@linux.intel.com>

On Thu, Aug 27, 2026 at 11:18:35AM +0800, Binbin Wu wrote:
> Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
> directly configurable CPUID feature bits, even though KVM doesn't support
> MSR_IA32_CORE_CAPS for TDX guests, to accommodate legacy TDX module
> behavior.
> 
> Older TDX specs define the CORE_CAPABILITIES CPUID bit as fixed-1, so
> userspace may expect the bit to be enabled for TDs.  If the bit becomes
> directly configurable in a newer TDX module but is not reported as such to
> userspace, userspace can no longer enable it once KVM starts validating
> the CPUID configuration input.
> 
> Reporting CORE_CAPABILITIES as configurable keeps userspace able to enable
> the bit across the fixed-1 => configurable transition, and lets userspace
> infer that the bit is no longer fixed-1 so it can adjust its expectations.
> 
> Keep MSR_IA32_CORE_CAPS unsupported for TDX guests, as existing TDX users
> have not needed guest access to the MSR, and advertising the CPUID bit as
> configurable is enough for userspace to handle the legacy-module
> compatibility case.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
