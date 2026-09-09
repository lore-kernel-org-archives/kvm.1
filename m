Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682254086A;
	Wed,  9 Sep 2026 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912274; cv=none; b=efZ/95RrcF0TiUNuX8aO1PqE6D/xqApnQOsGZh9DSRv7FOPQX8iMquhrP3CkeFPHFLg9D2GaTfPlC1PuplIxtQGbog4yLcDnxAarmpHToyy21gcT1kXFGOpzKmdMmCAXo6ixv9952wbtH3QV6ZVrmbAdWefKkmtnoXKSnzoc+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912274; c=relaxed/simple;
	bh=LVngz5xrrFG04RTWJfBl9aqLp7qEaRWxEYW9CKyLeE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9aLpWa1ijGD/zQqfoJR5VggAEd0J8j1vMd8OLGvVIjV90RUBaUN5g8gWJn+3QCSqGgGqlLAhIzvp/AIeO/tv9XajgOfXKZCbJnSigiYq5axrW7LHTXzyc/dS7zd1Be+0j9AIV2sQMCxKyhJvQ3m30fc8UcF7boKDHJB6GP1mqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzeamnKy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzeamnKy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788912273; x=1820448273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LVngz5xrrFG04RTWJfBl9aqLp7qEaRWxEYW9CKyLeE4=;
  b=UzeamnKyxS3XfC2hc3M7mlM7iNRkeR00aUQOsnF1Q9G93Sq5C1T8lWAy
   7uWF3F48UyxSXgwGZ64pxiU2HY/B73x+DdValmC5CpzaGsY6H3YIyBD10
   yy+g5um44kPuO8brTq2njFX71949uSeEGCNbVV2hlWtI77S30rg21toZK
   xWY3sgh9qftbDXk8nIunWAmvkvCmZlzaPeISeL9Snbz4x25F0z6UPxMV6
   OlJulGhx0YajMdY+8m9+sDi/+JUPsSGhRS4CJmq3bcB7ezA/1PzU1BtgL
   NL3HoMX9roF+LqMiSp5NlKrwxHyJUyeOi53Gw0iF2BeDYzKE8/msoS3OB
   Q==;
X-CSE-ConnectionGUID: k7oWBNqMSjq58GZnN+B3Zw==
X-CSE-MsgGUID: cAq94ggmQku84vmXmuhUKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93025380"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="93025380"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:04:32 -0700
X-CSE-ConnectionGUID: hc3g8ajMSU2qNYGaMEhPrg==
X-CSE-MsgGUID: H74i50FVRBKXxFiJf8KCOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="276371222"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.245.162]) ([10.124.245.162])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:04:28 -0700
Message-ID: <0d3d90e9-be85-4182-8f05-ffdfa24c0378@linux.intel.com>
Date: Wed, 9 Sep 2026 08:04:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <1f1877f904d0521100d2ca656fc9f0542c46a68b.camel@gmail.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <1f1877f904d0521100d2ca656fc9f0542c46a68b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/2026 5:42 PM, Artem Bityutskiy wrote:
> Hi Binbin,
> 
> On Thu, 2026-08-27 at 11:18 +0800, Binbin Wu wrote:
>>
>> Specifically, this series builds a KVM-side allowlist of supported TDX
>> directly configurable CPUID bits to:
>>  - Filter KVM_TDX_CAPABILITIES
>>    Replace the hardcoded denylist to only report configurable bits that
>>    KVM explicitly supports.
>>  - Validate KVM_TDX_INIT_VM
>>    Reject any configurable bit that the TDX module allows but KVM does
>>    not support, as well as CPUID entries with an unexpected subleaf.
> 
> Today's denylist only rejects TSX and WAITPKG. Everything else is allowed.
> 
> Obviously, the TDX module allows directly setting virtual CPUID values
> only for a subset of CPUID leaves, not all of them. So "everything else"
> above is that subset minus TSX and WAITPKG.
> 
> My question is: is there a feature in that "everything else" that
> causes host state clobbering today?
> 
> In other words, does this patch only build the infrastructure for
> addressing future clobbering issues, or does it also fix a specific
> bug?

The Denylist works fine today. But the TDX module evolves.
There are new host state clobbering features coming, e.g. FRED.

The Denylist based solution is not a clean solution:
- It couples the feature enabling for normal VMs with TDX tightly.
- Each time a new feature is added in the denylist, it needs to be backported to old KVM versions

> 
> Thanks!

