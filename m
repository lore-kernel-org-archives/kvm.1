Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A828850E;
	Thu, 27 Aug 2026 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805216; cv=none; b=Y2jMWm9SOzHu/CslkOGl/dNPGt+Qx+0PEJlztSLS5XSOtc0Ab3KZhQU9xcXemRCxYPMFme9J9/rKtE6OpUsqff9MucywDJVHopD1KnrunxrTjIELc3YF+eD/VbBDHcO7rtgi90gAxny54ivzYARJ1mBPcmuSytWxpc952+XmBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805216; c=relaxed/simple;
	bh=AlrT28RSsUofChiqrzLpOS4n4oecYPjYKR+b3pCjGJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5tOOl01SCoAxIzgdl4RKkSrEwgO83+WACICXnh38nf9+5oSI9f1AxJYShWVjXrem+4USqDrEjgxnNGjWM0MUZkonDOawdWcQmlLzr42diDq4uE0XMhKavk1DCK0TmS+i6nDS4V9ixleULL7u0xFuFaQoDR1ziTR/e/ywJUISaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hh6V4YPo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hh6V4YPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787805214; x=1819341214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AlrT28RSsUofChiqrzLpOS4n4oecYPjYKR+b3pCjGJY=;
  b=Hh6V4YPonSqV0HsrUCGvfDLZeCQPkXF56zFhoZ2lnfD0Y+JRGmuAVNS5
   gfrlaEONPQkDxL6iiK1Qm/TA8c2Ia2gUUjLOVwwP1/+WJIlVsV3XCNbCI
   IcsS4I4hJg1n6AA0k8HTzZh+YpNXHDGxbgBG2DxHk8MpebP7u/oJ/7RlZ
   SHSxmsDRjWE6iJ9GLOvZx0ZeoJQ9plTb4tLTekpeGCyEFLvJyGf3gLuu3
   DNfBb1NQL2T3zKjXT8/TUrgclf5hYQIvQ95X8qVoSMECrsyEb+C5qUCI8
   zrppYx94wo6G7t4VxgZwWSlhkSTpYmxRwJrc8rrYQhAGUC4r6Asm+TYB0
   g==;
X-CSE-ConnectionGUID: JizrJs+LROWZ0UgJCQ2QyQ==
X-CSE-MsgGUID: cA7x+VoSTRWUUzZluucxVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="92115293"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="92115293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 21:33:33 -0700
X-CSE-ConnectionGUID: gxsSGgWNTEeFBFhyXpvTtg==
X-CSE-MsgGUID: 71slt69TQD2bCTlzhb/Vkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="273009032"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 21:33:33 -0700
Date: Wed, 26 Aug 2026 21:33:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, 
	David Kaplan <david.kaplan@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Nathan Fontenot <nathan.fontenot@amd.com>
Subject: Re: [PATCH v5 2/8] x86/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
Message-ID: <eqafo3gmypwdvjw6ygzqsk5zdelscuzfulvbdryt7anmftpcuc@tmi3er6x47wa>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-3-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826223510.3669875-3-kim.phillips@amd.com>

On Wed, Aug 26, 2026 at 05:35:04PM -0500, Kim Phillips wrote:
> Prepare for legacy IBRS toggling on AMD, where the BTB Isolation
> SEV-SNP feature uses it to optimize the VM exit-to-re-entry path.
> Commit 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to
> support Kernel IBRS") restricted the option to Intel because that was the
> only vendor that needed it at the time; nothing about the mechanism
> is Intel-specific.
> 
> Keep the IBRS-trumps-retbleed logic in retbleed_update_mitigation()
> Intel-only.  Legacy SPEC_CTRL.IBRS does not mitigate AMD's Branch
> Type Confusion RETBleed variant (RET prediction uses the Return
> Address Predictor, not the indirect branch predictors IBRS
> restricts), so letting SPECTRE_V2_IBRS trump retbleed on AMD would
> silently drop the UNRET/IBPB mitigation that does cover it.
> 
> On AMD the decoupling is total: retbleed mitigation selection never
> consults spectre_v2=, so spectre_v2=ibrs neither adds nor removes
> RETBleed coverage.  A kernel built without MITIGATION_UNRET_ENTRY and
> MITIGATION_IBPB_ENTRY already reports RETBleed as "Vulnerable" via the
> retbleed sysfs node and boot log regardless of the spectre_v2= value,
> so there is no silent gap in the spectre_v2=ibrs path to warn about --
> and a warning there would wrongly imply the Intel-style IBRS/RETBleed
> coupling exists on AMD.
> 
> Also drop CPU_SUP_INTEL from CONFIG_MITIGATION_IBRS_ENTRY's depends
> line: the IBRS_ENTER/IBRS_EXIT macros are vendor-neutral, and the
> Intel-only restriction would silently redirect spectre_v2=ibrs to
> AUTO on AMD-only kernels.
> 
> In spectre_v2_apply_mitigation(), route AutoIBRS-capable CPUs to
> EFER.AUTOIBRS only for the eIBRS modes.  Previously any IBRS mode used
> EFER.AUTOIBRS when the CPU had AutoIBRS, which was unreachable while
> spectre_v2=ibrs was Intel-only, but would now hand spectre_v2=ibrs the
> always-on AutoIBRS behaviour instead of the toggleable SPEC_CTRL.IBRS
> the option asks for.
> 
> Finally, clear EFER.AUTOIBRS at the top of cpu_select_mitigations(),
> alongside the existing SPEC_CTRL kexec cleanup.  head_64.S preserves
> incoming EFER bits, so a kexec from a kernel that ran in AutoIBRS mode
> carries the bit into the new kernel; without an explicit clear the CPU
> stays in AutoIBRS mode while sysfs reports e.g. "Mitigation: IBRS" or a
> retpoline mode, diverging from the actual hardware state.  On a normal
> cold boot the bit is already clear, so the msr_clear_bit() is a no-op
> there.  Clearing on the boot CPU suffices for APs, since it precedes the
> init_real_mode() EFER snapshot used by the AP trampoline.
> 
> Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
