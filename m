Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221E3264DA;
	Thu, 18 Jun 2026 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796695; cv=none; b=UANQJMF20rIBCyW6IiJZTOCUUrDEsDxVMp97m+kjDyotXxzSrT159jokXcQGkj4sNmNjShjfL7M0Mt5XMnUlFJMlh9aHBOucSuwKS/6ae6Ru7EjY1FZN0HQ6QO9AaM3N4fOkVmNtRQ0zA8e7mDnG13CgaCB1kRaWhaAzghfidaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796695; c=relaxed/simple;
	bh=RAAaHoeh/MJumT7Jl018zpIQtLKmhwOXGGNn3ZLlRog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=moJJeg644vvIp4qYIdbInAkWcSkt/yyen4zZk5i978M+Bf+vDGiaHNIu35lQwhdhHPp7xR/4pOtp12KyqUSgseZiL++3ylJRNaMIfTdP3xSWfUzQRU61JP3xrjYwdMxlBwS4nTy4t7bvRTybxSBI8WXtKp8qO6oBZboxX81rFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4b+IXkQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t2jc4irZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4b+IXkQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2jc4irZ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781796692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAAaHoeh/MJumT7Jl018zpIQtLKmhwOXGGNn3ZLlRog=;
	b=f4b+IXkQhTwpjwvjeIS1sST2BLVtsjL1UEdnmxNOL3lPDXGXN8p4pBZTulWxnvylYeKVFG
	uGbMKdwi+CpjyDB9PBq7i6vVXxyG8S7BCgaClErdpvv1yr9NTz2M+bFLuy8zG75x1SYbaS
	I5Y9y3yuOPT48X3zoEALahwLSuvgH0Q8Z9+txzIcZmx49i0Hh3TBkpmj6sAJTM29MEshDP
	D2zBkkEYZ1hnAs7p/LoLBujaAGEGCdM4L0Z33LPyovOnyyDwz00riz8cpvuLnW8BW887CI
	zRIBZp7UkIF0mKRU2sNooS78DgPMPr5zjfTxECII4a6DfL3Lt7WcjsCvWBnliQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781796692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAAaHoeh/MJumT7Jl018zpIQtLKmhwOXGGNn3ZLlRog=;
	b=t2jc4irZweu5KNBW2cs9NoLMghLuOSyOya4gG6B0vbJPWT7FpL5OwzHy+GB23sGgly2aig
	sV+QDO9IaCT6MHAA==
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
Subject: Re: [PATCH 04/16] riscv: kprobes: Use generated instruction headers
In-Reply-To: <ajOezhejx7PcOw_x@blinky>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
 <20260407-riscv_insn_table-v1-4-54b4736a1e77@gmail.com>
 <87jys5egum.fsf@yellow.woof> <ajOezhejx7PcOw_x@blinky>
Date: Thu, 18 Jun 2026 17:31:31 +0200
Message-ID: <87fr2jq2zw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:
> Since I was checking against the previous version it's not possible to
> do a straight one-to-one conversion to the kunit. I think it might be
> possible to do something similar but I will need to mess with that to
> determine a good way of doing it.

Perhaps not to the existing kunit, but a new kunit which calls the
simulate_*() functions directly. Just an idea.

Nam
