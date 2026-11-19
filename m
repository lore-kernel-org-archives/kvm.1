Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046525;
	b=NKhoKBMcqzcovCRhnfLtjVeMsJ9pFo+ul3tfNqM9c9ESzJBMBcolGUrkK0dw+sUECTLh
	 g7nY1/n/TujMOKou5kQaI1MRtsTYr9hFEJQDnDpuTER2Z/LmYl89rXjnwZebnx9c/voYg
	 YVeWEvHzxAdCOhomaSLozDRM7+T+2/9rv0JMPkiya3HLBIir47Kfs/JRaiUJHxlQvwqgK
	 f2cecir/RzUCPfTSB0m9gHJGEVHNJ5l39x+vNuH7mdYVwMNO62P032hOB91qjqFyVhNvH
	 nDssldfWIweMMLAyTthOkJRv4mgMn/t3YJEPd5n7PCdHaNT0YrgDTgREizMy3lHVy+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GNpSDWCwA2M95P8ux0wgAkE+CliZl79pp2XxcfcD2Xc=;
	b=oge/oQi9czdUHa9l8yfV3xKmfwbK0H6CIgrjfhz9WkGEAZpDg2NIGrEAImiXedYwLKZ7
	 0ZA6I8bhCH4MKyKJG4IJKwoj/b5hgMxJfINgFw7djfM4wZBodpLfMIDEJLGexR4xh54x2
	 xa/4Wc0zCrzR7D5st4bBut0tJ14x5SCtLVKi30tiqcZC27kFsYS1UznjFV+6x3wOXIlrF
	 Jb+jstIj83rEyUp6WpSs13CAoTA67our2OdyV0ST7bI1YFiPykfdt160b1KawadX21t1k
	 p+dkNazdjwVpUBkp16e6YkFhZNnGWEiwCm27S8X9Zqmoi4zVVXdpkga5Vxtag0iDR+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y6h90oC8;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842860A382C
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A842860A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y6h90oC8
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4ae40674bd0so1184589fac.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046523; x=1795651323; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNpSDWCwA2M95P8ux0wgAkE+CliZl79pp2XxcfcD2Xc=;
        b=Y6h90oC8jZ9Xyl3cPOM393Kepu7WHWu6aXK6CZviiMZPds5OZunHu8DMtpRd4BA7SE
         ZiGnZYmdAZFb/koJ8cho1yCNQlgd5k0aZ/eBo5W7hyw3zqagWqqo2HKxbrigooV+NfLv
         pZmyMKWG/PuIcSAh0AaX9kQUp3jkpekYc8E5HfYscWycNxAqMp0IyUvymvD6b+I50ytE
         K31IkIhDSvoXnxX+mcxmnN8XTmzGgIspGcdqZzkgAwHKwlpQXRxzlK8CKZtJVYMLwAsn
         Kk1y8VBOWZZ/0dlOqPm3WjwFA3e/pIH26BGnzhhWDVE9eLTJmWGxsdvQ/ygtkYhDJtk0
         T5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046523; x=1795651323;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNpSDWCwA2M95P8ux0wgAkE+CliZl79pp2XxcfcD2Xc=;
        b=KI0laVBmV4KFvy8UVLxdJyoEFMkAG15VKOS9Cj7vZBw187hcPjbcWS3e1Xq0ZKpHF4
         Pjqo0cfqatJp8WgF0ljyA/+rD4dOJBO1eWhC1SpIIUO74XGnJW51Z96dDpcLmRl0BUty
         gENlj9KYGCbQvjmlUYFr7DnJOfo+tv8nR0sR65LFPxYB8xyhlJ9kuV+V0ylfd+2uNh+2
         QcleX379gK6Be8VfrqYldU0oim+boioAmv6goVPZNufX3p2lWF5ixrLcq6h8frM8Mxsz
         LzGxjfL9u08L+pzvAgmwY6IhCkm8fUTCbtNUwcqO0Vou+vLV4L673X7X33dj7EXsasFt
         fbJA==
X-Gm-Message-State: APuU4Z8OH3OBFEbVFJTUsmmI7HFjqiihszuUVZyPPxBdEvLpJEQnyv0L
	L49sbVo2JC4A+p0GLicwpmG0bW1n24bLrSeMvczcG7MbPPbPMKFAO3YMfldjC02s1FGV+FcVhRb
	HY/XBQC9BRBJH5ui6bOE5Es0JjT8smACCvG9E1kia/ErBGxHx7ZMUeOTHDxV+kJ6t34NJIZD4s5
	cT5SHFoA8rhT+vYMcafeF6a/2nQNjTVSAuT2Zpd0F/Ntc=
X-Received: from ilpz1.prod.google.com ([2002:a92:d6c1:0:b0:54e:91a3:243d])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3008:b0:574:524d:f23a with SMTP id 5614622812f47-57741131621mr4704844b6e.25.1795046523220;
 Wed, 18 Nov 2026 16:02:03 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:48 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-7-dmatlack@google.com>
Subject: [PATCH v2 6/8] vfio: selftests: Add sysfs_kernel_warn_count_get()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to read /sys/kernel/warn_count, which counts the number of
warnings the kernel has encountered since boot. Return a negative value
if the file does not exist, e.g. on kernels that predate it.

Factor the code to read an integer from a sysfs file out of
sysfs_val_get_int() so that it can be shared by both helpers.

This will be used in a subsequent commit to detect kernel warnings
triggered by tests.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/sysfs.h          |  1 +
 tools/testing/selftests/vfio/lib/sysfs.c      | 28 ++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
index ede114181cf8..5ef515eda686 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
@@ -9,5 +9,6 @@ void sysfs_sriov_numvfs_set(const char *bdf, int numvfs);
 char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i);
 int sysfs_iommu_group_get(const char *bdf);
 char *sysfs_driver_get(const char *bdf);
+int sysfs_kernel_warn_count_get(void);
 
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_SYSFS_H */
diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/selftests/vfio/lib/sysfs.c
index 308da0526543..3845d81825e3 100644
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
 static int sysfs_val_set(const char *component, const char *name,
 			 const char *file, const char *val)
 {
@@ -170,3 +176,17 @@ char *sysfs_driver_get(const char *bdf)
 
 	return out_driver;
 }
+
+/**
+ * sysfs_kernel_warn_count_get() - Get the number of kernel warnings since boot
+ *
+ * Read /sys/kernel/warn_count, which counts the warnings (e.g. WARN(), KASAN,
+ * and UBSAN reports) the kernel has encountered since boot.
+ *
+ * Return: The number of warnings, or a negative value if the kernel does not
+ * support /sys/kernel/warn_count.
+ */
+int sysfs_kernel_warn_count_get(void)
+{
+	return sysfs_path_get_int("/sys/kernel/warn_count");
+}
-- 
2.56.1.708.g77570a6a1d-goog

