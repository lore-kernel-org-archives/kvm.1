Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430178;
	b=K9e0eiGjIkzOY7Jehn1tkA6LN9OSnNlblsXwWqiAQwRKPO8hhLHMFMbhgnCJcRcjlRUh
	 xMRtbOswRiX1aLeCyPsTFhS+HKQ+gkVr1CIsUHEEUoca0epKHs+xaEPFPq8R5KqlB1g/E
	 U/VKQa+44BDpBVmfUabYS6LxvbtQfURFarjZZq84Xj1Oe81CqIA5MMmSA8PQHo7n2xf8u
	 nJFArdMAyHtxbGuzDxnlWdbRe6DBAw2uE7WvEHm8QyaX8QoMr5hky39aGq3kh7OcvjlaJ
	 3cs3IVmN/7puI3ABvYlhSzsElPCrA0AkEQL1Kjwyu3ill5um8IQuVfR8d35PJ3v+Csw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430178;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qNx6DHkaVsiPl/g7Htua0EzSABv4CXVzJo807UeBYIU=;
	b=bAu03OZHz4R5MvgedoHpZ+lNPN2QkdU2phqN8bZz4U9yozfo7FNO+oouG0vUcEltkiWg
	 e3DSalGTnohzPYD7N2eR+4n96LPRUZfpnkiP6srvMIRrJo9SzAyWvt2cxUFx4v8cBQ9Ou
	 zeSqFLSWkGCXKfqKy80e916y35hdwjJJnZ4ig6WNITdM33dAeu9EVQtZeRdE6ypQdjAgA
	 KJEVMD+0yXgmVSLIlXsbWX+HgKViGIUTGFnQ/x6xVklcFbfAqs51C+3/73kAOohbLeDxf
	 Nf55Po9J7EyaVODGQUcZimBgXB3lnzWfIfgLlCdYbKEWSCMggp8kNedbKz6bgpEuBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iiw6TvWG;
	arc=none smtp.remote-ip=95.215.58.198
Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC0606A31C
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 17:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iiw6TvWG
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ht0YeVNr87GBjD/XD3J4ka9N9ZFBQ94E02FEAUKrXMQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792430172; v=1; x=1793034972;
 b=iiw6TvWGLDpdUujW+T4pCEJBQaxSFh1bnb2CPwcVAUYeGQQe5WxwUZ6gNCwiajETL3atuAGQ
 oy+pUMT35XrePg/0Krhue2neU0ism537XbShNYthPC+NRXoxw58eQe+7uG+cDe/Em7uuwGmTOrF
 eZ+oeaCCPgyf75EEftBwFdPc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6fce2d4bfa616019;
	Mon, 19 Oct 2026 17:16:10 +0000
X-Mizu-Trace-ID: 6fce2d4bfa616019
X-Migadu-Flow: FLOW_OUT
Date: Mon, 19 Oct 2026 19:16:06 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm-riscv@lists.infradead.org
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw
 spinlock
Message-ID: <atZPqGKEip_sW3fr@orel>
References: <20261019134709.2610129-1-andrew.jones@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019134709.2610129-1-andrew.jones@linux.dev>

On Mon, Oct 19, 2026 at 03:47:09PM +0200, Andrew Jones wrote:
> kvm_riscv_vcpu_aia_imsic_put() runs from the scheduler preemption
> notifier with the raw runqueue lock held, so it must not take
> vsfile_lock, an rwlock_t, which sleeps on PREEMPT_RT. All vsfile_lock
> critical sections are short, so a raw spinlock is fine.
> 
> Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization")
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
> v2:
>  - Convert vsfile_lock to raw_spinlock_t instead of adding a separate
>    hgei_lock [Anup]

Hi Anup,

Sashiko found an ABBA deadlock with this v2[1]. Making vsfile_lock
exclusive serializes kvm_riscv_vcpu_aia_imsic_put(), which runs under
rq->__lock, against the SW-file inject paths, which kick the vCPU
(pi_lock/rq->__lock) while holding vsfile_lock. Lockdep confirms it with
an EMUL mode guest, and the host then hangs (I should have tested with
EMUL before...). v1 doesn't have the problem, since its hgei_lock never
has anything that wakes tasks nested under it. I tested v1 in both EMUL
mode and hwaccel mode [again] with lockdep and it's good.

Should we take v1 instead?

[1] https://sashiko.dev/#/patchset/20261019134709.2610129-1-andrew.jones@linux.dev?part=1

Thanks,
drew
