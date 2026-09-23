Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AE3EFFC2
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146278; cv=none; b=T+fIvdmaibsb0wOlYJLlr5yUiKSt/wucSTC4sXMJ3KNcv4RCY+hr/x5ZEO2MYasSxDf9ylsRZ18xbBQEvHJvf1HQqun1vzQQC1oPqvCRSpCJrShSrfT7BrGvjHPhPbv0FyRBzuFZFa1lXdhPxUevsT5YTU1TeBDKotjii921DPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146278; c=relaxed/simple;
	bh=0mngPl7KWIvpaE7OO1ZplHJVHIc1+52hFYNxFM41UA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb0CYd8Oqy/53N0qR2JLupAMGyDsw4IZEmb1tcKgQ+cjH/itdkSELf80vWgUDAQPt0I3Vq1jSfOQ0RWhf2gP3ti9hTCVFnIPSbZjuMcwGQVE+G+alYQKRPAtdflb/eLhifB4+CMfYI03rZplHh5JZgwZ7nbW8BtZjDheSkKGqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjU0S7g8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjU0S7g8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790146274; x=1821682274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0mngPl7KWIvpaE7OO1ZplHJVHIc1+52hFYNxFM41UA4=;
  b=ZjU0S7g8+r6K1/xvvb1BeppyN0Ehx+9ZJp97q3ZAEoRNa8Ri5ex8q5AT
   pSsiXhS6IZIKzOj1YqQnINhclaTIgk++ugDnNoYRokU32hjUM88gcUdHO
   aTlzkssiFTKA5rBB1BBpBx6yKIGsQAR5teVGIpnPwgaFyWmzt7Ng3GY8+
   c2P1MRz1ermDLr8tXrgOlwsrZ/CpKc3oLY1Pt3294sbZVuEBv+su/0NHa
   u0eUvBAkno3j7P2wxcE/H4NIH3xmy9xcGWEwgXGuykCZbvqAZnRJC5BFc
   WnWQj9zRrkHEXO1PQi3XphDlvHvLj1QzIYDTMrYot3MvQJ7riVtmsp9l7
   A==;
X-CSE-ConnectionGUID: HZ8i01C/QyuKdcGbe1BGbQ==
X-CSE-MsgGUID: xRHbp5MhQIOPqD6TMHrbtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90831056"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="90831056"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 23:51:11 -0700
X-CSE-ConnectionGUID: O2KnseYsSOSd7QpmEBureQ==
X-CSE-MsgGUID: 01ZAONYmRkS0IKeJvKA+kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4761836"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 23:51:03 -0700
Date: Wed, 23 Sep 2026 09:50:59 +0300
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
Message-ID: <arN20-sGytS6BlZc@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1>
 <arDVIEobkRr3E7yS@tlindgre-MOBL1>
 <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
 <arIfu_A1e6KEokWI@tlindgre-MOBL1>
 <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288de298-2773-4fa5-8020-21b61bbcad67@intel.com>

On Tue, Sep 22, 2026 at 05:37:33PM -0700, Kishen Maloor wrote:
> On 9/21/26 11:27 PM, Tony Lindgren wrote:
> > Oh right thanks. I think this is really the maximum transfer buffer size
> > Peter asked, not just a hint to userspace :)
> 
> It is a strict upper bound. Maybe it's semantics, but I called 
> it a "hint" because allocating for that entire size could be optional.
> If a userspace driver for say TDX wants to send smaller batches (say 128) then 
> it can refer to the spec, do the math, and allocate 131 pages and the kernel 
> should permit that; it's not wrong. If userspace ever allocates less room than 
> a call requires, it would fail. A different userspace driver could simply 
> allocate that max size and be done; no need to refer to the spec or do the math. 
> It is for this second case where I thought returning the upper bound would be 
> useful. Hence the earlier suggestion.

OK 
 
