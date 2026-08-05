Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54404334D3;
	Wed,  5 Aug 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927838; cv=none; b=tL5OJRiwON3ps9XW90nTWqAmhB996hQ8CHMkd3bn4pktVrDBQ3QVJWeYPHe4LY0erDgkAyBg1/a+//kWnTXh//exczPSoQXhs9I8+8jyjtRWwYlTtdU4lo4nrPlMx5k6VEG5g7/yRKi0K4LMTNLPLWAw0crsesACbSp7vY+ct5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927838; c=relaxed/simple;
	bh=cWUXBZZ/0t1QBYaf1rn4JIUxtpfPjOf2Zk+P9DLSsb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szfOHU46VEBz1XmLVJSRME5TQbCd22Auck0aKzaLsTI+jYAy7DYV4HSWFJxgyCgPmN3+OYTpcXxwQfe8R6mO59lw14zcaAWnJXJMkf6RLFT3KekiebCY10qpgSzDVobxwmyttj7C3kMG9/WDxIflYAPLIzwQZgf9QBiHE4KehmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J1Dmf0S5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J1Dmf0S5"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id CDE8F20B716C;
	Wed,  5 Aug 2026 04:03:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDE8F20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927815;
	bh=ggyXrQg2nON7P/s3Q3W09ZXdgsDVh5eVj4ANYdmwBr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1Dmf0S55BuZZ4flbJsRtWWCiK/ZCX7sqLRBrHtxMaU0WkJxc1w0Xxz3zFeX/NfRq
	 Y4WARdfwCfLwjo8Skuh5x/Wn9x+EEoAOrar8akVDV99rSKDVYbrFCeGNnHSpLxhdi9
	 9kagAwn3vp1ktKfgZBQ6sUnlOVzOvvrq+fdVXTgw=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 15/42] KVM: x86: Add KVM_HC_VBS_VTL_CALL hypercall for VBS inter-plane calls
Date: Wed,  5 Aug 2026 04:02:57 -0700
Message-ID: <20260805110324.25067-16-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define KVM_HC_VBS_VTL_CALL (hypercall 15) in the UAPI header and wire
it into the KVM x86 hypercall exit path so it reaches QEMU userspace.

This hypercall is used by the plane-0 guest VBS subsystem to issue
synchronous calls to the plane-1 secure kernel via a shared calling-area
(CAA) page, following the same pattern as KVM_HC_VM_PLANES_CONFIG/
ACTIVATE.

Changes:
- include/uapi/linux/kvm_para.h: Define KVM_HC_VBS_VTL_CALL = 15
- arch/x86/kvm/x86.c: Add to KVM_EXIT_HYPERCALL_VALID_MASK and to the
  userspace-exit case in ____kvm_emulate_hypercall()
- security/vbs/kvm_planes.c: Remove local #define of KVM_HC_VBS_VTL_CALL,
  add #include <linux/kvm_para.h> to pick up the UAPI definition
---
 arch/x86/kvm/x86.c            | 6 ++++--
 include/uapi/linux/kvm_para.h | 1 +
 security/vbs/kvm_planes.c     | 8 +-------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b7256f155bea..4b99016fe536 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -121,7 +121,8 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 
 #define KVM_EXIT_HYPERCALL_VALID_MASK (BIT(KVM_HC_MAP_GPA_RANGE) | \
 					 BIT(KVM_HC_VM_PLANES_CONFIG) | \
-					 BIT(KVM_HC_VM_PLANES_ACTIVATE))
+					 BIT(KVM_HC_VM_PLANES_ACTIVATE) | \
+					 BIT(KVM_HC_VBS_VTL_CALL))
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
@@ -10533,7 +10534,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		return 0;
 	}
 	case KVM_HC_VM_PLANES_CONFIG:
-	case KVM_HC_VM_PLANES_ACTIVATE: {
+	case KVM_HC_VM_PLANES_ACTIVATE:
+	case KVM_HC_VBS_VTL_CALL: {
 		ret = -KVM_ENOSYS;
 		if (!user_exit_on_hypercall(vcpu->kvm, nr))
 			break;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 1b097f7ed937..1703238952fb 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -32,6 +32,7 @@
 #define KVM_HC_MAP_GPA_RANGE		12
 #define KVM_HC_VM_PLANES_CONFIG		13
 #define KVM_HC_VM_PLANES_ACTIVATE	14
+#define KVM_HC_VBS_VTL_CALL		15
 
 /*
  * hypercalls use architecture specific
diff --git a/security/vbs/kvm_planes.c b/security/vbs/kvm_planes.c
index 3eec3abb56ee..07a004712e9f 100644
--- a/security/vbs/kvm_planes.c
+++ b/security/vbs/kvm_planes.c
@@ -22,15 +22,9 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/kvm_para.h>
 #include <asm/kvm_para.h>
 
-/* ── hypercall numbers for VBS VTL calls (plane-0 → plane-1) ──────────── */
-/*
- * These extend the existing KVM_HC_* numbering.  The host (KVM + QEMU)
- * intercepts them and routes them to the secure-kernel plane.
- */
-#define KVM_HC_VBS_VTL_CALL		15
-
 /* ── shared-memory calling area (modelled after the SVSM CAA) ─────── */
 
 /*
-- 
2.55.0

