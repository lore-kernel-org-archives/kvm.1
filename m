Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630FD3C98B7
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 04:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520203; cv=none; b=vGnOgtk2d+1YXoA80otT5YaaT4ZWGMXqp+jqWoA7eBc+5pZMPO/jmrqv/pGmt729/vUb4SQumWtDkhK72G813iH6eILCeAwz1X+YEVx6iB64WbT1qYYAociiSACuVZsY//t6wwAuBFNizwr3xRvm2GMG5i7T5DNIoUQ2LUq8EBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520203; c=relaxed/simple;
	bh=R0VieXqy7QXcl5nOFjPA3C/nOHBFSdEdyrLMUG8f/WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVTwsaeTLaLJwUOebltNo5XOWsQJAPegtvqUauRUQzACSuB3/raw1AJxXmqEAiukONLkILMUDSqHKVVcYAHHTmLfCrwYNN7YhjT6AexlPCKM5XqPtcCZ+yRMUjLAWogEsq/2D+GLCudR3M2vLonDYQhB4XmA6UUqy9z6wLjBcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+GMXtXb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+GMXtXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791520200; x=1823056200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0VieXqy7QXcl5nOFjPA3C/nOHBFSdEdyrLMUG8f/WQ=;
  b=J+GMXtXbTp1NQSJya4tNaq6O6RWJOmnE00AGHZoHvfSv271NSC/hCoup
   A7FF91lPx0iYqVl2p7+O+/zobffLXlXWEYtMGQdYtikgcsl39HMW0z+O3
   dxAdDCviAwwAQT9zLnlQu4tgmXVvVAvB5eV9NCbn+ZGiJMMyqpc9xcaJQ
   PFG9gP8w82Yx7EpI+HuQLGRZmYeHGCbOggcnacKEuVgOgMiBWc/v75AMJ
   p61dJz9bm5ReT2IJ0g8MVjrnNvbaqJ3s+ooh/LNgM3kuiEVNAGPff+uBs
   TrLQj3im9t3uDUTIeBR8qUKiAFUNrm9qAgRgwxRid5XUXydezcl9DQOdQ
   Q==;
X-CSE-ConnectionGUID: jwVmLdPjQkiIQvHEWQlvhQ==
X-CSE-MsgGUID: S+bws3+NTpeg1c4xZgkoMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="315601"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="315601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 21:29:59 -0700
X-CSE-ConnectionGUID: Tb2Tpi+FQGG8GOtVVK3pmA==
X-CSE-MsgGUID: 2EiaiXtuTFSOJNYGcSRwDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="172104"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 21:29:52 -0700
Date: Fri, 9 Oct 2026 07:29:49 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <ashtveScA8rsUbjb@tlindgre-MOBL1>
References: <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
 <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>
 <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <asc2_aQ_T91bwMIm@tlindgre-MOBL1>
 <asepPP4Buo9u5p5E@zhexu-thinkpadt14gen5.rmtcaon.csb>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asepPP4Buo9u5p5E@zhexu-thinkpadt14gen5.rmtcaon.csb>

On Thu, Oct 08, 2026 at 10:31:24AM -0400, Peter Xu wrote:
> On Thu, Oct 08, 2026 at 09:23:57AM +0300, Tony Lindgren wrote:
> > Yes GPAs are part of the MAC generated by tdh_export_mem() so cannot change
> > for import. This can be seen at the TDX module source at [0] below.
> > 
> > What if we add a flag for the memory functions to describe the type of
> > addressing used?
> > 
> > [0] https://github.com/intel/confidential-computing.tdx.tdx-module/blob/tdx_1.5/src/vmm_dispatcher/migration_api_calls/tdh_export_mem.c#L1083
> 
> Could you elaborate some more?

Sorry if I was a bit unclear. I meant TDX needs GPA but also other
type of addressing could be added.

We could specify the addressing type in struct kvm_memory_transfer flags:

KVM_MEM_TRANSFER_GPA	0
KVM_MEM_TRANSFER_GMEM	1

Kishen suggested adding gmem_fd to struct kvm_memory_transfer and then
for KVM_MEM_TRANSFER_GMEM the addresses would be an offsets.
 
> IIUC if the stream is encrypted with GPA info, then the gmem offset is a
> no-go, because I believe in that case we need the ability to apply a stream
> of encrypted data to one guest memfd.  It means even if gmemfd can be
> attached to a VM before hand, it doesn't describe GPA address space, so I
> don't see how to verify the encrypted GPA.

Yes that's my understanding as well.
