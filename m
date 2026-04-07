Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D13431E6
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584894; cv=none; b=iMpV56QD33lXgQ4tdAWdXj9cswweNzK1D6nNaCDL/cBfIo/5VPjFLmPA3cwYlZoy7/+RlNOYLK85CFKss7Rqi7Vdaws1ANOOY9rVMGPFxuuaUE7byu/tDXx6W74VikjC1vW0P/FtcuwVPwg+3hRK3oP/JpRYoZl/9eBRxVHWaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584894; c=relaxed/simple;
	bh=bgGqLOGrvDnNuaZb+/+HyfYImZod2w+FVuoRIUn/uPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcfU6CEgX7TUZ7UcT4ReMZLGARi9+XE3NN0+q678+/Suaec/DNmdrxmNLaGUEBXUXr8Yl9ICvol2avuxoamnVI4aSJlsCzksfbGbQV1kcUfmbStjFc0wUkWF++56r6LXjTaG+in2zSCSvlDBzCLJq7sPXxOkUy7yCY82ELRFRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UefrZJt1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYNwF0sn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UefrZJt1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYNwF0sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775584891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ptoacRRqyfrvyJsuaTHTOJB1Wd2nT72S8Ib9SDoAls=;
	b=UefrZJt1W5Klz6ywStH2w9nh+2r3G6W7nI+Ao+tMS8I/dV8Bg6r3UaatKkB5OzSA3LMafy
	TsevYDETpJQsEIVspjmOFDj2oaqKhCwUaAiih6qxxegdSAvFeBn0gEvylFHtlsk4LkcTao
	K3zq/R8EMDLwLYizq7OyLSJP/kFs5Ds=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-WM86X3taNxScFAnhFCggQg-1; Tue, 07 Apr 2026 14:01:29 -0400
X-MC-Unique: WM86X3taNxScFAnhFCggQg-1
X-Mimecast-MFC-AGG-ID: WM86X3taNxScFAnhFCggQg_1775584887
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488ba2919b9so9418925e9.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775584887; x=1776189687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ptoacRRqyfrvyJsuaTHTOJB1Wd2nT72S8Ib9SDoAls=;
        b=bYNwF0snhzSaAEmTcxC3PpAR8V9J94jiAVrMVwCTLWmrj35ZrsPkfBd/xO3dbYa7fg
         t/J1M8Xkn+YpHdnG58F/EhbX4P+wpiAtdQknnpFMpKOgbWuttq09gS0EVQYNA8A/fpuC
         W8XW46v8bNspzphvILPPC0zV/lxU8dywXv/RzfhaN4Gc2GatWHMzMw9n6FpBPn+8ckll
         2GHehlzRdw4JVbN08AFldxMmhm/8/zySoVGqw3q+TNevktmNq0NDYdvTHrUmhVKqhANk
         ckcoyzG81DhJ8g/7szgckwZEFJWwdT3X7xWd59Vv1QJ5KYDHkfu+jqlU5usRHjrd/fSp
         TS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584887; x=1776189687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ptoacRRqyfrvyJsuaTHTOJB1Wd2nT72S8Ib9SDoAls=;
        b=T2EM7L3JYmMfdt/dQ3ChJ0b1io/owa5/X2wvhLvLfh3JhWNoV4yh3zFOcGoK+rL+Wg
         wDtaEzDw44EFRJDi43c64eDp+NeYOF30WM7xjGbQggRp1cembe1h1gffoG2vzhpJsecO
         iHTRhTF2Isr9GZAM9HK6lT1bY6u9+Gk/uE8PAREf0CHj6BVOdQk6kuayndEFbWkAcaVq
         5OWZDl18Lg93O6WBcDucsvNHCZWlSgd8UwoGosJuYSGWdQQ6kThk96IefjlYw7WF1RnB
         YgvB8vVc6n9r0ImWy2dPsTsKuxikozGdwQx3v+ymgUao4bfTfhOPwkiaHGBim91fo7UE
         tGUg==
X-Forwarded-Encrypted: i=1; AJvYcCXASBklk0MrsipLpZblausvHbnboCEwJufmW6NLrUVipPMZre9XBP/46eWbrgqQA6ogXu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXVSqPz80vhE+JXPv/2auCoPsmbc+MNgxyeKa/MoJopAnkNhj
	frgvfzNgfN6f7FA45NoJyJLDRhPSEULJxQ7NiU+3kn7KVqckVhcI+j4oz4FZ38o4bPuEtdkZp8V
	OC6B4gyAgGKy0HHvB5JXHcp4oZDFDIlU/okuVD+kA932myrjr+RYIFGmWng2v7g==
X-Gm-Gg: AeBDies29iZ0ZDvAElva54ii4NuPuvKKFhT/wxgvs308CapZWq+ED7rmIprVzIjAn0d
	FtrnhvRLteVNTlUAtz/AuMsMjSUUZ7auvwnxRUGf6clYVKyQ/STrWrKFn1iZRv13eQyZZlJvcQc
	9aRt7A7va5bg9S6IzIZ8QfAnOZ9QXS7zndCjjt/h2XGPHFaKA0s4y0YplMEJIMi7828s5ZiZM+3
	7iHli1olijjfhSo48dxM5ZGVGcbQDm1bCNGnG4o7t1OFJg5bZD8gwRsTk9AJtESMJbL7dVsDneo
	uMWrZEYi9i7hQaS3QBErMnOIvDvJgXg202EDjeB5fxFWAJJBt5USp1ar9Q1E1TGe/rreCNXJXxU
	iEBYTTvbKyXDD7n5TEk1rgHr1ihViylTkymIxfZK64p36WCP7yeJiCJ4o7Slk41/dnTYkYUh/z5
	1Y0+GmpWclWwXt6vy0WLqPQGnw
