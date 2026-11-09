Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213152;
	b=njRnF8Ft+kozJZ0LDPvJAN+FhCsHOPF9zcQaWkj3CPljZt5GIAGnqKtvJ0hcIpgSbVHY
	 gPT1SOtbQRIT6UBc9w+gM2kqMjri/i4oq60KQFURe0aIshZHjVt1ej48r5q9CCdDlcTXl
	 jY8EFkGKQ1eUKiEiyOiTAGhFA13fWczRmqkypewwzgWZ/K8GSW7+ZVJHiJFksoG8WgAkb
	 BaEPgFZKcnSNSr5OmbromD6aZHdGHIilQK2lMdn/b7zmkskIZY69YisVHFNAoo1f2l0ZZ
	 kKtjdQyVvm6xE37ZIqPmtuHRhGWacv8QiKi1MSJk0tZhSOLKyRZo6Hu6zXenGkQTEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213152;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=42Orm40wyRzB+1dz5ASuI1+iqJtxIK4njD90kiRR/14=;
	b=rqUSaj+t+kyKU3h2mzCJqCVDGGs/9Ra3RwIyAcVp5DARnFwxBkf5n7jMsKEZmnmYuDmR
	 os8iHo+NG31Cv7nJQz+BxPsKlddMmX4co/8ySWklapzc/rSGFEywA20nIDwzKZonbsIt1
	 QgJXfCmzbHU7jcxtfotkt4RYBFAVq8HuXn5wtHV8ANVPksrhxOvjrwM53jNx/9EWWyWm8
	 rgji+zAgVV7pXMxXpmhRJjaHRhEq2JtEsxJsAvmkDP83+02b4HFIJgyglZv2oX+RmmWI7
	 eWaxLlmSg/qWWEQ/a5VwvbWxjHqk9Q2WMPtO4MfOH07UXW3P//qmMV/8mobzTAK5AKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OYqErS+P;
	arc=none smtp.remote-ip=95.215.58.217
Received: from mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558A606EE8B
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A558A606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OYqErS+P
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h9tWamJLklnLk65EksHqbtyH+466JFRTiXTrnW1mmmE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213149; v=1; x=1794817949;
 b=OYqErS+PX1fiBK2+BBhLgkvYq8BrD86IwPoKvPFeXbNfdENtREZzCtbj5zmiJslkKz+NjW3V
 0x8sTL3tLMYWpWZ/2J3eYaYuyzT9+OqRfhxOy305dj2+OX74EwUDaa05rmyorBXDpsx8lFTwKVN
 A5qjrIxvdwHVHXhN7TyQPgoc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3df3eedc180a0556;
	Mon, 09 Nov 2026 08:32:28 +0000
X-Mizu-Trace-ID: 3df3eedc180a0556
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
Subject: [PATCH 09/16] KVM: arm64: Advertise MOPS to protected VMs
Date: Mon,  9 Nov 2026 08:31:58 +0000
Message-ID: <20261109083205.806619-10-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109083205.806619-1-fuad.tabba@linux.dev>
References: <20261109083205.806619-1-fuad.tabba@linux.dev>
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

Advertise FEAT_MOPS to protected VMs. With the field set,
vcpu_set_hcrx() sets HCRX_EL2.{MSCEn,MCE2} for them, and
kvm_hyp_handle_mops() already handles their MOPS exceptions.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/sys_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index d186aba6aa09c..bcc35d6990e67 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -212,6 +212,7 @@ static const struct pvm_ftr_bits pvmid_aa64isar1[] = {
 static const struct pvm_ftr_bits pvmid_aa64isar2[] = {
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, GPA3, IMP, vm_has_ptrauth),
 	MAX_FEAT_FUNC(ID_AA64ISAR2_EL1, APA3, PAuth, vm_has_ptrauth),
+	MAX_FEAT(ID_AA64ISAR2_EL1, MOPS, IMP),
 	MAX_FEAT(ID_AA64ISAR2_EL1, ATS1A, IMP),
 	FEAT_END
 };
-- 
2.47.3

