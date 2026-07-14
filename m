Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955884A13AD
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042122; cv=none; b=cacszN+YOESL3wxIogjJvS1QxDJPwKtRM1satLs/HjAOS2KeWZ+aPMPrVl0KNRODg8BBLwW4AUWy7Z9TBden2MJwvLL1dE97dADsxmdFGBrvT13vdwCukY3eN+N2QZYIMnMrV8oZttHdvCIHu0e1D/vdEyljVo+s2HM39LqUKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042122; c=relaxed/simple;
	bh=5cybhF/vC+0B3zoCTwUJxRWAum92bZ7tlfrTb6K+VF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fN2gyj9qKmC5JiNMcFUhHOCCDlxkuQEulNDL5AvJggN/FI6j4xQh4KDkuWc8EVnufuF8tLP5A4uqdp5VBYg4JHPniUkRThTaXFhzxdmHRhBUQmcGyuiNyAJDCRjFENPMM3lIqdnrCW5Hy7wi118nmMWbXImCB7ggmHM+CayZ0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNW4KZRb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNW4KZRb"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8488ac68185so6844019b3a.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042120; x=1784646920; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EHEoo7An3D7oI8NS/D99aTdGzqKD9FxsvRgklpMZ9w=;
        b=qNW4KZRbrG2kB6r0yIfOt3gdhcotMM0JJeeAGkxE91nPczQMU2SR0Nt88xBXgA7O5m
         6AU5D0HIle3T4QU1OD0WDFpriWYIL9p4CYlYBNApsPEkNhsVYtxEoXY1/KLTWypKati0
         m+YmhLlVHavoWXie74vUdsNcqOugpx5m2qkf9bRtyZ1K5MMmhVDqKc8g5xIJRHDPrrui
         G3w3SryPzflqgGGSs3Pq3j/nIYFtn8bNxTscO3eJq76yUyfVNR5fXjnVTgbOJu9zY761
         A/GbFx16rTUKw4sSux1c62Gl8WOpB/MVKlq8y6/3dFJ44fXhJ0w9m2iiZf6aJQr9RD0D
         wL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042120; x=1784646920;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EHEoo7An3D7oI8NS/D99aTdGzqKD9FxsvRgklpMZ9w=;
        b=KK2HELKQ8jhFTA/RygxTcIez0tNXzsH7gRHG1RyM/VcFt0QA5A/B4VCkEu7Gyc/rE5
         pRf3e002Ny0dwLd8ZoJwIMoGL2mSzQm1btu1AnvbZHVkYsGB1291MQaOgs1BPuJcy7XA
         2ZYyhjOFu2//rRcMoDawUJ22KyPB3oDHHwLjHbq0MXvjFl0GNhf+1IJJUhDHNLvL2EzG
         JG+Btz4RMB1eeUKhEpRzBz6PiWIRctaghFX2wtrpxsFbmiJu0OP+AIJ42o0jMJzZdPr3
         3961cWFtj30yOK5O+1rkzH2l2jC8iNF5EAeXieGZkS0gyKr4Uwgitp7HXeBWWaLFUPjt
         Je2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp5D/EHInQSIZ1ApUemLHNCtDSa+KlAP6jRfMjd2Oks7rMUI7xDdgc9P5F+Ct81RhUH2GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJQQCky5EuYJh5Iq59beie78l6qhsXYc9IrselBWPPpFyLdOQ
	CMkh/QqsX/FXu0ygsnAeZTlg1jTgGvyjLNlBD4gwc5MH2pyXm72ZmGDeIDoj8ttfM8ehSl1ElZD
	3NvTLUmactA==
X-Received: from pfbdi5.prod.google.com ([2002:a05:6a00:4805:b0:848:4690:d658])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c081:b0:84a:2d5c:528c
 with SMTP id d2e1a72fcca58-84a2d5c562cmr6425028b3a.61.1784042119955; Tue, 14
 Jul 2026 08:15:19 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:55 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-11-vipinsh@google.com>
Subject: [PATCH v5 10/20] vfio/pci: Retrieve preserved device files after Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Enable userspace to retrieve preserved VFIO device files from VFIO after
a Live Update by implementing the retrieve(), can_finish() and finish()
file handler callbacks.

During retrieve, find the VFIO device using the BDF and domain
information from the serialized state, and open it using the new
vfio_device_liveupdate_cdev_open() API.

Disallow Live Update to finish if userspace hasn't opened the file
successfully or any error occurred during retrieve.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_liveupdate.c | 64 +++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index e6eb7f6b53d7..4baac80d03f0 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -39,7 +39,13 @@
  *    preserved, so there is no way for the file to be destroyed or the device
  *    to be unbound from the vfio-pci driver while it is preserved.
  *
- * Retrieving the file after kexec is not yet supported.
+ * After kexec, the preserved VFIO device file can be retrieved from the session
+ * just like any other preserved file::
+ *
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+ *   device_fd = arg.fd;
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
  * Restrictions
  * ============
@@ -93,6 +99,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -223,13 +230,65 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
 	return 0;
 }
 
+static int match_device(struct device *dev, const void *arg)
+{
+	struct vfio_device *device = container_of(dev, struct vfio_device, device);
+	const struct vfio_pci_core_device_ser *ser = arg;
+	struct pci_dev *pdev;
+
+	pdev = dev_is_pci(device->dev) ? to_pci_dev(device->dev) : NULL;
+	if (!pdev)
+		return false;
+
+	return ser->bdf == pci_dev_id(pdev) && ser->domain == pci_domain_nr(pdev->bus);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_device *device;
+	struct file *file;
+	int ret = 0;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	device = vfio_find_device(ser, match_device);
+	if (!device)
+		return -ENODEV;
+
+	file = vfio_device_liveupdate_cdev_open(device);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
+	args->file = file;
+out:
+	/* Drop the reference from vfio_find_device() */
+	vfio_device_put_registration(device);
+	return ret;
+
+}
+
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device;
+
+	if (args->retrieve_status <= 0)
+		return false;
+
+	device = vfio_device_from_file(args->file);
+	guard(mutex)(&device->dev_set->lock);
+	return vfio_device_cdev_opened(device);
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_finish(to_pci_dev(device->dev));
+	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -238,6 +297,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
-- 
2.55.0.795.g602f6c329a-goog

