Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186262;
	b=ozo9Dgroq06vzRkojNysjItnpogiyMfCUGSlZH69QSsvmXqROLYLjCqLuKAVZyG8IFs0
	 ay6xNubGmDRtgblg8NwmKaySpv25cMXCuolAEqbbG0ncFp+MkreZgmDqQPWjCQySLMCtO
	 VwFGKSd2z9crlxRYn9NVOIse7aAnGSioFx7I5648lT/Bz+qQIQBNlsm+fgbEbLS5Fp4qe
	 xfc3gpxEMlQGnMzqUUW7cHHM+6NqB9WTGKNkM7C+YKJ1enVnftYJltZfsxZCBsCFgDhH3
	 lGAu2InT/vUgwKZCUPSdXtyO4z+DWLsaS7gB08ghOYRFhXbqBf1C/a3vZvz8cJXpfbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186262;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=crX5XS3FGZcYAh9eQKuEJE7vepq3CD0BrqYx20wEGlM=;
	b=FQbIU4fJwOHj54qdEvNEwwBPEH+ygTkt95SpxoQtgkEf3RuFStxQZZUu1PkZdOe74vn8
	 1MVakIsWMCY3Q3+hsY723lz48RIooCHM5U5ZMUn7545tBGsCKIhsknI2wPiEyXcHZiliD
	 x2H4MW33aIq66Tmp388twW2xGgLqWo/GNZskwOkE86EykghNPOXxzWzl5EgwmouYG1eq4
	 xqr+ZfuAFYLHcugB0z9LKfWYooYu4BxzfuN3dAWZuKc21F5WpQQxUU2QogmuuNSiyNxj8
	 NcG6TLkMcfsL7A6o2ECeUCBpzeam/E7PJLKyOAw1ykOu8UZJFz7ZXryjtAkV31y0SqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v3Tlu4qd;
	arc=none smtp.remote-ip=95.215.58.43
Received: from mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A9606A337
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 453A9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v3Tlu4qd
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CeSDvXB1FvcvX/1ttzO8WrGAbCq21rBYr7QIfpWmWiA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795186259; v=1; x=1795791059;
 b=v3Tlu4qdreQSXtgCqm7CW4AlGJeIr7iq1VCMSuILIFZvi8nJXezMBiBKtV5vkiKVKYxkH/vu
 JDVkql0nzeN87jPDiHi7QgTDQ/Xllhjjhu3tYhFogoSWW39hm082eojPjmAKKk+HFzrq/r6AzVE
 dJSMfAyxIk25Z2PhB9QjPwqM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2a1e500c4fd2258e;
	Fri, 20 Nov 2026 14:50:59 +0000
X-Mizu-Trace-ID: 2a1e500c4fd2258e
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 15:50:28 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2] riscv: sbi: Fix timer delay
 measurement race
Message-ID: <awBeIov4bo7vKhz3@orel>
References: <20261026033738.96294-1-qingwei.hu@bytedance.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026033738.96294-1-qingwei.hu@bytedance.com>

On Mon, Oct 26, 2026 at 11:37:38AM +0800, Qingwei Hu wrote:
> The timer test samples the counter before checking timer_works in the
> wait loop. If the timer interrupt arrives between these operations, the
> handler sets timer_works and the loop exits with a timestamp taken before
> the interrupt. That timestamp can precede the deadline, causing a false
> "timer delay honored" failure in both the normal and masked IRQ tests.
> 
> Check timer_works first in the wait loop and sample the counter again
> after the loop exits. Use this timestamp to calculate the elapsed time
> so that an interrupt cannot cause the test to use a stale timestamp.
> 
> Fixes: 14fa12b1351c ("riscv: sbi: Add test for timer extension")
> Suggested-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
> Changes in v2:
> - Check timer_works first and sample the counter after the wait loop,
>   as suggested by Andrew Jones.
> - Drop the timestamp field and counter read from the interrupt handler.
> 
> Testing:
> - Cross-built riscv/sbi.flat and built it natively on a RISC-V host.
> - Ran the SBI tests with KVM five times each with 1 and 32 vCPUs.
>   All runs passed, with 15 tests skipped per run. Both timer delay
>   checks passed in all runs.
> 
>  riscv/sbi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/riscv/sbi.c b/riscv/sbi.c
> index 3b8aadce..5633b1f9 100644
> --- a/riscv/sbi.c
> +++ b/riscv/sbi.c
> @@ -292,8 +292,9 @@ static void timer_check_set_timer(bool mask_timer_irq)
>  	if (ret.error)
>  		report_info("set timer%s failed with %ld\n", mask_test_str, ret.error);
>  
> -	while ((end = timer_get_cycles()) <= (begin + d + margin) && !timer_info.timer_works)
> +	while (!timer_info.timer_works && timer_get_cycles() <= begin + d + margin)
>  		cpu_relax();
> +	end = timer_get_cycles();
>  
>  	report(timer_info.timer_works, "timer interrupt received%s", mask_test_str);
>  	report(timer_info.timer_irq_set, "pending timer interrupt bit set in irq handler%s", mask_test_str);
> -- 
> 2.39.5
>

Queued. https://gitlab.com/jones-drew/kvm-unit-tests/-/commits/riscv/queue

Thanks,
drew 
