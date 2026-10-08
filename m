Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2315435502;
	Thu,  8 Oct 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463778; cv=none; b=fgEHWG5ZBoxLI1zaqzqX/s1XU+lwebiPHrAB3CKWy3us9xlLg4l4lADMGve8r4my7NlTCqaoAWbr6XmmgcOOnIjGln+mvnsUGUGZ310Xn95D1sHjV6prAkVJ8OAU44+wRN9xmnRBDfblgC3CJJmVBOFbu9QRAKipwfddO/hFjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463778; c=relaxed/simple;
	bh=T7knMqaLkhIDDOsOBoKx7vZrCXHFiz/ADPp9M/eIGtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Wptg4Qz61yKYNKU2/dowaVw+PsZMNADES7eZQhWBlSvYE3353wZQwVh8+mE7r+SbyIBK9uiS9N9DfO1IEyG2TMbJUl+DV+V+ux/GU6Z1XxlAg53L5e1+H+64pazzyLXq2PHUqvgupjsp/jlm0GMEzp9OSbg4Y9i84wjDjlHtNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ApP97k7/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ApP97k7/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1791463774;
	bh=T7knMqaLkhIDDOsOBoKx7vZrCXHFiz/ADPp9M/eIGtE=;
	h=From:Date:Subject:To:Cc:From;
	b=ApP97k7/bQZ6s/HGuiS38WkXopQSWYXNmcnmElBkPT9fMjDaYql/z/xC7I9ynTrsa
	 zaARSqtPxCvO0LoA23qBmx8CqvlCjmGNsSVSAZhGNpCFsGEqDjBRdPS5ZvLX7oASRj
	 zGd0uantVthWx7lw7gV1L99plsiZNAFQv04qVxDLx41YTLkDMtA2+4uxz2yuk10JPM
	 UHnffgNAHKF5tSknhUxDElvT96bmGWJlEa3CACNu8uvbG5dpGInooWntvv79msh/kY
	 TeNSHRuO8W1ivbj6EDzTejoFwp347KrJ9dkNSwKi2rjE7BXt16UxzKO8LMQ0ykTRMW
	 kny5R4F6VDL9Q==
Received: from [192.168.1.156] (unknown [100.64.0.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 65F6517E014D;
	Thu, 08 Oct 2026 14:49:34 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Thu, 08 Oct 2026 13:49:06 +0100
Subject: [PATCH] KVM: x86: Reevaluate pending interrupts when enabling
 ExtINT through LVT0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lapic-extint-lvt0-unmask-fix-v1-1-db2bf68fba75@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQRyqhV5EuYhx1WhslE0UQ7
 27aLt9f/AOUo7DCozgg8iYqc8gobwX40YWBUbpsIEN1aYzFyS3ikfckIeG0JYNr+Dh9Yy873qm
 jiqzra0uQF0vknH/75vm3ru2Lffo+4Twv3tPVPYAAAAA=
X-Change-ID: 20261008-lapic-extint-lvt0-unmask-fix-52d2328af682
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.2

If the PIC output becomes asserted while LVT0 is masked, unmasking LVT0
in ExtINT mode makes that interrupt injectable without setting
KVM_REQ_EVENT. Without another event triggering reevaluation, the
interrupt remains pending and a guest waiting for timer ticks can hang.

Fix by setting KVM_REQ_EVENT on an LVT0 write where pic interrupts
become acceptable.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
During calibrate_delay_converge() we spin waiting for jiffies to increment on a
tick interrupt. However, if KVM fails to deliver the interrupt this causes the
guest to hang, spinning on the while loop.

Reproduce with:

qemu-system-x86_64 \
  -cpu host \
  -accel kvm \
  -smp 1 \
  -machine pc,hpet=off \
  -kernel <bzimage> \
  -nographic \
  -append "console=ttyS0,115200 noapic apic=debug no-kvmclock clearcpuid=tsc"

Resulting in a hang at:

printk: legacy console [ttyS0] enabled
printk: legacy console [ttyS0] enabled
printk: legacy bootconsole [uart8250] disabled
printk: legacy bootconsole [uart8250] disabled
ACPI: Core revision 20260408
ACPI: setting ELCR to 0200 (from 0c00)
APIC: Switch to symmetric I/O mode setup
Not enabling interrupt remapping due to skipped IO-APIC setup
Enabled ExtINT on CPU#0

Note that the bug manifests itself only if a PIC interrupt is asserting during
the mask window, so it is timing based. Using nested virt helps, or apply the
following patch to the guest to provide enough time for a tick after masking:

--8<---------------cut here---------------start------------->8---
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index aa1e19979aa8..ddee09360dd0 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1509,7 +1509,7 @@ static void apic_clear_isr(void)
 static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
-	unsigned int value;
+	unsigned int value, i;
 
 	if (apic_is_disabled) {
 		disable_ioapic_support();
@@ -1527,6 +1527,9 @@ static void setup_local_APIC(void)
 	value &= ~APIC_SPIV_APIC_ENABLED;
 	apic_write(APIC_SPIV, value);
 
+	for (i = 0; i < 10000000UL; i++)
+		cpu_relax();
+
 #ifdef CONFIG_X86_32
 	/* Pound the ESR really hard over the head with a big hammer - mbligh */
 	if (lapic_is_integrated() && apic->disable_esr) {
--8<---------------cut here---------------end--------------->8---
---
 arch/x86/kvm/lapic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e1f3cea14765..ce7fbd6c45c2 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2520,6 +2520,14 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 			val |= APIC_LVT_MASKED;
 		val &= apic_lvt_mask[index];
 		kvm_lapic_set_reg(apic, reg, val);
+
+		/*
+		 * Enabling ExtINT can make an already-asserted PIC interrupt
+		 * deliverable without another transition on the PIC output.
+		 */
+		if (reg == APIC_LVT0 && kvm_apic_accept_pic_intr(apic->vcpu))
+			kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+
 		break;
 	}
 

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261008-lapic-extint-lvt0-unmask-fix-52d2328af682

Best regards,
--  
Matt

