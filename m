Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E14963B6
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042129; cv=none; b=EeUr8N0StITtm15gripHJzAPxTrWt4EgQPcjqAXv2Lyf+BsiPGtofNMukF8HrdiMcGeelr3NbYd2Vq5KbPWZ6QCCVgazhZog+s8SHa4alEsmwL4vBU+R8SZ18BQ8ufyD/fb24tpkCdhDkDYcOKttU4HMZT/gBz6vSFPdtfh8Ru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042129; c=relaxed/simple;
	bh=D8+CDqnTMa7BMe+HDcJm6O9ksq5NtEkbNPKxr0uj1to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrfLaLPw5E6jL24J64VSsyNyXl0XQct+BZkhudiRqaESdE7PFwJ3L92Gd+P9j1eFxdr3GSgnPCI8AWIr0dNmZi0AgqTm/AlK0FSTzCiw8ZBcpimcCzZ+ogaLFsCPT21Fnz5/swfA34Jqll3aCVyrYKO/KUI/+c8OIcPHFyElZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sn6TTR9c; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sn6TTR9c"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cccfa32670so63437895ad.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042126; x=1784646926; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4NITAiOyX61WSGfTGRgV5OG/+gstw4nR1bSZsXufP8=;
        b=Sn6TTR9cwxZ5Ug2u4keqR/9NKnAV88TIe1ZjTJeR7Y1p6KCi+6fU1Hg4h6s7gR0/+c
         JHo669hyUDbiWenPJIxgTB83PR0lZI/9pIFlbgeEU2ZjR0gUHt7eL6Txii2g0xXXdcJL
         NXZR142BCT7pssq5sPMxeisGNiMNNWF77w8wlLWfKTTn3UwWd3tLWS39NZM4LHNRbP6a
         LcVai/YSlqX2KNmXEscr5aF2MmPmjudL19mnNal3QqPsEBXaPAzGav59S3xLB+GHkuBz
         4rZWSosNTXx6YY1LsjnsqG5z5uMOTp7oMqINa9BezPwziOj/01Lvviyz5E8CElPLNHDJ
         s+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042126; x=1784646926;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4NITAiOyX61WSGfTGRgV5OG/+gstw4nR1bSZsXufP8=;
        b=D5mkLbZjv3DqSWleCnLXLF8uCSapdM6reIzStXepbElNTQPPeH0+mAoaGsXshLX/Ev
         hOtn/UvGei5WpIdZpTOUaxILuslXpns4xKwIMUBzcdQmJ7LcIIJp0PStn6N3Zu/La+Z/
         2oZOu/CZUWS9e0zq3qCW9MJUXSLcJhX3GkQOPCVHJdSpco0rZbSm8/vHy1XRL7Rt/ynN
         ofpPVDXLiiI+MuTbAO/kQcISGXfjzlSV9OfXNtd7UHz/bQVAjr4suFzf2VTlRUsCmAVK
         t2jAczmI8g0fCs3hGjVtu58sHjMZbG53wlf5Bl2LTWKtNWbJzOki014dGxICbpCVxc11
         AgxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrchdgfNlQCHlF9QCP8nPGk5nDYZEtGHqWtsFqaCTOwP+u5xjycdONIuUZNPKaJArN++qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeS/yNJu0mC8nCSBGYNmQN1X5GffFhzNr3rwtNP86wXIMvB1g
	zR6uNnc5Uu//kPpkCc/P858bGOygEwccKzXCjRixaJqbmMhuCB1xF5dihIauvWqcJZi0LN6yn7w
	NpSUrbA0nPw==
X-Received: from plbkx14.prod.google.com ([2002:a17:902:f94e:b0:2cc:61be:8bbb])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db11:b0:2c9:d539:61e7
 with SMTP id d9443c01a7336-2ce9ead007bmr140240975ad.19.1784042126213; Tue, 14
 Jul 2026 08:15:26 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:15:01 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-17-vipinsh@google.com>
Subject: [PATCH v5 16/20] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
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
 tools/testing/selftests/vfio/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index dc06fddcf855..591f1a52c310 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -36,16 +36,18 @@ LDLIBS += -luuid
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-$(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+$(TESTS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TESTS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O) $(TEST_DEP_FILES)
 
 endif
-- 
2.55.0.795.g602f6c329a-goog

