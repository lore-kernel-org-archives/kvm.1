Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BF31716B;
	Fri, 22 May 2026 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419924; cv=none; b=dOgTwFCL1LNd5dDVxASixyGokErdT6LvoOIW1gEh8sklmXgAR84Rnc8A5qhz4fjhPvHfQ+60U6bfKk/mBaNXyN/OtH1OOX35JkgaM84FeWuk2qjyi+EqadgV5lGFddMLVx3tDAFLP4DX0ne3RPoNYUGZjKVw+4HwmyDmqT6CceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419924; c=relaxed/simple;
	bh=CEOdbTeRWaHp/ze0TpBYNRD2SqgHFJrjhcgEU3s6UMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVDC+wzKGSKW9aw4BmF7G+kr8Y36IUc0eiwzaCeBqRLtHGXKea1h1PTKXs7v6XcaQcyiBQMtGRYgR9K+5AuFNyx/JLFfRFzC5kmSf64zxscy1eAOF9caXiIkAYr+npSRS+7J/WCiau3VRiF1QXCn0f4Is0jPpUOTQ0xtzeL5/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Sg71yg9qQQ0XEQ--.7414S2;
	Fri, 22 May 2026 11:18:13 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: andrew.jones@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	jiakaiPeanut@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	xujiakai2025@iscas.ac.cn
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend handler
Date: Fri, 22 May 2026 03:18:13 +0000
Message-Id: <20260522031813.3429490-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yirnowpcfq6wqru3jshbbaicqftfj4ef3dcss65jdtuon6nzml@iyv45tnmmfha>
References: <yirnowpcfq6wqru3jshbbaicqftfj4ef3dcss65jdtuon6nzml@iyv45tnmmfha>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Sg71yg9qQQ0XEQ--.7414S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43Jw4rKw1rXw1ruw1Dtrb_yoW8JFy3pr
	Wjkw4xuw43GF1jq3yxJrW2qayjgrWrGa1UWwn5Cr1xXr15Cr1avr4xt3yY9ayIg3srZa42
	vrs0q34rCr4qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiCREPCWoPqqh6nAAAsf

Hi, drew!

Thanks for your review!

> > I'm not a big fan of this approach and I see sashiko found it has gaps[1].

I read sashiko's feedback and I think it makes sense.

> > I'd rather we introduce a mutex to kvm_arch to serialize cross-vcpu
> 
> Eh, not sure why I said 'introduce' here. We can just use kvm->lock.

I looked into that, but it may be not suitable. Here's why:

Documentation/virt/kvm/locking.rst explicitly states: kvm->lock is taken 
outside vcpu->mutex. The susp handler runs inside kvm_arch_vcpu_ioctl_run(), 
which is called from kvm_vcpu_ioctl() where vcpu->mutex is already held.

Taking kvm->lock inside the susp handler would produce: vcpu->mutex → kvm->lock.
So may be we should introduce a mutex to kvm_arch to serialize cross-vcpu
mp-state operations.

What do you think?

> > mp-state operations. So it'd be taken in SUSP, HART_START, and also SRST
> 
> And, even though SRST doesn't really need it - why not... Consistency has
> its merits.
> 
> > (anywhere that reads or modifies another vcpu's mp-state). Operations that
> > only modify the calling vcpu's own state would still only use the per-vcpu
> > mp_state_lock.
> > 
> > [1] https://sashiko.dev/#/patchset/20260521142030.1560861-1-xujiakai2025%40iscas.ac.cn

I agree with you.

Regards,
Jiakai

