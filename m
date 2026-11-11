Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362092;
	b=s2vu2M+uC8LkARGR3aJkSxCX9765hjlYUG6yDXeYA7R3i+dEttZRBrgVT9ZH/mM2dDFG
	 orbr9bi1uaegJkTp8J05ODngjQw8InatLVDl16u6FBi8HDX8zwDy4PjftnyaInKfqCrP5
	 rh2PSvQ/KVG7zHyVZQ4fOCgMr8ExC5zkl6MrwFLnCI9cRGZgJDZe2FvWL/HFiIFoWfMfQ
	 CfKaFwfXxuk+Tz71ls9TSQWT+w13lAQSDhwMyikw8ynKwgbVOluQ8FA8wcAbnASgiGlqt
	 zMqjdTYvdcox9DVQWLZYKOEgdD9U1TBgpU10CuUVa0faXq/1KEujBmWEZBUK3gfbqVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k7+rctivAQtYkLHuZqX5HCvrX9Yyde7ANU70Ujw6ljI=;
	b=Tj9f/0bDKcgGAQjxYulCEgybArU7S05gKHGqjNipyWCbephuvtr/HpcMXBzD5qmKWGgb
	 Lj3DV1pMTKDqH9Fe32JfK85R85HXnnX0y+QzQRK8SL+IqCV+yHmTbNvwkr2nCpdYnzDds
	 VqKIb/qHITEe0+BjwyGUhExTRYYZF5uCNRd6iIdrTjUpMxxaFRgMyL70zV/EYv8xSqX7T
	 HjDyB/Fs/ncbm3RbNaK645lo1TWIgsdhKxlor9uaoh3oftvoYMLjz3C8/VbuQ/dctU7Zc
	 Z3Y075tX/LWd8gjf3S9kir1/pqnxld9T5DJ+zFq7Fu5ZQhGCDT9ddHiHfKLWsdLHNuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OU7t3zhh;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54D606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 01:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD54D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OU7t3zhh
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1458511b3a.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794362091; x=1794966891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7+rctivAQtYkLHuZqX5HCvrX9Yyde7ANU70Ujw6ljI=;
        b=OU7t3zhhehW8LHRPAcKWIggLgNKkLVf3RYwEVrpMuRzuwbaMUGfSqI+JN5Q5lvcq/F
         OvTXkaQLG0A6PeHcpd8p27ZzBF8dUAnhSd1YpJibwRRmugZ1p2QsrD+EvTsSfFCeL37z
         G67Na9eBYh7JES+DMNfImTGHRXyqCFjxJffXma/y1tD79kEKLeyTLMY2Yo5ycCpPoEFV
         hMIhrs80f3EsNfvtITiEoI+Iay+gqjDGdoV80kVsh2twWFbRMLwp7hpAUyNCcnCJnhSR
         s/gO4l6GcIaJo1oHWiHh0QzZpVAcbUb4TfthZvdghVx6v269POOKSQ7L3Jh43hJ8Ob1w
         4+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362091; x=1794966891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7+rctivAQtYkLHuZqX5HCvrX9Yyde7ANU70Ujw6ljI=;
        b=QJhGelYfAi+3QjJ0Pv/2LQHLBhU9ak+mYH4efGSocnB2D3VVlQExmI48PodDucgpRK
         hZB6ZjQhHGPRkNPZG2bV/HSi+pd7Lca/tgTtZnymrPq95+UJgMhWULvTRzs3dz+0RGZz
         UaAcI2mou6hq/KM/+lT02NPc5Smudot8reK4JyZOqDKowX7gtOBuX+KI4Vpeh+9smQNN
         QM5eU5V9bWYkjXZAASHNj9sKjP8/aDHHwM62qphXz0ceIRL8cCRf8opIx4jhzvBbae/R
         E1xdPUQxvnbqwSI1hRXEFGpr8/K/nJ4VamAKHtP0+GfF1VJZsm0tjilv2t5UGVcVwcB/
         XP/Q==
X-Gm-Message-State: APuU4Z/rJLu3wk9n2LCYvPTdns4DywV2Ba2jIME1CMKP2qI/vY3wCFx/
	AJGdfs/reH6UI4kaMDp4bZuo3xUCpqq3gWTfVWVlhedLeq9eltvl9vEcJB42kQ==
