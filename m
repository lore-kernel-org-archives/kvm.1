Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273647D45D
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235014; cv=none; b=OKj6OjFLy5ICjLVQWP2+5+VNGjKCu0uZag3Ew6o+Cu0MEP5CJmgkwIuvyoU4kE9K8VZ00Jzl1sY6T4WGMntVpqpz0aKmVbmLljkkPMyiQZ0O8R7okQS7PDckoEi91t65GtbTGGd+TjuEkpkQUTT/yHTf8j3TUx02uBfgYurL4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235014; c=relaxed/simple;
	bh=7GJpk+Zm7RfMxIWiA/UAYftsuVNurXh/QNUDx1LsL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7geg1tnSwUci/lA/7MPDByo8s049DFPUPx1j14GXBql+q8lE8RcrS8I50Gec6g6UnnwV585/Kt55QCvNqQXybwUV5xgcoJVl5LiXq7macaUVFdeoUr3XzDH96Uv3EqDl9ZVyDJIiDhnfMbUyxh+tWG2Jru6W6WFLEfqaVwIDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USj/93rV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USj/93rV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e812e2b31bso3584435ad.3
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792235012; x=1792839812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tf4fy3DAykjNBLlmTR7a2o12P+Rb24NlY7yvH7wOMkE=;
        b=USj/93rVMZ7kMj/UgK8nl+8jzPWsmEaGOUYt0f2cZoNZ1EM2s0ybq5ydIlaZfOhRCK
         VecqvOHi7U0mAJ7m3LTuMngG4Lm/Q3H79Ubkf5SulOLs/tM54dWwHOjVOMZ9DtuBaJ2I
         WyThx+84LCg/d2c2hL8iS1XSw3c71q0TwYtE425zxQjlvNuK33YXqWFPyeCFdfBC0FXu
         MKP4NLnL90laYp7AbosLBtDuSdsRyJeRI1PtJOs3nVqKbUHhIlwAgVtvZR5qnf76w3b8
         sgQjwqrQdQ5elToLA7JJGLz1bwopr5gQNZ7QOaDGZLy4GAyERzrA2J75n1RRUnUizID6
         wC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792235012; x=1792839812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tf4fy3DAykjNBLlmTR7a2o12P+Rb24NlY7yvH7wOMkE=;
        b=N9qYa4tpSsth0bWbS/l4Q9eLRkkV/m6Lwj7/IXXFKFcsCn7hfB45OHkSWjnqQ/k7Xy
         9uDHiCQcWjd/hMJK1QPMDbIUbTnEBN2gFMX7JxcS8ptU3BDwMeL4oLmIw5hPBcCsGR4u
         gCZdxIxd26bxRmiUpAfrWk4rV3tTfmjQ2edCW8/ei18b3lPT0O/1ziaRhRWL41l6hjLm
         hKCe0I731dp+kEoTAsrNMRt/T5+6yrFYRBFfwOj5D0luFTqV+9zcYxZytpL5ceRKK95O
         HGXD4HGMX+SYGmarYA1KslGr/m/wl3kFm9QZDF3Nf7p5FCF83PFI2jytg27xn5Hle1f7
         JirQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGn1CtfmqpE7YcvRtYH/9xmbE0OPZzV6SV8+tNTraPCx+5fdk6x+ygLVhKmYj1/YVwxxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJLloLfBDhuW0wE2r9epwFLJd42cbK8nfJZVVtkA/Hp5eSdVXp
	HDS/46tFgYoCTayA6girkYV16xszTJyHPGRcSUkYVUP7NMS3dyqXJl8d
