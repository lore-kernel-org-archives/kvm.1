Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355593DBD68;
	Tue, 31 Mar 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952609; cv=none; b=FCHi1yD5rVt+8RBeAI43ETa4gsomwPEitbm/cJrFlyJLJaNuVo2byqrrD6VjuTwdpSWLBh46QZ6iykRd0Q4G7V0tPKVEyPPmR7xLVpwVkothGBU+BoxKqSOt2s1o/DBcY/xERqFTn5bxA8xdX8Hff/N2QEUHz4t/N0k/E2Li/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952609; c=relaxed/simple;
	bh=SWf9lqgvO+gKL3ZsoHo1JIQesnmHtmpMinphTTBUfr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA21x99LLIu0Y3zjeJCabrRkdRNjOoddhv5YdHyhQVIoGnys8NxfLCC+0mDieqoqFA0NsC8wVHoOLOBI0VM57RNg09MYcQeUJr3c8uiTTsWGvbl4ubP14+8N0W9/UGXMi7lydZ8L8704A46VHYduKLJYpuHLniFTyyw/BT2UGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kY4hWLzE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kY4hWLzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774952609; x=1806488609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SWf9lqgvO+gKL3ZsoHo1JIQesnmHtmpMinphTTBUfr8=;
  b=kY4hWLzEhU2lndt3/yvVtNe6e0nwEaCudXqVflrSkSYeYwxATLT238s9
   LMXkwYb6zLuehcV1xOqTdLm/UsPhUhbgIHMgYbRcYKeiTpRlO8GAGf0XN
   wMJwadnBhkDZpU9JwWS5yOYf85hD3sQRK18/YGDTNSBRexkoqUw/s65IW
   t5ciOt5lVENHiGB65mqjFoh3pytrlP+GeSZRWq1aZ3oDiAcIp6B8VkOid
   uLUYVxsHsASGZPwE+IvJiFQIRZGY3MR73hBXf7uIDp/OKMkgRitMT9SZl
   /TCjf90L4FisoztOCsnbByIqDAv9yr+ltPZ4JOghXiwQlztSt4pFDPIIF
   w==;
X-CSE-ConnectionGUID: BhtV6zXOSOiNcdZW8qf7Dg==
X-CSE-MsgGUID: PzYaO9n7QKaxzicpG3q1vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93348490"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="93348490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:23:28 -0700
X-CSE-ConnectionGUID: E34X/ZbzR2GbkQ8IVNG+KQ==
X-CSE-MsgGUID: XyPVIRZURVmal8FpOoECOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="223028900"
Received: from unknown (HELO [10.239.158.60]) ([10.239.158.60])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 03:23:21 -0700
Message-ID: <10413396-e7ef-4303-b3ba-558e65ad3b5b@intel.com>
Date: Tue, 31 Mar 2026 18:23:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20260326084448.29947-1-chao.gao@intel.com>
 <20260326084448.29947-5-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260326084448.29947-5-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/2026 4:43 PM, Chao Gao wrote:
> The TDX architecture uses the "SEAMCALL" instruction to communicate with
> SEAM mode software. Right now, the only SEAM mode software that the kernel
> communicates with is the TDX module. But, there is actually another
> component that runs in SEAM mode but it is separate from the TDX module:
> the persistent SEAM loader or "P-SEAMLDR". Right now, the only component
> that communicates with it is the BIOS which loads the TDX module itself at
> boot. But, to support updating the TDX module, the kernel now needs to be
> able to talk to it.
> 
> P-SEAMLDR SEAMCALLs differ from TDX module SEAMCALLs in areas such as
> concurrency requirements. Add a P-SEAMLDR wrapper to handle these
> differences and prepare for implementing concrete functions.
> 
> Use seamcall_prerr() (not '_ret') because current P-SEAMLDR calls do not
> use any output registers other than RAX.
> 
> Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
> ("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
> callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
> the kernel does not need to interact with it for runtime update.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