X-Gm-Gg: AYBFou3IDX7WIcE/E8P9yahHmd83XqtoStpHacH7Z9thpdQkZg9ynDrtH0vLOgylaHT
	kB2cPgosEHKitNWqeL0cpVktbhixDICmqwGdPInaOPFp/SlIH0bQFlqeTwQMFKtkmWls9NAmtGS
	mqIIlMGeZ1AqVWgcPPxej6tkz3xBp0MAspU6pE87zkjSQ6PH0hx30pY7qqDh+CC7s6M0HN+uV98
	UY81CEQFNvccQJaOJ1/CPEbWAcmVzElQC2KBiu9O2SC37n3RtFxjcrJuU05N2lBGlKVx7cnAhTz
	yB4V87pgqE8YgTGeDsE4wb6Lq7UF3pX9vOu+bFk2SSVWkfXuI2dsM27U4lyEl7FdDAXrhVMH/r3
	pUdTKoVd879pzCNk7XyAwRyxCTp8QcRqAxfqcW+roZfZbm8oDsIlhkVh5Au++i6PXIkSyhsg/sG
	JuxOD47mM0Tcs3nHbSXvLwmidbOyIitGtPd5pvZnpTwlms8y6rpgzvPt5lO4xqE60Xy9X9bMmrD
	ery9QEYHsr7DNCq9WVobNYmhXoQuSvM0Bmo6o/BJGLuFJULEkORsufyujUnVosPkOnBbMMJh1Xa
	4pVWtxn/7TN9tmAv56Eb7+wgdaSwypLv/0pwKiiXN4WG9gKXsQi7c0J4eRkRqR6vnmPfaziS
X-Received: by 2002:a05:6a21:a0a:b0:3eb:2f53:bdc6 with SMTP id adf61e73a8af0-3f2fca9f30fmr1021395637.23.1794362091122;
        Tue, 10 Nov 2026 17:54:51 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db31cafsm2073710a91.3.2026.11.10.17.54.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:54:50 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: Add Kconfig to compile out the halt-polling histograms
Date: Wed, 11 Nov 2026 09:54:46 +0800
Message-ID: <20261111015446.20577-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The halt_poll_success_hist, halt_poll_fail_hist and halt_wait_hist
histograms in struct kvm_vcpu_stat_generic take 768 bytes in every vCPU.
Add CONFIG_KVM_HALT_POLL_HISTOGRAMS (default y) so that they can be
compiled out.

With it disabled, this shrinks struct kvm_vcpu from 5776 to 5008 bytes,
struct vcpu_vmx from 8384 to 7616 bytes and struct vcpu_svm from 6728 to
5960 bytes.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/powerpc/kvm/book3s_hv.c | 20 ++++++++++----------
 include/linux/kvm_host.h     | 23 +++++++++++++++++------
 include/linux/kvm_types.h    |  2 ++
 virt/kvm/Kconfig             | 11 +++++++++++
 virt/kvm/kvm_main.c          |  8 ++++----
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f2d9f16c2e44..0e271e14a204 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4684,18 +4684,18 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	if (do_sleep) {
 		vc->runner->stat.generic.halt_wait_ns +=
 			ktime_to_ns(cur) - ktime_to_ns(start_wait);
-		KVM_STATS_LOG_HIST_UPDATE(
-				vc->runner->stat.generic.halt_wait_hist,
-				ktime_to_ns(cur) - ktime_to_ns(start_wait));
+		KVM_STATS_HALT_HIST_UPDATE(&vc->runner->stat.generic,
+					   halt_wait_hist,
+					   ktime_to_ns(cur) - ktime_to_ns(start_wait));
 		/* Attribute failed poll time */
 		if (vc->halt_poll_ns) {
 			vc->runner->stat.generic.halt_poll_fail_ns +=
 				ktime_to_ns(start_wait) -
 				ktime_to_ns(start_poll);
-			KVM_STATS_LOG_HIST_UPDATE(
-				vc->runner->stat.generic.halt_poll_fail_hist,
-				ktime_to_ns(start_wait) -
-				ktime_to_ns(start_poll));
+			KVM_STATS_HALT_HIST_UPDATE(&vc->runner->stat.generic,
+						   halt_poll_fail_hist,
+						   ktime_to_ns(start_wait) -
+						   ktime_to_ns(start_poll));
 		}
 	} else {
 		/* Attribute successful poll time */
@@ -4703,9 +4703,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 			vc->runner->stat.generic.halt_poll_success_ns +=
 				ktime_to_ns(cur) -
 				ktime_to_ns(start_poll);
-			KVM_STATS_LOG_HIST_UPDATE(
-				vc->runner->stat.generic.halt_poll_success_hist,
-				ktime_to_ns(cur) - ktime_to_ns(start_poll));
+			KVM_STATS_HALT_HIST_UPDATE(&vc->runner->stat.generic,
+						   halt_poll_success_hist,
+						   ktime_to_ns(cur) - ktime_to_ns(start_poll));
 		}
 	}
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..15a310eb7487 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2088,6 +2088,13 @@ struct kvm_stat_data {
 	STATS_DESC_COUNTER(VM_GENERIC, remote_tlb_flush),		       \
 	STATS_DESC_COUNTER(VM_GENERIC, remote_tlb_flush_requests)
 
+#ifdef CONFIG_KVM_HALT_POLL_HISTOGRAMS
+#define STATS_DESC_HALT_POLL_HIST(name)					       \
+	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, name, HALT_POLL_HIST_COUNT),
+#else
+#define STATS_DESC_HALT_POLL_HIST(name)
+#endif
+
 #define KVM_GENERIC_VCPU_STATS()					       \
 	STATS_DESC_COUNTER(VCPU_GENERIC, halt_successful_poll),		       \
 	STATS_DESC_COUNTER(VCPU_GENERIC, halt_attempted_poll),		       \
