Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105C42BC42
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105224; cv=none; b=d+9qMBo09Kf3XjIFMIEbU9t+HbJqd8DEfLIz7hGyBN9bw0o5mZX9JVMKVqzGBt4V1VdifwgaUU93OmAGsss6fFPOcNOFVZlmNa8q3LVPKR0cpVKR03VNo9+H7absjkORcWCvOBG4rebpMQhaYa4IKy4Wd4zEzujMkpOpjyggV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105224; c=relaxed/simple;
	bh=8tFAkirRsfy8mrsVPR+9MNCgjYSEr5mfFc20VPN6Rl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epljqOn1e+7rw7vFIRfzXkNiRGB9x2lIC/MX+EcPk6BoD03h7/RI71jfLdjRHtvXLSt75ZMESYMdmXq4Ym4qKR8wQ4RklNhYk9EsAxjZqrLQGYmGoJ37oS19UxybrCI8IUXeLeAYz0Ctrvlav2uWP0ZauXXhDWuIr11yeLdYu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATZaTG1z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATZaTG1z"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so3013605b3a.0
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105172; x=1786709972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=octD+x1xc4tKtjXP6Mo+pV5UMSnNG6oQUe1hiIQzHKM=;
        b=ATZaTG1zxBQnK3FvvgkNCVCNITyfPZhcpIbRhGSE8pS/sqnRVXBKk54DSZ/VPQK3tu
         kFR9T/Yf4spfMNlPHrLnzFqkPhxp58dQcN4SEjbkArl4KkR8JL+2ybPlXeS4V/a5Q8sB
         1Q4SCCxBwSJfd58xfYQovVZtFBJnGOoCgHaCC4EF2A0XrzM5S/l3bsg1sCuWvgEdbzyM
         3h05NkmMCx3A7uclLcsSZkNSZN2xdUQ77xrDRCCbM8Pf75Llt19kZdWiLuvJqNrpvGZh
         sZacGhHrQOggl6rnmivVQprgL5ZQj0FHKV0w50MyODA9uvLVLpqtL5PytHfkUTjzd9/G
         8geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105172; x=1786709972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=octD+x1xc4tKtjXP6Mo+pV5UMSnNG6oQUe1hiIQzHKM=;
        b=j9fVFl24U4S6ARAuu9Hzg9sdDUZrTwOTFzCmtxsVGsJjuK/Z2JCbOOregiiU5bCOlI
         4sQ5q4/NuidSAgw2wx25HG00Ga163+nZ4V7ra3HrJ7IddlLL7cTluEKjy76EI1Hrczeb
         tUJCX5YAAlZ0fZH9MbYh5I2t82V6SNpZdLp7ZSMhnKLs2GeWfzpjztFxUR6F8Rh2vl1X
         OZbv/RvkE8HQasMbfxMkpxJGHoKwNexvgtHht3f9MXdvd3CPOdMa9L+NXV0khjDnRt90
         afM9PzcLqwx8tkLlLEBQRhOGr7r5hAVOGRN8v3FFquivRp0vDwYPQHA40P2zN+NE0dlL
         d5gg==
X-Gm-Message-State: AOJu0YzTrfKzL1VkWG60xc0Cj5FsEH0RynL2VEI0/wKDiz7VIuAQw49C
	f1TgU08aFS6zi6LzcwE3mAFpZ0fASvbi/ajZ1f5YEmYAsV1/aopi8yhz5ELeOQ==
X-Gm-Gg: AR+sD11U1VgjCMfP5X+w5d80Yrv4sLWTEAxA1F90JgcFxgBrnj/bv13K6tzYnk1Ok8Z
	9qfUTK+WBmzcet60HUkRcQ4sW2vdo40LAHTh7oBelNZRMGVIgmiMUkvNNq6+cP9dv/xi8SvRhmH
	IVM1eicBBbifzlr94HzhxFj4JMI6by8FhHQcxFR853ssOfD6+79EIMDmm9o2ySeq6+w9Cw+HFc4
	97BqBN40gmQIvqcethjqdWBYY8vfIp+TjuNVeApwPkFzxtM5ObQU4QFkisBNIA0cbhFW6rdj0ZB
	3n6wriJzlPmUJ8n7wkyLphZ9ftUqhlNizhOsKzLV+Y/+76hHX8MCS7x1tx0MkAUP28wEcLKEYNZ
	3mhHfVqLoQK23QOD0t8drwofzLhVa/A0c7tfcoCFRnhwgVhq4t9KB21UbcbdxxQFeYh0UvAq8K+
	3WUQpSrR9i+pH0SyqA3CWz9WezF62cWIrbSABdtRXf0kRhE+3UoPD0EzhiixI/+F7Wy6WvfV+Cz
	OtrxQKNYVl/c+x5
