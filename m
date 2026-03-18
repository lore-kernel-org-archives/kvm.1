Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C230213E89;
	Wed, 18 Mar 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817998; cv=none; b=K2v9L4Xqv5xX+QMFSM5fnLvfIYwEaeSmNDFehvm5vSJSnREJqWx7TE6k+ot4pjNRb819Te0IhYNZo4f6tiVHgQgWB0eiXV9+lqNJJj0Cwg4DV1QiPPqslejW7w5/Jr77XFDaYCmfj2dbnsNqM8Bc+Lx9IFOFc5P35GI7VOzPMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817998; c=relaxed/simple;
	bh=ZoFcTiK9dwks0CzY+u+U0zNNzCaL6zIBHQTN8cNkkU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0c3r+PLDbZCqC3qUAfwfINzAjhEfgU7EO4okeiaC9iDVh9hM0Q6jkbvlVhCfI0Uju/8gqmMW6v8prMCIf+5grVBHTACGHAVUPlARlGCSryTwp9H/XrkGIDp+e+w6Xs0waR4luU5TEn11uR4BhGxbyhqdUpH59kfohYFX/3eM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koSA6Kw6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koSA6Kw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773817998; x=1805353998;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZoFcTiK9dwks0CzY+u+U0zNNzCaL6zIBHQTN8cNkkU0=;
  b=koSA6Kw6ch5+MRSys+0zRPi0MRDJBET2ax32XMBeZPOMQjNe5lbQ+ygZ
   Gtj4jl+o4c94MTVwzX9HoWreczLOQVoCDjjmDg0vpjrmxDZ96pkpOYlST
   kYSOlyBmHEQXd5CqYJvvLphA9ZOT+Lj71ITpvCdJqSimxY+rBhHYrjshL
   l4+PVRtm6+TWbBfRFBZCS+YUtKF3R1HhpmzX2lEAafwTfjyedggUvklQc
   lo6SQvoQmx1MvnJk3nVAxAt0QEg8n96+okDm9vJSvbmdhgMk56fP0Obzr
   G+/Hs63IdfxNdV/jNaTcdcGYJN42MYYYSGDz5VaDBSD0e0iyLjFAnoWYv
   w==;
X-CSE-ConnectionGUID: QbkDC0WAQOqZMtzwG0z2PA==
X-CSE-MsgGUID: ZBXesVZKQy2bSn+mlADFJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92435950"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92435950"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:13:17 -0700
X-CSE-ConnectionGUID: rP5REFf2RtaKNdJ5X9SOuA==
X-CSE-MsgGUID: fhp9d5bJSMmkPUv87y9hHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222581920"
Received: from unknown (HELO [10.239.158.72]) ([10.239.158.72])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 00:13:09 -0700
Message-ID: <935081ba-9f66-4bdf-a408-c19be32c6ad3@intel.com>
Date: Wed, 18 Mar 2026 15:13:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 Farrah Chen <farrah.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260315135920.354657-5-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/15/2026 9:58 PM, Chao Gao wrote:
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
> Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
> ("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
> callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
> the kernel does not need to interact with it for runtime update.
> 
> For details of P-SEAMLDR SEAMCALLs, see Intel® Trust Domain CPU
> Architectural Extensions, Revision 343754-002, Chapter 2.3 "INSTRUCTION
> SET REFERENCE".

SDM started to contain SEAMCALL definitions. How about just dropping 
this paragraph to avoid people from reading the old doc?

...

> +static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
> +{
> +	guard(raw_spinlock)(&seamldr_lock);
> +	return seamcall_prerr(fn, args);

How about adding the reason of why choosing seamcall_prerr() instead of 
seamcall_prerr_ret() in the changelog?


