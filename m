Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773C3AF640
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584889; cv=none; b=mH6gA4gSGqoMLz4x838uptN4ctkngMJtSBcaaKdUFASKlrEVmyQmVlcJk3K1Ym6NPXwoPd9SvgdaF5mTb2kbjKZiZZ/WeWjSIx4pZxm1n8BCXX72UZWU0pc5zVAwlJGIMPzTl6OO6JBkFGgFHn4kJswQQxuqZ3TuO85O8l+14Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584889; c=relaxed/simple;
	bh=fsIDXAbIYZu+a2glp0ukFJmWMSTlU6ubDK7M83jkY+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0pkC1uYOEpvp5JcVDID3yQyAOWtnddR9gveoRI3q9Q32o+F4J7PfJqt5drlQwHyb7i56ObVcKvDMNMtl7hY2YHAOE++vRsHRtyRIJUEaLwx0UEt7I/J/iSx7nEtVCRSNPRqF7jbnlYG1IKJk0uxD7WU6N8kh4Ont4lWdIr1o6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQ38ogi/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZIpfWkl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQ38ogi/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZIpfWkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775584886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMYuhA38uZpLgzPpLIwAk2pCXc1DGham/nuBdQUx0Xw=;
	b=NQ38ogi/OVeV2N8bwrhlWhwX39mo7qWKI4Vrmf8VXFd+8Fj8on8FquOQjGBMJOtjy8WWiv
	6bJC2PhhTGtbPvpvnE3NRuD3FBTNewU0xXOMyf2TBb0OYaF/u+SGW9L+GfyPmB4iQG67bW
	Wq0VkiO/Lsfw9+NWgcXJth3fQ9NuRrg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-gD5ejJKuNFmmYebaRn7tgg-1; Tue, 07 Apr 2026 14:01:25 -0400
X-MC-Unique: gD5ejJKuNFmmYebaRn7tgg-1
X-Mimecast-MFC-AGG-ID: gD5ejJKuNFmmYebaRn7tgg_1775584884
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1ceb2ddfso5018524f8f.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775584884; x=1776189684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMYuhA38uZpLgzPpLIwAk2pCXc1DGham/nuBdQUx0Xw=;
        b=VZIpfWklRun0WiY5FNV3Cr3qrZBPlQXL68suAmy3GA22rPdeOm5+62z0C+tS5Js62d
         pHGVTObacC2W1I2bzFU1gF/PCcdZhxpqerGJMwwhaFlsoX7IGXhENSN/AbKsSjbn3dDF
         PeUhamUQ0P8krPp7RTBn4RR5xlkAJ8+UpW+VrpdSG0q0401qcp/2PXV5mnr4RwYa1JlR
         67/grM2kj7UdYpMck7tBoHq3Ooqtf5kmfjtnnmhn/WfpvhX4/EGuEqzhnHNW5KoYX/jK
         SCBjQvfw7GzoOerNB4iUFNxh1IH6HNw62ZwbHm2VAs7TWt7SRKpWFeNsXOyFPAvxaKzg
         Nw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584884; x=1776189684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMYuhA38uZpLgzPpLIwAk2pCXc1DGham/nuBdQUx0Xw=;
        b=X5RKls3x3MGtdk70+NbvpmptHx0ybFZOYdobwG+6tT5oo1nXnSPfHf58A1e9qAoRZ7
         0Fwt8tsZ1sy1hZPN3u/tqSNMkP9CoiVtawvvqLpHJ+hTdVFboqYpgvyNetne8LkMJdxW
         i8s5D+z9amjF3iPDWNEquuABoeZ89yGQS4PgUJK+83mPJ999bsNqnYBVZrtFAurPmN9A
         CUpxAp+bjehe8wDCCDWE9gaFTw5j9HK1OzYs+lxxbuDG1yfyT2FQJaDFB8Uqhaxca0+Z
         edP/sydGraw8hPk9Gkd775Q4ClayjvH8ieS8wxVyX5MfDJnC8cDkuseA5KDUXVsE8uEO
         B9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVrI67Pg0MemK25MnJjKmqIjRHfpEqLt8Ftyxqf64c3xjDmH8T5q4UtsEXGU6A+XnRfPGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOxR7xwM+gmqHvc0seQpPElwLGJfIst+uM52A5LSc0hBV3sZt
	uZmd6tLuAGazdG1G7tj/cOTUfbcr9AduCj1FT+2xvgqJ2zdphBTgWDaSBApyb7Iy+XsDyW3xjJQ
	m/5VAZ/YELUAZauKTxVlEHvRuc5+sxUBkayaeEajI5SfXhbfgpNL+tKuyzplC5Q==
