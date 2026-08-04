Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA33E49F4
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832030; cv=none; b=VuBMnx3MYo9X0Lr3YlrUxP75MMVGr0Q0Pq+lDmAuaB6hOSU4rXlToCxQJ4OF/TOooAsGMAh3RF+TBTUBCH2DTgKsrU1xjTAj5Ld29XYThPk8xJu64yiPznw0am5kNJ/AJA3Bk4JzyTYHiU/4+CXV/w9f8idhT+DfKeEV2Usp1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832030; c=relaxed/simple;
	bh=oT6MK+nFqRDDT6381MyCKbz3RNZwGiyYyYgu0C2Gb5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/vwym+Y1pKfIfb6GxqeefMxXn3e1SLWiviQ5Tr5CJDlOXYE8shWH16042OXzyNXcwP4uK44+MWPKszpR3bIOLXLpWkXvEFcPyTAdXIyq9yxHU6ITneYzY3UNr8HQS8zf2UUeXHhO+QS0j8DIP+1RnbAL5hZgWrePghY0MFBWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vjeAR/pl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vjeAR/pl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785832014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nVmasiSGPkk+x1jneoko6hUi583kHYVUUu//LQCwxW8=;
	b=vjeAR/plqnY7VIMQjOpoh4d5HW8l20DJwINTiYehlOVy7ReNk1IK5PpB0cbRj25pYohZt2
	uAoNAUVxyob/KghhCtXaTx89UzltsCUS6wqOIR26OBYhHs8XfHA5UTFWVIWnVPpHxwe366
	3ZoEk4UB6s6Dhyj1fk1iahuuj1/AN2A=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev
Subject: [PATCH] LoongArch: KVM: Advertise already-supported capabilities
Date: Tue,  4 Aug 2026 16:26:04 +0800
Message-ID: <20260804082604.178092-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Several LoongArch KVM features are fully implemented but were never
reported through their standard KVM_CHECK_EXTENSION probes, so userspace
cannot discover them and either ignores them or takes a slower path.
Advertise the ones that already work:

  - KVM_CAP_STEAL_TIME: steal time is fully implemented (host-side
    record plus guest paravirt), gated on kvm_pvtime_supported().

  - KVM_CAP_IRQFD_RESAMPLE: the resampler is generic code backed by the
    in-kernel irqchip; advertise it so userspace can use irqfd with
    resample for level-triggered interrupts.

  - KVM_CAP_VM_GPA_BITS: the guest physical address width is already
    computed as BIT(cpu_vabits), so return cpu_vabits directly.

  - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
    implemented (CPUCFG, PVTIME control); advertise the discovery cap.

This adds no new functionality; it only makes existing features
discoverable via the standard probe.

Signed-off-by: Tao Cui <cui.tao@linux.dev>
---
 arch/loongarch/kvm/vm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..d7dd08d9be5b 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -120,8 +120,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_READONLY_MEM:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_IOEVENTFD:
+	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_SET_GUEST_DEBUG:
+	case KVM_CAP_VCPU_ATTRIBUTES:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -136,6 +138,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
 		break;
+	case KVM_CAP_STEAL_TIME:
+		r = kvm_pvtime_supported();
+		break;
+	case KVM_CAP_VM_GPA_BITS:
+		r = cpu_vabits;
+		break;
 	default:
 		r = 0;
 		break;
