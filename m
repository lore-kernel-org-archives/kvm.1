Received: from outbound.baidu.com (mx15.baidu.com [111.202.115.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EA823DDC5
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938199; cv=none; b=ozrP2Ji0Rf7ZtkdI9XbKu52Hp7rbQOFwqpn9LUOZ8Rq0xIo6t9CgH6D9nBcJG3qnIi9yHeGrRU+3qioSUbBuOcjMhw+n0ZA91dPwo9K9+lOqyEQXsgxc/RZv1Hkhd05WBoXbPmpr8mXU4eNPxz/ATyzMsnmDtyNcxCMnF+VsGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938199; c=relaxed/simple;
	bh=d/+Vrm1JzqHR4axod9Rf8FamulmU3bbxkzqv+Zgv41o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMUncAdBQYml0OyV5GfWQcd4WhjqIIPK72uc6T7WfTwD45T/bNvNld4IUauVfSek3P/VbTS+BY4Q1OG9irZXShw1mOyHHwKfilIjtN5YKpmHx4LgTKTXRIsSbp8BiwFEy8UwBJwnx8yamXI3VR/a89McXkdp+ebzlDHbxDvPLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=PtPsLHMu; arc=none smtp.client-ip=111.202.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="PtPsLHMu"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Peter Xu <peterx@redhat.com>, <kvm@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: x86: ioapic: Use old_dest_mode consistently in ioapic_write_indirect()
Date: Wed, 27 May 2026 23:16:24 -0400
Message-ID: <20260528031624.1929-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1779938194;
	bh=Kc0CEIwLt5Dpbtzj6F39foMivt+h/rNr1evEKjYny1E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=PtPsLHMuKOpMV7vPskivoI7uTWfWGPgv5NW5fMNr1NIHS+jsKVPrNORbG9AyG56rG
	 kQTGhwUJPBmtZaH/93b82EzoQfatYYhV8zEsZmXpn91JfgCFWVmv7q+D8cGErq/dXa
	 5ohMLJRfdUDZQr72Z6CofYK1T3U7hUV7D58a6wr8s/yVeAynpPWTibFyC4aNi0CLcV
	 CRByAmo+MRa2R4sSq4RB2IERsdgXQNTI6WxCrFjKuuKclGN7nPQynAYbiEDhNFr/A3
	 Ln1UD3eXA5AopNMWVDJxQuxIZb9dVQXLmWs7Efa70yzqqdtMZvOdE2I0k3WOvXKn7g
	 z60XFOVUbdDuw==

From: Li RongQing <lirongqing@baidu.com>

When reconstructing a temporary IRQ state from the historical/old IOAPIC
redirection table configuration in ioapic_write_indirect(), the code
previously assigned 'irq.dest_id' from 'old_dest_id', but incorrectly
queried the live/new 'e->fields.dest_mode' to populate 'irq.dest_mode'.

Mixing the old destination ID with the new destination mode creates an
inconsistent, hybrid IRQ state. This discrepancy leads to an incorrect
vCPU bitmap calculation via kvm_bitmap_or_dest_vcpus(), causing subsequent
interrupt routing updates (such as RTC interrupt handling) to target the
wrong set of virtual processors if both fields were modified simultaneously.

Fix this by using 'old_dest_mode' consistently alongside 'old_dest_id' to
ensure the historical IRQ structure is reconstructed accurately.

Fixes: c96001c5702e ("KVM: X86: Use APIC_DEST_* macros properly in kvm_lapic_irq.dest_mode")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kvm/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index eed96ff..f3f4a48 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -441,7 +441,7 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 				irq.dest_id = old_dest_id;
 				irq.dest_mode =
 				    kvm_lapic_irq_dest_mode(
-					!!e->fields.dest_mode);
+					!!old_dest_mode);
 				kvm_bitmap_or_dest_vcpus(ioapic->kvm, &irq,
 							 vcpu_bitmap);
 			}
-- 
2.9.4

