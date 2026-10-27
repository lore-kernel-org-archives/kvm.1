Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116037;
	b=us+/Xv9c9yM0XmL8QAdISD6OssYkdlaNZf4cxFVgYbPD+XrZUH5GzYpTbWr8OMAgKCGS
	 FeZAxVM04V9JHmsn2/ptt8c0POliXBs70TFPJhUNavPgt4BYRec677j7+CmdyOP3aje1u
	 Xx6SQwmnKK148LK8ThmJS0GJf+bEdhBYTkrMYze3ZGuA3M3heQf8sZT/bJt1+jcYToAQc
	 7Iu7rJ5lw2yyWgjH4c+/QETqFPsrETErz49Ve4dpA276/Fym7iRtQXLArLjJkGUHfFo+X
	 E7jYYRfyGDKvzXoOqYMBaEXm7B/tncYZqIAmfr4bgI7tqmcaHgDT4uIcHph/2x2AXzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HZh4WI6iG7eVBAQLCE+rfkIurvL6oSlg1UPzN6ojlZg=;
	b=ngQWue4WI+IkE09A9W/jgIdV/8hQKNlQkXHjWdNUjREdYTp3VSVoy8aEuc14sjnVQVMs
	 +euq6UfGGo5mGB9uuP8AhZutEpHIqyg+g6dDbnxagvVWvgSK+4wQM7nS/B9szMpNPk96K
	 oeJV9BZae/g0fn52nKvgGWSlAYG9g1ltTb3RSp3YJO9Yqm6muHznzTVM7F2JJhsrggNhG
	 cAfXK65in7acGa7UOUIsmv/hsK7h8K5I/chbpgsk2gyQpES4nLIB0FW9MAe9KDlEjbL9M
	 +5YVmjGZlFqHN6YJKKx7THVLzd+f3aa1SHGYw6xTLTPRi7iaEcN5CDO4ExzMrwwDUNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBtLLjVL;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784F606DA21
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0784F606DA21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBtLLjVL
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so3563216f8f.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116035; x=1793720835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HZh4WI6iG7eVBAQLCE+rfkIurvL6oSlg1UPzN6ojlZg=;
        b=gBtLLjVLT4BjTVlQZ+Ej1ypLY2Tfmti1Ub4RN+AeTdnwL4IkOKiDmdt4QJCo3OXK1d
         AGCLrtmyV42bdwvZLirsDfRNuVZvdzkK+wmskVpJPHm1eBcTTYmzRXcwbk9kYOUgx/z7
         +aU9qa/Q8tTbBW86+9vl5gTxsJZL9AGEco/c3lwooaNCTKsLJ+kQixjP85paOBakoXGP
         I3+0+mZ8QLcW2VUb8E6+lpv9VjmVAUR7XVrhLRD7RZbJEofcDQjI4VFKxKHYeZPRv/KW
         +UE3ceCHRDuqxAGgMrYpbJmz3ozD7cJHmwRORVKz4/9k7EqBn+eOPuX9ZM++vf8xrVaS
         8QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116035; x=1793720835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZh4WI6iG7eVBAQLCE+rfkIurvL6oSlg1UPzN6ojlZg=;
        b=hft8FpAqEZNY26nbf/mVRzqsA6iEsfFcMi3DeSQRtUiut+VlG4ZvvW5En3+Z59mNVg
         oDhO9D1BxSBAOhpxjZfTOpZPGcjoz18e1pRSjbnnl7yFpZsCntA8zjqWrhBCIUpeila5
         3nZrQ19qh/HphFfUf0RAPI2x+7UMkamaF9jZIUaajnX8dkBTmt+tmYg+BVyjI48Ki9wC
         iAHOEjvNA5DBvgFLqpf2zZONIEasNw81QMPII9L/hrF87yupw3ejbDAmrKnyLyUHY/Pg
         nMDtqaPi4acR7g8847piY8qy91n3I/YpwbI+ORSVhR0LI9DxQv6Rj+xocIdKOsW5j4i7
         0etQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoLluDOYiOKf53/tu+7TAQMN0msE8LpGebrooEvP75so2SqXQz6WUhE9KfMJnIDWK52Xc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKERglVYUA+CIlMb9nSMNSEI9w36+vO/nTh5KW+O4BA1Mj1oXZQ
	QGJrtJ73yIO36DBsRYEqVV47bPJud6oAopfuinfkmqNX93jjjvRDGPZB
