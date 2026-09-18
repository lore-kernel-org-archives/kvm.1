Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4C3CDBAA
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699612; cv=none; b=mV9N9EpP6gCmOWLw6R50WfCaOcJ4Ao/8xz/6B25NukLab5vzfBH8GSrsKdkPD/d4ojG/aaF+DaxkUYj82LcZFh4V4uy90JQkwRqMjHKnO1SlfIHiuXJd/l89bB45u62Bg1hi/BwiUKlcUqCGaknp0nyYQ67I8Hd7jM6374md6rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699612; c=relaxed/simple;
	bh=dwjlFa/K9V/FlCSuEo2COBXLlzeVVphfTyK1djlBGbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXYb7rXwQpDDJmgcqbyyubhZ5DDKFWzl4GyG97cxA6mq4Z4QlRf+B4xLuzZdnUfGhYE5O49Q7TbRoBJY7B6JOoN9s9cq1bssWcXk1jB07PQ6aHALM+w1YoLrvGwMuOtlHUnqF3Ohg27bvwyQM/8qjNgkaBB0y0ri3GBxvkSzY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtxPnCa2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtxPnCa2"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85a4329731cso208999b3a.3
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789699599; x=1790304399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lGfz1siIT5q4E2uH8NernSgbLLCtHEciMJJUl+iNLo=;
        b=YtxPnCa2f60qsbjunv8REnS7zQJxPotqbtKB3y9fZKS3CiGrG9Mwxvgpxs1DXpXT5A
         aQQxb2C554zIRLL0JojiiYoZkHY3G+aw6EIamBVwubdvQFoVkva0eaaOshLiuZbtmS9E
         7+jM4MwN3DxtlF5Y9DygZ8ip37dCaO1rcm45YApVTfEsNDi55RjVJhLDJtg9R67SLj5d
         q8h/iXeIGSR+03Q9oZiFwcsPFP64X9psxxWmSUwpfTKo7onVz/5ZhATksAmIiCGib+XS
         a0zROPQqBVRcpjzVPul49qSoyxdwsMrpmr1ggGEnFsBq24gkPkJJgp/SqCTl1JsWfepe
         1UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789699599; x=1790304399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lGfz1siIT5q4E2uH8NernSgbLLCtHEciMJJUl+iNLo=;
        b=QVsr1hXD7Km+mspTLKspZaFmGxcf8V1zknXfGHZMz38GLlUoMxst+H7hHKgYpZPVgW
         V43ndnSk1R5K0irvzIApgtvDQ9FJyYOkga4C5SjfYIvcxBO5OMeC2Sw8zjg9mkjeuzl7
         1EI6fQ/LAQFD6RJ6UlAsZ9htWYMZZjQ2nZ7eSHlUHtWGFNHShWXpQU5miRRArMqhXHSa
         3j/4izs9F24I7eNzXdF/S2G1+Th0yD8Q0nj8kpHMnTSIsKBpemVOPgQ5Pqe1caL5/qbE
         Z3mPxYsbsvabcK0tP5+EtJ8sT1Fw0xJ/E555HLibQN0zRqY/kttfMfoxYfthyHhK3fCd
         pzeg==
X-Forwarded-Encrypted: i=1; AKwUvByUi+RDCxrle1CG3A+EIshd0ccptxRT3Mc42iB27AiiyjzthMHMOnqvWHDEVxXySbZMi5o=@vger.kernel.org
X-Gm-Message-State: AFuF++nU6kiImlCQStInwrI7gEw9qfnJbyabNeJOKiSzvvxB8yE84uox
	iLhc+A1AC5YLbHou0w6C+QqfxBYh57lihduAa/1bGh4OEHKYDM2dpeax
X-Gm-Gg: AYBFou3olKgN6nBJO+0LLNR8B9VWwnOYcenRXhu19tTQgtvj6dM9vIJzZgQsiG4WkIh
	ZNBqtFM3NOKZiSQPsKXsyMNH7Jc4LCEuL0rj6gaywR56hqXk08ey5C65XgFwpsWt1aIqYqqfNsw
	mYA0uCc1z3zPxVPKgdrGizZfXjjIQPLZ0kMxZYzXDdSUnS/BLtIS53k8xHZOs9S3P0/4hhnJ5IX
	9AZgNDChuch8pMwr2TclB1FVF71mqAu4tUyXJvugFeT79vifPcI0mWarJP8tMW7XGdlTvyfF1gb
	wWYhFmTaSiuBu+VH1b9pzVhpIlovmxOf2R3QhPQhu3U/jJqG7LzuALW5j37UrIf6B/IjZQJ5NKX
	jjpB7id6v5jsR+HaqzsImSdptzgQLzjzb4IwFU2lrQ1i85Ew8GBNJ1gBJ3tyRo8ivaHuJ0DER+m
	K6j2Pcofe0iLnA2s8McwXPyG1qUccqdilIzNvDyDMTVu/QD0iGtSkukThN3VWtRyvM5VUA5sK0W
	GLRM1Y6nPF6H4tIUfukm15to2IWILMNN2jaALA=
X-Received: by 2002:a05:6a20:cc97:b0:3cc:9288:99aa with SMTP id adf61e73a8af0-3dd8c21565fmr2275776637.0.1789699598611;
        Thu, 17 Sep 2026 19:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:ec74:2ce6:f939:d0ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287b0293sm349521eec.24.2026.09.17.19.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 19:46:38 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] KVM: arm64: vgic: Do not remove in-flight LPIs from AP list on disable
