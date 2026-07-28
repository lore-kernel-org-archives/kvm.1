Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7136A350
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256959; cv=pass; b=s16NMWy52Qpc6wY3FySYfflFfLQF2+0pTzC2vqfQbRGLQQoCTCP1Ldnnkt+iWZLwqWRrsdY07ChjlqyYpU1ijDCu6rsT+xwpxagdqaFw58HNUWMRAH+GqOsyxyu8QHinaEDHuU7skhqRWKk3812bwjy99z+DlvxQTh6eu+mpgno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256959; c=relaxed/simple;
	bh=gGUzl9hEiATjdxsmd9H6qaZ+Y5D0OduTWuAkipzUKxc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pq12FeVZyVoqAArAuCaNX5E3BdELDJFbCdN5Ffc+i4Pfmg8DPitnOPvHhfj7v44VFu4pcWdqg29PlR8zywaGA7Bl2Cwzs99fiNwpl89wD3vhS00pfPEAf9BPyeo80ZA5dRB3Nsm57jrqDlcUZy9jm9XElYlrfAnrtOG91xESzPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbDAcIup; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbDAcIup"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15f020a223so6895466b.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 09:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256956; cv=none;
        d=google.com; s=arc-20260327;
        b=i/5jpucWyDoA4VLvPC3k4fBIUQx1sZKlWGRT6bKCMLEzk2voeRDgL94vtN7GWNjBbl
         cEJgLErbvLF9oic77X/gvKvqDJwR9UcqSDBuMzqaYs6ys6Rg/OqMwhMXDUqEuDOj2QWE
         Eb/pNrJ8nzcLouUdZ+rMdl5lcyMqLpURA5VkTTNS6ZdKdZLc4gk7Co00KLiULs8RSrLb
         tAJanpL9gWL6fE0sti7lnVqrRDkX4EX0jAhPRBKnO7Y6XxpzUGAowViCUFlQXwpO4u0z
         tf/db18NMZhBaPem4WWCEjfrSLmTC/xqwSZX4CBkAfD8AY0b2yTGlxs5ONs19LxMJxOd
         lX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eRawWXBOm1UVfqgMPk0g+KIpk+hFbB2MCDRZOUgVRNU=;
        fh=rFsAkVZ1FpBfexSbJo/Uceq2foIwpIzMn2r7cYk8pOA=;
        b=T9sIXHGJ9TCZqP6ygZ+7ScNjAVDwsfPcbAIQfcSHe6ue2HRj3Dip4fULlie/UKXlZB
         B5Vo3q1yr9CXjQNB26i4DrImg5QkNKrBB44OpQ0T42jAK12NpStpJqZ1do2GlK6CHIBs
         ljg3S4upY/z340ho59wZBhOk53lpkffLJZXrcFdoqhw+QtoTNiFm5wLRyA5ngEvakEHp
         vaEB723dTN45tcEqz0+zXxJ0c5d0iajRR/6q7yW1/qRKVsAKKrsvn4IV7cqY3PqkMU8f
         +19bHfLGdSKt8ISiEUrHMkjDjWeqt3W9gQerBpOOJKmBLMKoqh6V5cJXkYFwi8BOTbDO
         z8PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785256956; x=1785861756; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eRawWXBOm1UVfqgMPk0g+KIpk+hFbB2MCDRZOUgVRNU=;
        b=RbDAcIupMokL1nVg6djeLZq9XmGmpmDnSsfE3WYqbQzIv09fePuP6b7B4ksgSKKNWj
         ZuQCWCQtHMwXybsQtGf24LFK5fnxc8g1j9zttHumrzdZhtBN8rmnSFwy9LBHvjhzxgig
         aZ4cvlN6iWcKpZJFyb4m/nM8u3LGdDdRjssh8ZRspHEPpePMlNImgMRO49d5xyVRbGcK
         +9ixLHqmAKxD5jOPLvax6dARAEeW4YrbQrfZddZMmw5dmE2ROHqxpQbhVAtIVZkkHU54
         EfrBe9ynU8Fa7yoGLP46jIW5ZdfFJCWGO5jhwAqBZUnxXiEp3Q6TvYr8Q5h07kDrCxr6
         QVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256956; x=1785861756;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eRawWXBOm1UVfqgMPk0g+KIpk+hFbB2MCDRZOUgVRNU=;
        b=P2PrwKv8pKuWYKjST+W9MoYG/PdvImXnmzONxXn2OHW/pvwfSkRO4x/fKbIFoB1fKv
         sd3fjTxw5YXIrXFW2sHptwQWwgW37/yJe+MKOG4oyLTzn+He3wqUNyo1B+LSCtEHYwMu
         k1BrF7GaeJmLO0cK4XLWbhY+FZcnHgQu0G66k35q4HeTMy/RTt+EK7er7iyTk6r73A4k
         IVW/gNmdSPtdr5NlrVTmB25QhU5Q+6f8bEGUt10t44gA0UXkmXtA32OJEiu5EpcTcjQm
         QAa3va/2QmzmfXKyMtiFVSrv9upSATdZOhQeT91XaU/wjw1dDByD+4LyAfv6tF+f69Db
         sLKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsnhYy3aVWsK8cx8KZZ/0yVPucwG+1mSs7Hg+k0lUiFQmoWT9bwUiIxHZEJufHuBql3kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIrQUmHc7njv1S7emdhXld21guX+TqywVHy38+o+r1HCfd1Xkz
	DMy49S0dbs4EIOtW4yR4qxFOsMP9YRi4Qy1OxoLHz/QmOkf8VMlG1T7qT6MOq7bjncDrGp5vXBV
	YvCQWyqyYb+JRGcBoC4PBfbQNLW42ww==