X-Gm-Gg: AYBFou1EBanRHWvHnrsrOFdxOSTPwVlaf52AhwzFgNnsweanOVKXMHJYU/dOnDZ2eyA
	p/GDmrpheHdOKzmhxN98kWN2ZVsOn72BoKTXqrf7Knha6zW/xAkr6IrUN8zUepN1dY8nldct6qq
	4lit72vXTcmAkLmSFnt2Cn7py9y6Hhb1GCmoLgrzA+4RDqdwoZOLuTAh5EqbH/XHD5hrmPDgkge
	NBX1V1/xsIlXkYGmeSnw7L9yk/EVAMgdLrH0JXrkz2AHDYPmYuevke45e8//PEsOGMmXCj5W0H6
	rnqXc2qVoYt5wTk3sMHCqqHbWS4Xkj3DyPdLolHxO5EabkEIHzNpve5psctTjR4+PZRMG3KyBUB
	6BAmum/wIbVIOQFFFDRS0j2Pw7MAmyMqYRfsBVVuaW1htP254xmTpr9/wDxAt43dx0vRvCNv4Ms
	kLVGzdQHpyamXwip5r6k/MqLGwOYlIxJFWK4/qVouzU7Ju5oQXMyASs2kJvhv+cDS1013ykkE+C
	g1r6wyd9AUu1PhPUJ3SrVjXz9iAAs6T407NvPrQZwk4qytd/S343ku9TpKdMRwR/WwLRZaDEDHt
	LTgEQ8j4CdArymURnZaPR6215Qc0dgjL1xKptE/IxfE2CdEFEmUzQ5JDaHWLXRNhPrM2n78kMks
	9trwZTmlKfOfFdkD8
X-Received: by 2002:a05:6000:490d:b0:48e:5550:c64c with SMTP id ffacd0b85a97d-48e5550c68fmr8550797f8f.14.1793116035016;
        Tue, 27 Oct 2026 08:47:15 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:14 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 09/14] iommufd: Map guest_memfd files
Date: Tue, 27 Oct 2026 15:46:44 +0000
Message-ID: <20261027154649.91571-10-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

A VMM that assigns a device to a guest backed by guest_memfd needs the
IOMMU mappings to follow the guest's shared memory. IOMMU_IOAS_MAP_FILE
pins what it maps, which guest_memfd does not allow.

Accept a guest_memfd in IOMMU_IOAS_MAP_FILE through guest_memfd's export
interface: its pages are not pinned, and each update() unmaps the range
and maps what a lookup returns now, read-only frames without write
permission. This is a demonstration: entries are PAGE_SIZE, a device
that touches the range during an update faults, and a range that fails
to map again stays unmapped, with a warning.

Dirty tracking, the no-IOMMU mode, kernel access, splitting an area and
a frame at address 0 are refused, since iommufd could not follow them.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/io_pagetable.c |  14 +-
 drivers/iommu/iommufd/io_pagetable.h |  30 ++-
 drivers/iommu/iommufd/pages.c        | 299 ++++++++++++++++++++++++++-
 include/uapi/linux/iommufd.h         |  11 +-
 4 files changed, 349 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 43d518e4ce58..62fa553cdffc 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -217,9 +217,13 @@ static int iopt_insert_area(struct io_pagetable *iopt, struct iopt_area *area,
 		return -EPERM;
 
 	area->iommu_prot = iommu_prot;
+	area->gmem = iopt_is_gmem(pages);
 	area->page_offset = start_byte % PAGE_SIZE;
 	if (area->page_offset & (iopt->iova_alignment - 1))
 		return -EINVAL;
+	/* guest_memfd frames are mapped whole, see iopt_gmem_map(). */
+	if (area->gmem && (area->page_offset || !PAGE_ALIGNED(length)))
+		return -EINVAL;
 
 	area->node.start = iova;
 	if (check_add_overflow(iova, length - 1, &area->node.last))
@@ -289,6 +293,9 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		case IOPT_ADDRESS_DMABUF:
 			start = elm->start_byte + elm->pages->dmabuf.start;
 			break;
+		case IOPT_ADDRESS_GMEM:
+			start = elm->start_byte + elm->pages->gmem.start;
+			break;
 		}
 		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
