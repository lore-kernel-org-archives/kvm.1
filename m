Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AB3F6C3A
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932080; cv=none; b=k7uAdDUsWR7LMXBsZ9nrZDbfZiyYz0olWK+J8MVCU+Am7yGkSjgHZiw20qLQOjYiOEICJ4RF/EftPr+PCLRtr/kWlKsc5g0G1mqo22b40kVexX95+tZhQWl13koyCeus16WbFJwV1wB+sLagQ4WtuYYTuVotiLEeZ5qyRtldGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932080; c=relaxed/simple;
	bh=6eiGhicYVzNPLypek389DI1BNTDiRpp/hhxkWJC9R94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQaKep+a4NYJFoGhlhTYOeSUChqNU5InjUHNFRtaCUk8Xatr02dX0Z5xI2QnvIexCno/El//ELOWqztZ/XjwZV0YVG1aki+beaX6cY+lpmdp0bpxpOsVQrS0Nxg14P+4y5EGJBB2ntslYKloFdKjVgVgPQQyPSUM6HatF7aM1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9BAFF202947;
	Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 06/10] accel/kvm: Handle KVM_PLANE_EVENT_CREATE_CPU event
Date: Mon,  8 Jun 2026 17:21:05 +0200
Message-ID: <20260608152109.356783-7-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Implement the plane event handling infrastructure and handle the
KVM_PLANE_EVENT_CREATE_CPU event.

Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c   | 13 +++++++---
 include/system/kvm.h  |  2 +-
 target/i386/kvm/kvm.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dbfef63a84b0..c5fe6d189e62 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -573,11 +573,17 @@ static void kvm_alloc_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
     cpu->kvm_plane_state[plane_id] = p;
 }
 
-void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
+void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id)
 {
-    int vcpu_fd = cpu_kvm_plane(cpu, 0)->kvm_fd;
-    int plane_fd = kvm_vm_plane_ioctl(cpu->kvm_state, plane_id, KVM_CREATE_VCPU, vcpu_fd);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    int plane_fd;
 
+    if (kvm_get_or_create_plane_fd(cpu->kvm_state, plane_id) < 0) {
+        fprintf(stderr, "Failed to create plane %d\n", plane_id);
+        abort();
+    }
+
+    plane_fd = kvm_vm_plane_ioctl(cpu->kvm_state, plane_id, KVM_CREATE_VCPU, x86_cpu->apic_id);
     if (plane_fd < 0) {
         fprintf(stderr, "Failed to create plane vcpu\n");
         abort();
@@ -586,7 +592,6 @@ void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd)
     kvm_alloc_vcpu_plane(cpu, plane_id, plane_fd);
 }
 
-
 /**
  * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
  * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 16597333cfa5..24a21915366f 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -221,7 +221,7 @@ int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
 int kvm_vm_plane_ioctl(KVMState *s, unsigned plane_id, unsigned long type, ...);
 
 int kvm_get_or_create_plane_fd(KVMState *s, unsigned id);
-void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane, int kvm_fd);
+void kvm_create_vcpu_plane(CPUState *cpu, unsigned plane);
 
 void kvm_flush_coalesced_mmio_buffer(void);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8c3..30fba9e75016 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6524,6 +6524,60 @@ static int kvm_handle_hypercall(X86CPU *cpu, struct kvm_run *run)
     return -EINVAL;
 }
 
+static CPUState *kvm_get_cpu_by_apicid(CPUState *cpu, unsigned apic_id)
+{
+    CPU_FOREACH(cpu) {
+        X86CPU *x86_cpu = X86_CPU(cpu);
+        if (x86_cpu->apic_id == apic_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+static void create_plane_vcpu_cb(CPUState *cs, run_on_cpu_data data)
+{
+    int plane = data.host_int;
+
+    kvm_create_vcpu_plane(cs, plane);
+}
+
+static int kvm_handle_plane_create_vcpu(CPUState *cpu, struct kvm_run *run)
+{
+    CPUState *target_cpu = NULL;
+    int plane = -EINVAL;
+
+    plane = run->plane_event.plane;
+    if (plane < 0) {
+        return plane;
+    }
+
+    target_cpu = kvm_get_cpu_by_apicid(cpu, run->plane_event.extra[0]);
+    if (target_cpu == NULL) {
+        return -EINVAL;
+    }
+
+    bql_lock();
+    run_on_cpu(target_cpu, create_plane_vcpu_cb, RUN_ON_CPU_HOST_INT(plane));
+    bql_unlock();
+
+    return 0;
+}
+
+static int kvm_handle_plane_event(CPUState *cpu, struct kvm_run *run)
+{
+    switch (run->plane_event.cause) {
+        case KVM_PLANE_EVENT_CREATE_VCPU:
+            return kvm_handle_plane_create_vcpu(cpu, run);
+        default:
+            fprintf(stderr, "KVM: unknown plane event %d\n", run->plane_event.cause);
+            break;
+    }
+
+    return -EINVAL;
+}
+
 #define VMX_INVALID_GUEST_STATE 0x80000021
 
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
@@ -6648,6 +6702,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             break;
         }
         ret = 0;
+	break;
+    case KVM_EXIT_PLANE_EVENT:
+        ret = kvm_handle_plane_event(cs, run);
         break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
-- 
2.53.0

