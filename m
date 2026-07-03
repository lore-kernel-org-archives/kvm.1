Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A972E06D2
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111940; cv=none; b=tbSmM5ZlwQTwmyWuUq4m/2kFelyWeywMsSz2YfkVzr/NYmZCLEcYFxxGsEAgn6SJEHPH4Q+b8V2bvj/+kVhRd9ENFoxCFy+ro2SD7fzuqsvOPnRuEd1wpAhO9Lltu4CrpvNnqTFnI2M7GOrpgQ/h94L+4UHP0GlERmu0F7AK7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111940; c=relaxed/simple;
	bh=KPYcDesB5qyB4Y/O2yFaa9zUMYJFcZ4qcT23bnZblGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WPV7M9TtvT6yxPXSNfOE8cTBp2GFWKI7Jw8ZMR26LliPY2vOpyxDaYkxNqLahY6BbxdEebp+l/Vc4JtD6BrBER5AiveYFaeKl9M4cmIbBCryBIhSc39xl/LJJbcJw+bTolqCr9xr4PTz/kkMGGgeFG/yObhWvXvzaAOWjS0ddZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=12is77bD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MRiR+YaK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P0fFHs4g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gs53oWbH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="12is77bD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MRiR+YaK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P0fFHs4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gs53oWbH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B146772CF8;
	Fri,  3 Jul 2026 20:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783111937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1/6xGMWDZr+PSrwqvKyE7X7wdSEGrlM6VN2ne6ldj4=;
	b=12is77bDUjk4sKEvoujh7VAlm8v2PDvNO+w33cU3MX+hEZzPQVYB2267Fno22FXYzs/LeM
	Tfu94x7ejCgDKRLgyRNzCS9pxrtqtDamTct9HQgPc+e+EzWWq1/6Sm6KSSBQwQTd3aT/T0
	jvdmSIc/O4mrHadPo1hVa18sYYPF+9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783111937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1/6xGMWDZr+PSrwqvKyE7X7wdSEGrlM6VN2ne6ldj4=;
	b=MRiR+YaKcDcQgYr12lviiFWs8O4SK6U+ckFNpLXMc3umAGucZzpQFAO2nETqi8OSSWDuyh
	TD4hILNqt1qk2aBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P0fFHs4g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gs53oWbH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783111936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1/6xGMWDZr+PSrwqvKyE7X7wdSEGrlM6VN2ne6ldj4=;
	b=P0fFHs4ghSWfJgRCBvpHpF+JnI/sjbDguHGG9FjI6ovk2wwuv6+76Rx1NQuFN7fb/9ezDK
	ehYPkZAS9jl89bO6e45RjT7amiUExRX97RgdeNI25yWc+Qgzq2jDCZ0Ld/zk1QxsUITTIU
	fdfAM2EKKzt0jot5YtNC4tJctZ/T1NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783111936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1/6xGMWDZr+PSrwqvKyE7X7wdSEGrlM6VN2ne6ldj4=;
	b=Gs53oWbHY8Wc1ZXBalz+culyv+N5RhXobr3CSjp9d5QKyGxjUWmR0pXWF8kHZ9+19qY8TN
	Rl2t7r39tne6PVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6C2F779AA;
	Fri,  3 Jul 2026 20:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4dV1Kv8gSGp3BAAAD6G6ig
	(envelope-from <clopez@suse.de>); Fri, 03 Jul 2026 20:52:15 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Roman Kagan <rkagan@virtuozzo.com>,
	Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH] KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock
Date: Fri,  3 Jul 2026 22:52:01 +0200
Message-ID: <20260703205201.2667136-1-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B146772CF8
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[3d5461510f8dc4adfe30];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.de:dkim,suse.de:email,suse.de:mid,syzkaller.appspot.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Fix an issue where userspace or the guest can program an Hyper-V
synthetic timer to have a deadline in the past via integer overflow,
preventing the CPU from making progress and triggering an RCU stall.

Hyper-V's SynIC exposes 4 per-vCPU synthetic timers to the
guest, which are emulated by KVM. Each is programmed through the
HV_X64_MSR_STIMERi_CONFIG and HV_X64_MSR_STIMERi_COUNT MSRs. Depending
on CONFIG, COUNT represents either the absolute expiration time or the
period of a periodic timer, both expressed in 100ns ticks. These timers
may be set both by the guest (WRMSR) and the host (KVM_SET_MSRS).

When the timer is enabled, stimer_start() translates COUNT to an
absolute monotonic deadline and arms an hrtimer. If COUNT is set to a
value close to U64_MAX, the deadline calculation can overflow.

    ktime_add_ns(ktime_now, 100 * (stimer->exp_time - time_now))

This can result in a CPU livelock. stimer_start() arms the timer
via hrtimer_start() with a deadline in the past, which causes it to
immediately fire. The stimer callback then raises KVM_RQ_HV_STIMER, with
the intention of causing KVM to deliver a synthetic interrupt on the
next vCPU guest enter.

Then, once userspace issues KVM_RUN, vcpu_enter_guest() consumes the
request, calling kvm_hv_process_stimers(). This would normally disable
the timer via stimer_expiration() once the deadline is in the past.
However, the deadline comparison is done between the KVM reference
counter and stime->exp_time, which is a big value close to U64_MAX, so
this never happens for a few thousand years.

kvm_hv_process_timers() then re-arms the timer via stimer_start(), since
it was not disabled, which again fires immediately. Before entering
the guest, kvm_vcpu_exit_request() checks kvm_request_pending(),
which returns true due to the newly raised KVM_REQ_HV_STIMER. Then
vcpu_enter_guest() aborts the guest entry, returning early into
vcpu_run(), which loops back again into vcpu_enter_guest(), restarting
the cycle.

