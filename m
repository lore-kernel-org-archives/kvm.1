Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255484;
	b=SYbmGlkoSnPoEs0iMl7oDsml+Lr7WM7C8PA6zW6gPEbTGE+lXL4TXrkIUnKFAw07nAQL
	 yKDQfO8Xb6WU5DFx37e6NPYwfEu3f1u23l5Hbzfe96qAnrFexbXNR2KLKlwmBJmlaXhtI
	 Tvdl0QWyChR0BTV8sg3o/opzI7twbVWV5by4s+zVC/sFXb7CLUuMfsUtAgLPN5laBfCNP
	 vJEAL7/OEKrN8Gl18kvKxLdF+lBUPIhp0IKYKNYEyJrOQ6t3Jt1oHT8xkni3aCTi8iNj7
	 wZzRbPxc8V1GhUC1zjw9EYXNed7LAmeAtZATZKtZ22896dS9AnnNU2HqUJ4unq4aPUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255484;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc;
	bh=VY/qAy9cll2vTy1Z2Onm0tUCAye6cR6i95nFujBRmFY=;
	b=mdElyFONCZzPNqUaHSzIxphDQOKShJSd8MjA5gPRZIJW2SzzyQePQIaZDI+deShMRDba
	 ZKSwgqisM+nsFcfyvn5knCZk7q3CPvjQVBW/IWLYe7eWfDsXOZ4i3JqEGV003cF4KjswB
	 etpbUer6Zagh/Ml/aRulclP/omxZ2bT/oYUvGwTI9fa+ACfdAzyLHcbnQorl9hnT6sYUl
	 +3CqcXMpVI/xTx9UU4NMiKx96ueSJMJhDKq8UXldjPmN0DElnW8WtTt047xKwkcSRlqaG
	 ytjrqpC+mbwBCjhTX90NdgwUMNxFRQlRmsSWpkbpPGxVxVa2IucPZ0WmlHLkVsQPVXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=A4RJ2ou7;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6E606A31A;
	Thu, 29 Oct 2026 06:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=A4RJ2ou7
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SMufF73836061;
	Thu, 29 Oct 2026 06:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VY/qAy9cll2vTy1Z2Onm0tUCAye6c
	R6i95nFujBRmFY=; b=A4RJ2ou7waegB8dg/4b8jnXzyNW4iKIHWeZlP8BEtPOfG
	Wi/l0jKJNv86eJiE5FBnhJPJ0dkS+3XNyMpaw5B5vg/iPPmDMYECRzcJLbFw9xf1
	iFh7Nhosrs5OeywJDb6wkmYCUlGseHVMJpRkAVpsYtQZiPuMnodRg22qtR4r8yQy
	sq+IhPmT3CtS1hpXI1xcF/QNPfNkCALCLJT50G/ht1IY2aumYaXVSNO6+8tOInQE
	nkVxtkf2fYonDGGFAN7kZSwpdLXl+tmJ/FS+VjGvVhapFKRjFUQnSHp0QJfhtGc5
	zNaNtvlOGnXAky8H+fC9b0nklIxbrMGQ8EO6+krKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgm9rq2fm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 06:31:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69T61l463382366;
	Thu, 29 Oct 2026 06:31:13 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hm0gy8wc1-1;
	Thu, 29 Oct 2026 06:31:13 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org, kvm@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/1] x86/irq/i8259: Ack PIC vectors in the LAPIC ISR
Date: Thu, 29 Oct 2026 06:31:12 +0000
Message-ID: <20261029063112.203893-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
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
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610190000 definitions=main-2610290024
X-Proofpoint-ORIG-GUID: nYRXlyhwsUAlAN7F7Vevu25L2gHsdQsw
X-Authority-Analysis: v=2.4 cv=a+ilZkSF c=1 sm=1 tr=0 ts=6ae2e832 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=sHfnLyJkDqVpU-nex0sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX1BHjBuuZs29Y
 4M8wwA1HUC/TfRaziBmvUmvHVTsqgbXjBWhurJPxtepK9Yq6NDnYumHXG2M9Dt+4c0Z6kdiIAbV
 wxt6e0lSvFBZ3zL3DMVdtd+ReDVoPZPlGQfYNJ94dbMjFvX4aN+s
X-Proofpoint-GUID: nYRXlyhwsUAlAN7F7Vevu25L2gHsdQsw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXyqz3pj7Klab4
 aMFN035IuBaYquslnd5igkg6VkArjGY6ObiYmmfbKuX+uDi5Uibx9jHN+FyGvksKCCA+isiYz1/
 bgsC5aQodJ8KDaw44AhoKOvIaFybjYh3qtkSjNjRZyOsrvNU+BqijUDj1dtHJcvI5tEq65SdAMV
 NvTLVaCbCNz7uSQ41u3xEUk0iQvbUlBjilw7pv0KWFDnPoi64qOktHnHBPOnsbp7dmZP8ReZNal
 kGoaOAQH03Jhyd2L4ef0Ctr3LSpSxQmQe8uFNc06+uxbV9/GbZ33ulFXR5wv0jFQMyCv29xTgZy
 o34fvqpOLXkga5G7zt/yJsvwNr2Pbw277ueLhM/rf+bOQIIExnmM8mSQTGVeMWcKVAKZos2y6hU
 jrjHfCwlTXScwShsiNtU7PTnvoO+v4l/9oLCYlQSqZsiF4wFdDQkyWrG/JhYZ6a4SfSKG2PJxwj
 V4WqY6BshZ66/j6lvrA==

