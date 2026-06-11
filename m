Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABD2DC350;
	Thu, 11 Jun 2026 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158471; cv=none; b=ktyEAjZtKrt2rqe1Lwleaxs8RD/88RMLzLSgyx7bPf+8Ysykve3q0eVsyQCe1+eTboF9gaOxUDwgPv3a8jvZTPI1p3O2Q8oKEwUjbYhHC04BSva479f1+vK4xUwOx5hG4eF2WNZJMVFWhobh65seiiyd4z0cD39WKIu/4wo8yYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158471; c=relaxed/simple;
	bh=a7zXUsjIHFBj6UtuHIGqkb0M6o1HjRSl6bFr87ht9jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9dzJjCX5hIVpCZtpxRlmjhC0awP6Ls9fCICplDuJE+SR8KZXEVQMGzTYf0dmRRNLpzvKPNggoop5tnfnzlSOspApCBMaqglBkHxSpDuETvMxIca+G96hZhOW+FfGJwUbCSsGbzMkRFI+41SWVaAAp9xT3XqgOM0iVzCrafe/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nC9ssiMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=92MTl0jo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nC9ssiMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="92MTl0jo"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781158467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ss4V+l8mnf5i6k0R0ef1MTFl+m/Q+uH7niX45ju74q8=;
	b=nC9ssiMZmnQB6q7mxt5yHOD7QsdEgPh4KOBC5Xna6Mjmncguu3o9gTtbX397mar8EeQbpq
	A4mrcHazAwdML7cK23gnWfcMikiz5i9mY28doaaai1hRVTJrNOjIHEfFKqicVuXERTvLxb
	EWqci5bzGHyn/NZmMInhQPCeWaVTfZSurfpvdMJVGyp2Y7N+qIeyHsfLmtuHk+lrjZgA/4
	XLwcQHiEHteW6AgqEKOUxvo9ALYvmnjebokamnNPtWg7XGTEhWWNPNZwxtLyJ74rn+pa6u
	rOLAERS9eBoD2xfYVv/f9ifT1Mk2EUrBOhbN3cN1GQm3FW7Q8abOPDVBl4vV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781158467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ss4V+l8mnf5i6k0R0ef1MTFl+m/Q+uH7niX45ju74q8=;
	b=92MTl0joGPKBzVCUhKureETnSLTs8TgOxwiZ2SswSn11pFUs68rtFOWFnCH8FoE4CC1xVC
	BCV9Js8kTIHAygDw==
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
Subject: Re: [PATCH 04/16] riscv: kprobes: Use generated instruction headers
In-Reply-To: <20260407-riscv_insn_table-v1-4-54b4736a1e77@gmail.com>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-4-54b4736a1e77@gmail.com>
Date: Thu, 11 Jun 2026 08:14:27 +0200
Message-ID: <87mrx1eh8c.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
>  bool __kprobes simulate_c_jr(u32 opcode, unsigned long addr, struct pt_regs *regs)
>  {
> -	return simulate_c_jr_jalr(opcode, addr, regs, false);
> +	unsigned long next_addr;
> +	unsigned long *regs_ptr = (unsigned long *)regs;
> +
> +	next_addr = regs_ptr[riscv_insn_c_jr_extract_xs1(opcode)];
> +	instruction_pointer_set(regs, next_addr);
> +
> +	regs->ra = addr + 2;

c.jr does not change ra.

> +	return true;
>  }

We have CONFIG_RISCV_KPROBES_KUNIT now, please try that.

Nam