Since there are no manual yields in this loop, a task with SCHED_FIFO
may starve RCU grace-period kthreads, which exposes the stalls found
by syzcaller:

    rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
    rcu:    (detected by 1, t=10502 jiffies, g=14269, q=1142 ncpus=2)
    rcu: All QSes seen, last rcu_preempt kthread activity 10500 (4294965239-4294954739), jiffies_till_next_fqs=1, root ->qsmask 0x0
    rcu: rcu_preempt kthread starved for 10500 jiffies! g14269 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
    rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
        ( ... )
    Call Trace:
     <IRQ>
     __run_hrtimer kernel/time/hrtimer.c:1773 [inline]
     __hrtimer_run_queues+0x408/0xc30 kernel/time/hrtimer.c:1841
     hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
     local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
     __sysvec_apic_timer_interrupt+0x102/0x3e0 arch/x86/kernel/apic/apic.c:1062
     instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
     sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1056
     </IRQ>
     <TASK>
     asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
    RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
    RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
    Code: 74 05 e8 0b f4 5f f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 23 6b 27 f6 65 8b 05 7c 60 5a 07 85 c0 74 40 48 c7 04 24 0e 36
    RSP: 0018:ffffc900040a7320 EFLAGS: 00000206
    RAX: 5de15cb931505900 RBX: 0000000000000a06 RCX: 5de15cb931505900
    RDX: 0000000000000007 RSI: ffffffff8daa9dc3 RDI: 0000000000000001
    RBP: ffffc900040a73b0 R08: ffffffff8fc3d077 R09: 1ffffffff1f87a0e
    R10: dffffc0000000000 R11: fffffbfff1f87a0f R12: dffffc0000000000
    R13: 0000000000000000 R14: ffff8880b8628240 R15: 1ffff92000814e64
     hrtimer_start include/linux/hrtimer.h:259 [inline]
     stimer_start arch/x86/kvm/hyperv.c:682 [inline]
     kvm_hv_process_stimers+0xd0a/0x16a0 arch/x86/kvm/hyperv.c:893
     vcpu_enter_guest arch/x86/kvm/x86.c:11193 [inline]
     vcpu_run+0x2240/0x76b0 arch/x86/kvm/x86.c:11639
     kvm_arch_vcpu_ioctl_run+0x1148/0x1c90 arch/x86/kvm/x86.c:11984
     kvm_vcpu_ioctl+0x99a/0xed0 virt/kvm/kvm_main.c:4492
     vfs_ioctl fs/ioctl.c:51 [inline]
     __do_sys_ioctl fs/ioctl.c:597 [inline]
     __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f635278f749
    Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
    RSP: 002b:00007f635365c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
    RAX: ffffffffffffffda RBX: 00007f63529e5fa0 RCX: 00007f635278f749
    RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
    RBP: 00007f6352813f91 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
    R13: 00007f63529e6038 R14: 00007f63529e5fa0 R15: 00007ffd5b219358
     </TASK>

Fix this by clamping the deadline computation to KTIME_MAX, which
preserves the intent of arming a timer very far in the future.
ktime_add_safe() already does this type of clamping, so use it after
checking that that multiplying by the 100ns time tick also does not
overflow.

Reported-by: syzbot+3d5461510f8dc4adfe30@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3d5461510f8dc4adfe30
Fixes: 1f4b34f825e8 ("kvm/x86: Hyper-V SynIC timers")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/hyperv.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fd4eb1e561f7..315635d36606 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -626,6 +626,17 @@ static enum hrtimer_restart stimer_timer_callback(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+/*
+ * Translate a stimer expiry given in 100ns reference ticks into an
+ * an absolute deadline. Saturates on overflow.
+ */
+static ktime_t stimer_add_delta(ktime_t now, u64 delta_100ns)
+{
+	if (delta_100ns > KTIME_MAX / 100)
+		return KTIME_MAX;
+	return ktime_add_safe(now, 100 * delta_100ns);
+}
+
 /*
  * stimer_start() assumptions:
  * a) stimer->count is not equal to 0
@@ -635,6 +646,7 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 {
 	u64 time_now;
 	ktime_t ktime_now;
+	ktime_t deadline;
 
 	time_now = get_time_ref_counter(hv_stimer_to_vcpu(stimer)->kvm);
 	ktime_now = ktime_get();
@@ -657,10 +669,8 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 					stimer->index,
 					time_now, stimer->exp_time);
 
-		hrtimer_start(&stimer->timer,
-			      ktime_add_ns(ktime_now,
-					   100 * (stimer->exp_time - time_now)),
-			      HRTIMER_MODE_ABS);
+		deadline = stimer_add_delta(ktime_now, stimer->exp_time - time_now);
+		hrtimer_start(&stimer->timer, deadline, HRTIMER_MODE_ABS);
 		return 0;
 	}
 	stimer->exp_time = stimer->count;
@@ -679,9 +689,9 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 					   stimer->index,
 					   time_now, stimer->count);
 
-	hrtimer_start(&stimer->timer,
-		      ktime_add_ns(ktime_now, 100 * (stimer->count - time_now)),
-		      HRTIMER_MODE_ABS);
+	deadline = stimer_add_delta(ktime_now, stimer->count - time_now);
+	hrtimer_start(&stimer->timer, deadline, HRTIMER_MODE_ABS);
+
 	return 0;
 }
 

base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.51.0

