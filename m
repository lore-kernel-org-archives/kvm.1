Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0013A4F31
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894797; cv=none; b=jHKM3XrNT92PQLtWyPKgxM15aFS8VpjuBJys0m2l9UZ6KZT5gntz1r3TfZcbijWNNFOI9v7X2YBb7rkig3hv9B00LC7YUrTndr4TrXrLxYb2lbqO4T3W7UuEy0mjgoQXW2Ixh5vdsN/4PaWT1K0GD4Ba+mCMNLodJL+mNSh1PE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894797; c=relaxed/simple;
	bh=86j92cbC3iIQ8k+p6+INK1oIddVu6Aw92n3P5/8hIIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9MUUOtpRO9ORK/FO0f3cJnAVilugdoQE2fMvFExgESV7Kf1JrOXy1pf21d7OcBKITDBc4SAukm0Zdx0mCOlWmVn2/8ns8svmdXL8yXEsCY0+ik6eyJXQzUVL+Zy+JlvRcMK2EkOnv5CP4VbxOuM/oYQ2KfOcYKa+YNHuXGsRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1S0Fytb; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1S0Fytb"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a43fc3527so1299147b3a.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894795; x=1791499595; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2x7W5ngZlu/3nFvkA6yuMRWlRxfxLLOhPqXvdVf5w0=;
        b=T1S0FytbEDBz3V/IAFtk8rRmGnz8Hi6c8UYskTdKUHS6PTTe88bkXivkUZsVu5yYQQ
         F0TMWZ1Te0SBVKXiwWcthEDWT3W6U2RxA1eUVq/07YncI1e4IgewCZ8cpfxX8GXagyVm
         yoNQZTZ45kBaiLPn9x2fhp8LH4S6ybsSI/j5vyRp6Z+ODhC6GB0hdMxsSftanLx4hFKJ
         0wRTPzzcdXs50s7Ly5M3W+B0ajQSoplaY6yLlt5KB9wdBpkcL0IflF2WUbSqeYbXti0d
         9I6ytQ/RkSfP8jRqcKU0azKIOXz1baO0Vnom6LbtiUP6SO55+qtJkh7vr1i/SsAnsMtW
         9jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894795; x=1791499595;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2x7W5ngZlu/3nFvkA6yuMRWlRxfxLLOhPqXvdVf5w0=;
        b=itrZPywurueTZ5C/Nz70GYQhJ0XKhBIEYiTWYfwlL9WuurU18bpbqv5LRXA2ZnPj+N
         uVIfydCtcAe81HJu8pnw3WGCibpXO2LoASoKDIVqBkU4mDEB11g7XjZkKLgMeIborsIB
         y9afqKe7j6HTDxhCJoWdavsA4cWGO8OQUHOgFbCO34GGv6+eToObsVQxQ0kkOSOXTsa2
         GmzDjrIKfHUlep9FweKpJSjp9cFy5kGM0H1gRTTwiDzhWqthSUQxXnwyByZ7GBbo4CA7
         pmVRcGCN/uSmyXT05bz/6txxponGuVbIYNXDEqWiNqpCwfz9j4pkJKGuzweRvLNgShPI
         Ybjw==
X-Forwarded-Encrypted: i=1; AKwUvBxTx+0l0UJphSFnO+9/U8ZmAGVdAnh7vLd/Oe2hb9/LLuDTvGrPxQkR1UsQ1UNAZ73FeMk=@vger.kernel.org
X-Gm-Message-State: AFuF++nphqNk0P73ADrExj9zewy04ueKbPPHJX9dHcd9v+FdGzCcnSEr
	vkk8tVqg8b/N+V7VObBNaub7RjrvvBrC+/X/ZjwEype/MIS8Mr0QQh9dnDVRTlEzPJwyodm3ZDz
	3GQ==
