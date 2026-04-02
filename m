Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550213DDA4
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093491; cv=none; b=B+dw1DjF+3XfJ//p8JzE6lSk+QFDApxBuRn9rkv1me7XiPs6AY3vIT7cnkdtJM/Hj+//M8qm4k1xMT9UFjiurx71cup3qurDCv/vEKXNxsXTNSLLYQMImMJu2qOFB16RMVpvSdcERxyxhW6K7eSAZflbNzP4uRP4iuNVSp2yqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093491; c=relaxed/simple;
	bh=CmiCJDKKLtVBWY4PaNZhE3phmXu2DbyTzXQix20TwNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz9IW6ywWpJk1IJ/bPCxa467VKSbRz1QrcVHa4Nxl2SfICqQUjGh5y1/PAbgX8ycZymzFh5lCvm4Bd33fP0sf88d3J77kvkv4fHCDoyXppCwwgJPcMwKiro1pBiFuJtzsoMtzefkH4apkOkY4V3I5G5o64LrCwPG/17HarQzES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arTX9ihX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arTX9ihX"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c766cf593daso204786a12.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 18:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775093490; x=1775698290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAh0rZ9dUNksvKcTzl6dU2+Jr09vS06UeooC9PWMHnQ=;
        b=arTX9ihXtJTrVUYOrC/416+TIEj0MtY2aLqTZD8Ebcm3HXb3OvUe26VXAmmPA4PnBA
         LAfGHNDdei3k+qFacnuMAbL1/G2hHuWC6ChDLlKgIk6wekQOxePfzLxjrCbkEUiO4ARq
         uov3PTUG7Qb84THccOJYcuzVHZFoRvt3T4pNlWWEiAkM/BpGH9pyYWBNhVsrkaex76f1
         9Yy4i6roTjiGZlVYy68cO59IIXXMScem7+I5ntWbdFS8P7KgOFMbN30ObosNlw5CNN3v
         wDOV5QI/Sp4kQ7J0V8YVBc8iSkQuUqGbeOGT4woyFfmyfyqHnwVIqeRU34tk1WY0nm9V
         L3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775093490; x=1775698290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAh0rZ9dUNksvKcTzl6dU2+Jr09vS06UeooC9PWMHnQ=;
        b=bGvPbhyvF9t52cfKb88mobjP34Ctl0pyqgg9RjTXmkNN2zzVVxx3/XBPZ7VHlK+7MW
         AdNOca+nYE056PbS3nm/aZOzHMhTjoaIgpbt/VyjqvX4nbFMDTgOQGFkAm52GG9qplfj
         1EQ0h4HF6YxLkjXE2yBM+MY8oBUY5EUksi7BHxlT2fEpagy4WBK1GbYPG0yf4gS4Vqf9
         u9NP7fDFvsyQma/sRFnd5LouX1eKgYxBS798lSyrqf/g1PCnJUO8xiw+m/E3K7mASk6Q
         WrYNIupWMo6o7JizuD2H9cZI1ATieSwuBC+JMNKK4gaa5yqHcreH7R4bCdgC0dO6zvtQ
         BLGg==
X-Forwarded-Encrypted: i=1; AJvYcCVd15eTZ8L0lzTblofWsrCIQh95MTtLQMzHDACLb0xka3r936RWBbqW/kK9yc1bqV3LSs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/YmkG2+Vz+y0f7Sm7pz1Bp2LZK34nmNl4w0Z9VjCG2UHC7ob
	uRY9fcjfTnq/DPqRZDhJkP+RPECtEo+Rqoc73iiWL1mj7ZcUipPw88Kk
X-Gm-Gg: ATEYQzx/f1Q9avvxMjJsa+cj43pvpc/IKTUMBesJ6u+ZlQQfQ0CTPNBVyM1gMvz4F8e
	MfeiR1gGczGIwCaunDYiRo0VnmaaDX/sVcIe+01PGv+e5rKxT6WhgPZvkbvydKTL8nMNX5pSZTb
	EYzsclF0KupSDey7ElAYRIVW/n4fuItlI/wf7/W2pYGwd1Z26FMP1Yu+PQ3fX4qGo69ZoiFUeAb
	li2CA3cS3TljHdYRKpVt9uOfs+kxwMiDMz+usn04qMuBTSZR3VbSRjGwGmPXrL/BLgX/37n9K0M
	RCn5k3ojYcqG6tuGgICcsqspEvP58TYlaBn0ZLElq+1CJ8d0ZuVFke/4aTDW4UC9X2/BcwlOOGD
	tf4oLS8ItLWPqyjbi06s4ezWppMlhJSLNkGMohY0UtgBGImNrXq8LP3BKSVqtAbFOy0c+n14ALl
	9/Ls8s/PN8C/vfhMX+2I59OZCWl4kPZnvVDD6RmA4=
