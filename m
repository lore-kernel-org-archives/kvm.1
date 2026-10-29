Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306014;
	b=lz8k2mRTvOXYhBqcd0Bwj03a2CG0gQU52vc0/0ENMcZxj5ioK5o3h8Y6Dh17mOA0vk+m
	 WM9YeYqL1Hc3J33sIHOdqhgJ7+S5Q4plainfLvtBYwH96GqpEbHvaaYZb2PJ5dqTvS9OQ
	 k/dSpxO5x/ktajhLeJnaoQcrPALCdPh2+UGAxdL1z4vd4ImlDzE1Gf2fAvPPIhs2BGFWT
	 F+iEo44U1pqUVw0s07c0rBdw/VSrvS11iWYE9LUw8sDbtKDMQa4O6TfXhNHICzD6OWJuU
	 3c4w36nVa7IOmOXWxzfFfRXmaWcwzQ90TY6NO5o5lx8pBDWX8rVUEKrVB/W0b6MYqDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=z179Ocr4JquFIIJEs4efAQ+NRuf5uFGDrSodVviqc40=;
	b=F4vDxhRTEULApS0HJtqtvRanG1/B2L685c+fByWlN0jjBpf4gE1TkSNckHYJOflW0eqU
	 BNNr9FCJGIqKvqju7sbJZEmlnmT1oRLpx0UpgxqhlvdMImH1Hs6a0xYqUQYh71t+XB7uY
	 4pFEUHna5wA+FivdmUuPnC2TYNuaTlLT7t3FceakI0S+GXIpCbApAw8HrGmEXuwNmwqIM
	 iuPkCbgmHMriJIr6WZJXHRbVEgzwOgPH2GQXs4P/dhrcisr/GBQwd7MPGm5C9T/Diace4
	 QUxO805wmAgnAHZdOfzRtNcWxGHFkbHLgehS/ZA34v4+C9wNbJ4Jb6SrBSpErsbpj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="k/h7ENib";
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98C606A324
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD98C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k/h7ENib
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8862ed0539dso2580900b3a.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306010; x=1793910810; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z179Ocr4JquFIIJEs4efAQ+NRuf5uFGDrSodVviqc40=;
        b=k/h7ENibaZ/MHveOfXZbn8cGvIsxFR9IpAxNtw3uxjW2EEVPpBpgKySaDvjVCOtLkC
         PFPyV6kU+sS1sl2BXzQphOCHkjj+1XhYVzhLPwFeoiTBp7QrtAWXIyKORrt0HLt2Olmk
         Rqdjd4bcgIe+aXaCPfjfbV/wcB4KhVhth/FMBH1Acc5y1M8qHyXaae0FputJ9WIt6wK1
         ELuMFTyxid2zLMBN1WdTMSsV0IJlaGuE6o9f9XdTN1mbpnf9AuQhHazzCUy2IuoW9u+H
         J/t1k11ZqkQ7EmxV54ne+n3n5zMIwVgbZONmDDp7KmG2yiiZclWh5sL1Bogt4zPnEBoG
         yBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306010; x=1793910810;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z179Ocr4JquFIIJEs4efAQ+NRuf5uFGDrSodVviqc40=;
        b=at8nSR/IQgzZVsTYnsgSU/ycwrmmO7JfVAitoa7I/3zKihROcZGSNoF0NCl8jd+IXb
         LgzEl/EbfSMugzowH1ZJXzJFGFrqNU3ll+/fva3/WfXyqqBx6XuB0RRxGGC2qUFYZCA6
         amj3GO80ph2Ss96q0gDflcBvZPOPLaMXtoRHGScXL9on7/7XaUVO3CBUO6pLxeAd3DlN
         DivzQnjAnOCBINBmcpY0Uzx3srrKqDsQ27I8BxwqZJ8AfhuDqvNiR5s3rVNBtZ1ypXJO
         5r4CIjxGgbi/C9JlTeQHYiVhgHwraL5xhXH7kEOtjJ1MNYv+ufWD9+dmpOLiTA0Dmd/E
         noxQ==
