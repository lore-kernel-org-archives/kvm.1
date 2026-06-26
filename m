Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F43BFACB
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509739; cv=none; b=hLPafVGN+OiZgAs+8Wq3iEfF5AnDNV8g6gVA4AuWrRW+yWfDzRGHbngcmLR7H56LkTfDtyiDT8IelH6R1q/cUMUCSlB2ojLSnmczA8iwFooG0vB/3CQxao1hYyFMVAgp54A3uOANvhouRty947C+h7v0YFG73UWk7W6pfNW6XVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509739; c=relaxed/simple;
	bh=2O0WH3pvR3gLzy2R+GyxwzyDg8G99Zdln+fhYAUluQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YX5UM6tjyrTgTaVrkv/uado5PQJifnZbTUQ98TLsqEM+jXhrT3cV+oj4ocBTStK/JXia0wASkzhtYbRXjcxEpEqjeWRmY0ofBtuaDFql0OSmbv6xQGI9xDV5vBy4W3DuTOS+zTaTxCjiVcG9CxMvjJtm6i8MIy2b9fhYBQ2SpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaUV7NLM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaUV7NLM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37df91eab27so1388758a91.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509738; x=1783114538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SQrCOvI/gGqY/5lmFouPkrLmKsRGpPhinpGyhSDO7Ek=;
        b=BaUV7NLM3TMO9EsuTsYI5CGyIo1stGTBwS6fCv4mjkwOTGGeghXmTneDeQXLSIBlfw
         MFjrwibkb2FiV8AtdOERxcC+3fDm/00kGbzP0d6xXqlgyyC0FWJdx0/1xNv/QcRFGa4+
         Bgoco9QCGFr0Q4azfWofKgKKMLx4XZmBQ5bnHpmSm35MUsPN0cRJxRxBAHihouCmv+BJ
         mlNUePfzkY+4pGzZAv8RrEAMVP9s6GVyowOtl6xd6VeE+Gz9gnK2/X6keJtzWklAZem5
         TdKqFM+OLRzN0aVyMyIs5NktDnVmm4CfMG0o80CJ1RTGbe3y02gUFM1DC+AOBJ3n6h3O
         ts/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509738; x=1783114538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQrCOvI/gGqY/5lmFouPkrLmKsRGpPhinpGyhSDO7Ek=;
        b=eIFwP/y6rcRgA7hnHtCs+OpTltM++8CaE7J87XtDqzEGqlQL/pXFRYZ8ptlbElL6yp
         0JgYAlkOU+DuX3tlzjmJVCCGXbxHm6+N/3stPmgzqRzXA0IlwlnWMn3H9Rf8wNyaksgr
         Ds6XyGiIqqv0AHKgA5XDx12OpxwNUHKxttP8VIsR2jCSm3NGJ2Xl1wTAGt+0gDm53UFc
         5gPLri/Qx312JC/PhdvVMd1pIY4+/e6CBJeBMQRqcZqtLhQo7QX/3M3kr7OxXk0r8BGm
         uicvxuA/GroZI77QKfwN+2pCEF1POxTHxYmRWyIQU+TOx9nw5hTe0uD+gXABXCVApM3n
         Mlag==
X-Forwarded-Encrypted: i=1; AHgh+RpePlCRE5dIkcYCC8ef2u2foCiWsz8bv/Q4OkLGp07eXUwAWG4OIYY4Mit4U+lnQRubBog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGVQrbaQS+F/vaRGNiGyswOwW2TCZulSsLHLTIlzvRJA1+nDJ
	05m577U0wj97MmdW/6vzBjbW2SquLzz198LwFJGfxrpT/wOOJI51pnKFW30E8KWHDe+gth6CymB
	tM+YlIg==
X-Received: from plq11.prod.google.com ([2002:a17:903:2f8b:b0:2c8:17d:91a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2304:b0:2c0:d91d:c3e8
 with SMTP id d9443c01a7336-2c7fc65423emr78308535ad.4.1782509737490; Fri, 26
 Jun 2026 14:35:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:14 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-2-seanjc@google.com>
Subject: [PATCH v8 01/20] KVM: selftests: Build and link selftests/vfio/lib
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
index 4ace12606e93..ae0dfd67dd31 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -259,6 +259,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../vfio/lib/libvfio.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -313,7 +314,9 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
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
2.55.0.rc0.799.gd6f94ed593-goog

