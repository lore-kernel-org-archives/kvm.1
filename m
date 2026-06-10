Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CE1F8755
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052824; cv=none; b=Uv/3dSaRHsVUOYyKcL/s/plNX6/SRwqK+bC6KDLOvkQJ1dppwOmj4j3d+3IrUnaBojrAxDeMo8rQwUDJgcjTGWBeylGqE4JWV6aEn0nGVJJhn2f2f3hfB6rQb60T4+MM4sn6PL1iOeCQHg5ipGAnMJAotfF3DdldCv6PDLiUsvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052824; c=relaxed/simple;
	bh=ZICe4hE+bdgo/mmBoriJdsV7FkTThoAxxO0XvehbVwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eJFf1hB5v2jwBq9Jnm0mCj/uxbaHDdxiE/+OB5u/wspFnBAHDurqgtyCypawxTyN7JqFP7QQ3YpH1bXCISbFF84TW6oTL+mVH7h6FZpEkqfVWcKqUO7pQbGKdaRmfesle40y+xD/Qc5ksDiiATU6DkC4kUzT3tC9j85J1eUVYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MztX0AsL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MztX0AsL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8584e80bfcso2667381a12.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052822; x=1781657622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E3dsDf1mwPqE6CLqG/GF7U0hvBMIyZSe2b/ARirZzXU=;
        b=MztX0AsLHJ6sZ+wQAOrQuppHz/MdxNlR6epx5ciohFdUfIVDAdI/zZAwWd833cz+ui
         jSHXuctw1tL79EJsJVSQuIJIGWs8CBwehb7INeXfUTaVJqnDSP2aoSZh7Xl9AlnAl6Zb
         DNo2HUWDkph7rbSuboQKKXJUXCZAK9a/A5rsysBQq261NoTzp7TStYklN4ybfwN0AASM
         YkdkoD+SQGk3O+xePANSV6bxci6EEROP74mW+zWJe/cSLePj6hIO+Dh+YNhJQ2FHewyL
         yRM/kDYTqMe/UKxmtfnagSt0l0Q39V8yHfJZ4qyC8A5Y4T3FEJCxN3xqWbLppioynMN4
         Sx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052822; x=1781657622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3dsDf1mwPqE6CLqG/GF7U0hvBMIyZSe2b/ARirZzXU=;
        b=jSq6HbHaIzS2YLHIGhdKmreHBMX33lXqeYFOcZmYFHDDlxgTDS8sNhDoj/EX8He/Ey
         nQSI0HdTEJsw5F5H8+I8ibRFMb3PULEqKaYLTnUbM66D+NyprMWGZHtlDsCxf3S7nKEW
         ba6UFI920YzeXsjlnIk3DUxhfmMcdlKI84WztTAy4r2CgWjnwUGrvMusb0SmNc779qtv
         QfSAR1kGf0eWCqhiiB9WeINwURXPmBm/6ejZg7m9t0Z5A1Yvt2TBLCoZhUZJHnAyzyOg
         Dt4vfe+UV/dtdQT76/xZh35rh1Fudf1HO59c0Q7/wE+03Uz4A/5iuDkBXJME0JTCkaqh
         FVow==
X-Forwarded-Encrypted: i=1; AFNElJ+qdXpjiOMTf2CdR4lTIlYhXYmk7qZSEcMKG+UiaMlAyDt5poQK1+klcDgoa+KVK+h+5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFq24Jd5xJmWN6gN0429rjzcTJhoc5LpYm/wLeGefvUibsy7DM
	lCFgU2lt0DPq1XaAAnQJRvIiXLd5Q53r4Rk3yOMhHzH5j+lPEzpaDtZFapQnjQxzGdKdSUPilB7
	KJRL2yw==
X-Received: from pgwa8.prod.google.com ([2002:a65:6548:0:b0:c86:2164:9671])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b87:b0:3b4:8268:23e8
 with SMTP id adf61e73a8af0-3b4ccdf102dmr28032201637.21.1781052822397; Tue, 09
 Jun 2026 17:53:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:21 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-2-seanjc@google.com>
Subject: [PATCH v6 01/18] KVM: selftests: Build and link selftests/vfio/lib
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
index e0ddd3ff9472..14316358fd9f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -257,6 +257,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../vfio/lib/libvfio.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -311,7 +312,9 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
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
2.54.0.1099.g489fc7bff1-goog

