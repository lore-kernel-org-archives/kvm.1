Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C83769F6;
	Tue, 16 Jun 2026 03:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579574; cv=none; b=kH7K0DsECa8MMHDtS60h7lfXloe/l1oGdM9+OG/RATpnh3EI7elBkn0byWAKaxgWKCCzigs+20fC5sTddfwO9DjNi9bXjgeAQqkflPZj+35nZ2rfnR9TLYAvgwd4gEqRF8T5mwPjK2bTNQql9saCkU619vzxIQ+Ff/uw7s+aRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579574; c=relaxed/simple;
	bh=5Qb9E70od3L/wpfasL0KUhTUMNltxxUfSwxwXMX1d58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erZM0HtbDqaavTq2nXJmw8otGioscjfa6MgB0HJQl9f0ggrc3JoSQWyKbYXebJ1zjfBcdnIL3CF0mEAd7R7nI2sIUg1aAzvLR0kBUwwLWbBBENnYqaFrd019u7Y8z64zNKgGDwlTqSHWiz7n1LHjqe2Ae+Hrj1FL+WbikWWVnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X46OfPgd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X46OfPgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781579573; x=1813115573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Qb9E70od3L/wpfasL0KUhTUMNltxxUfSwxwXMX1d58=;
  b=X46OfPgdG2n6l+7c8vlRpyMl2W/vKsL3Ct4bugY/NPvJEVqMwJbUiFDh
   qlYfSID16c42t11p02M+hxS1EIa7mKJ/9Tjp7Z0JzBDmIf737IO4WrXTx
   GuHdFM1jMF306KN17c7ZSLB4rmcXjIJNeww22f7OuWdgmgn2scvEeIpjy
   I/s6vJNXuzucoty+QR2pl4EZVjNHIr/t3+kdLYLnIDys5w7nokvY0mzv5
   d47w8FYr74NgTC0fXBdOjA/cjnfLP3rJTmrx3s+SXKw2ofTl950LD6DZf
   GVlu+B3bvWGt8oiClG6A8dgFvlGyiQkdxzQX6Lb3zyYHDbiVDQgf6ykGk
   g==;
X-CSE-ConnectionGUID: i1qUggaAQeWpcXUSqEIYgg==
X-CSE-MsgGUID: 7M3m7P8jRXampcTmYH3YMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86173930"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="86173930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 20:12:52 -0700
X-CSE-ConnectionGUID: O1Z7pPUpScevwFUuAebIEQ==
X-CSE-MsgGUID: dRhkqa5kT52tMhi4aKI5Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="277838792"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 20:12:50 -0700
Message-ID: <da3e7bd7-eb9a-4a89-b426-899ae7dda35a@linux.intel.com>
Date: Tue, 16 Jun 2026 11:12:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-19-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-19-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Move the definition of "struct kvm_x86_msr_filter" and its associate,
> "struct msr_bitmap_range", to msrs.c, as the details of the filters are
> very much implementation details that can and should be buried in msrs.c.
> While the _existence_ of filters is public knowledge, almost by definition,
> the contents don't need to be exposed outside of the MSR code as the filter
> data is provided by userspace, i.e. it pretty much has to be dynamically
> allocated, and thus never should be fully embedded in a globally visible
> structure.
> 
> Note, this creates a discrepancy with the PMU event filter structure; that
> will be remedied shortly.
> 
> No functional change intended.
> 
> Suggested-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
