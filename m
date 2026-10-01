Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83E53D9CB
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883548; cv=none; b=Y5ylVkkBrsud9qkjct6E8ZqiPl1HLXpxVebyGbhOVnNnMIDUPgp2FDv9XLrpwPLJKeYWsOnORP0kmM8edyLYLLpWHOsWBfFqTQS9esQvfyYjNl3V66532HQ40+4FW11PiMOlMdajV/rzXnB7xKgZGYPnt8XLDe0Ie7OYC7G47Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883548; c=relaxed/simple;
	bh=M4dXSBge5+OeGOkEPm8tEyn1V45XLSawDxNn3M/5cP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YFIfd7ohrZHnGiKug0Z+Uf8nXsMJ5dL0Mr3YXZRvoBMivOqWtU6NuSQMBRRYoqhpKrj6urTTaiGMDeb9hzh7j7bfO0FI3cPGnARmb5392XDdhkGOEAn/alHpksxRt4eTpegoKKeSzY7Uq7zt4mNNi740fq1EMbHsDu1IWgwsAJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsgPbx7E; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsgPbx7E"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so8166176a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883543; x=1791488343; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWuVYqccoZ0xuvlXXUJd1igxfZmdeqLxo/EcY9b25x0=;
        b=FsgPbx7EGcmCQEtmqs8CaWUXQtxOnfFoyzsyffPBnuDBb4mIzofE1i82PiLbSuDtZ6
         lx1XbgCDij3DiTfRT2CG0wWeyJYNhdzlPE9quNk2ytGhmpz3OSYBcSRREs3s0/n/09Pf
         zGGqN9KKCia5ZDo6iCuVvecYLMESxwpQK9zQoU1mVbM8OAmv6JvN4n0RSH+H55+bAvtz
         c+/IVqD2jlqyHoUsSXqheE0opTZtJxzdff5iwiFiojUDsjpYpTGaQZLVUKrH+iWwDunC
         ykO9MdiHpLQC3UdrhP3Y7PyIa41FctMcQHs/fPfurPrZpYmyU24ooPophNsVGkpUcrWG
         nJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883543; x=1791488343;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kWuVYqccoZ0xuvlXXUJd1igxfZmdeqLxo/EcY9b25x0=;
        b=CXcMRV+OaM2rMSCSDmREfbjfbibGxjPb1fZaw/aKQuXblX4gcjUwOSAWNeIQY3dzR4
         zqVjYcvbF15VM9F9KvBSpDeXM3chh+TvrqmO3BLB/2gLgzDzFI0rQu8D7yc7gRpu7IV9
         qgzKwU4doshb1IteBlgC2dTpq8zIuij2xeCD2l3PcJ7xYnJ2e7fquKy1+2n342sMvXMm
         ZXXI4zA5tUdkPa8EsBx8dRs1+Px4FueFNUTJEL+qX7YKE1nqy6TiamLoaROHFto82mAf
         qT/zPypPP9Tl04KKB2uAx85iZedlfXTsTE+MoVyqzqIT30zLF1KiARQfYW2sOW6IbcFk
         AzTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUd1y+qlyPrj3od3Rg6dF6dEUeZDiKzv8UUstvVWzZgj4XqjJNjTNqri/dvJV/Nri5O/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+C7KTC5lSwdfESC/pnPYTtmag8ccNHDJW9r7fuKXXgjydhj3s
	OML8l0tSFWLkhcTX1FLIdxubBp2tiue/ZW5JhJtOHE8EjfsimM+vcLT2B9ysLMnSGt9vZTpe5Ps
	Q01jGuw==
X-Received: from pjbdt7.prod.google.com ([2002:a17:90a:fa47:b0:3a4:f73c:50c4])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2585:b0:3a4:b418:94ce
 with SMTP id 98e67ed59e1d1-3a6ce5fa387mr579569a91.1.1790883542430; Thu, 01
 Oct 2026 12:39:02 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:50 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=3341;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=eahQ/Qg0Jjy4E99ZAgvlDKelpVaZbNc+WKsobSaVqcE=; b=Dwk024wKMQMop0ug36RFw+ZisT1Gxgnh7qxnlmzhTrCyBGcmUvBqXFBld4BObW7rX4ebrGJpP
 Mwwe+dWVRoIC8u0q73KBSPTwOEnU7St2O7f139XS6ZpyMq6h8yR7nMc
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-23-7c62a5d8a992@google.com>
Subject: [PATCH v15 23/23] KVM: selftests: Add TDX lifecycle test
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Add a test to verify TDX lifecycle by creating a simple TDX VM.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../testing/selftests/kvm/include/x86/processor.h  |  1 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  5 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      | 33 ++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 495de8ef8166..14cff95cf291 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -161,6 +161,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
+TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 1eb380dd216c..61ae02d927c1 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -393,6 +393,7 @@ static inline unsigned int x86_model(unsigned int eax)
 #define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
 #define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
 #define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+#define VM_SHAPE_TDX		VM_TYPE(KVM_X86_TDX_VM)
 
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index dcfc62ffbaeb..85791fe16f68 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

