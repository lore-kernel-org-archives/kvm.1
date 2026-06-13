Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38571F4611
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310037; cv=none; b=BH946QoBammPWxXrBxELZiDsHEhs0xaO4L6yuYDR2TLlL8u0Glwwj4d2C07cL/n6KlnvBg/Hb7mdo6ZUFI/Pvgla8rfqzQRjSrCE3bv9xXWAsydTpnwtr6qv/juqOcBaZToIXQEXuqd8xJ2S0JMqudCp5PKjiw9KLtcR8gR5lsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310037; c=relaxed/simple;
	bh=2qrP8HGSKX83R6U67UnzcZDXWcrNXLbnx6XraVWtofM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLksgrbrR1RuD6oP3aknFYGsDU/r403fWW7eKuJlSa6SO4yg7e84BTTvBvnf+uSzHchToifpY9JCiALdCOdRLhakOLkua9oBT6ciaDcEgSff76Y2ruJr9lg0FMRbj2IsyIjZ+lZ8BjtjNhknXTQILgqmRDUEmEhOr6XXatpYMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwTqscwB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwTqscwB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32259e0eso19213745ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310035; x=1781914835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/Iw6k9IvS6YCS0467Ck1NDjfIZOkbT+wEKpbw8XzGD0=;
        b=HwTqscwB0mgmT/K2r/QguQkrolu+DuFwLoAWyFTns8KD1E6C3ks9zYegtig3hydXPp
         CH3FNiLalZ8ub4m6tFlg4Da0rz2CcWVCDFPizbQz7Ksj0fYaq2/d0jbminLha9FbvJsc
         1XveZ8wrkXBzROIRgwf6J5LNWmSiO+0rDtCFNmyi+HXxGdRog8FXoqt9UZypyDnJN40c
         nifaMNHcBIePLhu6rYihBKTG2wGtw9stJOAyHP0nOziB7QOEAS7YJf0Mp9SoyF10/uue
         W+aHSjzMBG/gSUPXX6FEOMp6ynJ+UdnUn6kGfWlp2GFAyAOigifxHi9ptZ8JVJ+7gzmK
         gYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310035; x=1781914835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Iw6k9IvS6YCS0467Ck1NDjfIZOkbT+wEKpbw8XzGD0=;
        b=NFX2oXdx6JOHG/0ZtptVFeL8C//AsvRqzGTecqJeaVYta0bT2C+3DAtTQt3le/Cl1T
         U4laIeL/+QAU39Rf/FVKTlEiWgLRayhDZbh5updaKYzaDCOf4S9uRezSjHMFhl4A0RYy
         YXic+K3WLMR0CMG5UO8NccuWBQijdGJ0+o+jmGPLDa3l5lvC4S2nsjGB1WFRVfCiHgBa
         Fn/fOwrUfr2xC4R6S42fKfklw2XIofuSXRabUaNwqXkfENIPG0wreg9sdOqtEaImf18p
         RnFFLOV9rEfYldSpp5M+dWhEyXQDvFb47BZzeJKkvkmK7tVXL6w41d1YSZ+dUhjvg1Hg
         RUyA==
X-Forwarded-Encrypted: i=1; AFNElJ8xGk5RQCrLrqPFgwc6lZKcaRz2PrPNR79A5vijLw5fYQKWFH7xW77uImElVOKbx8F2DUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGEVDWlDPPwfqXWF52kxV27oF73/x8guFc8xyKYhwCFGyBenR
	ub7wAEgASimpLqcRTCXMkopV0TD8hZ4a2ssOrjFJ8cvq18SVRwvdhXvpKKEfjc7MvlNy4vgrGSy
	MAxxARw==
X-Received: from plbmf15.prod.google.com ([2002:a17:902:fc8f:b0:2bf:14c9:866d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea07:b0:2c0:d91d:c3e8
 with SMTP id d9443c01a7336-2c41050b2aamr61506165ad.4.1781310034931; Fri, 12
 Jun 2026 17:20:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:12 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-2-seanjc@google.com>
Subject: [PATCH v7 01/20] KVM: selftests: Build and link selftests/vfio/lib
 into KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Include libvfio.mk into the KVM selftests Makefile and link it into all
KVM selftests by adding it to LIBKVM_OBJS.

This lays the groundwork for future changes to utilize VFIO devices to
verify IRQ bypass in KVM selftests.

Note that KVM selftests build their own copy of selftests/vfio/lib and
the resulting object files are placed in $(OUTPUT)/lib. This allows the
KVM and VFIO selftests to apply different CFLAGS when building without
conflicting with each other.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9462919d2660..59ec232b1e93 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -258,6 +258,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../vfio/lib/libvfio.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -312,7 +313,9 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
+LIBKVM_OBJS += $(LIBCGROUP_O)
+LIBKVM_OBJS += $(LIBVFIO_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
-- 
2.54.0.1136.gdb2ca164c4-goog

