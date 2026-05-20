Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D53469F6;
	Wed, 20 May 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305711; cv=none; b=ni+kYSpUXeGHKYpFr1RJ3OhPpo6WeI84OIRDEckd4PqoWCEDuuD8aI5hY7e6SrvdS1sgAaB3HDUP2mP74WtWVVfg0VeoQScvsWZ1AO57xKQdZgiFlsFr5X5tw9xRImWaG4hEweylC9FDgLOn7kbpiY2zjCNZE4o1O8jEE41ZAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305711; c=relaxed/simple;
	bh=RdcZ8ZY+8Tul4HDDN6hC6F7eMjzVrJ13hT5KbVvvu0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4KnoEdyfYXlYya2FpFMtUB2GK+kDG0E8pw7dfgJ8k8kT571Ne32VknOy++qDA548KXJNT3JSbwfTLa0uTmR8U+JjegsHcYEKCEv/MTkcLhap0nQnQ1jxe3maNziBNRWGZWtRVT1m6fw42lZ9+BW3Zj/mNO6wzfIJji/bGePCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFmyN6mn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFmyN6mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779305710; x=1810841710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RdcZ8ZY+8Tul4HDDN6hC6F7eMjzVrJ13hT5KbVvvu0o=;
  b=ZFmyN6mnrWLnR3kqtz8r05ee5eMM5RfsSid0nU/FvE0j9kNPuMUqnjtt
   wW47rgNPwiUIDZBJrzWA/aSgFH/ChKIdYSs24wrzyTXzC0ykSNkQKqEAZ
   R2bYBQt82FI4RBA329tF+5Es4CSML/6mzbMn/RrzYc+7QYdpudaIOkxtr
   clvxsdfYRfEEsCda8AKjrloxbfYpSmb1NpRip/xSjj+tCm9tWMG56hmzU
   YroTjV/BKQ1ZXEFybcsrdaUTUlWItOjkOO24IW+hZmqnlNkJuTLI+KYJe
   73hDeplZl/KtOrPpEdYcyA4acYYBe0Yy6cjX725xjq/a/iOVi97s9LPbR
   w==;
X-CSE-ConnectionGUID: Qd+rDAmZQe+jQK1qkhLpqQ==
X-CSE-MsgGUID: r/tMsR9MTcGJQUsZqWmCGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80182711"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80182711"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 12:35:09 -0700
X-CSE-ConnectionGUID: uHBEFyT4T4GuXcowqdFFVA==
X-CSE-MsgGUID: 9or94R8nSQm0LbaROot03Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="245274820"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.109.190]) ([10.125.109.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 12:35:09 -0700
Message-ID: <fc5f0061-8402-4f78-ab65-a7c8acc7e82e@intel.com>
Date: Wed, 20 May 2026 12:35:13 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 22/25] x86/virt/tdx: Reject updates during
 compatibility-sensitive operations
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
 <20260520133909.409394-23-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260520133909.409394-23-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/26 06:38, Chao Gao wrote:
>  int tdx_module_shutdown(void)
>  {
>  	struct tdx_sys_info_handoff handoff = {};
>  	struct tdx_module_args args = {};
>  	int ret, cpu;
> +	u64 err;
>  
>  	ret = get_tdx_sys_info_handoff(&handoff);
>  	WARN_ON_ONCE(ret);
> @@ -1288,9 +1291,30 @@ int tdx_module_shutdown(void)
>  	 * module can produce and most likely supported by newer modules.
>  	 */
>  	args.rcx = handoff.module_hv;
> -	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
> -	if (ret)
> -		return ret;
> +
> +	/*
> +	 * This flag tells the TDX module to reject shutdown if it races
> +	 * with a "sensitive" ongoing operation. That eliminates exposure
> +	 * to a TDX erratum which can corrupt TDX guest states.
> +	 *
> +	 * This flag is not supported by all TDX modules and may cause
> +	 * the shutdown (and subsequent update procedure) to fail.
> +	 */
> +	args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
> +
> +	err = seamcall(TDH_SYS_SHUTDOWN, &args);
> +
> +	/*
> +	 * The shutdown ran into a "sensitive" ongoing operation. Signal
> +	 * to userspace that it can retry.
> +	 */
> +	if ((err & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
> +		return -EBUSY;
> +
> +	if (err) {
> +		seamcall_err(TDH_SYS_SHUTDOWN, err, &args);
> +		return -EIO;
> +	}

This function is pretty tidy. More or less:

 	ret = get_tdx_sys_info_handoff(&handoff);
	if (ret)
		return

	args.foo = handoff.bar;
	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
	if (ret)
		return

	memset(&tdx_module_state, 0, sizeof(tdx_module_state));
	for_each_possible_cpu(cpu)
		per_cpu(tdx_lp_initialized, cpu) = false;

The logic's not bad, right? Get the handoff data, hand it off to
something, then go set some fields.

Then what does this patch do? It goes and globs a just huge blob of
TDH_SYS_SHUTDOWN errata handling and implementation details right smack
in the middle. Our tidy little function is no more.

I really with this would trigger folks' gag reflexes. It's *SO* easy to
fix. It's *so* easy to keep the code tidy and hide the dead bodies so
that the logic can still be followed.

I'm probably going to drop this for now.
