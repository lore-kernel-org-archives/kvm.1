Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798744;
	b=S6MWMyeIQd8VusnL1Bt0rdv8N5Hb+rFgC4Vsdm0BxZ2nT0AwIQJ88r85WLdDVIafLv0h
	 YLLyUeKfMEHQ3+wG7BO9omUilESD/VYG9mfP33EaXyruxyovhFaPWjVGukbMhiTdbSTeH
	 yzet3slc1rT3Etiqa+Nw9s9pLHY1Oqon6Ne9kWBoDb1r6F+NR5NGM/v7/IeVbReGeT8Td
	 6dlSDhuuos2D8dDCNBwMwjnzYLydV3SyrCzSfgsiVQe5MY5uPyu/qixr2Qnx4e0H4ZkLy
	 7hE1tUimM5RD2WTSdWYFbK+1axoOXtCaKlRUTl7bx5TTi0g3BZ8aFf1td2RhzjhZlxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=esRSTx9IpL/ybW25VHcD6mzBY2hlIDI+k1S943K/5/g=;
	b=ekArF7RFz+fRsRZw4lMhb5Co2VeRrVMVlFwRFkSewgjJ6TAwfkA5MQ1SB6XNwYPTQBF3
	 ZO0i2t5SXjedcXXDJ1GRUdnfy/FTyh+rf/qoh+BMrkO68aDqix/zgqMtV1Mb/zDTGexNv
	 1hdK/4fnn9K6dWtLjOQBPWTS3cpcuy3yqOSy/NHLcdQo5BULc/RAnDUePeUJdL6Ry934R
	 ON3/gqyETDXi3Wd5kQRJYQQCPjyhJFHnjpGg0k4brneg593ceBlPFxIAfXqcXH1Hw6AS0
	 aWbJht3B7lC4aiT3KTiodrEmLmuYwDarJtbxrQX2uePAFuHiofk2n6sQCu7nZgdkBXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GOSTsnbD;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D2606A32C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 16:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7D2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GOSTsnbD
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4d4d132bbeso766364766b.0
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795798742; x=1796403542; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esRSTx9IpL/ybW25VHcD6mzBY2hlIDI+k1S943K/5/g=;
        b=GOSTsnbDTX1TQfBxDmfWhCobhbqAkvH8HXW1y2/O80bzHdWX/aKWhZdTDToW13LN+J
         XTaFgA+2dQcijn1DEo/RnwFqWUeDBG1kRZUp7ZKa7OPEXOIfTuCAJMyo0uF4P5XDq+1E
         88Udb+X7XV87sf8YM4ih8l/Chyb5l2BNnEJz1nwWcxFY2P9DDU/ibJ4qiqXZ4CEiVqij
         q0OlVSVG56vbJTRBzRVwsEUWIgEhqdBCbyMoAXDqNMevd0fo1l8JfRGuNd9070oTY6a5
         0Xz4fcQsYcFtMzbErnfSG6S/XTahpQ0R4iX6XlRPRekE1Xyd/5GgrGgqCMjf494A858S
         T9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798742; x=1796403542;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esRSTx9IpL/ybW25VHcD6mzBY2hlIDI+k1S943K/5/g=;
        b=deTSHQGKUDLO+AmWemu4u1on/G18AdoHujPVNhBmSrAj3TBbX4hagdKg1VSPAAlqde
         sf+HNvwQsH3iB0STv+PDSaNr76I5UrbQ0r1x0dR92NVcF7Qn5e0iE+uKkfI8X70Kckzz
         WYjto8IaftiXRczgHP4hebvbAwEiJ3xt+xsmfW89HSyj89fTz2Xvr2jUxXDqh3G9zIZY
         MaLngyFBFes3j75VJDJoXJz+2l+BnZ/sK8xizD0bXzNEK4TcaDz3MM5E+8R26iP1pWWR
         omqDcprogY8VraB5og6+1sQnS3h//PDYs9dy8DCv+a8fxyXJsgOvK9sl/kK8S3F88mLf
         j4Hw==
X-Gm-Message-State: APuU4Z/Di8DW5y2j3lwQXQtQsKB0fYCjpvRiF/2n9pxbbmBTFFfJY4UE
	ixAQp75w9qFN5prE+h9+jeFyMc1fYZ2Rv0BZ3UdOtR5jaVLcGsetg/0OJgPU81sMCMnW4czBZSc
	Efj9QYiTMA63gC954C+NqUQ==
