Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2230C631;
	Sat, 17 Oct 2026 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197245; cv=none; b=JRUv8T2uFmhhh2eQjrvujARseaIIUM6ADGkgE1zSMe+hqjPzcvCvtIU6pIt0AS1OJI7XxpuS0idVq6n0wBHtlVe7w00xsM04qbpg/znhz30OZdY7ledkfVU22K3dVDWFrw9CGjxQAv2HCJcBPsB3psmOX0NlfdKLVlQsmR12URw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197245; c=relaxed/simple;
	bh=JDPw7W4hvxmpAbHvFL44g+TJT6tFdMu1q08yNRVLrrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abEehboF/0HwC5V0IsXLBmaNdKVMhkz71ZmvvaotZjYaJACMEyPazaxYC3KsiKLTuFRerVqnLoIS2692+3T73lsh38x58Hp++QHx9QPKXhFjEe4JufEWndBwLzA7xmJT6ODu42kIRi48pNX1HOEfyLt2rzeax8qnLwc9GPgLc2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=YOmfPKhw; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="YOmfPKhw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iSHy/CgRhICg1/p9z2nRv5RhEZ6KErBjj3CCnAWRA2c=; b=YOmfPKhw5Dc1btUQmoic+5Jmm3
	fY+vfCUD6mgkk3AM1EGU3qtoGJT0bmqm+cLNtRTa0DRtIB9VgT8tekhXd+0hXz/20hfxaVMEjwD1U
	e6LhWHeiquJh0tsKGgU1AQMt+8GY0vQoTmLLT3U0HZIyMcfyJSDxH/T2qDE+tEhtP9t5bFkJ1TI4g
	Z0bunAWeFmB5jezrw4FgoKl+DswFrgy3hTBDunL68JHSccazlWQg9CWpEqELDPXvbfoeTYfSUKH9k
	MxHOmTCSIfDAg+zZy8C7Om9ApIzNELpl1kawai311cfzCb+xDvTK8LgO7assR5ERbac0w3U7QqhHb
	dk+wkOaQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:60494)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjM-00B5eV-0b;
	Sat, 17 Oct 2026 01:52:55 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjK-000D3R-2V;
	Sat, 17 Oct 2026 01:52:54 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 01:52:52 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02 on every nested VMRUN
Date: Sat, 17 Oct 2026 01:52:18 +0200
Message-ID: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-sub-01.um.gwdg.de (10.108.142.54) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

The SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE (VLS) bit in
vmcb02->control.misc_ctl2 is OR-set in nested_vmcb02_prepare_control()
when L2 is allowed to use virtual VMLOAD/VMSAVE, but it is never reset.
vmcb02 is a persistent per-vCPU structure reused across nested VMRUNs,
so once one nested entry enables VLS the bit leaks into every later
entry -- including entries where vmcb12 has VLS cleared and L1 has asked
KVM to intercept VMLOAD/VMSAVE.  Per AMD's APM, virtual VMLOAD/VMSAVE is
honored over the VMLOAD/VMSAVE intercepts, so with the stale bit set
L2's VMLOAD/VMSAVE are virtualized and run without a #VMEXIT, and the
intercept L1 explicitly requested is silently dropped.

misc_ctl is reset from vmcb01 a few lines earlier; misc_ctl2's VLS bit
has no equivalent reset.  The only writes to misc_ctl2 are this OR-set,
the vmcb01 init OR-set, and the independent V_LBR (bit 0) set/clear, so
nothing clears bit 1 between entries.  nested_vmcb02_recalc_intercepts()
sets INTERCEPT_VMLOAD/VMSAVE when nested_vmcb_needs_vls_intercept() is
true and otherwise only WARNs on the reverse condition; it never catches
the real hazard of VLS on while the intercept is also set.

Reset the VLS bit before the conditional set, mirroring misc_ctl, and
add a forward WARN so a future regression trips immediately.

This is distinct from CVE-2021-3656 (single-VMRUN under-sanitization of
a VLS bit L1 set in vmcb12 without being granted the feature); here L1
is granted VLS and uses it legitimately, and the bit goes stale across
VMRUNs.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef6784..65e61b796 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -197,6 +197,14 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
 	} else {
 		WARN_ON_ONCE(!(vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
 	}
+
+	/*
+	 * If KVM is intercepting VMLOAD/VMSAVE, virtual VMLOAD/VMSAVE must be
+	 * off, or hardware would honor the virtualization and render the
+	 * intercept inert.
+	 */
+	WARN_ON_ONCE(vmcb_is_intercept(&vmcb02->control, INTERCEPT_VMLOAD) &&
+		     (vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
 }
 
 /*
@@ -994,6 +1002,13 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 
 	/* SVM_MISC2_ENABLE_V_LBR is controlled by svm_update_lbrv() */
 
+	/*
+	 * vmcb02 is reused across nested VMRUNs and the VLS bit below is only
+	 * OR-set, so clear it first; a stale bit would let L2 run VMLOAD/VMSAVE
+	 * unintercepted even on a VMRUN that asks KVM to intercept them.
+	 */
+	vmcb02->control.misc_ctl2 &= ~SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
+
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		vmcb02->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
 
-- 
2.54.0 (Apple Git-157)

