Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391024CCDD5;
	Tue,  1 Sep 2026 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245263; cv=none; b=tr41grlD+XolgTF7U2nsTk0eW/HXFGqcJ/nuh1rWX38sMO+Y9uOx21mNL8qlvzLD18F9/ft4sAvgrFHyvmYWKS9o4se/6olKFCRU4F0suieHzRv247yGQwG1RyONVlFuc1UxNP8cwf4x1vNkNxGdWkkpyrSDeOHjHh6/a8sqH9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245263; c=relaxed/simple;
	bh=QIyXyNrGOdB3bA9A0K5Dkt8YY9IpW7375gUC6vEbDdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciMQVR2w471sZn9/4+q25cb9neBhZsDU/ZAV/3r2KKTzexyKaxiCYN0+KrsIw/PDvk2EJVUYGcjELpRU8b0QdojJuRIGujc/y8UikaweIHkqve5OWAOzHn2T2XsON+T07hxoHtvd5YsPDEXtAtbGD2Bu07GSMv3l8Xx35kDphb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf/PhFCR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf/PhFCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245262; x=1819781262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QIyXyNrGOdB3bA9A0K5Dkt8YY9IpW7375gUC6vEbDdo=;
  b=jf/PhFCRMpQR4XSEaTu9Ktz/FAcupS3s3A5mWWn/4QcAEv0hDvaz7iav
   FgNAEQiySd3gvJV7DA0/o/lxaOcDi0xeOc71wziCznumfOKy8FHOtSKzG
   ui3XuLVVgEAxFv+8BQO8GVkkORgGSK28P9HuTVb4MxUOVj7PI5sQlq0Ww
   ZPWJ0pZADhSDdYU1tq+3PMz+57yc6lDILRuJ99h0L/371k/xeZtFxhY5K
   D0mnbPu4xK9mVT+ewznqRSwvIvSd0QkOElSAk1LN5ZSSrxHdBtsqbP7/T
   9tmZEFodXLNPM+NI1j+tS8lNrnjTQ1SeUj8HlUwEnYgA/tWUeOnC3jePF
   w==;
X-CSE-ConnectionGUID: 5C/24v4BT5mV0jboeXi+6A==
X-CSE-MsgGUID: 1OvB2rbGRzi3Tz3JQU7jxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99263280"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99263280"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:47:41 -0700
X-CSE-ConnectionGUID: ScPTa+OSSL6SBgCvb8W0lA==
X-CSE-MsgGUID: 3L2rShqtSKaws0u1zp/iCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="273188970"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.192])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:47:38 -0700
Date: Tue, 1 Sep 2026 09:47:34 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
	pbonzini@redhat.com, dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH v3 4/4] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
Message-ID: <apZ1BoWQxT8dDGMu@tlindgre-MOBL1>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-5-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827031837.2863609-5-binbin.wu@linux.intel.com>

On Thu, Aug 27, 2026 at 11:18:37AM +0800, Binbin Wu wrote:
> Validate the CPUID configuration provided by userspace through
> KVM_TDX_INIT_VM against KVM's TDX allowlist, and drop the hardcoded
> denylist based check.
> 
> The TDX module lets the VMM configure certain CPUID features for a TD at
> initialization time, but KVM must strictly govern which of them userspace
> can actually enable, otherwise a host state clobbering feature could be
> enabled behind KVM's back.  The existing check only rejects TSX and
> WAITPKG, i.e. it is not fail-safe, as any bit that a future TDX module
> makes configurable would be accepted even if KVM has no idea about the
> feature.
> 
> Add tdx_has_unsupported_cfg_cpuid_bit() and reject KVM_TDX_INIT_VM if
> userspace sets any bit outside the mask returned by
> tdx_get_allowed_cfg_cpuid_mask().  There is no need to first mask the
> userspace input with the bits the TDX module reports as directly
> configurable, as anything outside that set is rejected by the TDX module
> itself.
> 
> Also reject CPUID entries whose index differs from the value expected by
> the TDX module, as kvm_find_cpuid_entry2() ignores the index when
> KVM_CPUID_FLAG_SIGNIFCANT_INDEX is cleared, and so a mismatching entry
> could otherwise be applied to the wrong subleaf.

This nicely cleans up the earlier handling:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
