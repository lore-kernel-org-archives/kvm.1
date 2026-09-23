Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC53C1089;
	Wed, 23 Sep 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152685; cv=none; b=th24kgMFv5KpdwMr4wlZ4l7MisAtGA14KlwCMCtSw3k13msrbS1deenq2OCfyAsggopq0Edff+0rnWGyUStE8q5n7X2S6sjxiQx33zXFpWTp8nRzJB83tapIqv74SH0p2WOohczUbzNykLIzVgc75vv/P8ojvkS8w1MOeVxvIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152685; c=relaxed/simple;
	bh=FrR8b3Mzv3qdqtgXmfRNRlQ4l6oSfUahCbwP603V/HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA14DLU9dap3puWPWSSUz8Qeer84i8HSgxCI9uXkirNCoT+LBcvz/5ZLATzgwlJ2HswNPiRrpjEjrpp/fvWdwOSa9JT7rBdtD3LQ7NYK1JGl+BfJFLDj7CoATJkqTth+G9ntiQPNYUB4X/2iVaXRb++Yfzi1dEZ9tlo9WPqnp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY7q8yI5; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY7q8yI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790152672; x=1821688672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FrR8b3Mzv3qdqtgXmfRNRlQ4l6oSfUahCbwP603V/HY=;
  b=iY7q8yI5bgjAXMOSV+LiNXxxPP8232fIsHGMsvnXK0FHuKRmQJ336Cct
   OcCUBCTIvdTeKcY+bxHxqqyL4TNhBKh+il7ISnC2lsejE7Ec5B61VI/5S
   vgXSx0Gr+zPcQvG1cLMTcJIObwxmMTk19c+XGapFd/HNmivDfbjvqyI4C
   wJGq7R453V7D7XgS1SfqOWAfLUVVnEUgvgOSWWgEzLLw918s9ytvwK5gH
   Ck+YeDwJ+Ow5M9cFshjigz/J4xu52A1KkjLaHWNWh/+rlO3eYvzgKT2ib
   CGN3kxZI/epC2oEVXYazifqvbv1sNpoKbL9yW8DMmnv+FejtTu7MR/Uoc
   Q==;
X-CSE-ConnectionGUID: oU+PhisuQS6oZUBvQcKv6w==
X-CSE-MsgGUID: rwzUmp8DSEKqclEdpxnyJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1330894"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1330894"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:37:49 -0700
X-CSE-ConnectionGUID: bsfpIpVcQCe3xKoL05+I7Q==
X-CSE-MsgGUID: LVOFLOgfTbeBmfgqRfwTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="278259741"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 01:37:44 -0700
Date: Wed, 23 Sep 2026 11:37:41 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, yilun.xu@linux.intel.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global
 metadata code
Message-ID: <arOP1cXNYPbS0eZ1@tlindgre-MOBL1>
References: <20260918132946.76533-1-chao.gao@intel.com>
 <arNnJO3aKDlCD2Uz@tlindgre-MOBL1>
 <arOLgHrOf8tlTwfv@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOLgHrOf8tlTwfv@intel.com>

On Wed, Sep 23, 2026 at 04:19:12PM +0800, Chao Gao wrote:
> On Wed, Sep 23, 2026 at 08:44:04AM +0300, Tony Lindgren wrote:
> >On Fri, Sep 18, 2026 at 06:29:19AM -0700, Chao Gao wrote:
> >> This series cleans up the TDX global metadata code. It has two goals:
> >> 
> >> 1. Replace the generated code with a table-driven metadata reader.
> >> 
> >> 2. Make the existing code easier to read and maintain, and simplify
> >>    adding new metadata fields.
> >> 
> >> During the v1 review, Dave raised concerns about signing off on
> >> AI-generated code. I have since rewritten the affected patches based on
> >> my own understanding of the code.
> >> 
> >> The main goal of this RFC is to agree on whether the table-driven reader is
> >> the right replacement for the generated code. Please raise any concerns or
> >> alternative design ideas.
> >
> >For alternatives, I wonder if grouping the metadata would help in the long
> >run. Some of TDX metadata needs to be cached. Some of the metadata is init
> >time data for how much memory to allocate etc. Some of the metadata needs
> >to be re-read after TDX module update.
> 
> I agree that TDX metadata should be cached only when there is a reason to.
> 
> And yes, some init-time data is cached even though nothing reads it after
> init: max_tdmrs, max_reserved_per_tdmr and the pamt_*_entry_size fields are
> only needed while building the TDMRs.
> 
> Only the version fields are re-read after a module update. Splitting them
> out of struct tdx_sys_info would be a good improvement, so the rest of the
> structure could then be __ro_after_init.
> 
> These are cleanups that can be done in a separate series.

Yes OK agreed.

> >Should we have the table-driven metadata reader use the TDX module
> >metadata directly by default instead of always copying the data? That
> >could be used for the init time data. And data could still be cached for
> >CPUIDs etc.
> 
> The table-driven reader doesn't impose caching. It maps field IDs to
> members of whatever structure the caller passes, so the destination can be
> a cached global or a stack local. For init-time data, we can read it into a
> stack local the same way the handoff class is read in tdx_module_shutdown().

OK thanks, nice to hear you have already considered the next steps. Might
be worth updating the cover letter for the follow up options too.
