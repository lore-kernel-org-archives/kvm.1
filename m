Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685E3CD8A5
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830424; cv=none; b=s04QK/QAjMQMvQtiyf9/NswBi2mez0ItYnzI/m3z5A/CBLO/TTs9u/yv/phsktjiERzj7Ifps/539gIFEploA3KifIIuE9FWMzaOyJQk7fjCCmCjAgFFW/xS54/wH4zkguhXlGoTs6b97w041U3BdSDjfJ6/nqnjA2Cugztwdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830424; c=relaxed/simple;
	bh=qQNVg/ugBvxEaMVAleg/K0jywWTM/fiHSCa81VISAog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9kjz7Q+2/Ae/nSjkMTbASXvkkuppkXdVHxNDwpaDELv5C1F9DBNaz8+WY4yqC6sy0xJGmM/MIm2zASxum4l7sRO+8hl5+FxvyBy/eqOZTl014p4GbA4TrSkJiep9DVJKyK4akfJ5H1VBYzZugKDfnpX0Mw42oU5IFaAbpU0GKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEuagF1T; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEuagF1T"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso1383625a12.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775830422; x=1776435222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mc7B3oaZo2XXgdqoUZW5A1doeV9b3Cueq1LCyeLN+nM=;
        b=FEuagF1TABHDdWP+YDP6ZnBHeqR1h7MLKGLvXg+iT2ZWu2itgqcFgxaLLCIyP+ZKiq
         NbdNpjOv1eLUlYQaKcN+sqEthqhTSCwZF89YsPvBdYVCZbayv6C3h9hA4YCf9F4EiT45
         I9w3ewr0Ruh0LHgnqGHMTuR7uPQ75lyzWdniLOovJNcND9puwYWdSJGZRquivHoKCMx3
         CMjv83B7E56u4oPKlj/hI+oVaw3eXX+wlEjAp79Cb98At88vbnx9H2SKwPrRADIcr3XY
         3+B7p29kVya7An2jVn9LSsGKMOEmhy8vMpzdlvzPMY2C2QwhEzLjGAJ4Es6Cuy2o3lNv
         jbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830422; x=1776435222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mc7B3oaZo2XXgdqoUZW5A1doeV9b3Cueq1LCyeLN+nM=;
        b=Oq/6cRdVvMM9jsrAmaov9FWJB4hBPUNAotGStk8g84Yhnt5T3Ndd0oPUgKtWyPKtV1
         xF+orOEcDoexp4hDhq4Vg+3wxAXrELAp989mEzfwbZaTKCrD8adtTkL1HjbljwpQg3sl
         f5liazzj8rylxXuln6H2otl/HVXdmPdphUyArCxPpMm2PgwWKvidpwH2C7MKe55DgjFw
         RJD6QcG+Sjei37k2cS9cDIPIqlQNXkE7CiRJgV6wir4O8M7bLV9r5HlqMBmqZkwPsHTF
         OFSWl6GtAafxDAjw6SwIG4xWPEL7zlfObr1gao6tlSBfPA0Udr9GhH/RIbm1giK259CR
         9FdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZpFNVoYEJtoPgZ9hn54HcWSFBijqzbaemuOPt2qURL92yyCbISI2j0FpDwbnzljoldDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPdSqvSfvByNaLuLGLO1zTNq8Nvfr/4yGR9ebTHSCBYee3Ethe
	CQPnwunQUgPlItMIHAPdKBDWJe4JCO1QXOTPigiZfSk4ycmcA6AsRcbcucyRMT6lG/+2pMpNCif
	8ECzd4Q==
X-Received: from pfbgc3.prod.google.com ([2002:a05:6a00:62c3:b0:82c:2477:2e24])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4601:b0:82c:212a:8023
 with SMTP id d2e1a72fcca58-82f0c12fe20mr3847358b3a.11.1775830422076; Fri, 10
 Apr 2026 07:13:42 -0700 (PDT)
Date: Fri, 10 Apr 2026 07:13:39 -0700
In-Reply-To: <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com> <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
Message-ID: <adkFk3ZN4HJtpLA3@google.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"

+Dan

On Fri, Apr 10, 2026, Paolo Bonzini wrote:
> Il gio 9 apr 2026, 20:59 Sean Christopherson <seanjc@google.com> ha scritto:
> >
> > On Tue, Apr 07, 2026, Paolo Bonzini wrote:
> > > VFIO is implicitly taking a reference to the KVM module between
> > > vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> > > symbol_get and symbol_put.
> > >
> > > In preparation for removing symbol_get and symbol_put themselves
> > > from VFIO, actually store a pointer to the KVM module and use
> > > module_get()/module_put() to keep KVM alive.
> >
> > NAK?  :-)
> >
> > I really don't think we should do this.  We're reinventing the wheel, and probably
> > doing so poorly.  As Jason suggested, the proper way to handle this is to pass
> > a "struct file" so that e.g. fops_get() pins kvm.ko for us.
> 
> We could get rid of the reference count completely (get_file() as a
> replacement for kvm_get_kvm(), get_file_active() as a replacement for
> kvm_get_kvm_safe()). struct kvm would need to add a back pointer from
> struct kvm to struct file,

