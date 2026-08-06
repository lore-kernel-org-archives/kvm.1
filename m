Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3241531C8;
	Thu,  6 Aug 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027519; cv=none; b=o+UTYzLxYQOmQQGb742vioOAoOYD3IF6M939smyaZue5jK8aCi44nuOTRPMgU1ztGqteq9ipAeTziv3iJrRkXrQHofEmDgCLQrcZ+QIEzxt0zb9njuiIulv/SO0OPlOY/f7qg37B4ohro6Z9x3RGMZJzmhv5fJ6JYrDucd1jRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027519; c=relaxed/simple;
	bh=R30TNOC/IYlFsv7vRAcWwHErnTx3wp+w7QwcRJIxOaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNVotQvVnpR3Bf35bHSQA6qsjtded5XeXf/FVOoG+d+zQd4F+fpqdncPY3NZG4fOO1anStSUu9FBUiPk8DcqQcdPskQXDE7SZRC2etuHeAVhdn22myhlTbaN0/j5UFy6DusoJVAzRV9soQkHIRS5aDf+LlUJ5tXsodY2cEnz/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvnHQqf3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AcpzuNgt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvnHQqf3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AcpzuNgt"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786027515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4IJ9dPDD7ujYacDqxd6wmTgSCWh3iQS9y0EGvh2GbM=;
	b=vvnHQqf3CT+6tyZkkqRjo305rMXFVOTYizwgBBjon871om9RhAeTKor7f16ybGiZ+IBB18
	j//jk43lis2FapI6XrbVQiTUneINt+CSUdeWA79iRIx7nohBHfl0oXGS3ZeUfF/fBET5t5
	ZV0pNtHwdGa1yUKt0p8occEA4Z7lrFoMVGCCLYUfm8/U+etH/UX6LdIjuPxAaBG5iN4PZi
	/vlQO6/szB68C/PhNXoOkmXve5oReOzuCWNWQYRKKmqkasuj7sSwsOZBt5QYya8PclYhCE
	FGQwlwqC07R0oO8lnDGKRlmnui8EKc7pws+AfZvngZTeRkUuKYTH1QM7pFLcYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786027515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4IJ9dPDD7ujYacDqxd6wmTgSCWh3iQS9y0EGvh2GbM=;
	b=AcpzuNgtrbHDTMJgMUKgJzmAcIDRwIgOVNK+kvTRFlFG7yIbIfSnNmqR4eeucGYkSFmgKw
	05ykDSXTKOFICLBQ==
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
Subject: Re: [PATCH v3 08/17] riscv: Use generated instruction headers for
 misaligned loads/stores
In-Reply-To: <20260707-riscv_insn_table-v3-8-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-8-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 16:45:14 +0200
Message-ID: <87a4qzcnph.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> -static int handle_scalar_misaligned_load(struct pt_regs *regs)
> +static noinline int handle_scalar_misaligned_load(struct pt_regs *regs)

Why noinline? I heard that compilers are usually better than human at
deciding which functions to inline.

> +	if (rd) {
> +		if (!fp)
> +			*(unsigned long *)((unsigned long *)regs + rd) = (val.data_ulong << shift) >> shift;
> +		else if (len == 8)
> +			set_f64_rd(rd, regs, val.data_u64);
> +		else
> +			set_f32_rd(rd, regs, val.data_ulong);

Why if (rd) condition? What if the instruction is loading to f0?

> +		rd = (8 + riscv_insn_c_sh_extract_xs2(insn));

Having to remember when to +8 is error-prone. Does it make more sense to
do the +8 inside riscv_insn_c_sh_extract_xs2() and the likes?

> +	if (rd) {
> +		if (!fp)
> +			val.data_ulong = *(unsigned long *)((unsigned long *)regs + rd);
> +		else if (len == 8)
> +			val.data_u64 = get_f64_rs(rd, regs);
> +		else
> +			val.data_ulong = get_f32_rs(rd, regs);
> +
> +		if (user_mode(regs)) {
> +			if (copy_to_user((u8 __user *)addr, &val, len))
> +				return -1;
> +		} else {
> +			memcpy((u8 *)addr, &val, len);
> +		}
>  	}

Again, why the if (rd) condition? What if it is f0?

Nam
