Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5E53B328
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883546; cv=none; b=epQ0bxLi8KKbc6aw3k3QBlMyfx7HyCqNMO6hMr9uwhbtmGcODe5zItrek4Vr5B0dL6nM9m2E4NlJEvpPy/iOcqEjFKOMIur4/wcR0UnBev03XnNjh11ZdPLnTtRIEzB5XXIk6AHlgnOWZOoLTmBVPeachmyzS9GdB7r9TBkfIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883546; c=relaxed/simple;
	bh=6/G8XOzXqcANkVLz4qIxDCJ+3yExyENjEYd5u2PiG0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7p46Pfo4EYZDOsrZmGXGBiyJxzSjiBxAsCc6NxbrGQVR0uYY9zszPaZ3nzqsilncZEs2BsYzJ+eiDXvlPKcjdC+gafz3196+ncnyPu4wxXVgMjbjXxbGjYXf97yu/J9HSz5v6cwfpd/87p8/6uRiu+nTFH3bOY+Bc+dD3ebHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=up5Ak9dc; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="up5Ak9dc"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so12095061a91.2
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883541; x=1791488341; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ua8tU2uXWDcJJvbxGqdIItetaC1EcMoKaALryYwrxc=;
        b=up5Ak9dcsiSYev4MF0sIoKsyQC0HF2xU5P9RUxIy8ycXOGwGKKeMe38e/m6hzfCyBi
         QpvyWfKDfT06ox4rF0U4qbckTd1s2HkzoJWttL9PAXNzIasHTajbaAfEZA7O2JKOkk0y
         tIrtlaeew+rQj5Gb86OaEVl8HqgPeMExTCBr3ZnjX8OgOqjnoRecxHp5mweyPhFgeUel
         Ns9kzgoa1oP+rV/ShMug++VWAeSp0bkrJqcoPphjZabi4uLsiw1wsxdbhAtOl2L8Fuuf
         tcTSHpMcLNqittIrb/3JiGU/49COBD0Kyhqq/rTxwmmhhRy8/1nx++Nu007aOifr1yxI
         HXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883541; x=1791488341;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ua8tU2uXWDcJJvbxGqdIItetaC1EcMoKaALryYwrxc=;
        b=XxburskeM56fe9hnYkIBlpSFA5XOcwPXNCSuHK2/FouB41FKit4vvIgG9H5kQkmSYW
         oetylHMYxzRLNLdyzivTfzvWyN5qk0CrH7PZlRBlro6gRbSvyn6mxZiMKvEcPF0TRAmM
         znU6l2BNW3t6NWp2P12SGZmpXs/hUmTmPQPHdKlJnEUD4xDrTtx0D0yO/rXOWgzjE4Jo
         fDT6GxPFhdIrmBr+4hzoYuhdgyzcT7dsV3j5xi1vobH2zjCWekehF0pnabyZDOKDV9bk
         Or/883OVcv+vKyC/HsfYvzbq/8Yyt//QbD+/56AtXquKB77zgcoZ5mkHbjk0Q4bSraUM
         nUbA==
X-Forwarded-Encrypted: i=1; AKwUvBz71M4B67NreubHqHi1sglAE50ueQuWUUee1GHDfmmcQmwu1IonsRtgtF4oQU/MMitlIZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo+ea1/YukG1QSs/StRJ+GH7RgEJXOVB9DJkBmNGBMfOJa9T7q
	zuCgU9JTATyTHLllw4DILYl1uhwP0Q6OQXi1z3w4U4Qcp1kSTsw24TsvSBFSl8iUsuYyqohmhEe
	ghqpu7A==
X-Received: from pjps3.prod.google.com ([2002:a17:90a:a103:b0:3a0:e112:7ce0])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8b:b0:3a0:d82b:2390
 with SMTP id 98e67ed59e1d1-3a6cecfe7f7mr498796a91.46.1790883540606; Thu, 01
 Oct 2026 12:39:00 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:48 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=2651;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=Pns2Ik0aLmzPL3HWlqfh0hW7xhXQIK/Nnf6snCP/pbM=; b=tDOV13jr3yq7FK6cFemC9g4TUxsjq1VIRNHSlotPMUIQYyH/P2dXtT/tlbEUQKMGyNTDBkI+H
 Q2X3XTJHhXDDp6ASw/rLshmbffH3Q9nriKd6tDi/oU/J80He3qQ0pjH
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-21-7c62a5d8a992@google.com>
Subject: [PATCH v15 21/23] KVM: selftests: Add support for per-VM ucall ops on x86
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

From: Sean Christopherson <seanjc@google.com>

Add a layer of indirection to x86's ucall infrastructure to allow wiring up
a different set of {do,get}_ucall() operations for TDX VMs.  TDX can't use
port I/O (at least, not robustly), as the TDX ABI doesn't allow the guest
to share arbitrary register state with the host on a PIO exit, and the PIO
data payload is limited to 4 bytes, i.e. would potentially truncate the
address of the per-ucall structure.

No functional change intended, as the ops are still hardwired to the common
x86 ucall functions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/include/x86/ucall.h |  6 +-----
 tools/testing/selftests/kvm/lib/x86/ucall.c     | 27 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/ucall.h b/tools/testing/selftests/kvm/include/x86/ucall.h
index 0e4950041e3e..3639f03a4da9 100644
--- a/tools/testing/selftests/kvm/include/x86/ucall.h
+++ b/tools/testing/selftests/kvm/include/x86/ucall.h
@@ -2,12 +2,8 @@
 #ifndef SELFTEST_KVM_UCALL_H
 #define SELFTEST_KVM_UCALL_H
 
-#include "kvm_util.h"
+#include "linux/kvm.h"
 
 #define UCALL_EXIT_REASON       KVM_EXIT_IO
 
-static inline void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
-{
-}
-
 #endif
diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
index 38050c60a067..c003df3c7b8a 100644
--- a/tools/testing/selftests/kvm/lib/x86/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
@@ -8,13 +8,13 @@
 
 #define UCALL_PIO_PORT ((u16)0x1000)
 
-void ucall_arch_do_ucall(gva_t uc)
+static void ucall_x86_do_ucall(gva_t uc)
 {
 	asm volatile("in %[port], %%al"
 		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax", "memory");
 }
 
-void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+static void *ucall_x86_get_ucall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 
@@ -26,3 +26,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
 	}
 	return NULL;
 }
+
+static struct {
+	void (*do_ucall)(gva_t uc);
+	void *(*get_ucall)(struct kvm_vcpu *vcpu);
+} ucall_x86_ops = {
+	.do_ucall = ucall_x86_do_ucall,
+	.get_ucall = ucall_x86_get_ucall,
+};
+
+void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
+{
+	sync_global_to_guest(vm, ucall_x86_ops);
+}
+
+void ucall_arch_do_ucall(gva_t uc)
+{
+	return ucall_x86_ops.do_ucall(uc);
+}
+
+void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
+{
+	return ucall_x86_ops.get_ucall(vcpu);
+}

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

