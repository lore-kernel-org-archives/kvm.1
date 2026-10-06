Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7CC4A8A23
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311573; cv=none; b=iWNV/N+nvd6uDNxUV9ebT+g2eDvKhYZeOZmI5YWIesS7AVJ2i3vHIBuJs01Z9z//LnvZiqFFFua14sJ6D9KUIJaV9/lfLk8jrmY063O/KizF1WpHyhQtubLOTlyquyh5L5Cm4I1qin0i3IEwQLrDTFDGNz6o0/+MmGhjNWXm9Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311573; c=relaxed/simple;
	bh=PZoHwLAcac7MRG6rjhbSovKR0ePeapxARS7+LnV4ZIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+A7wx8qhGp1o6jlCtj21yVfJzS3K+/Kd5SvovET5omiVXZEfMlNM04ZffXVEG5wkEwLo02qGfGfRAcU4vZcR2imTuM+NBwDHe7TotdcFp6prd8fmyV/Yrv18As2rHR3Y97aU7rxsYVe207/Yz9sBSS1Xtj2Stm9Ij5zhmtRty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQKGwkYZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQKGwkYZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c315729ad50so134312366b.0
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791311567; x=1791916367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/DDLaBldS6BCqOPBQL7QwFwyovqmKt8FALCheekTNg=;
        b=UQKGwkYZbU5fWG0fyWPiQNAWLasI++YCp6UogLLx45CAG5x+8CZ6zMLQUArhPmPcfJ
         jK6L4NFQPIYzGg1D5vPcK9vzKU+uyfaGgRZPlIJeS+PsbVKIZiY+R4Evw/RnDnPUNdrv
         AJgII3N4gGOk2MwMi3bWAWvQ99tPWI6wpnAKYvV/OPXOK4v8JT0y1QgbYHmoIiWbTO8L
         xFIYIEG8QmD8lKmRhh0moTUC7ZgAnTu3XGrWKFR8rEd5hfjh5HY8JVSOiPa5tXg7hO26
         wMLiltQQRXiPVM/izwVBD1s46EQq8KnPdaOzgd6zCzoeK+w/YDPvuwzkfbkz6bgL5lGF
         CuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791311567; x=1791916367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/DDLaBldS6BCqOPBQL7QwFwyovqmKt8FALCheekTNg=;
        b=dVE1tZyjyhrthcHMiIxFCb3zsU4Oh29PtCrmHinZ6BZo4N1Ez/6+M1oEv27C0nO+vy
         h0rpUcMIJC8/l2Jb+n0Utrle2lz69Jw/tB+y8F7s15MK1doWN/U22i3dJmMy91j54vTI
         xY0OuGwprj9OPWU7KQxFOHiF9jgmLZDzMQYQ0LNf/ZOGdZO+/TYOLRFCCJMEA2oqW5h5
         stHNwKnHmaOU5+RCYtSvjBDkVMby9Q6jAIX9LEwadRTLIKXKReGewQD0bjptUv5pZxHq
         UPZ+qHTwlH+QRj41jFuAuz8gnIv2H2gczwBBFd6R8KmcuMt/cvKr7y8CqEBuuWMem+lJ
         SVDw==
X-Forwarded-Encrypted: i=1; AKwUvBx1auMXieZofYmeR/5jTFmTGnqh6uTX1ErOz1vRGDXoF/ePxfK6fESIDYJOHpR9TAyflMI=@vger.kernel.org
X-Gm-Message-State: AFuF++l4Vn0Oq+wALcQ+OKpKgSkUXInQXB/9vfx/+ap7HGmPRbR+VVwT
	cZ1uILkzkUDLjhLUu+yeUt7hvRfj+jywKo/PMRNCY9070nKc3ozCxCVn
X-Gm-Gg: AYBFou3KtBdJt+9yvjRaqW86xpwLhQ9Ca2U+Tmh15gWOUDa/mHTp9aPIv+OfPdMu/8W
	TOu5va/aeYAl/U8+7FTk4qIZqM65Mvls73WJR0c0V5OXbXPuj/WktmITK33Cm4Sa1ZdFrpNNDdV
	NG7gtVGZJ9h9qUAXwfI58b8fYudSjURQqQ5/f5v6jlKsqF8KMpiP/e2f8WCi/4q3Z9cXkqJuAJa
	ZufCsN/yf9WJhqpLKBU/CVx9UeEMpVfBq3Tsa9H0GwZIE0UwNAmvQQDsPXWNiAv3A3g0znxOPay
	mS9rW/FDVr28syUTaAhkqjjKzhtZi3OspE2KzNYCgGWFtV6h01kisUJfnPAAxjuOmrUDsCzFPff
	jeHFLqZmYW9AieeYVQEWDX2lRn/HMy4seFENlQX/65lTdHO44ZazrkFlFUaBLHVBifV/UBGBNrl
	scbDN2NkaBpHo+CRWGso2UUXoIFeplq/wiFpcv3LCCvcqJfaM7FQY/cP9iNcmwgktyXOsSjV7Ya
	dZ92rLJ3QeC89XCCP02lNcXMlrgC6bgxQf4qiDD74mxQCTnOtadYe+zb9kf0LIxNIltcG+wEaw7
	IuEFYitdNtUUw/9toxrCIJJl6UTvM42nrks=
X-Received: by 2002:a17:907:72d3:b0:c2e:4488:b8a3 with SMTP id a640c23a62f3a-c316a0bb639mr232794566b.33.1791311566749;
        Tue, 06 Oct 2026 11:32:46 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3158260f7bsm221934866b.6.2026.10.06.11.32.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 11:32:46 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 6/9] iommufd/selftest: Add mock-domain IOVA queries
