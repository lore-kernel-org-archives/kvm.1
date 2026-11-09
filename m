Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258520;
	b=r54mNdb0sdD6B93S9Z1EpN9enLJi0AduhtrRggpYQRa1x5/fNfPJYEJP8Q0c+/OgrKZ5
	 CvMklFckaAtHOj0NIO3tkqhA5cG2JFjj8iq3cQbVx7DiItsjdX6td1PH7+zPmw0rdDZwD
	 sLcGEp5q1YRaaH8P8w/VjMzNqgKlb52nDsojeHIdXheVbRfhBrsJ+i+scO+isNhKMjsvJ
	 EeJj1FUh09tgcF0jj5io4bRfpxHX39Iq9Ya1eLXb31TGZi1b25Kc2/bYrarkin4oHaEUU
	 Pnc279HfMZbx8HF+iYWXeZ9/36gyWgNlYz5iEubhdeCmeIqtVKVl4OvucrD9WTslR1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aNKqN93kR+lNxistdWyjeL4QD2Ikaa3czqMk7TzqBYw=;
	b=LwxGo4gvmvjyCt15NXoatFEoFdqVd8A+s1ojeSgOmlKbLNaeS/A13FKnvBN0h+RFzKiW
	 JMGoBWzrVdlpk9ZcWj05W5kW9KtCR6njCMgcvKXyNrnVnxdjOR+ZCdpCONc8PuF6Zeeye
	 Dx4nRV4u4jmyJY9teprY7jtMeuAfSYZFuhLVE7iqUrovL+ZbSDazFLzk178gXh9vH+t22
	 75ueetxmD91Pen88DPNdsZrx7GKJe2C04YQ1DMrit8NnhG27boMW+2U/lgiVNQLtDSOSu
	 Ln9NH/fwcAASDhmJO9vnPV1SFMznG72HV9BFcLpVO/0LgvnOTNKNQWp/scfOad6bE/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g1mx7+5d;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170960A261E
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 21:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5170960A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g1mx7+5d
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab8b4887d4so865894b6e.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794258519; x=1794863319; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNKqN93kR+lNxistdWyjeL4QD2Ikaa3czqMk7TzqBYw=;
        b=g1mx7+5dB/dwi5suUFjiBOitGRwdI8l7Hbx2/LPl7dz8QUomivRSvO9bkukH3n/P7/
         K3D7NGrPe84Hzd2vuzGLv2FsaKj9giidpggDMWYtcSa/y7RGYLuO7A4a35J91cWLaOme
         l7mcUMw6u2dpopRlJsDZEVH+tSPeTi6CdLClHK9pX7LJ/pq20uuf7aLhQ0uOdyrcqwXb
         VhaTf7YirRLgpGB94EW41kKF24E9yG5kbnOLBugs9fFy2lZC0G66wIdPJiBEpaZy1Sf5
         ZAVzKkg1b0L/OXIvSw7uWog2nuHLchLrS4pquLtU0s4uJWhMmrAFJkuDkFhXsWiF3ayK
         eA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258519; x=1794863319;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aNKqN93kR+lNxistdWyjeL4QD2Ikaa3czqMk7TzqBYw=;
        b=So0m/bGVCA9GBg7a+oKFBGed3ioHlbXh+u6B5MBhQN3SSDBvKJ2kwmw4cTREsU7E3i
         Cw+Ty8+IVtbOhxsL37vO6+tKku+n/GMohafgldS5f5xuR/Rc9ZdZn5eYLxYIqy+z7vfk
         UqpWPKDXqrkKmHHNY/9GWkE9u3mn6tjuXpkhFajpCTQb+iKDVBLOrABwu0CSvx2QPzOH
         ohL+e1OpIoK894OFitVQd0eTEVduv1Nw9MeH6gyi+ahF/O+BvGcr5Q6GCJQ/mpogWnVO
         X46HvCConjHS2BbJl1cB4MqgYw887FwunfkQ4+QbuYvArCnTrfLKmhO81nhI+MXCPiFE
         vbRQ==
X-Gm-Message-State: APuU4Z/hFRQ30LUSoTMYom8wbsKzFZfZAmiZrgZEWZM0z/t5iLDbLllp
	dvIO/HRG4ujPLXYlYXmhKhCsO86eSYJDHbGzqIK7ToHq3XA9TL/jRjfxyD2yHWC5RikWzpc/Pgk
	Hp1SqbhdqKoaXKufyN1hCqPNBrr1AqgAKLcQrIRBFtLtrglxrvdY//xgPngdlzVe7rhLa6lKcaN
	QMxORQS34vO6pCUNRWo+L6ZVVcwpgTNdCBFOcTpsBNYDM=
