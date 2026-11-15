Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794730328;
	b=jKsYk8McN8if+BC8NYnHfGPxD+lwSr5e/qRyCiuOZDk4Y7Z+PS8PWgAsXNpt3Q8U5DBX
	 zJcli+knOSbWt/R1nJ63ih3zaxgJ9RXVV8PdAu6hYH0MU93/Z90adEXpIYrws9O80wSvp
	 2MsTFnqwyMeXot8GEr7LuIfJJENFbP3h1xedCLnHxt5Ajt57/HJDFcSqOw/bDwrQq3I05
	 2NTOhzyHjErO+m7Vfr/4MR5LKgszatOeMHM3TpS4CfffFn2uklbSpAfnWb5zCXQkPD5M2
	 70WJvsyJzgG8wipov5P2WGXxTylRZORkj/x8DUPxQkBXrUCgwJ8ZR3qaSXdop/LjIyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794730328;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fUa0H0ztFNFxbRvfr5CH/40+4HwV2xqZXcXOuIDf7nY=;
	b=p1T1nxNz1C6x/TjN6H7g99XP7ndq0XAXADLzSwRtlQ6n1DDNUZZl62KGi3v/lVuomU0E
	 4q6+jSAmp3PIvYF2Zkv4U0sxKi4wQr/yd5AsiEQ2svUQX20dwOes5qywmjXAM+tky5i/K
	 Vi9EXw3Rc9tnA1oTONlxg5spxInVyY7ARlHY1IFOLqWXAa9rz+sx147CfdqHbvWAyWJWN
	 2Ar6MTJYn3+KB1V+zuZLAobz3ovK/Pya0EjXdeCiuELCWBY7A1Lb2eGrImxIn6S59s0q4
	 vBSH2PTgfczQmeB4j33R6Q+m9SvFvgXloc01CcHwPiLSm00SKBWeGiQ/xAeUDncSzeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i62iclQZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C983606A31A;
	Sun, 15 Nov 2026 08:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C983606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i62iclQZ
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF7vviY2205269;
	Sun, 15 Nov 2026 08:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fUa0H0ztFNFxbRvfr5CH/40+4HwV2xqZXcX
	OuIDf7nY=; b=i62iclQZDxxp/ozqj9EOgfArEp6xpaFMkgRosd357rXah9VU2B+
	5YLPQsPLWAY0pHLsE7E6f1Za6/2pMl869w2nUWtF1YX5AA0VYP4jobldKnoco8Lw
	iJ099NgEiUEs0iIZAtfG0/zUN2EieojtjJ3TFnwjRaBmqo00/baibTMpRbnC+YTi
	4gK9sZkzD4EhyRv0ijGw3ROrdnWoD5k1pRDvSlX9IsYhx6nqROObMANqZYo5WwZX
	1w1FdUQ8mJfthy706N3cqgcyDSaEzIMCs8q8KTyx0uwdp1BQDVEr1TzpOc4srtsL
	OEQvdts+6FpzLmhbNwzl4HD0uHtzC3GK+IA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk22k1m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 08:11:53 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AF8BofP2472710;
	Sun, 15 Nov 2026 08:11:50 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AF8Bo7n2472702
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 15 Nov 2026 08:11:50 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id ACC01248E2; Sun, 15 Nov 2026 13:41:49 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Atish Patra <atish.patra@linux.dev>,
        Andrew Jones <andrew.jones@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anup Patel <anup@brainfault.org>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v2] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw spinlock
Date: Sun, 15 Nov 2026 13:41:49 +0530
Message-ID: <20261115081149.901590-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: rt763E9qN95eSkS-VYNd9oSGTjgbV9Q0
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af96949 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=tOZApgkiDm8jHLQLuvUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAzMiBTYWx0ZWRfXz1twMmDAI67m
 93+/0v6JlKlCoh9rmjAH1fvgHno6x2LVMfHHASHeEV7BYpW7GFoZEM1ttkPwHCrleT6I2fXozfZ
 RrvqRJk8bo/lLD5QEqM4oEoMKvTuZhD6YtimpgA9qgmzxC2JW0sKUhwE9h26jBp6WnJWxdug7bz
 yPWSXkra1QuKRjyiFja0VN3GB6dbivXDUz6Icn2C1o/1MutYcPEWP2BWnlGekXvVIgLzLkdNgEY
 VB05jYVka7Yy7bSMT/8BUgG3CNbUJ8xTkI3yfeJcWvfi2RiwhyFe+yOLPMaU+fQPJBKzBpb3HiZ
 GKoCih61Wb+Vtban2dvFj6T2nk2xkjO20yFPGXt1u9G0ARYuWmFYn1fnJL2d/vw8qNp5umE/cST
 mxsY0AD4tBrTXjFXMBlaEIXG1oX6yF7ZB1nSEYrG+P7+ZS1XPbxyLY6Wfz9UqAyBXxTDjtlvoVx
 Xz5afzp2X4+GAbIeG+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAzMiBTYWx0ZWRfXwqyJ1ELKz4x6
 I4FanG0zWiT1K4AG9vRxrUMSP/84aMn2lttNHR5QHdX8jkYqSiOasuoC0Y6RNRKOlTtG83SQ8fZ
 h44F1PfQiFrm42oQY+bKCzKuAYkgblk=
