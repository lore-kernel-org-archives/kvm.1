Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDD10A1E;
	Wed, 28 Jan 2026 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564235; cv=none; b=J5TVWrwlWgCPD56DLOwOsNhX6qsm+wRcygu0v5wylC7snSIO/rITt67eaT+rCGHo1ftz5uayc/QM3wVafZV6okqQR4QstPijpfuNMcNglUQqZKHL6hKpL1ds8oHAA7K0D/54BPTwfYlZT6OkQq1IWG2HUuk5aYEDp1kOlKo5fxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564235; c=relaxed/simple;
	bh=34AuD5O+F3LEo8IGEMwHcslN7PGaxteSKoxStzdmegc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2Ca4HN/ozuW9ZedK5LxlliEwZkMNd1Gv1SzyhqfeO6fLA8poGxGicaL+tY7cU0qb19ZDc2iauxwcDNsU97Yfflt+oQHVEW12tBzE7wWPwOjZIzf3p4xB04hK/jRGGpaUac34Uqoxsx9jn7+HJKOSivg4zNZdedv1gPWVrXmsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCa3kHWe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCa3kHWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769564234; x=1801100234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=34AuD5O+F3LEo8IGEMwHcslN7PGaxteSKoxStzdmegc=;
  b=PCa3kHWels0jPVkUh7/dvJKj7Go1RgEVle0ZHlON4QNPHYPNshUqYiak
   xJEifObFDFHkUF2JS8s6OVSopQOqTgmmzeVu2mqpmGlyoeS+6/+hI2u7O
   B9wycm67oFyFm8QUSUwlb8jwTPqwG7OL2TxO/VM/33U9KQT8I49vNQmib
   JvsQEzvXzs/OveOw+FVvLjzwjkAAAl5dDY6zfx+4J7O43354nGoQfSw6t
   dj2Q4Xac84xQXNtB+2dNYwzJ4ifz1Ss+nrNS/+qVXjpdarTsjMS8FEcZ8
   b2ZMAIawbpz7GMUtAkA6cLop/Xd+6Jibulgc4AblXHH9Z0gw/D4jtJfP8
   w==;
X-CSE-ConnectionGUID: AJfqPDkPQ16BYkjP+lIKpQ==
X-CSE-MsgGUID: C3K4kLGNT0WstUhY5aushg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70675390"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70675390"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 17:37:14 -0800
X-CSE-ConnectionGUID: fv5QIVY8StOqNz7iaIaDAw==
X-CSE-MsgGUID: UBxGB4noTP6YUifB4Jrq9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212677022"
Received: from unknown (HELO [10.238.1.231]) ([10.238.1.231])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 17:37:07 -0800
Message-ID: <f8329aaf-7074-4bcc-b05b-b50a639cc970@linux.intel.com>
Date: Wed, 28 Jan 2026 09:37:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/26] x86/virt/tdx: Move low level SEAMCALL helpers
 out of <asm/tdx.h>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
 ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
 yilun.xu@linux.intel.com, sagis@google.com, vannapurve@google.com,
 paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
 seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
 dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-4-chao.gao@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260123145645.90444-4-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/2026 10:55 PM, Chao Gao wrote:
> From: Kai Huang <kai.huang@intel.com>
> 
> TDX host core code implements three seamcall*() helpers to make SEAMCALL
> to the TDX module.  Currently, they are implemented in <asm/tdx.h> and
> are exposed to other kernel code which includes <asm/tdx.h>.
> 
> However, other than the TDX host core, seamcall*() are not expected to
> be used by other kernel code directly.  For instance, for all SEAMCALLs
> that are used by KVM, the TDX host core exports a wrapper function for
> each of them.
> 
> Move seamcall*() and related code out of <asm/tdx.h> and make them only
> visible to TDX host core.
> 
> Since TDX host core tdx.c is already very heavy, don't put low level
> seamcall*() code there but to a new dedicated "seamcall.h".  Also,
> currently tdx.c has seamcall_prerr*() helpers which additionally print
> error message when calling seamcall*() fails.  Move them to "seamcall.h"
> as well.  In such way all low level SEAMCALL helpers are in a dedicated
> place, which is much more readable.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One question below.

[...]

> diff --git a/arch/x86/virt/vmx/tdx/seamcall.h b/arch/x86/virt/vmx/tdx/seamcall.h
> new file mode 100644
> index 000000000000..0912e03fabfe
> --- /dev/null
> +++ b/arch/x86/virt/vmx/tdx/seamcall.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2025 Intel Corporation */

Should this be updated to 2026?


