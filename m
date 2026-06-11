Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575B2BD58A;
	Thu, 11 Jun 2026 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158120; cv=none; b=dRKTiTlCIahA0CLie7gxdYjfFz8ydrDl0C66VuROkOzoi8FPfQgZ0TgaYNEAWCPRSMIrzJ+/RziSzy1dXveJ3CR5NuhTn+rJRlHtuZdIpyBmYRTCXz40xsXvSEEzC9qjZqH+Dd9pUujUbs1s22sqC+yf3TIMUV3JCXJQ6tI/ZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158120; c=relaxed/simple;
	bh=JQ3C2SC9kFSrE9uafrI5dNEr9wDvROrFVkQxkHFR65w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYedydTFM4huLE+hafcmaOV7VoxkKCURQkdpmkmE2G4YKfJtsemRRutZVPV2n1Je/4I1BeXLkKbrPi1vTJwBC23kiT1EKRYtFgZl6xKbrZ6kRrLWkb10i7fGNJ090IXiDvp8uujaIZve6WJWJHhloKAyTqdFso3ARWHFLhdCRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3P0PQAZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PDWstf/C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3P0PQAZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PDWstf/C"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781158116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2N870od5dbjdxJsDLvMUG2Jj7B/cBTMlD10x/Fp9YA=;
	b=U3P0PQAZcOs4DKD8mWRTVpkHZEs0WFNFuoLwloC7pnNcuqgYlw90J28+42/iuYQD2Dkee6
	ziCaCEKYimlTRTF06vVP+ebJU/T7LthjmujbqRF7j9shg6tiROyTKRAtWERJ6tkFHlorNX
	gBPUNWxz2L9By1mODgzY+MTNQxLQXPbTKRDSk+lkKJU2ZMXDG7k/qSS0HeEzJbYcDXuT93
	bAadlqxY0jkuDB+OJzhpaNiMwjrrJ5VxmdFxtOucyvr1JcpOhsHbuC/3DZdNhMiuyukJXc
	lWZBMzCMnp2rd8hpxnSAbUWyDlbl5dBY6mdbtPfk1IPkaHcFB29aaefLU/jzBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781158116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z2N870od5dbjdxJsDLvMUG2Jj7B/cBTMlD10x/Fp9YA=;
	b=PDWstf/CDMJGJqVyGfRsqfzxtCs8JjSX1BNIaweI8CHW4iQ5o458ziY2pDQmMdOQEnYDuX
	7hxO8TvYay6RiPCQ==
To: Charlie Jenkins via B4 Relay
 <devnull+thecharlesjenkins.gmail.com@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Charlie Jenkins
 <thecharlesjenkins@gmail.com>
Subject: Re: [PATCH 03/16] riscv: kgdb: Use generated instruction headers
In-Reply-To: <20260407-riscv_insn_table-v1-3-54b4736a1e77@gmail.com>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-3-54b4736a1e77@gmail.com>
Date: Thu, 11 Jun 2026 08:08:35 +0200
Message-ID: <87pl1xehi4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> +#define riscv_insn_branch(_insn, regs_ptr, _opcode, _pc, _comparison, type)     \
> +	({                                                                      \
> +		unsigned long _ret;                                             \
> +		if ((type)riscv_insn_reg_get_val(                               \
> +			    regs_ptr,                                           \
> +			    riscv_insn_##_insn##_extract_xs1(_opcode))          \
> +			    _comparison(type) riscv_insn_reg_get_val(           \
> +				    regs_ptr,                                   \
> +				    riscv_insn_##_insn##_extract_xs2(_opcode))) \
> +			_ret = riscv_insn_##_insn##_extract_imm(_opcode);       \

Should be
		_ret = _pc + riscv_insn_##_insn##_extract_imm(_opcode);

> +		else                                                            \
> +			_ret = _pc + 4;                                         \
> +		_ret;                                                           \
> +	})
> +