X-Received: from pfiu5.prod.google.com ([2002:a05:6a00:1245:b0:880:ddbf:45a4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1903:b0:886:af7d:f0ef
 with SMTP id d2e1a72fcca58-88af476b157mr613518b3a.6.1790894794627; Thu, 01
 Oct 2026 15:46:34 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:28 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-5-praan@google.com>
Subject: [RFC PATCH 4/7] vfio/type1: Expose IO page table usage via fdinfo
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Logan Odell <loganodell@google.com>

Collect the IO page table usage statistics from each IOMMU domain
attached to a legacy VFIO container and expose that data to userspace via
the new iommu-nr-pages field in fdinfo.

Introduce and implement the get_nr_pages callback for vfio-iommu-type1,
that iterates over all attached domains and aggregates their nr_pages
counters.

Only domains whose page table is implemented by the generic_pt library
account their page table memory. If any domain attached to the container
does not, get_nr_pages() returns -EOPNOTSUPP and the field is omitted
instead of reporting a partial count.

Document the new field in Documentation/filesystems/proc.rst.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 Documentation/filesystems/proc.rst | 17 +++++++++++++++++
 drivers/vfio/container.c           | 21 +++++++++++++++++++++
 drivers/vfio/vfio.h                |  2 ++
 drivers/vfio/vfio_iommu_type1.c    | 21 +++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c102b62023cd..2d06c9930fcf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2200,6 +2200,23 @@ VFIO Device files
 where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
 file.
 
+VFIO Container files
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+	pos:	0
+	flags:	02000002
+	mnt_id:	17
+	ino:	1103
+	iommu-nr-pages:	11
+
+where 'iommu-nr-pages' is the number of pages of memory used by the IO page
+tables of all IOMMU domains attached to the container. It is omitted when no
+IOMMU backend is set, or when any attached domain does not account its IO page
+table memory. Currently only domains using the generic_pt page table library
+account their IO page table memory.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index 003281dbf8bc..2cb6c5373626 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -7,6 +7,7 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/seq_file.h>
 #include <linux/capability.h>
 #include <linux/iommu.h>
 #include <linux/miscdevice.h>
@@ -384,12 +385,32 @@ static int vfio_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
+static void vfio_fops_show_fdinfo(struct seq_file *m, struct file *filep)
+{
+	struct vfio_container *container = filep->private_data;
+	long nr_pages = -EOPNOTSUPP;
+
+	down_read(&container->group_lock);
+	if (container->iommu_driver && container->iommu_driver->ops->get_nr_pages)
+		nr_pages = container->iommu_driver->ops->get_nr_pages(container->iommu_data);
+	up_read(&container->group_lock);
+
+	/* Only report a count that covers every domain in the container */
+	if (nr_pages >= 0)
+		seq_printf(m, "iommu-nr-pages:\t%ld\n", nr_pages);
+}
+#endif
+
 static const struct file_operations vfio_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vfio_fops_open,
 	.release	= vfio_fops_release,
 	.unlocked_ioctl	= vfio_fops_unl_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= vfio_fops_show_fdinfo,
+#endif
 };
 
 struct vfio_container *vfio_container_from_file(struct file *file)
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..37e8841ad0e9 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -226,6 +226,8 @@ struct vfio_iommu_driver_ops {
 				  void *data, size_t count, bool write);
 	struct iommu_domain *(*group_iommu_domain)(void *iommu_data,
 						   struct iommu_group *group);
+	/* Returns IO page table pages used, or -EOPNOTSUPP if not accounted */
+	long		(*get_nr_pages)(void *iommu_data);
 };
 
 struct vfio_iommu_driver {
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..fc7c1553d574 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3249,6 +3249,26 @@ vfio_iommu_type1_group_iommu_domain(void *iommu_data,
 	return domain;
 }
 
+static long vfio_iommu_type1_get_nr_pages(void *iommu_data)
+{
+	struct vfio_iommu *iommu = iommu_data;
+	struct vfio_domain *d;
+	long total = 0;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		/* Only generic_pt page tables account their pages */
+		if (!d->domain->is_iommupt) {
+			total = -EOPNOTSUPP;
+			break;
+		}
+		total += atomic_long_read(&d->domain->nr_pages);
+	}
+	mutex_unlock(&iommu->lock);
+
+	return total;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3263,6 +3283,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.unregister_device	= vfio_iommu_type1_unregister_device,
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
+	.get_nr_pages		= vfio_iommu_type1_get_nr_pages,
 };
 
 static int __init vfio_iommu_type1_init(void)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