X-Gm-Gg: AR+sD13q0Z1gbT5JHSf+rDOhRgk0yLoU4EYsa9KUas2NIc5vDPUU8jn8qBTVcDm+V3p
	8jlJJng8U4o0kAGTlfMo8Zx8mkyrrw3PnQcg29MO7mQ6YnRPtFv7M5153pilT9TngyktOf0X+qA
	+UhjywhY6fjtYHw7KpP8oHgmkmz6wutMss9qdmB83bSXRhBTjSvN7QQ5lvCBPebn2XANmyYM9gs
	UeSWydDWU3nKdDUMhlc//L7yoBE2Imzj7pnxi4DYXP8trJ6164ggvwexRjhUD1fvdwkVV1Uc09D
	3J+9dpUL/edlxZWKw3YbAlpP9lIGwIkyaVT6tyR1Ks5bmw86CExqesp/FAH9YCHYp8XpfGLzFeq
	oWAR4jIM=
X-Received: by 2002:a17:907:a04:b0:c16:2d90:68a7 with SMTP id
 a640c23a62f3a-c1f71e568ffmr173688366b.26.1785256956205; Tue, 28 Jul 2026
 09:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 29 Jul 2026 01:42:24 +0900
X-Gm-Features: AUfX_mzY5IhTWpi5crtF8mrU7J89TXc4_WGd_VuJLT6iuHP5tbvLAPaufRqw2FM
Message-ID: <CAGEsz8GNHFCOZ=-_y56rK1aX+Ze7w8qVqZSQ-OuGo_dPC4bXCw@mail.gmail.com>
Subject: [PATCH] RISC-V: KVM: Synchronize hrtimer callback during teardown
To: anup@brainfault.org
Cc: atish.patra@linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

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
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
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
@@ -61,10 +61,13 @@ static enum hrtimer_restart
kvm_riscv_vcpu_hrtimer_expired(struct hrtimer *h)

 static int kvm_riscv_vcpu_timer_cancel(struct kvm_vcpu_timer *t)
 {
-       if (!t->init_done || !t->next_set)
+       if (!t->init_done)
                return -EINVAL;

        hrtimer_cancel(&t->hrt);
+
+       if (!t->next_set)
+               return -EINVAL;
        t->next_set = false;

        return 0;
--
2.47.2
