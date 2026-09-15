Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B44C8C49;
	Tue, 15 Sep 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488178; cv=none; b=aRzYSGCyoNlyc14ykTeMNC0Rb6nOrBhpo9ZpSn8lC7H6WPSxOINnwCibG3xNR8YB8WkD2lLU8ZiDlJq3gLEP1hj+SzRMGualQ84T0+S4MAg5c+eMeuBEokpQrUkPIsNAs9f+X95zyMB1j/gJKvsYxfANb4McYcwVVfNouQYFD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488178; c=relaxed/simple;
	bh=rO1Aepg+ZPdfUbjznCSF+LW5fDa0Tz1f7cbp73DbIAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otggSW/IAFGCQFmxZxSOSQnvrobg6g2a8koira5f6xQWyueDr8ylNZrXDbQn7FZLjiZgo4HJLbCe/uq6DBkfiWVjexGWNtgtfZOIVv2jdXfDWBDT9IAg2fKRbJ+XYe5vSdwHS9cugg1KTqn5zqXliK1FhOnF2JKekoREDECF4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kiTqgz1Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kiTqgz1Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61F111D70;
	Tue, 15 Sep 2026 09:02:52 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B9AD3F882;
	Tue, 15 Sep 2026 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789488176; bh=rO1Aepg+ZPdfUbjznCSF+LW5fDa0Tz1f7cbp73DbIAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiTqgz1Yy7gR4b79nYtgyPn5gKXuxc5Ql439+CksEyu0ACTiBZF3AQnCkHudHESRL
	 56Vb4DL+sRoAZFCxozDJsocWeomwOVq3oITqrg/vq1LrdObvOx19lnRGaH0eq+s+EV
	 iOwXxpFgCoINxg9YqCKXx/dlurAbS+Nv4jR1BzwY=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	oupton@kernel.org,
	gshan@redhat.com,
	joey.gouly@arm.com,
	tabba@google.com,
	yuzenghui@huawei.com,
	linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	alpergun@google.com,
	fj0570is@fujitsu.com,
	WeiLin.Chang@arm.com,
	lpieralisi@kernel.org,
	enju.kohei@fujitsu.com
Subject: [PATCH v18 21/23] KVM: arm64: CCA: WARN on injected undef exceptions
Date: Tue, 15 Sep 2026 17:01:39 +0100
Message-ID: <20260915160141.3543048-22-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160141.3543048-1-suzuki.poulose@arm.com>
References: <20260915160141.3543048-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Price <steven.price@arm.com>

The RMM doesn't allow injection of a undefined exception into a realm
guest. Add a WARN to catch if this ever happens.

Signed-off-by: Steven Price <steven.price@arm.com>
---
Changes since v15:
 * Switch to KVM_BUG() to mark the VM as bugged as well.
Changes since v6:
 * if (x) WARN(1, ...) makes no sense, just WARN(x, ...)!
---
 arch/arm64/kvm/inject_fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index d6c4fc16f8795..d61a3ff04fabb 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -317,6 +317,7 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
  */
 void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 {
+	KVM_BUG(vcpu_is_rec(vcpu), vcpu->kvm, "Unexpected undefined exception injection to REC");
 	if (vcpu_el1_is_32bit(vcpu))
 		inject_undef32(vcpu);
 	else
-- 
2.43.0

