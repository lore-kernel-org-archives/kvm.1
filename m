Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5D2BE7BB
	for <kvm@vger.kernel.org>; Sat, 28 Mar 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774689734; cv=none; b=Wirr7h1Vw5NWnQ+KB9dD602feYXovBrbLb0OgtyzE45cSqocfeFtytcamrWXGjtfoAyUp7SIsL/PKY2GfB9nC8KmjPuFhHACvUSSlv8C61RK9UoxxBBASpkEjcfWHM4ox3E1IKh3meRDJrAfLxPrvHql6HUBjHQiISpMDLaVRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774689734; c=relaxed/simple;
	bh=0D7NDPLBz7CsahcpDPGJpQSPQyevwApoNMzB/Ma+bQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2IuJLpjBTKcsLRrc3R0XdIAjV1O+6lan+ut7wa8+EMRL24nAD8B41tyqdyNNpyCWCPQa+Ekx4iT0ybe6DDU6piSHXRvNYt2SGutFhlsXIq7u3P4kQ5hb0iA0Aby/81E/ssjucKxSHGer8oXvXxZ5zrz2mSOauCYzCj1fIqoGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQGQxLsP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQGQxLsP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774689729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=32F5mTJaAj0N/FgsyqUyjOrOpTIx3iyjz27Gm160YI0=;
	b=LQGQxLsPWUUKNiS9izD994OcRD4Qe8YmBJ2/6ybuHVLl7MGGBjWOElR2BGUgGHwfKmhtoT
	R48X4U/8G/SXxkly0CEAYbRZp/Aq9ovHcrfpLetqhPUx4ueSZOW3aZ6snWawrqEkigCePS
	lZf3p0VeRPJJHlDhgHnoU/ejGS4ypwU=
From: Yufan Chen <yufan.chen@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: yufan.chen@linux.dev,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH] riscv/kvm: fix guest vector leak on host alloc failure
Date: Sat, 28 Mar 2026 17:21:57 +0800
Message-ID: <20260328092157.75058-1-yufan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=ericterminal@gmail.com; h=from:subject; bh=NyfQPU3Jx0krdL2ohrnV2JS3MQSaKsafKvtyKGDOgko=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQen8OyTu1PtO8cubJjyjckVnkk+E65Zah1/P09Th+OB U7rTWz1OiayMIhxMViKKbLc/b9vbq7XrTnXuQ/nwsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6 hkY6BjrGDFycAjDVU2MZGd4zLJKIWpTyzoVD/cjFfqWSN2ZpJjwVPv6+73b6bcgL9waqOHGO1yO s/cU5sdtR5p/XBW9Mjp9gr+62/dNR/4aaC0ksAA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yufan Chen <ericterminal@gmail.com>

When allocating vector context for a vCPU, guest_context.vector.datap is allocated before host_context.vector.datap. If the second allocation fails, the function returns -ENOMEM directly and leaks the guest buffer.

Switch the failure path to centralized cleanup. On host allocation failure, free guest_context.vector.datap, clear the pointer, and return -ENOMEM through a shared exit label.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 arch/riscv/kvm/vcpu_vector.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 05f3cc2d8..4c2f92dce 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -75,15 +75,23 @@ void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
 
 int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 {
+	int rc = -ENOMEM;
+
 	vcpu->arch.guest_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
 	if (!vcpu->arch.guest_context.vector.datap)
-		return -ENOMEM;
+		goto out;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
 	if (!vcpu->arch.host_context.vector.datap)
-		return -ENOMEM;
+		goto free_guest_vector_datap;
 
 	return 0;
+
+free_guest_vector_datap:
+	kfree(vcpu->arch.guest_context.vector.datap);
+	vcpu->arch.guest_context.vector.datap = NULL;
+out:
+	return rc;
 }
 
 void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
-- 
2.47.3

