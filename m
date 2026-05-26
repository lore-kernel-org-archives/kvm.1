Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA1410D06;
	Tue, 26 May 2026 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817570; cv=none; b=QQWQAd56U/TQH+GtZKjdlX5JuYvZXUcER3owAKa4pXEyBJZKEBVmBCO4plZse1u8gGT0Fnc2DBhLDprjhjkz+HB3QnKr1P23inXoKFBgqcrWzviLCqnyxtvtjWw9X3TKIWbVjVRgk5yUi3T9W/SLo8OooWz3rfyKKeGeRjvnsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817570; c=relaxed/simple;
	bh=PdVtP6sssOJ3EIuVmfd7lk5qdcv/5nkj8OeuDeEt/FI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jzHlkAMRA/1WXzW5xdNZPm0l5EmO1aKWizTGdr0eOSBh6qjB1jNnr6wJWzqSoQ2Q0QvDmTv/vLPE3zEZ6Ya8uLskd77YDC8vbaM/wLChK7DtVowgOEbwPMWkqnubqAgdnGpOyFDwTgkM9cArEoZhLrU5rqhkxAEZ/G0CGddzXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LNlMJsmS; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LNlMJsmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779817562; bh=PyHP5PNdEGsrCQrHfMIuujp0ZFajIH+PxtUvpO2gIi0=;
	h=From:To:Cc:Subject:Date;
	b=LNlMJsmSvXJ1QIps+fGEVJByUugUWbF6+C77NsBBeqqz4kUueaa11WdvIizzuKoPe
	 XSuaY56i5S1BEsQaL8RAIyxoWPZXlouya0FUaa7RbrhqUDtF5wJFXb7MNdaasxzM/C
	 05AItxvgin4FfUM+g1SX1MOSWyiK3Ek91xKTKgK0=
Received: from localhost.localdomain ([101.6.30.191])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id B338346E; Wed, 27 May 2026 01:44:51 +0800
X-QQ-mid: xmsmtpt1779817491tcv3lxi29
Message-ID: <tencent_744B87186CA59CFD106992329A6510F7F60A@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3N6T8rBpCruW5btiixb4YHieciEvawUsMESFo13m08n+Dz8g6gzt
	 msVc44bMBuksxWjK2ySX7prw+7Rpmcho9lTWo9t4MAxI2TIDZne4GGvqTDa44N0rAS/NuRMpInoT
	 sOip9lurkikG2rnl50zU1c3C993p8bA5wW/x2J0jFz13+XFAC1/2cyXGLFmFbfAim5vR4WJQwk+5
	 CY99Y5dTYu9pssmgES4pRThunWj7z/uqvJDNfJLsiEFACMFTx0aVhE2KJVkq88bBW2KwBD2/1KyQ
	 FjwneNB+Bc01w5gpZ9RPVMWLu+07X/eRJUHVmKnj9MC7KSLcAaCEk1mTpsDi/lnX3dxgOUE0I7rX
	 ZmPEZMEbhkYFmtrqtP2j4HjSmesrdqyJhalaxK74/yp4iePpKkkTCnW3dHemJSDaBAZcCyY3tSYW
	 46uYPkZHGV9JGHfDFeP7HGM2AZcNIKKB3bBCKWiRFvMvzW6ufNY8JU7ZfoeWibKlxmbhhBe/8ONM
	 yPMeknKkrnCNkCkyPFRibz3xRm5hUQUG0GLisWOigFzWs9Sy4EkvIs0E/kNW4Fy4M8ejXagcprVB
	 Mtegyr14vwcNFjKHXbKuD3I6VqQtVoOLjtc4SEUwwJmvbHyEyFUMNmCN2sjPpBXb1Y9gz+vRFweu
	 CLDif1yuuFKfH4i1A7G+dM8fwnUn4B7WqxsB3FPSmOzTQ1KO1S/YcRfOqHwYqLdnqRZx0ak7X1f+
	 vQpfj5tm2G1A6rbcG58JDX6QM5EIChQM1Cz7Opcm2Uh9km5Wj+EubqzL3PD94ThAKDOt9Hrm1GaQ
	 9iklhFxIlSnz7LGalj7lGg22PEb5Z/NvzWhe0c141sW/vGuHgb9TrT9aL1inKwDN3LRSFGRAMLiV
	 z60C9+8t51c6VJIbuljzsPXSteURqGD79hLz4RSxYnxu/VI3WWZ2ds3Ko9Ze2xXWhD2zg3iFLpKe
	 akn/Ld4VDEkBIBqCC7cs49knovzJz9VP1xqwQIFm8+9bewTClk2yFQvrvjiGjH05w2/4EDkKYxgS
	 /cQYtyQ9OosvV3RSTa0QD2gyrNRLc=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: xuanqingshi <1356292400@qq.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqing Shi <1356292400@qq.com>
Subject: [PATCH] KVM: VMX: Use _safe MSR accessors in LBR handler
Date: Wed, 27 May 2026 01:44:49 +0800
X-OQ-MSGID: <20260526174449.957633-1-1356292400@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqing Shi <1356292400@qq.com>

intel_pmu_handle_lbr_msrs_access() uses rdmsrq()/wrmsrq() to directly
access LBR-related MSRs on the physical CPU. If the guest provides an
out-of-range or otherwise invalid MSR index, the unchecked access
triggers a #GP fault, resulting in an "unchecked MSR access error"
warning and a host crash when panic_on_warn is enabled.

The crash was observed in a nested virtualization setup where a
VMCS-targeted fuzzer triggered a WRMSR to MSR 0x1c8 (LBR_SELECT)
that propagated through the PMU emulation path to the physical host:

  unchecked MSR access error: WRMSR to 0x1c8
  (tried to write 0x0000000000004000)
  Call Trace:
   ? native_write_msr+0x4/0x30
   ? intel_pmu_handle_lbr_msrs_access+0xff/0x120 [kvm_intel]
   intel_pmu_set_msr+0x4e0/0x7f0 [kvm_intel]
   kvm_pmu_set_msr+0x17e/0x1c0 [kvm]
   kvm_set_msr_common+0xc76/0x1440 [kvm]
   vmx_set_msr+0x5e6/0x1570 [kvm_intel]
   kvm_emulate_wrmsr+0x54/0x1d0 [kvm]
   vmx_handle_exit+0x7fc/0x970 [kvm_intel]

Replace rdmsrq()/wrmsrq() with their _safe variants so that invalid
MSR accesses are caught gracefully and reported back to the guest as
errors instead of crashing the host.

Found by a VMCS-targeted fuzzer based on syzkaller.

Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
Signed-off-by: Xuanqing Shi <1356292400@qq.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..94d2cbffcff4 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -293,6 +293,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 {
 	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
 	u32 index = msr_info->index;
+	int err;
 
 	if (!intel_pmu_is_valid_lbr_msr(vcpu, index))
 		return false;
@@ -309,12 +310,12 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	local_irq_disable();
 	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
 		if (read)
-			rdmsrq(index, msr_info->data);
+			err = rdmsrq_safe(index, &msr_info->data);
 		else
-			wrmsrq(index, msr_info->data);
+			err = wrmsrq_safe(index, msr_info->data);
 		__set_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 		local_irq_enable();
-		return true;
+		return !err;
 	}
 	clear_bit(INTEL_PMC_IDX_FIXED_VLBR, vcpu_to_pmu(vcpu)->pmc_in_use);
 	local_irq_enable();
-- 
2.25.1

