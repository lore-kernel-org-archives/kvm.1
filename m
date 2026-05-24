Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E336A02F;
	Sun, 24 May 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628879; cv=none; b=ZIbFJdFQVX7V0GdOsyopFQuYT3AHGlYe5KwzvWN3cfPMKR57TqNNBrdBB2He14QYH8447iYyJQiw/qcyLdFKIzTR57AmplySHVOKsbN6wQIStqhmImBcfQfHCqjqPlncsEtrxL+xxjk+HJ9dCenlIB84yz3weM0gtU6BBgeF0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628879; c=relaxed/simple;
	bh=Au1iecDaQWJNcDTRDirWIcr1XH5hIoAm4ImD/d2IfVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbL09Z1v5HTUFHaV95hRXMQ7+raq0Cc+1FUx38IFYR+Phi7CcCH5Xmo8rBtM/HLagJ1XSKRZKR8nJR0EBMphNbyMIWvGe+Nf8ivx0bgy3PNdB98/1ys+3oTUcjurSDEPU0AylScraXfDoXdzwB0kU2B8HyMPiygCr1jDxg1Irys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvGA3usG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvGA3usG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O7oNgC154865;
	Sun, 24 May 2026 13:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=S/wJhNV3RAm
	G4rFJoPI+bHWyBGLEbvcGfNyWHa1gHpU=; b=LvGA3usGOZj5RVkZjeuo5boigAO
	9X5iSkwCCgx7ldkeVUHhoM+yamxESL1B8oxdSib9GaH+jzqcmzUBSN5XHSlTwnuI
	EZe/qNU+AfeAychnMu7wXYVLR/VtrYwYSWhfaGcoI5j/EToMXs8a7da7OwS6Ji1K
	IKJUeSbxLihA1AxIkmIQnPO6WERz6wcr5ioocss5HTGizvFv+xoKR8TCETl5ms1M
	dNijXBHAAhjoQPdBFloEVNufjvhpRd4PoM+vo8k+cm635kSpsQKWiGY9sJwXX6Kr
	Zm5R2t/6y6qlwI4xTmMMIqJYgKckRXwlhBxeCJWrDM7U11R5KhGmUYsv8RQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ebba0tf62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 13:21:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ODKxE3009281;
	Sun, 24 May 2026 13:20:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ahgq6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 13:20:59 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64ODKx6x009265;
	Sun, 24 May 2026 13:20:59 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64ODKx9X009261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 13:20:59 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 7F89021CFC; Sun, 24 May 2026 18:50:58 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v3 2/2] RISC-V: KVM: AIA: Make HGEI number management fully per-CPU
Date: Sun, 24 May 2026 18:50:57 +0530
Message-ID: <20260524132057.2425034-3-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524132057.2425034-1-anup.patel@oss.qualcomm.com>
References: <20260524132057.2425034-1-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: bnmTaGUR6yG9VfV1YibQOTzTa5IAgFYE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEzNSBTYWx0ZWRfX4+jrG67ilBiX
 TVzNUflng9tavOiH19DCmmF3UBPY2DfbugVuC2zQ0mzHNOa2UKzthbfCeIoaXHZXvdjKUhhDeeD
 bvYKiNADcDlK/uSbKt/dyhBhNxKzTOzcf3L66EhBwdF/pSZgts51I/8IB1bBgh2mXWMPRdswGNX
 GDdfEKyvZYMbR2E8wXqQQoMFPJ72DXbxk9unw286s2sR1n8nVREBn11osejrR8i+K71nSl43gL2
 LeL4T1dfVDacaR1smn2NEJ/Xlc3NvaULDwpiB8W6IBchDMpCcCMY1eqS/brzSGX6vruhUNpxgSR
 KzzD03s0C7Yi2UmhKeXsPIG4bkH4Twz6y4+4QNeApATff96Ue8R47ekUtS6ygotO/avdNL+EjpN
 2lk1qXEi/oThCXYjrpvAsBNncjv81FGMOapLxfqGHoSROex8D0CogoMdi/OAGJEZWNZrU0jM2la
 mNPAWkr2bbMevj3kW2Q==
X-Proofpoint-GUID: bnmTaGUR6yG9VfV1YibQOTzTa5IAgFYE
X-Authority-Analysis: v=2.4 cv=Xca5Co55 c=1 sm=1 tr=0 ts=6a12fb3e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2MwdZdDoDz0fOsLNy3oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240135

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Previously, the number of Hypervisor Guest External Interrupt (HGEI)
lines was stored in a single global variable `kvm_riscv_aia_nr_hgei`
and assumed to be the same for all HARTs. This assumption does not
hold on heterogeneous RISC-V SoCs where different cores may expose
different HGEIE CSR widths.

Introduce `nr_hgei` field into the per-CPU `struct aia_hgei_control`
and probe the actual supported HGEI count for the current HART in
`kvm_riscv_aia_enable()` using the standard RISC-V CSR probe technique:

    csr_write(CSR_HGEIE, -1UL);
    nr = fls_long(csr_read(CSR_HGEIE));
    if (nr)
        nr--;

