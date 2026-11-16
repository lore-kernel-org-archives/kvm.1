Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816034;
	b=ZUpuFqQp7vPevDNmWXFnoVThqN43TAZNXy15im7baorgAB5JrvN3p5qGfsrOdRGZrC6n
	 thNr4PxZhBTI3+nEO0yvthQDHE4UsfT4c7jO8gGzKHfQZ6VH/LwlOdy+09WQtTR/Sw5n4
	 r5ZfkzL5OzQpI5KIthDODcnMLYucv2JgyNfF+7JtwplChfNplHAJDXowt+FrmcLTlWEMK
	 CauCiCFz3jHKk90liKp4jVWysGfTshNSVGvlAYSR1AZhh4TIAkRlO9UpVze+w0tuZv34P
	 SLg76d+PMcHVgtI7sKt1S1k4G8sPOjUcWl6aMbopeo9PriaBRn/vo8HDdcYDBWMBGGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816034;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=OpNIxYQP5qejuVWtKFHCVeasqyFNmqtZ4cu+mSDOhDg=;
	b=aXbaEoq0xkdw19I5l+v2qiBTVQeofF6wzsZ40j6e+r0sOMllxY9Wfxx9OMOI6U9ZIZvv
	 kxADHvNJ8HEfg9ZIt5zizAYf9w3os4g9W1A6hEWtJMPTjtL311KbGMHIPWuRGuEA8p+qr
	 TTpqZTE/UKiHtONWCVb54+8mzJXSTa6HysPnrl8rtzg8z0T4h7Bt6/jfib215leq4IZn2
	 QvRom86y5BqlIrzkbNHBEDtnFrPe/HOIltKJdlslOALNJyQUWc+zq5ckGT+NUS/HZzfdG
	 dSw1wDu6zDcPgdsz2r3DymgBNZadU0RDi0iiOK0gX3SGqdgGtE020bju7pNoBkr6mMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F608606A31C;
	Mon, 16 Nov 2026 08:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F608606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jSgJq153Xz73VN;
	Mon, 16 Nov 2026 16:00:27 +0800 (CST)
From: Daolong Zhang <dlzhangak@isoftstone.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daolong Zhang <dlzhangak@isoftstone.com>
Subject: [PATCH v2] KVM: VMX: Disallow 16-bit busy TSS (type 3) for TR in IA-32e mode
Date: Mon, 16 Nov 2026 16:00:26 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261116070819.980621-1-dlzhangak@isoftstone.com>
References: <20261116070819.980621-1-dlzhangak@isoftstone.com>
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 16 Nov 2026 16:00:27 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AFAB81A.00A by FangMail milter!
X-FangMail-Envelope: 1794816027/4jSgJq153Xz73VN/6AFAB81A.00A/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794816027.6AFAB81A.00A
X-FangMail-Outinfo: 1794816027/6AFAB81A.00A/4jSgJq153Xz73VN/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794816027.6AFAB81A.00A.4jSgJq153Xz73VN@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFAB81A.00A/4jSgJq153Xz73VN

According to Intel SDM Vol. 3C, "Checks on Guest Segment Registers", the
TR segment type must be 11 (64-bit busy TSS) when the "IA-32e mode guest"
VM-entry control is 1, and may be 3 (16-bit busy TSS) or 11 (32-bit busy
TSS) only when "IA-32e mode guest" is 0.

Currently, tr_valid() unconditionally allows type 3 even when the guest is
in IA-32e mode (long mode). When emulate_invalid_guest_state is enabled,
this causes __vmx_guest_state_valid() to falsely report a valid guest state
for a 64-bit guest with a 16-bit busy TSS, resulting in a hardware VM-Entry
failure (EXIT_REASON_INVALID_STATE / KVM_EXIT_FAIL_ENTRY) instead of
emulating the invalid guest state.

Check is_long_mode(vcpu) in tr_valid() and reject type 3 when the vCPU is
in IA-32e mode. Also update vmx->vt.emulation_required in vmx_set_efer() so
that changes to EFER.LMA (such as in prepare_vmcs02() after vmx_set_cr0())
keep emulation_required in sync with vmx_guest_state_valid().

Fixes: 648dfaa7df2d ("KVM: VMX: Add Guest State Validity Checks")
Signed-off-by: Daolong Zhang <dlzhangak@isoftstone.com>
---
v2:
- Recompute vmx->vt.emulation_required in vmx_set_efer() so that EFER.LMA
  updates (e.g. in prepare_vmcs02() after vmx_set_cr0()) do not leave
  emulation_required out of sync with vmx_guest_state_valid().
- Use full real name ("Daolong Zhang") in Author and Signed-off-by.

 arch/x86/kvm/vmx/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..bc5137a3fb68 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3253,6 +3253,7 @@ int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 #endif
 
 	vmx_setup_uret_msrs(vmx);
+	vmx->vt.emulation_required = vmx_emulation_required(vcpu);
 	return 0;
 }
 
@@ -3898,7 +3899,7 @@ static bool tr_valid(struct kvm_vcpu *vcpu)
 		return false;
 	if (tr.selector & SEGMENT_TI_MASK)	/* TI = 1 */
 		return false;
-	if (tr.type != 3 && tr.type != 11) /* TODO: Check if guest is in IA32e mode */
+	if (tr.type != 11 && (is_long_mode(vcpu) || tr.type != 3))
 		return false;
 	if (!tr.present)
 		return false;
-- 
2.48.1

