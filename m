Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D53939DA
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430323; cv=none; b=IGAEXC2I8BVBpOMaWkBFumkBPMICTu/ZNJDXpYd+A2I9CoqBKft5VJfQtUIHztRh+uML/V1QhxWTfwdY5bVlIuoKhgzcCUoiykWrqJ8cFeZ4xyKL7aBhvtOBIUy6VBrd4EtAbOxtFFZ4WkDeENwTyAHGeG2QXIN6dQcj9fdwQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430323; c=relaxed/simple;
	bh=y04dFwd5QWP+IqlNvWgSGMRQNDIqk+2uXcIZuSUqkY8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e9uRiWA7g5RuffjGWtxHnsG1l+a78ZtIqe3UBID1N8JxetTkqA3s5FCyAwsLWBxSCc7CHaVoxG/xYoJRerTRE5GnW14LBROQNmq9t33msLysH3eegGIlcECxG/4AUrLzVoEKSEYuVrUz1eX/bzphv5T4cltGoJ+nxjwH94fT2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeWU9iBK; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeWU9iBK"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d004f13426so29411895ad.3
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785430321; x=1786035121; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZGz5OPToGH5LOf1V99GZkk6FjXuQA3/sLBX/QC8yio=;
        b=eeWU9iBK2+wnsY5LJLxK3+wNKnt8nPVFG8Qx+0ivgvEePO92Qe8ZSInucUREBoRWnc
         YcCR+Ow23yvlGzFT4EGDtjqnmJbS+SaSwQCYHYtIJg9aaWC9wlldSUvWADjhwYcQSGHn
         aN1odHJBOZaGNbSXstYs3KOgBCctDmEgniWqTgc9jeZDsLR2+mbY8N65UiCiB0LgUnFB
         i2pRJTdcgoE3oLvQU5VShNLrBJHe5YERzpqypX+xRW/s+qilomF9BQj7pdOnY9snSBPC
         nWrD6b2ETK5pmslo7+zm5wvE+KaSquSjjNAAIOFhGt2hDmeyqlCqaeghSKKVf09rO2DN
         5lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785430321; x=1786035121;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ZGz5OPToGH5LOf1V99GZkk6FjXuQA3/sLBX/QC8yio=;
        b=Nsb1VYJBk/btTnVHPklQxF63oRubxljYfWzfpyo6XKMUKM5HwVIserjY8MYuwK/Ear
         6vzLL+CvkObv/C58WW37fhy+bG5PBr0pFP3OgkDDSoW1fZfddMsA8juT5oXNkzq3yBlF
         ZQiep9EBM4ZAdx2nSI7BUlCoS7jwL0evAnanAa2tWcXHutfQ8/obJfxlOdmjjpdGlqeP
         0rTjRGiPyFyaq3k0jmDKbVi199E++T6bBOlnGSFgwZ9veMatta5j9LfTmxl4eg4zSjBb
         K7Onpvgf098crxmbohddUU0eFB70yUhLfbI+vaNe+qtKbZuG7hMOb3DXKrDAFEeJ9Ypu
         LRvw==
X-Gm-Message-State: AOJu0Yyy1HrZIs9CYC57UGSSLm7nM3aAA/XN/XRaISMPO614lT8amKw1
	4r6huGOshGS1duU9F9MEbY0DQ2RzkggJPATRIK4eQfeMPNIFv7ppgEMSq6Ldz3GTcQQdg6m4bYZ
	iX4b13g==
X-Received: from pldo18.prod.google.com ([2002:a17:903:92:b0:2ce:7984:4347])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3848:b0:2cf:b23d:79c
 with SMTP id d9443c01a7336-2d035e472e6mr28070495ad.43.1785430320812; Thu, 30
 Jul 2026 09:52:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jul 2026 09:51:59 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730165159.1988017-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Only link to VFIO library on x86
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Link to the VFIO library only on architectures where it's actually needed,
i.e. only on architectures that support irq_test, which is currently
x86-only.  The irq_test series, which pulled in VFIO support, effectively
raced with commit e65f1bf8a2db ("vfio: selftests: Extend container/iommufd
setup for passing vf_token").  I.e. when the KVM test was posted, pulling
in libvfio.mk didn't require linking to any new libraries other than VFIO
itself.

Now that libvfio.mk pulls in luuid, unconditionally linking in support for
VFIO is quite onerous, especially when cross-compiling, as it requires
installing what is effectively an unused library on four architectures.

Eventually KVM selftests will likely support irq_test and thus need to link
to VFIO on architectures other than x86, but at least then there will be
some amount of gain for the pain.

Fixes: a262fc49e0aa ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
Cc: David Matlack <dmatlack@google.com>
Cc: Josh Hilke <jrhilke@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 88c6c8046dde..ee91051786d8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -261,7 +261,10 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+
+ifeq ($(ARCH),x86)
 include ../vfio/lib/libvfio.mk
+endif
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -318,7 +321,9 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
 LIBKVM_OBJS += $(LIBCGROUP_O)
+ifeq ($(ARCH),x86)
 LIBKVM_OBJS += $(LIBVFIO_O)
+endif
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 

base-commit: 3c7d7f908d574277a845423ec32250a8d8df44c8
-- 
2.55.0.508.g3f0d502094-goog

