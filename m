Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664273;
	b=oUGrFjCm2SVZomMp/k6+ZQq8bEIYlbIKnZZMLUKnQP1dDW7wWWbEwxSd8+5RtsRZ62ui
	 f+aZu56Jm249yDJ2srXfQMMSkmEmoPxV+bwkjB1fLayyT+WHhRGkPnEnTiwehnlacCxmU
	 OZIxrD34SLjho2tZUCdhSSZMMDpOcHVkprkGIshICq8MkpH8U8/JeU+D/WH8B0i5hFNC2
	 3hIiE8YPcxaEBgp6keZs5Rg1tLhK8oE9UArZt4WRHlIO0UKgM4bEPy/IX52O5mBmfzXIS
	 tsX0cvs/9DAU0iXCw0owQRGHMKu1Oz/kuY6KjFuxDF97EiG1lESWG/JgIw5QYHNX0NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664273;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qqG2NJCc3JWi40GBILYwMhO94PZlOObFL01RUJTaOOg=;
	b=Hxx+tHcIBiiYm69EIc9p6/H0IHibjwWeILR0TCqW8bB9YRsVMiBZuGvEaDSZ2fy9Qcjx
	 trfh37hhwLgkNcY3JiOAbvhr7S5wfo5tC/OjdU+JsI41MgyH1b8bilo4F61TPEzFXceTh
	 R5VcPHcCxiM4Jn0L+Tnp8oNsAgiS82Vexlg8LZ+rgy+4Lo94DcJqcojO1EGMh07nYFbGs
	 9SJHOBv5j4QqrXhjxw8y0nEhJOZULolJh01wEa7blxo5j1bWlEil0J+C5rlm0ziH5XQmG
	 4AmNH7sjzQvh5AjslBS4B4W339YAfF5iGjmeRus++gq9LIuheycw+0BIdBqbU3cb2yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dvTk+BCl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E2606A323;
	Sat, 14 Nov 2026 13:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5E2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dvTk+BCl
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AEDk4x84114866;
	Sat, 14 Nov 2026 13:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qqG2NJCc3JWi40GBILYwMhO94PZlOObFL01
	RUJTaOOg=; b=dvTk+BClL+cnnkARh7sbqeGlV+Zbp3/rSkdLsBlVXcC0Rcr1M8u
	FU5wUay9SnIXcyZMr5wu8tgXeUiht1BzBtI7VJvjI2c4N1sjqIR+bHH/gZKTsnwV
	m/dReyVwLjdorbreiPECyoR62i/Z8fTxS0dFaxHSgxcpYF44uYcOXgvxrz1bQtH+
	GdeG0w6fZYGv0BNZcRQwRD5wMBpdpD2TZ07MpXzWVzDXaXMcRW6HWTg21zhrPTt7
	ynUrrE0juNO/YGqOkwX1HpDSiC/OlGQWV6ZzIeL/MsvO5klNGBTDUQgXhZMeXSKN
	BUB9hNJ4B1C9tQWHCdp9LhUDKCtoH87hI+Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjrx38-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 14 Nov 2026 13:51:02 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AEDoxKU2649580;
	Sat, 14 Nov 2026 13:50:59 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AEDoxe62649574
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 14 Nov 2026 13:50:59 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id B561F248E3; Sat, 14 Nov 2026 19:20:58 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Atish Patra <atish.patra@linux.dev>,
        Andrew Jones <andrew.jones@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anup Patel <anup@brainfault.org>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH] RISC-V: KVM: Convert IMSIC vsfile_lock to a raw spinlock
Date: Sat, 14 Nov 2026 19:20:56 +0530
Message-ID: <20261114135056.202556-1-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1NSBTYWx0ZWRfX9BAvxvMAehan
 IK1cbACB3iXuuEMfkX1Cjsrn85urvCZrgH6EjlDvX4GLMUHudgJTCJchwx2+RwZg4kxYd5bJC8H
 TY63RXKYEoxryKoQ6vkobwqTCtxavgDu0rfJW/aWK8J3q0kVMY6QgSSnRZJY2kyxLTgcMykBme0
 qpK1c6mGMyOlddfhTTirwfYVSvzpjZJMvAU4B2eqWd5L8Q4Afp9H5M1lc0Ud1umF6x96Ykibf2u
 aJ82UzpU2PTcUWZD1OgbWUCpeZxmXZ7VIy0RzeaFCvcapeCThooTKgy6gqT9RqGANWGvH0rR5u7
 QVslEKoA92nfi0JJL6YgteS3/mMvJdNv5Aq6LGu3WH8ClSUwnZdeLqZfxsQWRxwtEzohuyfLRrP
 Dy/BMcSEufnS2V1q5CMpM/G/8xIDQ1sA2ranD8ZD6j3edkDzxejNdofzLANAFkhRHelDrSwwT6i
 /64PuR+gVma2uk8lQvw==
