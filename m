Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034F3CAA47;
	Wed,  8 Jul 2026 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492490; cv=none; b=sFY1e8AET2GiefXQ2UJQ9V9ffP4CyPnr4KUdi5BnSZMt9qW53YfvN60s9NxVxnl7e/QYQuWGhTdFoD0ol1kN+CECmEZCARvvoWcUnoMhxt+a8rip+waFdUX/chtZ6DpgFmWErHYjw/6naJpTzNeoLwuyFi2Bxj1UfiY9GHzLXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492490; c=relaxed/simple;
	bh=DdhKItjKcLaVIqk4MenR5Zk1XyrINq+1HtrhLuTvIJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjoYGX09X2GyLqN+eWY4DfpyjKR0rp5k27D+8lvnP7mGVVXcfLbMscN73H1TWcD42PZOpWsOPxpzyPbwa3f/2ElnaLFO8WORD1lj/RcarX4YreD9eR1qe0EF0RW3puCrptfkCZn3Rw4g1dFXhbOKLOoyp9NqUIU3mBW4v8PG2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtjJ8Er4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtjJ8Er4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1361F000E9;
	Wed,  8 Jul 2026 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492488;
	bh=ovqp+sg+BUffpK87n6aLoEdnd7I75/1mcFzijmEIVc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtjJ8Er4O45fbRhFZklnewZQeqTGe51w9NZnZ3JUzdeRhVdIRL2rRpvc471V+YOrh
	 AR4qgw+/Mc8kgrhPlN3eOUTfAs8sz0iFoM0ZoiLEjPBppBM7KEOQfEmirC8Wckq/6l
	 KzKMfwcSJ9UJp+/n8rebM6VlGIjouGrxxGexOdHey+cKFzLb8NnzFoY0gJUd/QdhPq
	 rFxd2roKD/0J7f64qk7gFXlEF6WuTzxnDIFY5BbuLjxPJwxhakxMSEVZ/iREKkP83k
	 vZJYhNKsk93HlzU5MVBDGm25vQM92oTjflhMy8GtHuwkrSnwbNXLnZBOy3kI/f5C9J
	 NTsF4ID5Hu3Rw==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of native_apic_msr_eoi() for Secure AVIC
Date: Wed,  8 Jul 2026 12:02:00 +0530
Message-ID: <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783490022.git.naveen@kernel.org>
References: <cover.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop savic_eoi() in favor of using the native helper that writes to the
APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
level-triggered interrupts. However, it relies on APIC_TMR indicating a
vector to be level-triggered, but APIC_TMR can never have a bit set
since it is only updated when the LAPIC accepts a level-triggered
interrupt. In the case of a Secure AVIC SEV-SNP guest, all
level-triggered interrupt sources are in the VMM (emulated IOAPIC
primarily) and KVM accepts them on behalf of the guest resulting in the
APIC_TMR in KVM APIC backing page having a bit set. This is never seen
by the guest, which has its own private APIC backing page. As such, the
savic_eoi() handler is dead code. Remove it.

Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kernel/apic/x2apic_savic.c | 31 +----------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
index cb3b55225ab6..f2af149c6005 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -304,35 +304,6 @@ static void savic_update_vector(unsigned int cpu, unsigned int vector, bool set)
 	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
 }
 
-static void savic_eoi(void)
-{
-	unsigned int cpu;
-	int vec;
-
-	cpu = raw_smp_processor_id();
-	vec = apic_find_highest_vector(get_reg_bitmap(cpu, APIC_ISR));
-	if (WARN_ONCE(vec == -1, "EOI write while no active interrupt in APIC_ISR"))
-		return;
-
-	/* Is level-triggered interrupt? */
-	if (apic_test_vector(vec, get_reg_bitmap(cpu, APIC_TMR))) {
-		update_vector(cpu, APIC_ISR, vec, false);
-		/*
-		 * Propagate the EOI write to the hypervisor for level-triggered
-		 * interrupts. Return to the guest from GHCB protocol event takes
-		 * care of re-evaluating interrupt state.
-		 */
-		savic_ghcb_msr_write(APIC_EOI, 0);
-	} else {
-		/*
-		 * Hardware clears APIC_ISR and re-evaluates the interrupt state
-		 * to determine if there is any pending interrupt which can be
-		 * delivered to CPU.
-		 */
-		native_apic_msr_eoi();
-	}
-}
-
 static void savic_teardown(void)
 {
 	/* Disable Secure AVIC */
@@ -421,7 +392,7 @@ static struct apic apic_x2apic_savic __ro_after_init = {
 
 	.read				= savic_read,
 	.write				= savic_write,
-	.eoi				= savic_eoi,
+	.eoi				= native_apic_msr_eoi,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= savic_icr_write,
 
-- 
2.54.0

