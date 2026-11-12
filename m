Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503227;
	b=JqKqw+KqXAnfmu+JQxHe35Xq28fCwQje5Xz+uQDShcXGsmhEe3NhiujT3plw7eNRQTid
	 skuRr9CUkdkR6upHXEiWHsSnNfX+J8Mh7AKNoLtysM+A5Me1IDZjJ1twxmzjIJeoUc4Km
	 3ROgFkSUA5YyCoUmtUXW3b2K2MehIOdUc+HCBslX8gB5X3F5jiaKjBJ5ARwYLGl7x89Q8
	 +7Xm5+XFV7LUj/mNOTqWRL7dZvvHiZ8GlCimMN0TIe8V+oD0GHKib2gUk+0noAfG0vrmF
	 jKz26Sd/KBYRYKsAwu52FQGzHYvGTzeIIYqT4PcAZizKZtxTL5hsEfYTpH5bwHWjwvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503227;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info;
	bh=lLJ36rSMdNFze5jl4LOnhfR78kjXJTUSd1d+vQWrrJQ=;
	b=0GyemJI9uVBx4XyXn8xKk2VQQFUSN2Sm3c/mhyvcnhFIB1MmxMoJL+6KaRIvZsaY9g5s
	 h56wDli8bLdV+cNiPwsZjBE/qxbzd9l2ByWazbwtDwkoekZYRKsUXW/h6MUxRKaGy/wze
	 S1cEMGVWnWhelOavKM2RnDTg94oOj481+oWAYvN8EIYGPHrS6LXh4/IbXWmvf3ZSdsnnG
	 cxXpAnU8wQpt7ZZKjluxw2SoCHAA2xil2Wc7FMyEGpLHPiGMwE89dbqX2GJ3k0Yv2v1MQ
	 TiUWH731C17K8wayHKMr8rje7Dx9jajtUeyqa2/mU03aFP2dtJE6O6YbPsdaXA+jb5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=c0dJhObN;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB2606A327;
	Thu, 12 Nov 2026 17:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AEB2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=c0dJhObN
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACENMER1230998;
	Thu, 12 Nov 2026 17:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=lLJ36rSMdNFze5jl4LOnhfR78kjXJ
	TUSd1d+vQWrrJQ=; b=c0dJhObNjYv7M2/azQ8AvraFa4PITdLFMeo7czklfDG53
	c3W15o/n5HuKY1zAHGjw2rZne+cW1jphLyzP2QHuy4AZ+KdlCgJAQJCTcmIK25pT
	gTI46uH5pr0xX0G4T0xNGkBBzAaYACBA74PUQZMJCLRsSIu71u6HpGWYbQV+HSUC
	98ZJwx9uuJaPpZymqGOBkg1lMN2xI9cldotn5fn10eLY2gdzNVy18yecAGsvvA5O
	9t6IDyMBqs4pDNRO1j6KkFiE3sSQ7nPb/NHqshQQLsYv1lhgx5b3CvyjCtTz1WE5
	zM1+Z8sL1D3W/ku9OS7wE33bk4msMEU/fhkVgBMgg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsts1qtkh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 17:06:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACGvTpR3774706;
	Thu, 12 Nov 2026 17:06:51 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hwew50bwk-1;
	Thu, 12 Nov 2026 17:06:51 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org, kvm@vger.kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/1] x86/irq/i8259: Ack PIC vectors in the LAPIC ISR
Date: Thu, 12 Nov 2026 17:06:04 +0000
Message-ID: <20261112170604.1971438-1-dongli.zhang@oracle.com>
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
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=941 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611120067
X-Authority-Analysis: v=2.4 cv=YPYKWhGx c=1 sm=1 tr=0 ts=6af5f22c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JW85imeA6ZLr9y5tCYAA:9
X-Proofpoint-GUID: maoDPFY154l4ucuzSvJvV7wd2r8pkZUW
X-Proofpoint-ORIG-GUID: maoDPFY154l4ucuzSvJvV7wd2r8pkZUW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NyBTYWx0ZWRfX1WPL+6tSDHq+
 ryR9oHVb32Xj0aXIsvWXwqefo+ME1GXuKDBKrBPjT15sJPYNbtIrZiZ7yL7z8WIQoGCMsu3zqM2
 yTNQpe0F1ROJoVPBp+pU13YpgUfTKYs87hM0G/CkjyvLlzVphH2o2srRAaOlVk+K7wZTBVxeRkT
 d618O4euZGxp9uQe4VFk/peygBFGlLWSU/vM46HmK9Xj9Is9wXQ2evKB3kcs+AJd+NzO4+KtA1B
 cOAHI9KZ3Mwy8D+/+Iqs8zEv+5c5UVTP1pUMlDp3u6ippU+zrk9f0m7CAlBI1oq/O5LmXSd3aGT
 X7ahaB5mNY2P7HteBr0UYL0ineY1y/8seYc38w9p0wGD2K96NIJRLrr8MozaGMn1gmG/0VcLPGh
 JwJWoM2pSeyMLgeUMXl2xkRtsthLxBlUp9nkl9wnQadwJSrrqVISha/sqYTbV23N6m5CUARNsW5
 mmAQpUcU0tbouw6QvKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NyBTYWx0ZWRfX8PxDd5wGnPEk
 M1iODFsZdIsqyHAT1fFA8NDsbpKEHdEmNC1GRdoMlCtSsdiuQyxPVd5PZYl21UUi8u4KsSxCcPr
 1yl+WrVEONQuqr/cwTA7Mo7C2+OgL2CKYLiSVBR4olh7QyBNhoDF

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

