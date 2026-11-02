Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660691;
	b=uFbPKxiN+ILYRwC5W5jajaG7wQ4a4kSViYp2blSQTQneqEcKIvfzQtbCiQv9+CZw0RpR
	 SsJaBPQI2ZrwXc2HxP24f0csOO225zqT69oQdqDGgzSXZDJSHSdJOOyLHGBPv1L0mBr0E
	 iUyVcJfclEOHQDjiM1TfLw2ti3g0ViGCAfFto5znnxfHG9iIjJTne3F3Ca/O9caIVtYZu
	 JkPtgKyKE2Smgm4yXC8SiHrn/bmkEWvcqfAvMCoi72on5dXfu1ihr/ZatvyuUS723bt5L
	 FlXMHYc2+tCFoi2jbnuIXeyKm9AAZbTXukXSJE1B3i4a0wq5L/e1v3PYvVfd1hY06tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4ItxlYeVr4jZp+R3NA96zGYrogcZtie35UBh8ObNtXk=;
	b=C7Nvc6xDwHM0xqk5lJR205OU6alFKEPAagyg60Ervz7ADHaR/5PPEKRL3mMlnQ1Z5BEF
	 9HvcEeSkK+qv+52ASYZIF+hq9Vd8wDuOgBi9kgx2cVKUrZQs9YWBXY6/DDE1agTNkUW1E
	 +ZbdT/rVRiwA4k6JZ82lv8kHLyMO6svmOiMic5BB6pf0MAmVl2kgnBVQcnUMKsAd8SHMZ
	 vewZvYCM4uTjWOFJiQOme6+scg5hhqBtMuUytbp2oM5us6Y+D+17KaXbcXqWJxm4HXZy9
	 VVfuM/NnQVk53uyM/qetFXuQ8pZuarcmRnOBLUug8Ig7tmBTdm/XU/Le8LYv+/hBwhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="M0r/z25K";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADF606D831
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBADF606D831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M0r/z25K
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so6788675eec.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793660690; x=1794265490; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ItxlYeVr4jZp+R3NA96zGYrogcZtie35UBh8ObNtXk=;
        b=M0r/z25KaiUhDnTQ4GDlHUz/MJMq61W1P5hPJqoT1x4rmzyRP0H5eD0xBnsLGEVO9m
         QRVbJ5ojg/NovNjVzPbqDo9LeydmHq3xE/y9z+KWBTWSdQN087GlDk69PEjbNZB6E6Uw
         94yz8ZJSNfo23LDgURJ8KSZCo1dXXu79m+mNHAwIlUHq2eTWmPKIzmp8BTJcTzl/9Uf2
         9dz6J1n2Jq/TXWHs2cs1J6ZMM3fTJRbOL6W3FRqEDXqZSzot1PzfNoh16Uvtn37DGlNN
         1dtn1V8k83LekNVDtGlgv/n0r0ljKnb00qYo0t0+RN872TnNKJPYthEk3TSjsRfi/IHW
         dfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660690; x=1794265490;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ItxlYeVr4jZp+R3NA96zGYrogcZtie35UBh8ObNtXk=;
        b=xpFz2i99uEz2d9V6a8jJIR6Xx0FSv1vefwNjd1I1IAWwoeAfNYQ7CCqO5enb1kRhMS
         1IA6BS6inTaO07S3qRhTSsomIzOfJh/WZ4lbsk2vVSnapffpbjw9D7+0+7JQmRSkbwVq
         V6T7OYF+xK6EmWAt6kOl41R7pyPcTDA5ZRANG04L+YshAO1KioTtgdPz0UOYpYUjbrmj
         3yA8776g2las/UmXYRE0mkv2onP1tDRy7JZ/yIYIyQkEpU+NbUt9fP8zl95yXPb1T84G
         hsslTfjCHVSeUORpu8/HcJijX2OlB4FUqnr9ez79ew9f35RLJ0kN/cKclg/j/ArK4U7n
         Ognw==
X-Forwarded-Encrypted: i=1; AKwUvBwHa16umesdc/oPzb5eoyJoeBrV51VW8Zi3a5puAxZOENTZradCidBPVHlJpxBYgq5xYDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y3K5VsbjJDtyc5w8/GidKMIHaGnRPl6vBItfnE8b9+RuwDFxM
	U9ESW5dcCHCyswygBFBAebSDjrOCE75yj7ZdJ3X4lJ+C0gep+F3h11t/8qPU432ba8UGNCBzeJY
	muMqASe+vI8B1I7/8GH+rDJGJtQ==