X-Received: by 2002:a05:6a21:8802:b0:3cb:9bb0:27a2 with SMTP id adf61e73a8af0-3cb9bb028e4mr17191498637.34.1786105172022;
        Fri, 07 Aug 2026 05:19:32 -0700 (PDT)
Received: from volcano99fc-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019c2ddasm7058960c88.7.2026.08.07.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:19:31 -0700 (PDT)
From: sai madhu <suryasaimadhu369@gmail.com>
To: kvm@vger.kernel.org
Cc: dwmw2@infradead.org,
	seanjc@kernel.org,
	pbonzini@redhat.com,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	sai madhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] KVM: x86/xen: Use read_trylock() for GPC locks in hardirq paths
Date: Fri,  7 Aug 2026 17:49:06 +0530
Message-ID: <20260807121906.925704-2-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807121906.925704-1-suryasaimadhu369@gmail.com>
References: <20260807121906.925704-1-suryasaimadhu369@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_xen_set_evtchn_fast() is called from hardirq context (xen timer
callback, kvm_arch_set_irq_inatomic()). On PREEMPT_RT (and under
lockdep), read_lock_irqsave(&gpc->lock) is invalid there because
rwlock_t may sleep.

Switch to read_trylock() and return -EWOULDBLOCK when the lock is
contended or the cache is invalid. xen_timer_callback() already
defers to the slow path (timer_pending + KVM_REQ_UNBLOCK +
kvm_xen_inject_timer_irqs()).

Also fix __kvm_xen_has_interrupt() the same way for atomic callers.

Based on David Woodhouse's upstream series (May 2026, patch 3/7).
Fixes syzbot: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2

Tested-by: sai madhu <suryasaimadhu369@gmail.com>
Signed-off-by: sai madhu <suryasaimadhu369@gmail.com>
---
 arch/x86/kvm/xen.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 694b31c1f..02f30d795 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -697,6 +697,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
+	bool atomic = in_atomic() || !task_is_running(current);
 	unsigned long flags;
 	u8 rc = 0;
 
@@ -713,7 +714,15 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
-	read_lock_irqsave(&gpc->lock, flags);
+	if (atomic) {
+		local_irq_save(flags);
+		if (!read_trylock(&gpc->lock)) {
+			local_irq_restore(flags);
+			return 1;
+		}
+	} else {
+		read_lock_irqsave(&gpc->lock, flags);
+	}
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
 
@@ -725,7 +734,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 		 * and we'll end up getting called again from a context where we *can*
 		 * fault in the page and wait for it.
 		 */
-		if (in_atomic() || !task_is_running(current))
+		if (atomic)
 			return 1;
 
 		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info))) {
@@ -1797,7 +1806,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct kvm_vcpu *vcpu;
 	unsigned long *pending_bits, *mask_bits;
-	unsigned long flags;
 	int port_word_bit;
 	bool kick_vcpu = false;
 	int vcpu_idx, idx, rc;
@@ -1819,9 +1827,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+	if (!read_trylock(&gpc->lock))
 		goto out_rcu;
+	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+		goto out_unlock;
 
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 		struct shared_info *shinfo = gpc->khva;
@@ -1850,11 +1859,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	} else {
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 		gpc = &vcpu->arch.xen.vcpu_info_cache;
 
-		read_lock_irqsave(&gpc->lock, flags);
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+		if (!read_trylock(&gpc->lock)) {
 			/*
 			 * Could not access the vcpu_info. Set the bit in-kernel
 			 * and prod the vCPU to deliver it for itself.
@@ -1863,6 +1871,11 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 				kick_vcpu = true;
 			goto out_rcu;
 		}
+		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+				kick_vcpu = true;
+			goto out_unlock;
+		}
 
 		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 			struct vcpu_info *vcpu_info = gpc->khva;
@@ -1886,8 +1899,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		}
 	}
 
+ out_unlock:
+	read_unlock(&gpc->lock);
  out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kick_vcpu) {
-- 
2.34.1