X-Proofpoint-ORIG-GUID: ppqplaSz09GqRES1YyfPrhQeGEsw5BYC
X-Proofpoint-GUID: ppqplaSz09GqRES1YyfPrhQeGEsw5BYC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1NSBTYWx0ZWRfX+pxHc+D0Yn8A
 UTVNoyIScB+eQo60VTQSMqOKjeHiknhJ9B2002oB8ET4M8giNwRCPxQgaQPIe9vAmAuU87q3+oq
 xjKPE2ipyUuxZ76Di9GYlBir1g+fl4k=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af86746 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=wOdddZgVwB2pSmFxpusA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140055

The kvm_riscv_vcpu_aia_imsic_put() runs from the scheduler preemption
notifier with the raw runqueue lock held, so it must not take vsfile_lock,
an rwlock_t, which sleeps on PREEMPT_RT. All vsfile_lock critical sections
are short, so a raw spinlock is fine.

In addition, converting vsfile_lock to raw spinlock allows us to drop
the vsfile_hgei_lock and also allows us to use writel_relaxed() in
kvm_riscv_vcpu_aia_imsic_inject() since raw_spin_unlock() internally
does mmiowb_spin_unlock() which in-turn drains the write-buffer.

Co-developed-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Anup Patel <anup.patel@oss.qualcomm.com>
---
 arch/riscv/kvm/aia_imsic.c | 79 ++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 302938972aa0..0b9d15721d52 100644
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
 
@@ -606,7 +594,7 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 	 * only check for interrupt when IMSIC VS-file is being used.
 	 */
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 	if (imsic->vsfile_cpu > -1) {
 		/*
 		 * This function is typically called from kvm_vcpu_block() via
@@ -621,7 +609,7 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct kvm_vcpu *vcpu)
 		else
 			ret = !!(csr_read(CSR_HGEIP) & BIT(imsic->vsfile_hgei));
 	}
-	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+	raw_spin_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	return ret;
 }
@@ -646,10 +634,10 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vcpu)
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
@@ -663,13 +651,14 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
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
@@ -726,10 +715,10 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
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
@@ -779,11 +768,12 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
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
@@ -874,6 +864,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	struct imsic *imsic;
 	struct kvm_vcpu *vcpu;
 	int rc, vsfile_hgei, vsfile_cpu;
+	bool swfile_update = false;
 
 	if (!kvm_riscv_aia_initialized(kvm))
 		return -ENODEV;
@@ -893,7 +884,7 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 	}
 	isel = KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 
 	rc = 0;
 	vsfile_hgei = imsic->vsfile_hgei;
@@ -902,13 +893,16 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
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
@@ -959,6 +953,7 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	unsigned long flags;
 	struct imsic_mrif_eix *eix;
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	bool swfile_update = false;
 
 	/* We only emulate one IMSIC MMIO page for each Guest VCPU */
 	if (!imsic || !iid || guest_index ||
@@ -970,17 +965,26 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	if (imsic->nr_msis <= iid)
 		return -EINVAL;
 
-	read_lock_irqsave(&imsic->vsfile_lock, flags);
+	raw_spin_lock_irqsave(&imsic->vsfile_lock, flags);
 
 	if (imsic->vsfile_cpu >= 0) {
-		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
+		/*
+		 * We can use writel_relaxed() over here because the
+		 * raw_spin_unlock() below will do mmiowb_spin_unlock()
+		 * which in-turn drains the write-buffer ensuring the
+		 * write is visible to the CPU owning the IMSIC VS-file.
+		 */
+		writel_relaxed(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
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
@@ -1036,8 +1040,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 
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

