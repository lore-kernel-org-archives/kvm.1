Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D1286405
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848780; cv=none; b=aIihZIifGxXXSZgoSsOv7W4x4SZ0809mzrNusO9eApsPVNvlLCh2WW+iYHTtcf6HDGPk2RGfCBvNkeQD2y0UnoIV52vo9zK2ziqvKm8v5aUFi9rWHdAW4T93QJbntG2YhXyAm/YaFLDwozT/mOCKmmsKLptQj0bDMuuYSwnkebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848780; c=relaxed/simple;
	bh=pDivmIK8UxDTWlWa+HKMxIp+Ev7qbg1GmF8UpU0b2qo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qf6KfsKidYXO5LJ9JY/StOZtehrEx33OzNrfaPfI+bN5SX10O+ZoL3XvR2ootskulmYtrhrc30RYCmEMiViohMgtPwkPcSOVi4+kYqkEUMNfa2oHBf+4ZzRLDCYinQZDLmYFsWpVz5Gnfp80Q0V6nFo4HucweR++JNCAZQ/7Jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azmNu9sY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azmNu9sY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6aeb3637so260613365ad.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779848778; x=1780453578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJGgy03uEutpauKs1fQ7bqRu089ezmKrTIOy21fn9cs=;
        b=azmNu9sYttVJucB5Q6y80GwCDdEs4srfeNromwEVTgL0037w+Fj/QUgXXmTET62hxu
         GJwzF0TwDcTZs8pLbhPt4fFb0EahQ4dykSWAtNulIDzBWMhC44/o3KkQq0A0X+zwrpF1
         9b9wMEpmtnpjf1iNjqugHZ9tViPVerVEFKdt8VHvWPvS/gSrNwptr79PpGc1yn4SwDTE
         bvTk4pyJ1G41BLyp23O3AUN1gllGuxw0gvyBwSpDr4Ztc1aAJEu0c5zor79iB/cXksLh
         loogcArx8LBF++lqQglnlDVz33puQ+fnWNn5SpW5MmbVGS3gR7c32SOGz9QGwigUMNbF
         IL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779848778; x=1780453578;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJGgy03uEutpauKs1fQ7bqRu089ezmKrTIOy21fn9cs=;
        b=ZNEpZjTskRfVMjRhqXY+KnYq/j9PM0NyqdsZxtaG5sY7XAyrXe7ts6wQKS7sWQpCuO
         lfbAdWCTZUbmA4Wu6sExV9da0vqrmlpJAmmTCWy6r0bv/LCPqHO98wmzm6kJ0L0lQzTz
         AKtwYnokRnuaEp1wUDpVV0h5d+kMgN2ajEHkM0MEhEh54rd/QbzV7Nhc9iqSwhKqkN53
         DU4NXzIy6MFArl18a2tEGOqKzVLSADJE664yFbaDMaGlm8UcCDqnvhS+++tod5I7mHC6
         rP4vezI3OJ/363MfFZH/OOPUbBmPJK5N/6myjMrgTqeB3sjOMpV/D4XgA9Sxc/RX7mpi
         k1Yg==
X-Gm-Message-State: AOJu0YwA1CM2bmzY0fX9hsax/SeROaG6MlR+U0dIYMyZ9b0ko9FgL/x1
	WxVtyf1H0bXLZCgxExMAPqYy2pEcJoTazFGYazMPTzUvUyUWrcg9inlv24UpUaTkVw3CUhRDtSG
	pZyFPQA==
X-Received: from pliq5.prod.google.com ([2002:a17:903:3905:b0:2bd:3dba:a4c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aae:b0:2b9:5d1b:73da
 with SMTP id d9443c01a7336-2beb0741079mr241708895ad.30.1779848778312; Tue, 26
 May 2026 19:26:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 May 2026 19:26:17 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527022617.3973884-1-seanjc@google.com>
Subject: [PATCH v2] KVM: VMX: Handle bad values on proxied writes to LBR MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuanqing Shi <1356292400@qq.com>
Content-Type: text/plain; charset="UTF-8"

From: Xuanqing Shi <1356292400@qq.com>

Use the "safe" WRMSR API when writing LBRs on behalf of the guest (or host
userspace), and propagate any errors back to the instigator, as the value
being written is untrusted.  E.g. if the guest (or host userspace) attempts
to set reserved bits in LBR_SELECT, then KVM needs to return an error, and
not WARN on the bad value.

Continue using the "unsafe" version of RDMSR, as it should be impossible to
reach the helper with a completely bogus MSR, i.e. WARNing on RDMSR failure
is very desirable, e.g. to make KVM bugs more visible.

  unchecked MSR access error: WRMSR to 0x1c8 (tried to write 0x0000000000004000)
  Call Trace:
   intel_pmu_set_msr+0x4e0/0x7f0 [kvm_intel]
   kvm_pmu_set_msr+0x17e/0x1c0 [kvm]
   kvm_set_msr_common+0xc76/0x1440 [kvm]
   vmx_set_msr+0x5e6/0x1570 [kvm_intel]
   kvm_emulate_wrmsr+0x54/0x1d0 [kvm]
   vmx_handle_exit+0x7fc/0x970 [kvm_intel]

Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqing Shi <1356292400@qq.com>
[sean: rework changelog, only modify WRMSR path, tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2:
 - Rework changelog to better capture the scenario.
 - Keep using the "unsafe" version of RDMSR.

v1: https://lore.kernel.org/all/tencent_744B87186CA59CFD106992329A6510F7F60A@qq.com

 arch/x86/kvm/vmx/pmu_intel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a0..22138c487216 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -308,13 +308,15 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 	 */
 	local_irq_disable();
 	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
+		int err = 0;
+
 		if (read)
 			rdmsrq(index, msr_info->data);
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

base-commit: 9f2a49c511cb05b85745e1578e4fd425bff87f58
-- 
2.54.0.823.g6e5bcc1fc9-goog

