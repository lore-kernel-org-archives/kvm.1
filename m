Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309039C015
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584886; cv=none; b=fsYTRU+2HT8bZhad0PTjJzA742I0dK0eMTl6vBOVepOQk5db/Pz0Szkt35aqqjshG4ozFkE1V/+SXLyBPAAX2cIYnGZZoKKsYvqAJNZKEIeS6AVRUtzZ82wLlAjM8Ezfyc9MuZknJB33G0m/Fs6X2GNvmOIQ0al2kKKQq3cTBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584886; c=relaxed/simple;
	bh=fCKRONX8yM7lQOG/vgBN8rFi8saRuPtzgJkTstXrnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jq8V/StCAN8XqdjShpxuj22Jz1eK6g1vka/mFJcba68Q+vzITNDg52HouRkLfevXBTjxgvxHhv+lvoK3rFQIqJulPPqvF9CJsfLSSGMiWAIxvVoHoGHzFndhQH+JNTOwCwe2XzW36bIURlUySOt7UbpoCv8XU2U8+/aOTVIQuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvH8SHhH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKmbOM6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvH8SHhH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKmbOM6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775584883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F52AVfFEhfnHhPUaSAFo1kWAX0sZksEa7u1ua5dSj1E=;
	b=LvH8SHhHLAoN/CmGibCLcQIvlpM5dhOH802J1cNoExYliWFd+g9TN6q0GvVc/55MXXQ2yV
	4TbQke5IA7GnuuyHvg9BDwNdJ39prBMbtPqSRpspftwhbzGUUVSl0V2vUGOXdJHBoOIqhK
	59O3jcH98tt+4GvQqteIw1E8KlwaPN4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-exsTDV92PtebDkNe9OKSSg-1; Tue, 07 Apr 2026 14:01:21 -0400
X-MC-Unique: exsTDV92PtebDkNe9OKSSg-1
X-Mimecast-MFC-AGG-ID: exsTDV92PtebDkNe9OKSSg_1775584880
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483786a09b1so69421945e9.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775584879; x=1776189679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F52AVfFEhfnHhPUaSAFo1kWAX0sZksEa7u1ua5dSj1E=;
        b=CKmbOM6ykDoI+NT1tKqGDU5eqqauVRAHVg8azJCmwqQDoRUgNo+pciHY38ILMLQJwm
         qj5Was841CulBxHDKdib60YsVHH76tKP3jHprlPkLkxkUIkHW95pbpz3UoLX/Y+8MVGh
         JBrjJIHo9Eom4bIiPbWbnlN/UVbgddJBmbe1hJfP/SWVOvrsibF4k0vGKoQOo5n53IX0
         wkItlxg0DL7Rq4E9Jl+TPhKq+5RMZkw3YNqatq6PcX9Ikr53JvMUpZFtiaRZIBIoG6KN
         D+J/tnU76EHPo3iUokP2u4qzbx4+VDyAKicXcN1aLvXTBesZ2xNn+t61Ztm/1uw/bnwi
         5Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584879; x=1776189679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F52AVfFEhfnHhPUaSAFo1kWAX0sZksEa7u1ua5dSj1E=;
        b=ASrR+/LrrClgqtrKRGsOugjRQnZS5wo811yJKPJbvEvbgMsNObUd948LBYepSFE7GE
         F71A5xC/hy1EpIdA0El+C9/nzYr0IoPoyly4rLkVcjlTGhcmU6sEQWucje1zCjfZUErw
         xOgW0EPvjbuH96sGamo4SPjhgrfQkGpo7MNIeCxcJsmv4fu6desdn36dJc8TnaTFez8X
         W6MOME/t0+/6kyrF2eB+Z2IqgWdDym8lI4mOW9R185xUNSAgikUs75NscvyMMLTMWR5q
         xn11EzfVTMjeMPLOqUBqWa3UJyGU1HwGL2ZXom0mRIpclLohI+p3b5A+SVj6PfA9QVR/
         h32A==
