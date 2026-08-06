Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D53D47BF;
	Thu,  6 Aug 2026 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004597; cv=none; b=GmLIQh/voWMDD3yww8LObt8go+M9XlGQvXyyafFeRovAjWs+7IkW5LX4xgwLvGSFvU0huuJs0Dh08SiM5PqmG/kvqlcWu3lBEyPufT8LqnmOUG2MQxaiU0S3S/+ZioXYE54jJRizXvVTCvEqHuKcJbsfNBwiUfHoJsde7fQxnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004597; c=relaxed/simple;
	bh=LR0lpA9h89VSb0evYK9TzKmvwzjzTitcrbaIcjjOuWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S403jtXP1MC4M4Tj+PBChpXY2Pl4pL8xV45CParU8EBfm6a6yv66y4JbalujW5PuSGime1PXOOEr8qY7kgHd7MmZgELxMG2zpaVHDk1vNJ7CcKBNz3bH6/WGVFoe8x3XSIP0pD8Nib38rDjyj91e1gXPevfPx34yQ+D88p9b8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FYghH40; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKbqMjrj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FYghH40";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKbqMjrj"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786004594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1hzS6FheJp1n77P4UsaZHsQqZI4eItJ8gjMhgc47M8=;
	b=3FYghH40fpnYDZWlmZ5jI+mrrcv4UDui7sPgWAvIGC1R+RhqVEyN+IbSoWLF0eyD98/kOH
	NuidWmexSUOfU4h69r3BwVXpNWdoGqOc8OWkIz0unT68FIEfo2lKjlOlwXoDr7vpARGaQJ
	wL8JFewZjCbNum2G97CR/niKt320DOlzcaMDY0rp3l4nXLywF+D7JXMSbn1ixNGs0XUhCG
	Not+bog+FU4+SX+LM9gS/JBeLX7bZ6sBy3NAjj0wpuFzj+vx/DlHybx3589cWD9Krwbduh
	pHeMfFiM0/fbR/IIqhGD+R3CUFjOEmEXM87fuqAcqCxhcNXeFnyHYhDBiTJsiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786004594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1hzS6FheJp1n77P4UsaZHsQqZI4eItJ8gjMhgc47M8=;
	b=hKbqMjrj7aHywt4MUgZoaZH3RBSlIY18taYCwQo7M8SVh8PvJzopR45pwn3et1EjPw6KUK
	RBnBkYeqRVOBLVAg==
To: Charlie Jenkins <thecharlesjenkins@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?=
 <radim.krcmar@oss.qualcomm.com>,
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Charlie Jenkins
 <thecharlesjenkins@gmail.com>
Subject: Re: [PATCH v3 04/17] riscv: Add kprobes instruction simulation KUnit
In-Reply-To: <20260707-riscv_insn_table-v3-4-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-4-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 10:23:12 +0200
Message-ID: <87ldajd5e7.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> +		} else if (riscv_insn_is_c_jr(i)) {
> +			u32 rs1_index = riscv_insn_c_jr_extract_xs1(i);
> +
> +			simulate_c_jr(i, addr, &regs);
> +
> +			KUNIT_EXPECT_EQ_MSG(test, regs.epc,
> +					    riscv_insn_reg_get_val((unsigned long *)&regs,
> +								   rs1_index),
> +					    "c.jr instruction (0x%x) incorrectly simulated", i);

Should we set a value to rs1, just like everything else?

> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.h b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> index 537f44aa9d3f..7a672de8f130 100644
> --- a/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.h
> @@ -19,6 +19,12 @@ extern void *test_kprobes_addresses[];
>  /* array of functions that return KPROBE_TEST_MAGIC */
>  extern long (*test_kprobes_functions[])(void);
>  
> +void test_kprobes_arbitrary(void);
> +
> +extern unsigned int *test_kprobes_arbitrary_addr;
> +
> +extern unsigned int *test_kprobes_c_bnez_addr1;
> +

Are these declarations used somewhere?

Nam
