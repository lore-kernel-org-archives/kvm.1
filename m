Received: from out-164.mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6F377AB4
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908788; cv=none; b=dp/5x99xKw6PVLj7nhCXRib2t1tPsroBNyy+QuPBkhgtHeJqnpXQs23MjayAzwJDfuVGS68goaz2NgmqbP57Pp9gzelVP79z3IFWxaLFAZePkFyy1jvehTwSA/lodxoV0CHkwN3VM0OorLViuFi2tE5nyxR8CAjlnFml7YjlEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908788; c=relaxed/simple;
	bh=vaKNIEBZelWchPfm7/fqoe6xrkAvsarEnLBxT9PUXqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1Y6+hhjODs4bafyPFRXFBSw5JboTjEsTMUt1y1yO9QCGjy9oqCVf7GOi6/kEvvwfhapkA/nMhxvC47Bzdl055lL6tWcQpdC8IGLf3jGlTFkHXyPC9ywb57jbps2vazVd6Z2Cf7xwZ9LN4YFj4r6WBStMxJw/X5Fk2IE3++gPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cOvtqnJw; arc=none smtp.client-ip=95.215.58.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cOvtqnJw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785908775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fv3F37YwyrErPSl69qBUjTJbxlH3Hl4dP6cRAtWROGc=;
	b=cOvtqnJwreftTXpZkJBunpLozlY39LVS5mpQcea6Rpl9q5DDlLWRW86MQ7KryvWtsXKeIb
	liGQTlkjSclGG2ezm7tl8FTqbpAHhveBZ08u6pJtM6RH0q18h18VuTAzNNj6gRLDQuNEyB
	q5+T46xi4ZUF8pzkTyfvWeOyIWus4Ek=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev
Subject: [PATCH v2] LoongArch: KVM: Advertise already-supported capabilities
Date: Wed,  5 Aug 2026 13:45:49 +0800
Message-ID: <20260805054549.287648-1-cui.tao@linux.dev>
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
cannot discover them.  Advertise the ones that already work and have a
real consumer:

  - KVM_CAP_STEAL_TIME: steal time works end-to-end (host-side record
    plus guest paravirt side), and the probe returns kvm_pvtime_supported().

  - KVM_CAP_VCPU_ATTRIBUTES: per-vCPU device-attribute ioctls are
    implemented (CPUCFG, PVTIME control); advertise the discovery cap.

This adds no new functionality; it only makes existing features
discoverable via the standard probe.

Signed-off-by: Tao Cui <cui.tao@linux.dev>
---
Changes in v2:
  - Drop KVM_CAP_IRQFD_RESAMPLE: the only consumer is VFIO INTx, which
    needs IOMMU/VFIO not yet available on LoongArch.
  - Drop KVM_CAP_VM_GPA_BITS: the cap implies a GPA-width setter that
    LoongArch does not implement.

 arch/loongarch/kvm/vm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..0a51931d6f6e 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -122,6 +122,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_SET_GUEST_DEBUG:
+	case KVM_CAP_VCPU_ATTRIBUTES:
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
@@ -136,6 +137,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
 		break;
+	case KVM_CAP_STEAL_TIME:
+		r = kvm_pvtime_supported();
+		break;
 	default:
 		r = 0;
 		break;
