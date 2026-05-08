Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C8352F87;
	Fri,  8 May 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230455; cv=none; b=FpJkdxaPCvCv3afe72sQoaYdotrrG0wc3DgzkV8oGTvn4y5ydq4Ici8eyllIGH+AFDQ5N0vrgZJMBolMUsNkTSa3ZBOuOd6KCIcmKdQklHsATN//Gbv5ASdSBZ68pL7jRwLBtY/iJi0ANi/Xj+UlCDL5s7qaNRJ91LRihxDIni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230455; c=relaxed/simple;
	bh=XuLSlAzdMonX2OAPWYfKox6CCjm/Fa1zF9/Q3B9RcsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePL9cce5Fo0pQ/r1LAjkMz9sOPDJZIDyXJw60qqoAA2dVg2GnCCzOS/47tm0gxIJkGiprwDvEugwKK4ClJBhpcZ+AxLUoci1Ve4+2LTv79OPGW8+m5f/V9JQuaNkUwU8Qy8+Pm8o5rNSxFyPowWUF3k3zNvz8yfOVngvQVA5fQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G14ozyGi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G14ozyGi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0f9X78B7n8+V0op/rx07At4RvvELkEEqdKc95I/qhF0=; b=G14ozyGiHM3ZPaaVOYWmT+eM7C
	Lb5Y92cu+tAhHhgXD20YDdEAHCthrSnty+bXj0RZ+D2hRIj/mYaAUzfWzXWPdx905Ue63XZLurzp8
	Yw/gAh7K6JzGv7v7UURVHH/Dd3JLAsE+68DCP2K4ZZhv0W1vQSBnQ4Mv3F2v7+a56itcsmwI9AJFR
	8XowRNKKEcifIubt7WcQfpUf/PzI8Az6FmKqaoS6nL/tzndVZhcScIJuU6RHZZ4PU4hl2JrRG2A5X
	/80A3SUhzoJsXMoahuCfOp92MSr26/qA+suOUEDBpYW/ZFxGOatUU79JWIf5ZMU50dfjGoEyQuG8p
	xPgAMM9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGyF-00000003z4P-3t0y;
	Fri, 08 May 2026 08:54:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74B3C301C52; Fri, 08 May 2026 10:54:07 +0200 (CEST)
Date: Fri, 8 May 2026 10:54:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <20260508085407.GN3126523@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
 <af1QSIqNLlADZa0+@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1QSIqNLlADZa0+@yzhao56-desk.sh.intel.com>

On Fri, May 08, 2026 at 10:54:00AM +0800, Yan Zhao wrote:

> So, I added below fix:
> 
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index 0e8fb61f63ff..7bcf1decc034 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -268,6 +268,7 @@ void __init idt_setup_early_pf(void)
>  }
>  #endif
> 
> +#if IS_ENABLED(CONFIG_KVM_INTEL)
>  noinstr void idt_entry_from_kvm(unsigned int vector)
>  {
>         if (vector == NMI_VECTOR)
> @@ -280,6 +281,7 @@ noinstr void idt_entry_from_kvm(unsigned int vector)
>         idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
>         instrumentation_end();
>  }
> +#endif
> 
>  static void __init idt_map_in_cea(void)
>  {

Thanks!
