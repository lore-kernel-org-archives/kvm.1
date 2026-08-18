Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E93227BB9
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787096848; cv=none; b=bfNmty4oSO2izJa+opSnlaJa/sa7jsSRSpU2slSx1ohr7Nrjo+8Bfo1Dbv8S4w5AWHJtRLk48Xakr52SV99PlGh5nC8XRiihMkkzpKQ+GO3tIY0Ia/jCCS3N7N5svsMmxNGEnwF2GcCZ7h8Ykj/M3/RM5C2FJotwMAyVTRLYChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787096848; c=relaxed/simple;
	bh=oJcY4AMtJM2VDrkR78a8Tbzs/OAvTX+rFI2b8I49ZbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yfxp2wq/xlDfWnc/JBeUR0y7T8bRCDOBJGcCHBJPa2ZY5okpVk1U/gauB+OynfBC7seCUW4QwX5hX94in2R7aw/ZH+DxnK5chsSM/a3V11mYcH80xRStHgWJeWa6HzHckulbLAUQUfnRV/nH5WwuPprA9O4nnz7Scf9HXAL1aA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MBDbeSbC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBDbeSbC"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ILWw4X223982;
	Tue, 18 Aug 2026 23:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xPXES4/JQmuZeMgErC18jyHYBsIKT
	hfnzU7QZAiVXTw=; b=MBDbeSbCiFXA31lrKxBZJoAsSY0n/virt6QX55xAiqCHY
	VBvrUIRgeK433cC5FqIL/Rb/Wl1RM0w64vGb01OBpqYc9pROY0l8vXD1bPDI7tNN
	4Eg6poB8aPFkc3m/PWvvTXHQUJkrrU7fmQMewvg9BNTcMLi6/+e+K+F74g21iDoX
	4sD4rsqtbLmpTFS+PxwhcrPmCq4Fn4SW7aWX2wAX0ARwLc0Kz8OrjwuoLrP5xRlT
	wDNRoGcLpgLcbIqkqBvqofTF5/Q8TqjbKohAL6YY21eKdLQtYig+IYOL0fqMKifX
	xtch8YIztieXwoF6HkEKl+qwwj2zPw8qN7dcyupQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4ydgg4b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 23:47:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67INjexX014196;
	Tue, 18 Aug 2026 23:47:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejd64qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 23:47:22 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67INkDZj016602;
	Tue, 18 Aug 2026 23:47:22 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4g2ejd64q4-1;
	Tue, 18 Aug 2026 23:47:22 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, joe.jin@oracle.com
Subject: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID together
Date: Tue, 18 Aug 2026 16:42:38 -0700
Message-ID: <20260818234238.618158-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608180175
X-Proofpoint-ORIG-GUID: BpuUKP-F7r5oSuW9ZE9Q5ypGvbJwg0pn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE3NSBTYWx0ZWRfX90TveYz/3D1D
 nAIqlTsYnpVRnZyEy7iIEx53Amwh+hdmLdihH1CM1dgRByCEzMJWJdWqzK5FbjggeAO0D8udYgV
 Sp2TAdRy00/G2+xzwYgAtaEGPOpqdjfUV7QhZ66X2O+kaajD9VjkYW/x9SsWXaOCeT9DVeYKbXa
 TGy3wgXNg429fBwn/GckZBp2b4DeK5F3LCTX57ATQ7IT4sspEpsKkKQ3PVxeAOUQeoy4Vr6kN+h
 EBcHs7JtDx9aeXQFbaHc1khXErPhxwIETzQPcTUYh0djpcTCZV8KYH2aVx3qRwju9f8+KHRRYgd
 m24PzHEeIrLpuq3tuh2wJdqgBOD5hxBfZB02T1Od9UM2KyEg81+DhJ52bIV4jFU05MZVc4HRr5r
 riS4xSW2PqkH9L14Lcg2xt9bjNymh9xNloXD83uTZhSfh9mzz8o+ZsB+J4BDVtbchuS/STbvIOF
 fx9te3qfq2OX4L9KHrg==