X-Gm-Gg: AYBFou0XFVD3Y6k5IUXHozrMyBii5ghppiJLCs63hJPHTxiwnA+QaqRZHgUbSl+0Vis
	gskZW8xVQGhX/bCrcK9mdneDYLAjfLMLoGmaaJKIdkTO1ERKNWQkV9N7d9Qw/5ROLvGVJ3mpzEz
	twJw0pTeXeGjrzsJO8YZcA6Uk67H55swIZQIwS6G8OBU4oXvzgNsI5NvUc8HRP/zJ10zvq2NZQd
	5BXQcbBMKeEKjFwY/7ybh/LG3zMRapD280C/s2/pQ/6pHBOyaagqPlBQIgsvviRB/D4wAHRzUoh
	FZZNvj4eCakOxQ54m7SU0sQOcZBG9u+xvRYn3XsERcFAZ8vchfShfmZx0xpI+eheQDSTTY2+FIH
	iccsOduYGrUu8Y0RJBKa9WzJj6vdOZBu/tulWxOpYCkkSd6EaYQyhjbTAQYvoWEPtLXblZbzuzZ
	r0+Yw4Kh8u5Gok7/K7FE7OSW5D7iwZPZqYu0tDES4kbgR741y0SS6LhHMlXH1n2ATyUmPdSDRpS
	AbcoI0nLDHt9XajU5hEzA==
X-Received: by 2002:a17:902:e84c:b0:2e9:6b5b:3db6 with SMTP id d9443c01a7336-2e9a69e93d4mr22504755ad.30.1792235011936;
        Sat, 17 Oct 2026 04:03:31 -0700 (PDT)
Received: from x1c ([2405:9800:b670:b64b:7c65:ff3e:80ba:b06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804dd9sm20559955ad.16.2026.10.17.04.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:03:31 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>
Subject: [PATCH 5/5] KVM: selftests: Test protection of the ucall MMIO region
Date: Sat, 17 Oct 2026 18:02:13 +0700
Message-ID: <20261017110213.46199-6-tharitt97@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017110213.46199-1-tharitt97@gmail.com>
References: <20261017110213.46199-1-tharitt97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that creating a memslot overlapping the ucall MMIO region
fails with EEXIST and that ucalls work before and after the
attempt. Skip when MMIO ucalls or read-only memory are unsupported.

Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/reserved_slot_test.c        | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/reserved_slot_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1f4bc2a1322d..ff4a5e9733e9 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -68,6 +68,7 @@ TEST_GEN_PROGS_COMMON += set_memory_region_test
 TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
 TEST_GEN_PROGS_COMMON += memslot_perf_test
 TEST_GEN_PROGS_COMMON += vm_types_test
+TEST_GEN_PROGS_COMMON += reserved_slot_test
 
 # Compiled test targets
 TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
diff --git a/tools/testing/selftests/kvm/reserved_slot_test.c b/tools/testing/selftests/kvm/reserved_slot_test.c
new file mode 100644
index 000000000000..4a908017ca73
--- /dev/null
+++ b/tools/testing/selftests/kvm/reserved_slot_test.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define CLOBBERED_SLOT		TEST_MEM_SLOT_BASE
+
+static void guest_code(void)
+{
+	GUEST_SYNC(1);
+	GUEST_SYNC(2);
+}
+
+static void test_slot1_protected(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	u32 nr_pages;
+	size_t slot_size;
+	void *slot_mem;
+	int ret;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	nr_pages = vm_adjust_num_guest_pages(vm->mode, 1);
+	slot_size = (size_t)nr_pages * vm->page_size;
+
+	run = vcpu->run;
+	vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_MMIO,
+		    "Unexpected exit reason = %u", run->exit_reason);
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_SYNC && uc.args[1] == 1,
+		    "Expected the first sync before clobbering the ucall GPA");
+
+	slot_mem = kvm_mmap(slot_size, PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS, -1);
+	ret = __vm_set_user_memory_region2(vm, CLOBBERED_SLOT, 0,
+					   vm->ucall_mmio_addr, slot_size, slot_mem, 0, 0);
+	TEST_ASSERT(ret == -1 && errno == EEXIST,
+		    "Expected the ucall GPA overlap to be rejected: ret=%d errno=%d",
+		    ret, errno);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_MMIO,
+		    "Unexpected exit reason = %u", run->exit_reason);
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_SYNC && uc.args[1] == 2,
+		    "Expected the second sync after attempting to clobber the ucall GPA");
+
+	kvm_vm_free(vm);
+	TEST_ASSERT(!munmap(slot_mem, slot_size), "munmap() failed, errno=%d", errno);
+}
+
+int main(void)
+{
+	TEST_REQUIRE(UCALL_EXIT_REASON == KVM_EXIT_MMIO);
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_READONLY_MEM));
+
+	test_slot1_protected();
+	return 0;
+}
-- 
2.53.0

