Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82C45D5D8
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762076; cv=none; b=m5/tZKwy39BAAGIrnRGidmJgFe5sDlTbn8tIWW6PRa0HX/DZmcRVrj6hSfxO9fgxK+bsvj2+cIGZXmZmn5N8j82EjSWVMcXIFqzWTpDrFs61oYRafXU7lvT+r0XiWmfsihBRfeIM3qOK4OW0F0HWBCfrURJGgz6QMKy1WQNUn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762076; c=relaxed/simple;
	bh=wI5qPNx3qO7Pa3sc6McN5K8dBR/xnHmQ0Ews33+IkIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gb1S7zPjy9kVGJmwGrKeegKhq4VezKk/zA1EU+NwGH1H8u5uGpbPPLRsFKwxifyqZsrPoxYl/XhbypLE/qN/5STvb/Mf+hv2nl2eTNBdrOtUS5UgQmpL4+sxG846DKtTwFNfRQGi31vIbwMvePLKjZw79KD6kXO36AhekDBrDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5wMbhGm; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5wMbhGm"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7e86e7c5so777965ad.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762074; x=1785366874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZ5vfks9CA54LzjCooza2MQltMm+528uOQzkjWAogGs=;
        b=v5wMbhGmXs2/0N7ktQaWjKM+Dezi9qFeRXS4p2UHalZRqzPz4xw+4/z6320SmH4Fjg
         Ps4Q/5PDdZDqgxCXlKHPJypuHOm09hx4O0/qqoFLdTKy/8GZ9Cpu+JLX3JBmnR/WotzC
         BpmvpDi1lhgHLM9ISvhnHRgSbme3PZcGmv0V9+BWMiFhdYY901i9hrao0jEJj64kmnPG
         dez5fg8ueRc1zeTu/RqHHu8hNNecu2HK4E28+VIE+jWH2iiJQdhGjKLsv5If6fm9MDe9
         qV+iUeicNyrnO3rbQm7J10pVzGDjO/ZCZyHHzPaGgeHKz2qg+ffb6giPS1I6xahs+kBA
         nVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762074; x=1785366874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZ5vfks9CA54LzjCooza2MQltMm+528uOQzkjWAogGs=;
        b=p2uMkxykUBYktVxALqgmteg/Y1mqVkMinx9JbDOr7iEHPtU5Xzz+Ijq5qNzxidsH77
         Wt8WYLgrTNbMgN5uVfolvI8sxXw1dYN9MuuqKDeFjLEDZbJ44r9slI7DRzz2d7eJ1pv/
         4z5DP7x+S4tQTsQtuUrYBQjciV+hovifBtR3G/SXIVgJei6V+Yfpwkt6+IfLXd9inrSD
         11flagK74bCwRokQknMhZ3zEE8TQ0W+Esy6y28Rri5j2yWK4Ouf5W7jjyhgwwM2I//2u
         uSHKVSdzM6JoyBmrhrEqsMr2Drjl7qrFdnn65EJgGvclfPRt8mQdeuQV7rqPb8YW9e2N
         IZqw==
X-Forwarded-Encrypted: i=1; AHgh+RrJ41dr84ROffvZslXzDpWWQ153aXn8ks+bqF4Q14SrAkDLXiWA0XEF8CaGZTvqERAvfQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeGxJH43+A7OCyXrEnrTsQ6JHPzkA4Aqm3MKlL/ZIPiUITZDT
	F4PE1eMFqtmNL26rdcawRA//fv/+Y8x3/t9ssw5ABBujsTniWcKLVyyZU3mfcbeCNMb1kIRuIGn
	dBWTpZQ==
X-Received: from plca6.prod.google.com ([2002:a17:903:4686:b0:2cc:da2c:8084])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3806:b0:2cc:77f3:a927
 with SMTP id d9443c01a7336-2cfa6c5df36mr9033925ad.26.1784762073649; Wed, 22
 Jul 2026 16:14:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:21 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=2818;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=RCPDHzz3Momw9Jz6CWV7zruC6Eq0eGpKm4HWeSEZlV4=; b=XS2k1u22QABaJXBMqTzGiV+lo9tOPgOHujvv63hal4jsD2hzEPcFI8h8CpqNYG2H+rR3H7kYr
 l4HGH4aj1eVCCVON/9fqJ/XBd9H1vXzNNoi1bpcCeOxmdFamL9ax6m9
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-16-15ad654a50db@google.com>
Subject: [PATCH v14 16/22] KVM: selftests: Load per-vCPU guest stack in TDX
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
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c        |  2 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 07e7f5c90329..93ce6e1ad2c8 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -69,5 +69,6 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
+void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index f6a2aa6b86a4..5e415c6577b8 100644
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
index 5bbe51ad0f66..3c3ac6c7ce40 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -104,6 +104,16 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
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
 static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.55.0.229.g6434b31f56-goog

