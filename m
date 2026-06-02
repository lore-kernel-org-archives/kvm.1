Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039116A956
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363584; cv=none; b=YpzV4P6xEgoRGx5X8Ms7TA7l/cnRptCeLVzWcuuu9iPro3EXndDEi7309vl3ezjeaOvo0TQ89X/98fLNRk/y28sw06r+CoX89ZWIFb+LrHxvdNgcJ7z7MZClHzHzRfyrz6kWCYU0BMSO1tGBbvq4cxlI7vUuVHT96/yu3lWHP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363584; c=relaxed/simple;
	bh=l0zoV8l3EipfPh9dInP5LKaSIPGVrjdjqMCa+8pcMZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Moh2tg/Oa7IS+YLToELyHQhjra6+Te/MbnH/X00YQeaSjpTc2fNsrGg7xiP5Gzj9olN0I4jReD1Fpn0mApU7V6PO6SDgduoZwEOc1uOiXbJw4eNfn5wr96+GGIh+rFschedCLrk4oqZ1rn2ux+r1V+PA34z/4/V55ulNfJIYaJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcqpYeiN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcqpYeiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780363583; x=1811899583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0zoV8l3EipfPh9dInP5LKaSIPGVrjdjqMCa+8pcMZg=;
  b=QcqpYeiNmbmbTAMDFZ43A6zjOC9EdpO6fTDrTRV3FbVYxKO/fj6mUHNR
   ybHLGlx/kSsruuira4+q9R5sXY+Ngd+MpP32Y7MAgTnG5LsqbOGV0f71T
   bmkpFPF+iufxMcWdBGZlPQZRsIbJDJYeFF2jOOya9ctpfUNj1AYXik9Bn
   PnoKubgTRbXXKR3UsYPRQ0op7nemctQJzo0kb1Ygb3+/sFa4JNrOpgXOL
   HMv9WPx16cn4hhMbo1f2Pi54mUIbeLx1wm3ihC7RkDBWsjYp/V3e7IiJj
   OQ7QVlqV6vZycg2BqQNdhPDhsSVo/UdFx3AaKI6QCKjNX+qrY0QDGbnv5
   Q==;
X-CSE-ConnectionGUID: 180UwEaVSW2hclBAJxxr3g==
X-CSE-MsgGUID: o531OAKlTvaUUhG93gJQ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91820176"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="91820176"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 18:26:23 -0700
X-CSE-ConnectionGUID: e3yx+bZfQByAAonP4lU1hg==
X-CSE-MsgGUID: HhgyioKDSq+BIcgsNa1XCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="274010898"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 18:26:22 -0700
Message-ID: <7cab17cf-58f3-463c-8350-879ab1443e49@linux.intel.com>
Date: Tue, 2 Jun 2026 09:26:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] x86/lam: Allocate test page from AREA_LOW
 instead of AREA_NORMAL
To: yexun <yexun@linux.alibaba.com>
Cc: kvm@vger.kernel.org, chao.gao@intel.com, seanjc@google.com,
 pbonzini@redhat.com
References: <20260601035401.39303-1-yexun@linux.alibaba.com>
 <8f155587-07b8-4315-9015-3d104ddfb34e@linux.intel.com>
 <ah13KeNB2jw0lUUw@U-KQJTCFK3-0011.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ah13KeNB2jw0lUUw@U-KQJTCFK3-0011.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/1/2026 8:25 PM, yexun wrote:
> On Mon, Jun 01, 2026 at 03:15:45 PM +0800, Binbin Wu wrote:
>> On 6/1/2026 11:54 AM, yexun wrote:
>>> diff --git a/x86/lam.c b/x86/lam.c
>>> index 87efc5dd..b2dcf7f8 100644
>>> --- a/x86/lam.c
>>> +++ b/x86/lam.c
>>> @@ -231,13 +231,13 @@ static void test_lam_user(void)
>>>      bool has_lam = this_cpu_has(X86_FEATURE_LAM);
>>>
>>>      /*
>>> -     * The physical address of AREA_NORMAL is within 36 bits, so that using
>>> +     * The physical address of AREA_LOW is within 36 bits, so that using
>>>       * identical mapping, the linear address will be considered as user mode
>>>       * address from the view of LAM, and the metadata bits are not used as
>>>       * address for both LAM48 and LAM57.
>>>       */
>>> -    vaddr = alloc_pages_flags(0, AREA_NORMAL);
>>> -    static_assert((AREA_NORMAL_PFN & GENMASK(63, 47)) == 0UL);
>>> +    vaddr = alloc_pages_flags(0, AREA_LOW);
>>> +    static_assert((AREA_LOW_PFN & GENMASK(63, 47)) == 0UL);
>>
>> Although the error exists in the original code, the GENMASK(63, 47) is an address
>> mask, it's not right to mask a PFN.
> 
> Thanks for your review. What about asserting '(vaddr & GENMASK(63, 47)) == 0UL'?

LGTM.