X-Forwarded-Encrypted: i=1; AJvYcCW1f3+mmaSP1rcY6HEmxFiJy87NitH7BQKDRHAevNStM2ogYDyeX+EY5kwdbQHR+4+lZhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zgGNx7WFizvC2ylrNbCxL0Q7uJrvSqrZjSFqGtB56aMUAeI4
	oTnkq3ErHfrzct5YsZz8h91KWMdZ9FALEUhnKfvXP0/g/i00nJvPl0/wuHbH8NZ3Jw79FCBgxYA
	ZQcWfM5P+6PkqCZsPx4V4eNtOZJIjEa973WzeRTnmcBsxPqxEnqdfwhuOGWn1wA==
X-Gm-Gg: AeBDiesL8Ojhwbr56PsL1G7CwU45IHtHhTJuN0s2JWvK8LNl6WnEhcCniRUp1QqRtno
	TLFqbmwI3bBURE3C1P2CZuyCDuqYQW2vvC4WYNtBTp48t/3tUVff+6YQlrZq5qnzlzShX6Vheeu
	gLy2cliHlVbYLXPmaA+FS6f9P46eILsg8PxiO8YkiawM5Dc9Sl7EY6SemY39TXD5Su1AlMmyBpS
	1fWHZoB+ye5+J4I62VKsVcB6rm05isLahQ23fks9ZNP8uELW/DuJfqVXoc7jwFvAMJ3KvbinAgD
	2udPLhcy9eJ53b2bnSKXZkRbMMTyVZ006jAzSdSlC3UbN+lU4YiukzC75JMauhPQYKEplfW5Sr5
	8ULqn/cUXkcVlFLToZ4a0xxsnfHpwIGVRFPFCm4Jef2uv+ALuC+E8Bw3zov4tSLZPh6rWpt4WPD
	Agwp4CA6LWmE0MvZg/Nx+uV5p9
X-Received: by 2002:a05:600c:628e:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-488997dd822mr232166555e9.21.1775584879173;
        Tue, 07 Apr 2026 11:01:19 -0700 (PDT)
X-Received: by 2002:a05:600c:628e:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-488997dd822mr232166265e9.21.1775584878698;
        Tue, 07 Apr 2026 11:01:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c531ab02sm2465625e9.1.2026.04.07.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:01:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: [PATCH 1/3] VFIO: take reference to the KVM module
Date: Tue,  7 Apr 2026 20:01:05 +0200
Message-ID: <20260407180107.1603697-2-pbonzini@redhat.com>
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

VFIO is implicitly taking a reference to the KVM module between
vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
symbol_get and symbol_put.

In preparation for removing symbol_get and symbol_put themselves
from VFIO, actually store a pointer to the KVM module and use
module_get()/module_put() to keep KVM alive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/vfio/device_cdev.c |  2 +-
 drivers/vfio/group.c       |  5 +++--
 drivers/vfio/vfio.h        | 15 ++++++++++-----
 drivers/vfio/vfio_main.c   | 39 +++++++++++++++++++++++---------------
 include/linux/vfio.h       |  3 ++-
 virt/kvm/vfio.c            |  4 ++--
 6 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..a67d7215c239 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -56,7 +56,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
-	vfio_device_get_kvm_safe(df->device, df->kvm);
+	vfio_device_get_kvm_safe(df->device, df->kvm, df->kvm_module);
 	spin_unlock(&df->kvm_ref_lock);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..7d28f45fefaa 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -158,7 +158,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 static void vfio_device_group_get_kvm_safe(struct vfio_device *device)
 {
 	spin_lock(&device->group->kvm_ref_lock);
-	vfio_device_get_kvm_safe(device, device->group->kvm);
+	vfio_device_get_kvm_safe(device, device->group->kvm, device->group->kvm_module);
 	spin_unlock(&device->group->kvm_ref_lock);
 }
 
