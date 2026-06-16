Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDD44CF4A;
	Tue, 16 Jun 2026 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624694; cv=none; b=OrqPuVKnsJ4dgWEBb6X9Jzu6WAqEwL7ae5a9VUHVUG2n533jUejrR6vFdd4CPh5PE4NkVVkpgmVBa84CoyrAJy1nqGythMyVxPJkQ9Z5VN3YpqAza8XhL8kQRCiu2Craw1uSBu1fxSk3K5bIcMDgeNuddT1kRQJpaaVJ1kmTJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624694; c=relaxed/simple;
	bh=vseCNT9gEmCrfGxlO0c8fqLzL35bJUh8ghI+JUtTqvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX0nf6p7BocwskRnwhvmq95YjZlYA5tWD1XddmvQWZdvT9Cmd87lz5HWGk38bGAoi4Y+3VXWv/V13tr6ylV2unNSLjy4m9ZEe8jl+IOuflkfKHzEkIXfNyD9llpA/NGekRuK1HCP2y1wKByCfqQCiqDwpk4UKla83SmuBBtqmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKn7xLg3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKn7xLg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781624692; x=1813160692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vseCNT9gEmCrfGxlO0c8fqLzL35bJUh8ghI+JUtTqvE=;
  b=kKn7xLg3kWVJ2junC+SKfjKkDOvrOLhl8rHbzoLY+1eceEisk6aWmyqf
   wpxGbHlNAh9ZFQdX4sEro/r+SXUrQXQFNwku9y+cijWoBi+lsJwWUChxj
   Nkks2oLdg6BepDbilIRxTzB1IWGE66kvnR9mng1Y5i6XR4uKKiEtkrOsE
   FPcSE2as5UBJyoD52CHM8KngXHONAdRD5GrA3gW2mPUqpdzypI9UfCATt
   TrNwM35tqDpI1Ob+fHUlM0oHlSifYLYunZXWa7ab9hM6yGeZkMDlw9BZA
   1FIRh0oVUAHoAH3Byk3OUZBwsJIeAjXTaQSMRTvWq2Ea9xTQfqP79pyQo
   Q==;
X-CSE-ConnectionGUID: 1g5kA25USb+FdGHc7EfIAw==
X-CSE-MsgGUID: +obHCzYxQ5WF0cuSmKHzGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82406961"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82406961"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:44:50 -0700
X-CSE-ConnectionGUID: QQ85vL2iQ3OU7lJb2eKghw==
X-CSE-MsgGUID: wfLtxUPWQtemeTqWg4IwDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="244921624"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2026 08:44:45 -0700
Date: Tue, 16 Jun 2026 23:19:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Dan Williams (nvidia)" <djbw@kernel.org>, kas@kernel.org,
	rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com, aneesh.kumar@kernel.org, aik@amd.com
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Message-ID: <ajFplm9kLEyTe/zS@yilunxu-OptiPlex-7050>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <6a2c821a99e3_9b8551002a@djbw-dev.notmuch>
 <ajAYxo83xVV1Sb+Y@yilunxu-OptiPlex-7050>
 <1fc76b45-a25b-41a7-b7fa-06650c8052fb@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc76b45-a25b-41a7-b7fa-06650c8052fb@intel.com>

On Mon, Jun 15, 2026 at 08:57:09AM -0700, Dave Hansen wrote:
> On 6/15/26 08:22, Xu Yilun wrote:
> >> The TDX "Extension SEAMCALL" capability is akin to ARM CCA's "Stateful
> >> RMI Operations (SRO)", and achieves similar externalized complexity
> >> relief as a dedicated hardware coprocessor like AMD SEV-SNP. The
> > I may not include the ARM/AMD examples, not sure I can explain them
> > well.
> 
> I actually think they're pretty important proof points. One of the big

OK, I can include this section that Dan provides.

> challenges as a maintainer evaluating these things is judging the
> solution itself.
> 
> Is this architecture a good one? Is it overly complex? Are the avenues
> for simplification?
> 
> If five vendors pop up all with similar problems and solutions, then
> it's a pretty good bet that they're all on the right track. But, if
> there are four going one direction and one going off by itself, it's a
> sign that the errant one might need a course correction.
> 
> It would honestly be worth your time to go *talk* to the AMD and ARM
> folks and ensure that you are all on the same page. Last I checked, they

Yes, I queried ARM/AMD TDISP folks offline and CCed them in this thread.
Correct me if anything wrong:

AFAIK, AMD firmware run on an external physical core (PSP), firmware call
execution won't occupy host CPU, and the two partners communicate
asynchronously, so no worry about interruptibility and preemptibility.

From Alexey:

  "The AMD CPU puts a request in a queue, writes to doorbell, and wait for
   an interrupt. The PSP (a separate physical core) will see this, handle,
   put the data in the CPU memory (if needed), trigger the interrupt. Done.
   The host CPU can be rescheduled while waiting"


ARM SRO is something I don't familiar with. ARM has no co-processor for
CC, host invokes RMI and trap into RMM for secure execution, stateless
RMI blocks interrupt so should be short lived. This is very similar to
Intel SEAMCALL.

Stateful RMI, however, from their RMM 2.0bet1 SPEC [1] B4.3.2 Stateful
RMI operations, could be used "When an RMI operation cannot be completed
within an IMPLEMENTATION DEFINED time limit". It is "guaranteed to yield
within an IMPLEMENTATION DEFINED time limit from the point at which an
interrupt becomes pending." I see it tries to solve the same problem as
extension SEAMCALLs.

I see SRO is WIP in [2], and is used for TDISP [3].

[1] https://developer.arm.com/documentation/den0137/2-0bet1/
[2] https://lore.kernel.org/all/20260318155413.793430-49-steven.price@arm.com/
[3] https://lore.kernel.org/all/20260427065121.916615-3-aneesh.kumar@kernel.org/
