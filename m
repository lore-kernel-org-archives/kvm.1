Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAE437455
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515756; cv=none; b=WyeC+fR+vewWzrfm1u/ehifw+2xmV2ycsKKdnRHrPRW5SPftsLOvuCDvGidU8fglzs+KEIGqmvIt2FyqxJbMmictgBnbFH2+frZChcKGgj12ZhrDDYBKTJuohKsPjorOzcMAVdU83s9i/jh/US11wvPhzwOvaDrDWl+rUYfqgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515756; c=relaxed/simple;
	bh=8AsJQivIvh05NxAaZ800XMQSi1CvVtRnuVUMO8HT4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JasN0iB42g/vR+v/VAIjjvzfZFoS0lgDv0oG96h86Cdz+PF11EMAVe1F9/9tuwJpxMsY6h82eSA058Io0/MJy3luCUmqKYWi5PUGI3jImN2SK/2mPFUvDT3SFNwy7/l/KwIjjw/OLzfE2M0mgs+AiTIFLCEtlyC5Ohq7Qq2hzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR/Ekjkk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR/Ekjkk"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1026362b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785515755; x=1786120555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rU2QgWWmiwDOTc97tpYJfn2gTZC2cyR2MioCmCqpMNY=;
        b=MR/EkjkkpKh+lQapp2CdZAFuKlKb4YXHlc3ZQLITtMcOx9sdfoXeaeLedRTvBapwd/
         Dx74d4ZlDzfkAnvY7Ktz8p1Pk9ZLIyePj3CV3A1+4eJMpz8JuocOe/dubUZZNxKA+SV3
         FlzEnD3T2qkyVlHheUiO/9cMrg89RjqQNJUB+k1QGQKSfzHe2tlv/vOk2Lrx/4Np7WOV
         DwWa4ZzAzjZfgQx3lkWb8WbfnSjjeFBCQBhhTQMFz+aiQdy3QWYJMn8gkG21A38x2u3F
         gpHgZgqoz9knAUs33OCkEBB7WRXoEyMGY+12H5qYmalYQR4aT9Jl+txKPhpUWihc9Xmt
         lIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515755; x=1786120555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rU2QgWWmiwDOTc97tpYJfn2gTZC2cyR2MioCmCqpMNY=;
        b=dUtekAzj+yxFUeWBd2+2dBTj5/TYceKyW3veJRpzyci3WfDEet0FVz/uVQjhXVbF14
         FkxDKAqZ0HPd/i0rd5PYem3l5M1VqS6q1662xo4yajCA1SXU0sTc2357hc2wISkOIGGY
         pyuz8AXBO/HUQ5UUY8f/QeBSTrB6+n1wkSt9VbLkZS1SZSIjTepx1a2YvK4sIFnSecgk
         ksLftp2qOKvxjk6cJWhCdWHQyRY7rT8ABKOGuKj67Rx6dTB46r4FB2c3NZozpMe+KYTf
         2SLeU48RJ2ybw789jXLxXIRq3R6Pu+8nksQ1dpd416gWW16Ii1VrB++RQGMF+J24CGn5
         4YFg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0yHaWLNAbwwsOShbqB07GjpYZ/rpXqvZJS9iJubh/jWYyH+kbR3DKwN9STuDXVv5dHjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIpR+Cwn5cM15VXEUGgvq4Uld5x4jOuvIaWFe/o9nU6gbal2VG
	ITSQTDcK9RQOz5AuY2qHfxT6kIE0wokkA0HzYz71s6/Y8iqxdxyBT1hCCkhiBWY=