X-Gm-Message-State: AFq9FYL8rDAq1EdihU0b7fd3ybTQ8711a8rsjRnShV4KRen3NCWUFISC
	O78DV83owL0K/KfWhUB2G3l1D1ID0pJ9DAsEO9DXXgzChNcnuw/oBv2p3nvWNUqWlR4Le9gnuWU
	oGV6mS3NPpjU8JPja931uqMKxl2TwaWtA3/9OH6KByF57J0y6o627AQ+4LtM/FyNd8So0Ylt92r
	wMg/q4MmZ8RI+zQfUqgIAkSPcl7cx2knAw6ED9nMQj0d0=
X-Received: from pgdo12-n2.prod.google.com ([2002:a05:6a02:620c:20b0:cd6:1fc4:6199])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7741:b0:3e2:30c1:fe01 with SMTP id adf61e73a8af0-3e928e3f9c8mr297152637.69.1793306009847;
 Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:23 +0000
In-Reply-To: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029203324.1637772-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029203324.1637772-5-dmatlack@google.com>
Subject: [PATCH 4/5] vfio: selftests: Add sysfs_kernel_warn_count_get()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a helper to read /sys/kernel/warn_count, which counts the number of
warnings (e.g. WARN(), KASAN, and UBSAN reports) the kernel has
encountered since boot. Return a negative value if the file does not
exist, e.g. on kernels that predate it.

Factor the code to read an integer from a sysfs file out of
sysfs_val_get_int() so that it can be shared by both helpers.

This will be used in a subsequent commit to detect kernel warnings
triggered by tests.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/sysfs.h          |  7 +++++++
 tools/testing/selftests/vfio/lib/sysfs.c      | 19 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
index c9ab1ea8f5a9..1b9711d1bf90 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -9,4 +9,11 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
 int sysfs_iommu_group_get(const char *bdf);
 char *sysfs_driver_get(const char *bdf);
 
+/*
+ * Return the number of warnings the kernel has encountered since boot (e.g.
+ * WARN(), KASAN, and UBSAN reports), or a negative value if the kernel does
+ * not support /sys/kernel/warn_count.
+ */
+int sysfs_kernel_warn_count_get(void);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H */
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index d88e348a1e0d..71470196f092 100644
--- a/tools/testing/selftests/vfio/lib/sysfs.c
+++ b/tools/testing/selftests/vfio/lib/sysfs.c
@@ -33,15 +33,12 @@ static void readlink_base(const char *path, const char *data_fmt, void *out_data
 	VFIO_ASSERT_EQ(ret, 1);
 }
 
-static int sysfs_val_get_int(const char *component, const char *name,
-			     const char *file)
+static int sysfs_path_get_int(const char *path)
 {
-	char path[PATH_MAX];
 	char buf[32];
 	int ret;
 	int fd;
 
-	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return fd;
@@ -56,6 +53,15 @@ static int sysfs_val_get_int(const char *component, const char *name,
 	return ret;
 }
 
+static int sysfs_val_get_int(const char *component, const char *name,
+			     const char *file)
+{
+	char path[PATH_MAX];
+
+	snprintf_assert(path, PATH_MAX, "/sys/bus/pci/%s/%s/%s", component, name, file);
+	return sysfs_path_get_int(path);
+}
+
 static void sysfs_val_set(const char *component, const char *name,
 			  const char *file, const char *val)
 {
@@ -148,3 +154,8 @@ char *sysfs_driver_get(const char *bdf)
 
 	return out_driver;
 }
+
+int sysfs_kernel_warn_count_get(void)
+{
+	return sysfs_path_get_int("/sys/kernel/warn_count");
+}
-- 
2.56.0.317.g454f8302e1-goog