X-Gm-Gg: AeBDievbWGO8vHzQTgMctb2NOpB9NVER5ZmV0Gx81kLxSbrJFjBtqpEjW1hruFhPL19
	JJgWSuGwb2biAL4qjFIx7KAWvhSp9A5VWajxCGDbJSKWSsgPmypRGh/YeiethSDwzqbvaN+opYL
	vg3ey3TbC69haCLmajnRodC6f7zuxZkUdIi4GvDxMmdkjniSbV8o+vMUAltRvZNGLWcJ69BJqfF
	jdJfKS95ntuvStQshj1FR+rRI/a+T78c0XXXDOqIIqTTW5FNsm1pA4fTwEcAbzX6EeD5clKaYtT
	T91RgzeeCRbLf4ZKasUIzT50FARbhh2QV95U7Q0CbWnTZ3VNKyahmilekbQZSSI+SCDMhY38I+/
	Tq+DiR7uHtU6tWCNsIed4Bc91uMdBsvYb6VItdw6ix7oRQ+wiUzbLVIUyaK35yHkZX/Nbqla/wf
	4H0852Upqf6Oj6dLdR6QSceRqH
X-Received: by 2002:a5d:5f87:0:b0:43c:ffcc:b682 with SMTP id ffacd0b85a97d-43d292ff296mr26465109f8f.33.1775584883646;
        Tue, 07 Apr 2026 11:01:23 -0700 (PDT)
X-Received: by 2002:a5d:5f87:0:b0:43c:ffcc:b682 with SMTP id ffacd0b85a97d-43d292ff296mr26465033f8f.33.1775584883005;
        Tue, 07 Apr 2026 11:01:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm49857921f8f.27.2026.04.07.11.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:01:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: [PATCH 2/3] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
Date: Tue,  7 Apr 2026 20:01:06 +0200
Message-ID: <20260407180107.1603697-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407180107.1603697-1-pbonzini@redhat.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.

However, usage of symbol_get is mostly deprecated and there are just a
handful of users left.  In the case of VFIO, in particular, the
functions it calls can be made inline.  Start with kvm_get_kvm_safe,
for which it is trivial to do so.

While at it, move the function from kvm_host.h to kvm_types.h.
Unlike e.g. drivers/s390/crypto/vfio_ap_ops.c, there's no need for
VFIO to know any implementation details of KVM, and struct kvm
can be treated as an opaque type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c |  2 +-
 arch/x86/kvm/vmx/nested.h  |  4 ++--
 drivers/vfio/vfio_main.c   |  8 +-------
 include/linux/kvm_host.h   |  8 ++++----
 include/linux/kvm_types.h  | 22 ++++++++++++++++++++++
 virt/kvm/kvm_main.c        | 27 ++++++---------------------
 6 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9c26038f6b77..a88686b5db24 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1136,7 +1136,7 @@ void kvm_tdp_mmu_invalidate_roots(struct kvm *kvm,
 	 * being destroyed in an error path of KVM_CREATE_VM.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING) &&
-	    refcount_read(&kvm->users_count) && kvm->created_vcpus)
+	    refcount_read(&kvm->rc.users_count) && kvm->created_vcpus)
 		lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 213a448104af..2c83fc905698 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -58,7 +58,7 @@ bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+			    !refcount_read(&vcpu->kvm->rc.users_count));
 
 	return to_vmx(vcpu)->nested.cached_vmcs12;
 }
@@ -66,7 +66,7 @@ static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
 static inline struct vmcs12 *get_shadow_vmcs12(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
-			    !refcount_read(&vcpu->kvm->users_count));
+			    !refcount_read(&vcpu->kvm->rc.users_count));
 
 	return to_vmx(vcpu)->nested.cached_shadow_vmcs12;
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index d1bbc42d484a..cb6eaabd64ce 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -436,7 +436,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
 	bool ret;
 
 	lockdep_assert_held(&device->dev_set->lock);
