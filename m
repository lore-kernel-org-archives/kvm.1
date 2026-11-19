Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074513;
	b=KHwUuz0btVEtZmYKBJc1KYyb6H1o8iczdAr9ci14S7kDppoHLtRRhbw1wr1xw3alM0i2
	 Z/W/YpcOV8EjF51wcNlCxAH+cMX3zZuPf29Yk+2xPqvD6oSwAZ/VmXG7ZBtZBnVKnyvaK
	 AY3JuImxf9N2evST8S+WlaGLFWXSEDMgDL+DFAT/33iJdIDl0J4O9lZPvTNcgLwLkYGQH
	 PpWKKEaAF+D9WdFvbHtqf1IGFSZEIAbVX8v4qZ/hzNydGC2IrchPemHsKRVVYT6wnoTzD
	 kfeO74AFFfMZlDzzV4pMVjGtA0OqGPIR1P8rvArgbfXbmBSmElTmY5Bb+VoR5PWGCMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074513;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rhbKilbj1FUsGuogaR9rA79TUtedLUv57kTcPATorNU=;
	b=rc7jEDeLDuWq5aWlJ93ieMblFzUM2M1X+/MPVnv3WQYUmq/C1nQgLxabwaLq/WcjimEm
	 Ve0juFEDedsy/RpOw2hGApJwB6SajTJOoTeElnBwOxfUGO49480Hv0c0kYJRIguOsOPp8
	 EU/gOCN/Qp9gqu5vJFjX1nIpj2S+Re0tOsYIbCo3fVSXW+K2w+2KIVSSATmCMddjLWPY8
	 H70wgLx3zNXN50R5KLLZrjwLptjV740gfVPfgQPfWsi2/EoVM0dzZR2PYaq3IY/E839yr
	 lfACIGtB9E1qLy3OI5V3SbErhROjIoJT54t9Exj1cgKvqv/OrRf9mwudjhYGXyrYAmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pef6v6Y1;
	arc=none smtp.remote-ip=95.215.58.243