This is to fix a LAPIC ISR stall that can happen in a kdump kernel, but can
also happen in other scenarios.

The issue can be intermittently reproduced in a QEMU/KVM guest when there
are large number of VMs on the same host.

Device interrupts can use the PIC, IOAPIC, or MSI-X. Nowadays, most x86
device interrupts use MSI-X or the IOAPIC. However, the PIC handler does
not send a LAPIC EOI, even when the interrupt it handles has set a bit in
the LAPIC ISR.

For example, suppose there is a QEMU/KVM guest using virtio-net.

1. virtio-net is about to deliver vector 52 to CPU 2 (APIC ID 2), but the
guest suddenly panics on that CPU.

2. The kdump kernel boots on APIC ID 2, which becomes CPU 0 in the new
kernel.

3. Suppose delivery of the interrupt is delayed, so vector 52 has not
reached the CPU yet.

4. On the new CPU 0, init_ISA_irqs() initially sets up the legacy IRQs to
use the PIC. Vector 52 maps to IRQ4, which is normally used by the serial
console.

5. Before these legacy IRQs are handed over to the IOAPIC, suppose the
delayed vector 52 arrives through the LAPIC and sets its ISR bit.

6. The new kernel handles it as PIC IRQ4. Since mask_and_ack_8259A()
does not send a LAPIC EOI, the ISR bit for vector 52 remains set.

The below is an example when vector is 55.

(qemu) info lapic 2
dumping local APIC state for CPU 2

LVT0	 0x00010700 active-hi edge  masked                      ExtINT (vec 0)
LVT1	 0x00000400 active-hi edge                              NMI
LVTPC	 0x00000400 active-hi edge                              NMI
LVTERR	 0x000000fe active-hi edge                              Fixed  (vec 254)
LVTTHMR	 0x00010000 active-hi edge  masked                      Fixed  (vec 0)
LVTT	 0x000400ec active-hi edge                 tsc-deadline Fixed  (vec 236)
Timer	 DCR=0x0 (divide by 2) initial_count = 0 current_count = 0
SPIV	 0x000001ff APIC enabled, focus=off, spurious vec 255
ICR	 0x000c0400 physical edge de-assert all
ICR2	 0x00000000
ESR	 0x00000000
ISR	 55
IRR	 37 38 39 40 48 56

APR 0x00 TPR 0x10 DFR 0x0f LDR 0x00 PPR 0x30

This is painful when it happens in production. The kdump kernel stalls, so
we cannot collect a vmcore for analysis.

The issue is easier to reproduce with a customized KVM host kernel that
allows arbitrary vectors to be injected through debugfs and
kvm_apic_set_irq(). I can stall the guest kernel by injecting vector 50
into vCPU 0, even after the guest has booted successfully. Vector 50 maps
to IRQ2, the cascade interrupt between the two 8259A chips. IRQ2 is not
taken over by the IOAPIC.

For other vectors, I can reproduce the issue by adding mdelay() at the
beginning of setup_IO_APIC() and injecting the vectors during the delay
through the modified KVM host kernel.

In theory, a normal kexec reboot may also hit this issue if device
interrupts arrive late.

Fix this by checking the LAPIC ISR bit corresponding to the PIC vector and
sending a LAPIC EOI only if it is set. Cover both normal and auto-EOI
modes.

Assisted-by: OpenAI Codex
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kernel/i8259.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index f7a86b94a0dd..73939edb8c2b 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -144,6 +144,16 @@ static inline int i8259A_irq_real(unsigned int irq)
 	return value;
 }
 
+static void apic_eoi_8259A(unsigned int irq)
+{
+	unsigned int vector = ISA_IRQ_VECTOR(irq);
+	u32 isr;
+
+	isr = apic_read(APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(vector));
+	if (isr & BIT(APIC_VECTOR_TO_BIT_NUMBER(vector)))
+		apic_eoi();
+}
+
 /*
  * Careful! The 8259A is a fragile beast, it pretty
  * much _has_ to be done exactly like this (mask it
@@ -190,6 +200,9 @@ static void mask_and_ack_8259A(struct irq_data *data)
 		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+
+	apic_eoi_8259A(irq);
+
 	return;
 
 spurious_8259A_irq:
@@ -224,6 +237,12 @@ static void mask_and_ack_8259A(struct irq_data *data)
 	}
 }
 
+static void mask_and_ack_8259A_auto(struct irq_data *data)
+{
+	disable_8259A_irq(data);
+	apic_eoi_8259A(data->irq);
+}
+
 struct irq_chip i8259A_chip = {
 	.name		= "XT-PIC",
 	.irq_mask	= disable_8259A_irq,
@@ -386,7 +405,7 @@ static void init_8259A(int auto_eoi)
 		 * In AEOI mode we just have to mask the interrupt
 		 * when acking.
 		 */
-		i8259A_chip.irq_mask_ack = disable_8259A_irq;
+		i8259A_chip.irq_mask_ack = mask_and_ack_8259A_auto;
 	else
 		i8259A_chip.irq_mask_ack = mask_and_ack_8259A;
 
-- 
2.43.7

