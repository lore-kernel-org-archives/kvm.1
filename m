Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE42309AA
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799949; cv=none; b=oKB0A0LLdnNPSeaj3SZ+LU542j2hy75TVJjDa3mM+Erh+V62spuYEcHPltjXkPl40c1qU4hodpzMaQlUtZm1TK35owFpskANtoJmUEjFpphk+qjvKBAzSLUUV3qivQSSaBXqvseC93bS6EgQzFtmN9e6m5monfkamkw1IT+pB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799949; c=relaxed/simple;
	bh=C7Gi8RgmeDCO1C/mZTDBsGQQ7mj8sq4xG97Ay4lhbCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iv+El8tsc3p3EAK/La0ooLeIXQJ0YXpSu5WXLV9fvdkQECiaYfjozWsFBkoTpKlkXg9rzFGs/ibH8DhbsphdcmWNfIYR/wgrPeMVycA87iYKWjxbcGXFCVySlmbA1nv6PxUkYGV8ly7k0riTNYv+IMbXGhaF0Hyc2yDUD2swNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJXdB/9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJXdB/9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855141F00A3A;
	Tue, 26 May 2026 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779799948;
	bh=5/ATMz46UmOlvFcbxerWQjxTy1+MMpvRzG/+gf6TU9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BJXdB/9C1KA2wMarVh9e+S3nv5EPLpaPlrtvbuiPBJdc3Pw77yB4KwEQyuO3giIGG
	 aJ8TNLMDlXqtnTt2vmHHDyGKhKEiFKSS6Fn/oQc+eytrYFDqrUI+NeEOSKk8bEP0Vt
	 QROt/iyZnuk5DBcFAMzrr58UtpoK8dgDGEMt9w/Xx3uDq/CtmjHnOmOk6S/+J82CND
	 asSTOXbplB+TyNGtc6Xj+qo2IuutT+lrq7R2zl0JH0wF9p2+1eDssoxdWZJwwIToHE
	 MjgRDpNniNEWzlH+nQ2wmZX2rfr5W/5FiivscAxLBqsZgJwRo4c6KpeniaGbL5O57V
	 8aT2pGArhr4WQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	kvm@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] s390: kvm: arm64: add HAS_IOMEM dependency
Date: Tue, 26 May 2026 14:52:20 +0200
Message-Id: <20260526125220.1560451-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260526125220.1560451-1-arnd@kernel.org>
References: <20260526125220.1560451-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The arm64 kvm driver can only be enabled when MMIO support is part of
the host kernel:

arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c:120:27: error: 'struct kvm_vcpu' has no member named 'mmio_needed'

s390 does not support MMIO if PCI is disabled, but in practice one
would not actually need kvm support in those configurations either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is currently needed for randconfig build testing the
'sae' branch, it is not yet in linux-next
---
 arch/s390/kvm/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/arm64/Kconfig b/arch/s390/kvm/arm64/Kconfig
index 42a1be50f6e1..65b9dc25fe62 100644
--- a/arch/s390/kvm/arm64/Kconfig
+++ b/arch/s390/kvm/arm64/Kconfig
@@ -3,6 +3,7 @@
 config KVM_ARM64
 	def_tristate y
 	prompt "Kernel-based Virtual Machine (KVM) support for arm64 guests"
+	depends on HAS_IOMEM
 	select KVM
 	select KVM_VFIO
 	select IRQ_BYPASS_MANAGER
-- 
2.39.5

