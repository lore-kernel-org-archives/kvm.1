Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011822;
	b=en1NLit7Szg8xcKXrGWcZvEkbLWy0OJ9C4nrFK3GDtw2+MWQCS+d9l6hygNDinokqkuv
	 24es6XMSmjwHHB7mA8qApW9cHJJilP3f8fSVYt83/zcQ6owr3txJ/btzq6QSKYco1aNi5
	 isjQaNQTI3VuNGw12JKvmVv6U6DEIEXt00dDWRptBGWu97B5sgmRGdMaRnoLMGwXXsUXH
	 MWE8U61jQSVa9XDds3rLM5xMxyE2ji6UoL0Q13Nv/Vn5NudPmW5PwOgW1oiiu97o00lbi
	 3aDPCfYMf16aPFHEHhnWZqB8ra5hid/0xXVRTLaoYGUCl3K5EqO24Q2qDRyGZT1VZfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011822;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=VXEN2fX4IZspMfQCjFNkasyktSzz9/ubEwayDCWJkus=;
	b=C3ARIJ4F9zf+e38mEYZk+Lmh+tMvDf85/VosXLl22ua4k07t4T4ubXlKKWqZhCVJGxIs
	 twWRz89C7zOHCXoscRjiOfv56/iUVUZ7s5+QMCNCaNuRjTRqWwDwA0RoMwP7pwdmjCObj
	 6ASBIF5qsos+fryGK5kmKKKHfQND2je8QmXIxKDpyualiLWUbf8n6b/TLzyJvJKWEaZ4Y
	 ui0EcJRtQrZVR2lZl5tKaAzC5KGxSIxz3+nd513LrtsZqKNS/fAtp5HH8nkkoo+V57ZLQ
	 rA0uLoXCeqt3EHda0PtGascw2Bm4DEaG/JQfVZwQ2pNf5fyxSGj9bMu3iuKc5UZA4PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqIRBYJu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DBE606EEB8;
	Sat,  7 Nov 2026 00:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqIRBYJu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011821;
	b=rSKq5sNG5Gj7gIOhZXrVqFdCXSwy6ApZkCTDorCx+qx2Sq70zpqbg+aKMF6MeLf2V5nj
	 KTqsw3DGwV74xNre4PWk2L9KqHQO58ewZpmt/bGEstqOyjftc/snnSgyDqsKRQBq+XFnJ
	 soGibdrwZhnO5rwi7U9g+vQf1fekeWF5ZMAArCcyVnmbatum79EJ4xajak6V8OQR8sIKx
	 DWCV7gjwi7GnhdIlwhfr+ZpPea13xbzc2hDjktNtscjG9bsiOVXzaQn3FeVCjR1kRyswZ
	 p4ecTBI46ENAw4dx0V9G9NqaVTwPGit7Z/4gzli3cO8ul4KmHQF7W/RIAMLA5SLx9Cg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011821;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VXEN2fX4IZspMfQCjFNkasyktSzz9/ubEwayDCWJkus=;
	b=b3Hx05ywh8qL/e9wDHvUL1bD41rTLNxFBliU2BcmHupPye8irVAtgoj/EbPvFZJK07aF
	 7f6FlvUnbV7Zdv2Oy0oAdD034CjbvY4eyrPIjLuC0o4zXvuRZZp06Sml+PnnRFWQerRrH
	 0i4IBpeC+eaPA8y6FxdEDcKdus58uBeGr5DPpbHZP5V8iBNnrQJ5Wc/qTnS+Ayn9PZMbp
	 E2CwWxbBj06iqe+OGRVuW6ytt6eefGiPc5TvX3qkuhdlJaxnG/AjBJjlednyYoPfnouwG
	 R2wHsQdQPXgY4ZJg2cjeCe4ePJjE7l7xw2fhpa98scuR7mFETuVje7wuIKOYZCIOjqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 822B01F0089F;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011821;
	bh=VXEN2fX4IZspMfQCjFNkasyktSzz9/ubEwayDCWJkus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CqIRBYJuBQm1T3h2S6fC0yitfwcQuoBnf754Uh1Dz1I/iQhfxzFkuIlN+U1E9KDov
	 x469opBxGeSGfiK7KZXpsGupOTQ/M71ndw9OOOgTp9z8tESAu2rgWbK1AXmBzU2mPX
	 c7TxDqePJS9LS6lbLe2I0mg2mNVBPAChelWsBYMZEpbXu1owWehdJTNlqBd4pLHSf/
	 grB1ViPYwd621MiZaVNs5ajTiVBweGsz0MplcPIB9pBZIiArKZXkdSWb909356wAoW
	 cD7lOJWEMPZuYjBwe4k8goILNG9Q+/YKI6Qg+vZQevR0dJ4Wsq+GPdroWcZ1k2G6q1
	 6kX0NwtG0wgbg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 641A247967;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:55 -0800
