Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823613DDAA;
	Thu, 23 Apr 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960025; cv=none; b=kaQaA+zmTPjhqrRySchbdYI4QsR2up7zC7Pabe1FAD7Pt/k+O+ENG6dzVXmyQPRN6lSYCDdLI7lEb+Is9irxjaewiyZoYjsQ+JBRfzzA7sVx2hJri2pDeTDQSC50N4Pu6WY0ljZMl3PjewkB3pCE+/Oe6ftTeqMiTrGDtxcWkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960025; c=relaxed/simple;
	bh=dMmQTWZzl7J0ESUOSqOYjWSODc3+zPmgVNnlOFyBtZM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PyvsHKxO9O65SFG52TsP0qZSbxU2uwESVkwZSyeWUq4I76zaB7xr8mVy/led3Hg1YNS4l0S/jHOHWASCBu6AXKunFH4yWu0hIq57Z2WuroMoy8bNASJg829plcaam9nZ7v7pzKua1DV4Wgyg3y8gAzWj7ScxEykZszttuaepzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z3meE/YI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3meE/YI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=LNZVVUHwaZaORA5/EEV1ww8+kRjZdOBgTODzaZmECH4=; b=Z3meE/YIlGqxkSYj8jv3ibGqHn
	nsrq+G2hGnj+eJ/psffJ4yyQ08pa1RUprx0hgRXPgDdrtuuWyPNe9utqMhmu5/GXDkYRPZpcMMxpl
	cX85MKn0zlTTWFl6C6M1AR4/Pyn9d+XOZojrDrKUPL9QGHPjeM9K15GOLN6I3ViB/qbUqvnpJ+7Ie
	4uHTal+6kDbgCcaDzBiD5ta3dtikTlogBFVw0ypxgrsIjf7fZv3ADv3z2QMckS9GwtNljnvfTN8OA
	bAKXQkDJyTDcBkYtz9lmvO4cN105t6bFaVjDnJ2RQ0bl1qPz9jNchcNdXmzyWjx9L+3dtxGztrmjI
	vRaTjb0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFwTS-0000000DNn0-0yYU;
	Thu, 23 Apr 2026 16:00:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2B9903021A4; Thu, 23 Apr 2026 18:00:16 +0200 (CEST)
Message-ID: <20260423155936.957351833@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 23 Apr 2026 17:56:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Sean Christopherson <seanjc@google.com>,
 Jim Mattson <jmattson@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
Subject: [PATCH 2/2] x86/kvm/vmx: Fix VMX vs hrtimer_rearm_deferred()
References: <20260423155611.216805954@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Vishal reported that KVM unit test 'x2apic' started failing after commit
0e98eb14814e ("entry: Prepare for deferred hrtimer rearming").

The reason is that KVM/VMX is injecting interrupts while it has IRQs disabled,
for a context that will enable IRQs, this means that regs->flags.X86_EFLAGS_IF
== 0 and the irqentry_exit() will not DTRT.

Notably, irqentry_exit() must not call hrtimer_rearm_deferred() when the return
context does not have IF set, because this will cause problems vs NMIs.

Therefore, fix up the state after the injection.

Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
Reported-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
Closes: https://lore.kernel.org/r/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel%40intel.com
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
---
 arch/x86/entry/common.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/entry-common.h>
 #include <linux/kvm_types.h>
+#include <linux/hrtimer_rearm.h>
 #include <asm/fred.h>
 #include <asm/desc.h>
 
@@ -27,6 +28,18 @@ noinstr void x86_entry_from_kvm(unsigned
 #else
 		idt_entry_from_kvm(vector);
 #endif
+		/*
+		 * Strictly speaking, only the NMI path requires noinstr.
+		 */
+		instrumentation_begin();
+		/*
+		 * KVM/VMX will dispatch from IRQ-disabled but for a context
+		 * that will have IRQs-enabled. This confuses the entry code
+		 * and it will not have reprogrammed the timer. Do so now.
+		 */
+		hrtimer_rearm_deferred();
+		instrumentation_end();
+
 		return;
 	}
 


