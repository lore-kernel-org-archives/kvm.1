Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669873812CD;
	Mon, 18 May 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090313; cv=none; b=htBXXe4zgppADA2zS5C2Gpw9lS6TgIxluuvai4fCiV8CwYlmHEb+VXuNnvcsAbTi5FDClJe7Uns+0Q3M1QV2MgA0Mz0fhsfuv7xa3IVgkLwogI4NRc4H21tdLDjtyvYtPOPFwjZj/DQJ0NJweZIiH90a0kSB6R+TSUrxmcyvAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090313; c=relaxed/simple;
	bh=Xn7ejV6D166C7lk6TaQZW65H2kSi2PQRjnd2oYtALxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPxCM+MPxQUbCSVoXZ6ffhMJGej0D22kmhJOp508TR7/e/7anM5MSwMI2T/KiN8JWzv5iZqGTaWW7oH8iY5IWav0maQYcyuHaZc3W1ItrVZvonKdR6mD5dweROmCcag2ZX8jqgF4EqLszfoehO+3b7rYRK0pVixH9AFPj4inrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhINqGOc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhINqGOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779090310; x=1810626310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xn7ejV6D166C7lk6TaQZW65H2kSi2PQRjnd2oYtALxQ=;
  b=VhINqGOcgkyCN0stc9q51nWlIJOi6ZPr9yY8iwfbCGuMnLwODsZChIeH
   hUMPpoOUUzIYh130Ww8knKs39ElVrCjiXo4fNtsxdwbK8Qw/8XWrUkDjJ
   5cR31WzIIlj6BAdi05NOUdAkkl3YIFnd25LNu1D03TxE/P0mYg6yD71yA
   u1BwpQG6u5KZUGp6I6VQxDk02O4kebHGDayJb8obgMQE99lv+mR4oUvaE
   MOtqtv3XMwqVnZqbyiSDkd/DQfImQSaO6XTctf8CpgJEadiTsPoDd3bOs
   /o0pmkuc8YNkjy9kGXgxO/OhlNbRLB4dmtiZjzNiPpIZwCmoL1KdYpgSA
   Q==;
X-CSE-ConnectionGUID: RdnR/ykgTG+jB+KWJM4Jlg==
X-CSE-MsgGUID: yT0VYKs4QUejZy2R/15R8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79967653"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79967653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:45:10 -0700
X-CSE-ConnectionGUID: Cw4W9WHtTretkoiXa1M0Iw==
X-CSE-MsgGUID: yMy/BdNcQCOFy1Qm9hdTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="236716659"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by fmviesa008.fm.intel.com with ESMTP; 18 May 2026 00:45:07 -0700
Date: Mon, 18 May 2026 16:12:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <agrKBk64pCMhzx6+@intel.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508091829.GO3126523@noisy.programming.kicks-ass.net>

On Fri, May 08, 2026 at 11:18:29AM +0200, Peter Zijlstra wrote:
> Date: Fri, 8 May 2026 11:18:29 +0200
> From: Peter Zijlstra <peterz@infradead.org>
> Subject: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
>  x86 core
> 
> 
> Move the VMX interrupt dispatch magic into the x86 core code. This
> isolates KVM from the FRED/IDT decisions and reduces the amount of
> EXPORT_SYMBOL_FOR_KVM().
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> ---
> Changes since v2:
>  - one more IS_ENABLED(CONFIG_KVM_INTEL) (Yan Zhao)
>  - fixed idt_do_interrupt_irqoff() prototype (Binbin Wu)

My Guest is running well and there's no interrupt error in system, so,

Tested-by: Zhao Liu <zhao1.liu@intel.com>

