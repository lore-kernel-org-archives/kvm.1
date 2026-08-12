Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484D17B50F;
	Wed, 12 Aug 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519797; cv=none; b=jB9YNCxKOvvjRmbT0zeUNl77oo9XubSVDmetz8PrB0rpp33cO6KonkYIAObpWcf06tHfkxmU4/z19m7wWiEginAIjQRqSu8jB80vnxaijIOtYMpfkLX77ZKbj03ktTOAtt26zNAsemVg+BOQ5D2cF1x/crqdzdPwq48sj8xldO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519797; c=relaxed/simple;
	bh=QILAfq3H4DMlFgNLDzMYt4ktWH2ByPq23XNDWJHBSR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGAfuRTLxlTDEkaYm3jtB+JLgZAIyYUwVGcANKUNDKgVlHzdXu3RD9v7qNwXPGbVVk/P/y8i74ybXt1FBI778hATBs/WFsA6+iljo2GS3SNviJatWex36x85UieCL47syycYb9Cde05W16hypH98O+U/JKN1pVauTEYK0oh5mmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5f3YrSX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5f3YrSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786519795; x=1818055795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QILAfq3H4DMlFgNLDzMYt4ktWH2ByPq23XNDWJHBSR4=;
  b=h5f3YrSX2n/sWBFFulv731a5CVt2EM11SuXSAPfJzSTEIyoKx4fntx/4
   1trR/yV2+WCAta9dMuqdna1dqAjoaW2rI2w5YFkVekexSSXR69iqzBAt4
   kRQt25zliTNv6LFwNLexJw+Q68HJsgdQ8Tkpqhlp48nN3YXsRznSzcZ23
   g4xTyUkJSv7rKRbPSJSk1mWh+vzfMpcE4pWfhd1KIokq0vtiHcRNQ7g68
   Rd/nF9S+FuUe35eHOaNj+7CSeuKbANYjaPo7PGsR6HeXKBlZuADMAoX91
   sKqDzIN2R/a/XGWDMiYHszjL6twiDZJzLsVRSIeboZXqwCFUTBs3PRu6V
   w==;
X-CSE-ConnectionGUID: 4PolFNqfR/+pP0eRtHt9EQ==
X-CSE-MsgGUID: V6mKrJNvQHirr6nVHxMWvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="90940719"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="90940719"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:29:53 -0700
X-CSE-ConnectionGUID: NOTMrTxuTo6su0uWtJjW5w==
X-CSE-MsgGUID: 0h4Qek5MRlONch2ZjsJfTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="267061894"
Received: from unknown (HELO [10.238.208.98]) ([10.238.208.98])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:29:51 -0700
Message-ID: <1a7bff3b-731b-4990-8267-82d08669c8ee@intel.com>
Date: Wed, 12 Aug 2026 15:29:49 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com>
 <5dfed336a46329ba39922dcb3a8723116dae9ae4.camel@intel.com>
 <6bb1328d-e995-4ad7-9744-3ab01d2ae591@intel.com>
 <0a458dd822e5469068d5dea6aea3dd935b69e963.camel@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <0a458dd822e5469068d5dea6aea3dd935b69e963.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/2026 11:20 PM, Edgecombe, Rick P wrote:
> On Tue, 2026-08-11 at 09:32 +0800, Xiaoyao Li wrote:
>>> We could make this return instead be a goto err; that returns this. Bonus is
>>> the
>>> comment on the other one can cover them both. What do you think?
>>
>> Given 1) this patch is here mainly to avoid the false-positive on
>> bus_lock_detected after the next patch,
> 
> Hmm. Before this patch these are just one line returns. So a "goto err" would be
> unneeded. After this single line is expanded to be something more elaborate, and
> a comment is added around one of these more elaborate returns, but not the
> other. So I consider it a bit of a style regression. Which makes it appropriate
> to adjust it in the patch IMO.

Well, actually the added comment cannot be shared. For the 
EXIT_REASON_EPT_MISCONFIG case, the reason to return a synthesized 
invalid Exit Reason is to differentiate with the case of 
TDVMCALL(ept_violation), where the exit reason is updated to EPT_MISCONFIG.

In fact, we don't need such trick for real EPT_MISCONFIG, because there 
is handling for real EPT_MISCONFIG in tdx_handle_exit()

	if (unlikely(vp_enter_ret == EXIT_REASON_EPT_MISCONFIG)) {
		KVM_BUG_ON(1, vcpu->kvm);
		return -EIO;
	}

before the handling of transformed EPT_MISCONFIG from 
TDVMCALL(ept_violation)

	switch (exit_reason.basic) {
	...
	case EXIT_REASON_EPT_MISCONFIG:
		return tdx_emulate_mmio(vcpu);

But it's not urgent to fix it and it's not mandatory to enable Bus Lock 
VM exit on TDX. Let's leave it to the follow-up series.

