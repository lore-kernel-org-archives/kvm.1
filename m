Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208D380FFE;
	Fri, 15 May 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864853; cv=none; b=o70NZ4m4YLi1hHZL8ojq/YC1aVzmt9xLz0JjLtfYz+sF27jOLGFKtmRhKVbCdtTsr9bm3xJKCeFKZtuUdXm17Wvrx/BKs3Y2DVkI0j3jH+x34D6ZCMK9oIbnoHjDgytyFIUoxkX0l50qEjlsJZ8PXb7SJSRnELR5aATb/gw/5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864853; c=relaxed/simple;
	bh=39lve1qd5GHhKudxaoQqdZfvVoQUMOHO5sM1M3CGWW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIs7cpL+dllxGxmYBDiB6ieCHBo2Li1dy0i9SsMFpySY+LlHxsONu+qzMT30kFjOV/bplTK3RWXY+9hs3/ZqcNVxJc2JMypnnbZGuvz9fKoku9eetTM6QggmSRtI6kNHn3jwueLx5Dk4vG1MSv9j2QWRb9y9Mj4MrnUTfyiWa/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1SpugQd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1SpugQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778864852; x=1810400852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=39lve1qd5GHhKudxaoQqdZfvVoQUMOHO5sM1M3CGWW0=;
  b=e1SpugQdqTZOc8yAZAOy0CUYoXt5vesSgU9yBfuCfL/YWudPcWo1CgSW
   V9ckeSM2TaLpJp6QvJm5iCFnRa9R/vCB4h+NsTTm6W6oQ6TXlh5lW+4yd
   bMRzjeIQz9jgh0oB/pT4xaxhRpClAUjkZwHuUKYrU7LWQ3xI4UFUzbjyW
   LB8NHZ3B2u306S8Ehdl4dznVHw+ZYE6XjmjLPaSBxBehprHFDLUq+yj0d
   QGmn8e+cliLM16sOCxmoAH9ftm2qOhTVPOKuesI7Nd7RT7UQ6gs401t9t
   EKI/u5Jp0kzYf38bsEPpKROOAgvWeGwWDWKnuOui4QLlL0dbiarB/pEw5
   A==;
X-CSE-ConnectionGUID: EyWSZjxKQEeYyh7uMFpAxw==
X-CSE-MsgGUID: g92T8WYiQXW6AeqGkyN3tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="67353591"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="67353591"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 10:07:31 -0700
X-CSE-ConnectionGUID: Z1hic7hUSda7XeybceUR4Q==
X-CSE-MsgGUID: F8YRZUOLTM+DfUaTHTg0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="234488612"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.201]) ([10.125.108.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 10:07:29 -0700
Message-ID: <6f2ea784-3fb2-4e91-ab8c-b8f26d591f38@intel.com>
Date: Fri, 15 May 2026 10:07:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/23] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20260513151045.1420990-1-chao.gao@intel.com>
 <20260513151045.1420990-7-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260513151045.1420990-7-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 08:09, Chao Gao wrote:
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

Nit: the "main act" solution statement for this changelog is:

	Add a P-SEAMLDR wrapper to handle these differences and prepare
	for implementing concrete functions.

What's more important, that ^?

Or:

	Use seamcall_prerr() (not '_ret') because current P-SEAMLDR
	calls do not use any output registers other than RAX.

?

Now, what is in a more prominent place in the changelog?

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
