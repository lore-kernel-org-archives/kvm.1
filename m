Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C21389100
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405465; cv=none; b=IVmeRBzvnHfYttVushw01Ndn338urOMdn2ouEjm+1Bm4o2l2Xw8p/jN2ZXaUG7jbMsy/QSymhJAWy9IedLff1tYDskwvRf+wzLe0LCuJQuGwz3ktCgWnZX1eEzvv7vwYKVNSzzEK2yewC7YWvDtUgSvv0U4V4lUKH6v7s4O8bSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405465; c=relaxed/simple;
	bh=g07zdxChitPTI9twOohppbiWhlIxXngRCSMr4LUrbCs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOU0jOVXtDBADk+RHPIeNzW3mnSBbh0jd54eySrWQBOVbMTekYEPwhypFWyYcenm0JJ1+eNPmZRr2JTTlDt1FrEq14R87AAwpOWwsR4PjHTh0jJcACFSx2UVF94fiNnlxenshvW4E7VudusKS9LRXakV3A9IEFz6N/gd8s43Dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy2MwqiA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy2MwqiA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-367cb6de61aso12034168a91.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405463; x=1780010263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDuVHbbe9tFqK9kSIH2YOcoslIJRCEw3L/LE+oaB3CE=;
        b=Dy2MwqiAxd6eeeQP1ZZNdx7qQW7H7uTYry3Rl1EqFpOPCG6tZ0PSASjOM9nM2XwoBQ
         eEMCoboCeW2SoHH0iy6d5TSaDQPI2WRI0X1IgURORuU/fvWmoxvFXuiGgbaPw4zX88M1
         9IWb/cb/cOVA6y9C1cnyBcE5k3wSTGkEtbLYmPsQvJMqC2VDMFKTJdYnI0jsUSydS6IY
         6rrs9maHC+TGvle+5L4sXAQ05SrkHF3FBSORdPxlt1TX0gasGMubBwhbaQKcV8NDddHP
         z+BYu4ivQAVx4CdninSGApnMK2Az61JBWBrTAS3dDhNrQiIPqAJVjqfJdyvd7V3LWWp1
         HkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405463; x=1780010263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDuVHbbe9tFqK9kSIH2YOcoslIJRCEw3L/LE+oaB3CE=;
        b=TnYOjlYodsuKWcLD+9cInYJY06v9NfeiO8JEeQ/az1E2a/t50Q9Dsi0m83tsVWMzkx
         xOQEeP/QGKDgd2ZIR9S3keNxuF45PXC+YlfUMCkohOO/ckoh67UU/R/cHuIyra5P9Z/e
         RAE17HjPZSa+uzAsCS6khvGNsjvUX/kSaMtB3senTWd2nTtCZ8mn0KYYuqohwU5DbAwM
         oU51zAgsChkgX0o/mFxKWZUh1cDVHw/DZ6xawT01pKgnNe3Ge//Tj9jXopKglbj7y4zd
         pyDIGyLVWH+DkNi3hIy/CWh9fnlRdhiSkcZ2QWjTPnx9A6iLGXUq9mDD2Ra6t4FcvD8J
         LRnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/S5/DnKoPU1a1OR3zWPKltrY47LFk+Ro9xAmggROcZ59IH5lguNJdZUpvkkkxhNcevGys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkSKyb/+GEzNPcJ0Cg4lHas3ufYSvjGHrywZcxI4FNxRz85Fs
	SFx4wR98jANKs4gx8LkzehPJlp6Tf3U4W+AFqugKyhe0u8HJ/QDuKku6yaNMvumWqcQRtyqrE87
	FOT4Umg==
X-Received: from pjbii14.prod.google.com ([2002:a17:90b:488e:b0:365:f319:9427])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e04:b0:359:1130:1047
 with SMTP id 98e67ed59e1d1-36a677c7a77mr1021731a91.17.1779405462422; Thu, 21
 May 2026 16:17:42 -0700 (PDT)
Date: Thu, 21 May 2026 23:17:03 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=3221;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=sRLiM6RbKoG5VddtAxKgLddQfa2cG3iSFQQYT2bdoPE=; b=LQ4+Mf9N/xXTNK6v12F5/Hub6eIZiXj/exJGFNQFy/wfFpW4Gkn2yokdKqIUWZEOB5CKda52Q
 Vl26TIS53DfA2JDT220jZpKa3XPSiQ8gKhVMwHGOs/gTm6xxUIFU6wy
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-22-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 22/22] KVM: selftests: Add TDX lifecycle test
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Adding a test to verify TDX lifecycle by creating a simple TDX VM.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../testing/selftests/kvm/include/x86/processor.h  |  1 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  5 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      | 33 ++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 489324cecf83..14db8eb2bf0d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -167,6 +167,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index ed9c031b77b8..f65755482a97 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -372,6 +372,7 @@ static inline unsigned int x86_model(unsigned int eax)
 #define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
 #define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
 #define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+#define VM_SHAPE_TDX		VM_TYPE(KVM_X86_TDX_VM)
 
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 8276622c50d2..56538b1286f3 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,6 +11,11 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+static inline bool is_tdx_supported(void)
+{
+	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
+}
+
 /*
  * TDX ioctls
  * Use underscores to avoid collisions with struct member names.
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
new file mode 100644
index 000000000000..7cdcaf33b585
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "processor.h"
+#include "kvm_util.h"
+#include "tdx/tdx_util.h"
+#include "ucall_common.h"
+#include "kselftest_harness.h"
+
+static void guest_code_lifecycle(void)
+{
+	GUEST_DONE();
+}
+
+TEST(verify_td_lifecycle)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_shape_with_one_vcpu(VM_SHAPE_TDX, &vcpu,
+					   guest_code_lifecycle);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	TEST_REQUIRE(is_tdx_supported());
+	return test_harness_run(argc, argv);
+}

-- 
2.54.0.746.g67dd491aae-goog

