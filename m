Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E643F4C3;
	Thu, 27 Aug 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829631; cv=none; b=CEQNpOAoCu5HJ7d1hGY7VoNWSO3FTcxJN5rPxdVZ+o2tPg03ub21Wwhv3KRvHuEW2QL4pVS/lB5pfz5WXA3Z9i3IdydZuKsBmClbfxhXXqhSgQJLtHk2P8tde0GEF86fNJ9HdpeaytTPYlJBw2OB0Ifz2YUtxbNTMosWnEbBSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829631; c=relaxed/simple;
	bh=zSLRFNnL5x2DfE/U81g/NAKhiKXYE3cBTm/6YFBbWsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwOn0dgHlg9lDJZ3WSAttt3JFHTWgnLDdf3pFteXXnZ/iEyzgdiVDvipJUwDnqL8kLye2HHbpY/fADlOMJkwupezuj0YMbtRFZ3a3jrqtsuEakK6kdM6kj5eTyLCdVDCanXkLqJCveOwfEv+2AriW1jl4AoGyjmGxseaATJ0hFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/t0wqAM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/t0wqAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787829627; x=1819365627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zSLRFNnL5x2DfE/U81g/NAKhiKXYE3cBTm/6YFBbWsk=;
  b=N/t0wqAMV6NX9gKpvy9cUszuvKZuDCbfDyK92KD7L5D/oS3Hg2908ppt
   kb6SimAqbJdbEEU+P/6iFtOoJrf2q0WPO6zAHwGN2ZM1wHbcQokJl8O1c
   FpIXwiFhEev1rYhDpXL8uKMKUmp2DNI0kD1gZ6ut1EtShfjdYzvSFz3IJ
   zmFmm+vMqO384cwayoXuFTrfXovVVMoV1mzpWsilpKqX+Oph7qKb9eax6
   Oig63r1rUxRbZCrJ5f8ejuEhdTRfjuJd0LVNgRYcBXohcHTPuDtfrTx1z
   RSYv0+5fice8of1opC7niITEeqT6gmvZl5H3+PFw6F1Hf9PRNO4LJxpNK
   Q==;
X-CSE-ConnectionGUID: rHxSi8gpRRWgrJPgFy33QQ==
X-CSE-MsgGUID: KeEAuCF0RGemT0Pf3O9Qcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88090169"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88090169"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:20:26 -0700
X-CSE-ConnectionGUID: mOVhvOfSQj63p3yUX99p/g==
X-CSE-MsgGUID: dX+aq5HhQgW+Cfdh/tcAhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271647152"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 04:20:24 -0700
Message-ID: <328eaea1-0e59-4097-98cc-c6f5261ba351@intel.com>
Date: Thu, 27 Aug 2026 19:20:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] KVM: VMX: Move the shared NMI handler/trampoline
 to common code
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-3-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Move vmx_handle_nmi() to main.c to capture that it's a common handler and
> to allow guarding against incorrectly using to_vmx().
> 
> Opportunistically use a "vt" prefix instead of "vmx" to communicate that
> it's a shared handler.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
