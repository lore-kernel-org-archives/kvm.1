Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817889;
	b=lHkA+XP7+AzedYLYl5IuWPidObA3F8xx3BpYhQPUVHOO+qjK8lKq0mJhTeMpuV6VwPSY
	 XzCOZZuxNdj/Bfw9FnH9Ea9b3kBp9mDsjJDdYzsLpnWtHDapy+cAd2LKyUs3LdZsLEJOn
	 7rqwc85yYe6fgjP6q+0LlyadFZPpgXRz5xRC3l0emL2hSVZx8aGJCMdMBxIj8CH6EgMg8
	 uZ5yGpfcnCffgcZeKS/OucmEbuZhaUkWbGmYmfC2MyZRyRd6LvpdWT+UeLc3R97NLb5BF
	 D+akhr8EBNC+63dE0Q+9POoW18I4MzfnKMAIaGhKOr+C9xYQBdDy308QmDzqrezMcjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e4FD0TnSbqIZHrEuE1RCeadLjVO6riDlZ/NP/w6fhxU=;
	b=V295e3xyjgE8JXfHUn7cafsOKRxzvUNLgILhM3Tk7nggvkYjw51/iqziYY1OrQm/mcv2
	 z3fLwwep8AyogRvggglTpa8r97AAhAB2L3cqQtYEYRKuMDpzNKaZi3tYb0ZkhKSRJUUgT
	 VakeaPRXybE/s5EuHyjnwml6MhJGhVC4uxzwBAfB0K+sMW8uZGwsiJoxMyv8md4YZ8uI/
	 UAEW8Q8a1qGNn8MVuJaoSzcTQQ5jfBa4poa+gA73xO8gA4fa7fx/kU+7r7UADvSgEYcuk
	 YWh2iyB6hj1eaXE37daLseC4Hby0eQPc2viPCfn4ozVsED2bU414JFLqJ7fQQvVLY/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwdYnhcd;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3083606A330
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3083606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gwdYnhcd
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1173352b3a.3
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 00:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794817888; x=1795422688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4FD0TnSbqIZHrEuE1RCeadLjVO6riDlZ/NP/w6fhxU=;
        b=gwdYnhcdcV1kB0DwBjsvppFlBiCRBDLxLbgYRVLRA0HTKVZsBlR7mFuISFBTJdZuYq
         oGXFDaF+LoLxZ+eb2R/ijetdmwmN7gvPRLCF/mC7Uv98BtP+xTg79j5moLo/dDPClkSR
         QaEMUwQi8/coPin2FI0lQaEF839iLAhvowAK8xaVl4ChRb3EdKgMske/aJqn5LVBjBah
         0dQrBDLqHiEw/Shb1dGaLjJEDxFlw4u0/YsPz4hUljkUwTbgflrdgroIm0W61geIV7IH
         hcWuz4HO7aV5/TMo4rsCIIOOTm/2CjJ8k3N9E442hhfHgL+9jZL8dkoIK/pgmRG+N6eD
         Gy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817888; x=1795422688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4FD0TnSbqIZHrEuE1RCeadLjVO6riDlZ/NP/w6fhxU=;
        b=fWtttiM4e4YGJskGOBOfGr5xPB7YBOOOH6Wk3ElJcfXYRgtctxoi6O7IqUX1nM5dqP
         vscAwNoDi6Zbdi7upi5CZ07cDkhsNiJ5wL5G2XpnBEWqLo7pbv7CfnhU5KgUNOd26+uE
         6rjf8u6+bITgXXP0YY9yqgwzX29HozxhDlEuFSXlz4Vg5U9himm3fYE1RW4sBtncLaxI
         MZgz1w5Qj3URhInESu9ZWQGYqH6qYnWFgwm45yJI/Eebkg42Zi6unMQ1GDjvkO7NiS7P
         zYJLz8RsSW/hts5AKNhwPfWnrWd3zi8NdFnOyOPSkvW8cXHsPdfLBHpuTpShXpXEv/jL
         W2kA==
X-Gm-Message-State: APuU4Z/+/K2PHD9EKNFlEXoNPbA20MIuIzQFzFEwY+0GvJF3wBbmK9VM
	l/J9Nb9XJLsMbiO8kprdyZGnHJUqgglMJ6YZNt/kospdYQww5b5/teFf4iDxCztg
