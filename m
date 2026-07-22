Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14645D5D5
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762075; cv=none; b=ZB6uU7fQnkPKOSNh9a8Yum/I23HGncHc5xMvBiAaWWOEAcQSJNxL+UWggkOX3Szoh4609hrFmvi2ntP6UpEiVn4XdOG0ylFh4AgtPhLBBqsLUuPvM8l65Cnt03HKV116myUHpmvdeZNkZpb4RoGkkmy2nrwOATXw6Q/Lu0Rqw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762075; c=relaxed/simple;
	bh=85nJ9/hYOiJ96H11w7YE6HgvAK/atu2QWkFdBC4kTTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gsoDY9XMS0Q26ioi3xBEm/I9bzIua9HFexshPeElgeeaytZ/66NZz4YgzpIWwd41FRt5pTlXzs8UdOoXAeZP+heCyG849leXDd/1YIu0FXPo0ilet8s8mWtj6Eqb/mByZpPtu+oxoi99vXzn0wbHg0sLNxcEXD1TUQQS7HvBV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjEczBZ9; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjEczBZ9"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb6823efcso467435ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762073; x=1785366873; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZLWKI1tlBYiW8AamRHdf/1OfHZxF/vT4pGO9bOW1EQ=;
        b=MjEczBZ94B9AwOdRCvmj2KuKDSm2+KoGCEXzTR1J1NrS/prjtISmCL0hntwEhvOCk7
         WUELRsrerrY6vKe8Vm0IJPEDW7kPmPalvGdNL0/Cmh5Efa9mcSOT8aleo/PYi7wil0Wy
         Z2M4KdH4nECVIuwgEI1pVo3lNHRXhiMPn59MAX8rF3oEqX4OZCLuseD8+o7Ji93psPA2
         3fwl8gDs1cTSX+M8HGRYrXkX8iOeYrZIMSDsd0OgMThHjHcijoQR7h4BIS3JXDJ0qOco
         qFwOf8/BDm9slObChvcirIjFHzGJQxV3G/HZabVQkGrXy48bkB0Qz36OpNDAk1KbqHtk
         u8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762073; x=1785366873;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZLWKI1tlBYiW8AamRHdf/1OfHZxF/vT4pGO9bOW1EQ=;
        b=XMaXVPrOz5kpHgb5tPCFZx4b8196RinGjCsnrkDCmP2VsT6rPkzL6ixvuFx4SAB/eV
         oXj4c32NYEtfdK+p6f8iG8bcLNFudVZIGQYE+xDS/T0qzNZrPr5/5VlhmkQXfkcQsZth
         ZjSaMKiLg2AHn12N0r5gClaJsJFbERYF93HYCU5v9+5Q/L7gjX77cXByCPRgBhXUA2AO
         mB0KD0Y5Y/4BZv7v8ORU0R9xcQsj1pLrzaRLPBIRI91MK4tivIFuFpHDbhp2jCxd86mq
         nDRoJ0xsIXGDMNDi4cOCj4uEQCR+74LLDpu7NoqGEA511dUqNRFug98K3lEOXSq1ygV/
         kzPA==
X-Forwarded-Encrypted: i=1; AHgh+RrlPu2MHXdekiTtvq8Z4pmkC1/NV11MmRPB4gLZsq66nVvMUjRrw+FHgVY3JWj0hvNBlz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuMx4d2Z6P78Fm8TsUCa5raqQZILlGkoROa1dMuMzE5bbv3J7
	IxE+e7O0XPZicyALQWuU+Uq6CvXKPk72rEZUXyMuenq0LgDyLtd43mW366Bm/PyWCVI4Os7b8TG
	63LchsQ==
X-Received: from plbku3.prod.google.com ([2002:a17:903:2883:b0:2bf:8db:4516])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecd0:b0:2c6:9f6a:9f6f
 with SMTP id d9443c01a7336-2cfa6c66734mr9553835ad.28.1784762072595; Wed, 22
 Jul 2026 16:14:32 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:20 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=3521;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=xqpuRNldDHsQw4caqxUrdj/Q5OmHfnukgRI/kPmbKvA=; b=lro9gw6spAzyLdUzV3VuSRQIK+ZItJCg11HfLCf1lzHdMGraZlgSyxEOVHfijLoItxsnTtGLy
 nqcpK0M8FOyAze6f36y/Zonp0LYbMf4Ht+uI3WjVyWGfhWGCj7xCKum
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-15-15ad654a50db@google.com>
Subject: [PATCH v14 15/22] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
vcpu creation.

Since the cpuids for TD are managed by the TDX module, read the values
virtualized for the TD using KVM_TDX_GET_CPUID and set them in kvm using
KVM_SET_CPUID2 so that kvm has an accurate view of the VM cpuid values.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 21 ++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 33 ++++++++++++++++------
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index f5003cbaa106..07e7f5c90329 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -44,6 +44,27 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	}								\
 })
 
+#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
+({									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (u32)(_flags),					\
+		.data = (u64)(arg),					\
+	} };								\
+									\
+	__vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+})
+
+#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
+({									\
+	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
+	TEST_ASSERT(!ret, "%s failed, errno: %d (%s)",			\
+		     #cmd, errno, strerror(errno));			\
+})
+
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 8f8bb90fec35..f6a2aa6b86a4 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -838,6 +838,17 @@ gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 	return stack_gva;
 }
 
+static void tdx_vcpu_init(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
+	vcpu_init_cpuid(vcpu, cpuid);
+	free(cpuid);
+	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+}
+
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	struct kvm_mp_state mp_state;
@@ -845,15 +856,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	struct kvm_regs regs;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = kvm_allocate_vcpu_stack(vm);
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vm)) {
+		tdx_vcpu_init(vm, vcpu);
+	} else {
+		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags = regs.rflags | 0x2;
+		regs.rsp = kvm_allocate_vcpu_stack(vm);
+		vcpu_regs_set(vcpu, &regs);
+	}
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;

-- 
2.55.0.229.g6434b31f56-goog

