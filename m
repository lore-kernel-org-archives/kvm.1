Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7949550D
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042126; cv=none; b=Gs/0XDpqb0D9uYysgkzRM1VZl8CoCDF26oXgcBusmhdpCXfod/zhIsZ/uQPpOlNRSjth/PgDawf83haaL8udWRC59vcRwofV1Rb09zjXuNGaMw32sKt9SLSxotNp02xIz2VtO9Q4DmlkGtqNtC2FFNZj+vLjczxYMG3Ukv34zKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042126; c=relaxed/simple;
	bh=ikkIKALeVfseIqEqO/ki0c8rJ+D/mTjIlQS+Bh7TNH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fVxBP7BNp4DWq3VcDnGobTnY9rwFc3ZlWeINn+zuivIotH7B0mhHL0rlUvJ4r3KnuWSyHK8G7hDxFTQPGV8eJC3S2BlnrFHpfYw/4X9Cat9xenaouxgMY1uEsTvo5LfD1hzF9w0rMieGbtYR/KdTErq1zkQt/NF3F42pO/y34Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Saua0PpR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Saua0PpR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84a3514f912so4346984b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042123; x=1784646923; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6euMhf7mogWwsfwAzliK6IQ37N0mgMRUyNxCkXOGnkg=;
        b=Saua0PpR+1WYgK5nic0uAf4ibCeyitepgMldrbhBt/QtD2vnwVJkePQf9zltqpv/4N
         kLOGC3oPS0zYBJqHKeW5hKdQfgyEo7g1wu9SXR0erxCzK7kq2ovXNbUZtmThYc0geFAN
         FvlEuxvfyHnfGP3MIzLPkDOEGB1X8c/XskYncNGB55TH2d2tzviTY1+6gtcapTPWKDwZ
         jEIk+gedgykX+vPlR/ymnkKhi/xv8eCzNrr4ApDkxAt0HYthyyE2AmVOiLuB7Q4oRNeM
         7/SLGMQPm2dRUXb2ECiwosQSoXC4S3mBUNC//pJrk0M9gkj/D84hmJMFQ7Yi10/xCsDx
         OldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042123; x=1784646923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6euMhf7mogWwsfwAzliK6IQ37N0mgMRUyNxCkXOGnkg=;
        b=S/iYLJnMlWp1QLSJOJVZwpl0iz3KaCHek9owtaEFrwyk3v76xZ/lfcjS73HeSc5f+q
         uZjue3zTpuczG5RCv5ueZPkAolkA6lKxrdnUqR/SXNz52xIS1HMMWLzTaxUFgwwnZHTb
         x3APZjpAzN6/iZ7bkVsYY5pXCHboj3/It1YBxrS7+vtOlZt5gb1PvotOKOPEiaClpWYW
         e/HMOhjL0CxXFdK9iZIxKpk2fVo/KYhJJeJwjQKUtDHnD46xCmEyC4bi7ln3AW62LcR1
         8hx+/IFfkDMmun2MAqrsF8eM0ZmENdFDPv0Mo3LldUCx4RqKbmV9el8mvUBzY+Af0UEp
         Aq1A==
X-Forwarded-Encrypted: i=1; AHgh+Rpn79s5mheVxc8eiWALppEH2q5G75wGM3aGvVQ5ANMmxax4BEst6fQCmbYESpsroaMBlek=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoi/mXcNkA1c13YqjljP5DYLXBAojij4kNOV52ild9eIhozSsy
	85VoYT1KRufxHnrWQi7CHjlzFfCzRtG+38Z0tvN1L4t6nD5lMx1f0rPvOS8wBXL9vTGtgEenI57
	cRgQc/fYtKQ==
X-Received: from pful22.prod.google.com ([2002:a05:6a00:1416:b0:847:7fb7:7370])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e87:b0:848:6dd5:f69
 with SMTP id d2e1a72fcca58-84a516062dfmr4085012b3a.42.1784042123043; Tue, 14
 Jul 2026 08:15:23 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:58 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-14-vipinsh@google.com>
Subject: [PATCH v5 13/20] vfio: selftests: Build liveupdate library in VFIO selftests
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

Import and build liveupdate selftest library in VFIO selftests.

It allows using liveupdate ioctls in VFIO selftests

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e6e8cb52ab03..4c8a30f950c4 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -21,6 +21,7 @@ TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
@@ -31,14 +32,17 @@ LDFLAGS += -pthread
 
 LDLIBS += -luuid
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 $(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.55.0.795.g602f6c329a-goog