@@ -2096,12 +2103,9 @@ struct kvm_stat_data {
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_success_ns),	       \
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_ns),		       \
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_wait_ns),		       \
-	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_poll_success_hist,     \
-			HALT_POLL_HIST_COUNT),				       \
-	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_hist,	       \
-			HALT_POLL_HIST_COUNT),				       \
-	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_wait_hist,	       \
-			HALT_POLL_HIST_COUNT),				       \
+	STATS_DESC_HALT_POLL_HIST(halt_poll_success_hist)		       \
+	STATS_DESC_HALT_POLL_HIST(halt_poll_fail_hist)			       \
+	STATS_DESC_HALT_POLL_HIST(halt_wait_hist)			       \
 	STATS_DESC_IBOOLEAN(VCPU_GENERIC, blocking)
 
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
@@ -2148,6 +2152,13 @@ static inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value)
 #define KVM_STATS_LOG_HIST_UPDATE(array, value)				       \
 	kvm_stats_log_hist_update(array, ARRAY_SIZE(array), value)
 
+#ifdef CONFIG_KVM_HALT_POLL_HISTOGRAMS
+#define KVM_STATS_HALT_HIST_UPDATE(stats, hist, value)			       \
+	KVM_STATS_LOG_HIST_UPDATE((stats)->hist, value)
+#else
+#define KVM_STATS_HALT_HIST_UPDATE(stats, hist, value)
+#endif
+
 
 extern const struct kvm_stats_header kvm_vm_stats_header;
 extern const struct kvm_stats_desc kvm_vm_stats_desc[];
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..d79ef87e22c4 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -133,9 +133,11 @@ struct kvm_vcpu_stat_generic {
 	u64 halt_poll_success_ns;
 	u64 halt_poll_fail_ns;
 	u64 halt_wait_ns;
+#ifdef CONFIG_KVM_HALT_POLL_HISTOGRAMS
 	u64 halt_poll_success_hist[HALT_POLL_HIST_COUNT];
 	u64 halt_poll_fail_hist[HALT_POLL_HIST_COUNT];
 	u64 halt_wait_hist[HALT_POLL_HIST_COUNT];
+#endif
 	u64 blocking;
 };
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 99c9969e77a4..2be6530d9b4b 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -40,6 +40,17 @@ config NEED_KVM_DIRTY_RING_WITH_BITMAP
 	bool
 	depends on HAVE_KVM_DIRTY_RING
 
+config KVM_HALT_POLL_HISTOGRAMS
+       bool "Halt-polling histograms in vCPU statistics" if EXPERT
+       depends on KVM_COMMON
+       default y
+       help
+         Provide the halt_poll_success_hist, halt_poll_fail_hist and
+         halt_wait_hist logarithmic histograms in the per-vCPU binary
+         statistics.  The histograms take 768 bytes in every vCPU.
+
+         If unsure, say Y.
+
 config KVM_ASYNC_PF
        bool
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..e8f5ee422493 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3788,10 +3788,10 @@ static inline void update_halt_poll_stats(struct kvm_vcpu *vcpu, ktime_t start,
 			++vcpu->stat.generic.halt_poll_invalid;
 
 		stats->halt_poll_success_ns += poll_ns;
-		KVM_STATS_LOG_HIST_UPDATE(stats->halt_poll_success_hist, poll_ns);
+		KVM_STATS_HALT_HIST_UPDATE(stats, halt_poll_success_hist, poll_ns);
 	} else {
 		stats->halt_poll_fail_ns += poll_ns;
-		KVM_STATS_LOG_HIST_UPDATE(stats->halt_poll_fail_hist, poll_ns);
+		KVM_STATS_HALT_HIST_UPDATE(stats, halt_poll_fail_hist, poll_ns);
 	}
 }
 
@@ -3851,8 +3851,8 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 	if (waited) {
 		vcpu->stat.generic.halt_wait_ns +=
 			ktime_to_ns(cur) - ktime_to_ns(poll_end);
-		KVM_STATS_LOG_HIST_UPDATE(vcpu->stat.generic.halt_wait_hist,
-				ktime_to_ns(cur) - ktime_to_ns(poll_end));
+		KVM_STATS_HALT_HIST_UPDATE(&vcpu->stat.generic, halt_wait_hist,
+					   ktime_to_ns(cur) - ktime_to_ns(poll_end));
 	}
 out:
 	/* The total time the vCPU was "halted", including polling time. */
-- 
2.43.7

