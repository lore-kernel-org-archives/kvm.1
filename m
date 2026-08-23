Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B833ADB9
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787475063; cv=none; b=WJFOocagbR4MsEPIAQeZto+PqT542zB0+fENZW0UKqGOlsqpTsplA1Qm21fvtIYHhnYAiPVLc/1lucLSCgnKsdi6g7/QQ74OwBPkBOupgpVwhZNYwfdSIOEq9gPBJStCG+mEG6jmZ4NoLCz0I1pQUy6neDna4ZmhVGqMsZZ9jp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787475063; c=relaxed/simple;
	bh=kjpxf2sQ1FERHhRTBKUY+6K4RPxRhA/sRW81XFP9zpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opUaWYDbBfJXzPeW/BbIuRw6PMpO3d7KFEqIlV41RMUw/Sw7IcjDac36Zv3FPbkW7ZsIMwZN+NV6/QdsiavL0HNqAFuCr9F4MJRMPEKm/eUk82EEZPHLEA8aTDedMAYcjEkNJ4zpNaK6IItfJiXwu13IA7pZ+MCbJMr5/rEdymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2KzQBRi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2KzQBRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787475060; x=1819011060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kjpxf2sQ1FERHhRTBKUY+6K4RPxRhA/sRW81XFP9zpI=;
  b=m2KzQBRim2qOLT2zzmqxPwkHcmeApOYJsh1cRlgRRjxaoER2karpcC+4
   2kqT9gua73bUL5K1WQrdkTXL4Ealijp1oy5BdCtTxEnCZlW6ybl8kwffT
   edFcWNMghWvdNx/oBPu8JL0+XilT8Khmy1MGMXiy77u7V72bV1TuL+BOW
   zHjxFUwX6bOggquignr+cfnKW8bGDXdoekM+ADu9MlUgGSRL33Pw7bfYZ
   3rGxoiF5ovxnqXP084zZwYfgG9LO3szj7o1VXpwRkd6bhTpBt/V9EeCPP
   nGuctpzTWr5StplLFuwxwOD4CIWIclVRP655x4GCA5ZPGV4ZhDMbuY7BV
   w==;
X-CSE-ConnectionGUID: DVofRPmTRaqgdghfCdz75w==
X-CSE-MsgGUID: 6rtAUJgFRRWNWmN7Azxk7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="105492015"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="105492015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:51:00 -0700
X-CSE-ConnectionGUID: mDwjNrNuTjanWCTPIivfVA==
X-CSE-MsgGUID: u6Amo0LdReaPom+XTKMx6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="262469051"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa006.fm.intel.com with ESMTP; 23 Aug 2026 01:50:58 -0700
Date: Sun, 23 Aug 2026 16:50:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Message-ID: <aoq0cYPRcUBc88P3@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-4-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-4-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:50PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:50 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> IA32_ARCH_CAPABILITIES is an Intel-defined MSR.  KVM can synthesize the
> CPUID bit and read-only MSR for non-Intel guests, and QEMU already hides
> that interface for AMD CPU models because Windows may not expect it on
> AMD-compatible CPUs.
> 
> Hygon Dhyana uses the HygonGenuine vendor string, so it currently skips
> that AMD filter.  If arch-capabilities=on is requested, QEMU can expose
> CPUID.7.0.EDX[ARCH_CAPABILITIES] and the associated MSR feature word to
> a Hygon guest.
> 
> That creates a vendor-inconsistent CPU ABI: the guest sees an
> AMD-compatible vendor and cache/topology interface, but also sees an
> Intel-specific architectural capabilities MSR.  Guests that choose CPU
> mitigation or feature paths from the vendor can mis-handle that
> combination; Windows is known to be sensitive to ARCH_CAPABILITIES on
> AMD-compatible CPUs.
> 
> Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when the vendor
> CPU ABI compat gate is enabled.  Keep arch_cap_always_on as the migration
> escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
> older machine types via x-hygon-vendor-abi-fixes=false.

Nit: pc-11.1? Same applies to the other commit messages.

Thanks,
Zhao