Send an EOI only when the LAPIC is ready. Use a per-CPU flag to track
readiness across initialization, disable, and resume.

Assisted-by: OpenAI Codex
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
v1: https://lore.kernel.org/all/20261029063112.203893-1-dongli.zhang@oracle.com

v1->v2:
  - Mark the patch as RFC, as the APIC readiness and disable paths need
    further review (I tried my best).
  - Introduce a per-CPU flag to track APIC readiness to fix issue
    mentioned by Sashiko for v1.

Reproducer:
https://lore.kernel.org/all/e4070a8b-fa4d-4ba1-a333-e7cf72da416e@oracle.com

Suggestions for improving the readiness checks or alternative solutions are
welcome.

 arch/x86/include/asm/apic.h |  3 +++
 arch/x86/kernel/apic/apic.c | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/i8259.c     | 11 ++++++++++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9cd493d467d4..13406e79185a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -123,6 +123,8 @@ static inline bool apic_is_x2apic_enabled(void)
 
 extern void enable_IR_x2apic(void);
 
+void apic_eoi_cond(unsigned int vector);
+
 extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
@@ -181,6 +183,7 @@ extern void topology_init_possible_cpus(void);
 extern void topology_reset_possible_cpus_up(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
+static inline void apic_eoi_cond(unsigned int vector) { }
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
 static inline void init_apic_mappings(void) { }
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 90025451ace2..60347bf17abe 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -91,6 +91,20 @@ static bool virt_ext_dest_id __ro_after_init;
 /* For parallel bootup. */
 unsigned long apic_mmio_base __ro_after_init;
 
+static DEFINE_PER_CPU(bool, lapic_eoi_ready);
+
+void apic_eoi_cond(unsigned int vector)
+{
+	u32 isr;
+
+	if (!this_cpu_read(lapic_eoi_ready))
+		return;
+
+	isr = apic_read(APIC_ISR + APIC_VECTOR_TO_REG_OFFSET(vector));
+	if (isr & BIT(APIC_VECTOR_TO_BIT_NUMBER(vector)))
+		apic_eoi();
+}
+
 static inline bool apic_accessible(void)
 {
 	return x2apic_mode || apic_mmio_base;
@@ -1164,6 +1178,8 @@ void apic_soft_disable(void)
 {
 	u32 value;
 
+	this_cpu_write(lapic_eoi_ready, false);
+
 	clear_local_APIC();
 
 	/* Soft disable APIC (implies clearing of registers for 82489DX!). */
@@ -1509,6 +1525,7 @@ static void apic_clear_isr(void)
 static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
+	unsigned long flags;
 	unsigned int value;
 
 	if (apic_is_disabled) {
@@ -1557,7 +1574,15 @@ static void setup_local_APIC(void)
 	value |= 0x10;
 	apic_write(APIC_TASKPRI, value);
 
+	/*
+	 * Keep interrupts disabled across ISR cleanup and readiness setup
+	 * to prevent races with apic_eoi_cond() in legacy interrupt
+	 * handlers.
+	 */
+	local_irq_save(flags);
 	apic_clear_isr();
+	this_cpu_write(lapic_eoi_ready, apic != &apic_noop);
+	local_irq_restore(flags);
 
 	/*
 	 * Now that we are all set up, enable the APIC
@@ -2513,6 +2538,7 @@ static void lapic_resume(void *data)
 
 	irq_remapping_reenable(x2apic_mode);
 
+	this_cpu_write(lapic_eoi_ready, apic != &apic_noop);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index f7a86b94a0dd..78c6d90e9765 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -190,6 +190,9 @@ static void mask_and_ack_8259A(struct irq_data *data)
 		outb(0x60+irq, PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
 	raw_spin_unlock_irqrestore(&i8259A_lock, flags);
+
+	apic_eoi_cond(ISA_IRQ_VECTOR(irq));
+
 	return;
 
 spurious_8259A_irq:
@@ -224,6 +227,12 @@ static void mask_and_ack_8259A(struct irq_data *data)
 	}
 }
 
+static void mask_and_ack_8259A_auto(struct irq_data *data)
+{
+	disable_8259A_irq(data);
+	apic_eoi_cond(ISA_IRQ_VECTOR(data->irq));
+}
+
 struct irq_chip i8259A_chip = {
 	.name		= "XT-PIC",
 	.irq_mask	= disable_8259A_irq,
@@ -386,7 +395,7 @@ static void init_8259A(int auto_eoi)
 		 * In AEOI mode we just have to mask the interrupt
 		 * when acking.
 		 */
-		i8259A_chip.irq_mask_ack = disable_8259A_irq;
+		i8259A_chip.irq_mask_ack = mask_and_ack_8259A_auto;
 	else
 		i8259A_chip.irq_mask_ack = mask_and_ack_8259A;
 
-- 
2.43.7