X-Received: from ejcl14.prod.google.com ([2002:a17:906:78e:b0:c4d:4f51:fd3c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9301:b0:c46:78af:6150 with SMTP id a640c23a62f3a-c5131585160mr2356923966b.2.1795798742373;
 Fri, 27 Nov 2026 08:59:02 -0800 (PST)
Date: Fri, 27 Nov 2026 16:58:41 +0000
In-Reply-To: <20261127165843.709034-1-vdonnefort@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261127165843.709034-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127165843.709034-2-vdonnefort@google.com>
Subject: [PATCH v2 1/2] util: Use a memoized value for PAGE_SIZE
From: Vincent Donnefort <vdonnefort@google.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, maz@kernel.org, oliver.upton@linux.dev, 
	suzuki.poulose@arm.com, alexandru.elisei@arm.com, andre.przywara@arm.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The PAGE_SIZE macro invokes sysconf on every evaluation. Promote
host_page_size() to util, memoize the sysconf(_SC_PAGE_SIZE) result and
back PAGE_SIZE with it.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 builtin-run.c      | 14 +-------------
 include/kvm/kvm.h  |  4 ----
 include/kvm/util.h |  6 ++++++
 util/util.c        | 15 +++++++++++++++
 4 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/builtin-run.c b/builtin-run.c
index 75e8ced1f421..f06231e382ad 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -401,18 +401,6 @@ static void kernel_usage_with_options(void)
 		KVM_BINARY_NAME);
 }
 
-static long host_page_size(void)
-{
-	long page_size = sysconf(_SC_PAGE_SIZE);
-
-	if (page_size < 0) {
-		pr_warning("sysconf(_SC_PAGE_SIZE) failed");
-		return 0;
-	}
-
-	return page_size;
-}
-
 static long host_ram_nrpages(void)
 {
 	long nr_pages = sysconf(_SC_PHYS_PAGES);
@@ -427,7 +415,7 @@ static long host_ram_nrpages(void)
 
 static u64 host_ram_size(void)
 {
-	long page_size = host_page_size();
+	unsigned long page_size = host_page_size();
 	long nr_pages = host_ram_nrpages();
 
 	return (u64)nr_pages * page_size;
diff --git a/include/kvm/kvm.h b/include/kvm/kvm.h
index 72a8c3f32b5f..2b7e4b7f4a9f 100644
--- a/include/kvm/kvm.h
+++ b/include/kvm/kvm.h
@@ -23,10 +23,6 @@
 #define HOME_DIR		getenv("HOME")
 #define KVM_BINARY_NAME		"lkvm"
 
-#ifndef PAGE_SIZE
-#define PAGE_SIZE (sysconf(_SC_PAGE_SIZE))
-#endif
-
 /*
  * We are reusing the existing DEVICE_BUS_MMIO and DEVICE_BUS_IOPORT constants
  * from kvm/devices.h to differentiate between registering an I/O port and an
diff --git a/include/kvm/util.h b/include/kvm/util.h
index 0f5a4bba5714..dc0972061108 100644
--- a/include/kvm/util.h
+++ b/include/kvm/util.h
@@ -154,4 +154,10 @@ void *mmap_guest_memfd(struct kvm *kvm, u64 size);
 int kvm_create_vcpu_thread(struct kvm *kvm, pthread_t *thread,
 			   void *(*start_routine)(void *), void *arg);
 
+unsigned long host_page_size(void);
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE host_page_size()
+#endif
+
 #endif /* KVM__UTIL_H */
diff --git a/util/util.c b/util/util.c
index ff888bf9e061..c4ee03304503 100644
--- a/util/util.c
+++ b/util/util.c
@@ -235,3 +235,18 @@ int kvm_create_vcpu_thread(struct kvm *kvm, pthread_t *thread,
 
 	return -ret;
 }
+
+unsigned long host_page_size(void)
+{
+	static long page_size;
+
+	if (!page_size) {
+		page_size = sysconf(_SC_PAGE_SIZE);
+		if (page_size < 0) {
+			pr_warning("sysconf(_SC_PAGE_SIZE) failed");
+			page_size = 0;
+		}
+	}
+
+	return page_size;
+}
-- 
2.56.1.839.g22a8290db9-goog

