Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986000;
	b=P6RxdEcU9k2vQpPNxn7zgHtVe9IL7XQDj7LgOIvIJcHKa0WPiLj6UmylmzzEH3gDLzKk
	 9FsH1s5ndhSPhmezkRfxpQLHHL/DcEqEPZajxxWNVWfdbHYNPUJfPws/MFQgAY9raCzbT
	 0F1dA0DF6gpC9ElA5+NVVhZnPT0LbCB83lm2SPgtUfg/UF3SDiw4B2V+0vSOp0Uz0z551
	 D7KiM8xXeB1v7KdTXdnKX8wRzL77QMbaag10Q8LQafP9iEcdcp7jARe43L4nP7R2dCQBY
	 bqMkP/jVmtqBWaRO4z7gJtSaJLNygO0HZtxYQSXyNbAoDtc46Q8s0Rmtk4b6C/6zjWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986000;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8pB+MXPNtH9n1jK/JmpiYpmW0motvJ1fOUd08yC+k48=;
	b=uclhIFmQBCPUT4930q7vAfZnJSIoq+hbV0TaZSKrVGQB4OmRxelbx7ehINVycFn0Fcty
	 GD3ERz/MeldUOaq6DqT5f6BKQ/edDAQiy5Gfq6ZVneBG1Xwll3C0COj8v02NOIcen6JEu
	 CnASUzyn+4eu9y/kcNBUFqLCw7Pa0SFiRfxQ/ycnRmyJx2XkYyhc5ukpwPeqLPnB+qEVv
	 a22eXHlB8XiwxD7EGZ2f7KkS+8C4nFgx+1e+vILbh6fXoEX+O4HJVdVboOltzG1mi8A1/
	 FavKCZGMfFFrwVtXOfxYUcDeUnMvbZpwDVhkIQljbj26tkpDbFVQ3fg4oc2lNhsygLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLzpbgMd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=i7OvvaGZ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC0606A31C;
	Wed, 18 Nov 2026 07:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DDC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLzpbgMd;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=i7OvvaGZ
Date: Wed, 18 Nov 2026 08:13:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794985997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8pB+MXPNtH9n1jK/JmpiYpmW0motvJ1fOUd08yC+k48=;
	b=wLzpbgMdmN1snhABK51fJE0hhG87MbcpKkOXh8RBHFftRMW2bTofPHTFD4FNmaEpkOG84N
	tOyICaCBvc+wl88K1KiwhCyg9W4NOpxL81mmWTnYhJOExB8rWr7Dvv4nOTpLc5JspN9xaq
	0UTXkvQ+VT3PgET8DALpawp+ef/JQ4YuJZQK8sNXJAd+Z+qjL4B2Um6pWU3gg7q6CAFOOw
	A6eo+E4PXAjgTbmsh5Hr1EitsrL13B1q6aSfTQ5pINc36L8qfSGIOCUj31MbKrh271VGdn
	bgRi2Cu907bpMvs6yZt+7Om5P/Dytc/UCbmsWFLsllwI2TsN+rmxa7cBq7xZhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794985997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8pB+MXPNtH9n1jK/JmpiYpmW0motvJ1fOUd08yC+k48=;
	b=i7OvvaGZhMMfJFYOaboeajhrsvueAErjBNBKv+3b9msb0fwcQnWLXZ2yUaOa1lHyP9M3/I
	8Jr+H67IMA0LulAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Koichiro Den <den@valinux.co.jp>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] RISC-V: KVM: Run vCPU timer callbacks in hardirq context
 on RT
Message-ID: <20261118071314.NJWhnli-@linutronix.de>
References: <20261118062104.2912910-1-den@valinux.co.jp>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118062104.2912910-1-den@valinux.co.jp>

On 2026-11-18 15:21:04 [+0900], Koichiro Den wrote:
> On hosts with Sstc, kvm_arch_vcpu_load() cancels the vCPU wakeup hrtimer
> with preemption disabled, including when called from sched-in preemption
> notifier. The vCPU reset path also cancels the timer under get_cpu(),
> with or without Sstc.
> 
> On PREEMPT_RT, these callbacks run in softirq thread context, so
> hrtimer_cancel() may sleep waiting for a running callback, which is
> invalid with preemption disabled.
> 
> Let the callbacks run in hardirq context on -RT. They only rearm the
> timer, update interrupt state under a raw spinlock, and kick the vCPU.
> Similar to commit 9090825fa997 ("KVM: arm/arm64: Let the timer expire in
> hardirq context on RT").
> 
> Cc: stable@vger.kernel.org
> Fixes: 3e1d86569c21 ("RISC-V: KVM: Add SBI HSM extension in KVM")
> Fixes: 8f5cb44b1bae ("RISC-V: KVM: Support sstc extension")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