X-Received: by 2002:a05:6a20:394f:b0:398:8026:4811 with SMTP id adf61e73a8af0-39ef77372d3mr6463370637.35.1775093489688;
        Wed, 01 Apr 2026 18:31:29 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([27.4.76.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41b8dsm1091851b3a.34.2026.04.01.18.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:31:29 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: pbonzini@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	"shaikh.kamal" <shaikhkamal2012@gmail.com>
Subject: [PATCH v2 1/1] KVM: x86/xen: Use trylock for fast path event channel delivery
Date: Thu,  2 Apr 2026 07:01:02 +0530
Message-ID: <20260402013102.21951-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ac08V4TaM2yh9SY1@google.com>
References: <ac08V4TaM2yh9SY1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_xen_set_evtchn_fast() acquires gpc->lock with read_lock_irqsave(),
which becomes a sleeping lock on PREEMPT_RT, triggering:

  BUG: sleeping function called from invalid context
  in_hardirq(): 1, in_serving_softirq(): 0
  Call Trace:
   <IRQ>
   rt_spin_lock+0x70/0x130
   kvm_xen_set_evtchn_fast+0x20b/0xa40
   xen_timer_callback+0x91/0x1a0
   __run_hrtimer
   hrtimer_interrupt

when called from hard IRQ context (e.g., hrtimer callback).

The function uses read_lock_irqsave() to access two gpc structures:
shinfo_cache and vcpu_info_cache. On PREEMPT_RT, these rwlocks are
rt_mutex-based and cannot be acquired from hard IRQ context.

Use read_trylock() instead for both gpc lock acquisitions. If either
lock is contended, return -EWOULDBLOCK to trigger the existing slow
path: xen_timer_callback() sets vcpu->arch.xen.timer_pending, kicks
the vCPU with KVM_REQ_UNBLOCK, and the event gets injected from
process context via kvm_xen_inject_timer_irqs().

This approach works on all kernels (RT and non-RT) and preserves the
"fast path" semantics: acquire the lock only if immediately available,
otherwise bail out rather than blocking.

Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
Fixes: 77c9b9dea4fb ("KVM: x86/xen: Use fast path for Xen timer delivery")
Suggested-by: Sean Christopherson <seanjc@google.com>

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 arch/x86/kvm/xen.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d6b2a665b499..479e8f23a9c4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1817,7 +1817,17 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
+	/*
+	 * Use trylock for the "fast" path. If the lock is contended,
+	 * return -EWOULDBLOCK to use the slow path which injects the
+	 * event from process context via timer_pending + KVM_REQ_UNBLOCK.
+	 */
+	local_irq_save(flags);
+	if (!read_trylock(&gpc->lock)) {
+		local_irq_restore(flags);
+		srcu_read_unlock(&kvm->srcu, idx);
+		return -EWOULDBLOCK;
+	}
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
@@ -1848,10 +1858,22 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	} else {
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
+		local_irq_restore(flags);
 		gpc = &vcpu->arch.xen.vcpu_info_cache;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		local_irq_save(flags);
+		if (!read_trylock(&gpc->lock)) {
+			/*
+			 * Lock contended. Set the in-kernel pending flag
+			 * and kick the vCPU to inject via the slow path.
+			 */
+			local_irq_restore(flags);
+			if (!test_and_set_bit(port_word_bit,
+					&vcpu->arch.xen.evtchn_pending_sel))
+				kick_vcpu = true;
+			goto out_kick;
+		}
 		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 			/*
 			 * Could not access the vcpu_info. Set the bit in-kernel
@@ -1885,7 +1907,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	}
 
  out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
+	local_irq_restore(flags);
+
+ out_kick:
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kick_vcpu) {
-- 
2.43.0