@@ -451,12 +450,7 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struc
 	if (WARN_ON(!pfn))
 		goto out_put_mod;
 
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn))
-		goto out_put_sym;
-
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
+	ret = kvm_get_kvm_safe(kvm);
 	if (!ret)
 		goto out_put_sym;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..5163b541c82d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -767,6 +767,9 @@ struct kvm_memslots {
 };
 
 struct kvm {
+	/* Must be the first field, see function definitions in kvm_types.h.  */
+	struct kvm_refcount rc;
+
 #ifdef KVM_HAVE_MMU_RWLOCK
 	rwlock_t mmu_lock;
 #else
@@ -830,7 +833,6 @@ struct kvm {
 	struct list_head ioeventfds;
 	struct kvm_vm_stat stat;
 	struct kvm_arch arch;
-	refcount_t users_count;
 #ifdef CONFIG_KVM_MMIO
 	struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
 	spinlock_t ring_lock;
@@ -1062,8 +1064,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_get_kvm(struct kvm *kvm);
-bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
@@ -1073,7 +1073,7 @@ static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 	as_id = array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
 	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
 			lockdep_is_held(&kvm->slots_lock) ||
-			!refcount_read(&kvm->users_count));
+			!refcount_read(&kvm->rc.users_count));
 }
 
 static inline struct kvm_memslots *kvm_memslots(struct kvm *kvm)
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..4cb68c71a13c 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -33,6 +33,7 @@
 
 #include <linux/mutex.h>
 #include <linux/spinlock_types.h>
+#include <linux/refcount.h>
 
 struct kvm;
 struct kvm_async_pf;
@@ -140,6 +141,27 @@ struct kvm_vcpu_stat_generic {
 };
 
 #define KVM_STATS_NAME_SIZE	48
+
+struct kvm_refcount {
+	refcount_t users_count;
+};
+
+static inline void kvm_get_kvm(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+	refcount_inc(&rc->users_count);
+}
+
+/*
+ * A safe version of kvm_get_kvm(), making sure the vm is not being destroyed.
+ * Return true if kvm referenced successfully, false otherwise.
+ */
+static inline bool kvm_get_kvm_safe(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+	return refcount_inc_not_zero(&rc->users_count);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..6e3796814da7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1099,7 +1099,7 @@ static inline struct kvm_io_bus *kvm_get_bus_for_destruction(struct kvm *kvm,
 							     enum kvm_bus idx)
 {
 	return rcu_dereference_protected(kvm->buses[idx],
-					 !refcount_read(&kvm->users_count));
+					 !refcount_read(&kvm->rc.users_count));
 }
 
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
@@ -1153,7 +1153,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	if (r)
 		goto out_err_no_irq_routing;
 
-	refcount_set(&kvm->users_count, 1);
+	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
+	refcount_set(&kvm->rc.users_count, 1);
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1223,7 +1224,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 out_err_no_disable:
 	kvm_arch_destroy_vm(kvm);
 out_err_no_arch_destroy_vm:
-	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
+	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->rc.users_count));
 	for (i = 0; i < KVM_NR_BUSES; i++)
 		kfree(kvm_get_bus_for_destruction(kvm, i));
 	kvm_free_irq_routing(kvm);
@@ -1316,25 +1317,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	mmdrop(mm);
 }
 
-void kvm_get_kvm(struct kvm *kvm)
-{
-	refcount_inc(&kvm->users_count);
-}
-EXPORT_SYMBOL_GPL(kvm_get_kvm);
-
-/*
- * Make sure the vm is not during destruction, which is a safe version of
- * kvm_get_kvm().  Return true if kvm referenced successfully, false otherwise.
- */
-bool kvm_get_kvm_safe(struct kvm *kvm)
-{
-	return refcount_inc_not_zero(&kvm->users_count);
-}
-EXPORT_SYMBOL_GPL(kvm_get_kvm_safe);
-
 void kvm_put_kvm(struct kvm *kvm)
 {
-	if (refcount_dec_and_test(&kvm->users_count))
+	if (refcount_dec_and_test(&kvm->rc.users_count))
 		kvm_destroy_vm(kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_put_kvm);
@@ -1348,7 +1333,7 @@ EXPORT_SYMBOL_GPL(kvm_put_kvm);
  */
 void kvm_put_kvm_no_destroy(struct kvm *kvm)
 {
-	WARN_ON(refcount_dec_and_test(&kvm->users_count));
+	WARN_ON(refcount_dec_and_test(&kvm->rc.users_count));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_put_kvm_no_destroy);
 
-- 
2.53.0

