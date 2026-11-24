Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527442;
	b=1RZ7VGe09Tp1kLW24YX/iaMkzxEZS8EhCp3Lqg7mS70QMb+cqU8uRd8Jg1CG/PyckkIv
	 QXHzfWnhaUx414sTmuXU4amGNi0S+2yJOYupBLaJzBVFFucR58dmGVGI7VSmmOaQWbblE
	 0FeS1FmOOsdO7MqddGO64LSfXxziXa+OjUbmEVjEXUBdAfujLdre5MdeLqczxdkJLywYw
	 +utxaD+9SyhwI32cOid9+apSGu0MATz71xNyq4sbk5DhNQRXy+feD4FLZ6QUghJ0/pXbQ
	 skmCy7V5pq2qqlTnTwwrKQd327OZsfmuFYInPeoNfMBNU3U2pQKVEZTueNOyOLphLHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YPTZ3U0iB+VgDsp4Bth03cZ8ixWij7qO36Sh45zXRn8=;
	b=mCCHSesao3L2TWTluH0rEiQAX6ZggekSkwvoCf4IjG4IsOdfpkdglNcDcEopNwVrh0vS
	 hjo8iGQLAyN0F5AyNk9XGz86Z0yCN26yaYGNrYvttHAIenp6/00j6hAr5ZeiZXdA4YHDr
	 25iOIbgmyrdIsZ+XvZYpR5BPA2K54AlGweawxDoX6FzdYFtDWKXWixfKtYfk/VXFv4Ah1
	 LRFhCvuEyq5HTdwMTbPWhfrZNVtKp/nMgjDwIyfMZ1Tt1874s91gQ63iuAf/S/qcjO3+v
	 2VES2e3Y0gDrsE39NCJDIzUqbP+8mki0Z0ipZyMSjQ9GgSIoQ7WpaQpfLvogHIOtIHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=LdOFBmtt;
	arc=none smtp.remote-ip=129.187.255.138
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E9606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=LdOFBmtt
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4jYkPh4WKYzyY3;
	Tue, 24 Nov 2026 14:37:12 +0100 (CET)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:to:from:from:received:received; s=
	tu-postout21; t=1795527432; bh=YPTZ3U0iB+VgDsp4Bth03cZ8ixWij7qO3
	6Sh45zXRn8=; b=LdOFBmtt7iTU//qsLldot5+4ppu9wIXTQEbXCeWPYMXNL4QoC
	eviqhMfddKl7DZFdr6p/jgqQszSi1oU0DTq0tb7Zx6jwUSb6pGYAaWyz1/atq30f
	bRpEgMqVHv4EqBwS4IN55a+f7adxEjjf2E0v0lvwG3BU/ctS2jQXhgnRozCzOb6s
	i6z6Ws1HYYGhEDLawncYl8M4Y/ivAFCc2AcuCBI57bVqbESOR2HM2pRp/1br3fxk
	7CRDF9GpOX5Yy90nf4yrzq7P8FgoO57PVixQUjwQpB+4YQrAmVIpt1yb0nA/wyb3
	jaJd+x0Mhsm9i1g8qLmoKrS7NWx11W7ooVk+A==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.877
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
 by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id jThmpmI4qnQf; Tue, 24 Nov 2026 14:37:12 +0100 (CET)
Received: from thanatos.sec.in.tum.de (unknown [IPv6:2a09:80c0:50:1:f68e:38ff:fe7b:57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4jYkPh0p7FzyVD;
	Tue, 24 Nov 2026 14:37:12 +0100 (CET)
From: Manuel Andreas <manuel.andreas@tum.de>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Manuel Andreas <manuel.andreas@tum.de>
Subject: [PATCH] KVM: nVMX: Allow NMI injection while NMI-blocked if vmcs12 doesn't use virtual NMIs
Date: Tue, 24 Nov 2026 14:37:04 +0100
Message-ID: <20261124133704.5563-1-manuel.andreas@tum.de>
X-Mailer: git-send-email 2.47.3
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

The SDM requires blocking by NMI to be clear when VM-Entry injects an NMI
only if the "virtual NMIs" VM-execution control is 1.  If virtual NMIs are
disabled, injecting an NMI while blocking by NMI is set is legal.

KVM enables virtual NMIs in vmcs02 regardless of vmcs12 (and vmcs01 always
uses virtual NMIs if enable_vnmi=true), but copies vmcs12's guest
interruptibility state and VM-Entry interruption information verbatim.
If L1 doesn't use virtual NMIs and injects an NMI while blocking by NMI
is set, the CPU thus rejects vmcs02 and KVM reflects a bogus
"VM-entry failure due to invalid guest state" to L1.

Clear blocking by NMI in vmcs02 in that case.  Delivering the injected NMI
blocks NMIs, i.e. L2 still runs with blocking by NMI set, which is the
state L2 would be in on bare metal.  Leave nmi_known_unmasked alone,
it's derived from vmcs12's original value and so remains false.

Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
---
 arch/x86/kvm/vmx/nested.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a98f28651f7..7229f4b98eee 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2563,14 +2563,30 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 	 * Interrupt/Exception Fields
 	 */
 	if (vmx->vcpu.arch.nested_run_pending) {
-		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
-			     vmcs12->vm_entry_intr_info_field);
+		u32 intr_info = vmcs12->vm_entry_intr_info_field;
+		u32 interruptibility = vmcs12->guest_interruptibility_info;
+
+		/*
+		 * vmcs02 uses virtual NMIs if KVM does (i.e. enable_vnmi=true),
+		 * regardless of vmcs12, in which case the CPU rejects VM-Enter
+		 * if an NMI is being injected while blocking by NMI is set.
+		 * Architecturally, there is no such restriction for L1 if
+		 * vmcs12 doesn't use virtual NMIs, so clear blocking by NMI in
+		 * vmcs02 if L1 is injecting an NMI.  Delivering the NMI blocks
+		 * NMIs, i.e. L2 still ends up with blocking by NMI set, the same
+		 * as it would on bare metal.  Note, nmi_known_unmasked is derived
+		 * from vmcs12's original value and so stays false, as required.
+		 */
+		if ((pin_controls_get(vmx) & PIN_BASED_VIRTUAL_NMIS) &&
+		    !nested_cpu_has_virtual_nmis(vmcs12) && is_nmi(intr_info))
+			interruptibility &= ~GUEST_INTR_STATE_NMI;
+
+		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
 			     vmcs12->vm_entry_exception_error_code);
 		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
 			     vmcs12->vm_entry_instruction_len);
-		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
-			     vmcs12->guest_interruptibility_info);
+		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, interruptibility);
 		vmx->loaded_vmcs->nmi_known_unmasked =
 			!(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_NMI);
 	} else {
-- 
2.47.3

