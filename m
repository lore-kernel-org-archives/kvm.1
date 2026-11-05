Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922482;
	b=RxP/KsYcegwBZ+JZMW/wR1GoK+tTojXP3oK3xF9VsqkoUkvC8SDUVfaTutt1JDwH+aQl
	 9ZDqssojGS1MgrDGJhnpTalOo0qpydUUIOnjKx999SiPpdegtXePqHPZO3kOt0xfjg5y7
	 XhICzl0og7E85h0l0Pl1oCl8WgthDm6FqCjQ8OE70Z/TBlspT/n0GOhUOznJL7R/3WpiP
	 ZEd17peUcYflJMkH+9PifRmcY29qyTG3BdlsIBy+MSBiqOOlYM9LMlbYk/Y9IuDPPqEoi
	 AaQJp8u7EmaRCc6OjagF+5X0jLeW3NyIxmS6RdI0u3wwMwCyCE3N/m7awU6h3YbouSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3APDwUUBO5Tor+FhWze8o86U6Ry1uRslwxSo4XqrbcE=;
	b=Cwmrmg8+gM5VAp7P/GwHcMdZLw2PDjkF4wOp55bi83h+MbRlNNVKemM5zGyKN5byHVYx
	 Uka4OUfVxy2HX8uv3DNZ2QBm1YcwE6DO/cmLTsHCtGuSEELioCzBzSV5CxZ7xZiSPJiD9
	 HpemM0dfKdLZ0k0fIcTeMDncoZALhh/+8U7m+blgMW8I2HVPZg2aH0xBkx7vK4Yyln7ao
	 rKnkfI6e6/LRVQTgHGU5ChjNaXaXnbdtP7rtzrcI1m8QP6DUJ15q3bUlGDj/B+gph/Fk7
	 tClR/lsQK3tTQhcagr/ZBSdMxPNRC/2WVyEGNZSfyTxTn4xTSOm41pvqAXd8gkJsTpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SldGp000;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184D60A381D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B184D60A381D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SldGp000
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaae62796dso732025ad.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922481; x=1794527281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3APDwUUBO5Tor+FhWze8o86U6Ry1uRslwxSo4XqrbcE=;
        b=SldGp000HO5eYKjIRruXFswTpb6V1OGSqMIcrnjFZXW7kUNy/vXs8/Hq4QHe/gd+gg
         Mg24FAXAhzpIVuJ79O4Dzf3JFw6pIuPGwlPmd26hoDR7NqDF25v6hxzw3Ps5/UP/Q90D
         RLU1kI4B+HCifskeaktSTDNt8GvBCNkkEXPIs+iZ1qRhbpIgkIz5241nCzPR0ft75tKw
         NFdBN3ObNvp3o/cfZ09my/dGLRzG+fHQIBxbotX6O07/xsIGQvLX/W86DOaaijpH4j2I
         Craf1CS+CzbIh8gkg5HUA9unt/lDNRlM6yoTWjd6rf6OWUNNUmj3AtvZtD+EP0UvCIk1
         MGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922481; x=1794527281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3APDwUUBO5Tor+FhWze8o86U6Ry1uRslwxSo4XqrbcE=;
        b=j7PqenyLpSRBZki1yjiCaj0XNBJUIODBtE0saQWlMsobGrfcilWYPD8AiS19m+d4sK
         YYTIHAWEPeAuPnYntgbTFuQXj8MDC+EnYn4OcEgYuiFJ5RDZS1rUDyFBBQ0MF1S7GIVs
         abHZq9M4H/hhfAFD+nSm5q8Wfozfbo3cofSpoMWDrzmgzSa9NCFPfU8kwyOjHTfZncfd
         rjezyl+jgKq/0WRpAsyPVxjKR5qPcxMOSA/nAdMmvf7dGiIJxbovQ9znuxZcVeATZqUT
         hoXENCDty2Ql3CE5fNsX6QOjzJOudVMzle7vB3LkD0Xg42Rb8+b+meKfQRKrn7dje05Y
         LOrg==
X-Forwarded-Encrypted: i=1; AKwUvBzxd0JVNL73K8CyjtDW1+krCrqMH5TMMRZcvB1n39hj56+Z3EphFe0Wg3rClD8vwpNyG8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QUHvmzFmx5AWB2fMqumxVrBo516QJdH8FKWnhVBrwEyyJ1FRY
	6pJ9KKYjfOvKo3DcwClIISpsb4sMewpA+X9cih6yQMMAdooW/qw3tAcgY/C1s72HwUpvtiXY7BA
	SN/JAkw==
X-Received: from plhn7.prod.google.com ([2002:a17:903:1107:b0:2ea:775e:19b7])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecd0:b0:2e9:9522:ed3b
 with SMTP id d9443c01a7336-2ed40e0f220mr10754625ad.70.1793922480859; Thu, 05
 Nov 2026 15:48:00 -0800 (PST)
Date: Thu, 05 Nov 2026 23:47:04 +0000
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=3389;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=rtaSAm22wUuQqMoCfkhcKnDPwilIcSWfTJAYTINBIKY=; b=q/dD+BNThuDw5f3at4kbEcwCii+6ek0wqsmjTN3LQGQmhXgtKQX6+UCbiVQitmA5mNX1BEa4R
 9z2eYcAE3KgA05oLcdk6QFkljZrZqgcF5VZUP/WWlOV1hgn5CBvSC7J
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-20-2024e8fa517a@google.com>
Subject: [PATCH v16 20/20] KVM: selftests: Add TDX lifecycle test
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
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/kvm/Makefile.kvm           |  1 +
 .../testing/selftests/kvm/include/x86/processor.h  |  1 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  5 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      | 33 ++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index ab797c8dd497..1ea7b42db22d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -166,6 +166,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
+TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 4db0c7009876..4c390edb634b 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -396,6 +396,7 @@ static inline unsigned int x86_model(unsigned int eax)
 #define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
 #define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
 #define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+#define VM_SHAPE_TDX		VM_TYPE(KVM_X86_TDX_VM)
 
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 67e717521409..cef54d2676bf 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -12,6 +12,11 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
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
2.56.0.455.g6c5a503b38-goog

