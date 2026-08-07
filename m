Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250A263F34;
	Fri,  7 Aug 2026 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064858; cv=none; b=W6PTp8oVhlDtn18foTZ1h0Fb6CfWxEzn16RtgGzHeslO97gJPwQQJ1IdxAnu5MAFkQbJcwQgl4rV2OVkJSm/6FLH65NV5K+YFlMuVj45i5GBLdH/R9GwEWqqjDLEF5yh1zZ0KdbKWOt37YIwKfm0167g/1qWAE618sC84VcK7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064858; c=relaxed/simple;
	bh=+58dXrIkISmA90psJJjor31o9O8NKb8/nkNfgbXG79U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=civYTt3wTH3zBa9z+Wn/VODLmmUEo0fO1A68HhB50PDVcdrvkUp8FRQvSZ1d+Zd21HFBnDvXdU7Xj/i58VLNdrfz9+eKN4DpZ4hwRdjhNJMazcistPnNchzB6hMU95fxG2i31yJUNrlo/IZfyB9Utad6u5ztLoREqT9oR1q3oyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZKWO63t; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZKWO63t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786064857; x=1817600857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+58dXrIkISmA90psJJjor31o9O8NKb8/nkNfgbXG79U=;
  b=JZKWO63tMK5GbeAlnrYovW2stIZ4HCh5eNPpKDywaV+/hp89I3/c91qL
   hIPAX20MPFnKotOhTYk+pjo1fDqbtF83DEr6ProsH2ypLnEdEBVDmOqci
   LRGh1D1nBNR/AqxsIhJrBkDjTUJl7TiNUdhkLYeCDohc6xiePaX4hA6u9
   8d2+qLJk3NAI0xUBgvaBuypLTnRqUHYRfnk9V5bIUQnwmicCS0/WXtVsL
   j0YZZzYyY8JLOZ2q9CRtylINMj24q1QmZjKfRq5aacdXK/n3alSmKA9w6
   tT7hJiofBjD7tOADVvyJXOcwVjFniawD0ct2j5KsWJKYGBIHgIhF48CXa
   w==;
X-CSE-ConnectionGUID: qTdUf6bLTdqf7qhHe7qeMQ==
X-CSE-MsgGUID: 36f6UTKDQuKTNHVq8+6ixg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="112221198"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="112221198"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:07:36 -0700
X-CSE-ConnectionGUID: WStqkYthRrCZn/hBz73Qxw==
X-CSE-MsgGUID: N/0R1n6qSAq3t4fGO9OF+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="259649549"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:07:33 -0700
Message-ID: <08e8d534-3204-4f31-9938-91dd1070ad22@intel.com>
Date: Fri, 7 Aug 2026 09:07:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Chang Seok Bae <chang.seok.bae@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com>
 <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com> <anSRCBhWi2BK9kYB@google.com>
 <5ab71720460d268e3336e521209c796ca04b0012.camel@intel.com>
 <anUngktlwsNI6oUM@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anUngktlwsNI6oUM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/2026 8:32 AM, Sean Christopherson wrote:
> On Fri, Aug 07, 2026, Rick P Edgecombe wrote:
>> On Thu, 2026-08-06 at 06:50 -0700, Sean Christopherson wrote:
>>>> It should be instruction timeout (as is in the SDM). Please reword the
>>>> changelog to refer to the name of the features as they are in the SDM. I.e
>>>> if you search for NOTIFY_VMEXIT or NOTIFY_WINDOW absolutely nothing can be
>>>> found in the SDM.  The changelog should ideally mention both - SDM's
>>>> nomenclature and linux's nomenclature.
>>>
>>> No, let's change Linux's nomenclature before merging this, "Notify" was always
>>> vague and confusing.  It's unfortunate that we let that bleed into uAPI
>>> headers, but we can simply #define aliases (or just force userspace to update
>>> as well, if they use kernel headers directly).
>>
>> Hmm, ok. We were trying to go with a minimal backport friendly fix.
>>
>> Xiaoyao, if we are going to carve it up, I guess we might as well do the
>> consolidation of the exit handlers too on this version. (a cleanup patch that
>> got left off of this).
> 
> Oh, I missed that this was tagged for stable@.  Do the mass rename on top.  To
> address Nikolay's concerns, I think a brief blurb at the end calling out that
> KVM currently uses old terminology would suffice.  E.g.
> 
>    Note, KVM uses "pre-production" terminology for the feature formally called
>    Notify VM-Exit.  All public versions of the SDM refer to the feature as
>    Instruction Timeout.  This will be remedied in the near future, for now,
>    use KVM's terminology for consistency.

Get it. Thanks for writing the blurb! I'll add it in the v2.
