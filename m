Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750412;
	b=vPYB83Pu4PdP0wfqzzsZZ1iGeBMJKC8/honztJbzujgoZKC3zoPe++5Rf/Fw9+SotlYn
	 iC61vRJgf5gj9dx/m+uNUMWjxYdxlOfuZ4eaLgmtOAIEP/jMrj8+yMsRMr1JeuTJ5kDzv
	 aJfAAjIua6FWLvtlvAnr/19PdzDa/IKoV3YGgIkynBThMEkMDxVT2o/lyQ9SUq9fG5Tho
	 6up4jwwnZZzods4FxgxxBwdHQtWjq8MnThG1iD83CT89LgESazwE33sM3+GxyJvUSuI7n
	 9WKoeBKT5eRXU/11NZXYiokYfY8s2RlVNWTHkMZE3YiB6HI6bY5WQlfEzrWEh9gs04g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750412;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6DfDp1o9SWa4Xb1iGe8PGA7eQLTGhvN1SanEm1WQEes=;
	b=v5deRgC3utWO2uCjte5Kpvl6WYoAf0cl+YFmHYz2SQkeZMi+C3ULey11POKN7TO+dC2e
	 ln5wI5sgyY8x+6cnVLFPeA4JRInCsqMEKMyD7C1GMHQAPo+m770thDMYL0BDkPR0g0KdG
	 fghhkEv6aplK7GZnTkSRVGuZ6UwtbcpPf+yjfisxye1wtgwEHNkw8FiUgGeDdHF6C9YMR
	 ZlLLKBsAQYs2UnOBwSXKExCwwWmYYDGBGtt3f+DUdEy1gBXd3A5RpVpQZfhY/vooSNhBF
	 MvqzLa2C5uNzcHfj4QSnIeCXxnDF4G0TquAjJAFCcAVvNDG1PtyPILxj/JNT+Hl5Klw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GYV71AqB;
	arc=none smtp.remote-ip=91.218.175.151
Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64595606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 10:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64595606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GYV71AqB
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fKBkHWnt456uHkkOHw4bPYUmVOV4SXwzeUkGlmGDAEA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792750408; v=1; x=1793355208;
 b=GYV71AqB/Uov+xYYdJtXYwYwR+qEXoz1X3SA5LbpBmyjJMaVLU6d60dnOgqGtreT/DIwgNyb
 UwIjrSg1sHHPQDkbT+JGa/GuyCxMVf6ebxyvT602WT1cCQu+BRzU1BNieRjEznr/lg1KxVXTvd0
 19/LBOCw2f0OmlZc93retEjQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 99fbb73a2f9b5088;
	Fri, 23 Oct 2026 10:13:28 +0000
X-Mizu-Trace-ID: 99fbb73a2f9b5088
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 12:13:23 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: Re: [kvm-unit-tests PATCH] riscv: sbi: Fix timer delay measurement
 race
Message-ID: <atsy0DXLV-WNdi-c@orel>
References: <20261023030442.3709880-1-qingwei.hu@bytedance.com>
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
In-Reply-To: <20261023030442.3709880-1-qingwei.hu@bytedance.com>

On Fri, Oct 23, 2026 at 11:04:42AM +0800, Qingwei Hu wrote:
> The timer test samples the counter before checking timer_works in the
> wait loop. If the timer interrupt arrives between these operations, the
> handler sets timer_works and the loop exits with a timestamp taken before
> the interrupt. That timestamp can precede the deadline, causing a false
> "timer delay honored" failure in both the normal and masked IRQ tests.
> 
> Record the counter at the start of timer_irq_handler() and use it to
> calculate the elapsed time. Keep the loop timestamp for timeout detection.
> 
> Fixes: 14fa12b1351c ("riscv: sbi: Add test for timer extension")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
>  riscv/sbi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/riscv/sbi.c b/riscv/sbi.c
> index 3b8aadce..a298228b 100644
> --- a/riscv/sbi.c
> +++ b/riscv/sbi.c
> @@ -245,6 +245,7 @@ struct timer_info {
>  	bool timer_irq_set;
>  	bool timer_irq_cleared;
>  	unsigned long timer_irq_count;
> +	unsigned long irq_cycles;
>  };
>  
>  static struct timer_info timer_info;
> @@ -256,6 +257,7 @@ static bool timer_irq_pending(void)
>  
>  static void timer_irq_handler(struct pt_regs *regs)
>  {
> +	timer_info.irq_cycles = timer_get_cycles();
>  	timer_info.timer_works = true;
>  
>  	if (timer_info.timer_irq_count < ULONG_MAX)
> @@ -304,7 +306,7 @@ static void timer_check_set_timer(bool mask_timer_irq)
>  	}
>  
>  	if (timer_info.timer_works) {
> -		duration = end - begin;
> +		duration = timer_info.irq_cycles - begin;
>  		report(duration >= d && duration <= (d + margin), "timer delay honored%s", mask_test_str);
>  	}
>  
> -- 
> 2.39.5
> 

Hi Qingwei,

Your patch is fine, but I think we could also just change the loop a bit

    while (!timer_info.timer_works && timer_get_cycles() <= begin + d + margin)
        cpu_relax();
    end = timer_get_cycles();

Thanks,
drew
