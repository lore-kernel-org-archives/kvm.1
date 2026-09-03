Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCF3806C6;
	Thu,  3 Sep 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427132; cv=none; b=WJ+lSb5WRT7uVwU3rZwCzyhgsJUOT2LV2E/KcL6wS5FVAFQAeyL+ZJx0thuVIqDb4k9hnnlDB3gHe5ygBFnUlEY3cI3iLcC7zzbQGDyjG5droUsStweM4niTXsD1qr2xHhTLFXIAWgu3/nwD6PL5CXqLaXxydKv/3X9qxFKUslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427132; c=relaxed/simple;
	bh=dyS9eTW0CVcIxmYUq6Dh7YZPRRwPdp9Onqle2XWVEms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYSEDR7PRYoQuhzNO2PbSvAU2ZUeY6BNqJ0XhpANVhTlZJtadITPYRM7Z2S9d+1zojwaxGvIwR5EtsuJgeUoMLoje5d4GnKMN0O/tSxaByNVFCTMoE2uGNBaBgjnQI5oJ4umEKHCZfko6w1KpGGtVivwn9voe2Fy20k9fCZytMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWYzMay0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWYzMay0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788427130; x=1819963130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dyS9eTW0CVcIxmYUq6Dh7YZPRRwPdp9Onqle2XWVEms=;
  b=UWYzMay051kjcpsk3UapY+j5cHh+S28ATXFdstMLpMrH9RnJQ1S4g7UY
   J+mQ9G9VLyyB5Czmg/TWXZndb8+kHMJ0MuRLPeQsH+P8d2KotHL36nj/S
   313de7GHarybVLyryIO/UCKgLd9m1dfgCKjKVj01Bl0yTdOkyjMobigI8
   Lwyx6iET8jvFkMoL8LPuI/1vNWE/eTUaL55By2ejCxdZJn8a7SNHUwLPw
   2rk385kwH7NuX94MA20oizEj+zWonNMo6m46h5arlfvStJNlSuEpTVzO3
   uOGFhXKT2Fu1s1krhyhFNq5xq0XD8t08vguU+c5yeVqVKWK99tde+ag1y
   g==;
X-CSE-ConnectionGUID: 1Cav0H3sRL+HN7bQuopVLA==
X-CSE-MsgGUID: pfXylP2hSQa8G+KFGgGrSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114448338"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="114448338"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 02:18:49 -0700
X-CSE-ConnectionGUID: QxjMoLSOTIOdXGIo3bjLaQ==
X-CSE-MsgGUID: OWVN8APHSbGUJf7LIZKccg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="273179912"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 02:18:45 -0700
Message-ID: <b14bb5cd-9bb1-4eb2-aaed-2c62daace3ff@linux.intel.com>
Date: Thu, 3 Sep 2026 17:18:43 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] virt: tdx-guest: Calculate the Quote buffer size
 safely
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-3-peter.fang@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260729122939.1340412-3-peter.fang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/2026 8:29 PM, Peter Fang wrote:
> struct tdx_quote_buf has a trailing flexible array member.
> struct_size_t() calculates the size of this kind of struct safely. It
> handles overflow, which is an important property since the Quote size
> comes from the host.
> 
> Use it in place of the fixed length limit.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>


