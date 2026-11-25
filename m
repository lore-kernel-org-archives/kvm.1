Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621159;
	b=fRDktiOVIz0iw/cIzSVyP/O6WiLywmVylqJ/WoS2RGwWk0zbLLsvdJHmwxgZNTSttz2u
	 uxBV1iIvQpMP83iGstlMv81XqpehEyD3fbyqssvPJf831Nn5CVo4N7/YwvuMBkHRJfpdL
	 RMjWinpmHqxCALIFJEhv/cJKHVQyQiNx5tDiJS08D0+p5XSlGgscUfQ1qmllHvfjy69cI
	 waGAQeWLmYhJsP6vz5R+93cQM5IITeVWvexxtROCnlHz1bsyizHpLY18GGrnJADvqpE11
	 ouwxrJTB2zy/fzCdoIO3vESY33PGVB6eAw7nztcL9FfJUGgZkitwTPqh6XYT8LoYumQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621159;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LCnVdHirYtBKX2t/3K8ljhm+P9aiBrtU685db8fTm+U=;
	b=Fu01bpNG5FFe14D3tShjeKvX6TP+4pkn8z91f30nv8Y8cna/zjBltQ3RlQCykQRF/Ref
	 3pXyKyDNWtLbXO+9oPNhrjwmjEJjmcW8xnCLAOcP/xwmtKya5FpU6uPn/oqTHAQytLZW7
	 MB82pwUAreNPyhfirrWReFpnlHQn/yLL/9AV/vfvJsEq21K2GZg6ef4JiCNv/dowT8ddU
	 feGa1gsq1LUVK65zUxyDqJSKWSrV3Q5rbDZ6PyczxpNPU0+SNA4HDDc1g60yY1PX7xG4Z
	 w5Wo4G+n7SO9xZJhu3r2KLAgXdC2mPPSSCTowVqxmd+Dea5dsPziJyvlgydjADfQP0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wALhDrPH;
	arc=none smtp.remote-ip=91.218.175.98
Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235A606A68D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C235A606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wALhDrPH
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o/SZfwEeYhSxZ5cZ93jBl6fDIchTpBEO/6emnlOmEC8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795621156; v=1; x=1796225956;
 b=wALhDrPHUWRg+PnqBIVx+mxcK8l9B5eVX7yhtcbiSL6rCAaOfbBky+29ZklmAUKpVE6l/uSW
 44X01pscOJFIM/bi3O9KlVHJPxOgE9E/lsPcaqvCb5h1OVtHFPy9Izhflf13+0gKlEKWyZPwl7y
 ep/OCYkzSH14QmG7cg87eAIQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3ce0fa6c33041ea;
	Wed, 25 Nov 2026 15:39:16 +0000
X-Mizu-Trace-ID: b3ce0fa6c33041ea
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/20] KVM: arm64: Don't advertise the host's MTE_frac to protected VMs
Date: Wed, 25 Nov 2026 15:38:53 +0000
Message-ID: <20261125153911.106793-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125153911.106793-1-fuad.tabba@linux.dev>
References: <20261125153911.106793-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protected VMs don't support MTE, so MTE_frac in their ID_AA64PFR1_EL1
doesn't apply and is RES0, as it is for a non-protected VM without MTE.

Commit 3d7ff00700d1a ("KVM: arm64: Rework specifying restricted
features for protected VMs") caps the field at NI in the pVM
restriction table. However, NI is 0xF and the clamp is unsigned, so the
cap does nothing and a protected guest sees the host's value. On a CPU
with MTE2 but without FEAT_MTE_ASYNC, that value is 0xF.

Drop the entry so that the field reads as 0 again. It was the only
entry capping an unsigned field at an NI other than 0.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 32e82653ebf7e..e1749138f7507 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -105,7 +105,6 @@ static const struct pvm_ftr_bits pvmid_aa64pfr0[] = {
 static const struct pvm_ftr_bits pvmid_aa64pfr1[] = {
 	MAX_FEAT(ID_AA64PFR1_EL1, BT, IMP),
 	MAX_FEAT(ID_AA64PFR1_EL1, SSBS, SSBS2),
-	MAX_FEAT_ENUM(ID_AA64PFR1_EL1, MTE_frac, NI),
 	FEAT_END
 };
 
-- 
2.47.3

