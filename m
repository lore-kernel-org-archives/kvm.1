Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402D23EA83;
	Sat, 17 Oct 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197228; cv=none; b=FtDOwRcofDv8/zTkNuf8hsPdtQ+uMorummX/KykM7e9vdfuy1XotPVZpZ5WHCiWsfMUiS+ESlhSua3n7ZYYZkjjcNpbyUyo/oETDIBHhd9BkefbwhwagZpCUudaKoHQm7TJKOZEKQR3h93L+iBuBhg6KDvWGDomECgFgbxJOrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197228; c=relaxed/simple;
	bh=xkZnutXewFl+x7u/LYxwKe5nVw0sxUXgyU1Osl1cK1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O0Xc9c+FQZuN4yXhEsB/pf11/HIbL0Mr/ogi9RWD/PIieq6KyXWhBlnPOkzE4FgNdm8tpwuTcE8+Tjir03LrX0U2uy7M63TcETXqR2PvPCqNdP93rchQNYQ/pOZop/ufVYiqGOrHLEgcAC8w2DqFqOksT25tKc3Lhhp7XLT2LN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=jbB0WHX2; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="jbB0WHX2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QTdcR7kD/IU9Djlvm733F4izyqwYWugNa4ZWITXI82g=; b=jbB0WHX2KW+Ti7nGEiid5gFmd5
	2w/hraLNGPPLFOm4i0t6yq3aH+bqPvRSpRaVtChaP2hXzH1cnsz0g/Jqi5yQl9WfIUaHl9qPYEzJ6
	/T9sU6lisgy9uJ8epAvSXDEkvI1n7ltJg/5iuyXKwNoRItisMsKSuImLTipkMG/lVQ523mdESbE0g
	zhAZbxqIwjn4PwxI2tzhcJrcUZ1KfQ7FGKm9rg+wt+agY2VA0v4+/eo6XStTW27LvBtlQIEAtRuxb
	17e+q7WhdsZerGlmyriPLRNottuaLNcCRUgbPoZZdqpUwF59mgqUwpebc53oNUDclNlbkix8BGCN8
	TwDY8pTw==;
Received: from mailer.gwdg.de ([134.76.10.26]:47118)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjM-00B5eU-0b;
	Sat, 17 Oct 2026 01:52:55 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjK-000D3R-2Q;
	Sat, 17 Oct 2026 01:52:54 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 01:52:47 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: nVMX: Reject nested VM-entry in wait-for-SIPI with a pending event injection
Date: Sat, 17 Oct 2026 01:52:17 +0200
Message-ID: <20261016235221.33726-1-amirmohammad.eftekhar@cispa.de>
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

nested_check_guest_non_reg_state() only verifies that
guest_activity_state is one of ACTIVE, HLT or WAIT_SIPI; it performs
none of the activity-state cross-checks that VM entry requires.  Per
Intel's SDM, "Checks on Guest Non-Register State", when the valid bit of
the VM-entry interruption-information field is set the interruption to
be delivered "must not be one that would normally be blocked while a
logical processor is in the activity state", and for the wait-for-SIPI
state "No interruptions are allowed".  The same section also requires
that the activity state indicate the active state when the
interruptibility-state field blocks by STI or MOV SS.

KVM accepts a vmcs12 that violates both rules, and hardware does not
catch the miss: prepare_vmcs02() never writes GUEST_ACTIVITY_STATE, so
vmcs02 always carries active, and wait-for-SIPI is emulated in software
only after a successful entry (the mp_state = INIT_RECEIVED arm).  The
injection, in contrast, is copied into vmcs02.  The physical VMLAUNCH
therefore sees {active, valid injection} -- a legal pair -- and
succeeds.  Because the offending field is stripped before hardware sees
vmcs02, the missed-exit WARN in __nested_vmx_vmexit() can never fire for
this class either.

From L1's point of view a VMLAUNCH that bare metal rejects with a
VM-entry failure (invalid guest state) instead succeeds, with L2 left
parked in wait-for-SIPI holding a stale VM_ENTRY_INTR_INFO in vmcs02.

Add the two activity-state cross-checks that KVM strips before hardware
can enforce them.  The HLT state additionally restricts which
interruption types may be injected (external interrupt / NMI / #DB / #MC
/ pending-MTF only); that matrix is left for a follow-up as it needs the
per-type table, whereas the two checks added here are unconditional and
cover the fields KVM elides.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/nested.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f8..66c9d1ffe 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3311,6 +3311,24 @@ static int nested_check_guest_non_reg_state(struct vmcs12 *vmcs12)
 	       vmcs12->guest_activity_state != GUEST_ACTIVITY_WAIT_SIPI))
 		return -EINVAL;
 
+	/*
+	 * The activity state must be active if the interruptibility state
+	 * blocks by STI or MOV SS.
+	 */
+	if (CC(vmcs12->guest_activity_state != GUEST_ACTIVITY_ACTIVE &&
+	       (vmcs12->guest_interruptibility_info &
+		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS))))
+		return -EINVAL;
+
+	/*
+	 * An injected event must not be one that would be blocked in the
+	 * guest's activity state; no interruptions are allowed in the
+	 * wait-for-SIPI state.
+	 */
+	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_WAIT_SIPI &&
+	    CC(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.54.0 (Apple Git-157)

