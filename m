Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA44455607
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894750; cv=none; b=RtqiYnGvHtdBHVIPzcTJJQhI+gV+FrmFQH+kU8JrzmKdvrH82ibmgF9YYvG0f+g4+YAbC6blxwPAtu3SjQx956AL1eHDyxjeGl0LxBWt4WB0jG4MEHbTJb/rhfjvW2dhNJSmMTxjTHN+1thkOTH5/xIU9fT1GxvUBIneLbyFdeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894750; c=relaxed/simple;
	bh=cNVcbuAwiuPvbW7gIOTu7dEHjAhHHDNmMOS8HQkVoFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tPEIXlBeNGJSklcUDgsP9vGzETlLhMAFSEcuV3SttiZbAT3VyhTHbze3u7O7rD5Kju231QIfMLxjmgJZ0lZSuNC1V7mmnHx/QmilzGi419G/0/DaPRvtpfMnFXLUmydG8NUCgslVgENHt7N30FJUmqUNY5b1hA9pwwPoSh5B1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwLqrN+S; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwLqrN+S"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc795ad1f5aso4081847a12.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894748; x=1791499548; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IisvBifMmb2UUMDo1HteD5AGTapgBqr+NugNWMv+c3A=;
        b=rwLqrN+SPTOAHAJGJxAYUDIdo8ysq0rlTQgHnPbbMHsRDVHDW0WGWZX7YwB96zNafy
         jAVkdw9tz92d6uNCRdzFA54w7sIEQ0YkoA4cMxk+n+PIf+7ZwOwGqKNBph18dz10JKgf
         LC4cijSyN5IsVl83aCwEEuFkYWsHUCdj/oP3O8dFdp9G5w+xDav3gop/RT7mWER6jyVQ
         RY6/MtzINs16NcIxS+bbwVOaHT5iKU02XmArnS4q/QtYTgE8M48tIRZJ17tLa9casUXA
         1QX6QcVhBjaGu1taq4QVv8sJBCMbtWgSDbgTieUO+xh+4Bui1Hr5OcLT7INo1Rq3BXqZ
         QBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894748; x=1791499548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IisvBifMmb2UUMDo1HteD5AGTapgBqr+NugNWMv+c3A=;
        b=M+4yz66R3yDJJSuK1GGFD6FEe/fJoaX3P/UpJ6kngiBwtLYT3Xy2mFFbsQWVCw0KEn
         1/L4yv8LIWPncPrYH68taNt6IobkgIVmxkSeun5AMdSPG/mvEC0E45VwO9JpX4h4lRa9
         QwkBfcUeMirqNZK6O95aaEP7Oj9TkIdSJDlbrwNftwsLWwMYMRrLd8bznKFXoJi1NhtU
         +XGf+hulSNjOJVN96kBbyvbKDLyCNMdi9qXDPQf1DO6bKZL/YNi7SfA4JFEhu2DcxjP1
         bJYNoIosAO+DXT6DUqT1gGY0sdqcPrWMetAOfjG1BRskioWZZyOKt3pL44Ker85UUA+4
         N1yw==
X-Forwarded-Encrypted: i=1; AKwUvBwoCy+nUS5k0qvvqJap3sLNwz82C5/txDShH6Pb+qbMJYQ/uV2aWVH98ejADHl88CfNHV0=@vger.kernel.org
X-Gm-Message-State: AFuF++mCqTa7ptVp0Q2kR8M8s/DGqlzcDjDR5/4WMWDDsvL4zEVmyZko
	ryDe4FPCB0Y0gFJd0XtzKqhrcEdPnDrnl+jZ2Dt4tcznQ672QRV+Ol4paT0UFCrJBO3VfTfN2i5
	nZA==
X-Received: from pgbcw4.prod.google.com ([2002:a05:6a02:4284:b0:cc7:91e8:1fab])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a122:b0:3de:6172:e33d
 with SMTP id adf61e73a8af0-3e0bcf2949cmr852824637.20.1790894747533; Thu, 01
 Oct 2026 15:45:47 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:25 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-2-praan@google.com>
Subject: [RFC PATCH 1/7] iommu: Add infrastructure for per-domain IOPT accounting
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, the IOMMU subsystem tracks the total number of pages
allocated for IO page tables globally via nr_iommu_pages, but lacks the
ability to attribute these allocations to specific domains / users.

Add an atomic `nr_pages` counter to struct iommu_domain and introduce an
anon union to store the iommu_domain (aliased with private) in ioptdesc
for the accounting infra. The union ensures that the ioptdesc layout
remains identical to struct page, maintaining the integrity of existing
static_assert checks. Utilizing the `private` field is safe here as IOMMU
page table memory is exclusively owned by the IOMMU subsystem and is not
managed by other core MM subsystems that typically claim this slot.

Co-developed-by: Logan Odell <loganodell@google.com>
Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommu-pages.h | 8 +++++++-
 include/linux/iommu.h       | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index e9e605b5fa3a..edf75c81054f 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -25,7 +25,13 @@ struct ioptdesc {
 		u8 incoherent;
 		pgoff_t __index;
 	};
-	void *_private;
+	/*
+	 * Alias iommu_domain with page->private for IOPT memory accounting.
+	 */
+	union {
+		void *_private;
+		struct iommu_domain *domain;
+	};
 
 	unsigned int __page_type;
 	atomic_t __page_refcount;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..478b64f4084f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -231,6 +231,8 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	int (*iopf_handler)(struct iopf_group *group);
 
+	atomic_long_t nr_pages;
+
 	union { /* cookie */
 		struct iommu_dma_cookie *iova_cookie;
 		struct iommu_dma_msi_cookie *msi_cookie;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

