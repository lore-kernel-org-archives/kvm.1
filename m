Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FC2459C5;
	Tue, 11 Aug 2026 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418249; cv=none; b=WKorOeOtmgC7lYgnCF68x7PLKhViiAykxVqzaNHvmOb9+Z28MfrMTV6b+XY/eRsg73Ph54dssN+gVhSDNWz/cZe7hl37OmciFk1yc2SiqMttoiJYgm94NRtoc6p7O9GdQAsIi6+woYEhMkjH1W7twSVRNRg03yfZnagmO40iVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418249; c=relaxed/simple;
	bh=QTCq14i7jxrlvROni+h5Y9gFqQzT44xa9JZvCkaz8yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms8HfiA3wUJQrlDQPER++4tXmlW1TzgVdj8YOSLa6vPJ8Za+T8RahO5KumZGONCX5+2bzNBVp1AWxDXaU2wNMhNE3jCrqG4ipvAkqar4kRHHAUfp9XHCNLGN0QbEF67sdZLcab8UirUqQXAptFoE1ukX2DrvfO/yg9cwh/V6UR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzczaKHC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzczaKHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786418247; x=1817954247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QTCq14i7jxrlvROni+h5Y9gFqQzT44xa9JZvCkaz8yM=;
  b=BzczaKHCafo5Ef51oKkIwxzp6ufkJrXNb5eOIa3xGrt8R9tp2wmqCw1m
   ijnV6YblAUZqnvc/KiqJAMRln27lWSJX1NtNTxO0CPvOIi8aZPIurE545
   g6m5u9J+o+nvgAYA7uXxmdnUAMz7mXxUCigd8kTxeIz7kadqHUzFKhujP
   iQB8NVX1ZZZx+qdxBTujrYld+jC3GqLdkAVejqDGM4tvEccjRBuIHUS47
   dzmr4Bcb+0HZ2obxelXveb2No6wkErEUUuwKTbf5tRK+ox7u6EdhEL6iG
   5Mv2aL3KvRf0XxReg3GoFeer4qhDuTpVjXfk6liZSei71lgFCDCmsUVlq
   g==;
X-CSE-ConnectionGUID: DnNfQ2wKS6+vOZaT5xIHYg==
X-CSE-MsgGUID: R0iiYM/HSo6vhME+x0EFXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86952320"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86952320"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 20:17:27 -0700
X-CSE-ConnectionGUID: F37ECsn4RsGMoY53defQmQ==
X-CSE-MsgGUID: 96gk7SEeQGudqam8JoBkqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="258938771"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.248]) ([10.124.240.248])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 20:17:24 -0700
Message-ID: <30686bd2-37a4-4cff-82df-29c918444a58@intel.com>
Date: Tue, 11 Aug 2026 11:17:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kiryl Shutsemau
 <kas@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com> <anpmxJOESl3swUpd@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <anpmxJOESl3swUpd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/11/2026 8:03 AM, Sean Christopherson wrote:
> The shortlog is way too generic, and the changelog is light on details.  Over
> the weekend, I managed to forget why this was necessary, and it took me a few
> seconds to recall why we need to avoid setting bits 31:16.  Of course, one could
> argue that says as much about me as it does the shortlog+changelog...
> 
> Oh, and shortlogs like "Fix the exit reason handling" sometimes lead to amusing
> follow-ups like "Really fix the exit reason handling".  Don't be that person :-)
> 
> Something like:
> 
>    KVM: TDX: Don't clobber exit_reason[31:16] when TDX-Module didn't try VM-Entry

1. It's not only about clobbering the exit_reason[31:16], but also about 
how to interpret the basic exit, e.g.. the change

-	switch (exit_reason) {
+	switch (exit_reason.basic) {

2. It's not only about TDX module doesn't try VM entry, bus also about a 
valid VM exit after successful VM entry. This patch also preserves the 
exit_reason[31:16] for a valid VM exit. (One could argue that existing 
code cannot clobber exit_reason[31；16] because the code to clobber it 
requires the [31:16] to be 0, because of switch (exit_reason))

3. For the case where TDX module doesn't try VM-Entry, I'm not sure if 
"clobber" is the correct word. There is no valid exit reason, so nothing 
to be really clobbered. Just don't synthesize a exit reason with 
non-zero bit 31:16.

My intent was just using one patch to handle them all, so as to make KVM 
behave correctly after enabling Bus Lock VM exit for TDX in the next 
patch. Because they are targeted for stable kernels.

What's your advice then? What do you think of spliting it into multiple 
so that it's easier to write a shortlog and changelog for each one.