@@ -858,10 +858,11 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return ret;
 }
 
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm, struct module *kvm_module)
 {
 	spin_lock(&group->kvm_ref_lock);
 	group->kvm = kvm;
+	group->kvm_module = kvm_module;
 	spin_unlock(&group->kvm_ref_lock);
 }
 
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..a0c38f89b30a 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -22,8 +22,9 @@ struct vfio_device_file {
 
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
-	spinlock_t kvm_ref_lock; /* protect kvm field */
+	spinlock_t kvm_ref_lock; /* protect kvm and kvm_module fields */
 	struct kvm *kvm;
+	struct module *kvm_module;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -89,6 +90,7 @@ struct vfio_group {
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
 	struct kvm			*kvm;
+	struct module			*kvm_module;
 	struct file			*opened_file;
 	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;
@@ -108,7 +110,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
 void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm, struct module *kvm_module);
 bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
@@ -171,7 +173,8 @@ static inline bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return true;
 }
 
-static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm,
+				      struct module *kvm_module)
 {
 }
 
@@ -435,11 +438,13 @@ static inline void vfio_virqfd_exit(void)
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm,
+			      struct module *kvm_module);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct kvm *kvm,
+					    struct module *kvm_module)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 742477546b15..d1bbc42d484a 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -433,7 +433,7 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm, struct module *kvm_module)
 {
 	void (*pfn)(struct kvm *kvm);
 	bool (*fn)(struct kvm *kvm);
@@ -444,25 +444,31 @@ void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
 	if (!kvm)
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
+	if (!try_module_get(kvm_module))
 		return;
 
+	pfn = symbol_get(kvm_put_kvm);
+	if (WARN_ON(!pfn))
+		goto out_put_mod;
+
 	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+	if (WARN_ON(!fn))
+		goto out_put_sym;
 
 	ret = fn(kvm);
 	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
+	if (!ret)
+		goto out_put_sym;
 
 	device->put_kvm = pfn;
 	device->kvm = kvm;
+	device->kvm_module = kvm_module;
+	return;
+
+out_put_sym:
+	symbol_put(kvm_put_kvm);
+out_put_mod:
+	module_put(kvm_module);
 }
 
 void vfio_device_put_kvm(struct vfio_device *device)
@@ -481,6 +487,8 @@ void vfio_device_put_kvm(struct vfio_device *device)
 
 clear:
 	device->kvm = NULL;
+	module_put(device->kvm_module);
+	device->kvm_module = NULL;
 }
 #endif
 
@@ -1483,7 +1491,7 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1494,6 +1502,7 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 	 */
 	spin_lock(&df->kvm_ref_lock);
 	df->kvm = kvm;
+	df->kvm_module = kvm_module;
 	spin_unlock(&df->kvm_ref_lock);
 }
 
@@ -1505,16 +1514,16 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
  * When a VFIO device is first opened the KVM will be available in
  * device->kvm if one was associated with the file.
  */
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+void vfio_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module)
 {
 	struct vfio_group *group;
 
 	group = vfio_group_from_file(file);
 	if (group)
-		vfio_group_set_kvm(group, kvm);
+		vfio_group_set_kvm(group, kvm, kvm_module);
 
 	if (vfio_device_from_file(file))
-		vfio_device_file_set_kvm(file, kvm);
+		vfio_device_file_set_kvm(file, kvm, kvm_module);
 }
 EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..69a8d527b0e8 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -53,6 +53,7 @@ struct vfio_device {
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
 	struct kvm *kvm;
+	struct module *kvm_module;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -339,7 +340,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *file, struct kvm *kvm, struct module *kvm_module);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 9f9acb66cc1e..515ed445d8e1 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -37,13 +37,13 @@ struct kvm_vfio {
 
 static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
 {
-	void (*fn)(struct file *file, struct kvm *kvm);
+	void (*fn)(struct file *file, struct kvm *kvm, struct module *kvm_module);
 
 	fn = symbol_get(vfio_file_set_kvm);
 	if (!fn)
 		return;
 
-	fn(file, kvm);
+	fn(file, kvm, kvm ? THIS_MODULE : NULL);
 
 	symbol_put(vfio_file_set_kvm);
 }
-- 
2.53.0

