Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011833;
	b=P/VjqHOPip3QH5dk0vOOcbLoZVAjlGUZYnEZwMGuDVaB9pPEW78F8rNUXhsOcC/+wl03
	 ioTfHcpBkrOfiyTmn9enzcH7BzhQbAMfKbWjdhFOwYYoEewwiRuzM0dIkLmxeUQsHaOjc
	 WQlWhCjZwpMT4edLi9A7Myi5AGBvylE5FJaItesuUVvm7x0z01WFuKcy+xMfcgqvw/O7g
	 65JwJTMk0cI0FKl9h/0aIgPvYAd5AOgCMBliw4MfZCJ9po9caBAcvttJ4slbYjEJ9aMmV
	 WcZhlYUGx/KWnJj2kyyaOhb1Fjk9fb6+iPet3bDlAAUdUMj9NJZ8A6M9MzSy4BFsYhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011833;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7u/xUqUjSpG1uHVLTmzq+uP5uQjAYFobNAgMRyNfitg=;
	b=BH68zBNRnKoPSIq0mJYO/8XLDGSFUpnQfs2Div4L852mDy4eal4wNTT1FyyTzkMHmQ2O
	 3tNXZZUkJ5NaY8k5EHYnv9LS5+PIFc80KUUZ2l6/a9Fb+SkKlDnhM4yjbLUjVaUWpr35L
	 gXGLVqdlQhLZ1u2cNQfNrpuJ0921jOZEUuV5DLmugGgAY4QwjcOAZw2oxuT9N5YbSBbW8
	 WnAAOTO+0/5W3ITyghx0PMdgai21AYykTjjmPjlsEMB4J0Xk3b2Yz8Po6zBVo24EMpUL3
	 psfTmOdohjFKFt2VLSpWSuouBhX0v/6rdhmauTpArMeSs57wtHq/5UnwiqchV+QOotw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LN9e0/At";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA860A5BDA;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN9e0/At
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011833;
	b=KQ7Pa95P+RuYFA3R/MlXuUG5Q5TMXlvSi9HyCZkGFDaxYMVDSfsOYo7+p4BCGzsxML/z
	 riiu48h7oL/qriWC3kOxA8VRK8/AN00iLh0k02dOF3mUUTTV3DqYF1ojctF+CAqgjGSiI
	 8RcoHXeDtY2QP733RJ7p+3xtgcBj6VHeI+TC85O9uk0H0O4/86RgKjnvdm7/jV+teUTmQ
	 vxJ+ACCT8gBSAq5+sxgVdMtnKgsQ/vQ1/RomkQXt5/1HIWyCjoxOZ2hsXjuhgDhYbkiMt
	 OU4y6YAvDksK4gGJx/yDOiiRzTX7VkITKUBx2Fnzg7MNnB54hka/P+PsNAMJnW3rLNg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011833;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7u/xUqUjSpG1uHVLTmzq+uP5uQjAYFobNAgMRyNfitg=;
	b=Anb/xznNcUqNJlEFcqOxyVh6fJ37SopfHjjqNViv1hlh3sFLz67CBkEIIOxow9ni5ra1
	 7HOapqsPqrJ+WoHjm7uRrVxGHDgiMkVELPjwPMvzjUIujDkT8q310BwaAa9A9okRonEj4
	 gZPNFmEO1N0dQMC4EddH1ZtKkpV/0AobthOKFXl6Hn+atVlz5NW6kJBsRByIzu00vvuQY
	 HzS8IPea+WAKEKzZezOmOTZW9BTROhhhO8IY4sDDArVGic1wHB1FNn4GaNQ38hnuC4YK/
	 6YajYahUOl5TxQAGEEneiOkPAbfaJm4D0Eidmj+nZA5CM6xJKLQthtj2wkF2lb7UtYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7815C1F008AB;
	Sat,  7 Nov 2026 00:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011833;
	bh=7u/xUqUjSpG1uHVLTmzq+uP5uQjAYFobNAgMRyNfitg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LN9e0/AtB7Izb4lqha7xs8FLfETDMlx/1nrJ7pTkRXq1u+n8796yPJra24YFlq+3H
	 vrD7PybLJjSPbpQe6+n+3qysUlG3Nbyu3iiLWC3574iW++Py0jeswshs5HwfBlr9Mt
	 ZFmSxAh08jHjFZdem3eUeZqMPPCD/WKCqS1BaF9JoFUFROVo+W3zuvfEMJ+3D8XVE8
	 dTpxXj/WlrnsY85LycQuNwE2nhfatfyBC7tsPuLkcf2kEW0LKF7EhOU2G3XGR+97y0
	 VtsTIXhNAJKkbpvtW9DvrHZLicPC3uCO7bjMIi3z90JwTGcs41DlnehxcTJFfYYcXf
	 m9KoJ1oheNBMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A5F77479E9;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:29 -0800
