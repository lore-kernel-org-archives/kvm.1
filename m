Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883913;
	b=VyHg2JoAnjAS+/x0Apq6bE2aqSOOI1uePIdf1jQVsxZhkDFlPBWA8SjKG6C4wfPQPQK1
	 dKU5NRgQQ0lt53gx0wGZ/i8MkouC4vDtaBAw2ZXzdXvUaKDUBRPGnS7cM7Bv8zuKTniv3
	 xirutt6q+WHm2IdIezYE60Twmm7Rn44W8L/HplOMpovxXxaM18oQfiRkqoiH97r3hQP5N
	 EK7UoYz0dEJCvmWT9ON/sonWUlkpi/lPcbSnSutP+WXXtMRWNPVH40XjOwp7B4upXNC1q
	 UWyYcg/7EcyBg28c8vEcJc89tPmAtuDGn2jp1Z3lDfZWTCU4Ekgq62FV+EvPrFLB8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883913;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZxmfLdEEjAQHUZvDYuOA8C56xBk1N2ZhSsTcHqmAo3E=;
	b=zmCSul0yQUUHYuYoU9W+ewjs5qkGWyTvVDKPEPuGLqDxmn0N7UWUdk+ZhNhPY8Gegefj
	 qXJvGIYUAgTvh/17UsdHMkE6W1XuisgNTst9Wnb0Y6l7ObcHjPhHHyp3mfAGcGp6nx9Mm
	 qflODtW4hcTUZ5uY2IID1ZcLoS+s7mNrb7c8Eo94NxKxtlfdL1NvvKF2h2qvIrMyDD1cN
	 qgIIwMmTB8Lt47LCv0nIDvSmh2kTrhEaWuGK31NAVSxodR2c0bCVqW+b6nKhlONYXBESr
	 oOWgFyXBDnPKm/D52S987RBpoLH4LDXH1SKD4saTDMMXEZzyc3TgGiWFW4ziXsMi0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=swJzZ2ss;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96C606A328
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 13:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C96C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=swJzZ2ss
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=akSBIvakXwiwzQr5eWo9mafDERPdZxPgysFS+iMF6Zs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793883910; v=1; x=1794488710;
 b=swJzZ2sszlzjhWfBynOlG/NmMi+7fGXkUOFaMZU+CCfvgq4JoCktkMGx5bQCa0jF55gRmXXy
 rMmIiEbYsXQy1kVONVo/8EVdZALy4SVxmskiFpPdtoAKrFyz6oSZBBLUDxV5PEVwBIKnQwNC9G2
 6uQBSxIpTGGV+CXayuSCwlXk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea9cf62d0a721eb1;
	Thu, 05 Nov 2026 13:05:08 +0000
X-Mizu-Trace-ID: ea9cf62d0a721eb1
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
Subject: [PATCH 1/4] KVM: arm64: Remove redundant kern_hyp_va() calls from the pKVM FP sync
Date: Thu,  5 Nov 2026 13:04:53 +0000
Message-ID: <20261105130456.1617185-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105130456.1617185-1-fuad.tabba@linux.dev>
References: <20261105130456.1617185-1-fuad.tabba@linux.dev>
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

With pKVM, EL2 saves a guest's FP and SVE state on exit into the hyp
vCPU, whose kvm is the hyp VM's and whose sve_state is already a hyp
address. kern_hyp_va() returns both unchanged.

Remove the two calls, in fpsimd_sve_sync() and __hyp_sve_save_guest().
The one in __hyp_sve_restore_guest() stays, as nVHE without pKVM reaches
it with the host's pointer.

No functional change intended.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 179d7c8277b88..ea762788e325e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -482,7 +482,7 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 	 * on the VL, so use a consistent (i.e., the maximum) guest VL.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	sve_save_state(kern_hyp_va(vcpu->arch.sve_state), true);
+	sve_save_state(vcpu->arch.sve_state, true);
 	fpsimd_save_common(&vcpu->arch.ctxt.fp_regs);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
 }
@@ -531,7 +531,7 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	else
 		fpsimd_save_state(&vcpu->arch.ctxt.fp_regs);
 
-	has_fpmr = kvm_has_fpmr(kern_hyp_va(vcpu->kvm));
+	has_fpmr = kvm_has_fpmr(vcpu->kvm);
 	if (has_fpmr)
 		__vcpu_assign_sys_reg(vcpu, FPMR, read_sysreg_s(SYS_FPMR));
 
-- 
2.47.3