X-Received: from dyec15.prod.google.com ([2002:a05:7300:220f:b0:369:45ee:40a0])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:ae18:b0:369:f035:661 with SMTP id 5a478bee46e88-36a42389027mr14414309eec.15.1793660689624;
 Mon, 02 Nov 2026 15:04:49 -0800 (PST)
Date: Mon,  2 Nov 2026 23:04:45 +0000
In-Reply-To: <20261102230445.3993629-1-almasrymina@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102230445.3993629-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102230445.3993629-4-almasrymina@google.com>
Subject: [PATCH v3 3/3] vfio: selftests: Test BAR write faults after clear_refs
From: Mina Almasry <almasrymina@google.com>
To: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, David Matlack <dmatlack@google.com>, 
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>, 
	Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

Add a regression test in vfio_pci_device_test to verify that huge_fault
on writable MAP_SHARED VFIO PCI BAR mappings handles write faults after
soft-dirty tracking clears VM_SOFTDIRTY and downgrades vma->vm_page_prot
to read-only via /proc/self/clear_refs ("4").

Use vfio_pci_find_mem_bar() to locate a memory-backed BAR of at least
2 MiB that is safe to read and write, and zap existing BAR mappings via
PCI_COMMAND_MEMORY before each sub-test to verify both:

1. Read-then-write fault sequence after clear_refs, exercising in-place
   huge PMD/PUD write-protection upgrade via wp_huge_pmd()/wp_huge_pud().
2. Direct initial write fault on an unpopulated BAR VMA after clear_refs,
   exercising vmf_insert_pfn_pmd()/vmf_insert_pfn_pud() with
   FAULT_FLAG_WRITE set.

Skip gracefully when the device has no known memory-backed BAR >= 2 MiB
or when /proc/self/clear_refs soft-dirty tracking (CONFIG_MEM_SOFT_DIRTY)
is unavailable.

Suggested-by: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>
Cc: Matt Evans <matt@ozlabs.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 .../selftests/vfio/vfio_pci_device_test.c     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 93c11fd5e081..323a316f59e7 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
+#include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -102,6 +105,68 @@ TEST_F(vfio_pci_device_test, validate_bars)
 	}
 }
 
+static void zap_bar_mappings(struct vfio_pci_device *device)
+{
+	vfio_pci_cmd_clear(device, PCI_COMMAND_MEMORY);
+	vfio_pci_cmd_set(device, PCI_COMMAND_MEMORY);
+}
+
+static int clear_soft_dirty_refs(void)
+{
+	ssize_t ret;
+	int fd;
+
+	fd = open("/proc/self/clear_refs", O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = write(fd, "4\n", 2);
+	if (ret < 0)
+		ret = -errno;
+	else
+		VFIO_ASSERT_EQ(ret, 2);
+
+	VFIO_ASSERT_EQ(close(fd), 0);
+	return ret < 0 ? ret : 0;
+}
+
+TEST_F(vfio_pci_device_test, bar_write_fault_after_clear_refs)
+{
+	struct vfio_pci_mem_bar mem_bar;
+	int ret;
+	u32 val;
+
+	if (!vfio_pci_find_mem_bar(self->device, SZ_2M, &mem_bar))
+		SKIP(return, "No memory-backed BAR >= 2M on %s\n", device_bdf);
+
+	zap_bar_mappings(self->device);
+
+	ret = clear_soft_dirty_refs();
+	if (ret == -ENOENT || ret == -EINVAL)
+		SKIP(return, "soft-dirty clear_refs unsupported (%d)\n", ret);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * clear_soft_dirty_refs() stripped write permissions from
+	 * vma->vm_page_prot on the unpopulated BAR mapping. Fault it read-only
+	 * first, then write to exercise in-place write-upgrade
+	 * (wp_huge_pmd/wp_huge_pud).
+	 */
+	val = READ_ONCE(*(u32 *)mem_bar.vaddr);
+	WRITE_ONCE(*(u32 *)mem_bar.vaddr, val);
+
+	/*
+	 * Zap the BAR PTEs/PMDs, clear soft-dirty again, and fault with an
+	 * immediate store to exercise initial write insertion
+	 * (vmf_insert_pfn_pmd/pud with write=true).
+	 */
+	zap_bar_mappings(self->device);
+	ASSERT_EQ(0, clear_soft_dirty_refs());
+
+	WRITE_ONCE(*(u32 *)mem_bar.vaddr, val);
+	(void)READ_ONCE(*(u32 *)mem_bar.vaddr);
+}
+
 FIXTURE(vfio_pci_irq_test) {
 	struct iommu *iommu;
 	struct vfio_pci_device *device;
-- 
2.56.0.385.gac671c819a-goog

