Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213132;
	b=T+VvLP9kwRG+aWF7j08eEpW+lVl5/jMDO96FmuE6v9l9nskIubsYMTLMWjxX6+JDMr3J
	 xBuzcz5WXP8biorx0XF65kjboDrHt0tcPLU7aNsmnmKh9NeXI7sA9e/VUu9RC0AIOa/Dd
	 v9gRkCr93pjynsO59vdxo3OIOdbcuMcHmq8Ne+WiyN/VvU+xHevpGAgfEh/zKKLpThO/i
	 eTetRp1nfENAJ6YIbLoMuyt3MCx0s89XtNd3wonV6TXPPTZOMKcY5L6wGbITqjMtU8dlJ
	 VrAq1m1RZT1Lx7t1yJNxeZO5/J4OmDmE4OSGYK2D00GvyGRV+c+OV0MQEOfE34FBkXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213132;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yYnRMu74QSYMFyFnZroW2XAIK+45426ADoRmFNwN2fU=;
	b=YQo85lw6g95Wi5Fno8QhrGpdVeXUK1xsg9Q5B+kXdGKa+qR1c9a38PJtUrNp0+nd71fG
	 2Ef+EnbOU2uNnAyvoqRenHpv5xdMovcVvNZnDyHOGcXsft/HgOmqNNCgzu23bLFKFWUwn
	 c6ppOSVAKD9h/DPaLpr9j6AO2UrJzIUlG5TaXTTm0EoalIb6x3tkXRBk9k9Jy9/9NPX8b
	 WTl+fiTJ4R2nKaqhiKq3UcRztVGNwjjZav4o9L/Bnr+kK6pA/HfB00hUOAK/AplGRrVK6
	 h67kz3R0HXT2fua/7+1E27C0FKxu7//neYfUQvOU6WlZ03SRznwJE9OFuUMulW+7cbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="H/lVnO8m";
	arc=none smtp.remote-ip=95.215.58.138
Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0D606A33B
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A0D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H/lVnO8m
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=scB/wdNHn77rOn8XuOwegyz93L7MG0cBY5PFUM4ImWI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213129; v=1; x=1794817929;
 b=H/lVnO8m1Sac2706uznVDfJOOjMcv/TmwFyofUliBSPJ5Tn6PI4gU4Lw1OieEKT7RcipLwgC
 STjm5Ps4uZTYyr21dBIUCj+xeC7gwuqB6w09bq/kZfOzVK0EXe4WCagGd4YVFtVWoDp0fF/H6YJ
 sm1s9PxO5nTj/GI69vomk4Ys=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8251e993a8e30812;
	Mon, 09 Nov 2026 08:32:08 +0000
X-Mizu-Trace-ID: 8251e993a8e30812
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
Subject: [PATCH 02/16] KVM: arm64: Remove redundant kern_hyp_va() calls from the pKVM FP sync
Date: Mon,  9 Nov 2026 08:31:51 +0000
Message-ID: <20261109083205.806619-3-fuad.tabba@linux.dev>
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

With pKVM, EL2 saves a guest's FP and SVE state on exit into the hyp
vCPU, whose kvm is the hyp VM's and whose sve_state is already a hyp
address. kern_hyp_va() returns both unchanged.

Remove the two calls, in fpsimd_sve_sync() and __hyp_sve_save_guest().
The one in __hyp_sve_restore_guest() stays, as nVHE without pKVM reaches
it with the host's pointer.

No functional change intended.

Tested-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 9958ca6d7b0a2..57c3f7a2d4b14 100644
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

