Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704850;
	b=S70zfaJsI6gnJldpFTb2YQOsRmVxbBeDCgUMmfWtJpgiHd390hTvdqdsFSAuA57pvEuZ
	 +sswwNhHubeQ5yASsUqk7AJ9yHlHBtBCPZKR5VPtlhh3p/RgWVqG6ODhLjIkkoojofWlz
	 56sIiRGWIDn8pLXx4ivcWYno2ieVaZ+odmM2osK71pVG4RFzjnfS5x+RBbNp/aZsKQbAh
	 IA7rN5hr9ju/RMX/HPHuVJQdAU6UyB+F9lLlu9QzBzVJPrsqCS5/yOsK+VCybV/HqDeku
	 lffOALfEf6A2mRlKW8sahZhejR1HgofI/CVraYUXwBJrYdU+MY8fGzwXNyOeIrnZaFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704850;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=3pJH03OqZ65+mg9epLm93kfGNWSyn7kvxbOtV12f8bs=;
	b=F0gW3chai0gqLbaOuhKrgnbDszqgejFvUw7cyoy6R9pa93rjw5sEFE2qjPshDtpX2tA5
	 K7j/l0/MlwQvnvmIoaNGdEp1PWf1CPazeLWG4ESPC6orC6R/03/wOCX7Msc28irVFFbHf
	 MJYx3mePMgDs9Whm1ezqekWWTQO3qr18KvFHZp0v0LDzyguZC5UGpLRf3iyThIBgyrDo7
	 fxOLmoFRFOfvGqHidMPk2lMU4B211JVPBEZSMWkP5gqGa+GOFsJpzlEEPBMzT94UmGxV9
	 wqSm9Mn/p/oM6OX20u7XVtUCqPDMnlT0MAF4LM2n1lYzuclRM3uprU7RXeIZ74lfaTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=MSBFCQXJ;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A530606A319;
	Thu, 22 Oct 2026 21:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A530606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=MSBFCQXJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3pJH03OqZ65+mg9epLm93kfGNWSyn7kvxbOtV12f8bs=; b=MSBFCQXJ/BnKZS2tgHxEjCnv42
	MOeylAQzurfY81FRISFTAJYaJh2cA4ch+JYxEGaYxGT1PDTw963nu1RsmEKn92uFl9OMiDuOPXLTZ
	dCqWw5C2mHKbxaYOpv22b/l8TOnGuoXo8gZLYHaPYqoUyxvlN1JuN2WKHr8Lef6OYo6fkxSsz/S05
	DmaAiuNpHlrOb/0nsbaw5FjAqmwambKWg24GgROINRJa5eTwJn34EflkBzV7+68U1ktF+NSguXqfi
	sxChkgp6P7iiIiOWEOFi6iQYDFzUNkMQUK9fo9/jp2x2yI+zhxKqTZugLSyCp7j/dJl0VGA+y/7pQ
	syLw50nA==;
Received: from mailer.gwdg.de ([134.76.10.26]:35764)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0QJ-00EBgz-1K;
	Thu, 22 Oct 2026 23:34:07 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK0QJ-000X1f-00;
	Thu, 22 Oct 2026 23:34:07 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 22 Oct
 2026 23:34:01 +0200
From: <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammadeftekhar@gmail.com>, Amirmohammad Eftekhar
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH v2] KVM: nVMX: Reject nested VM-entry in wait-for-SIPI with a pending event injection
Date: Thu, 22 Oct 2026 23:33:48 +0200
Message-ID: <20261022213348.221488-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-07.um.gwdg.de (10.108.142.66) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

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
v2: No code changes. v1 (sent 2026-10-22, Message-ID
    <cfe12756-208a-4a3c-bd46-cfdfeae6cdb1@gmail.com>) was whitespace-damaged in
    transit by format=flowed in my mail client; resending cleanly via git
    send-email.
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