Date: Tue,  6 Oct 2026 18:32:32 +0000
Message-ID: <20261006183235.16576-7-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006183235.16576-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <20261006183235.16576-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

A test of memory that can be taken back or replaced does not know in
advance which frame a device reaches. IOMMU_TEST_OP_MD_CHECK_MAP only
compares against a known buffer.

Add MD_CHECK_MAPPED, which checks that a range is fully mapped or fully
unmapped, and MD_IOVA_TO_PHYS, which returns the frame behind an IOVA,
or 0 if it is unmapped. Both refuse an IOVA outside the domain's
aperture.

Both hold domains_rwsem for writing so that a userspace unmap cannot
free a page-table level during the walk.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/iommufd_test.h |  16 ++++
 drivers/iommu/iommufd/selftest.c     | 109 +++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 52b78cbcc920..28fd9c43edc4 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -31,6 +31,8 @@ enum {
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
 	IOMMU_TEST_OP_DMABUF_GET,
 	IOMMU_TEST_OP_DMABUF_REVOKE,
+	IOMMU_TEST_OP_MD_CHECK_MAPPED,
+	IOMMU_TEST_OP_MD_IOVA_TO_PHYS,
 };
 
 enum {
@@ -193,6 +195,20 @@ struct iommu_test_cmd {
 			__s32 dmabuf_fd;
 			__u32 revoked;
 		} dmabuf_revoke;
+		struct {
+			/*
+			 * 1: every page in [iova, iova+length) must be mapped;
+			 * 0: none of them may be. Mixed is an error.
+			 */
+			__u32 mapped;
+			__u32 __reserved;
+			__aligned_u64 iova;
+			__aligned_u64 length;
+		} check_mapped;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 out_phys;	/* 0 if unmapped */
+		} iova_to_phys;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..1f5cd2d00fda 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2031,6 +2031,107 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/*
+ * True if [iova, iova + length) lies inside the domain's aperture.  Outside
+ * it the page table returns an error code from iova_to_phys(), not 0.
+ */
+static bool mock_domain_covers(struct mock_iommu_domain *mock,
+			       unsigned long iova, size_t length)
+{
+	struct iommu_domain_geometry *geo = &mock->domain.geometry;
+	unsigned long last;
+
+	if (check_add_overflow(iova, length - 1, &last))
+		return false;
+	return iova >= geo->aperture_start && last <= geo->aperture_end;
+}
+
+/*
+ * iova_to_phys() walks the page table, so it must not run while an unmap
+ * frees a level of it.  A userspace unmap holds the IOAS domains_rwsem for
+ * reading while it unmaps the domains, so holding it for writing keeps such
+ * unmaps away.  A memory provider or dma-buf revoke unmaps under its pages
+ * mutex only, so tests must not run these queries while a revoke of the
+ * range is in progress.
+ */
+static struct rw_semaphore *
+mock_domain_unmap_lock(struct iommufd_hw_pagetable *hwpt)
+{
+	return &to_hwpt_paging(hwpt)->ioas->iopt.domains_rwsem;
+}
+
+/*
+ * Report the physical address the mock domain resolves @iova to, or 0 if
+ * it is unmapped.  Lets a test check that two IOVAs share one frame, or that
+ * an IOVA moved to another frame, without knowing the frames in advance.
+ */
+static int iommufd_test_md_iova_to_phys(struct iommufd_ucmd *ucmd,
+					unsigned int mockpt_id,
+					unsigned long iova)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned int page_size;
+	int rc;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
+	if (iova % page_size || !mock_domain_covers(mock, iova, page_size)) {
+		rc = -EINVAL;
+		goto out_put;
+	}
+	down_write(mock_domain_unmap_lock(hwpt));
+	cmd->iova_to_phys.out_phys =
+		mock->domain.ops->iova_to_phys(&mock->domain, iova);
+	up_write(mock_domain_unmap_lock(hwpt));
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put:
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+	return rc;
+}
+
+static int iommufd_test_md_check_mapped(struct iommufd_ucmd *ucmd,
+					unsigned int mockpt_id,
+					unsigned long iova, size_t length,
+					bool mapped)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	unsigned int page_size;
+	int rc = 0;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	page_size = 1 << __ffs(mock->domain.pgsize_bitmap);
+	if (iova % page_size || length % page_size || !length ||
+	    !mock_domain_covers(mock, iova, length)) {
+		rc = -EINVAL;
+		goto out_put;
+	}
+
+	down_write(mock_domain_unmap_lock(hwpt));
+	for (; length; length -= page_size, iova += page_size) {
+		bool is_mapped =
+			mock->domain.ops->iova_to_phys(&mock->domain, iova) != 0;
+
+		if (is_mapped != mapped) {
+			rc = -ENOENT;
+			break;
+		}
+	}
+	up_write(mock_domain_unmap_lock(hwpt));
+
+out_put:
+	iommufd_put_object(ucmd->ictx, &hwpt->obj);
+	return rc;
+}
+
 static int iommufd_test_dmabuf_revoke(struct iommufd_ucmd *ucmd, int fd,
 				      bool revoked)
 {
@@ -2143,6 +2244,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_dmabuf_revoke(ucmd,
 						  cmd->dmabuf_revoke.dmabuf_fd,
 						  cmd->dmabuf_revoke.revoked);
+	case IOMMU_TEST_OP_MD_CHECK_MAPPED:
+		return iommufd_test_md_check_mapped(ucmd, cmd->id,
+						    cmd->check_mapped.iova,
+						    cmd->check_mapped.length,
+						    cmd->check_mapped.mapped);
+	case IOMMU_TEST_OP_MD_IOVA_TO_PHYS:
+		return iommufd_test_md_iova_to_phys(ucmd, cmd->id,
+						    cmd->iova_to_phys.iova);
 	default:
 		return -EOPNOTSUPP;
 	}
