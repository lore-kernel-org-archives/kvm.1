Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722D3E00A0;
	Mon, 18 May 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089625; cv=none; b=XGGMXLALzY2rcG+I9PZOy7pduLoLXPkNl6gFNx4UsNtKYOMuXOdBoyPpWlSwULL7HImEXfZq/GG3ecmru/oZVvtoGZ10Zx62Dd8/BZ40HjJEEyZpUCet0d1xmYyqZV1GUdoRk3Qf+57H9jjpgCqZqdxxhlnt1vhYulZ8nACmmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089625; c=relaxed/simple;
	bh=wYq775yLb9VjVlL17ft08A6Ah9AQkPUbBBu1w57j9Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=turt5LaHglHwV94tiqvc/w5JwGhB9iyBTl1QkYeWM18nIgUBQetTRYpfsg30p/Aiu7b6TQ5zXJCbSGSS6X3x17sCDZSSEnz7ow+TRAUgjzr6BT/7JcMuKNhFq7fdhr9WJIyMRosO9pbNS0/MGNNKHuNqGXYd2R4Xh68uh1ZEDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jwgkb5OK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jwgkb5OK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089625; x=1810625625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wYq775yLb9VjVlL17ft08A6Ah9AQkPUbBBu1w57j9Fw=;
  b=Jwgkb5OKG95S0PdUt2jM03W5Fr3eYDpUhEUQXdkkRE9++rOZ7/8K9Giy
   xmm6GyiE3IhFlIP5w0aqyrpqf2tBbzLIS+Ze7kHaSPREPTtkwuGtg48Is
   LSggsK0KrbJ76fPDQwW0a2CtoyzY9L7c0Kyli4OrN8F9LSQhVZElv5mzR
   u6FHbAJgP5dFv7DN81aXsBx1EumL3xSn0tm8R79+O0zwigZukkJZhpTOc
   jfXPKPDFwyvsHPtDxIaTrJm/YTeJ4Ph7rgENgtd6wkua7+757sqzrJ9BY
   wOxVMaV0cB7yblSk444VHI1KhRmSgPN2h/uGDHmXg+jkZMjkML0YYMB4f
   Q==;
X-CSE-ConnectionGUID: Pd4Y4vthTdu48TInO0Jfpg==
X-CSE-MsgGUID: QadETROcQG+wAtHpchtWQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="90633308"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="90633308"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:33:44 -0700
X-CSE-ConnectionGUID: nqhrYB8JRjepi+1FykYLNQ==
X-CSE-MsgGUID: IPdMvKrXT/S60DhIEV8Wmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244334472"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.39])
  by orviesa005.jf.intel.com with ESMTP; 18 May 2026 00:33:41 -0700
Date: Mon, 18 May 2026 16:01:27 +0800
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
Subject: Re: [PATCH 2/2] x86/kvm/vmx: Fix VMX vs hrtimer_rearm_deferred()
Message-ID: <agrHV5UnMLFDIto9@intel.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.957351833@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423155936.957351833@infradead.org>

On Thu, Apr 23, 2026 at 05:56:13PM +0200, Peter Zijlstra wrote:
> Date: Thu, 23 Apr 2026 17:56:13 +0200
> From: Peter Zijlstra <peterz@infradead.org>
> Subject: [PATCH 2/2] x86/kvm/vmx: Fix VMX vs hrtimer_rearm_deferred()
> 
> Vishal reported that KVM unit test 'x2apic' started failing after commit
> 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming").
> 
> The reason is that KVM/VMX is injecting interrupts while it has IRQs disabled,
> for a context that will enable IRQs, this means that regs->flags.X86_EFLAGS_IF
> == 0 and the irqentry_exit() will not DTRT.
> 
> Notably, irqentry_exit() must not call hrtimer_rearm_deferred() when the return
> context does not have IF set, because this will cause problems vs NMIs.
> 
> Therefore, fix up the state after the injection.
> 
> Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
> Reported-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> Closes: https://lore.kernel.org/r/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel%40intel.com
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> ---
>  arch/x86/entry/common.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)

I also found this issue for a normal VM on DMR (with 192 vCPUs). As the
previous threads analysised, this issue is not platform-specific, nor is
it specific to TD.

I applied this series and confirmed this could resolve the hard lockup
in my case, so,

Tested-by: Zhao Liu <zhao1.liu@intel.com>