X-Gm-Gg: AYBFou2RMcVE/Pn016YZY+wMuOoJ0DyhxQrndg6IzKpDS4GBgtsC8giI2cXuyMcaU35
	piLlZTLCSLiHK+yEVujadFi96MeZJDTFjCMNqglRhgGe2pipzoyy1aNvCf5NGkJCP/LW1VGn6Qb
	VWX5hne5GD76PN4u8ELR8keGvucdIaeVjsNN9uWMx2tPBlUn1XO4g2GwZwFCqkZrQtiMCNstBVM
	3CP4vttBtTL41uM2yeRcHtsqK1/mX8Y8dHjbMxq4DEty/eI/Sd0IcijRSlV+7uir6fEsY8RMKP5
	NtQqzj8sdLZNyI3GMa/Kdyi0HFQ296Q+2KpMHFSRyn9BstB+vo0+X1lIR8RrWEZSRi2RX0T6Z3C
	N+7MP9VOcK2ttFhDmKmwIGrzDIDFYEv73acoxNU8w25NNLXi1oGXs66uYeM2/ycSt3z+3D00oo5
	pXihRCpBKodwLYvHjIFoOKiKBP0Vir3asFCNBvnaKltBs2BB8d4Piiu8V45Ihk93gzcRKHFzJX4
	pKxoHQBWrJAvmtLjDiAX4eeRrof3hiBjKHWx3uimXKDctLqppIoQXNYIM4FVUAW1IaJx82MsTje
	Y4Qu7lNtn76Bnxq+27g3mr+JAOq4QPgirUpvIUso8YsMiWzrw57EPNDQ9INDnE9p+BoJnm2WDpX
	lbVstB6ivuO6MsGh7Rg==
X-Received: by 2002:aa7:9065:0:b0:881:fffd:26ab with SMTP id d2e1a72fcca58-8beb5ab478fmr8538008b3a.24.1794817887856;
        Mon, 16 Nov 2026 00:31:27 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2055031sm3572830b3a.39.2026.11.16.00.31.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:31:27 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 4/4] KVM: Move the halt-polling histograms out of struct kvm_vcpu_stat
Date: Mon, 16 Nov 2026 16:31:16 +0800
Message-ID: <20261116083116.5893-5-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261116083116.5893-1-flyingpeng@tencent.com>
References: <20261116083116.5893-1-flyingpeng@tencent.com>
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
histograms take 768 bytes in every vCPU, out of 1104 bytes of stats on
x86.  Move them into a separately allocated struct kvm_vcpu_stat_ext, and
add kvm.extended_stats (default on) so that it can be skipped.

The descriptors don't change and the extended stats are laid out after
struct kvm_vcpu_stat in the stats data block, so the binary stats ABI is
unchanged; if the block isn't allocated the histograms read as zero.

