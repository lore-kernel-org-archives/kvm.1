Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074516;
	b=ESFB3Aw7rDcNxZP6zbqX03u00ywiQIu7Al0Mb74ZMX4PNNIa7Xup92MAOX+j97zAlzEp
	 axzIyUfc/JrlsqymLPDqQmhvqxeJNT76XpXzR5IAPMmyJBxVKkRYbL+wN7gJD6iDSltQ3
	 +Dj/81RfO1wJQqvmmr7lFbSLgg/9azimts6s79uWyiwPVh5DQCY1nv5SeJnu/e7noOVdt
	 v5BIeesuF0+KwOXrXxMRD4/0DUAEutk4BUL6YINMH6QJj17vaNXjLS0zjKx5ky6a9ykSX
	 Ql0TYNKq/j3UIPX7RKIqxpZZpFJB4jH81kdl408uBNzJW5uzHUBUxCyuDzYJ0eSjdfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074516;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9OvsCez/mnUZbbAv1gDuv9Tvo74rOa+eY/frI5444/g=;
	b=gfawnZO13yTHdebNaB+NCDe8Hb0hDowPZtnYt+eZVR7g7jPKU6AA8Jmyls0C7ps8NzMg
	 Sq4Mu65U/hCK5W35Q1vvNyU5S2MW8xcMkpR2bO8FGJOEoULiy4F9QujTet9skiPy+mwJH
	 48+WMf6sCGettfwTgoDu7VDpRGKwiCkYU+Txp5CPJRHAdCTgoDLlD7xEE3yv3+PAETNOx
	 UkvWu/6OrCE/aFt3XZQBSjZiCOWaw9TSo9YNKbD9SJ1emgH0CPUEf22BjqUgaOlV7rUj2
	 0+Ij0G/545rEx8U2AGSV7hk2oR8fLuVnu5re6/N4B/Sey+X49LeiGtIXUur+HkYyPvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GCERgFzj;
	arc=none smtp.remote-ip=95.215.58.7
Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3F4606A338
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3F4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GCERgFzj
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BMRLbfDwuPynqr9aeLbnM0FT6gjc5bIdUFfFRqSKRNg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074512; v=1; x=1795679312;
 b=GCERgFzjrOpzHa5cZ1WWUCE3XnLGDZPocNCttbYlXdkBomCGWKY67w6LqFrFAjRT8An8EGvw
 JKtvjpSgQhklJ3uPxdzgP4EsS+DY1X/PEuekCguPMJtKQjic3HatENtO1/3jKWuF8u4f/M+iNyl
 n+P4kId3+dvNbb3yVdkysj3s=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6230fe79aa9c22c7;
	Thu, 19 Nov 2026 07:48:31 +0000
X-Mizu-Trace-ID: 6230fe79aa9c22c7
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
Subject: [PATCH v2 7/7] KVM: Fix typos in comments
Date: Thu, 19 Nov 2026 07:47:52 +0000
Message-ID: <20261119074752.1027729-8-fuad.tabba@linux.dev>
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

Fix typos in comments in the generic KVM code and in the KVM uAPI
header.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 include/linux/kvm_host.h | 10 +++++-----
 include/uapi/linux/kvm.h |  8 ++++----
 virt/kvm/binary_stats.c  |  2 +-
 virt/kvm/eventfd.c       |  2 +-
 virt/kvm/guest_memfd.c   |  2 +-
 virt/kvm/kvm_main.c      |  6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 21207d234618a..ccc1637a4eb08 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -105,7 +105,7 @@
 #define KVM_PFN_ERR_NEEDS_IO	(KVM_PFN_ERR_MASK + 4)
 
 /*
- * error pfns indicate that the gfn is in slot but faild to
+ * error pfns indicate that the gfn is in slot but failed to
  * translate it to pfn on host.
  */
 static inline bool is_error_pfn(kvm_pfn_t pfn)
