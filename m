Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD518DB37
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747109; cv=none; b=Xhmbnjtf5qccHCisoU5y7du4NPHm/Fm3NsvVzpp2Ib1C5bh3S/nCI+BkD4Zt+i4zixnDfczUm99ZskYp0bbT2QEKQfL01aYGM6tEmJPoMlcuGO1GX0Vm1gTRoge3r47Ay2jvzMzyC2wMG6xj20+3isPYMJ7J5J+oTbVIMJCF+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747109; c=relaxed/simple;
	bh=sMWfFcv5OvkLRUQERYQzkmwsgeFG2NFF1f1ARRD++vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+w08kw7QVj+NRBZCnKmHI9tm6hJxs1KJErtUy3m1N1xSedNgvXQ7I+zyfg3cE+FmksLKaMv/JqYxPLJYxRx5qkrR6FD2VgcVjmh1jvFADjsyr8qIR/uM9qdNm3snOBKyjbKKLhjw28MwdMJP1n1ciIeHskK+EaAV6HkYqE5p64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gh2TQ5aq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gh2TQ5aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776747107; x=1808283107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sMWfFcv5OvkLRUQERYQzkmwsgeFG2NFF1f1ARRD++vQ=;
  b=Gh2TQ5aqk/KrqW4PmFlS3XUU/HoFjAOr6YEFobxq4Q3NE9Oup3yjbiUC
   pbpwkrtDd8dlYE7NndBle96j7JVEjWc+2wvZlmLZhvrYtBWjPnG7LTuph
   BsEm6KVdcW2KsUlc1A5PB0fUz4c6naMRMpDUMXZKgynkWV+aC08XYhiD6
   +aKSOCJSxl5LiPyQWpdHqHbMg9Zz8MWVBk4zbwLBN6y72jH0NAtXAdJAG
   UY0gEFM/5mkNSAax7WdHmXasclbaJrbF72hdpkztGzY7NiVmDMA412XNI
   lPz+mX9G+3gEeWFrITnU12hGPWZYek3O3mN+9M6UjXbNvuSZAKIbRSS9F
   w==;
X-CSE-ConnectionGUID: 28zoF/O+RaSyYgF+drTGEw==
X-CSE-MsgGUID: k90AbkSdQkqG5F54O6XZFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77545404"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77545404"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 21:51:45 -0700
X-CSE-ConnectionGUID: djdraZ0iQri6EAWQQyhLfQ==
X-CSE-MsgGUID: 7QHraqN2Tl6dnPoEZKCZng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="236905984"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 21:51:43 -0700
Message-ID: <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
Date: Tue, 21 Apr 2026 12:51:41 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Thomas Gleixner <tglx@kernel.org>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Wu, Binbin" <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <87mryxekxy.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/20/2026 11:00 PM, Thomas Gleixner wrote:
> On Thu, Apr 16 2026 at 20:50, Vishal L. Verma wrote:
>> I tried out AI assisted and patch (below) which does happen to solve
>> it, but I'm not familiar in this area, and not sure if this is the
>> right fix.
>>
>> diff --git a/include/linux/entry-virt.h b/include/linux/entry-virt.h
>> index bfa767702d9a..c4856c252412 100644
>> --- a/include/linux/entry-virt.h
>> +++ b/include/linux/entry-virt.h
>> @@ -4,6 +4,7 @@
>>  
>>  #include <linux/static_call_types.h>
>>  #include <linux/resume_user_mode.h>
>> +#include <linux/hrtimer_rearm.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/seccomp.h>
>>  #include <linux/sched.h>
>> @@ -58,6 +59,7 @@ int xfer_to_guest_mode_handle_work(void);
>>  static inline void xfer_to_guest_mode_prepare(void)
>>  {
>>         lockdep_assert_irqs_disabled();
>> +       hrtimer_rearm_deferred();
>>         tick_nohz_user_enter_prepare();
> 
> 
> This code should never be reached with a rearm pending. Something else
> went wrong earlier. So while the patch "works" it papers over the
> underlying problem.

IIUC, the problem might be:

HRTimer -> VMExit:
[IRQ is disabled]
    kvm_x86_call(handle_exit_irqoff)(vcpu)
        vmx_handle_exit_irqoff
            handle_external_interrupt_irqoff
                sysvec_apic_timer_interrupt
                    irqentry_enter
                    ...
                    irqentry_exit
                        irqentry_exit_to_kernel_mode
                            if (!regs_irqs_disabled(regs)) //<-- This is false, hrtimer 
                                hrtimer_rearm_deferred()         rearm is skipped!


This issue is triggered on TDX since TDX can't use preemption timer while normal
VMX VM uses preemption timer by default.


> 
> Can you please do the following:
> 
>     1) Apply the patch below
> 
>     2) Enable function tracing and the hrtimer* trace events
> 
>     3) Enable tracing if it has been disabled already
> 
>        echo 1 >/sys/kernel/tracing/tracing_on
> 
>     4) Run the tests and wait for /sys/kernel/tracing/tracing_on to
>        become 0, which means the problem triggered.
> 
>     5) Retrieve the trace from /sys/kernel/tracing/trace and provide it
>        somewhere to download from or send it to me compressed offlist.
> 
> Thanks,
> 
>         tglx
> ---
> 
> diff --git a/include/linux/entry-virt.h b/include/linux/entry-virt.h
> index bfa767702d9a..ab73963a7496 100644
> --- a/include/linux/entry-virt.h
> +++ b/include/linux/entry-virt.h
> @@ -58,6 +58,10 @@ int xfer_to_guest_mode_handle_work(void);
>  static inline void xfer_to_guest_mode_prepare(void)
>  {
>  	lockdep_assert_irqs_disabled();
> +	if (test_thread_flag(TIF_HRTIMER_REARM)) {
> +		tracing_off();
> +		hrtimer_rearm_deferred();
> +	}
>  	tick_nohz_user_enter_prepare();
>  }
>  
> 