This shrinks struct kvm_vcpu from 5776 to 5016 bytes, struct vcpu_vmx from
8384 to 7616 bytes and struct vcpu_svm from 6728 to 5968 bytes.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++
 arch/powerpc/kvm/book3s_hv.c                  | 11 ++--
 include/linux/kvm_host.h                      | 24 ++++++--
 include/linux/kvm_types.h                     | 10 +++-
 virt/kvm/binary_stats.c                       | 29 +++++++++-
 virt/kvm/kvm_main.c                           | 58 +++++++++++++++----
 6 files changed, 116 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c1e0f6bf4c24..181f9a920b26 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3159,6 +3159,12 @@ Kernel parameters
 	kvm.enable_vmware_backdoor=[KVM] Support VMware backdoor PV interface.
 				   Default is false (don't support).
 
+	kvm.extended_stats=
+			[KVM] Allocate the extended per-vCPU stats, e.g. the
+			halt-polling histograms.  If disabled, the extended
+			stats are still reported but always read as zero.
+			Default is Y (on).
+
 	kvm.gmem_in_place_conversion=
 			[KVM] Controls whether KVM enables in-place conversion
 			support for guest_memfd and tracks the private/shared
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index f2d9f16c2e44..fc9fba16ce48 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4684,16 +4684,15 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	if (do_sleep) {
 		vc->runner->stat.generic.halt_wait_ns +=
 			ktime_to_ns(cur) - ktime_to_ns(start_wait);
-		KVM_STATS_LOG_HIST_UPDATE(
-				vc->runner->stat.generic.halt_wait_hist,
+		KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vc->runner, halt_wait_hist,
 				ktime_to_ns(cur) - ktime_to_ns(start_wait));
 		/* Attribute failed poll time */
 		if (vc->halt_poll_ns) {
 			vc->runner->stat.generic.halt_poll_fail_ns +=
 				ktime_to_ns(start_wait) -
 				ktime_to_ns(start_poll);
-			KVM_STATS_LOG_HIST_UPDATE(
-				vc->runner->stat.generic.halt_poll_fail_hist,
+			KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vc->runner,
+				halt_poll_fail_hist,
 				ktime_to_ns(start_wait) -
 				ktime_to_ns(start_poll));
 		}
@@ -4703,8 +4702,8 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 			vc->runner->stat.generic.halt_poll_success_ns +=
 				ktime_to_ns(cur) -
 				ktime_to_ns(start_poll);
-			KVM_STATS_LOG_HIST_UPDATE(
-				vc->runner->stat.generic.halt_poll_success_hist,
+			KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vc->runner,
+				halt_poll_success_hist,
 				ktime_to_ns(cur) - ktime_to_ns(start_poll));
 		}
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..fd07a626fdaf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -391,6 +391,7 @@ struct kvm_vcpu {
 	bool scheduled_out;
 	struct kvm_vcpu_arch arch;
 	struct kvm_vcpu_stat stat;
+	struct kvm_vcpu_stat_ext *stat_ext;
 	char stats_id[KVM_STATS_NAME_SIZE];
 	struct kvm_dirty_ring dirty_ring;
 
@@ -2029,7 +2030,15 @@ struct kvm_stat_data {
 	.offset = offsetof(struct kvm_vcpu_stat, stat),			\
 	.name = #stat,							\
 }
-/* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
+/* Extended vCPU stats are laid out after struct kvm_vcpu_stat. */
+#define VCPU_EXT_STATS_DESC(stat, type, unit, base, exp, sz, bsz)	\
+{									\
+	STATS_DESC_COMMON(type, unit, base, exp, sz, bsz),		\
+	.offset = sizeof(struct kvm_vcpu_stat) +			\
+		  offsetof(struct kvm_vcpu_stat_ext, stat),		\
+	.name = #stat,							\
+}
+/* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC, VCPU_EXT */
 #define STATS_DESC(SCOPE, stat, type, unit, base, exp, sz, bsz)		       \
 	SCOPE##_STATS_DESC(stat, type, unit, base, exp, sz, bsz)
 
@@ -2096,17 +2105,18 @@ struct kvm_stat_data {
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_success_ns),	       \
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_ns),		       \
 	STATS_DESC_TIME_NSEC(VCPU_GENERIC, halt_wait_ns),		       \
-	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_poll_success_hist,     \
+	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_EXT, halt_poll_success_hist,	       \
 			HALT_POLL_HIST_COUNT),				       \
-	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_hist,	       \
+	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_EXT, halt_poll_fail_hist,	       \
 			HALT_POLL_HIST_COUNT),				       \
-	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_wait_hist,	       \
+	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_EXT, halt_wait_hist,		       \
 			HALT_POLL_HIST_COUNT),				       \
 	STATS_DESC_IBOOLEAN(VCPU_GENERIC, blocking)
 
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 		       const struct kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
+		       void *stats_ext, size_t size_stats_ext,
 		       char __user *user_buffer, size_t size, loff_t *offset);
 
 /**
@@ -2148,6 +2158,12 @@ static inline void kvm_stats_log_hist_update(u64 *data, size_t size, u64 value)
 #define KVM_STATS_LOG_HIST_UPDATE(array, value)				       \
 	kvm_stats_log_hist_update(array, ARRAY_SIZE(array), value)
 
+#define KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vcpu, hist, value)		       \
+do {									       \
+	if ((vcpu)->stat_ext)						       \
+		KVM_STATS_LOG_HIST_UPDATE((vcpu)->stat_ext->hist, value);      \
+} while (0)
+
 
 extern const struct kvm_stats_header kvm_vm_stats_header;
 extern const struct kvm_stats_desc kvm_vm_stats_desc[];
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..fd7426627928 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -133,10 +133,18 @@ struct kvm_vcpu_stat_generic {
 	u64 halt_poll_success_ns;
 	u64 halt_poll_fail_ns;
 	u64 halt_wait_ns;
+	u64 blocking;
+};
+
+/*
+ * vCPU stats that are too big to embed in every vCPU, e.g. histograms.  They
+ * are allocated only if kvm.extended_stats is enabled, and read as zero
+ * otherwise.
+ */
+struct kvm_vcpu_stat_ext {
 	u64 halt_poll_success_hist[HALT_POLL_HIST_COUNT];
 	u64 halt_poll_fail_hist[HALT_POLL_HIST_COUNT];
 	u64 halt_wait_hist[HALT_POLL_HIST_COUNT];
-	u64 blocking;
 };
 
 #define KVM_STATS_NAME_SIZE	48
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
index 76ce697c773b..c4f8bed1f01d 100644
--- a/virt/kvm/binary_stats.c
+++ b/virt/kvm/binary_stats.c
@@ -19,6 +19,9 @@
  * @desc: start address of an array of stats descriptors for a vm or a vcpu
  * @stats: start address of stats data block for a vm or a vcpu
  * @size_stats: the size of stats data block pointed by @stats
