Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893292F6918
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854900; cv=none; b=Gb3lRC6spVxil6aXJr9KrE8D7+NwUEAbqveJ/L5aAzrXb+mAAPYTUagNeISIT44v24PMk8q0Jm9xc8lZI4c0w8aug2xk8j+4OcrheQHaVcPD/apabFyi9+4DyHzCtYlje+4Da0EKeuVHM/Ym1fsA5TUVqdnpWjmTZbwn75dldBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854900; c=relaxed/simple;
	bh=b8RnFfiemRCSiKgp7BSai6DqR7scjQ7rM1MZat3I3Zk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mC8O6McWigIkwTACOBFtig4lDjYmrraicFOMOYzJLCppjLcAc17z04A+Vc/DRYpIunnH7IHWOlt3cn9Cv+meFdN1/jwH4flrEC7VXN4P5hZO1YgAPU1YCejNfeuEU54IUbNvlGFNOeVhn7C+P8NCX0CrCVG9xZddS6P6fQD14Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvcfyXm1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvcfyXm1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca1f16e391so14619925ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782854897; x=1783459697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmjNTs+qY7n634WoJJiK9mzDi+CLz08woczbBq1WjCg=;
        b=VvcfyXm1PJnqSvVp05GzPmPHY2AKPLkwX7Yjg4NAqEDK7iFOkn/bkDbFACjLRnKHRg
         lCUsizhOLtH2SHkBk8jpqhqUYpyRzznAHajj5w3oxdkxJvpYHKujMb5vXRi4S3a9YaEK
         srmlF8he8AJpBqzpmvs5K8y43GHA3BWgZFRUco96C5lL+/TDcnYNvaEKwKo9ntpjYjbD
         ccn9Cj/TK4+T4oGT+ZPIaSGyn1AmVLmgCkss64KgfaILq5PU3HHyLRA6LpGIYsc2PhDx
         aurma2QTVBhzSRsERIF77LEm1yc+bfMJaBvf7ZiRXue8PgWKACSvGNHs9KmtgP8yyc8t
         RzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854897; x=1783459697;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmjNTs+qY7n634WoJJiK9mzDi+CLz08woczbBq1WjCg=;
        b=lTbXIK+udr0IvJpPUEsXMWdJw33dHeTUtq6xzY3A9c1vZUpISEbPxqCCWj9/danXli
         yHADHCYLmm1OS4pXMmh3c924uxzpSeoIumR3kZf9joZP+V66nwU3BEu+bZrlj7wEPPQC
         azqpGstz+eKliqf2gqp4A9klYxnmtF52DfodhpNkzFPH/1mqwlxL6rUyTUkXQq6lV0Zo
         RMbJRgzxZTFtCjAr/sOdOeVEt1nuEQa0UePMS56efgwoAf5TeOnKZuJvKiWqSHrCnWIT
         pXD2TNcTav88njTzZPqrXznARcpBg7Uf4jz3XoC8fXuVYC5qfsAho7NtDaF2IzxzYaLj
         pPWw==
X-Gm-Message-State: AOJu0YylYdF9CBqwiKa52HzJPG1usOIShqPUUZFWqk3GtGtWqoSzsWeZ
	TV8AZ/Ce1PLnUdL+jpKbydmZZ6xWiCgGm/Ff9iTOf5eAdCQD8sxulpGGYzS7TxGgkq2g7Jp+Fva
	htKCvFw==
X-Received: from plau11.prod.google.com ([2002:a17:903:304b:b0:2b0:5538:b55b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f788:b0:2c0:ab82:6bb8
 with SMTP id d9443c01a7336-2ca5a5eefbcmr18599625ad.27.1782854896675; Tue, 30
 Jun 2026 14:28:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 14:28:05 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630212805.474418-1-seanjc@google.com>
Subject: [PATCH] vfio: selftests: Add luuid to libvfio.mk's list of libraries,
 not to the Makefile
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Link to the uuid library as part of libvfio.mk instead of as only linking
it via VFIO selftests' Makefile, as the whole point of providing libvfio.mk
is to allow linking the VFIO library functionality into KVM selftests,
without KVM selftests having to know the gory details or duplicate code.

Cc: Raghavendra Rao Ananta <rananta@google.com>
Cc: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>
Fixes: e65f1bf8a2db ("vfio: selftests: Extend container/iommufd setup for passing vf_token")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

I would either like to land this in 7.2-rcN (ideally rc2 or rc3), or take it
through the KVM x86 tree for 7.3, as it's blocking a KVM selftest[*] that's
been in the works for more than a year.  I can throw the IRQ selftest in its
own topic branch, so even 7.2-rc5 would be "fine", but I would much prefer to
get this (or an equivalent fix) into Linus' tree sooner than later.

[*] https://lore.kernel.org/all/20260626213534.3866178-1-seanjc@google.com

 tools/testing/selftests/vfio/Makefile       | 2 --
 tools/testing/selftests/vfio/lib/libvfio.mk | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e6e8cb52ab03..2c32c48db509 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -29,8 +29,6 @@ CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
 
-LDLIBS += -luuid
-
 $(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBVFIO_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 2b8d73b7d329..67942b085068 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -26,6 +26,8 @@ $(LIBVFIO_O_DIRS):
 
 CFLAGS += -I$(LIBVFIO_SRCDIR)/include
 
+LDLIBS += -luuid
+
 $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c | $(LIBVFIO_O_DIRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.55.0.rc0.799.gd6f94ed593-goog

