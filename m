Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D23CBE95
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495607; cv=none; b=QKYf/lNqbQGNv5VtYW2E4yyIaIFqxKwfwskztQEnpMADlT9HN1yylPkrN2t1UjPBOjdlYRbhn8+Y8zuig4DyBUfRYYQRlii6avVzvMAkviq590JuC0hoLIsARVnCe3oKEHYN20W780ZbrVP9pP1imu2cpCObFYq6X8E26HRkScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495607; c=relaxed/simple;
	bh=yF7LfwdzDGXjHphjLzV953Ax0pwRq9FtyPOygII0oew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izeFPMDSkkkwjLPbn3vrzBRAb9WRTPG7+9mNO1vHzLUNgxRHeg4g1m8koWS/ed5CZwhBp28ZTdWIYsS/RYRjJuQkbIstj5D2NBzIwtlkPN91JQ/nho0uz47aGYNgU71+RidSjaK0zmKiZyQHlC0pC94VJ2pOJY9jFbRkynVYh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DyL0Jxzj; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DyL0Jxzj"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yF7LfwdzDGXjHphjLzV953Ax0pwRq9FtyPOygII0oew=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790495601; v=1; x=1791100401;
 b=DyL0JxzjPvzCfcdd7kDtT+jDp8wsIvruEM3bVcdKW4FB9qb7BRt1TTfe/sBJatxm4EosURZx
 4V8Bk2CFv4zdJNfIrkol2NIeBhGhf7ODqairF1/L1QO4H2rk9xAbr1duiEHVqxhX/bUXddX63Xs
 0Px5vQaS8u2Gt9mFqQ8RPavI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9517acd8b46f1144;
	Sun, 27 Sep 2026 07:53:21 +0000
X-Mizu-Trace-ID: 9517acd8b46f1144
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	gaosong@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 4/6] LoongArch: KVM: Rebase steal time counter in vcpu context
Date: Sun, 27 Sep 2026 15:52:38 +0800
Message-ID: <20260927075240.3007947-5-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927075240.3007947-1-cui.tao@linux.dev>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

KVM_SET_DEVICE_ATTR(PVTIME GPA) initializes st.last_steal from the
ioctl thread's run_delay, but kvm_update_stolen_time() accumulates the
vcpu thread's run_delay; the first delta can be negative and wraps in
u64, so the guest reads a steal time close to 2^64.

Drop the initialization from the attr path and lazily rebase the
counter on the first steal update, which runs in vcpu context like the
hypercall path.  Re-registering a GPA clears the rebase sentinel first
and publishes the address with a write barrier; the reader side loads
the address and sentinel with READ_ONCE and a read barrier so a
concurrent re-registration is not observed half-applied.

Fixes: b4ba157044ea ("LoongArch: KVM: Add PV steal time support in host side")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/vcpu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 8e028be3f0a9..d931a5a802f6 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -154,12 +154,13 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	u32 version;
 	u64 steal;
 	gpa_t gpa;
+	u64 last_steal;
 	struct kvm_memslots *slots;
 	struct kvm_steal_time __user *st;
 	struct gfn_to_hva_cache *ghc;
 
 	ghc = &vcpu->arch.st.cache;
-	gpa = vcpu->arch.st.guest_addr;
+	gpa = READ_ONCE(vcpu->arch.st.guest_addr);
 	if (!(gpa & KVM_STEAL_PHYS_VALID))
 		return;
 
@@ -187,8 +188,14 @@ static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 	smp_wmb();
 
 	unsafe_get_user(steal, &st->steal, out);
-	steal += current->sched_info.run_delay - vcpu->arch.st.last_steal;
-	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+	/* acquire pairs with the smp_wmb in the attr path */
+	smp_rmb();
+	last_steal = READ_ONCE(vcpu->arch.st.last_steal);
+	if (!last_steal)
+		/* first update in vcpu context: rebase the counter */
+		last_steal = current->sched_info.run_delay;
+	steal += current->sched_info.run_delay - last_steal;
+	WRITE_ONCE(vcpu->arch.st.last_steal, current->sched_info.run_delay);
 	unsafe_put_user(steal, &st->steal, out);
 
 	smp_wmb();
@@ -1122,7 +1129,7 @@ static int kvm_loongarch_pvtime_get_attr(struct kvm_vcpu *vcpu,
 			|| attr->attr != KVM_LOONGARCH_VCPU_PVTIME_GPA)
 		return -ENXIO;
 
-	gpa = vcpu->arch.st.guest_addr;
+	gpa = READ_ONCE(vcpu->arch.st.guest_addr);
 	if (put_user(gpa, user))
 		return -EFAULT;
 
@@ -1197,7 +1204,7 @@ static int kvm_loongarch_pvtime_set_attr(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	if (!(gpa & KVM_STEAL_PHYS_VALID)) {
-		vcpu->arch.st.guest_addr = gpa;
+		WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
 		return 0;
 	}
 
@@ -1208,8 +1215,10 @@ static int kvm_loongarch_pvtime_set_attr(struct kvm_vcpu *vcpu,
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (!ret) {
-		vcpu->arch.st.guest_addr = gpa;
-		vcpu->arch.st.last_steal = current->sched_info.run_delay;
+		WRITE_ONCE(vcpu->arch.st.last_steal, 0);
+		/* publish the new address only after clearing the rebase sentinel */
+		smp_wmb();
+		WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 	}
 
@@ -1800,7 +1809,7 @@ static void kvm_vcpu_set_pv_preempted(struct kvm_vcpu *vcpu)
 	struct kvm_memslots *slots;
 	struct kvm_steal_time __user *st;
 
-	gpa = vcpu->arch.st.guest_addr;
+	gpa = READ_ONCE(vcpu->arch.st.guest_addr);
 	if (!(gpa & KVM_STEAL_PHYS_VALID))
 		return;
 
-- 
2.43.0

