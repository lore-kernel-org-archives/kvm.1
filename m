Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5573CEBB9
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543323; cv=none; b=B7/qgDsS4FWWQb9FRfHwgsm2ob/e3IVdJ/o9/lBWjpPt1xZnLkYUL3uZqsp/4BU4n0GWON5jAsTMfcyVVWAlPTJAprVO4ed3zJ3s7P9Ty3CqJK0yx5eNfpxw3QhXUWB7iDHleWBnlsNHbMNRhOECmoLtS/Vuhay5EDxB2EOelm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543323; c=relaxed/simple;
	bh=nkhAcR/a501eLQKC6FcCHdjPYtswgNMRUI2YsbdltG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=exBZi5qmA3TZbPKPB+6+X9iOkzP2a6Nipv5hv8Poq9lCMWYlOF360c1kUbm2xN/ERpuZdloCU5qZ+Ju1G9JI0LpL5SXh3zDkOaM4sTXtIFWlzQgDq7yvN8yWhWK5RKMwLuYweCjIlhLTYXxuD1tbrKHfZ7NjTaSFd+VwcdMjeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Us9uC6Eg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Us9uC6Eg"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba268cb5e6so38269225ad.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543321; x=1779148121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlR7sP3TmIVuCVXTiNbI5bhyf9pBSqUWeLZMdRUzyiQ=;
        b=Us9uC6EgoALj9/Kv6lzR8kR3yWheHUSKyJA/Q4I6oMcjcDSTsWQ8BtKkDprmJP+sLF
         tTxRRHchETetEfItbg1JN4UnypExqBhBSTlYVCRFUDu9QXmlBG9v5pHr/C+95jIk/UQl
         G0wRVrNvCU+EAdjrC4HLWmVvSQtmJ7BKrvCi/w+Y/nSA2VRMflWc9WDFsqX7U9SX0W4N
         G+0XLZPfDLAtYULSUo8HzhDid9YzFlfRZkfRrZJblAz3liNR5sVdDdMVW3xk3clZKHOY
         pTdXBh0RpZPeOMPKPfXq3Gs/4/dZe9WT24DMg1Pe+okrrQtN6CgX7HBoOgiGDxMvwRmL
         NpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543321; x=1779148121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlR7sP3TmIVuCVXTiNbI5bhyf9pBSqUWeLZMdRUzyiQ=;
        b=UXHlh/bJ4JaaQ4taz4Cf6fjC2BiNXRlGIxywidZyuOfxB8nPa1K9ykWXRYxMxRO2gi
         KKb3S4bFjUzYeaQx2HvldzlJHVT0EWk8BuoYGz7jtKTkYIehUVDb9NcBmQ6GHQikU1WR
         Q8Fl0EXuEry7yqpLP5Kmn9kMZWaaVy6Tob1yfvkZBrWNc7CERpshJRL0qm84ofav1h5u
         UGQsz4LkthZLTNx2RS5yFOsgrVfqvXZKWedArmCXVz4LFoMh7/h8EGQ22miz4RQMzbFz
         LGlzgzh/lh2ewDfC8uEkGjOLnCfj0wTzL++vyZ0M0bZyqpjYdK4OftKEQdnnDg8ut8Vf
         mDHA==
X-Gm-Message-State: AOJu0YwrRsW5dmWB7T6iCw/+Z4Ll2er7EeWv8TQIATDb/qTM8M/CGndn
	XQKMdaNVzwXeH2A8SM/bymPUDL3FgKah2XWCQWvDscw89xGfQLvQmeDKOT/99xQs3mOba/N3mr7
	ZdiogG9rUX6iN2XN77Vat/p1USw6/NtiTcBKHXS/yEreW9ukcUA+x6Q8dfvDYk8cY44mgEXwaT7
	2Si6DZIyTPnjk1ln9dcL3Tpe2NxdQp9jP0vLsU9A==
X-Received: from pgwb24.prod.google.com ([2002:a65:6698:0:b0:c74:42:899a])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c5:b0:2ae:cb0e:fd59
 with SMTP id d9443c01a7336-2bd010f3972mr6895335ad.8.1778543320035; Mon, 11
 May 2026 16:48:40 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:57 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-12-vipinsh@google.com>
Subject: [PATCH v4 11/16] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
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

From: David Matlack <dmatlack@google.com>

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index df3e44660bd0..ad081ec31fb2 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -32,14 +32,17 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TESTS_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
 
 endif
-- 
2.54.0.563.g4f69b47b94-goog