I wasn't thinking of dropping kvm_get_kvm() entirely, rather just not exporting
it.  Forcing internal KVM usage to grab a reference to the file doesn't add a
whole lot value.

> therefore adding and removing a reference count would have some additional
> pointer chasing. KVM has too many kinds of files to seriously consider
> passing around struct file* in virt/kvm/ and arch/*/kvm/, and you'd also have
> pointer chasing to get filp->private_data so it wouldn't win much.

Again, I'm not suggesting we do that.  The conversion looks pretty straightforward;
the compile-tested only, but it doesn't seem overly complex.

drivers/s390/crypto/vfio_ap_ops.c would need similar treatment.  I didn't try to
handle it in my sketch because it's not clear to me how we want to deal with that
thing, as it's accessing a pile of state/fields that really shouldn't be used by
non-KVM code :-(

I added Dan because the PCI TSM stuff is picking up "struct kvm *kvm" references,
and I want to head that off too, i.e. have it use the file approach instead of
whatever it plans on doing (can't tell from the code, because there are no users).

---
 arch/x86/include/asm/kvm_page_track.h |  8 +++---
 arch/x86/kvm/mmu/page_track.c         | 16 +++++++----
 drivers/vfio/group.c                  |  2 +-
 drivers/vfio/vfio.h                   | 12 ++++----
 drivers/vfio/vfio_main.c              | 41 ++++-----------------------
 include/linux/kvm_host.h              |  2 ++
 include/linux/vfio.h                  |  5 ++--
 virt/kvm/kvm_main.c                   | 14 +++++++--
 virt/kvm/vfio.c                       |  6 ++--
 9 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 3d040741044b..046a25c8fe4f 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -44,13 +44,13 @@ struct kvm_page_track_notifier_node {
 				    struct kvm_page_track_notifier_node *node);
 };
 
-int kvm_page_track_register_notifier(struct kvm *kvm,
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n);
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n);
 
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn);
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn);
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn);
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn);
 #else
 /*
  * Allow defining a node in a structure even if page tracking is disabled, e.g.
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 1b17b12393a8..f070dacc4028 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -217,10 +217,11 @@ static int kvm_enable_external_write_tracking(struct kvm *kvm)
  * register the notifier so that event interception for the tracked guest
  * pages can be received.
  */
-int kvm_page_track_register_notifier(struct kvm *kvm,
+int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm(file);
 	int r;
 
 	if (!kvm || kvm->mm != current->mm)
@@ -232,7 +233,7 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
 			return r;
 	}
 
-	kvm_get_kvm(kvm);
+	get_file(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -247,10 +248,11 @@ EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier);
  * stop receiving the event interception. It is the opposed operation of
  * kvm_page_track_register_notifier().
  */
-void kvm_page_track_unregister_notifier(struct kvm *kvm,
+void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	struct kvm *kvm = file_to_kvm(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -259,7 +261,7 @@ void kvm_page_track_unregister_notifier(struct kvm *kvm,
 	write_unlock(&kvm->mmu_lock);
 	synchronize_srcu(&head->track_srcu);
 
-	kvm_put_kvm(kvm);
+	fput(file);
 }
 EXPORT_SYMBOL_GPL(kvm_page_track_unregister_notifier);
 
@@ -319,8 +321,9 @@ void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
  * @kvm: the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_add_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -349,8 +352,9 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  * @kvm: the guest instance we are interested in.
  * @gfn: the guest page.
  */
-int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn)
+int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn)
 {
+	struct kvm *kvm = file_to_kvm(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..f4a81d1b63fa 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -858,7 +858,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return ret;
 }
 
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
 	spin_lock(&group->kvm_ref_lock);
 	group->kvm = kvm;
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..aa93c1ec6b10 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -23,7 +23,7 @@ struct vfio_device_file {
 	u8 access_granted;
 	u32 devid; /* only valid when iommufd is valid */
 	spinlock_t kvm_ref_lock; /* protect kvm field */
-	struct kvm *kvm;
+	struct file *kvm;
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
@@ -88,7 +88,7 @@ struct vfio_group {
 #endif
 	enum vfio_group_type		type;
 	struct mutex			group_lock;
-	struct kvm			*kvm;
+	struct file			*kvm;
 	struct file			*opened_file;
 	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;
@@ -108,7 +108,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
 void vfio_df_group_close(struct vfio_device_file *df);
 struct vfio_group *vfio_group_from_file(struct file *file);
 bool vfio_group_enforced_coherent(struct vfio_group *group);
-void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
+void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm);
 bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
@@ -171,7 +171,7 @@ static inline bool vfio_group_enforced_coherent(struct vfio_group *group)
 	return true;
 }
 
-static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
+static inline void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
 {
 }
 
@@ -435,11 +435,11 @@ static inline void vfio_virqfd_exit(void)
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm);
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm);
 void vfio_device_put_kvm(struct vfio_device *device);
 #else
 static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
