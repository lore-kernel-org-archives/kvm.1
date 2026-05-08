Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510F2494D8;
	Fri,  8 May 2026 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233305; cv=none; b=GpLMiB36wDxFXdYiTead+JhZXX6rErC28CmxIuRaLRf39Feu9RgNBwMc3+jfXYDC7qH2fVaKvF7+9Q7uD5ss+SXvlWzSVKOIATaopAM4VUhKWQs+geWMYlAo3WjjoFCoNm15gUqp1oT14BAIAfYuXkinFtLDKe7LyzcYYM7niR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233305; c=relaxed/simple;
	bh=Y0/S2QKRNXbd6S9RrTD+zzcjbPgAHkjs4ZOzPZLxvtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agO+KPgIL92Hx2OiVXeT+OOs2czUO5k8FRhUYrB+8fFgDQKQ5uRp21ptpdUnWkS0a5s4MzGOBqbrUMteMzFdIQGxw5ODlRR3iLWcVkojrQY7dHHdEYCD/gWWrR3ITCH7QfBIkmj5N6HfyGOFTqsoqx+MJYA471hdL9HbbhgvjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkzyIZrW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkzyIZrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778233304; x=1809769304;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y0/S2QKRNXbd6S9RrTD+zzcjbPgAHkjs4ZOzPZLxvtI=;
  b=RkzyIZrWaILchwhbaWfbzlVfbnDa5lYVtTY3aBAQri5UmPNyc0aw59AT
   rEKcJjTZgPb3A103S/IGeG/JzgIaDexsMBTKhR/q8Mr+/bA6p434QcKov
   Oj98ikb2sEkM6OJVmbU5+1mStxTNpZpRFHjfz9ZXornq47qDqoDDgIiUP
   +jsmc1c2msZN6JIiccqQRZPxH/iv3yPOvXHQ9rm6MiPmXAYZnjRPpgGTB
   cBeX4MFEQXoPHMhkoR7HU3SpyOPspsR22GLp3ucVDQMippKv6sGnHClqm
   ux7NNSA/6eS7JfRRk7qAzWC4iYwuJPNW6/dFcVS7yet7Xk70AyvEP0dIg
   Q==;
X-CSE-ConnectionGUID: Gs3aUIZ6T7qSYghMLTuANw==
X-CSE-MsgGUID: yv5wYncQRJusE8NF3LRTHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89507602"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="89507602"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:41:43 -0700
X-CSE-ConnectionGUID: hdWUskmDQOSdkikhSugg1g==
X-CSE-MsgGUID: e5Y8EzdhQhqp8xtOOtIugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="233665459"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:41:40 -0700
Message-ID: <0f36788b-27da-40e8-8ecc-beb6a7101c69@linux.intel.com>
Date: Fri, 8 May 2026 17:41:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/2026 5:18 PM, Peter Zijlstra wrote:
> 
> Move the VMX interrupt dispatch magic into the x86 core code. This
> isolates KVM from the FRED/IDT decisions and reduces the amount of
> EXPORT_SYMBOL_FOR_KVM().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linxu.intel.com>

One typo below.

[...]

> +
> +	/*
> +	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
> +	 * The FRED NMI context is significantly different and will not work
> +	 * right (speficially FRED fixed the NMI recursion issue).

speficially -> specifically

> +	 */
> +	idt_entry_from_kvm(vector);
> +}