X-Gm-Gg: AR+sD12N0JPvJp5XWPe1A8pBCgYDi8NBOsx2odCYHZMwYUOGoRp9uhm2BgUrYgkqdXS
	1U5gwvCux+EplTIpozmhRoMPg2J7YIRYhmrKP04yXG8Gggt2rVQdkh/mkdLILR+iobhM8nOoMTD
	zQcrHxsKwjb9mBLixcQ8QbgfXZ/nI4a3taO2J5zK1K7pU7QMFd3zBFRCODzrpHNikl6PSQgGn9G
	xKm4FgVG+ohdBSK1lFlfXJefiirNXA6AuMrXdCueUoJ1cf7l6Ppfr1UgHnOhno0zc03RhivG3UM
	jU9sBcb+I58BW65x72RRGLngSFeW7l4zDecpWr173ie7EBB4BTeyYNL1ilAnlOB43rIP9SOPfBw
	1Gg2YiALTbFzWhePu58dNQ9Hbck9LDFHua2zZhW5g4mGNJ7Jr7xJeCbpOz7lOty6S35njcGYP8y
	JnSbA7A14DD6u6jWNPjqBjTs47bexZ3cGwbrTobGu1m8UfIkzUXdSKJZ410/gPKc+v80AQhzrtM
	QANs5upZXxEnm/LPabKhIc6whiZmgW7GWVmHfJtPCpRW7PC8mtFmOfaUpsPxseRQIVSANy2N2pk
	g/6Bx4hfqA/d2T1kMPjcsHk=
X-Received: by 2002:a05:6a00:14cd:b0:848:40f5:ff5e with SMTP id d2e1a72fcca58-84ed7517231mr2195457b3a.37.1785515754707;
        Fri, 31 Jul 2026 09:35:54 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc422ff9sm674942b3a.54.2026.07.31.09.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 09:35:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2] RISC-V: KVM: Synchronize hrtimer callback during teardown
Date: Sat,  1 Aug 2026 01:35:50 +0900
Message-ID: <20260731163550.46991-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
References: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-Sstc hrtimer callback clears next_set before its final uses of
the enclosing vCPU.  If teardown observes next_set as false while the
callback is still running, kvm_riscv_vcpu_timer_cancel() skips
hrtimer_cancel() and kvm_destroy_vcpus() can free the vCPU before the
callback enters kvm_riscv_vcpu_set_interrupt().

A guest can arm the timer with SBI TIME and request shutdown with SBI
legacy shutdown or SRST.  A VMM that honors KVM_EXIT_SYSTEM_EVENT and
destroys the VM supplies the teardown side of the race; no post-launch
host ioctl is needed to arm or request teardown.

On upstream master 62cc90241548, generic KASAN reported:

  BUG: KASAN: slab-use-after-free in do_raw_spin_lock
  Write of size 4 at addr ff60000005e58898

  kvm_riscv_vcpu_set_interrupt
  kvm_riscv_vcpu_hrtimer_expired
  __hrtimer_run_queues
  hrtimer_interrupt

The object was allocated by KVM_CREATE_VCPU and freed concurrently by:

  kvm_destroy_vcpus
  kvm_arch_destroy_vm
  kvm_destroy_vm
  __fput

For deterministic validation, I added mdelay(1000) immediately after
the existing next_set = false assignment.  This only widens the
existing post-clear callback window.  A no-delay trace build naturally
reached the callback-after-teardown-start/before-deinit ordering in 12
of 200 runs, but 1,500 stock-kernel stress iterations did not produce a
KASAN report, so natural reproduction is timing-sensitive.

Always invoke hrtimer_cancel() for an initialized timer.  Preserve the
existing -EINVAL result when the timer is no longer set, but only after
synchronizing with a running callback.

With this patch, hrtimer_cancel() blocked for the full widened callback
window before vCPU destruction.  KASAN reported no error in 100
fixed-and-widened runs or 200 fix-only timing-sweep runs.

Fixes: 3a9f66cb25e1 ("RISC-V: KVM: Add timer functionality")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Add the required Assisted-by trailer.
- Drop security@kernel.org from the recipients.

 arch/riscv/kvm/vcpu_timer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

AI disclosure: I used AI assistance during the audit and am treating the
issue as public as required by Documentation/process/security-bugs.rst.
The reproducer and full KASAN trace have not been posted publicly and
are available on request.

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index ae53133c7ab0..a2cd277a4059 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -61,10 +61,13 @@ kvm_riscv_vcpu_hrtimer_expired(struct hrtimer *h)
 
 static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
 {
-	if (!t->init_done || !t->next_set)
+	if (!t->init_done)
 		return -EINVAL;
 
 	hrtimer_cancel(&t->hrt);
+
+	if (!t->next_set)
+		return -EINVAL;
 	t->next_set = false;
 
 	return 0;
--
2.47.2