-					    struct kvm *kvm)
+					    struct file *kvm)
 {
 }
 
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 742477546b15..7af53d1288f8 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -433,35 +433,13 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
 #if IS_ENABLED(CONFIG_KVM)
-void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kvm)
+void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *kvm)
 {
-	void (*pfn)(struct kvm *kvm);
-	bool (*fn)(struct kvm *kvm);
-	bool ret;
-
 	lockdep_assert_held(&device->dev_set->lock);
 
-	if (!kvm)
+	if (!get_file_active(&kvm))
 		return;
 
-	pfn = symbol_get(kvm_put_kvm);
-	if (WARN_ON(!pfn))
-		return;
-
-	fn = symbol_get(kvm_get_kvm_safe);
-	if (WARN_ON(!fn)) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	ret = fn(kvm);
-	symbol_put(kvm_get_kvm_safe);
-	if (!ret) {
-		symbol_put(kvm_put_kvm);
-		return;
-	}
-
-	device->put_kvm = pfn;
 	device->kvm = kvm;
 }
 
@@ -472,14 +450,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
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
+	fput(device->kvm);
 	device->kvm = NULL;
 }
 #endif
@@ -1483,7 +1454,7 @@ bool vfio_file_enforced_coherent(struct file *file)
 }
 EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
-static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
+static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1500,12 +1471,12 @@ static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
 /**
  * vfio_file_set_kvm - Link a kvm with VFIO drivers
  * @file: VFIO group file or VFIO device file
- * @kvm: KVM to link
+ * @kvm: KVM file to link
  *
  * When a VFIO device is first opened the KVM will be available in
  * device->kvm if one was associated with the file.
  */
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+void vfio_file_set_kvm(struct file *file, struct file *kvm)
 {
 	struct vfio_group *group;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..7ea398d33e9f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1066,6 +1066,7 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+struct kvm *file_to_kvm(struct file *file);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
@@ -2310,6 +2311,7 @@ extern unsigned int halt_poll_ns_shrink;
 
 struct kvm_device {
 	const struct kvm_device_ops *ops;
+	struct file *kvm_file;
 	struct kvm *kvm;
 	void *private;
 	struct list_head vm_node;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..6dd5dd2550a0 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -52,7 +52,7 @@ struct vfio_device {
 	struct vfio_device_set *dev_set;
 	struct list_head dev_set_list;
 	unsigned int migration_flags;
-	struct kvm *kvm;
+	struct file *kvm;
 
 	/* Members below here are private, not for driver use */
 	unsigned int index;
@@ -64,7 +64,6 @@ struct vfio_device {
 	unsigned int open_count;
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
-	void (*put_kvm)(struct kvm *kvm);
 	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
@@ -339,7 +338,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+void vfio_file_set_kvm(struct file *file, struct file *kvm);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..b240a3cc5995 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4808,7 +4808,7 @@ void kvm_unregister_device_ops(u32 type)
 		kvm_device_ops_table[type] = NULL;
 }
 
-static int kvm_ioctl_create_device(struct kvm *kvm,
+static int kvm_ioctl_create_device(struct file *file, struct kvm *kvm,
 				   struct kvm_create_device *cd)
 {
 	const struct kvm_device_ops *ops;
@@ -4834,6 +4834,7 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 
 	dev->ops = ops;
 	dev->kvm = kvm;
+	dev->kvm_file = file;
 
 	mutex_lock(&kvm->lock);
 	ret = ops->create(dev, type);
@@ -5351,7 +5352,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		if (copy_from_user(&cd, argp, sizeof(cd)))
 			goto out;
 
-		r = kvm_ioctl_create_device(kvm, &cd);
+		r = kvm_ioctl_create_device(filp, kvm, &cd);
 		if (r)
 			goto out;
 
@@ -5483,6 +5484,15 @@ bool file_is_kvm(struct file *file)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 
+struct kvm *file_to_kvm(struct file *file)
+{
+	if (!file_is_kvm(file))
+		return NULL;
+
+	return file->private_data;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_to_kvm);
+
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 9f9acb66cc1e..f6681dacf7b9 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -35,9 +35,9 @@ struct kvm_vfio {
 	bool noncoherent;
 };
 
-static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
+static void kvm_vfio_file_set_kvm(struct file *file, struct file *kvm)
 {
-	void (*fn)(struct file *file, struct kvm *kvm);
+	void (*fn)(struct file *file, struct file *kvm);
 
 	fn = symbol_get(vfio_file_set_kvm);
 	if (!fn)
@@ -175,7 +175,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 	kvf->file = get_file(filp);
 	list_add_tail(&kvf->node, &kv->file_list);
 
-	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
+	kvm_vfio_file_set_kvm(kvf->file, dev->kvm_file);
 	kvm_vfio_update_coherency(dev);
 
 out_unlock:

base-commit: df83746075778958954aa0460cca55f4b3fc9c02
--
