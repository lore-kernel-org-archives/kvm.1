Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614597;
	b=em0cjBbkwoThB1pBrpgOiM5Rq/cBtySewL382rnt5ZFPmgG92NEBdIt+eXNX/KYK4N86
	 MlxpeIBtCSzW+OKfgokVxlYWg8KdWwoS82i38o7WRlcldf2ush7p5kX/nmxkx3nv5qeHA
	 BCMBhHy4SZ9IaEEozVpieitLV+/4VI1JmOM2Xo1UwoJWJ7oXQLoiQ4Nbd84xFHDy0cppl
	 RWWwX3KLNXtFQc7yF4ZWcJMLR6KuKdzT+EyrpTFu772MB3hnvr0sGRc7RhKsc/e4dV8Kk
	 d22DStgKA9jYVYRkgvXhZjkjKNQjMQZYadgiYkGomwQVWKgy0fWo4GjJvO2Ow4N35yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614597;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=sJ7kjlxh+mcnqNNAS/9X3/G2tjirPXO/Ll2OmU9Rg88=;
	b=jOGbtHEUT/994/JguZ0VsJl6lz7IO+xFM4frw2rOaSohampeSkzLYnuU911MmIO64e6F
	 Rm73QS7r+vQQ53b3IF1yILnmQFIh4lIcW97dGHcMFaaKvgx85eSvSxPKwIMFO/ptiT8d9
	 TCueVzz7bXPAebxBKriV1r8l075nR+2u3XOVAWaTiIRTdJ7/DZzT5pGaQEg2dhit4J5HS
	 qwCSmEEuJ8TvNQw5RpdFTPrHxNjZHOLhKWxpgZjV8Nei1JcAjgM5cgwiFmqPhJVDWCizx
	 /vKEVZemvQW5WW1AJe487OgfqQGz6aA1LGU8cM8UdSPdCEZ3uRK5gADDeGEIatGmDVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=QxQPXTiP;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444B606A684;
	Wed, 25 Nov 2026 13:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B444B606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=QxQPXTiP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sJ7kjlxh+mcnqNNAS/9X3/G2tjirPXO/Ll2OmU9Rg88=; b=QxQPXTiPztdBs74HcY0x3dLVl3
	EhfVb5gAQDrVYIOS058Gxp1hON/foU4/SpwYM/Gy9xN0ySSx4NOoxzbp3NaGsvM1XN2d7DSBeED70
	h5L6roJi5zyF6N83PXFBcpTTL51j6XswaR6VzFbs2qrR0daaL108ouR+thY9avIlGpGEFxMDt0MuE
	xTw+7XGFuyxbquPotCSFP2lED53eavkfR/yn1LZQGYsQ07VExFNwzyGKB9vDs91WsiZ20vEstVY4f
	EkBtmmLMv4EpUVQwHzk0zWz136zhJuMV8xKzg6M1nDFERiocXrD54IwldbQVRnF335jrcpDemukN1
	nf294GpQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:44649)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xWDNg-00CDed-06;
	Wed, 25 Nov 2026 14:49:52 +0100
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xWDNf-0001nb-37;
	Wed, 25 Nov 2026 14:49:51 +0100
Received: from localhost.localdomain (10.250.9.200) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.57; Wed, 25 Nov
 2026 14:49:51 +0100
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>, <amirmohammadeftekhar@gmail.com>
Subject: [PATCH] KVM: nVMX: Expire the emulated preemption timer immediately if its deadline has passed
Date: Wed, 25 Nov 2026 14:49:42 +0100
Message-ID: <20261125134942.60776-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
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
X-ClientProxiedBy: MBX19-SUB-06.um.gwdg.de (10.108.142.71) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

vmx_calc_preemption_timer_value() returns the unclamped u64
"preemption_timer_deadline - l1_scaled_tsc".  The deadline is reused, not
recomputed from vmcs12, on the two entries to L2 that are not
VMLAUNCH/VMRESUME: RSM back into L2 (has_preemption_timer_deadline
survives the SMI) and KVM_SET_NESTED_STATE with
KVM_STATE_VMX_PREEMPTION_TIMER_DEADLINE.  If the deadline has already
passed by then, the subtraction wraps to ~2^64 and
vmx_start_preemption_timer() arms the hrtimer ~2^64 / virtual_tsc_khz ns
in the future (about two hours at 2.6 GHz) instead of synthesizing the
immediate preemption-timer VM-Exit.  L2 then keeps running without the
exit L1 asked for until some other event forces a VM-Exit.

Reachable by:
 - an SMI taken in L2 whose SMM handler runs longer than the remaining
   timer (SDM Vol. 3C 27.5.1: the timer-induced VM exit occurs
   immediately after RSM if the timer expired during SMI, in SMM, or
   during RSM);
 - a guest WRMSR to IA32_TSC / IA32_TSC_ADJUST from SMM that moves L1's
   TSC past the deadline (the timer counts only TSC increments, so a TSC
   write must not affect it at all);
 - KVM_SET_NESTED_STATE with a restored deadline that has already passed,
   e.g. a live migration whose blackout spans the expiry.

The original deadline code, 850448f35aaf ("KVM: nVMX: Fix VMX preemption
timer migration"), returned 0 in this case; the guard was dropped by the
nested.c hunk of the follow-up commit.

Fixes: 8d7fbf01f9af ("KVM: selftests: VMX preemption timer migration test")
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
Observed inside a disposable nested L1 (KVM as both L0 and the L1 under
test) on mainline and on 6.1.74, exercising all three routes.  With a
deadline set just in the past, the L2 preemption-timer hrtimer is armed
about 7064 s out (2^64 / 2611200 kHz) instead of causing the immediate
exit, and L2 runs for the whole observation window with no exit; the
controls (no deadline, future deadline, SMI with a short handler) exit on
time.  No warning, BUG or KASAN on either kernel.

 arch/x86/kvm/vmx/nested.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2291,6 +2291,18 @@
 			vmcs12->vmx_preemption_timer_value + l1_scaled_tsc;
 		vmx->nested.has_preemption_timer_deadline = true;
 	}
+
+	/*
+	 * The deadline can already be in the past when L2 is (re)entered
+	 * without a VMLAUNCH/VMRESUME, i.e. on RSM or KVM_SET_NESTED_STATE.
+	 * Expire the timer immediately in that case (the SDM requires the
+	 * timer-induced VM-Exit to occur immediately after RSM if the timer
+	 * expired during SMI, in SMM, or during RSM) instead of letting the
+	 * subtraction wrap to a ~2^64 timeout.
+	 */
+	if (vmx->nested.preemption_timer_deadline <= l1_scaled_tsc)
+		return 0;
+
 	return vmx->nested.preemption_timer_deadline - l1_scaled_tsc;
 }
 

base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