X-Received: from ilej14-n1.prod.google.com ([2002:a05:6e02:620e:10b0:53c:6681:b05])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6809:1ca:10b0:568:66c5:2ad with SMTP id 5614622812f47-56866c50430mr374020b6e.34.1794258519045;
 Mon, 09 Nov 2026 13:08:39 -0800 (PST)
Date: Mon,  9 Nov 2026 21:08:31 +0000
In-Reply-To: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109210833.1250548-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109210833.1250548-4-dmatlack@google.com>
Subject: [PATCH v3 3/5] vfio: selftests: Print the IOMMU modes when a
 requested mode can't be used
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Print the names of all known IOMMU modes when passed an unrecognized
IOMMU mode, and the names of the available IOMMU modes when a test skips
because the IOMMU mode it requested is not available. If no IOMMU mode
is available at all, print the generic "No IOMMU mode is available"
message instead. Expose both lists via iommu_mode_names_all() and
iommu_mode_names_available() so that tests can also print them, e.g. in
their help output.

irq_test lets users choose the IOMMU mode with -t, so a typo or
unavailable mode should tell them which modes are valid.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/auit0kVkAaWcNUvk@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  9 ++++
 tools/testing/selftests/vfio/lib/iommu.c      | 44 ++++++++++++++++---
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index 8306ade5f069..309b231eb0d8 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -52,6 +52,15 @@ bool iommu_mode_is_available(const char *iommu_mode);
  */
 const char *iommu_mode_unavailable_msg(const char *iommu_mode);
 
+/* Returns a comma-separated list of the names of all IOMMU modes. */
+const char *iommu_mode_names_all(void);
+
+/*
+ * Returns a comma-separated list of the names of the IOMMU modes that are
+ * available on the current system, or "none" if no IOMMU mode is available.
+ */
+const char *iommu_mode_names_available(void);
+
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
 
 static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 56696bd5c30d..bde53bd55208 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -105,6 +105,38 @@ static const struct iommu_mode *iommu_mode_detect(void)
 	return NULL;
 }
 
+static const char *iommu_mode_names(bool include_unavailable)
+{
+	static char all_names[256];
+	static char avl_names[sizeof(all_names)];
+	char *names = include_unavailable ? all_names : avl_names;
+	int i, len = 0;
+
+	if (names[0])
+		return names;
+
+	for (i = 0; i < ARRAY_SIZE(iommu_modes); i++) {
+		if (!include_unavailable && !iommu_mode_probe(&iommu_modes[i]))
+			continue;
+
+		len += snprintf(names + len, sizeof(all_names) - len, "%s%s",
+				names[0] ? ", " : "", iommu_modes[i].name);
+		VFIO_ASSERT_LT(len, (int)sizeof(all_names));
+	}
+
+	return names[0] ? names : "none";
+}
+
+const char *iommu_mode_names_all(void)
+{
+	return iommu_mode_names(true);
+}
+
+const char *iommu_mode_names_available(void)
+{
+	return iommu_mode_names(false);
+}
+
 /*
  * Returns the IOMMU mode with the given name, or if iommu_mode is NULL, the
  * most preferred IOMMU mode that is available (or NULL if none).
@@ -123,7 +155,8 @@ static const struct iommu_mode *iommu_mode_lookup(const char *iommu_mode)
 		return &iommu_modes[i];
 	}
 
-	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
+	VFIO_FAIL("Unrecognized IOMMU mode '%s'.  Known modes: %s.\n",
+		  iommu_mode, iommu_mode_names_all());
 }
 
 bool iommu_mode_is_available(const char *iommu_mode)
@@ -136,13 +169,14 @@ bool iommu_mode_is_available(const char *iommu_mode)
 
 const char *iommu_mode_unavailable_msg(const char *iommu_mode)
 {
-	static char msg[128];
+	static char msg[512];
 
-	if (!iommu_mode)
+	if (!iommu_mode || !iommu_mode_detect())
 		return NO_IOMMU_MODE_AVAILABLE_MSG;
 
-	snprintf(msg, sizeof(msg), "IOMMU mode '%s' is not available",
-		 iommu_mode);
+	snprintf(msg, sizeof(msg),
+		 "IOMMU mode '%s' is not available.  Available modes: %s.",
+		 iommu_mode, iommu_mode_names_available());
 	return msg;
 }
 
-- 
2.56.0.506.g506a7eabc5-goog

