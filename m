Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBC378D82;
	Fri,  8 May 2026 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220564; cv=none; b=Hm6EW/l9iOB+6g2yc4EohMkOOzhm7DOkKDPBnMrEOM4EvqhxE8AffnIOpHUdQx7J4KN/nFu0eMmX2S5frWdBSi9OLq/VJZhcRH03aA5QOICeiYNs5OwS61iVixb/emWfAKl3jDIL65hE5HRnQhJpzbbbOSiXxP9JNuxWOWq8Jzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220564; c=relaxed/simple;
	bh=xEYhGI9JnV6IR942qczHUrjNEovpYYbfD7A/lDVWKf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mt/xHr+TDlkyGQFb2EZdwICHHGdinThArjgJIfRspIePXzKQ6Fr1yizoXdotnnWML6cmoXOmYnSLlg2BoM/+7xh2pXJsuNIyzzNI9IoIFfdYM09yXlY+MH1olbh3+7vwl18BCufIrVySq6WAYGuUZX9k1BYtbjuslfzbQ4eZgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YR4xTIh0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR4xTIh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778220558; x=1809756558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xEYhGI9JnV6IR942qczHUrjNEovpYYbfD7A/lDVWKf0=;
  b=YR4xTIh0H5o3wWF5FNbDjPxNuqi1HzrJ2NnUYoWTDoDcDdtVHbugdUnH
   9HoMpAZ/2pBtPkuzKWKWjaPRBFzFnIatxMCGO/5t0sOmSx3K1/HHg1Spx
   EZc8z3ynPY69Ijxn6sRSkycVWtyNPTzRwLIFgpuJxzFQGVpIvxXuFnlca
   n6zOcc4376tnqIKN18KLpSBbV6t7156KoHnu/bn2FeV+Z+kFRA8+OGYFz
   DtTSJmncyFq+FevU3s2SmtcHOK40JnWVTztboMrp3fyBa/dvZjOTDso9N
   c/WjhDVp58h4yC1VmLq0FTPwT75Cs+zTc0DYHGYeUggE7z8imUHuYZSdi
   g==;
X-CSE-ConnectionGUID: 0szZOH6/SruTzPgjMnEAZw==
X-CSE-MsgGUID: HgNse5S3R3iBE+lh4VfVbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="66710707"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="66710707"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:09:14 -0700
X-CSE-ConnectionGUID: CXCcUbDuSR+BxdDhTMSZ8Q==
X-CSE-MsgGUID: pgMWt5ENT+GKGqnacY/rPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236795235"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:09:12 -0700
Message-ID: <719c6275-c4b9-49f1-877e-05dd079b984e@linux.intel.com>
Date: Fri, 8 May 2026 14:09:09 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
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
 <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/2026 4:37 AM, Peter Zijlstra wrote:
[...]

> --- /dev/null
> +++ b/arch/x86/entry/common.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/entry-common.h>
> +#include <linux/kvm_types.h>
> +#include <asm/fred.h>
> +#include <asm/desc.h>
> +
> +#if IS_ENABLED(CONFIG_KVM_INTEL)
> +/*
> + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledged by hardware as
> + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
> + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
> + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
> + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
> + * the VM-Exit is held pending until it's unblocked in the host.
> + */
> +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
> +{
> +	if (event_type == EVENT_TYPE_EXTINT) {
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * Use FRED dispatch, even when running IDT. The dispatch
> +		 * tables are kept in sync between FRED and IDT, and the FRED
> +		 * dispatch works well with CFI.
> +		 */
> +		fred_entry_from_kvm(event_type, vector);
> +#else
> +		idt_entry_from_kvm(vector);
> +#endif
> +		return;
> +	}
> +
> +	WARN_ON_ONCE(event_type != EVENT_TYPE_NMI);

Not sure if it's OK to use WARN_ON_ONCE() here.
If the warning is triggered, it could unblock NMI due to handling of #UD.

> +
> +#ifdef CONFIG_X86_64
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		return fred_entry_from_kvm(event_type, vector);
> +#endif
> +
> +	/*
> +	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
> +	 * The FRED NMI context is significantly different and will not work
> +	 * right (speficially FRED fixed the NMI recursion issue).
> +	 */
> +	idt_entry_from_kvm(vector);
> +}
> +EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
> +#endif

[...]


> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -438,6 +438,10 @@ extern void idt_setup_traps(void);
>  extern void idt_setup_apic_and_irq_gates(void);
>  extern bool idt_is_f00f_address(unsigned long address);
>  
> +extern void idt_do_interrupt_irqoff(unsigned int vector);

In idt_entry_from_kvm() below, gate_offset() returns 'unsigned long', but here
it uses 'unsigned int'. It's not safe since there is no guarantee that the
address is within 32 bits for x86_64.

Also, the argument is not a vector.

[...]
> +noinstr void idt_entry_from_kvm(unsigned int vector)
> +{
> +	if (vector == NMI_VECTOR)
> +		return idt_do_nmi_irqoff();
> +
> +	/*
> +	 * Only the NMI path requires noinstr.
> +	 */
> +	instrumentation_begin();
> +	idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
> +	instrumentation_end();
> +}
> +


