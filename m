Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3334A2798F8;
	Thu, 21 May 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357809; cv=none; b=S1H+XEViS4sw3bKdyATVv3W0nE6hHpC5QlYtIX+ST5sS13pXBy5LMig7WZoq156scyfJ1xOdylNx11daoFzNcb5ROh+xBQ4yMFnib0LQDYhyEd9fOqQbF4QhAH5HQzfplN4I/24d66CViUjSTDonqfZUB9EjB0BQaIwwH4gT7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357809; c=relaxed/simple;
	bh=2+c+lANEiuMMm2jFytQqWucZt6tHAaoShNwyBvQiCP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2Mr2mTVNILcMWBalX9tLYhy2TwqCUZuSMoyiD2GzJTe9PQrtVcMcc42chi/Fmtj2HnVaos+EH4xJHFP+56xDK9XkCa++coitLA5azZ2HWu59V7tPUoCfdMdi4uLKNT4GcTAdceVUUeBl4DKUM7pHksiZ5uHGEaK6NJJV4fU56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJV9ocmt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJV9ocmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779357809; x=1810893809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+c+lANEiuMMm2jFytQqWucZt6tHAaoShNwyBvQiCP4=;
  b=SJV9ocmtjXqVsnao7gOsR4+HPoPHCs9g8sgzQOiDzMjP0IG2ks0mzY/o
   sQCVeUMO3GT++ZN4KRcq0Ck7EcuqurDg8NBJVQpkKRgTOGZZy3FSDDpzt
   8fFgW4F0pjaWtSGYF7UIosVzAQv7yNnF7w1Ho3E3ANS2mZ/s+yaNBwRtH
   LX+v+WjItS/DqwyaOIZjwtu2lk0XYKmOM/FT2m7OvO9Vx8ccEZRGD5A0R
   QiXCIDacM4tjlEGE1AeRwRjVaGEUKl1VNz4uF6I5F702pn7MqRJUOxTgG
   8Lmm21SBin4QWc3iJGIlEQJg75AllIM+Pp57ygVWH8fUbEynOglrXSCC/
   w==;
X-CSE-ConnectionGUID: 18yxl3ROSZ2MwPb8Rt0miA==
X-CSE-MsgGUID: 1MG8at2eS0ijk/bgOXtb8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80328125"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80328125"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:03:28 -0700
X-CSE-ConnectionGUID: VvxLMYaATfOGlGaEtovo4A==
X-CSE-MsgGUID: tgrVaY0qSUWt5SaIHfP2Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="278599650"
Received: from unknown (HELO [10.239.158.74]) ([10.239.158.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:03:22 -0700
Message-ID: <74f96bdb-1b17-475f-ac8b-d4bf1de10b0c@intel.com>
Date: Thu, 21 May 2026 18:03:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/25] x86/virt/tdx: Clarify try_init_module_global()
 result caching
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
 <20260520133909.409394-2-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260520133909.409394-2-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/2026 9:38 PM, Chao Gao wrote:
> TDX module global initialization is executed only once. The first call
> caches both the result and the "done" state, and later callers reuse the
> saved result. A lock protects that cached state.
> 
> The current code is hard to read because sysinit_done is accessed under
> the lock, while sysinit_ret is not.
> 
> To improve readability, move sysinit_ret accesses within the lock.
> 
> Group sysinit_ret/sysinit_done updates right after initialization so
> Caching the result is separate from the initialization itself.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