All HGEI allocation, free and disable paths (`kvm_riscv_aia_free_hgei()`,
`kvm_riscv_aia_disable()`, etc.) now use the per-CPU value instead of
the global one.

The global `kvm_riscv_aia_nr_hgei` now represents the minimum number
of HGEI lines across HARTs and can be used to check whether HGEI
support is available or not.

This makes KVM AIA robust on big.LITTLE-style asymmetric platforms.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/aia.c | 67 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 5ec503288555..c289d8999aaf 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -23,6 +23,7 @@ struct aia_hgei_control {
 	raw_spinlock_t lock;
 	unsigned long free_bitmap;
 	struct kvm_vcpu *owners[BITS_PER_LONG];
+	unsigned int nr_hgei;
 };
 static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
 static int hgei_parent_irq;
@@ -452,7 +453,7 @@ void kvm_riscv_aia_free_hgei(int cpu, int hgei)
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-	if (hgei > 0 && hgei <= kvm_riscv_aia_nr_hgei) {
+	if (hgei > 0 && hgei <= hgctrl->nr_hgei) {
 		if (!(hgctrl->free_bitmap & BIT(hgei))) {
 			hgctrl->free_bitmap |= BIT(hgei);
 			hgctrl->owners[hgei] = NULL;
@@ -486,21 +487,8 @@ static irqreturn_t hgei_interrupt(int irq, void *dev_id)
 
 static int aia_hgei_init(void)
 {
-	int cpu, rc;
+	int rc;
 	struct irq_domain *domain;
-	struct aia_hgei_control *hgctrl;
-
-	/* Initialize per-CPU guest external interrupt line management */
-	for_each_possible_cpu(cpu) {
-		hgctrl = per_cpu_ptr(&aia_hgei, cpu);
-		raw_spin_lock_init(&hgctrl->lock);
-		if (kvm_riscv_aia_nr_hgei) {
-			hgctrl->free_bitmap =
-				BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
-			hgctrl->free_bitmap &= ~BIT(0);
-		} else
-			hgctrl->free_bitmap = 0;
-	}
 
 	/* Skip SGEI interrupt setup for zero guest external interrupts */
 	if (!kvm_riscv_aia_nr_hgei)
@@ -545,9 +533,48 @@ static void aia_hgei_exit(void)
 
 void kvm_riscv_aia_enable(void)
 {
+	const struct imsic_global_config *gc;
+	const struct imsic_local_config *lc;
+	struct aia_hgei_control *hgctrl;
+
 	if (!kvm_riscv_aia_available())
 		return;
 
+	gc = imsic_get_global_config();
+	lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
+	hgctrl = this_cpu_ptr(&aia_hgei);
+
+	/* Figure-out number of bits in HGEIE */
+	csr_write(CSR_HGEIE, -1UL);
+	hgctrl->nr_hgei = fls_long(csr_read(CSR_HGEIE));
+	csr_write(CSR_HGEIE, 0);
+	if (hgctrl->nr_hgei)
+		hgctrl->nr_hgei--;
+
+	/*
+	 * Number of usable per-HART HGEI lines should be minimum of
+	 * per-HART IMSIC guest files and number of bits in HGEIE.
+	 */
+	if (lc)
+		hgctrl->nr_hgei = min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
+	else
+		hgctrl->nr_hgei = 0;
+
+	/*
+	 * The global number of usable HGEI lines should be minimum
+	 * across all HARTs.
+	 */
+	kvm_riscv_aia_nr_hgei = min(kvm_riscv_aia_nr_hgei, hgctrl->nr_hgei);
+
+	if (hgctrl->nr_hgei) {
+		hgctrl->free_bitmap = BIT(hgctrl->nr_hgei + 1) - 1;
+		hgctrl->free_bitmap &= ~BIT(0);
+	} else {
+		hgctrl->free_bitmap = 0;
+	}
+
+	raw_spin_lock_init(&hgctrl->lock);
+
 	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 	csr_write(CSR_HVIPRIO1, 0x0);
 	csr_write(CSR_HVIPRIO2, 0x0);
@@ -588,7 +615,7 @@ void kvm_riscv_aia_disable(void)
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-	for (i = 0; i <= kvm_riscv_aia_nr_hgei; i++) {
+	for (i = 0; i <= hgctrl->nr_hgei; i++) {
 		vcpu = hgctrl->owners[i];
 		if (!vcpu)
 			continue;
@@ -634,14 +661,8 @@ int kvm_riscv_aia_init(void)
 	csr_write(CSR_HGEIE, 0);
 	if (kvm_riscv_aia_nr_hgei)
 		kvm_riscv_aia_nr_hgei--;
-
-	/*
-	 * Number of usable HGEI lines should be minimum of per-HART
-	 * IMSIC guest files and number of bits in HGEIE
-	 */
 	if (gc)
-		kvm_riscv_aia_nr_hgei = min((ulong)kvm_riscv_aia_nr_hgei,
-					    gc->nr_guest_files);
+		kvm_riscv_aia_nr_hgei = min(kvm_riscv_aia_nr_hgei, gc->nr_guest_files);
 	else
 		kvm_riscv_aia_nr_hgei = 0;
 
-- 
2.43.0

