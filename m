Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774131F30A4;
	Mon, 25 May 2026 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673121; cv=none; b=j+iUvAwTLuMvV7Ypa/AYkdo9xB0SEOeiaCSm7/1SoqnZUivHShoNmSHzajm4kmlykMTyTPuZJYBekg4k9NldJK0SXXgku1xnaMPsvyTRB2B5ctHHkIsmYIDQSLXixcLrc5WsurTGPYuFKdLPIXzcZVrIV3qOOCPyEv8xT1mr7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673121; c=relaxed/simple;
	bh=J+FBEp0rOQXiOqVIfvuzfQ+pLGwu2QQ/PA+POTgVYqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BTYW318HpMk71H1xtUl987X5qjNM2ncPf1Ph6PZhtSJcDTkizBet/PfqHUTF6KiIDrWS0HyMS2OXciGwwmuRvaPmoCiyGsXNAqQYMKiVpX6PNiNtWLuVhGF3ZMU/muHEYVQ4ryDPapsbvY+PMRqbajMnluMXV8dJ4WlgfLdkq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABHLOMSphNqWbc8Eg--.11616S2;
	Mon, 25 May 2026 09:29:55 +0800 (CST)
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
Date: Mon, 25 May 2026 01:29:54 +0000
Message-Id: <20260525012954.981933-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <y5hmqjrtgeby3amnlfycifpfm2dc3oaj5eebgvdu3tgjjgohvx@kw3a7xpxqrbt>
References: <y5hmqjrtgeby3amnlfycifpfm2dc3oaj5eebgvdu3tgjjgohvx@kw3a7xpxqrbt>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHLOMSphNqWbc8Eg--.11616S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48JrWxWF47Xw4xCw4UArb_yoW8AryUpr
	WaqFnakF47tr4Sk3s2kF1xXryF9w4fZF4UGr98KrWrJ345Ar1xtF4xKa1jya4UuFZ7A3W0
	qFs7trZ8AryUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiCQ8SCWoTokcOowAAss

Hi, drew!

Thanks for your review and patience in discussing this issue with me.

> > > But... before we get too carried away. Unless I'm missing something, this
> > > race really looks too theoretical to justify any change at all. Do you
> > > have a test case in mind that could force it?
> > 
> > Unfortunately, I don't have a reproducer or test case that can reliably
> > trigger this race. 
> > 
> > But as we saw earlier, this is a real bug, and we can tell that just by 
> > analyzing the code.
> > 
> > The real environment is complex and unpredictable, and such races are 
> > possible. Wouldn't it be nice if we found it and fixed it now?
> >
> 
> I assume the scenario we're trying to fix is:
> 
>  HART-x                                                 HART-z
>  ------                                                 ------
>  SUSP()
>    Check HART-y is stopped
>                                                         HART_START(HART-y)
>                                                         HART_STOP()
>    Check HART-z is stopped
>    Determine all HARTs are stopped and exit to userspace

Yes, this is exactly the scenario we discussed earlier.

> 
> Besides the fact that the race seems quite unlikely (only a pathological
> guest would try to force it), userspace can/should still double check that
> all HARTs are stopped before proceeding with its system suspend
> implementation. So, since we would need to introduce a new lock to resolve
> this very unlikely issue, then I'm not 100% convinced we should. I would
> be more willing to fix it if I thought the host was at any risk, but I
> think this is "only" a guest corruption issue. If the guest does wild
> things like this during a system suspend, then it can keep all its pieces.
> I would agree that we should add a comment about this choice, though.

I agree with you. I'll send a v2 that replaces the fix with a comment 
documenting the race and our decision.

Thanks for the thorough review again!

Regards,
Jiakai

