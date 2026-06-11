Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420A34CFAB;
	Thu, 11 Jun 2026 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155306; cv=none; b=gAq9g7qaqfheFHAIIIJs5W8vMzsFBck3ZUSHppJQFTP2czJIa9X/4n6HsOuz0Rbcp5rP2JjDOVQYcFW+6NWX+yPT03rX+ka+pBksIsjCpMYvIN9EjkMghddU6qVl5++KtJ8NknehVXLNrGaOWTZ8lhsYt9RcBwwb6D73MhVGyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155306; c=relaxed/simple;
	bh=i/JsgUYCntCG1YQqZsG70gRHrs+EAW6ILhqG6XZySuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGQp3RBLpotG5lITER82ALXAbv6a+oqQ95C8MuiSj7FH/nFko4l/gDW4MxC7BedE9ElYLkBFsSASQ/nhqbmtXb9jixyfQM4+um4kE2Oh+mrf7YegQp+niutQIafadH1njRAdoPz5wM+Ftld3f6uMdei9KJdoKaLWh1s6f8TEOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQzCTui0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fHWDIlZd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQzCTui0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fHWDIlZd"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781155298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxZrj3HZL3fhz45xiVff8+rxIRxk0wNsp5NDbhPArlI=;
	b=aQzCTui0vIILvBLiJ6c+wEedWOf1pg+UetUx3mJQd/3OCbhPCyC/7p99cIGbjKgoJbxeMJ
	RvZqYgQwQFmC5CqTD+p42o+nd8/IV56U9kBsGlgsljW4/EmiHlyE08zJwlpzKtucjsQTH2
	rEJEjOzYg4y7RDE+33fQm7bKo99nmPtAfJtfGnHRx8CfIAXiBKPibOszPxJ5R9VMvrAzqv
	cRKzAmPGIbpXjmJYkNqeuRTchJRuKCXXrSf/oOJdgegFvGyzXK6jp82DFjbqWEtEXJ4e+C
	Ed5pEg0YR/GG/tIVoc+km7DO9PUvOfGDB+PARYYG7MGDLtyslxaUlED8pLbDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781155298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxZrj3HZL3fhz45xiVff8+rxIRxk0wNsp5NDbhPArlI=;
	b=fHWDIlZdzOiLKfXOL42qehPTjVZemfYb8XJAOT676l7OxGd2A/3JPDZzKUvv/Wqp1V95b2
	AtIF3KGM8zBcLRBw==
To: Charlie Jenkins <thecharlesjenkins@gmail.com>
Cc: Charlie Jenkins via B4 Relay
 <devnull+thecharlesjenkins.gmail.com@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, Atish Patra
 <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/16] riscv: Introduce instruction table generation
In-Reply-To: <aioJ_5SIXdGQg55R@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-1-54b4736a1e77@gmail.com>
 <878q8m1j9y.fsf@yellow.woof> <aioJ_5SIXdGQg55R@blinky>
Date: Thu, 11 Jun 2026 07:21:37 +0200
Message-ID: <87se6tejoe.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> This is a weird one. The Ziclsd extension introduces it for RV32[1]. All
> of the data is generated from the riscv-unified-db and because it is in
> the Ziclsd extension, c.ld is included for 32-bit in the c.ld
> description [2]. 

Oh :( We probably should amend the base spec to mention that.

>> > +        compressed_name=${name##c.*}
>> 	   ^^^^^^^^^^^^^^^
>> 	   this name is misleading
>
> That's fair, I can rename it to be something like "compressed_inst"?

My issue is that "compressed_name" indicates that it holds the
compressed variant of the name. But it actually is empty if the
instruction is compressed, otherwise it is the original instruction name.

I am not sure what is a better name. Perhaps just inline this to the
usage below.

Nam
