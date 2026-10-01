Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F8538D62
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883539; cv=none; b=hCZckrq6Q9xL/afVYZq/5dsLP75XQ/YqcVhF6pmyRvpgijwQLx61PESoDu0ieoOF3hIh8HvyZn/QJsR/AXRRA+WVql33BT5lauZeSfgdWMPGWaKJWgY4cTeSfGofKp1Ip26wQ6Xk1Nm4MgjlMQ2CzUHcVMQt7OrttyMi6uitVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883539; c=relaxed/simple;
	bh=bvvMms5Mq0V0ojOMhq/1KL/irCbrmagZq2kHnu+JWJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkKlYawwGRfeNVd+K8nsRmuOcoB8EDPH1A8dEn5mLAPf25zNV89rUHlDsrYAtF8dB6v9wPpS97Ldxu0QF/AciK2qlSLF4pd5SObiw55NjQ3/mhG03mdZvKdgrTD4zpL513aStBMlxqldK24inDK19QAuv02SwZbllBSxvgOX1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/z7NINN; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/z7NINN"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d001671a54so69219805ad.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883536; x=1791488336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6DHx4mVjUCF68ITps8fQJ3UYYtBbDCCWLiPyDIDzxk=;
        b=Y/z7NINNi+oPvSjyifJ+ckuAjwYRwIjKOiz8TblsbzYD4UrsqX3NmvuOHWujTVUhrw
         XOL9sO+k6Am/U6qqt5BtlwsCm+pUJ2uFrHTBRJeVm8s7/TG5UylEvZFkHxQDP1i4a8Ea
         dtxORiL+nA7Wy6dGDCvNez8y46d+UBL/jpL7EnCwhb8XHlazz7D7SjuCi+/97LIbyzFn
         Zo+A/WCk4Y3KB8SbkK1n55kS50/7JTMzmfCvClig7ql8dLCXsEtHVPRn3JY0FDQdr82l
         prEKs1aoodHYilfOV/55PEMyfznGMRfKLtZkx1apiKWtzNQUVZGetVpbNv5M0QTnxOjK
         VmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883536; x=1791488336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f6DHx4mVjUCF68ITps8fQJ3UYYtBbDCCWLiPyDIDzxk=;
        b=Ed/npUnO1JjGrYJPodzYazd4zYuZA5IhB7ku8yBPxhRh86iKMeMoYcgom+T63ppEox
         hgvYsCPzUu5F/gR02A+aH4iUsx2l0GCoFnoaMpDpkdvEdMTTUpRZ4ZIuWw6bK0G2pdgJ
         udLcqPTZfbHAXegvDGQjAbOoExd9gTUGd/8/pj8F8Qqi8l7cYF/gkSwKWkaDFS1Rzo7y
         J4r3SJoiv/6NJ+Sx2qNsa2MWfDh3Tq2yIH/NruET+VWZm1rgq+MpI+n/O57PN4msVvk1
         sBQHy9XK4wo7h7i7Srn+xJZ4Um39NXZEjA1fQt0YnyzK1DGbaEF0lF3z8KZXqCPdw7Q0
         ItqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9Ua6sA2i2CLMRa71xn5wt6IZ6xtLOADRKBEreXKlJKLXuVB1oIEqStaE5hIPXi8PbpUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjhme/mynWl0pPX6cTzuqKZhaGAVIfQS+eAX60stRsFU3nZWGq
	gxiJS8HaHJ3tR3ZgUxluvhLU9ahzvucdEIOl2O4gGa+nyIl5rQ6deNtBlwzz7KToFXRWyE/tCCi
	xLmf5ew==
X-Received: from pljg24.prod.google.com ([2002:a17:902:fe18:b0:2e1:2a93:3745])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f685:b0:2dd:c100:b2c5
 with SMTP id d9443c01a7336-2e49b7fdca8mr3329635ad.48.1790883536152; Thu, 01
 Oct 2026 12:38:56 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:43 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=2986;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=7IIE0zsKtDI6/O9FzsIrIrODoz41LwlvaBTgumYAjkM=; b=9wjJH4QxYzM4d9NEij4Ug8ef4a2EaOZ0ZJrc7Py8IIz9kgg15VKA+1kqDMli0dYaAx5s/j/uY
 Kc/xcTAiLtCAJUNm0NvR+BfY/jnoEtW4Cb071KSEydNxSp+GmYSTYpc
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-16-7c62a5d8a992@google.com>
Subject: [PATCH v15 16/23] KVM: selftests: Load per-vCPU guest stack in TDX
 boot parameters
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

Allocate a guest stack for each vCPU and record the GVA in the TDX boot
parameters region to allow proper vCPU initialization.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c        |  2 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index f5b2f32f2118..72497724a2ee 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -70,5 +70,6 @@ void tdx_init_vm(struct kvm_vm *vm);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
+void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 4af9cbf3fabb..2d2160d68b9b 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -888,6 +888,8 @@ static void tdx_vcpu_init(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_init_cpuid(vcpu, cpuid);
 	free(cpuid);
 	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+
+	tdx_vcpu_load_boot_parameters(vm, vcpu);
 }
 
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 40ee9b1951c2..270a4ee1b7eb 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -90,6 +90,18 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
 		    "gdt must be within 32-bit address space for 32-bit boot code");
 }
 
+void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+
+	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
+	TEST_ASSERT(vcpu_params->esp_gva < (1ULL << 32),
+		    "ESP GVA must be within 32-bit address space for 32-bit boot code");
+}
+
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

