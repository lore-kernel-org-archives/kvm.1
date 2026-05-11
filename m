Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721A3C3448
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543321; cv=none; b=LvM1hogjPSubh9UgBNpYm8+Pf2fMqAoyoFMzH/MLG1mojzTnPh/NeAOb/YaQiIgJzeNFOF5fyxGygdLYoMzEubJb2xIXOiMYpznttLwwfOYZbNogtSZ0jAGjGGMtM4sJ/rj786bZweExYY4atIUL7O4iqE8XuLn3i/sq7kRSWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543321; c=relaxed/simple;
	bh=21W6Ql13lrjgrDgG4oHa5rhHZslFZu4s8ImhCjMl8pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jXeurxxnOQ857VmvSpZ058VMoWhT6LSnzr8/zC3ofnRFZZshKQON9jIQmlQgRWtTnvpLu5P3YPYmU57+3Kmj/dU/fiAfpAyqV/26uyItvSP7kBK7zpMhFrYdsTOAGrNm9lCDg3yXpRFT7kxJNDVirkBzpNxTbmAMvuSgfp043j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlAdcA6s; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlAdcA6s"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3662eec51e0so2597531a91.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543318; x=1779148118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WP44kmfFcYhlyRsivHdlontJq1i9E72JydBw+wZ7hQ=;
        b=jlAdcA6siMmeUdU5KrMMGE7lsld1eVkfND3GlBRd+icWNvn2e1VOdVxa7UniQAN7z5
         BUqgM4Zu3FtP74Uj3W73SArbFz/2NOQV4A9WoNElZXaVtsloGkPwcc3/RNhDl6BK/wHt
         lyFCuyxOhc9mvEoTkh4Nu7/qDvnu5667eHH23+QACsE82MNYuImcdcI+cb1b4JDXettA
         9OwYRM8GB+EwuO+dn8E5pq7TM2z5PE7IdIyr3mCb7JxH8mZBecZmLKfFBZLBG/ib83uu
         t3ic5g4P2eWmzMcSD1yrYljM35KpWz02mudmbeYry1nvwdl6Cz5Xnw4CUA/AbM9lhthe
         2mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543318; x=1779148118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WP44kmfFcYhlyRsivHdlontJq1i9E72JydBw+wZ7hQ=;
        b=RU6/p7KOSp1+t9OOl/D1Hxv8xBjQilDROjXa1GcDsiDtGH+mtznC6lVKRYGTxB1IDt
         6PRoQ18IQjXirUc6D/6Q/mixfTY7GsJrVxh4nwivw0vKZnA54ITT6axX1cMDQwQicFgh
         0Iz3kQLLAX6HidhsEMZZ2mKBQs4tYXRVcboHnOBUEThEsTw+iCNu2ZXjatRRFSFvPNQ/
         yFv27V+qajr25xJT+kOQJkwmm8O7IkSipclJ5cylalvH6GCgk2DR4ZVM3+KB5WCeLZus
         JFwtJU/XDy+nnjPBHXAl87zUhoO5lLQbnT74bZ0woK6XaknnSB9gf3aM/3k4L8ru9VWq
         TJow==
X-Gm-Message-State: AOJu0YwJNQ+kirkiPskE1+tIXeK3eGt+cGGPwJh+V6S6h3eo+D+N4rvk
	btykEYsfVzhpnDUF3fLqvo2gXS6H73+E9GwOudqW4VisW63I1KanpbnSFSKlT+qNGK10fSebIgi
	bQrn49jYvS0S49+r4lA/wY0urhewXY+fAsBk7qumqG/kPolLwEPNI6mI6rXo18BS7Jd59lWv+a6
	gaQNNH/kOS7nNcA21+0tZ+j2/01Pu5Xa88jM2ZNA==
X-Received: from pgjw1.prod.google.com ([2002:a63:fb41:0:b0:c80:15fa:8bd5])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0a:b0:368:3030:4a65
 with SMTP id 98e67ed59e1d1-36830304d85mr7869135a91.13.1778543317042; Mon, 11
 May 2026 16:48:37 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:54 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-9-vipinsh@google.com>
Subject: [PATCH v4 08/16] vfio: selftests: Build liveupdate library in VFIO selftests
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Import and build liveupdate selftest library in VFIO selftests.

It allows to use liveupdate ioctls in VFIO selftests

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..7865b2aa011c 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -20,6 +20,7 @@ TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
@@ -27,11 +28,15 @@ CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
 
-$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.54.0.563.g4f69b47b94-goog