+ * @stats_ext: start address of the extended stats data block, which follows
+ *             the stats data block, or NULL if it isn't allocated
+ * @size_stats_ext: the size of the extended stats data block
  * @user_buffer: start address of userspace buffer
  * @size: requested read size from userspace
  * @offset: the start position from which the content will be read for the
@@ -34,6 +37,9 @@
  * +-------------+
  * | Stats Data  |
  * +-------------+
+ * |  Extended   |
+ * | Stats Data  |
+ * +-------------+
  * Although this function allows userspace to read any amount of data (as long
  * as in the limit) from any position, the typical usage would follow below
  * steps:
@@ -52,6 +58,7 @@
 ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 		       const struct kvm_stats_desc *desc,
 		       void *stats, size_t size_stats,
+		       void *stats_ext, size_t size_stats_ext,
 		       char __user *user_buffer, size_t size, loff_t *offset)
 {
 	ssize_t len;
@@ -66,7 +73,8 @@ ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 	size_header = sizeof(*header);
 	size_desc = header->num_desc * sizeof(*desc);
 
-	len = KVM_STATS_NAME_SIZE + size_header + size_desc + size_stats - pos;
+	len = KVM_STATS_NAME_SIZE + size_header + size_desc + size_stats +
+	      size_stats_ext - pos;
 	len = min(len, remain);
 	if (len <= 0)
 		return 0;
@@ -136,6 +144,25 @@ ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 		src = stats + pos - header->data_offset;
 		if (copy_to_user(dest, src, copylen))
 			return -EFAULT;
+		remain -= copylen;
+		pos += copylen;
+		dest += copylen;
+	}
+
+	/*
+	 * Copy extended kvm stats values, which read as zero if the extended
+	 * stats data block isn't allocated.
+	 */
+	copylen = header->data_offset + size_stats + size_stats_ext - pos;
+	copylen = min(copylen, remain);
+	if (copylen > 0) {
+		if (stats_ext) {
+			src = stats_ext + pos - header->data_offset - size_stats;
+			if (copy_to_user(dest, src, copylen))
+				return -EFAULT;
+		} else if (clear_user(dest, copylen)) {
+			return -EFAULT;
+		}
 		pos += copylen;
 	}
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 54a2924f9b92..210d1f658a21 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -112,6 +112,10 @@ module_param(allow_unsafe_mappings, bool, 0444);
 static bool __ro_after_init per_vm_debugfs = true;
 module_param(per_vm_debugfs, bool, 0444);
 
+/* Allocate the extended vCPU stats, e.g. histograms, see kvm_vcpu_stat_ext. */
+static bool __ro_after_init extended_stats = true;
+module_param(extended_stats, bool, 0444);
+
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 bool __ro_after_init gmem_in_place_conversion = false;
 module_param(gmem_in_place_conversion, bool, 0444);
@@ -493,6 +497,7 @@ static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
 	put_pid(vcpu->pid);
 
 	free_page((unsigned long)vcpu->run);
+	kfree(vcpu->stat_ext);
 	kmem_cache_free(kvm_vcpu_cache, vcpu);
 }
 
@@ -3796,10 +3801,12 @@ static inline void update_halt_poll_stats(struct kvm_vcpu *vcpu, ktime_t start,
 			++vcpu->stat.generic.halt_poll_invalid;
 
 		stats->halt_poll_success_ns += poll_ns;
-		KVM_STATS_LOG_HIST_UPDATE(stats->halt_poll_success_hist, poll_ns);
+		KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vcpu, halt_poll_success_hist,
+						   poll_ns);
 	} else {
 		stats->halt_poll_fail_ns += poll_ns;
-		KVM_STATS_LOG_HIST_UPDATE(stats->halt_poll_fail_hist, poll_ns);
+		KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vcpu, halt_poll_fail_hist,
+						   poll_ns);
 	}
 }
 
