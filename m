Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5738F954
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058445; cv=none; b=ZkO/FhooeZM/7ndvSqcNksJOUdNMVA0NSe0QEaVJO1ymqbNSDj7f3M+jQfYr37Go4MKQjma+zZiV5l6mDrgQTDeRDdn1xhWaE/JkEv7cpstFYFL3tyIJDrANjX0RJSuZzqvx5+tHFuNhB18BzwygSJhTKxForU6PlMKwfWf//vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058445; c=relaxed/simple;
	bh=Ax1AHTjwuPWIMbHV33ItcAYsSzezF3yc9Z7Iji35p3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5VY9b0njuOjekyky/uya+WjRlELys91Z2zV1JwHlf8AQQSn4q13YQTQqjgISg2j9VCkBw/NCiHceK31eB7XuIwvcGvN7ZRfqfgciIfk1VMIzvxsj++jTbMJPo/ebd7xvGiGkTi5f4NxskZ2E6RBJkZPv6MkjiU5L6NcdIIFgj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFJjGX8X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFJjGX8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790058443; x=1821594443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ax1AHTjwuPWIMbHV33ItcAYsSzezF3yc9Z7Iji35p3I=;
  b=QFJjGX8XzN3Z9wInMdVDTohlPLdcpWXkFvBtUPllHbw0CcJO4s1kl2d7
   q3cvRCH5rLcapR8M8Arrj1xsiCzT8hydIE/+kDVWxoGnoXnq9paavRAqj
   +eTsCCeILkqXwYV979pqes6e2LcirMkkFrK4lZ5MuqX5YL1UuMmrxlWJh
   qv5yHMWmJ2OpYHggf4d1wJAtkHdQN0s1en+INqddv6z7aSD9Zn3OSwCrX
   NI8IvO5liAB1oZ6W9lb6vqMhh2pkrdM6/4H8oz4FoEJyg1nZMdB33/HFu
   CLJ2fGJ0wjTwV3/7glTo+DB6L+alKynVd9+n017G8CDL6gbU9IUNlP3kM
   A==;
X-CSE-ConnectionGUID: FYNGx48rRXS1zlHrF9JZ0Q==
X-CSE-MsgGUID: BgGqJ2MOQiaj8rofOstrDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101295101"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101295101"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:27:22 -0700
X-CSE-ConnectionGUID: bGPkEG/VTiiW7dIG7MxSWg==
X-CSE-MsgGUID: z3EkypD9SSKI0Dy1p0FJvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="277776037"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:27:14 -0700
Date: Tue, 22 Sep 2026 09:27:07 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
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
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <arIfu_A1e6KEokWI@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1>
 <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>

On Mon, Sep 21, 2026 at 08:56:48PM -0700, Kishen Maloor wrote:
> On 9/20/26 11:56 PM, Tony Lindgren wrote:
> > On Mon, Sep 21, 2026 at 08:58:17AM +0300, Tony Lindgren wrote:
> >> On Thu, Sep 17, 2026 at 09:33:18PM -0700, Kishen Maloor wrote:
> >>> On 8/31/26 12:13 AM, Tony Lindgren wrote:
> >>>
> >>> I was wondering how a vendor would use kvm_transfer_buffer for a command that
> >>> passes an input and also returns an output. size can describe the input
> >>> length or the space available for output, not both, so the kernel has no way to
> >>> know how much it may write.
> >>>
> >>> Two suggestions below. They're orthogonal.
> >>>
> >>>> ...
> >>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> >>>> index 5f6c1ce9673b7..d9291a8a97bb1 100644
> >>>> --- a/arch/x86/include/asm/kvm_host.h
> >>>> +++ b/arch/x86/include/asm/kvm_host.h
> >>>> @@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
> >>>>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
> >>>>  	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
> >>>>  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
> >>>> +	bool (*cap_live_migration)(struct kvm *kvm);
> >>>
> >>> Should this return an 'int' specifying the maximum buffer size that the vendor impl
> >>> requires/uses? Userspace can then learn this once.
> >>
> >> OK that sounds good to me. I assume you are thinking the maximum hardware
> >> specific buffer size per thread? As in 512 * 4096 bytes for the TDX case?
> 
> Yeah, an upper bound on the buffer size, so 516 * 4096 (4 for the GPA+MAC lists 
> and MBMD) in TDX. It could be a hint to userspace to size its buffers at the 
> start. Though it would be up to userspace to decide how to use that information.

Oh right thanks. I think this is really the maximum transfer buffer size
Peter asked, not just a hint to userspace :)

> >>>> +struct kvm_transfer_buffer {
> >>>> +	__u64 address;
> >>>> +	__u32 size;
> >>>> +	__u32 reserved;
> >>>> +};
> >>>
> >>> Should this struct include a 'capacity' field (u32) that is set on each command?
> >>> It would be the number of bytes writable at address.
> >>> size would be the input length on entry (0 if the command passes none), and the
> >>> number of bytes produced on return (0 if none).
> >>
> >> Hmm so the transfer command return value can return how many bytes were
> >> written of the input. But yeah we don't know how many bytes were written
> >> back to the transfer buffer as result of the transfer command.
> 
> The transfer command return value could return how many bytes were written into the buffer.
> But in an input-output call, the kernel handler wouldn't know how many bytes it could write,
> or for that matter even how many pages to pin up front in case it needs to return an output
> because 'size' couldn't simultaneously convey the input length and buffer capacity. That was
> the gap that I thought a read-only 'capacity' field could bridge. Of course, this
> assumes that the output is written in-place.

Hmm yeah this inplace capacity vs transferred issue remains still. So I
agree we need to specify the capacity in struct kvm_transfer_buffer like
you suggested.

To me size is already the size of the buffer though. So instead of changing
size to capacity, how about something like datasize or len for the input
and output transfer length?

> >> How about if we add the bytes returned to the transfer struct? Then the
> >> kvm_transfer_buffer can stay as just a buffer. 
> > 
> > Actually, for the possible cases with input+output, we could reserve space
> > in the transfer struct for another struct kvm_transfer_buffer for the
> > results?
> 
> Yes, say an 'in' and 'out' kvm_transfer_buffer inside struct kvm_migrate_cmd should
> close this out and shouldn't require a 'capacity' field. Maybe we then establish this
> convention:
> - A non-zero 'size' on 'in' at call entry would signal that there is input.
> - A non-zero 'size' on 'out' at call entry would convey the buffer capacity.
> - A non-zero 'size' on 'out' at call exit would convey that there is output.
> - A zeroed 'size' on 'out' at call exit would convey that there is no output.

Looks doable to me but with the inplace issue as above.. Sounds like we just
need to reserve space for a case with a separate output buffer though.

