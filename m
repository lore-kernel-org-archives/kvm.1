Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EA5224234;
	Thu,  7 May 2026 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778121450; cv=none; b=AFqGPulTf0W2uRKu/6ANhzLEnWNjM+SaQ7QKYhQNHdgnCTolpCofpHxFXbvqLd4Jkv4QbTOp6BFtjik7DHlKtXoubm3P42MQ5XUbZ9robnZbDkGc2qgNSx2dnAldgBwEoLlXGMT+oIqqJyLz7wzZNMBNDQ7bGdiNDO/3YdpYtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778121450; c=relaxed/simple;
	bh=x4OZxVVa7XuFeQ5NIz/1eEAUFe9OyoXfnPlSCrrsrgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e6WH8ftLcDUaWF3WlZM7xDD661eWmY2hjWx6eJ32ssGaFnNmAWbgn5PApFL47MSyP39MuETogk3r8zd0Ov8N41s0GvEzGhKlvP8LkxHjfvK57hY0zh50E4ady6EbK3E+D4veoE5tmSdY+Z8dEf24jOseF7oPVnRIuW7vAG6N1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kSwqf2eJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kSwqf2eJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9S1WGdndtZGFNHWYXQ4+xkbiY7A2wvAjhcJYFVSrbYU=; b=kSwqf2eJbwf16dBZopSNAF+AGi
	8oHhPzgX9wfNxNjIdylz47I+Kc3CO4gTcvdH0y3OJ6t1BZ1/1/+ep24voT6Vz6mDWDcdP3nKrmQ9m
	fHAekLGoAwq2YKvwZiE0cUC+IiDkpgT4Rj8thdZRWfPIpTNEij613gBYb0pGrVIEu716aMzU/+PIq
	VNPr5qGCqHH+WPX3Le6cAZt9Nj44fO+c/CW3IXTkLG46gEXmpCBq5I2j9vLvQ8HLL/aPC0oromucA
	UzeQdiI08SAHzWeIAzcjQhMwBDSN+wEMeULte4eNMkdsHxcZbLufPQDt4/G7Qno/gbP9lHpX8xOBS
	pkhUB33A==;
Received: from 186-249-147-124.shared.desktop.com.br ([186.249.147.124] helo=[192.168.1.66])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wKobn-007Avi-0E; Thu, 07 May 2026 04:37:02 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
Date: Wed, 06 May 2026 23:36:45 -0300
Subject: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
X-B4-Tracking: v=1; b=H4sIALz6+2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMz3YrUPN2iEt3inNTUAt1Uc8MkSyMDS/M0Q0sloJaCotS0zAqwcdG
 xtbUAflQHKl4AAAA=
X-Change-ID: 20260506-xen-rt-sleep-e71b92097f19
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-dev@igalia.com, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
 Mauricio Faria de Oliveira <mfo@igalia.com>
X-Mailer: b4 0.14.2

kvm_xen_set_evtchn_fast() calls read_lock_irqsave(), which might block
on PREEMPT_RT, but that is invalid in IRQ context, as when it's called
by xen_timer_callback() (even on PREEMPT_RT per HRTIMER_MODE_ABS_HARD).

Check for that case, and bail out early.

Note: there is previous work and discussion on this [1] (~2 years ago),
which involved continuing to execute the function with changes, but it
was not merged. That was a different, more complex approach.

[1] https://lore.kernel.org/lkml/ZdPQVP7eejq3eFjc@google.com/

This is quickly hit while booting a Xen guest in a KVM Xen host.
With this patch, it boots quietly and runs timer stress without issues
(e.g., stress-ng --quiet --timer 1 --timer-freq 19000 --timer-slack 0).
Tested with/without CONFIG_PREEMPT_RT.

Test case:
=========

Configure a host kernel (CONFIG_KVM_XEN) like,

    $ make x86_64_defconfig
    $ ./scripts/config \
      -e EXPERT -e PREEMPT_RT -e DEBUG_ATOMIC_SLEEP \
      -e KVM -e KVM_INTEL -e KVM_AMD -e KVM_XEN
    $ make olddefconfig

and boot a Xen guest kernel (CONFIG_XEN) with:

    # qemu-system-x86_64 \
       -accel kvm,xen-version=0x40011,kernel-irqchip=split \
       -cpu host,+xen-vapic -smp 1 -m 1024 \
       -nodefaults -nographic -serial stdio \
       -kernel arch/x86/boot/bzImage -append 'console=ttyS0'

See dmesg in the host:

    [   27.643129] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:231
    [   27.643134] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 284, name: qemu-system-x86
    [   27.643137] preempt_count: 10000, expected: 0
    [   27.643138] RCU nest depth: 0, expected: 0
    [   27.643146] CPU: 1 UID: 0 PID: 284 Comm: qemu-system-x86 Not tainted 7.1.0-rc2 #5 PREEMPT_{RT,(lazy)}
    [   27.643150] Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    [   27.643152] Call Trace:
    [   27.643155]  <TASK>
    [   27.643157]  dump_stack_lvl+0x64/0x80
    [   27.643165]  __might_resched+0x131/0x180
    [   27.643171]  rt_read_lock+0x47/0x210
    [   27.643176]  kvm_xen_set_evtchn_fast+0xa5/0x3f0
    [   27.643184]  xen_timer_callback+0x88/0xc0
    [   27.643188]  __hrtimer_run_queues+0x10b/0x280
    [   27.643193]  hrtimer_interrupt+0xf6/0x1b0
    [   27.643196]  __sysvec_apic_timer_interrupt+0x55/0x130
    [   27.643200]  sysvec_apic_timer_interrupt+0x39/0x80
    [   27.643204]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
    [   27.643208] RIP: 0033:0x7f069721a8db
    ...
    [   27.643226]  </TASK>

Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=208f7f3e5f59c11aeb90
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 arch/x86/kvm/xen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a2ef3dc154050e01df608182e59e5..76782191043b56c581f89c3861979236662cdbd7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1814,6 +1814,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	rc = -EWOULDBLOCK;
 
+	/* Bail in IRQ context on PREEMPT_RT; read_lock_irqsave() might block */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && in_hardirq())
+		goto out;
+
 	idx = srcu_read_lock(&kvm->srcu);
 
 	read_lock_irqsave(&gpc->lock, flags);
@@ -1892,6 +1896,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		kvm_vcpu_kick(vcpu);
 	}
 
+ out:
 	return rc;
 }
 

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260506-xen-rt-sleep-e71b92097f19

Best regards,
-- 
Mauricio Faria de Oliveira <mfo@igalia.com>