Subject: [PATCH RFC v3 55/88] vfio: Track device file access mode with an
 enum
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-55-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=5176;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=OPzfI8FY9YTnY7U//Qo2HO1R07AW0TxEMrDt75CQipU=;
 b=yxGBfLn330m/QlZKxV56D9+INpmu/vb92BX3fIJN1BHK07X4RoQNHQmNHqFgxcPEyc9f3OrFI
 TITTtiAfEvkBiWVgqH/0/MljlVFSh1dt4fWyaeiRAMfq00Gn4JmxuQ3
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Device file operations currently track whether access has been granted
using a boolean flag, assuming that binding a device always unlocks both
control-plane operations and direct region access simultaneously.

Upcoming support for control-only device bindings requires distinguishing
unbound descriptors from descriptors bound with restricted vs. full
access, without introducing multiple flags that could get out of sync or
represent invalid combinations under lockless release-acquire ordering.

Replace the boolean flag with an enum representing the access mode so
that the entire access state continues to be published and read as a
single release-acquire value.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/device_cdev.c | 8 ++++----
 drivers/vfio/group.c       | 2 +-
 drivers/vfio/vfio.h        | 7 ++++++-
 drivers/vfio/vfio_main.c   | 8 ++++----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index c1c26d7a9aec9..19be3947fc74a 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -125,7 +125,7 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 
 	mutex_lock(&device->dev_set->lock);
 	/* one device cannot be bound twice */
-	if (df->access_granted) {
+	if (df->access_mode != VFIO_DF_ACCESS_NONE) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -163,7 +163,7 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 	 * Paired with smp_load_acquire() in vfio_device_fops::ioctl/
 	 * read/write/mmap
 	 */
-	smp_store_release(&df->access_granted, true);
+	smp_store_release(&df->access_mode, VFIO_DF_ACCESS_FULL);
 	mutex_unlock(&device->dev_set->lock);
 	return 0;
 
@@ -185,10 +185,10 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
 
 	/*
 	 * In the time of close, there is no contention with another one
-	 * changing this flag.  So read df->access_granted without lock
+	 * changing this mode.  So read df->access_mode without lock
 	 * and no smp_load_acquire() is ok.
 	 */
-	if (!df->access_granted)
+	if (df->access_mode == VFIO_DF_ACCESS_NONE)
 		return;
 
 	mutex_lock(&device->dev_set->lock);
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 185f359f75d38..0a33e0e025bd8 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -217,7 +217,7 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 	 * Paired with smp_load_acquire() in vfio_device_fops::ioctl/
 	 * read/write/mmap and vfio_file_has_device_access()
 	 */
-	smp_store_release(&df->access_granted, true);
+	smp_store_release(&df->access_mode, VFIO_DF_ACCESS_FULL);
 
 	mutex_unlock(&device->dev_set->lock);
 	mutex_unlock(&device->group->group_lock);
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 2eeb526a8da58..af2b8158b40c0 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -16,11 +16,16 @@ struct iommufd_ctx;
 struct iommu_group;
 struct vfio_container;
 
+enum vfio_df_access_mode {
+	VFIO_DF_ACCESS_NONE = 0,
+	VFIO_DF_ACCESS_FULL,
+};
+
 struct vfio_device_file {
 	struct vfio_device *device;
 	struct vfio_group *group;
 
-	u8 access_granted;
+	enum vfio_df_access_mode access_mode;
 	u32 devid; /* only valid when iommufd is valid */
 	spinlock_t kvm_ref_lock; /* protect kvm field */
 	struct file *kvm;
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index ea8e6cc13c457..fe126e137d5ca 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1349,7 +1349,7 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
 		return vfio_df_ioctl_bind_iommufd(df, uptr);
 
 	/* Paired with smp_store_release() following vfio_df_open() */
-	if (!smp_load_acquire(&df->access_granted))
+	if (smp_load_acquire(&df->access_mode) == VFIO_DF_ACCESS_NONE)
 		return -EINVAL;
 
 	ret = vfio_device_pm_runtime_get(device);
@@ -1397,7 +1397,7 @@ static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,
 	struct vfio_device *device = df->device;
 
 	/* Paired with smp_store_release() following vfio_df_open() */
-	if (!smp_load_acquire(&df->access_granted))
+	if (smp_load_acquire(&df->access_mode) == VFIO_DF_ACCESS_NONE)
 		return -EINVAL;
 
 	if (unlikely(!device->ops->read))
@@ -1414,7 +1414,7 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 	struct vfio_device *device = df->device;
 
 	/* Paired with smp_store_release() following vfio_df_open() */
-	if (!smp_load_acquire(&df->access_granted))
+	if (smp_load_acquire(&df->access_mode) == VFIO_DF_ACCESS_NONE)
 		return -EINVAL;
 
 	if (unlikely(!device->ops->write))
@@ -1429,7 +1429,7 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 	struct vfio_device *device = df->device;
 
 	/* Paired with smp_store_release() following vfio_df_open() */
-	if (!smp_load_acquire(&df->access_granted))
+	if (smp_load_acquire(&df->access_mode) == VFIO_DF_ACCESS_NONE)
 		return -EINVAL;
 
 	if (unlikely(!device->ops->mmap))

-- 
2.56.0.455.g6c5a503b38-goog