@@ -515,8 +522,13 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 		if (!file)
 			return -EBADF;
 
-		pages = iopt_alloc_file_pages(file, start_byte, start, length,
+		/* -ENODEV: not a guest_memfd, so map it as a memfd. */
+		pages = iopt_alloc_gmem_pages(file, start, length,
 					      iommu_prot & IOMMU_WRITE);
+		if (PTR_ERR(pages) == -ENODEV)
+			pages = iopt_alloc_file_pages(file, start_byte, start,
+						      length,
+						      iommu_prot & IOMMU_WRITE);
 		fput(file);
 		if (IS_ERR(pages))
 			return PTR_ERR(pages);
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 0dddfb5db5fd..11e16d22436a 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -6,6 +6,7 @@
 #define __IO_PAGETABLE_H
 
 #include <linux/dma-buf.h>
+#include <linux/guest_memfd.h>
 #include <linux/interval_tree.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
@@ -13,6 +14,8 @@
 
 #include "iommufd_private.h"
 
+struct mem_cgroup;
+
 struct iommu_domain;
 
 /*
@@ -48,6 +51,8 @@ struct iopt_area {
 	/* IOMMU_READ, IOMMU_WRITE, etc */
 	int iommu_prot;
 	bool prevent_access : 1;
+	/* The pages come from a guest_memfd and may have holes */
+	bool gmem : 1;
 	unsigned int num_accesses;
 	unsigned int num_locks;
 };
@@ -191,6 +196,7 @@ enum iopt_address_type {
 	IOPT_ADDRESS_USER = 0,
 	IOPT_ADDRESS_FILE,
 	IOPT_ADDRESS_DMABUF,
+	IOPT_ADDRESS_GMEM,
 };
 
 /* One (area, domain) mapping of revocable pages, on iopt_pages::tracker. */
@@ -207,6 +213,17 @@ struct iopt_pages_dmabuf {
 	unsigned long start;
 };
 
+struct iopt_pages_gmem {
+	struct guest_memfd_export export;
+	/* From symbol_get(): KVM may be a module */
+	typeof(kvm_gmem_export_lookup_pfn) *lookup_pfn;
+	typeof(kvm_gmem_export_detach) *detach;
+	/* Byte offset in the guest_memfd, always PAGE_SIZE aligned */
+	unsigned long start;
+	/* Charged for the page tables that a fill allocates */
+	struct mem_cgroup *memcg;
+};
+
 /*
  * This holds a pinned page list for multiple areas of IO address space. The
  * pages always originate from a linear chunk of userspace VA. Multiple
@@ -236,6 +253,8 @@ struct iopt_pages {
 		};
 		/* IOPT_ADDRESS_DMABUF */
 		struct iopt_pages_dmabuf dmabuf;
+		/* IOPT_ADDRESS_GMEM */
+		struct iopt_pages_gmem gmem;
 	};
 	bool writable:1;
 	u8 account_mode;
@@ -260,10 +279,15 @@ static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
 	return pages->type == IOPT_ADDRESS_DMABUF;
 }
 
+static inline bool iopt_is_gmem(struct iopt_pages *pages)
+{
+	return pages->type == IOPT_ADDRESS_GMEM;
+}
+
 /* The owner of the pages can revoke them, so their domains are tracked. */
 static inline bool iopt_pages_tracked(struct iopt_pages *pages)
 {
-	return iopt_is_dmabuf(pages);
+	return iopt_is_dmabuf(pages) || iopt_is_gmem(pages);
 }
 
 static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
