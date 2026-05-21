Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E7372ED5
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405460; cv=none; b=Yaikh1pSYjcdchNb5ArnKmgXslcK6E6/K64g79C3v65PYzWXYfOvqcvHM4aMSUsYHdOF4SGyBDUFJ67vqUuNoGSCTnUWFoMvlsRN5/X8Gyv75IGBMFN/gwd8k8qzN6MUK5zU6rGNJEZvvy/Uv72g8E4pPtrlcGIXF/WoOpAJn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405460; c=relaxed/simple;
	bh=DLAtbrHdvo5WvlVNUy3DYeBFnFMkg96Xemd+rnnf2bI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jFsglEA4DsQRQylDJCjX4Tw4XCjOOir42GB51tK3LgfVi1P5uengaE88/NEy5n0Rd1MsTcxewv4YqmPieAUuJLaEyUd/fHtgz7bZKs5rgh0g/+F2wagTWQGXlkzPjtsU/tjXX28lu4oKZweFbZlyK7QrvewMM9krzXdNMm8W5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlj9E6dM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlj9E6dM"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso119177715ad.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405458; x=1780010258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPS+sP3pre8chdLQaPvokk18FwKqoIxFKysij7DMlHI=;
        b=tlj9E6dMRJ64zAUsCjC0OrvL6s0rW+FkpXvtI9r4mSWZAPX4WGAgQNRREvZEv6/sdO
         yUIjc6SXs76ZoB3b7uCjNzK9n9P+TM4IhOUsjOwVY7ye50mX++Z9VD0pnf/gkbQDAHv8
         T4iQzqyI0nRMyzXKEf6+C/BMSwWoeCpgxlgQDCooAHQXN6OwGT3azqE7HYzvmvO1w7l7
         ebYocg7cZDk5RctkMk1hqCKRQ4QpmPtVNNidAWVC7FXFkE7AF0QyJBmmCYzHhzmsqnKd
         2694XshGytR91uY8Q7Aresa9+atz6/kJIhc1upuRJS8xY9LKJW+w9jPAM+yq6Ya8+cMo
         5FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405458; x=1780010258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPS+sP3pre8chdLQaPvokk18FwKqoIxFKysij7DMlHI=;
        b=BvjedzSR1h2SUyvrHUsKsN4MV6anYxNV38JEST07yNYy+BaYq31aGVbTRFbuyEF/n+
         dgfXgfPGHKFV6bW2LNkH3gJAxEPCgRbSTMGoGOOiXmM2Z6nBm58h1/8X2ERmZY4xnH0o
         dZU59sLiic3jv7Z0/TM+MfqixnZ/CySL7/A3c+5a9f0A+/iWK/2Ai36hu3WpwSiF510C
         qgczlHtmmz6E/eL/eHRd+AI47rdozvIXdY06U1s+rFBQN3vtgzm8bp1qoqpiOcBaYNxr
         0VMTSpjhK7KjMS0yTnmjbAYnSPDRllJLWa3F6gOYuX9X2yYMLlmlI2Gtu8nyBW2k9aVj
         sIBw==
X-Forwarded-Encrypted: i=1; AFNElJ/u6iaDcOI/k87T7qGouxN9cp3gu+OUAj/1QJBtfhXpt75/zmn03eU65gI+7OhowtCKE/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezGypJxhqHUy5RZdjK+0qnPEu5BU7017xVy2lDz3WoKD0JV8i
	fokT+NqvTyO01mrNYQexZHaGS6P0EFg8/tQkvmrO6+jtBJoZAVuMgEME71TVj20VkylMWBkUw32
	ljTjCjg==
X-Received: from plrp5.prod.google.com ([2002:a17:902:b085:b0:2ba:3f4e:3d6])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88e:b0:2ba:6ca2:bd9
 with SMTP id d9443c01a7336-2beb07032fbmr9695845ad.41.1779405457898; Thu, 21
 May 2026 16:17:37 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:58 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=2957;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=75vtIEAl1dKIldzNzTlPnRhKHFkQqQMkW79OfZa3kcE=; b=Q9VYAySvG+mi4HBliB0DA/6YC8JFcHSxCIIS/IW7G4YvLcnSpO9YfF7Nkrfxpw+8eXtveLYYt
 Ty96nYghLlbDAvi+eunlB5g1VbkmceAis3Utdu3yMheAU2vWAYRm+sk
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-17-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 17/22] KVM: selftests: Set entry point for TDX guest code
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

Since the rip register is inaccessible for TDX VMs, we need a different
way to set the guest entry point for TDX VMs. This is done by writing
the guest code address to a predefined location in the guest memory and
loading it into rip as part of the TDX boot code.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c        | 10 +++++++---
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c     | 10 ++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 644de6bbec17..efa4c7f7b1c1 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -68,5 +68,6 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
+void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ba332f279f03..d84c629a1945 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -808,9 +808,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
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
index f26d602501b8..158cba1b95e3 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -117,6 +117,16 @@ void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	vcpu_params->esp_gva = kvm_allocate_vcpu_stack(vm);
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
 
 static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {

-- 
2.54.0.746.g67dd491aae-goog