Date: Fri, 18 Sep 2026 10:46:20 +0800
Message-ID: <20260918024620.83869-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918024620.83869-1-ndaugoing@gmail.com>
References: <20260918024620.83869-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuchao Zhang <ndaugoing@gmail.com>

By code inspection, a race condition and potential Use-After-Free/crash
exists between remote LPI disabling and local LR folding when EOImode==0.

Commit 6da5e537f5af ("KVM: arm64: vgic: Pick EOIcount deactivations from
AP-list tail") introduced tracking the last interrupt placed in a List
Register in per-CPU host data (*host_data_ptr(last_lr_irq)) and traverses
the remaining ap_list via list_for_each_entry_continue() in
vgic_v3_fold_lr_state().

However, an interrupt loaded into an LR can be an LPI. While vCPU-B is
running the guest, another vCPU-A can write to vCPU-B's redistributor
GICR_CTLR to clear EnableLPIs, which dispatches vgic_flush_pending_lpis().

vgic_flush_pending_lpis() unconditionally removes all LPIs from ap_list
without checking whether the interrupt is currently in an LR
(irq->on_lr):
- It calls list_del(&irq->ap_list), setting ap_list.next to LIST_POISON1,
  and drops the AP-list reference.
- If the LPI is unmapped or its translation cache was invalidated, the
  vgic_irq refcount drops to zero and the object is freed via RCU.
- Meanwhile, vCPU-B's per-CPU *host_data_ptr(last_lr_irq) cannot be
  cleared by remote vCPUs and is left dangling.

When vCPU-B subsequently exits the guest:
1. vgic_v3_fold_lr_state() resumes using the unlinked last_lr_irq.
2. list_for_each_entry_continue() unconditionally evaluates
   list_next_entry(irq, ap_list) during loop initialization, accessing
   LIST_POISON1 (or freed memory).
3. If eoicount > 0, it attempts guard(raw_spinlock)(&irq->irq_lock) on
   the poisoned address, leading to an immediate host kernel panic.

Fix this by:
1. In vgic_flush_pending_lpis(), do not remove LPIs that are currently
   in-flight in an LR (irq->on_lr == true). They will be naturally pruned
   by the owning vCPU's vgic_prune_ap_list() after LR folding.
2. In vgic_fold_state(), clear *host_data_ptr(last_lr_irq) after folding
   so that no stale pointer survives past guest execution.
3. In vgic_v3_fold_lr_state() and vgic_v2_fold_lr_state(), bail out
   immediately if eoicount is zero, avoiding unnecessary list_next_entry()
   evaluation.

Note: this closes the primary race (the last_lr_irq node itself is no
longer unlinkable while in-flight), but the fold traversal can still
race with a remote flush unlinking a subsequent non-LR node in the
ap_list tail. Fully closing that window needs the fold side to take
references before dropping locks (in the spirit of the prune-side fix
in commit 7258770e5814 ("KVM: arm64: vgic: Handle race between
interrupt affinity change and LPI disabling")) and is left as a
follow-up.

Fixes: 6da5e537f5af ("KVM: arm64: vgic: Pick EOIcount deactivations from AP-list tail")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-v2.c |  3 +++
 arch/arm64/kvm/vgic/vgic-v3.c |  3 +++
 arch/arm64/kvm/vgic/vgic.c    | 10 +++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7182f63fc938..7b6cd05ce32d 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -122,6 +122,9 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 	for (int lr = 0; lr < vgic_cpu->vgic_v2.used_lrs; lr++)
 		vgic_v2_fold_lr(vcpu, cpuif->vgic_lr[lr]);
 
+	if (!eoicount)
+		return;
+
 	/* See the GICv3 equivalent for the EOIcount handling rationale */
 	list_for_each_entry_continue(irq, &vgic_cpu->ap_list_head, ap_list) {
 		u32 lr;
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 726e20a1da6e..c6eb5d9dca2d 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -155,6 +155,9 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 	for (int lr = 0; lr < cpuif->used_lrs; lr++)
 		vgic_v3_fold_lr(vcpu, cpuif->vgic_lr[lr]);
 
+	if (!eoicount)
+		return;
+
 	/*
 	 * EOIMode=0: use EOIcount to emulate deactivation. We are
 	 * guaranteed to deactivate in reverse order of the activation, so
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index b25303d9919f..0d7d75c3ac93 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -205,10 +205,12 @@ void vgic_flush_pending_lpis(struct kvm_vcpu *vcpu)
 		if (irq_is_lpi(vcpu->kvm, irq->intid)) {
 			raw_spin_lock(&irq->irq_lock);
 			irq->pending_latch = false;
-			list_del(&irq->ap_list);
-			irq->vcpu = NULL;
+			if (!irq->on_lr) {
+				list_del(&irq->ap_list);
+				irq->vcpu = NULL;
+				deleted |= vgic_put_irq_norelease(vcpu->kvm, irq);
+			}
 			raw_spin_unlock(&irq->irq_lock);
-			deleted |= vgic_put_irq_norelease(vcpu->kvm, irq);
 		}
 	}
 
@@ -873,6 +875,8 @@ static void vgic_fold_state(struct kvm_vcpu *vcpu)
 		vgic_v2_fold_lr_state(vcpu);
 	else
 		vgic_v3_fold_lr_state(vcpu);
+
+	*host_data_ptr(last_lr_irq) = NULL;
 }
 
 /* Requires the irq_lock to be held. */
-- 
2.53.0