@@ -285,6 +309,10 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 					   unsigned long start_byte,
 					   unsigned long start,
 					   unsigned long length, bool writable);
+struct iopt_pages *iopt_alloc_gmem_pages(struct file *file,
+					 unsigned long start,
+					 unsigned long length,
+					 bool writable);
 void iopt_release_pages(struct kref *kref);
 static inline void iopt_put_pages(struct iopt_pages *pages)
 {
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index cf0f08c4e9a6..88354aa554cf 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -52,6 +52,7 @@
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/kthread.h>
+#include <linux/memcontrol.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
@@ -238,6 +239,40 @@ static void iommu_unmap_nofail(struct iommu_domain *domain, unsigned long iova,
 	WARN_ON(ret != size);
 }
 
+/*
+ * guest_memfd pages are mapped with PAGE_SIZE entries, and may have holes.
+ * iommu_unmap() stops at the first IOVA that is not mapped, which
+ * iommu_unmap_nofail() warns about, so find the runs that are mapped and
+ * unmap each one, without touching the holes.
+ * iopt_gmem_map() refuses frame 0, which iova_to_phys() reports for
+ * an IOVA that is not mapped.
+ */
+static void iopt_gmem_unmap(struct iopt_area *area,
+			    struct iommu_domain *domain,
+			    unsigned long start_index,
+			    unsigned long last_index)
+{
+	unsigned long iova = iopt_area_index_to_iova(area, start_index);
+	size_t left = (last_index - start_index + 1) * PAGE_SIZE;
+
+	/* A guest_memfd can be large: yield, once per page scanned. */
+	while (left) {
+		size_t len = 0;
+
+		while (len < left && iommu_iova_to_phys(domain, iova + len)) {
+			len += PAGE_SIZE;
+			cond_resched();
+		}
+		if (len)
+			iommu_unmap_nofail(domain, iova, len);
+		/* Step over the run and the hole page that ended it. */
+		len = min(len + PAGE_SIZE, left);
+		iova += len;
+		left -= len;
+		cond_resched();
+	}
+}
+
 static void iopt_area_unmap_domain_range(struct iopt_area *area,
 					 struct iommu_domain *domain,
 					 unsigned long start_index,
@@ -245,6 +280,11 @@ static void iopt_area_unmap_domain_range(struct iopt_area *area,
 {
 	unsigned long start_iova = iopt_area_index_to_iova(area, start_index);
 
+	if (area->gmem) {
+		iopt_gmem_unmap(area, domain, start_index, last_index);
+		return;
+	}
+
 	iommu_unmap_nofail(domain, start_iova,
 			   iopt_area_index_to_iova_last(area, last_index) -
 				   start_iova + 1);
@@ -1349,6 +1389,10 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 	    WARN_ON(last_index < start_index))
 		return -EINVAL;
 
+	/* guest_memfd pages are read from guest_memfd, see iopt_gmem_map() */
+	if (WARN_ON(iopt_is_gmem(pages)))
+		return -EINVAL;
+
 	rc = pfn_reader_init(pfns, pages, start_index, last_index);
 	if (rc)
 		return rc;
@@ -1647,6 +1691,230 @@ void iopt_pages_untrack_all_domains(struct iopt_area *area,
 	}
 }
 
+static int iopt_gmem_prot(struct iopt_area *area, u32 attrs)
+{
+	int prot = area->iommu_prot;
+
+	if (attrs & GUEST_MEMFD_PFN_READONLY)
+		prot &= ~IOMMU_WRITE;
+	return prot;
+}
+
+/*
+ * Map what guest_memfd backs in [start_index, last_index] of the area into
+ * @domain, with PAGE_SIZE entries, so that updating part of a large block
+ * never has to cut a larger IOMMU page.  On failure, nothing in the range is
+ * mapped.
+ */
+static int iopt_gmem_map(struct iopt_area *area, struct iopt_pages *pages,
+			 struct iommu_domain *domain, unsigned long start_index,
+			 unsigned long last_index)
+{
+	struct guest_memfd_export *e = &pages->gmem.export;
+	unsigned long base = pages->gmem.start >> PAGE_SHIFT;
+	unsigned long index = start_index;
+	int rc = 0;
+
+	lockdep_assert_held(&pages->mutex);
+
+	/* A revoke would race a dirty bitmap read and lose its dirty bits. */
+	if (domain->dirty_ops)
+		return -EOPNOTSUPP;
+
+	/* The device of a no-IOMMU domain keeps the addresses after a revoke. */
+	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
+	    domain->owner == &iommufd_noiommu_ops)
+		return -EOPNOTSUPP;
+
+	while (index <= last_index) {
+		unsigned long pfn, iova, end, nr;
+		/* No larger than the rest of the range: holes cost per page. */
+		int order = min_t(int, PUD_ORDER, fls_long(last_index - index));
+		u32 attrs;
+		int prot;
+
+		cond_resched();
+
+		rc = pages->gmem.lookup_pfn(e, base + index, &pfn, &order,
+					    &attrs);
+		/* The aligned block of frames, or of holes, around index. */
+		end = ALIGN(base + index + 1, 1UL << order) - base;
+		nr = min(end, last_index + 1) - index;
+		if (rc == -ENOENT) {
+			index += nr;
+			continue;
+		}
+		/* Frame 0 would look unmapped to iopt_gmem_unmap(). */
+		if (!rc && !pfn)
+			rc = -EINVAL;
+		if (rc)
+			goto err_unmap;
+
+		iova = iopt_area_index_to_iova(area, index);
+		prot = iopt_gmem_prot(area, attrs);
+
+		/* A read-only frame in an area that is not readable: a hole. */
+		if (!(prot & (IOMMU_READ | IOMMU_WRITE))) {
+			index += nr;
+			continue;
+		}
+
+		rc = batch_iommu_map_small(domain, iova, PFN_PHYS(pfn),
+					   nr * PAGE_SIZE, prot);
+		if (rc)
+			goto err_unmap;
+		index += nr;
+	}
+	return 0;
+
+err_unmap:
+	if (index > start_index)
+		iopt_gmem_unmap(area, domain, start_index, index - 1);
+	return rc;
+}
+
+/* Map the whole area into every domain of its io_pagetable. */
+static int iopt_gmem_fill_domains(struct iopt_area *area,
+				  struct iopt_pages *pages)
+{
+	struct iommu_domain *domain, *undo;
+	unsigned long index, undo_index;
+	int rc;
+
+	xa_for_each(&area->iopt->domains, index, domain) {
+		rc = iopt_gmem_map(area, pages, domain, iopt_area_index(area),
+				   iopt_area_last_index(area));
+		if (rc)
+			goto err_unmap;
+	}
+	return 0;
+
+err_unmap:
+	xa_for_each(&area->iopt->domains, undo_index, undo) {
+		if (undo_index >= index)
+			break;
+		iopt_gmem_unmap(area, undo, iopt_area_index(area),
+				iopt_area_last_index(area));
+	}
+	return rc;
+}
+
+/*
+ * guest_memfd says that what [start, start + nr_pages) of the file holds may
+ * have changed: in every (area, domain) over part of it, unmap that part and
+ * map what guest_memfd backs now.  A device that accesses it in between, or
+ * after a failure to map, faults.
+ */
+static void iopt_gmem_update(struct guest_memfd_export *e, pgoff_t start,
+			     pgoff_t nr_pages)
+{
+	struct iopt_pages *pages =
+		container_of(e, struct iopt_pages, gmem.export);
+	pgoff_t base = pages->gmem.start >> PAGE_SHIFT;
+	struct iopt_pages_track *track;
+	struct mem_cgroup *old_memcg;
+	unsigned long first, last;
+
+	if (start + nr_pages <= base || start >= base + pages->npages)
+		return;
+	first = max(start, base) - base;
+	last = min(start + nr_pages, base + pages->npages) - base - 1;
+
+	guard(mutex)(&pages->mutex);
+	/* The page tables belong to whoever mapped the file, not to this task. */
+	old_memcg = set_active_memcg(pages->gmem.memcg);
+	list_for_each_entry(track, &pages->tracker, elm) {
+		struct iopt_area *area = track->area;
+		unsigned long s = max(first, iopt_area_index(area));
+		unsigned long l = min(last, iopt_area_last_index(area));
+
+		if (s > l)
+			continue;
+		iopt_gmem_unmap(area, track->domain, s, l);
+		if (iopt_gmem_map(area, pages, track->domain, s, l))
+			pr_warn_ratelimited("iommufd: guest_memfd pages left unmapped after an update\n");
+	}
+	set_active_memcg(old_memcg);
+}
+
+static const struct guest_memfd_export_ops iopt_gmem_export_ops = {
+	.update	= iopt_gmem_update,
+};
+
+/**
+ * iopt_alloc_gmem_pages() - Pages backed by a guest_memfd file
+ * @file: The file
+ * @start: Byte offset in the file
+ * @length: Number of bytes
+ * @writable: The pages may be mapped writable
+ *
+ * The pages are not pinned, and every domain that maps them follows
+ * guest_memfd's changes.
+ *
+ * Return: the pages, ERR_PTR(-ENODEV) if @file is not a guest_memfd file, or
+ * another ERR_PTR().
+ */
+struct iopt_pages *iopt_alloc_gmem_pages(struct file *file,
+					 unsigned long start,
+					 unsigned long length,
+					 bool writable)
+{
+	static struct lock_class_key pages_gmem_mutex_key;
+	int (*attach)(struct file *file, struct guest_memfd_export *e);
+	struct iopt_pages *pages;
+	unsigned long end;
+	int rc;
+
+	/* KVM may be a module, or not loaded: then this is no guest_memfd. */
+	attach = symbol_get(kvm_gmem_export_attach);
+	if (!attach)
+		return ERR_PTR(-ENODEV);
+
+	pages = iopt_alloc_pages(0, length, writable);
+	if (IS_ERR(pages))
+		goto out_put;
+
+	/*
+	 * Pinned pages take the mmap_lock under their mutex.  The mutex of
+	 * guest_memfd pages is taken under guest_memfd's invalidate lock, which
+	 * nests in the mmap_lock of a host fault, so give it its own class.
+	 */
+	lockdep_set_class(&pages->mutex, &pages_gmem_mutex_key);
+
+	/* guest_memfd pages are not pinned, so they are not accounted. */
+	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
+	pages->type = IOPT_ADDRESS_GMEM;
+	pages->gmem.start = start;
+	pages->gmem.export.ops = &iopt_gmem_export_ops;
+
+	rc = attach(file, &pages->gmem.export);
+	if (rc) {
+		iopt_put_pages(pages);
+		pages = ERR_PTR(rc);
+		goto out_put;
+	}
+
+	if (check_add_overflow(start, length, &end) ||
+	    end > i_size_read(file_inode(file))) {
+		rc = -EINVAL;
+		goto err_detach;
+	}
+
+	/* The file holds the KVM module from here on. */
+	pages->gmem.lookup_pfn = symbol_get(kvm_gmem_export_lookup_pfn);
+	pages->gmem.detach = symbol_get(kvm_gmem_export_detach);
+	pages->gmem.memcg = get_mem_cgroup_from_mm(current->mm);
+	goto out_put;
+
+err_detach:
+	pages->gmem.detach = symbol_get(kvm_gmem_export_detach);
+	iopt_put_pages(pages);
+	pages = ERR_PTR(rc);
+out_put:
+	symbol_put(kvm_gmem_export_attach);
+	return pages;
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1664,6 +1932,14 @@ void iopt_release_pages(struct kref *kref)
 		dma_resv_unlock(dmabuf->resv);
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
+	} else if (iopt_is_gmem(pages)) {
+		if (pages->gmem.detach) {
+			pages->gmem.detach(&pages->gmem.export);
+			symbol_put(kvm_gmem_export_detach);
+		}
+		if (pages->gmem.lookup_pfn)
+			symbol_put(kvm_gmem_export_lookup_pfn);
+		mem_cgroup_put(pages->gmem.memcg);
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
@@ -1814,6 +2090,12 @@ static void iopt_area_unfill_partial_domain(struct iopt_area *area,
  */
 void iopt_area_unmap_domain(struct iopt_area *area, struct iommu_domain *domain)
 {
+	if (area->gmem) {
+		iopt_gmem_unmap(area, domain, iopt_area_index(area),
+				iopt_area_last_index(area));
+		return;
+	}
+
 	iommu_unmap_nofail(domain, iopt_area_iova(area),
 			   iopt_area_length(area));
 }
@@ -1857,6 +2139,11 @@ int iopt_area_fill_domain(struct iopt_area *area, struct iommu_domain *domain)
 	if (iopt_dmabuf_revoked(area->pages))
 		return 0;
 
+	if (iopt_is_gmem(area->pages))
+		return iopt_gmem_map(area, area->pages, domain,
+				     iopt_area_index(area),
+				     iopt_area_last_index(area));
+
 	rc = pfn_reader_first(&pfns, area->pages, iopt_area_index(area),
 			      iopt_area_last_index(area));
 	if (rc)
@@ -1922,7 +2209,11 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 			goto out_unlock;
 	}
 
-	if (!iopt_dmabuf_revoked(pages)) {
+	if (iopt_is_gmem(pages)) {
+		rc = iopt_gmem_fill_domains(area, pages);
+		if (rc)
+			goto out_untrack;
+	} else if (!iopt_dmabuf_revoked(pages)) {
 		rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
 				      iopt_area_last_index(area));
 		if (rc)
@@ -2361,7 +2652,7 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
-	if (iopt_is_dmabuf(pages))
+	if (iopt_is_dmabuf(pages) || iopt_is_gmem(pages))
 		return -EINVAL;
 
 	if (pages->type != IOPT_ADDRESS_USER)
@@ -2453,6 +2744,10 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	if (iopt_is_dmabuf(pages))
 		return -EINVAL;
 
+	/* guest_memfd frames may have no struct page, and are not pinned. */
+	if (iopt_is_gmem(pages))
+		return -EINVAL;
+
 	mutex_lock(&pages->mutex);
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..db5f09c21d1f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -252,7 +252,7 @@ struct iommu_ioas_noiommu_get_pa {
  * @size: sizeof(struct iommu_ioas_map_file)
  * @flags: same as for iommu_ioas_map
  * @ioas_id: same as for iommu_ioas_map
- * @fd: the memfd or supported dma-buf file to map
+ * @fd: the memfd, guest_memfd or supported dma-buf file to map
  * @start: byte offset from start of the file to map from
  * @length: same as for iommu_ioas_map
  * @iova: same as for iommu_ioas_map
@@ -263,6 +263,15 @@ struct iommu_ioas_noiommu_get_pa {
  * VFIO PCI dma-bufs exported through VFIO_DEVICE_FEATURE_DMA_BUF, and
  * other dma-bufs may be rejected. All other arguments and semantics match
  * those of IOMMU_IOAS_MAP.
+ *
+ * A guest_memfd is also accepted, with @start and @length page aligned. Its
+ * pages are not pinned: only its shared pages that have memory are mapped, a
+ * page as soon as it gets memory, and the mapping follows conversions, punch
+ * holes and its provider's changes. Read-only pages are mapped without write
+ * permission, or not at all without IOMMU_IOAS_MAP_READABLE. Such a mapping
+ * cannot be split by a partial unmap, accessed by the kernel, moved by
+ * IOMMU_IOAS_CHANGE_PROCESS, or used with dirty tracking or the no-IOMMU mode,
+ * and a page at physical address 0 cannot be mapped.
  */
 struct iommu_ioas_map_file {
 	__u32 size;
-- 
2.47.3

