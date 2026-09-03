Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C06B3E3C5A;
	Thu,  3 Sep 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416503; cv=none; b=S91YgbyxTwzdatauvaWZjAzKCxvoAiCMZZr59xVBnn5HZdzH9a8umoY9/ikM0HVskGM5+JAQOahYmgij9d/OMvfJVo+NRUhBanRu1Y19tnb4uBqjJr5qm6Q5mDjTlrYBHs1eFxmUeCzvmF+VSD1U6Vqf4j0eqE2RoN6v6pn3C4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416503; c=relaxed/simple;
	bh=6/rj+c+IzNhry1TdYe80RDUcerB9QKuJs9SppT64Ly4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMxw0JZ1/PAwMN+UOeNjA8jtvMmZWmRq3lQCHW4K9HKgso9dKV5sJYmqnBUkp6JRADWCkdlSSTZBwUBOSVfY0Iz6fJ8RcZ51UDX3/VgnGPKG8lleyTiOjpV0VRzwE2LxHVmdLyFcFc6drI3jcrbDBAEFA6sYyg7KokCszfh21gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWl4mc7r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWl4mc7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788416502; x=1819952502;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6/rj+c+IzNhry1TdYe80RDUcerB9QKuJs9SppT64Ly4=;
  b=IWl4mc7rcXnc/en2NX1AcTu3QmAP+O7dVuu15owWYSH+86Mj5HCXFfQv
   tl6o7Qcr7/gUgTqB5f4VvGnDDRUmx8wk8R6IuXz0iPBupahQIkRl8IK7p
   Bm8LKKdrn9GlFPO3YIQh/rBDlTOeGnAu7lN75A8m/6W3MairoUvBsmLcj
   /3l92h4nBHXiIrvs8IAZzUkvZdWFo6IeonKfCYOwO928ZMLeGxXEyOb5d
   l5jerAM4g6hlJrocArhapB519k5FwiRPH3ADFRKm11DV2AvuWBfWtUg5C
   IJpxOVpCAhCq824fxhMS1egj+yA8rAJOcuvOsoPBMq8QT2Np3RmOwmTfh
   A==;
X-CSE-ConnectionGUID: ftYufxbKQSedm+4ci1epcg==
X-CSE-MsgGUID: txkFHBsLRFaUhD39bvyPDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99484683"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99484683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:21:41 -0700
X-CSE-ConnectionGUID: XQQnnL8MRAK2/JXVtas98A==
X-CSE-MsgGUID: nJUrpAGPQU2OMAWovOWtrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299488985"
Received: from unknown (HELO [10.238.208.122]) ([10.238.208.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:21:39 -0700
Message-ID: <bf51e3d3-cf28-4155-9915-683bf6c848a4@intel.com>
Date: Thu, 3 Sep 2026 14:21:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynamically
To: Peter Fang <peter.fang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Binbin Wu <binbin.wu@linux.intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-5-peter.fang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260729122939.1340412-5-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:29 PM, Peter Fang wrote:
> A new TDX module ABI reports the TD Quote size limit in a metadata
> field. This size used to be fixed at 128 KB.
> 
> The guest driver's Quote buffer is shared with the host VMM. The current
> fixed size may be too small for Quotes using schemes such as
> post-quantum cryptography (PQC), where larger certificate chains can
> increase the Quote size significantly.
> 
> Allocate the Quote buffer based on the reported limit. This avoids
> wasting memory on platforms that do not require larger Quotes. Older
> platforms fall back to the default 128 KB buffer.

I think we need to justify why using the value reported by TDX module
(i.e., QUOTE_MAX_SIZE) is safe.

From "Intel TDX Module Extension for Quoting" spec,

  QUOTE_MAX_SIZE that specifies the maximum size of the buffer that must be
  allocated to contain the Intel TDX Quote received from Intel TDX Module.

So, TDX module only guarantees that QUOTE_MAX_SIZE is big enough to hold
the quote that is generated by the TDX module. But for the current tdx
guest driver, it doesn't know how host will generate the quote. Host can
generate the SGX-based quote and we need to justify the QUOTE_MAX_SIZE will
be enough for such case.
