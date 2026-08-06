Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAA3CB2FE;
	Thu,  6 Aug 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005041; cv=none; b=VZktftSYPIGIeOEkDRHmNeZPn/A8ZGG4J02hp3j2pXF1zgrdQHxFh7nUX38qyPC0kkOtmgt8jqxXmUudbTqv8b9nDjmew4ylYu/RtLzcJ9a6SlvFeZk9mys8fVwaZbBWWMizYAC070NbcN2mP4Mf+WL3q0cIFCe89GWtArlp9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005041; c=relaxed/simple;
	bh=tZf7xKKc+1d2MNQgkLvIjW8ujEjid1DyCjtobMNJ3tM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rncGMivkvlwwzersRFnecTggB93wpd9JjOGo55f+bDbg1ZLJ+e7ypay7YG/3Tt+5YxRCzRGvbDHA+SUf2xLiXjEGmobyrTa2QVfEIR2hS0uPg406yzJtKJR4PV7YVBQ5rVoo9A8H38CekVXssCtvUN/td/w52nwrZ+hD283I+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3U+sDmts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7o8EsxQc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3U+sDmts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7o8EsxQc"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786005038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZf7xKKc+1d2MNQgkLvIjW8ujEjid1DyCjtobMNJ3tM=;
	b=3U+sDmtsKA+gIobhreS8X5tZMGQYfmuSSZS4qPnpbkB12L0+Q3YwHunpfZzVLtSTHcdcNw
	KfJ8EABF/J+YRK8Cn6tP73xzTRSFvvT9kALj8HH5CSFMGnEXfZOGx4KAZZYLLMD4jPGvTI
	RYpCZwU8sqymXkEx1lXTGSd30O+M0LkB0lE3Sj2dCuQGfh2RByjotBPRF/nUi3D7SYq+KB
	M6tNTsZ0RPQ3Ie7pMYkyaYCI92qPAoq3stLeXEy3ilNNAk0J6/+EHtxl7XI4k5np7JKGpn
	UWLAlnXZH6XVL0jJZAJAuMuNB+i0++CK4BhRWVQ9xNTI5QWvI5rjt7u6G4LTNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786005038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZf7xKKc+1d2MNQgkLvIjW8ujEjid1DyCjtobMNJ3tM=;
	b=7o8EsxQcewlMoX0tfcRt/S/CFJgOsMEMUZCKY2z4IwAgXrtmyS+s+DlSYK9o+PaWyj0g+3
	Dx3nZz0cNTv/iSAQ==
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
Subject: Re: [PATCH v3 06/17] riscv: cfi: Use generated instruction headers
In-Reply-To: <20260707-riscv_insn_table-v3-6-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-6-3f8e5f75ba97@gmail.com>
Date: Thu, 06 Aug 2026 10:30:37 +0200
Message-ID: <87fr0rd51u.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Charlie Jenkins <thecharlesjenkins@gmail.com> writes:

> Migrate the code that is decoding cfi instructions to use the generated
> instruction headers.
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
