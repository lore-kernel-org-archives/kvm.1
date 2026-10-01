Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42D51DB1D
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883541; cv=none; b=XBVrnL+GP1kVX5pqCRY4utgIEGinn7ooe4YSJzUX/yVf6jRv3Cl4JxFB3wtvUIKpUZhItcZpha2RVu0nafGYgG4/+/Vd385Vt+SiCorYMJiaZpFLDtGhj04DvNNwTwW7USR0j/XBHrq0K4CsXFHNU+f2GdPryEnmss6sMcFaUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883541; c=relaxed/simple;
	bh=KvNwxbyCNTfqcwvIEbMM/Vd9BRr9IMnSFsJD1t/9KfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cH4fT2E8VWVNggdb/XI3M4rPIhxlC8UuFudhIQ25NczWx7uQn5a9m1ZxZ4rRJRJ8BKhOMXJYpOlUNURQCIy7NHKoc45BCA6t5Rew11KPNUfnLmOEnQs1DnX/wBHG6kutYRcJi+3GghmDsXNZw00lCeebLDhL3W1nP12z1+28hoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjGuWMS4; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjGuWMS4"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so4870643a12.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883537; x=1791488337; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHBql5y8ETtJ8wyQH03C6EhJ/BrwkerEDfeUC6+NPDk=;
        b=PjGuWMS4CVdWPlWw/xjvvPKyfoNMSZYy1IO9+4tXdj/GCQmh9KarwVIvBxlgADF0wu
         3Q+fjM97lWkSzMd0I2sAo3iehFdZSFdTD6tQ0X9uW2/pp6hD77aD5zt0B0zEGfg0ZtT3
         +3De2GOTCWkIZTGyv1toCF82FU66xGisn15ylfPh/K3p07IMPWw0um4QvSkLGIfzg/ct
         N3uZmQjvdt1IuZMfTiqqd5z/WYumybn2LGQoTiTz5spdMR5NbBQ4QQUj3y0c/ZQt0g6u
         4IHDHom7+6owgQ4Lgzbejgc7cg1n8JABZ9xGvByR5dNOV5iJlH62/uwiHkqazpXw6KKT
         bZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883537; x=1791488337;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHBql5y8ETtJ8wyQH03C6EhJ/BrwkerEDfeUC6+NPDk=;
        b=IfIgXSuzD180aPDQkmzphf24bfPw7hJ2ZzJfsr2zVhuSk9luN3VKcGrz1fnDRpMW2e
         jC8cSw1LBDytC33Zim3LHhDE6IK+TQJNxRNoNd8d0N2X8w0yu2fxJxRYVbs8WZi9RTk8
         8CcBmiLDRl1KLDde6mrFvOgV9BF2NvrHNlNEQstsUaPdQJXwUZ83+kcIQCZjeOMDmaJ+
         0wY+LqJj0ERp1kZDhti5HYQfpafOjvhMA5IEHGm0Oz7305HQDyqRoRim5Qv8FkcNht+j
         0Z6mX32HaMJrqR5LTh8XiljgsBayKw9LbCDZKBYQtVTHwfV2DJYw/dwCDXzONS6uy60D
         yjKg==
X-Forwarded-Encrypted: i=1; AKwUvBzc6xxwHDLzicvOnF0YQ2JLT3A2ciMJw3FDyPiWSzhdVkdPhWd1L9CMWbh/ytyNlmzMV2g=@vger.kernel.org
X-Gm-Message-State: AFuF++mM/otvpMyXXMRZ0xwQXOpFWslkYQzN/Bo/TeRneimRjKNM8G1r
	M5hmRW2tHjjZ7q4+BgnZbnxXRbBHOrlwSC9bhTGiHTRIzjGX1d1IHglVhwJe9VPerTpU8WghanY
	UfV3fXw==
X-Received: from pgfu10.prod.google.com ([2002:a65:670a:0:b0:cc7:e738:5b23])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1f:b0:3da:f32e:b3bf
 with SMTP id adf61e73a8af0-3e0bcefb957mr383150637.17.1790883537092; Thu, 01
 Oct 2026 12:38:57 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:44 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=3134;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=b+1NLAF26hCfEEdCty3EECayK7690hjQ4YhxNbwDlbg=; b=MS9HJHZVdGDDilcJsyY8v/u6OfJ224odOxzaC3QZymCSH0+DAqznPbZ4ocCN5cuHxIyd7B7dI
 Rr90Joq91L/AeTEjzRVzNv0sH9LrFgilkkrxAx7wvnSqS2wUMJJT4GJ
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-17-7c62a5d8a992@google.com>
Subject: [PATCH v15 17/23] KVM: selftests: Set entry point for TDX guest code
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

Since the rip register is inaccessible for TDX VMs, we need a different
way to set the guest entry point for TDX VMs. This is done by writing
the guest code address to a predefined location in the guest memory and
loading it into rip as part of the TDX boot code.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c        | 10 +++++++---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 10 ++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 72497724a2ee..f36cddbd045c 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -71,5 +71,6 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
+void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 2d2160d68b9b..b4b76dc505ae 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -846,9 +846,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	struct kvm_regs regs;
 
-	vcpu_regs_get(vcpu, &regs);
-	regs.rip = (unsigned long) guest_code;
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vcpu->vm)) {
+		tdx_vcpu_set_entry_point(vcpu, guest_code);
+	} else {
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip = (unsigned long)guest_code;
+		vcpu_regs_set(vcpu, &regs);
+	}
 }
 
 gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 270a4ee1b7eb..5f10a7c1455d 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -102,6 +102,16 @@ void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 		    "ESP GVA must be within 32-bit address space for 32-bit boot code");
 }
 
+void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vcpu->vm, TD_BOOT_PARAMETERS_GPA);
+	struct td_per_vcpu_parameters *vcpu_params =
+		&params->per_vcpu[vcpu->id];
+
+	vcpu_params->guest_code = (u64)guest_code;
+}
+
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

