Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57653298CAF
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481510; cv=none; b=kWd0pN4ubSK28epFAhG19Qx8rjixayOwDtr2GSUW3JKyU053as+wzIa/OKlA1Iy/NDddljwIiyC/I1IkHmap86uRS6r/CalJTvOE/Yq/0eZ4ZX1QrQ6O5Wu+S6SibeMWf++XlXDuh65BR/IuOk6aritplZFZWmiTzuC9R3CbjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481510; c=relaxed/simple;
	bh=+2gH6d0mvPbRq5RRTPhJOH3p5CfgPHiv91vDTc5GU4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgf/eppBrOb00skYArEbZrqA7YRjJ88V1YMh9sdnjgVAW28+3uTJZ46pUkcMDpw7QMDlEOamdZRkeVzAaXVOi4602fEbrkz9ZoV7qcbrRWrY96XBr0LZru8XTd4c3LSPUPaRbGneNqS6zsPEvNIqwtj2zU1v2WQDIZJ99ByIn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jm2z6p6+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jm2z6p6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785481508; x=1817017508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+2gH6d0mvPbRq5RRTPhJOH3p5CfgPHiv91vDTc5GU4g=;
  b=jm2z6p6+HxcKw332oS65poyqc73fNtaTM+sVVv2fG3mTPyX3Mzh9HFEK
   IGSDtskiM6Phowipyo0OWr1FujfLLdPfFilmC05vtxfvTVqO4bF2TT6iK
   iPZ+uNVwUMQTvtGmnxju70sjGaMWcF0T+beAABu12sSuv9jSFa+e/UH0q
   MqodXzTSyccd+cCUiULxlT/gbVqiuPMRqU3QfTfw9k/QY0410MkXBszoI
   iwXMlT6sxE8fhWKRO1ALLwxq8IaFh75viS979uys6DhibDqc0OSVpNSq3
   pP+UMSj/0X15E3HkEDpSQRTNwj18iu0qoViuct4f7Gv7ZqVWYIZhSC8qh
   Q==;
X-CSE-ConnectionGUID: Bn73gLolTJqoNOyTzOGHKg==
X-CSE-MsgGUID: JbnH4WlzRialnoBF2XDXAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85231694"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="85231694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 00:05:07 -0700
X-CSE-ConnectionGUID: UOzxglkEQLead0t9YnX5og==
X-CSE-MsgGUID: xc0QzjWxTMqyBUzm4jtdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="259267745"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2026 00:05:06 -0700
Date: Fri, 31 Jul 2026 15:05:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v1 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
Message-ID: <amxJIUQXIgXwHR4s@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-4-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-4-zhang_wei@open-hieco.net>

On Mon, Jul 06, 2026 at 01:55:24PM +0800, zhang_wei@open-hieco.net wrote:
> Date: Mon,  6 Jul 2026 13:55:24 +0800
> From: zhang_wei@open-hieco.net
> Subject: [PATCH v1 3/9] target/i386: Hide ARCH_CAPABILITIES for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> From: Tina Zhang <zhang_wei@open-hieco.net>
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
> Apply the same ARCH_CAPABILITIES hiding rule to Hygon CPUs when Hygon
> vendor ABI fixes are enabled.  Keep arch_cap_always_on as the migration
> escape hatch, and keep the old Hygon CPUID/MSR output for pc-11.0 and
> older machine types via x-hygon-vendor-abi-fixes=false.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/cpu.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

