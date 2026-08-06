Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0863032B123;
	Thu,  6 Aug 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005019; cv=none; b=kEzrtenUb2LAbeWrZ31aHwWPI3IxMTpCvdmU+Aq6TTfZ0TKrtnzc8gz4q+5yZJJRalm6YTvitXKQ8U4GxsoePrqvyvucoVRseEuBE0xbdTpWQTMHjmRjYAnpRWLrOhq1gR45aslITuM9ZES64izMI31VALhA7FXDgG2tj4eWreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005019; c=relaxed/simple;
	bh=RYCqiASa8LvYt/XQP0Uqmi0xvt/HI/PjhI8z3teOwyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prU7IFRjv2iYRoa9z1V+tT0XRqXHZscdMUletrfsz5Q5hNdVSqbJfeRBSAlZLiOU57NYwpCih9eaLOAHmjDYw+MvA03YcN1kX0xX7qFDZVNYDzXzKT6DKwsk1b4HE408GT/rI2WdrkBJ03ISIWX8cxOyYA4O0piMt59qssLe9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N4ulFANk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=df+jiy/u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N4ulFANk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="df+jiy/u"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786005015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RYCqiASa8LvYt/XQP0Uqmi0xvt/HI/PjhI8z3teOwyg=;
	b=N4ulFANk+Jf6IV7bn8P/eqhssX+kCl9QEn40O1M3GjqNka2J4jp/JZAC0BdQGhtpcvadZn
	sOFZtuGdMFxu6wT1XbHWBQ7jtMH6+pBdEitxTFvSGH7Hm0KyahyZ01DRcNfXYP7T+XS4n2
	WFNwz6RYniSyD1qnI8ihnblcn6S6vR+pwUcleFVJ7SU9yXVO53VOVxADgbcRiSHYTHUzut
	jAdy77QG8XrLwWvjWvgspfuPJvt80DINXy8lKvCVuFMOsUp01TnvJpUQSoqCsquNtMM1pd
	U75a+Wgz8FQQqonbuMXZf/bI0PfOb7zAsFEdXpBM6bCQn3s5XosZvcEw78BRaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786005015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RYCqiASa8LvYt/XQP0Uqmi0xvt/HI/PjhI8z3teOwyg=;
	b=df+jiy/uQp2/4IBaxPt0UnDSaG6JqQTpGXMEyQpQKYox9a1aUE82jy0N/pi/hhSFmVwMTW
	WPYXSr83aZxpICAA==
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
Subject: Re: [PATCH v3 05/17] riscv: kprobes: Use generated instruction headers
In-Reply-To: <20260707-riscv_insn_table-v3-5-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-5-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 10:30:15 +0200
Message-ID: <87ik5nd52g.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:

> Migrate the code that is decoding instruction for the use of kprobes to
> use the generated instruction headers instead of the hand-written
> instruction functions.
>
> With the more granular instruction support, split the decoding of branches into
> their own functions.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
