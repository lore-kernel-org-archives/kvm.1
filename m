Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25546DFE1
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762074; cv=none; b=tyOkXKp/OZxJrSa487N28sz/rHV51JGCQb9URuu8VYh5+AVpyf4VBilYkCScHDwLiGkJL08SIs8lTRBImT7u9ixhS87YeSXV7YG+V67/tZRuwZWEcQcdJxBgKkkoJkdOb+TqSiaRPSkqWIM0xGeqULoCTbXKaqEkPM21rgc/dMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762074; c=relaxed/simple;
	bh=RSswLO4sPBgFvowrW2cB2ZwYWDNA3GkGtc6qyyhOGRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZSX8fVZDAK79o/zav+8Lz4jZyWneIGVHjMxVSdy0by4bdG4QGHT3d6htQYxKwIUyHZoyxqMTiIFM6nihu+VzVSdXAjgHXXdxqvJsU0lWz7SWcKhKd9mjczIdseH3nef5PlZzlkqvKrwOO1cmTxYQfkEiN80bb0YoqvrfenqsEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksZ3rwdD; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksZ3rwdD"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so69624a12.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762072; x=1785366872; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwqV7gcRQG0nFUaQrTilJBRN8gkgEZ+YbIjfOqZXofI=;
        b=ksZ3rwdD+A6r1aVl+jEKuJx0zTs/E161KCsJwGNDnsKpAXJOmTwjnaL8bKoRLb3a0q
         UIAkgO7QPZyYkOW7ADEW8QTRgPlOC49X1InS4F7y2HWA7Rrf1fVy09KqvtcbJQBjqnrI
         Ub3Rlw4Jy6OiTvyLuVT/AAqM2dC8hyzHfMutGAHtgcT6Qo0epJj7x3NiVTKywdFJ2wKX
         Y32lIMnkBKcWpBoPmxlAs3hLUsDUB/tVutz1vvyRn+EmFn5pMeyGkLVl+e/2SyPWJ8CS
         kxyYh1FnESz3RBHnyAK6jDfQ/rUCC+Yr6SSkS4CLP1rk+E9YwsI+m6Evkt4x0Pk75Zgh
         8t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762072; x=1785366872;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lwqV7gcRQG0nFUaQrTilJBRN8gkgEZ+YbIjfOqZXofI=;
        b=jxaTlnSxJypMdWC3Kiw5oRyFGqB65vYjZJl2a7pGPrnplAwh3VGMLJiDwuTp+ZvuVs
         d2SLSMA8UTZJqbZbKgP0Jj2SuE+b50XlP7dcbT8soECwZfRki3t1RaWp8V0FKGQ3EJHE
         6l6kRJQ8k4BRRJBpIyb01jQDaF7zoKUlmNTExl6zQZLwB1Tu94/vOAAgfK0k/2oxbWr4
         9ewjVGT10iuYMCk8XIUJ+iI9MGkp5NkN7LDEK7v0Q56TbQR09J6km+KdH0iWAK78zt8Z
         kNP4TMXnCDJQg3LDj/xAGpbGQPGbMSnkc2R2bbC2ZnDpl2ABBd3Vurg/ePsoYdpxbgH5
         ECVw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2wznaizw7FL8xEoKobBdYSO/daIGR8ztStoqeHxyztWe9KIi6/IvJUsFBKDLYmZmNWRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVu149O9gUrS6JKtHcjldHvQQaPYNxA2Q9WXrlFzrRAzVm7l9
	XeHf4Ar9W86GOpeGnBa0uYn+tRH3WUbEUdojO+dXdqpxnGJBFkQUc4EK7LVMjRU21OID36wlCqT
	ZRoUQcg==
X-Received: from pgr15.prod.google.com ([2002:a63:114f:0:b0:c96:4c5b:dcb8])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a0:b0:3b5:4fff:fa0f
 with SMTP id adf61e73a8af0-3c44afb58dbmr533802637.14.1784762071639; Wed, 22
 Jul 2026 16:14:31 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:19 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=3023;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=rHXAM3z5iBMuIUFttYkcIVu3B5Hjw4iTtMgyHIwbXEU=; b=620Ll51aNeaTFs40pgGcJMM6v44aJCfl+IG/XbXAFX+HpW8LoMl5/r7FljDHnt5RWx9ADE6zE
 Pxy7Ld/XSGrD5r0tZuuzzywD4RXSEEQkLna8RP4etzM0nq25p37vQud
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-14-15ad654a50db@google.com>
Subject: [PATCH v14 14/22] KVM: selftests: Expose function to allocate vCPU stack
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

Introduce kvm_allocate_vcpu_stack() to allocate a vCPU's stack
in preparation for TDX to allocate a vCPU's stack and initialize
its stack pointer.

TDX VMs' registers are protected state and cannot be initialized
using the KVM_SET_REGS ioctl() that is used for normal VMs. A TDX
vCPU's stack address will be a property of the TDX specific boot code
that initializes the vCPUs' stack pointers at boot.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h |  2 ++
 tools/testing/selftests/kvm/lib/x86/processor.c     | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7e00c9414595..ff3219edab44 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1144,6 +1144,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
 }
 
+gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
+
 u64 vcpu_get_msr(struct kvm_vcpu *vcpu, u64 msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, u64 msr_index, u64 msr_value);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 748c6041f8bf..8f8bb90fec35 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -813,12 +813,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	vcpu_regs_set(vcpu, &regs);
 }
 
-struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 {
-	struct kvm_mp_state mp_state;
-	struct kvm_regs regs;
 	gva_t stack_gva;
-	struct kvm_vcpu *vcpu;
 
 	stack_gva = __vm_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
 			       DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
@@ -838,6 +835,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 		    "__vm_alloc() did not provide a page-aligned address");
 	stack_gva -= 8;
 
+	return stack_gva;
+}
+
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+{
+	struct kvm_mp_state mp_state;
+	struct kvm_vcpu *vcpu;
+	struct kvm_regs regs;
+
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_init_sregs(vm, vcpu);
@@ -846,7 +852,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_gva;
+	regs.rsp = kvm_allocate_vcpu_stack(vm);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */

-- 
2.55.0.229.g6434b31f56-goog

