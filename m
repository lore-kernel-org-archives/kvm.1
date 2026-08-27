Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDC361657;
	Thu, 27 Aug 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832576; cv=none; b=P0x9EXQ0GO59ViPcQcvJdOM9pZOqAbyAk/WK8tb2tZbb0pbeFav7H1W/YAqsfmV2EC4xWyVVhq9lw8TK6wkojiSIHr5TJElrXwCQlsDsji7p2HoiSaSZjz8rPyIxTZ5g5C4cywxRR+jga+0OmN204KFrvE1lOq+VCRXJaRUqUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832576; c=relaxed/simple;
	bh=dqY8xDQUXJN1jB6xQMJimKfVxNtx6G07QEVauBcyu/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEBH/+WoRy1OcPpIgPhg7iBWY25JcCy+6V76ciBAclyhRWuOwc/Kudksy4tevNCvgfoxklfwFtM9lR3TSOOgCPom+ntBm7Dl+WDRQcCJtuZ7fzdy6VHfiRMH+Lq+zsdfGx7XA4jlf07PpoAQVxGzXe1S+Sf2aemWMyWWm2xxCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGc14r47; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGc14r47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787832574; x=1819368574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dqY8xDQUXJN1jB6xQMJimKfVxNtx6G07QEVauBcyu/o=;
  b=gGc14r47rPZvF4xUdi9NclVpdjbjqIWqsg0j+0FpGettGRlcx88Iy4pZ
   IH8yNRtQtvnvy1fMrjFyzfHPumjwoO/MXysVAg41QPlsSFGKQUyRwQ+EV
   KOEaTGBaruvkmlMrRNPxnpG7qZ17bRQo2aVo2sld1Xg0MWmxpAzUtJ0V5
   eH1S8VE98AdHSPmAAhCshsImUWKy+KHE/h3tBdZbwBA4EQ1rNrlNXmjjI
   lyGyHN+FzLuIS/6o45TxOscJUgcBEvRh0W5shTWD9bXzGCYl2otQYXn16
   EzbQW8HnQq56gkV7/SXpGIWCWm3hPTeDaJPstzK4RcEBYxAtk9HDx0oSN
   g==;
X-CSE-ConnectionGUID: jJPQOfxgQZGlnquPo8+iJA==
X-CSE-MsgGUID: NKFcc46vRxuP7/vbo4blsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87273408"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="87273408"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:09:34 -0700
X-CSE-ConnectionGUID: RRMzcS4WSG+BVCtbi8BeRA==
X-CSE-MsgGUID: g3EMG9MRSFCndiyS4u/A+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="272097949"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:09:31 -0700
Message-ID: <5b8b6182-fc1a-47e3-a2fa-f7f9d0a23bed@intel.com>
Date: Thu, 27 Aug 2026 20:09:28 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] KVM: VMX: Rename common exit info getters prefixes
 from "vmx" to "vt"
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>,
 Yan Zhao <yan.y.zhao@intel.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-9-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260826171246.777729-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:12 AM, Sean Christopherson wrote:
> Rename all common prefixes for the APIs that get exit information common to
> VMX and TDX from "vmx" to "vt" to capture that they are used for both VMX
> and TDX vCPUs.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson<seanjc@google.com>

I like the rename!

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