X-Received: by 2002:a05:600c:4743:b0:487:219e:42d with SMTP id 5b1f17b1804b1-4889970642emr252137535e9.11.1775584886504;
        Tue, 07 Apr 2026 11:01:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:487:219e:42d with SMTP id 5b1f17b1804b1-4889970642emr252137205e9.11.1775584886036;
        Tue, 07 Apr 2026 11:01:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a8ddfde7sm443698845e9.5.2026.04.07.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:01:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: [PATCH 3/3] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Date: Tue,  7 Apr 2026 20:01:07 +0200
Message-ID: <20260407180107.1603697-4-pbonzini@redhat.com>
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

The remaining use in VFIO is for kvm_put_kvm, which is not inline
because it needs to call kvm_destroy_vm.  However, storing the
address of kvm_destroy_vm in the "struct kvm" is enough to remove
the dependency from VFIO.

This also makes it possible to direct kvm_put_kvm to either the arm64
or the s390 implementation of kvm_destroy_vm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/vfio/vfio_main.c  | 24 +++---------------------
 include/linux/kvm_host.h  |  1 -
 include/linux/kvm_types.h |  8 ++++++++
 include/linux/vfio.h      |  1 -
 virt/kvm/kvm_main.c       |  9 ++-------
 5 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index cb6eaabd64ce..f27a1d00c21e 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -17,7 +17,7 @@
 #include <linux/idr.h>
 #include <linux/iommu.h>
 #if IS_ENABLED(CONFIG_KVM)
-#include <linux/kvm_host.h>
+#include <linux/kvm_types.h>
 #endif
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -435,9 +435,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 #if IS_ENABLED(CONFIG_KVM)
 void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!kvm)
@@ -446,21 +443,13 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struc
 	if (!try_module_get(kvm_module))
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
+	if (!kvm_get_kvm_safe(kvm))
 		goto out_put_mod;
 
-	ret = kvm_get_kvm_safe(kvm);
-	if (!ret)
-		goto out_put_sym;
-
-	device->put_kvm = pfn;
 	device->kvm = kvm;
 	device->kvm_module = kvm_module;
 	return;
 
-out_put_sym:
-	symbol_put(kvm_put_kvm);
 out_put_mod:
 	module_put(kvm_module);
 }
@@ -472,14 +461,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
 	if (!device->kvm)
 		return;
 
-	if (WARN_ON(!device->put_kvm))
-		goto clear;
-
-	device->put_kvm(device->kvm);
-	device->put_kvm = NULL;
-	symbol_put(kvm_put_kvm);
-
-clear:
+	kvm_put_kvm(device->kvm);
 	device->kvm = NULL;
 	module_put(device->kvm_module);
 	device->kvm_module = NULL;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5163b541c82d..ca06f9bda028 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1064,7 +1064,6 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module);
 void kvm_exit(void);
 
-void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 4cb68c71a13c..8a9be07cb8dd 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -144,6 +144,7 @@ struct kvm_vcpu_stat_generic {
 
 struct kvm_refcount {
 	refcount_t users_count;
+	void (*destroy)(struct kvm *kvm);
 };
 
 static inline void kvm_get_kvm(struct kvm *kvm)
@@ -162,6 +163,13 @@ static inline bool kvm_get_kvm_safe(struct kvm *kvm)
 	return refcount_inc_not_zero(&rc->users_count);
 }
 
+static inline void kvm_put_kvm(struct kvm *kvm)
+{
+	struct kvm_refcount *rc = (struct kvm_refcount *)kvm;
+	if (refcount_dec_and_test(&rc->users_count))
+		rc->destroy(kvm);
+}
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* __KVM_TYPES_H__ */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 69a8d527b0e8..5c69532d6127 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -65,7 +65,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6e3796814da7..27a718a0bc01 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -120,6 +120,7 @@ static struct dentry *kvm_debugfs_dir;
 
 static const struct file_operations stat_fops_per_vm;
 
+static void kvm_destroy_vm(struct kvm *kvm);
 static long kvm_vcpu_ioctl(struct file *file, unsigned int ioctl,
 			   unsigned long arg);
 #ifdef CONFIG_KVM_COMPAT
@@ -1155,6 +1156,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 
 	BUILD_BUG_ON(offsetof(struct kvm, rc) != 0);
 	refcount_set(&kvm->rc.users_count, 1);
+	kvm->rc.destroy = kvm_destroy_vm;
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		for (j = 0; j < 2; j++) {
@@ -1317,13 +1319,6 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	mmdrop(mm);
 }
 
-void kvm_put_kvm(struct kvm *kvm)
-{
-	if (refcount_dec_and_test(&kvm->rc.users_count))
-		kvm_destroy_vm(kvm);
-}
-EXPORT_SYMBOL_GPL(kvm_put_kvm);
-
 /*
  * Used to put a reference that was taken on behalf of an object associated
  * with a user-visible file descriptor, e.g. a vcpu or device, if installation
-- 
2.53.0