@@ -174,7 +174,7 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 #define KVM_REQUEST_ARCH_BASE		8
 
 /*
- * KVM_REQ_OUTSIDE_GUEST_MODE exists is purely as way to force the vCPU to
+ * KVM_REQ_OUTSIDE_GUEST_MODE exists purely as a way to force the vCPU to
  * OUTSIDE_GUEST_MODE.  KVM_REQ_OUTSIDE_GUEST_MODE differs from a vCPU "kick"
  * in that it ensures the vCPU has reached OUTSIDE_GUEST_MODE before continuing
  * on.  A kick only guarantees that the vCPU is on its way out, e.g. a previous
@@ -2185,7 +2185,7 @@ static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
 	 * If mmu_invalidate_in_progress is non-zero, then the range maintained
 	 * by kvm_mmu_notifier_invalidate_range_start contains all addresses
 	 * that might be being invalidated. Note that it may include some false
-	 * positives, due to shortcuts when handing concurrent invalidations.
+	 * positives, due to shortcuts when handling concurrent invalidations.
 	 */
 	if (unlikely(kvm->mmu_invalidate_in_progress)) {
 		/*
@@ -2471,7 +2471,7 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 
 #ifdef __KVM_HAVE_INVALID_WAKEUPS
-/* If we wakeup during the poll time, was it a sucessful poll? */
+/* If we wakeup during the poll time, was it a successful poll? */
 static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
 	return vcpu->valid_wakeup;
@@ -2526,7 +2526,7 @@ static inline int kvm_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 
 /*
  * If more than one page is being (un)accounted, @virt must be the address of
- * the first page of a block of pages what were allocated together (i.e
+ * the first page of a block of pages that were allocated together (i.e.
  * accounted together).
  *
  * kvm_account_pgtable_pages() is thread-safe because mod_lruvec_page_state()
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 951b891b8ae60..79bd6f5416e72 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -508,7 +508,7 @@ struct kvm_run {
 	/*
 	 * shared registers between kvm and userspace.
 	 * kvm_valid_regs specifies the register classes set by the host
-	 * kvm_dirty_regs specified the register classes dirtied by userspace
+	 * kvm_dirty_regs specifies the register classes dirtied by userspace
 	 * struct kvm_sync_regs is architecture specific, as well as the
 	 * bits for kvm_valid_regs and kvm_dirty_regs
 	 */
@@ -698,7 +698,7 @@ struct kvm_enable_cap {
 /*
  * On arm64, machine type can be used to request the physical
  * address size for the VM. Bits[7-0] are reserved for the guest
- * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
+ * PA size shift (i.e., log2(PA_Size)). For backward compatibility,
  * value 0 implies the default IPA size, 40bits.
  */
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
@@ -1556,12 +1556,12 @@ struct kvm_dirty_gfn {
  * @flags: Some extra information for header, always 0 for now.
  * @name_size: The size in bytes of the memory which contains statistics
  *             name string including trailing '\0'. The memory is allocated
- *             at the send of statistics descriptor.
+ *             at the end of statistics descriptor.
  * @num_desc: The number of statistics the vm or vcpu has.
  * @id_offset: The offset of the vm/vcpu stats' id string in the file pointed
  *             by vm/vcpu stats fd.
  * @desc_offset: The offset of the vm/vcpu stats' descriptor block in the file
- *               pointd by vm/vcpu stats fd.
+ *               pointed by vm/vcpu stats fd.
  * @data_offset: The offset of the vm/vcpu stats' data block in the file
  *               pointed by vm/vcpu stats fd.
  *
diff --git a/virt/kvm/binary_stats.c b/virt/kvm/binary_stats.c
index c772fe7be5dd7..654381d22480f 100644
--- a/virt/kvm/binary_stats.c
+++ b/virt/kvm/binary_stats.c
@@ -22,7 +22,7 @@
  * @user_buffer: start address of userspace buffer
  * @size: requested read size from userspace
  * @offset: the start position from which the content will be read for the
- *          corresponding vm or vcp file descriptor
+ *          corresponding vm or vcpu file descriptor
  *
  * The file content of a vm/vcpu file descriptor is now defined as below:
  * +-------------+
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 81ed20ec0d4a1..73db4938d5a11 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -470,7 +470,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 
 	/*
 	 * Register the irqfd with the eventfd by polling on the eventfd, and
-	 * simultaneously and the irqfd to KVM's list.  If there was en event
+	 * simultaneously add the irqfd to KVM's list.  If there was an event
 	 * pending on the eventfd prior to registering, manually trigger IRQ
 	 * injection.
 	 */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8c97a69b16dc0..3e02acf889396 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -376,7 +376,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 *  CPU0				CPU1
 	 *  kvm_gmem_get_pfn()
 	 *    slot->gmem.file == A
-	 *					kvm_gmem_release())
+	 *					kvm_gmem_release()
 	 *					  slot->gmem.file = NULL
 	 *
 	 *					kvm_set_memory_region()
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ba8f53ec3d718..65dc9d3eb8448 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1628,7 +1628,7 @@ static void kvm_swap_active_memslots(struct kvm *kvm, int as_id)
 {
 	struct kvm_memslots *slots = kvm_get_inactive_memslots(kvm, as_id);
 
-	/* Grab the generation from the activate memslots. */
+	/* Grab the generation from the active memslots. */
 	u64 gen = __kvm_memslots(kvm, as_id)->generation;
 
 	WARN_ON(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS);
@@ -3044,7 +3044,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	/*
 	 * Remapped memory cannot be pinned in any meaningful sense.  Bail if
 	 * the caller wants to pin the page, i.e. access the page outside of
-	 * MMU notifier protection, and unsafe umappings are disallowed.
+	 * MMU notifier protection, and unsafe mappings are disallowed.
 	 */
 	if (kfp->pin && !allow_unsafe_mappings)
 		return -EINVAL;
@@ -4044,7 +4044,7 @@ static bool vcpu_dy_runnable(struct kvm_vcpu *vcpu)
 /*
  * By default, simply query the target vCPU's current mode when checking if a
  * vCPU was preempted in kernel mode.  All architectures except x86 (or more
- * specifical, except VMX) allow querying whether or not a vCPU is in kernel
+ * specifically, except VMX) allow querying whether or not a vCPU is in kernel
  * mode even if the vCPU is NOT loaded, i.e. using kvm_arch_vcpu_in_kernel()
  * directly for cross-vCPU checks is functionally correct and accurate.
  */
-- 
2.47.3

