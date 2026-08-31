Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25F4968F6
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193702; cv=none; b=BOL8EKjckOcKSReh6BPLWnOjldPc4irUCOQXURqenH29lJPOpuSz/XGpxYpjRM+5uECVUXuXD6k9ik62HFvVG8vswlaOzlFQBR7aYaPw95gXwwHMEWCkh4OCuu64RjcxlkdO92Jv2J/i0y2sntms9y28rqofEpNGQp9BRQXvGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193702; c=relaxed/simple;
	bh=xIutThzYKRk+MmgmvnI6jxLg86YKS37TTQ0Ve9SNoQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVzdWuZcRIDE7N32zeBc0g7zi3AG7P9m+snfcGsNlAC8EXlODDpMnuQlkHlZbAD046SmRtGmqpOeu50NBFjGdmDy5x2NPFPNYve2wlNNkxKHiezTOwo4ZxAD8/cejuNCvmU6uBb89EXQ+PjxyCxQHSYmw9f6HdDfeI/IVB+eXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eZv0dstr; arc=none smtp.client-ip=91.218.175.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eZv0dstr"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xIutThzYKRk+MmgmvnI6jxLg86YKS37TTQ0Ve9SNoQs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788193696; v=1; x=1788798496;
 b=eZv0dstr7e0JcCExDFQuAwZ2D//Ch5dXmkdHho3oWMIg2+k3zQbQXxY/5knFWLVWncdhsvV9
 ICeBSeSXv41n0ISsMXvcSIbarMq4AURU2NALsg0Mq/AqWA2ZeYBPo2eNWOwkN8AQaaK7+fvhc10
 ybsbw5G3axM5XAZkvOG8bdVQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55f6d3df3ac0595f;
	Mon, 31 Aug 2026 16:28:16 +0000
X-Mizu-Trace-ID: 55f6d3df3ac0595f
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: arm64: Fix the KVM_ARM_PREFERRED_TARGET documentation
Date: Mon, 31 Aug 2026 17:28:15 +0100
Message-Id: <20260831162815.269851-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_ARM_PREFERRED_TARGET has never set a feature bit: the original arm64
implementation zeroed the bitmap, and kvm_vcpu_preferred_target(), which
only ever zeroed it, was removed by commit 5346f7e13e5e ("KVM: arm64:
Always return generic v8 as the preferred target"). The ENODEV error had
gone earlier still, with commit 08e873cb70f3 ("KVM: arm64: Change the
return type of kvm_vcpu_preferred_target()"). Document what it returns,
that userspace selects vCPU features itself, and drop the error.

No functional change intended.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/api.rst | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0430cc750c9e..193f3b0ec77d1 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3600,20 +3600,14 @@ Possible features:
 :Parameters: struct kvm_vcpu_init (out)
 :Returns: 0 on success; -1 on error
 
-Errors:
-
-  ======     ==========================================
-  ENODEV     no preferred target available for the host
-  ======     ==========================================
-
 This queries KVM for preferred CPU target type which can be emulated
 by KVM on underlying host.
 
-The ioctl returns struct kvm_vcpu_init instance containing information
-about preferred CPU target type and recommended features for it.  The
-kvm_vcpu_init->features bitmap returned will have feature bits set if
-the preferred target recommends setting these features, but this is
-not mandatory.
+The ioctl returns a struct kvm_vcpu_init instance containing the
+preferred CPU target type. The kvm_vcpu_init->features bitmap is
+returned empty: userspace selects the vCPU features itself, and their
+availability is reported by the capabilities listed under
+KVM_ARM_VCPU_INIT.
 
 The information returned by this ioctl can be used to prepare an instance
 of struct kvm_vcpu_init for KVM_ARM_VCPU_INIT ioctl which will result in

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.39.5

