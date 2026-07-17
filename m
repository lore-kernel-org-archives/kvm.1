Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31E3CBE69;
	Fri, 17 Jul 2026 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271106; cv=none; b=TuUyXrDlQ3IRL6jY9OsyWpb+qXkZB7tCh0BPGi8dCdAti+E79jFm/T7Y4MXpIlV3QMPiumFXqYQnPm0gWaP8r9n6iXlmoQfJ2Brpz58ZNf2MjVeUyDocV1m6z0xP/rNiHqL7WvGtkeKxVJemfwEsr29FlHbECzpNoXjVagADVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271106; c=relaxed/simple;
	bh=00m/MBOwFcpX4kIhUPRM33iT7ghTxs0pXn12lcrkHRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1t/DwnkK1RetRs5AnVyXfVlA85bCkPLAx+pXfjGkukHll9V3eJCgNWWAHTopAtQ6Fh5Fb24smRXlftnqJswEQKsH3gXrY8gAU7GQKxY08/SA0WYOEiv54ycWTfcSIbVbYQLWQLhQFHQ0Q65+Yt5mW9jrhgpMThz9P8NISufecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uRQvpXx+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k/6lWgIS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uRQvpXx+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k/6lWgIS"
Date: Fri, 17 Jul 2026 08:51:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784271098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHloH8eQez70XTBWP+YOYs861I04WwMlKGR/B+8UyX8=;
	b=uRQvpXx+VHdKwA2Zj2s2fbig4bRKStK7eaDY1daStzkR7P22iO9Wv/mOHOYI+rtZw+b8CS
	OzvGBYweVqeYmrgTzjfH/1muSHvA+JyIJ/lMIXJzByR7Rbcdoy+ctwHWbLdaUFoCsStAhK
	/76Jzaflrb91HsjSkPf9dv0Shr5t4ZuPVhDoy4L9w7JhEZRGQOQMPjgtutOeQCOE2Zk9y4
	PyeZhpOUAkFXEUgRc+d4PAlG8u8sKDu6xs7vo0AkhZeejAMtP/kNINsrDxnNxgtRjgu6U+
	OS7k2r+py4/9210hQi+pGc7p/v3ZsuKRiA/QQ+ZorhGk7yJIgkSPo2yX2jiiAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784271098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHloH8eQez70XTBWP+YOYs861I04WwMlKGR/B+8UyX8=;
	b=k/6lWgISwZ5cyfj3K2nN/MhzIKDOdKXhc2tWD6i0TuTGy3ssBlaCDjfo5BfTemhyzIQH/F
	6FbjUnX0tN/c0+BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: yhchen312@gmail.com
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	clrkwllms@kernel.org, rostedt@goodmis.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critical
 section
Message-ID: <20260717065137.FQ5Ax2W-@linutronix.de>
References: <20260716064011.2387501-1-yhchen312@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716064011.2387501-1-yhchen312@gmail.com>

On 2026-07-16 14:40:11 [+0800], yhchen312@gmail.com wrote:
> From: "Yuhang.chen" <yhchen312@gmail.com>
> 
> The VMID update critical section performs an IPI broadcast via
> on_each_cpu_mask() on VMID version rollover, which must not be preempted
> under PREEMPT_RT.

Here you state _why_ it must not be preempted. What would be the worst
that could happen.

>                   Convert vmid_lock to raw_spinlock_t and use plain
That part starting with "Convert" belongs into into a new line.

> raw_spin_lock()/raw_spin_unlock() (interrupts stay enabled, since
> on_each_cpu_mask() requires it).
> 
> Assisted-by: YuanSheng:deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Yuhang.chen <yhchen312@gmail.com>

Sebastian
