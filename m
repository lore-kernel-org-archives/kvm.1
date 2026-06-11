Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882B30215A;
	Thu, 11 Jun 2026 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158965; cv=none; b=t3lty8ywx3bni2dh6yOB8yd0ndYC3IjT0L22QG6V3KxiQD1KF33LAtnLBffEMgIyWmVAmQNHLAC/t8uICQ9iwWz0PIPsK6FipuP1K5dNxl5M3raIO0J3zeASm70NYsd5+MUtmNm3UHFzovEmle2cNloadWMvMilfmZdSoDIjJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158965; c=relaxed/simple;
	bh=ZCD04A3kDNsbHUnULOtASEJUFl9RiA8on+HC7R/jRyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWifbMo/ACmLR/bbqbAzGp2clXZXScY/wgyKH+HhqNkqAF9WqxRnkjp0n6lLCtd5GP1nFY7Htj75NmEmu6ij2SLL/mHIXNru3rvoXfkEtCTPS5+T0K2kH32HQVWuOfd8baQ1r7ZPjpSqOO9QvRqgv8iR+/gSxvbs5Tzcp9L9Vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z9pfJawa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBdiPdwL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z9pfJawa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBdiPdwL"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781158962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCD04A3kDNsbHUnULOtASEJUFl9RiA8on+HC7R/jRyg=;
	b=z9pfJawaBkLSUhDuqX1UedY73W4K0tp7NE1CP5qtt1uFFLlKUwL2EN7HppbMYVud6EWtfy
	npDVpizE5MJvIHhQcrNHGXhOQZke7kNCOAKxc9hCbryOIe81uaHrNE6tbHyBiFOtc6zQrI
	vb7bZf6jYKs47h6j/Ftoie59q0BdsvDKbFYSLV9s+AdGyVGzV4n+JqnXzPt/UBcnlsG9vy
	5RCAQwDo9TBGIP+7WU4gA+gVxieEntO/qSlnnwRTqOkHLU0bgQXSI+/cm7EfHCYQO8HcMI
	Ql3e/CJDXptWreo0mvCeJ5j1UBamm77E3AaYKeLtDqy7T3/ITJVLi/yIRhQNoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781158962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCD04A3kDNsbHUnULOtASEJUFl9RiA8on+HC7R/jRyg=;
	b=KBdiPdwLWY386ytcuhMI3mc2McYCUiAiriNQM+zUkg6uWLlRikL+bLoF6xds8BUWhD8tjQ
	+3JqSJELNBGPXnAg==
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
Date: Thu, 11 Jun 2026 08:22:41 +0200
Message-ID: <87jys5egum.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins via B4 Relay
<devnull+thecharlesjenkins.gmail.com@kernel.org> writes:
> This was again verified by checking all 32-bit values for each of these
> functions and checking that the two version have the same behavior.

Your checking is missing some cases. branch instructions and c.jr are
broken.

Btw, any chance that check can be added as a new kunit test case? I
wrote the CONFIG_RISCV_KPROBES_KUNIT, but that only tests some values.

Nam