@@ -3859,7 +3866,7 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 	if (waited) {
 		vcpu->stat.generic.halt_wait_ns +=
 			ktime_to_ns(cur) - ktime_to_ns(poll_end);
-		KVM_STATS_LOG_HIST_UPDATE(vcpu->stat.generic.halt_wait_hist,
+		KVM_VCPU_STATS_EXT_LOG_HIST_UPDATE(vcpu, halt_wait_hist,
 				ktime_to_ns(cur) - ktime_to_ns(poll_end));
 	}
 out:
@@ -4307,11 +4314,19 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	}
 	vcpu->run = page_address(page);
 
+	if (extended_stats) {
+		vcpu->stat_ext = kzalloc_obj(*vcpu->stat_ext, GFP_KERNEL_ACCOUNT);
+		if (!vcpu->stat_ext) {
+			r = -ENOMEM;
+			goto vcpu_free_run_page;
+		}
+	}
+
 	kvm_vcpu_init(vcpu, kvm, id);
 
 	r = kvm_arch_vcpu_create(vcpu);
 	if (r)
-		goto vcpu_free_run_page;
+		goto vcpu_free_stat_ext;
 
 	if (kvm->dirty_ring_size) {
 		r = kvm_dirty_ring_alloc(kvm, &vcpu->dirty_ring,
@@ -4366,6 +4381,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 	kvm_dirty_ring_free(&vcpu->dirty_ring);
 arch_vcpu_destroy:
 	kvm_arch_vcpu_destroy(vcpu);
+vcpu_free_stat_ext:
+	kfree(vcpu->stat_ext);
 vcpu_free_run_page:
 	free_page((unsigned long)vcpu->run);
 vcpu_free:
@@ -4393,7 +4410,8 @@ static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
 
 	return kvm_stats_read(vcpu->stats_id, &kvm_vcpu_stats_header,
 			&kvm_vcpu_stats_desc[0], &vcpu->stat,
-			sizeof(vcpu->stat), user_buffer, size, offset);
+			sizeof(vcpu->stat), vcpu->stat_ext,
+			sizeof(*vcpu->stat_ext), user_buffer, size, offset);
 }
 
 static int kvm_vcpu_stats_release(struct inode *inode, struct file *file)
@@ -5216,7 +5234,8 @@ static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
 
 	return kvm_stats_read(kvm->stats_id, &kvm_vm_stats_header,
 				&kvm_vm_stats_desc[0], &kvm->stat,
-				sizeof(kvm->stat), user_buffer, size, offset);
+				sizeof(kvm->stat), NULL, 0, user_buffer, size,
+				offset);
 }
 
 static int kvm_vm_stats_release(struct inode *inode, struct file *file)
@@ -6259,15 +6278,30 @@ static int kvm_clear_stat_per_vm(struct kvm *kvm, size_t offset)
 	return 0;
 }
 
+static u64 *kvm_vcpu_stat_ptr(struct kvm_vcpu *vcpu, size_t offset)
+{
+	if (offset < sizeof(vcpu->stat))
+		return (void *)&vcpu->stat + offset;
+
+	if (!vcpu->stat_ext)
+		return NULL;
+
+	return (void *)vcpu->stat_ext + offset - sizeof(vcpu->stat);
+}
+
 static int kvm_get_stat_per_vcpu(struct kvm *kvm, size_t offset, u64 *val)
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
+	u64 *stat;
 
 	*val = 0;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		*val += *(u64 *)((void *)(&vcpu->stat) + offset);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		stat = kvm_vcpu_stat_ptr(vcpu, offset);
+		if (stat)
+			*val += *stat;
+	}
 
 	return 0;
 }
@@ -6276,9 +6310,13 @@ static int kvm_clear_stat_per_vcpu(struct kvm *kvm, size_t offset)
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
+	u64 *stat;
 
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		*(u64 *)((void *)(&vcpu->stat) + offset) = 0;
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		stat = kvm_vcpu_stat_ptr(vcpu, offset);
+		if (stat)
+			*stat = 0;
+	}
 
 	return 0;
 }
-- 
2.43.7