X-Proofpoint-GUID: BpuUKP-F7r5oSuW9ZE9Q5ypGvbJwg0pn
X-Authority-Analysis: v=2.4 cv=ZIDnX37b c=1 sm=1 tr=0 ts=6a84ef0b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=531kEbb1zGAHHU4UcwEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE3NSBTYWx0ZWRfX5KlRQRorDWFf
 Z+V/vEV58WG7lH873/Fn8EwFCcdzkAZCsOCo4vilRjASunGY5QMjrOPHG4RMh+gl22UAWAtKQ2o
 KosM4eTIwyMVujBurSndWYKVqY02mNzNoIhrWySwya/IWgApwe40

The commit b2849bec936b ("KVM: VMX: Update SVI during runtime APICv
activation") resolved the loss of EOI issue when apicv is activated after
being inhibited at runtime. However, it does not resolve the cause of the
runtime apicv inhibition.

The inhibition occurs because apic_base and the APIC ID are not updated
together.

Although commit 052c3b99cbc8 ("KVM: x86: Reinitialize xAPIC ID when
userspace forces x2APIC => xAPIC") reinitializes the xAPIC ID to the
vCPU ID when userspace forces the APIC to transition directly from x2APIC
to xAPIC mode, the updates are not performed in a single transaction.

If another thread calls kvm_recalculate_apic_map() during the window
between updating apic_base and the APIC ID, kvm_recalculate_phys_map() may
set xapic_id_mismatch and temporarily inhibit APICv.

       Thread A                        Thread B

__kvm_apic_set_base()

-> vcpu->arch.apic_base = value;
   (disable x2apic)
                              kvm_recalculate_apic_map()
                              -> kvm_recalculate_phys_map()
                                 *xapic_id_mismatch = true;

-> kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);


It is easier to reproduce without the commit 052c3b99cbc8 ("KVM: x86:
Reinitialize xAPIC ID when userspace forces x2APIC => xAPIC").

In the QEMU scenario, when a vCPU is removed, QEMU parks the KVM vCPU fd
and reuses it later. When the same vCPU fd is reused for another hot-add
operation, its x2APIC is still enabled. Once QEMU tries to disable x2APIC,
we may encounter the race windows described above.

Add conditional lock protection within __kvm_apic_set_base() so that
vcpu->arch.apic_base and the APIC ID are updated atomically. The same lock
is also used in kvm_recalculate_apic_map().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 arch/x86/kvm/lapic.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 48b019114c19..1d858c259ab8 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2793,17 +2793,29 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 {
 	u64 old_value = vcpu->arch.apic_base;
 	struct kvm_lapic *apic = vcpu->arch.apic;
+	u64 changed = old_value ^ value;
+	bool apicbase_enable_changed = changed & MSR_IA32_APICBASE_ENABLE;
+	bool x2apic_enable_changed = changed & X2APIC_ENABLE;
+	bool apic_mode_changed = apicbase_enable_changed || x2apic_enable_changed;
+	bool need_lock = apic && apic_mode_changed;
+
+	/*
+	 * Serialize apic_base and APIC ID updates with APIC map
+	 * recalculation.
+	 */
+	if (need_lock)
+		mutex_lock(&vcpu->kvm->arch.apic_map_lock);
 
 	vcpu->arch.apic_base = value;
 
-	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE)
+	if (apicbase_enable_changed)
 		vcpu->arch.cpuid_dynamic_bits_dirty = true;
 
 	if (!apic)
 		return;
 
 	/* update jump label if enable bit changes */
-	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE) {
+	if (apicbase_enable_changed) {
 		if (value & MSR_IA32_APICBASE_ENABLE) {
 			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
 			static_branch_slow_dec_deferred(&apic_hw_disabled);
@@ -2815,14 +2827,17 @@ static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 		}
 	}
 
-	if ((old_value ^ value) & X2APIC_ENABLE) {
+	if (x2apic_enable_changed) {
 		if (value & X2APIC_ENABLE)
 			kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
 		else if (value & MSR_IA32_APICBASE_ENABLE)
 			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
 	}
 
-	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)) {
+	if (need_lock)
+		mutex_unlock(&vcpu->kvm->arch.apic_map_lock);
+
+	if (apic_mode_changed) {
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 		kvm_x86_call(set_virtual_apic_mode)(vcpu);
 	}
-- 
2.43.5

