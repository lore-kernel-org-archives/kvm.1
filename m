Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97837FF72
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405460; cv=none; b=bB3L7GNdVgu0WO+5jo7N5BfM1ojdBg3Hjfu3ci4Km9v3cDvFl8JPBDVAeqM+0IpDw8g/Oo1sXQN0QcEgTNBRK94/nnK7QkjFrLKf3ejvPgjohYQZBY6RWK4rvEJmSI2Di/Qqh7Q7UW6aSpcxxW6CTyKm78zparEu50wuh1DB+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405460; c=relaxed/simple;
	bh=qt2LXBAAVSatCHk6qv+r+f44VcaymTYLSqG7UfqKo1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NaBZztMFRcX2hlzE3XMM1rKuUtSZeyMIwbshnsl6eqY+fDedykwwqWOPhyf3n2AVKSo7hvIpZ1a3QQ3kjnBAEzzAKuY3lSfH2ofEwJeqEvBkRAqGQwETSYV/n2uyUHmp2kbcG6CJI9nK5UzzH5dm5sqwyLL71+Vr8/67Bmc1q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLlGG9rh; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLlGG9rh"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c850fcc89d1so922013a12.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405457; x=1780010257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjYeydDvPiSOX/QiZPpD+8PAHMI/7cV8oLRW0sTcZdI=;
        b=LLlGG9rhHlYjTo0tTJyRYbdwbsCC9vDSsuWK5X8c2yToHy0jbSJy6Prh2oqkWrmAtM
         Bz4qcyB4vVBJVxHOcSN9mVtiOjUaPc+MDs384AGTgz9z0cDq54CAaAH+uayY1Rr3y8q0
         gCH6IvMoqNemwhgsKjGA+69F3FTlPPRIXoiMUga0X9KXgnMtiWWpRN0XdyASdBBVn2lB
         8e/OlmBYn62ev2ND1cVQxdRTsDkTD3/Kw84Jx50QhQQHwCf5F6tMAXQ/AE7xTk/P0QOi
         qDIJY6yp85tpmvU95nicwfV8lGfe4e1P4Es0hWjyJQ7rKYu3xtL9PaQB4rAObFmkwu0g
         LLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405457; x=1780010257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjYeydDvPiSOX/QiZPpD+8PAHMI/7cV8oLRW0sTcZdI=;
        b=oB+8tYzwauNB73McQDQC+AFPF690sZcJLGfdTCAcwriuyDLcYj4SuCihkL5wd9p5ei
         6fZ2lVMCuViUEIpiOElLJNg8hXil5bV5/PVko9wb/yQXmabdY3zSclf81b6PewhKmmQZ
         wBK9mBeuXR/n9kKWMjIO+/dLg+GJbj/8y2wDZYPFLkbk5vbozMXgtP14fSPujzpQO49i
         9bhUYfckHApcgV+MWZwyjjucLY7W6H2DTJOXV6B50YzcVfnazV0pdMERVjFS/z1fTuQi
         qKCPP5Sk1GwB5nXdb81OL2kZz6e0YeWM6FH53gL/wWO749jKIKDHst1UYByDQpCHYMmW
         O0HQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rFChyIoYz4zNI+S9EylnU4RcpCAmOpI4MYSN0nBcdzra6CnqDZpYqwxUtKvfXOI9biBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu0LPCvONH9AVo1CF2wbHlYFxPisp2m6d4qrvGiL2Q40mxrYOR
	ANQeN5h0HcgTcCCLsVaQ4/NzaI8q5pDKQ9Ne7f5tHU/k9jI+ztTPg1t8L6ARLwCjHFZwgZhrr2P
	vWkAD3g==
X-Received: from pgjq12.prod.google.com ([2002:a63:e94c:0:b0:c82:2d14:39c8])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:600f:b0:35d:5d40:6d79
 with SMTP id adf61e73a8af0-3b329152a47mr703134637.12.1779405456963; Thu, 21
 May 2026 16:17:36 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:57 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=2770;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=svONZOzYgvB9uLNw7Dd3f+OSjFLXcc689lDb5h7CPLY=; b=NDG/VNPc1LnSu8n/1kL7ViTe0ceOo5Dm6jNO1YYWzgar9WZierYah2T9zWdcmfQa5Gl+NCdoj
 6A/yqBz+EybAB51kiI5NezZ09lf6fMQ49/zfGREJnBtYM1EkZ056LCW
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-16-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 16/22] KVM: selftests: Load per-vCPU guest stack in TDX
 boot parameters
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

Allocate a guest stack for each vCPU and record the GVA in the TDX boot
parameters region to allow proper vCPU initialization.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c        |  2 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 4d01f806b37d..644de6bbec17 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -67,5 +67,6 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
+void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 757da2295ba0..ba332f279f03 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -847,6 +847,8 @@ static void tdx_vcpu_init(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_init_cpuid(vcpu, cpuid);
 	free(cpuid);
 	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+
+	tdx_vcpu_load_boot_parameters(vm, vcpu);
 }
 
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index b16bf24f3ef1..f26d602501b8 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -107,6 +107,17 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
 	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
 }
 
+void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+
+	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
+}
+
+
 static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	struct kvm_tdx_capabilities *tdx_cap = NULL;

-- 
2.54.0.746.g67dd491aae-goog