Subject: [PATCH RFC v3 21/88] samples/kvm: Support creating memory provider
 files
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-gmem-alternative-providers-v3-21-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=4749;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=XXTp8SdWg70OOlSfykbRC6MejUHDWKPgp0+KOuBNidk=;
 b=5RFhXgQAErb6ooWSjO2h2LLuBNBG+M12psdrf0zRpmzprvoxOn5g77SsRgDZdK81NEofXQKVd
 ZjHGZkeX1tqBraGtNTCPyfLjAP17YEJOBXzIpgHtEfmSANNbl79366s
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Fred Griffoul <fgriffo@amazon.co.uk>

Support creating memory provider files via the MP_NEW_FILE ioctl on the
control device.

Allocating contiguous physical memory at file creation time ensures that
every provider file descriptor exists in a fully initialized state with a
fixed physical page range throughout its lifetime. When the provider file
is closed, free the contiguous memory range and release the associated
tracking metadata.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/memory_provider.c | 110 ++++++++++++++++++++++++++++++++++++++++++
 samples/kvm/memory_provider.h |  30 ++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index d5272cb88b758..e89ce55a357c0 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -2,15 +2,125 @@
 /*
  * memory_provider - a sample memory provider.
  *
+ * The module provides physical memory through provider files.
+ *
+ * The control device /dev/memory_provider creates provider files.
+ * Each file allocates its own contiguous memory from alloc_contig_pages().
+ * See memory_provider.h.
+ *
  * Confidential VMs are not supported.
  */
 
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/gfp.h>
 #include <linux/miscdevice.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "memory_provider.h"
+
+/*
+ * One provider file.
+ */
+struct mp_info {
+	unsigned long base_pfn;
+	unsigned long npages;
+	struct page *cma_pages;		/* from alloc_contig_pages() */
+};
+
+static int mp_file_release(struct inode *inode, struct file *file)
+{
+	struct mp_info *info = file->private_data;
+
+	if (info->cma_pages)
+		free_contig_range(info->base_pfn, info->npages);
+	kfree(info);
+	return 0;
+}
+
+static const struct file_operations mp_file_fops = {
+	.owner		= THIS_MODULE,
+	.release	= mp_file_release,
+};
+
+static long mp_ctl_new_file(void __user *uarg)
+{
+	struct mp_new_file nf;
+	struct mp_info *info;
+	struct page *pages;
+	struct file *file;
+	unsigned long npages;
+	int fd, ret;
+
+	if (copy_from_user(&nf, uarg, sizeof(nf)))
+		return -EFAULT;
+	if (nf.flags || nf.pad)
+		return -EINVAL;
+	if (!nf.size || !PAGE_ALIGNED(nf.size))
+		return -EINVAL;
+
+	npages = nf.size >> PAGE_SHIFT;
+
+	info = kzalloc_obj(*info);
+	if (!info)
+		return -ENOMEM;
+
+	pages = alloc_contig_pages(npages, GFP_KERNEL | __GFP_ZERO,
+				   numa_node_id(), NULL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto err_free_info;
+	}
+
+	info->cma_pages = pages;
+	info->base_pfn = page_to_pfn(pages);
+	info->npages = npages;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto err_free_pages;
+	}
+
+	file = anon_inode_getfile("[memory-provider]", &mp_file_fops,
+				  info, O_RDWR);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		ret = PTR_ERR(file);
+		goto err_free_pages;
+	}
+
+	fd_install(fd, file);
+	return fd;
+
+err_free_pages:
+	free_contig_range(page_to_pfn(pages), npages);
+err_free_info:
+	kfree(info);
+	return ret;
+}
+
+static long mp_ctl_ioctl(struct file *file, unsigned int cmd,
+			 unsigned long arg)
+{
+	void __user *uarg = (void __user *)arg;
+
+	switch (cmd) {
+	case MP_NEW_FILE:
+		return mp_ctl_new_file(uarg);
+	default:
+		return -ENOTTY;
+	}
+}
 
 static const struct file_operations mp_ctl_fops = {
 	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= mp_ctl_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static struct miscdevice mp_dev = {
diff --git a/samples/kvm/memory_provider.h b/samples/kvm/memory_provider.h
new file mode 100644
index 0000000000000..0bd9e250aeaf5
--- /dev/null
+++ b/samples/kvm/memory_provider.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SAMPLES_KVM_MEMORY_PROVIDER_H
+#define _SAMPLES_KVM_MEMORY_PROVIDER_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/*
+ * A sample memory provider.
+ *
+ * Every fd that this module returns is a provider file. Pass it to
+ * KVM_CREATE_GUEST_MEMFD.
+ */
+
+#define MP_IOCTL_BASE		'P'
+
+/*
+ * ioctl on /dev/memory_provider: create a new provider fd of @size.
+ * Returns the provider fd.
+ */
+struct mp_new_file {
+	__u32 flags;	/* Reserved, must be 0 */
+	__u32 pad;
+	__u64 size;	/* bytes, page aligned */
+};
+
+#define MP_NEW_FILE \
+	_IOW(MP_IOCTL_BASE, 5, struct mp_new_file)
+
+#endif /* _SAMPLES_KVM_MEMORY_PROVIDER_H */

-- 
2.56.0.455.g6c5a503b38-goog


