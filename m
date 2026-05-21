Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870EC3803F4;
	Thu, 21 May 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358249; cv=none; b=AIYx79C4I/t8lQUZ74cxri32Ri2k7PaiAqq8dgYeDrjOAvPaKitGJcM4HZvl86QWvMeUMMSXZYtsOSDpW2j5DxjrJTmTLPesdXsO4rUEfyMxVoM1oLAF4yMimB9DfeStkLK8eEo3urs6wc+rYZ9OXCiJKPPqR++EvKWpscSxy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358249; c=relaxed/simple;
	bh=KzNtd7vkaRdpgfmEk9+r8LcAE/xULckPWYpmRC31p/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tS78KppEmbmFtiiJGABKMMWqGL6nabJKRlvln74cwMBCvtgR21aaDcyWcP6lJ2MtnpXQX17vk/oJuicbFILMT8JVBE5Tjesta2zd9sxtHB7LQo3h0R5OhwhIso76YcR4Ua90UaQvDYG6qpEV8WqldrmRNDEF5qO8e7/Yt8rEc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUSDoALa; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUSDoALa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779358248; x=1810894248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KzNtd7vkaRdpgfmEk9+r8LcAE/xULckPWYpmRC31p/8=;
  b=dUSDoALaDIasLVgdzI0Ykk6znMq+1MiIWb2v5eWcH+I104U2vCDpdhYu
   xmMzdphzLedwi0yA3fPhmGDEe/Lp2j1HrHJKn/cdlmaUnobSUSd3EGOw6
   eNK+ruzpVB6K2LurhbTzVUcdStkxhO7Y65FY2mMN1I+PViT3OZThW4See
   igjiH3PAHryjCAhahw3gO8Rx5NXa+YjUejuvXB2FPp1xkFhWL1S5+tcW+
   9+QDzwPynscizesYFGpo9qCWIJx48YBXe/M1jCItZ+t0TDfoE+w5hViyP
   Cd2Qs3GtULwzuTlBvSDmsHKatmFSaXdSOy5+tz1ZLAXc4jqjcUtsP5v2Q
   g==;
X-CSE-ConnectionGUID: UXQq+KvTQWmdPEvx8SQaFQ==
X-CSE-MsgGUID: fWirNDMgQNSWPPFZQzp5fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80328691"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80328691"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:10:48 -0700
X-CSE-ConnectionGUID: x9d6o7WWSFa5z9lQ/djOmQ==
X-CSE-MsgGUID: gv2fM0NwQy+DoP3i8IQ78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="278600698"
Received: from unknown (HELO [10.239.158.74]) ([10.239.158.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:10:41 -0700
Message-ID: <7e288616-5ada-41d6-9338-724bd9aa15ff@intel.com>
Date: Thu, 21 May 2026 18:10:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/25] x86/virt/tdx: Move TDX global initialization
 states to file scope
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, yan.y.zhao@intel.com,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-3-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260520133909.409394-3-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/2026 9:38 PM, Chao Gao wrote:
> TDX module global initialization is executed only once. The first call
> caches both the result and the "done" state, and later callers reuse the
> saved result. A lock protects that cached states.
> 
> Those states and the lock are currently kept as function-local statics
> because they are used only by try_init_module_global().
> 
> TDX module updates need to reset the cached states so TDX global
> initialization can be run again after an update. That will add another
> access site in the same file.
> 
> Move the cached states to file scope so it is accessible outside
> try_init_module_global(), and move the lock along with the states it
> protects.
> 
> No functional change intended.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
