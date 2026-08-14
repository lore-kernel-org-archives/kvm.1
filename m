Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685B19E96D
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669363; cv=none; b=VZwLUlqWJXzKYgQoJ7NeaIWoXj/spJyxTK6bpxWtIv82JnK72rPInQ2a08N7UKhdwsoJvVD2msqBm0FN41vt+Cs6v/24Mfm2w4Dv9ubvd7/5fa2/uPYYDw+4yKpf2+3S2CL1dFQeUQ55UKYXisKBctgB1RW5JLRUO4OkmqpT73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669363; c=relaxed/simple;
	bh=0B46lS5Ljpeg4FS+ptKt2QMcbDX4xRoabXK9BHZHmQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAyQTCOQofEeIrWpOCOaaADfRSm8WVC0QW1BjTYCeGuL+Tuq2Xv5ikk5su1tTlwHX10ZujWvmLotaWm9oE1DLFtXxg4GNwcL6V+6aXAoztZbcta/AeDWGsdxWWOteoNoudHn/gNHe7aYz77ifyHo6Nv/5CFIUX+bXGUXrXdPW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZawGTaT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZawGTaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786669362; x=1818205362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0B46lS5Ljpeg4FS+ptKt2QMcbDX4xRoabXK9BHZHmQA=;
  b=aZawGTaTckMZFWIpB5zYG2fV0v61PX//D7RlYvAjlEDVrwHHoZbyrt4q
   SFOx/qt3wa+Q+AzjPBCk5OQD/9P8NM3CK7oOY+HjV12K0kG8kx4nvLPuM
   RcAR70MbDOh7LRW6gJwBjv8181Rxz5b+WHkDnuUO8bk61tZinicjVHYgU
   TPWmIPMqCa9Pi8uUd9Z98rizku24sd/IG518zVI98uBktpuchDQuLrEiZ
   6E0LHxDeiNv40bBwyGdjctJLAgjUGSs61SdsJnlVxKOmMpaWg4+XPashL
   y4cDsk01mFIK1TnE8CRCbC0yevGCkYm9AItXsHVW7DQtbttd0xNZ+NGLT
   Q==;
X-CSE-ConnectionGUID: /Gh85ii6TpiEWpg8gpIiJQ==
X-CSE-MsgGUID: oNUKLpFXRWqhs3lh7LLOmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104784435"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="104784435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 18:02:41 -0700
X-CSE-ConnectionGUID: DkZRhqoFS6O3q42sglhDtw==
X-CSE-MsgGUID: kdZDrTQ2R4CPO59AfLNKbQ==
X-ExtLoop1: 1
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 18:02:39 -0700
Message-ID: <eddf28d4-c211-41fb-b0a3-586e5afde030@intel.com>
Date: Fri, 14 Aug 2026 09:02:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com>
 <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
 <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
 <an5W5XC97HK229MX@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <an5W5XC97HK229MX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/2026 7:44 AM, Sean Christopherson wrote:
> On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
>> Side note. I really dislike how tangled this area is for something that seems
>> like it should be much more straightforward. Deriving partially I think from the
>> overloading of the TDVMCALL leafs with the exit reasons. So we have things like:
>> ...
>> 	case EXIT_REASON_EPT_VIOLATION:
>> 		return EXIT_REASON_EPT_MISCONFIG;
>> ...
> 
> I peeked at that code again, and FWIW I still think swizzling the exit_reason for
> TDVMCALL is the least awful solution.  If we don't do that, then we'll have to
> update every single use of the exit_reason to demux TDVMCALL into the "real" exit
> reason, which will be a mess.

I'm not sure if you read my idea[1]?

I think there is only one place KVM cares about the exit_reason 
TDVMCALL, just the

	case EXIT_REASON_TDCALL:

in tdx_handle_exit().
[1] 
https://lore.kernel.org/all/646f9595-459f-4224-b4e5-4ec2eecc0bc6@intel.com/
> And once we track the exit_reason separately from vp_enter_ret, IMO it all becomes
> more logical and easier to follow.  vp_enter_ret holds the information about why
> VP.ENTER returned/exited, while exit_reason holds information about why the _guest_
> exited.  Obviously it's imperfect since we're still fudging EXIT_REASON_EPT_MISCONFIG,
> but again, I think that's a better alternative than demuxing exit_reason in multiple
> locations.

The question do we really need to swizzle EXIT_REASON_TDCALL to other 
exit reasons ahead? why cannot them just be handled in the central 
handler for EXIT_REASON_TDCALL?

I think there will be more problems when TDX can exit with the reasons 
that are currently swizzled from the TDVMCALL. e.g., when EPT_MISCONFIG 
can happen on private memory.