Received: from mta1.migadu.com (out-243.mta1.migadu.com [95.215.58.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A84606A326
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A84606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pef6v6Y1
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0GyxFb1qj2Ksztez9USKBrBQrNju7005VYiun8PqpOc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074509; v=1; x=1795679309;
 b=Pef6v6Y1Bk2lT5BcEiVIlReseHh2k/f8OXAoqqVurOsJN5RB5mUg67+kYfhxAWZDeXOFxkkw
 HzwWID86LC2u8oNEsUcKFx+LQh8gfd/cCpXEoPIfJn8rLfziFYSXb1r0W2CKMUvcFWWONcL85pB
 zRtIlqmQdwciHYRk+QtC7mKA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b3a01d6596f9792;
	Thu, 19 Nov 2026 07:48:29 +0000
X-Mizu-Trace-ID: 2b3a01d6596f9792
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-mips@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH v2 5/7] KVM: Fix comments that refer to non-existent identifiers
Date: Thu, 19 Nov 2026 07:47:50 +0000
Message-ID: <20261119074752.1027729-6-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119074752.1027729-1-fuad.tabba@linux.dev>
References: <20261119074752.1027729-1-fuad.tabba@linux.dev>
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

Comments in the generic KVM code and its headers misspell the names of
functions, structures, fields, capabilities, Kconfig symbols and an
object file, or use names that have since changed. Use the current
names.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 include/linux/kvm_dirty_ring.h | 4 ++--
 include/linux/kvm_host.h       | 4 ++--
 include/linux/kvm_irqfd.h      | 4 ++--
 include/uapi/linux/kvm.h       | 2 +-
 virt/kvm/binary_stats.c        | 2 +-
 virt/kvm/eventfd.c             | 2 +-
 virt/kvm/kvm_main.c            | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_dirty_ring.h b/include/linux/kvm_dirty_ring.h
index eb10d87adf7d5..0a5e0fed77997 100644
--- a/include/linux/kvm_dirty_ring.h
+++ b/include/linux/kvm_dirty_ring.h
@@ -29,8 +29,8 @@ struct kvm_dirty_ring {
 
 #ifndef CONFIG_HAVE_KVM_DIRTY_RING
 /*
- * If CONFIG_HAVE_HVM_DIRTY_RING not defined, kvm_dirty_ring.o should
- * not be included as well, so define these nop functions for the arch.
+ * If CONFIG_HAVE_KVM_DIRTY_RING is not defined, dirty_ring.o is not built,
+ * so define these nop functions for the arch.
  */
 static inline u32 kvm_dirty_ring_get_rsvd_entries(struct kvm *kvm)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a8..4b91ef9667703 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -764,7 +764,7 @@ struct kvm {
 	struct mutex slots_lock;
 
 	/*
-	 * Protects the arch-specific fields of struct kvm_memory_slots in
+	 * Protects the arch-specific fields of struct kvm_memory_slot in
 	 * use by the VM. To be used under the slots_lock (above) or in a
 	 * kvm->srcu critical section where acquiring the slots_lock would
 	 * lead to deadlock with the synchronize_srcu in
@@ -802,7 +802,7 @@ struct kvm {
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
 	 * at the beginning of KVM_CREATE_VCPU.  online_vcpus is only
-	 * incremented after storing the kvm_vcpu pointer in vcpus,
+	 * incremented after storing the kvm_vcpu pointer in vcpu_array,
 	 * and is accessed atomically.
 	 */
 	atomic_t online_vcpus;
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index ef8c134ded8a3..bca430a4ae3a8 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -23,13 +23,13 @@
 struct kvm_kernel_irqfd_resampler {
 	struct kvm *kvm;
 	/*
-	 * List of resampling struct _irqfd objects sharing this gsi.
+	 * List of resampling struct kvm_kernel_irqfd objects sharing this gsi.
 	 * RCU list modified under kvm->irqfds.resampler_lock
 	 */
 	struct list_head list;
 	struct kvm_irq_ack_notifier notifier;
 	/*
-	 * Entry in list of kvm->irqfd.resampler_list.  Use for sharing
+	 * Entry in list of kvm->irqfds.resampler_list.  Use for sharing
 	 * resamplers among irqfds on the same gsi.
 	 * RCU list modified under kvm->irqfds.resampler_lock
 	 */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e9..951b891b8ae60 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1459,7 +1459,7 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
-/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT_2 */
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 */
 #define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
 
 /* Available with KVM_CAP_HYPERV_CPUID (vcpu) / KVM_CAP_SYS_HYPERV_CPUID (system) */
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
index 76ce697c773bf..c772fe7be5dd7 100644
--- a/virt/kvm/binary_stats.c
+++ b/virt/kvm/binary_stats.c
@@ -116,7 +116,7 @@ ssize_t kvm_stats_read(char *id, const struct kvm_stats_header *header,
 	 * The descriptors copy would be skipped in the typical case that
 	 * userspace periodically read stats data, since the pos would be
 	 * greater than the end address of descriptors
-	 * (header->header.desc_offset + size_desc) causing copylen <= 0.
+	 * (header->desc_offset + size_desc) causing copylen <= 0.
 	 */
 	copylen = header->desc_offset + size_desc - pos;
 	copylen = min(copylen, remain);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index f43b8b25bc854..81ed20ec0d4a1 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -248,7 +248,7 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 		/*
 		 * Taking irqfds.lock is safe here, as KVM holds a reference to
 		 * the eventfd when registering the irqfd, i.e. this path can't
-		 * be reached while kvm_irqfd_add() is running.
+		 * be reached while kvm_irqfd_register() is running.
 		 */
 		spin_lock_irqsave(&kvm->irqfds.lock, iflags);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f1407..ba8f53ec3d718 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4338,7 +4338,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 
 	/*
 	 * Pairs with smp_rmb() in kvm_get_vcpu.  Store the vcpu
-	 * pointer before kvm->online_vcpu's incremented value.
+	 * pointer before incrementing kvm->online_vcpus.
 	 */
 	smp_wmb();
 	atomic_inc(&kvm->online_vcpus);
-- 
2.47.3

