Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E762E2850;
	Mon, 15 Jun 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515850; cv=none; b=r2cPJ5Tvi3sdH1lz7Ba9ff9m0WsaeZpXxDd8nA21jcidGdK4W6JQhMvyT82yb9V1r9wZySFXQfOBpMAwvsj38DPJlnHIcpzj6erzMtZ92NyUFSkyAP5Aija4HJTbCCUg8mrCS66C5R1si61YqYRXVOILYPVbHZy1SS+TyR3HJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515850; c=relaxed/simple;
	bh=OQrkVJpxqhRwuoEC3x5q9DMnLv68oHP6Cl8y/lThgx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrDuBUzgWV/3aLh3NsHO/Dh16bw0uLSGpMTfYoDC3VEzdiLfbh+YMUjoMyfZFrgB/d97nmn4cZzXXzqLVNTcN2l5KL3odLpUTLANZQLq/Ldr1pLp3qWMKUj0+hF+TWad28M2mfY8XzNLSjMD4VZa6jNCEDbe1fCHHdNgbYwdvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfnCtgYj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfnCtgYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781515848; x=1813051848;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OQrkVJpxqhRwuoEC3x5q9DMnLv68oHP6Cl8y/lThgx0=;
  b=IfnCtgYjLdalZrGoUX8IN2rk3dHt6KgQoi0wFB9oR/+hdh7iorcXzRmI
   Y/HEYdDHnvtn20McUMqyLF5hhVKU4Vw6TT+Rc6oF8UfrxHmQGgNp374Se
   h2vstgq5X6p0BHgaMh0YWLWUA1mtWdAUOMRi22/NtjIAQDJOc8f1tbzCh
   5YqfLCTjqXEPeT/GUqctM+Ouef/FqE8skw+7O+mM3hAML1UmGOCGj5stp
   uk8lK6WDnZymd0+P3iwQAg4wTfPzI95Jbtjmm9yyzIR9HyhYbT4LfnSpd
   8SJ/GEsGlgsbSVDi3wxBOGQCxnsCPICk3UjDfxi2NaUkXBWSiBAE5Cg9M
   Q==;
X-CSE-ConnectionGUID: cFWXRfpBS0Ou8jU88KevHw==
X-CSE-MsgGUID: HJzGXr2qRuCj3VEctaGi2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82235799"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82235799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 02:30:45 -0700
X-CSE-ConnectionGUID: cH63mxeXS3CCVmx9VXHnEQ==
X-CSE-MsgGUID: nsKRERBYRn+fXWHdbpqgyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="247464937"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 02:30:39 -0700
Message-ID: <ead7d7fd-aa4e-4c18-b399-90fb448e0af6@linux.intel.com>
Date: Mon, 15 Jun 2026 17:30:36 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/30] KVM: x86: Move the bulk of MSR specific code
 from x86.c to msrs.{c,h}
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-15-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-15-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Introduce msrs.{c,h}, and move the vast majority of MSR specific code out
> of x86.{c,h}.  Use a plural "msrs" instead of just "msr" to be consistent
> with regs.{c,h}, and to make it easier to differentiate KVM's code from the
> other 5+ msr.c files in the kernel.
> 
> Opportunistically drop the "x86.h" include from mtrr.c, mostly as proof
> that the bulk of the MSR code is indeed being relocated to msrs.c.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

One nit below.

[...]> diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
> new file mode 100644
> index 000000000000..25b75fe39b80
> --- /dev/null
> +++ b/arch/x86/kvm/msrs.h
> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_X86_KVM_MSR_H
> +#define ARCH_X86_KVM_MSR_H

To align with the file name,
ARCH_X86_KVM_MSR_H -> ARCH_X86_KVM_MSRS_H ?