X-Proofpoint-GUID: rt763E9qN95eSkS-VYNd9oSGTjgbV9Q0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150032

The kvm_riscv_vcpu_aia_imsic_put() runs from the scheduler preemption
notifier with the raw runqueue lock held, so it must not take vsfile_lock,
an rwlock_t, which sleeps on PREEMPT_RT. All vsfile_lock critical sections
are short, so a raw spinlock is fine.

In addition, converting vsfile_lock to raw spinlock allows us to drop
the vsfile_hgei_lock and the raw_spin_unlock() will internally call
mmiowb_spin_unlock() which in-turn drains the write-buffer at the time
of releasing vsfile_lock.

Co-developed-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
Changes since v1:
 - Use writel() instead of writel_relaxed() because mmiowb_spin_unlock()
   will be only called by raw_spin_unlock() when writel() is called from
   critical section.
 - Use swfile_extirq_lock in imsic_swfile_read() to serialize clearing
   IRQ_VS_EXT.
---
 arch/riscv/kvm/aia_imsic.c | 82 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 302938972aa0..c5966019cd1f 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -47,9 +47,7 @@ struct imsic {
 	 */
 
 	/* IMSIC VS-file */
-	rwlock_t vsfile_lock;
-	/* Writers hold both locks; scheduler-out only takes vsfile_hgei_lock. */
-	raw_spinlock_t vsfile_hgei_lock;
+	raw_spinlock_t vsfile_lock;
 	int vsfile_cpu;
 	int vsfile_hgei;
 	void __iomem *vsfile_va;
@@ -490,17 +488,6 @@ static void imsic_vsfile_local_update(int vsfile_hgei, u32 nr_eix,
 	csr_write(CSR_VSISELECT, old_vsiselect);
 }
 
-static void imsic_vsfile_set_hgei(struct imsic *imsic, int cpu, int hgei)
-{
-	unsigned long flags;
-
-	/* Serialize the CPU/HGEI pair with scheduler-out's wakeup setup. */
-	raw_spin_lock_irqsave(&imsic->vsfile_hgei_lock, flags);
-	imsic->vsfile_cpu = cpu;
-	imsic->vsfile_hgei = hgei;
-	raw_spin_unlock_irqrestore(&imsic->vsfile_hgei_lock, flags);
-}
-
 static void imsic_vsfile_cleanup(struct imsic *imsic)
 {
 	int old_vsfile_hgei, old_vsfile_cpu;
@@ -512,13 +499,14 @@ static void imsic_vsfile_cleanup(struct imsic *imsic)
 	 * VCPU is being destroyed.
 	 */
 
-	write_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
 	old_vsfile_cpu = imsic->vsfile_cpu;
-	imsic_vsfile_set_hgei(imsic, -1, -1);
+	imsic->vsfile_cpu = -1;
+	imsic->vsfile_hgei = -1;
 	imsic->vsfile_va = NULL;
 	imsic->vsfile_pa = 0;
-	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	memset(imsic->swfile, 0, sizeof(*imsic->swfile));
 
@@ -553,6 +541,7 @@ static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
 			      struct imsic_mrif *mrif)
 {
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	unsigned long flags;
 
 	/*
 	 * We don't use imsic_mrif_atomic_xyz() functions to read and
@@ -561,11 +550,15 @@ static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
 	 * a temporary MRIF on stack.
 	 */
 
+	raw_spin_lock_irqsave(&imsic->swfile_extirq_lock, flags);
+
 	memcpy(mrif, imsic->swfile, sizeof(*mrif));
 	if (clear) {
 		memset(imsic->swfile, 0, sizeof(*imsic->swfile));
 		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
 	}
+
+	raw_spin_unlock_irqrestore(&imsic->swfile_extirq_lock, flags);
 }
 
 static void imsic_swfile_update(struct kvm_vcpu *vcpu,
@@ -606,7 +599,7 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 	 * only check for interrupt when IMSIC VS-file is being used.
 	 */
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	if (imsic->vsfile_cpu > -1) {
 		/*
 		 * This function is typically called from kvm_vcpu_block() via
@@ -621,7 +614,7 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 		else
 			ret = !!(csr_read(CSR_HGEIP) & BIT(imsic->vsfile_hgei));
 	}
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	return ret;
 }
@@ -646,10 +639,10 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vcpu)
 	if (!kvm_vcpu_is_blocking(vcpu))
 		return;
 
-	raw_spin_lock_irqsave(&imsic->vsfile_hgei_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	if (imsic->vsfile_cpu > -1)
 		csr_set(CSR_HGEIE, BIT(imsic->vsfile_hgei));
-	raw_spin_unlock_irqrestore(&imsic->vsfile_hgei_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 }
 
 void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
@@ -663,13 +656,14 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 		return;
 
 	/* Read and clear IMSIC VS-file details */
-	write_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
 	old_vsfile_cpu = imsic->vsfile_cpu;
-	imsic_vsfile_set_hgei(imsic, -1, -1);
+	imsic->vsfile_cpu = -1;
+	imsic->vsfile_hgei = -1;
 	imsic->vsfile_va = NULL;
 	imsic->vsfile_pa = 0;
-	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/* Do nothing, if no IMSIC VS-file to release */
 	if (old_vsfile_cpu < 0)
@@ -726,10 +720,10 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 		return 1;
 
 	/* Read old IMSIC VS-file details */
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	old_vsfile_hgei = imsic->vsfile_hgei;
 	old_vsfile_cpu = imsic->vsfile_cpu;
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/* Do nothing if we are continuing on same CPU */
 	if (old_vsfile_cpu == vcpu->cpu)
@@ -779,11 +773,12 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 	/* TODO: Update the IOMMU mapping ??? */
 
 	/* Update new IMSIC VS-file details in IMSIC context */
-	write_lock_irqsave(&imsic->vsfile_lock, flags);
-	imsic_vsfile_set_hgei(imsic, vcpu->cpu, new_vsfile_hgei);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
+	imsic->vsfile_cpu = vcpu->cpu;
+	imsic->vsfile_hgei = new_vsfile_hgei;
 	imsic->vsfile_va = new_vsfile_va;
 	imsic->vsfile_pa = new_vsfile_pa;
-	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/*
 	 * At this point, all interrupt producers have been moved
@@ -874,6 +869,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	struct imsic *imsic;
 	struct kvm_vcpu *vcpu;
 	int rc, vsfile_hgei, vsfile_cpu;
+	bool swfile_update = false;
 
 	if (!kvm_riscv_aia_initialized(kvm))
 		return -ENODEV;
@@ -893,7 +889,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	}
 	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 
 	rc = 0;
 	vsfile_hgei = imsic->vsfile_hgei;
@@ -902,13 +898,16 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 		if (write) {
 			rc = imsic_mrif_rmw(imsic->swfile, imsic->nr_eix,
 					    isel, NULL, *val, -1UL);
-			imsic_swfile_extirq_update(vcpu);
+			swfile_update = true;
 		} else
 			rc = imsic_mrif_rmw(imsic->swfile, imsic->nr_eix,
 					    isel, val, 0, 0);
 	}
 
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
+
+	if (swfile_update)
+		imsic_swfile_extirq_update(vcpu);
 
 	if (!rc && vsfile_cpu >= 0)
 		rc = imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr_eix,
@@ -959,6 +958,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	unsigned long flags;
 	struct imsic_mrif_eix *eix;
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	bool swfile_update = false;
 
 	/* We only emulate one IMSIC MMIO page for each Guest VCPU */
 	if (!imsic || !iid || guest_index ||
@@ -970,17 +970,26 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	if (imsic->nr_msis <= iid)
 		return -EINVAL;
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 
 	if (imsic->vsfile_cpu >= 0) {
+		/*
+		 * We must use writel() over here because the raw_spin_unlock()
+		 * below will do mmiowb_spin_unlock() which in-turn drains the
+		 * write-buffer ensuring the write is visible to the CPU owning
+		 * the target IMSIC VS-file.
+		 */
 		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
 	} else {
 		eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
 		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
-		imsic_swfile_extirq_update(vcpu);
+		swfile_update = true;
 	}
 
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
+
+	if (swfile_update)
+		imsic_swfile_extirq_update(vcpu);
 
 	return 0;
 }
@@ -1036,8 +1045,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 
 	/* Setup IMSIC context  */
 	imsic->nr_msis = kvm->arch.aia.nr_ids + 1;
-	rwlock_init(&imsic->vsfile_lock);
-	raw_spin_lock_init(&imsic->vsfile_hgei_lock);
+	raw_spin_lock_init(&imsic->vsfile_lock);
 	imsic->nr_eix = BITS_TO_U64(imsic->nr_msis);
 	imsic->nr_hw_eix = BITS_TO_U64(kvm_riscv_aia_max_ids);
 	imsic->vsfile_hgei = imsic->vsfile_cpu = -1;
-- 
2.43.0

