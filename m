Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBD531608
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883532; cv=none; b=PgWB8WUrHsH/tywh48rzgJAn8lr/gvkXf7VQj/bcKxSac9APluyh54V6KziFfe+n7/bzE/iFOykFgQ8N/+F+4ZNwO5x/c7SiD8WYsLynQxKRefrHI7HUBp7uz8JTPpXjy/rfeunQgwVAhEeiT7W8UHCYF8YnnwgL8cOfu+HVWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883532; c=relaxed/simple;
	bh=7l4Q+rDowHfpli+CXiLobxkRfzj0K0AnSNqvgkTEDRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lqX+y3BtlafVEL6J8RGtwpmJOJ1RkWhPaIgLjyyF/fAHciR53YfXeuV/1tR6EB8Nzlw2u6ymfTutaa6C/PUw4QydE6iQ+LsbOqRzlUwQvaHcxnjteFFo0Al0kjy++USq2QaXQFzyWewVeXA3xlYpsMyrn9dbBa+HF7nGgsAYs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbJnGvBO; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbJnGvBO"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f80c76e6so59494085ad.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883529; x=1791488329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yaiP3zKcJOVKeubnF5b9VUytsKLxmEjlQwuwQfnGsys=;
        b=HbJnGvBOou/eD8gYuBAr1RGOmqwHk5oqXD9N7WbJtgtsVJLzom38/jB8zZj9k2VfWd
         e+KXy8k3mMSInnZCAin/oFPe5WhfTtPUn9hQT5ZCub3KwwxmsrljBOgt95JEFlo4MUeo
         TMyuQ+PzUN/Q/4JeDFctVTlfLBwoirjksak+avluIbCxJEJRey36Ftrw1gTF0E3B3+cX
         pLY8x65KY4vD10nyXQLlsJFcmtvgpZFx0yRpyJIX01s0O61C3epRF965coKC9NNNY+aR
         CKdoO813oE5tmV3IoAVEaOxIKXgyUSfItPQgSyDTAcJoKRDHp2eAkniveLvCXMK3DX/p
         JAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883529; x=1791488329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yaiP3zKcJOVKeubnF5b9VUytsKLxmEjlQwuwQfnGsys=;
        b=DgqN7yLAItMJnN/49oZeRa6noaf5iRyGS0bSkfMGZUeEnwBkt8okaguI/AB+zCZChk
         pOZWykceINeVG9ttKUHJLom0innSgSSVuE2d73uoYROU/OPK5YqXJ/nhp0pI2lPGR68i
         6brO79mQ0kr/BOd8N9wi1UF/NZA/0KamTb+CL2TAF45r/vC7rvY7rE4r1K6V8GO2loQu
         FhWOnMGaPK/jPnKFTRHADYMwmODbGLPVewA3mZKMCnx1qjjn2SkfdBjJlUWs0aXneRYW
         ccYjO1rIAlB7K9EGmP3DRnKn7pIBLo8ysBqUDpXgMtxKXBp8+JakHWqt2MDm6mJsZrA6
         mlKw==
X-Forwarded-Encrypted: i=1; AKwUvBxSiqcHr3HTGt+GxdkGeoBaBS+odzXczix/pxGR85fhf+CzdXiWikQwoMm97Vq8lycMAJ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYITk5qdfQnRG8FVaMhT/9m2F4ThUjDimMQ2PzM11wQIiURzPGZp
	phuRpJzGUJZXjlZQZeLmVssKjzbXFMG2m/N7lH4T6VVdPONzr2fDOjsJ4r9JBd+3NrN1zLW3k2T
	rQfke9A==
X-Received: from pldv18.prod.google.com ([2002:a17:902:ca92:b0:2e1:32ec:8412])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bc8:b0:2dd:c053:e662
 with SMTP id d9443c01a7336-2e49b6a4af2mr4352805ad.40.1790883529087; Thu, 01
 Oct 2026 12:38:49 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:35 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=3448;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=5WwoSOJ4B7PQoIbZABgnDJo9uu2Dxyr72z45Xa0sFQ8=; b=zeie09mBOMiEchj6pJHrL1dy0T3WB7Fi6Efxx9MJGcW5MPoN6WOCr7uRhw1o39LtrMJpxVmmC
 nqHIEOrabJbAucKdlBVNet7QXEzqn+zcOJtOU1Y0B4R8P6rroWfrgw5
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-8-7c62a5d8a992@google.com>
Subject: [PATCH v15 08/23] KVM: selftests: Expose functions to get default
 sregs values
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
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

TDX can't set sregs values directly using KVM_SET_SREGS. Expose the
default values of certain sregs used by TDX VMs so they can be set
manually.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 .../testing/selftests/kvm/include/x86/processor.h  | 35 ++++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 20 ++++---------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 08b7b194f213..8854ee052d29 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -30,6 +30,10 @@ extern struct kvm_mmu guest_mmu;
 #define MAX_NR_CPUID_ENTRIES 100
 #endif
 
+#ifndef NUM_INTERRUPTS
+#define NUM_INTERRUPTS 256
+#endif
+
 #define NONCANONICAL 0xaaaaaaaaaaaaaaaaull
 
 /* Forced emulation prefix, used to invoke the emulator unconditionally. */
@@ -1651,4 +1655,35 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa);
 
 bool sys_clocksource_is_based_on_tsc(void);
 
+static inline u16 kvm_get_default_idt_limit(void)
+{
+	return NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+}
+
+static inline u16 kvm_get_default_gdt_limit(void)
+{
+	return getpagesize() - 1;
+}
+
+static inline u64 kvm_get_default_cr0(void)
+{
+	return X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+}
+
+static inline u64 kvm_get_default_cr4(int pgtable_levels)
+{
+	u64 cr4 = X86_CR4_PAE | X86_CR4_OSFXSR;
+
+	if (kvm_cpu_has(X86_FEATURE_XSAVE))
+		cr4 |= X86_CR4_OSXSAVE;
+	if (pgtable_levels == 5)
+		cr4 |= X86_CR4_LA57;
+	return cr4;
+}
+
+static inline u64 kvm_get_default_efer(void)
+{
+	return EFER_LME | EFER_LMA | EFER_NX;
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 1944eb2489d8..0c3779e7c275 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -15,10 +15,6 @@
 #include "tdx/tdx_util.h"
 #include "vmx.h"
 
-#ifndef NUM_INTERRUPTS
-#define NUM_INTERRUPTS 256
-#endif
-
 gva_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;
@@ -650,17 +646,13 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_sregs_get(vcpu, &sregs);
 
 	sregs.idt.base = vm->arch.idt;
-	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
+	sregs.idt.limit = kvm_get_default_idt_limit();
 	sregs.gdt.base = vm->arch.gdt;
-	sregs.gdt.limit = getpagesize() - 1;
-
-	sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-	if (kvm_cpu_has(X86_FEATURE_XSAVE))
-		sregs.cr4 |= X86_CR4_OSXSAVE;
-	if (vm->mmu.pgtable_levels == 5)
-		sregs.cr4 |= X86_CR4_LA57;
-	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
+	sregs.gdt.limit = kvm_get_default_gdt_limit();
+
+	sregs.cr0 = kvm_get_default_cr0();
+	sregs.cr4 |= kvm_get_default_cr4(vm->mmu.pgtable_levels);
+	sregs.efer |= kvm_get_default_efer();
 
 	kvm_seg_set_unusable(&sregs.ldt);
 	kvm_seg_set_kernel_code_64bit(&sregs.cs);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