> >>>>>> +struct kvm_transfer_buffer {
> >>>>>> +	__u64 address;
> >>>>>> +	__u32 size;
> >>>>>> +	__u32 reserved;
> >>>>>> +};
> >>>>>
> >>>>> Should this struct include a 'capacity' field (u32) that is set on each command?
> >>>>> It would be the number of bytes writable at address.
> >>>>> size would be the input length on entry (0 if the command passes none), and the
> >>>>> number of bytes produced on return (0 if none).
> >>>>
> >>>> Hmm so the transfer command return value can return how many bytes were
> >>>> written of the input. But yeah we don't know how many bytes were written
> >>>> back to the transfer buffer as result of the transfer command.
> >>
> >> The transfer command return value could return how many bytes were written into the buffer.
> >> But in an input-output call, the kernel handler wouldn't know how many bytes it could write,
> >> or for that matter even how many pages to pin up front in case it needs to return an output
> >> because 'size' couldn't simultaneously convey the input length and buffer capacity. That was
> >> the gap that I thought a read-only 'capacity' field could bridge. Of course, this
> >> assumes that the output is written in-place.
> > 
> > Hmm yeah this inplace capacity vs transferred issue remains still. So I
> > agree we need to specify the capacity in struct kvm_transfer_buffer like
> > you suggested.
> 
> To be clear, I think the in/out split for the buffers along with the convention 
> I laid out closes that gap I saw without needing a 'capacity' field.
> Because out/size could now unambiguously convey capacity on entry and output
> length on return.

But for an inplace buffer use with some input data smaller than the output
data, would it work? To me it seems you need both buffer size and data
size for that.
 
> > To me size is already the size of the buffer though. So instead of changing
> > size to capacity, how about something like datasize or len for the input
> > and output transfer length?
> 
> But I understand that (and please correct me if I'm wrong):
> a) You'd still prefer to not have 'size' serve that double duty.
> b) 'size' in your mental model already means buffer capacity.

Heh yes correct for the above.
 
> In that case, we could add a 'datasize' field to convey the length
> of valid data in the buffer, like this:
> 
> struct kvm_transfer_buffer {
>     __u64 address;
>     __u32 size;
>     __u32 datasize;
>     __u64 reserved;
> };

Maybe bufsize and datasize? Then the difference would be obvious while
reading the code.

> The convention then becomes:
> - A non-zero 'datasize' on 'in' at call entry conveys that there is input.
> - A non-zero 'datasize' on 'out' at call exit conveys that there is output.
> - out/datasize on call entry is ignored.
> - in/size and out/size are seeded with the buffer capacity.
> 
> > 
> >>>> How about if we add the bytes returned to the transfer struct? Then the
> >>>> kvm_transfer_buffer can stay as just a buffer. 
> >>>
> >>> Actually, for the possible cases with input+output, we could reserve space
> >>> in the transfer struct for another struct kvm_transfer_buffer for the
> >>> results?
> >>
> >> Yes, say an 'in' and 'out' kvm_transfer_buffer inside struct kvm_migrate_cmd should
> >> close this out and shouldn't require a 'capacity' field. Maybe we then establish this
> >> convention:
> >> - A non-zero 'size' on 'in' at call entry would signal that there is input.
> >> - A non-zero 'size' on 'out' at call entry would convey the buffer capacity.
> >> - A non-zero 'size' on 'out' at call exit would convey that there is output.
> >> - A zeroed 'size' on 'out' at call exit would convey that there is no output.
> > 
> > Looks doable to me but with the inplace issue as above.. Sounds like we just
> > need to reserve space for a case with a separate output buffer though.
> 
> To be clear, this is what I thought we were talking about :)

Heh yeah we're talking two things with the inplace use vs two buffers :)

> To add a 2nd kvm_transfer_buffer to kvm_migrate_cmd, like this:
> 
> struct kvm_migrate_cmd {
>      __u16 command;
>      __u16 flags;
>      __u32 reserved;
>      struct kvm_transfer_buffer in;
>      struct kvm_transfer_buffer out;
> };
> 
> If there is agreement on this model, then yeah, we'd want to define
> these fields now, since the struct can't grow later without a new ioctl
> number.

Based on what we've discussed, my preference is the following:

Keep the current buf naming. For the EXPORT/IMPORT type functions the use
should be obvious from the transfer type. 

Reserve enough space for a separate output buffer or results buffer or
whatever it might get called if such a use case ever pops up.

Add the datasize to struct kvm_transfer_buffer like you suggested and
rename size to bufsize.
