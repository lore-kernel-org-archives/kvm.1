Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377298;
	b=q/9amRKzU1hmFp1TrUZSsnVc6KUqJSS1EXuJXzNYqLoH8dBFlm/DMhl1/fUuRVHLj1aR
	 SanFYUwtdJYma3nquLytHV2pO4AvUZMbSRwrm7BXaGkdNU5kZfGBc7q7FRJQjXe6qCe1F
	 JzzW7XyJ22lmWO7D9JwmyIRcGeZ7gECDFexyjBSWYEnpGqi9KZwf4JKwSDnIR9nwyLcbs
	 px1Uvm/mL8h6+YDUnl4bwgyq2mgFQihLRjKCirGF/61VgSmrKu6YmQ7YrsG8MYwBD65Uh
	 K/MPDgajFD23yw1N+QIhh6VFF8fY+NTujxbmKYTqrV6gusNjpxGULpyjCjF3QOXZmGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377298;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=T0vffWeHSGD3k7NLrO/VgvIul7kmB79aWon4u9r87LM=;
	b=ZmvsjpnCnDbxYEqheu66EFLrIrgUEVD8HziWObbeHMzZh3TUn/4JImBS4+uSDMZcGjDq
	 TidYFZTtRR5VpVrXAkolM6JByJuSagoY9vi2VOpQ0ouk+orgJFoPx+fxILs/K2m2qesSZ
	 M7YiBEijOJTlIA2seWID9LEvjBneFvqdU4xluPwbAg75U7AdydQ5a2LAhqY6/mnm1tUca
	 1aqYwgERU4Lhohn6+JkyIcZPNLQ9NY9uDJJ0qULc3UFPwssmckFOQf+jWzXs1zgQQCE+A
	 3s2Wz+GOCupx4Bt8T/yTT8q0g02n1aR4GWM1YATvgoMWz82upPFl0AqP56Yha1FUpVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="LP6p/FfA";
	arc=none smtp.remote-ip=209.85.128.228
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30F9606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=LP6p/FfA
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-8b32b2e691aso26903107b3.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794377297; x=1794982097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0vffWeHSGD3k7NLrO/VgvIul7kmB79aWon4u9r87LM=;
        b=EuQ5YskoiKbe0voQL0kjwaV5NNN5Qp8NyD3G9ZnculDeuZt2N72piXkNwuGqarKYaT
         3fhP0g/s6Y+tCLmIeJbRb069tMQ1qRGvfq9hJRG8BqNeh08vbykdE5v+XlHxcmOUqXmw
         wFmScz5otXybAy8gBLZr26bfvkCmQ8t6zjYw2sZ/3DWAyR5qxAswXNAyyaD3i24+DNjC
         rR5/bN0PdWRBleXAkrtnfzpzR/oPVD/cyNlxUlCe0GItj17zqLq3Pg+jY3cG+cXH4E4v
         G4w8F6i9eY2ZDoFg7nzFSQNxdIEkNxIrK6ZlVTa6izDSuJxxqOzflB+haXNoHko20tNu
         yrSQ==
X-Forwarded-Encrypted: i=1; AL+hErExkWRimte7NmGtnWMPgbCHYXk3Bj5DMO7KtKpqPw13E+q4oqIaPjZmTYEigmjydIfpB4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2EnfIYdNpEu/KN/mhDl/pDyEba58qtrlg8fQvmwbfT5Kzgr3P
	LX/Bqp0R6h72it9MWUcYvU8Z2mGTn3QD7SfAHoUCBhn8XjePskXKYTzytnAgKye9zmChTTdFP/F
	icibqdBEIUiD8E4ZMwuoH1aRhRdAQvYCruztiwO6cUquMaahIATeA88vtSBw7yW3EKFs8FzUPcx
	N9cE5zyHhrlgRVfWwhlrmdpJYEvpKcDhXiuzm9tsYB6kEAm06jnm9httjwpjcxepB9ejqX05UVY
	AkX
X-Gm-Gg: AYBFou3/DA4fN4f0jW4deffiqLJ7484h8/coxq5GaV8n81fTx4KoC5ZOymEzWM61uUH
	Ye6ZEibH/s+jNsG8IRyA3DQ/niR2qrKTqdPrF33711+7BMxkyUjsSYHlt2z6otB2kGL13OGd2Zk
	pT1mxduFJBsi6NN4SkAPXtlpFtN/hRhyXtHJa6tAFtL3xyD+q01Ba78C8Dfd52BmuD6oP/GEM2J
	2HO42d9t3pPjjV0MEO/qbOc92CFoXZqAKh7W1Y1YiscgzjZYbgzr/F5XzSYkQmDvtpBWSW3fkWL
	ProG13vnBeoxyC0w20W6Jt6hOauW2JJgZ++fsrdh6KHNlOrG2D4TocujZLRApe7uxaamfIl5+K9
	NgqVixuQV7h/+VdI3BQbUpWWQAWTB2Y/arkGw3sNPlgmyyQ6wlvLHdT9K+PT1whu9kW/dPjj/pq
	F9wHeSW5RneI2JwR7HWJ7ecszH61VoBk/f
X-Received: by 2002:a05:690c:c4e3:b0:873:5c6b:a321 with SMTP id 00721157ae682-8b3a80e59e5mr12722807b3.27.1794377296701;
        Tue, 10 Nov 2026 22:08:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b3933b0e72sm265267b3.33.2026.11.10.22.08.15
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:08:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91c6c1e082bso46592176d6.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794377295; x=1794982095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T0vffWeHSGD3k7NLrO/VgvIul7kmB79aWon4u9r87LM=;
        b=LP6p/FfAufMP3li8gc3O/AYCJ1crV6gsCeNHfDwBQTQNyMiu+HiHMAzpbSkbydNPUM
         jk+ORKuuHGwrORM/hYL95fgXUwxHjttOvXmIJJwmOItIQgSUz2tmeOSebz0RvrlmTfNB
         la3DaFuuRnqIyfLuUt3cR+8XD0Q8c4Mv2H05g=
X-Forwarded-Encrypted: i=1; AL+hErHD8I0QmI84QYQKsYCEGFFTBMB8+e9l3rQRok/TJTIwloDVvD7SAdWsndMqoVlES7E9TGA=@vger.kernel.org
X-Received: by 2002:a05:620a:1723:b0:93f:3193:ac09 with SMTP id af79cd13be357-947ae82011emr309711385a.15.1794376830275;
        Tue, 10 Nov 2026 22:00:30 -0800 (PST)
X-Received: by 2002:a05:620a:1723:b0:93f:3193:ac09 with SMTP id af79cd13be357-947ae82011emr309704885a.15.1794376829606;
        Tue, 10 Nov 2026 22:00:29 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:28 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Doug Covelli <doug.covelli@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 07/12] KVM: x86: Route nested VMware backdoors to KVM
Date: Wed, 11 Nov 2026 00:59:56 -0500
Message-ID: <e03558351edde6ccd508fb38d9c2fd63e85370db.1794374897.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add KVM_VMWARE_ENABLE_NESTED_BACKDOOR.  When it and the backdoor flag
are both enabled, handle the #GP from a CPL3 VMware backdoor I/O access
in L2 in KVM, as for L1, even if L1 intercepts #GP.  Treat an access as
a backdoor access only if EAX holds VMware's magic value and DX selects
one of the two backdoor ports; L1 keeps receiving every other #GP.

VMware Tools use the I/O-port backdoor from user mode and rely on the
hypervisor ignoring the I/O permission checks for the backdoor ports.
When Hyper-V runs in the guest, e.g. for Windows virtualization-based
security (VBS), Windows and the Tools run as L2.  The access then
raises #GP and normal nested routing delivers it to Hyper-V, which
doesn't implement the backdoor.

Make the routing opt-in, because a nested hypervisor that implements
the backdoor itself, such as ESXi, has to keep receiving its guests'
accesses.  Cover only the I/O-port backdoor; L2 VMCALL and VMMCALL
handling doesn't change.

On VMX, claim the exit in nested_vmx_l0_wants_exit().  On SVM, a #GP
that L0 intercepts always reaches gp_interception() first, which
reinjects any #GP that KVM doesn't handle so that it reaches L1 if L1
intercepts #GP; check the filter there.

Link: https://lore.kernel.org/r/CADH9ctAGt_VriKA7Ch1L9U+xud-6M54GzaPOM_2sSA780TpAYw@mail.gmail.com
Link: https://lore.kernel.org/r/CABgObfb3Ttfg6H+_RpNQGSYKw9BLEwx3+EysXdL-wbpd1pkGHQ@mail.gmail.com
Link: https://lore.kernel.org/r/aAjrOgsooR4RYIJr@google.com
Link: https://lore.kernel.org/r/aIEnm7Y1VN-PCfF8@google.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 Documentation/virt/kvm/api.rst  |  9 +++++++++
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/svm/svm.c          |  7 +++++--
 arch/x86/kvm/vmware.c           |  8 ++++++++
 arch/x86/kvm/vmware.h           | 22 ++++++++++++++++++++++
 arch/x86/kvm/vmx/nested.c       |  5 +++++
 arch/x86/kvm/x86.c              |  3 ++-
 7 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e2f0e329f748..14ce68600551 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9293,6 +9293,15 @@ exception by setting ``vmware.hcall.exception.inject`` and filling in the
 validated vector, error code, and address fields.  When an exception is
 requested, KVM does not advance past the hypercall instruction.
 
+``KVM_VMWARE_ENABLE_NESTED_BACKDOOR`` makes KVM handle VMware backdoor I/O
+from a nested guest itself, even when the nested hypervisor intercepts #GP.
+KVM claims only a #GP raised at CPL3 while EAX holds VMware's magic value and
+DX holds one of the two backdoor ports; the nested hypervisor still receives
+every other #GP, and VMCALL/VMMCALL from the nested guest are not affected.
+This is needed, for example, for a Windows guest with Hyper-V VBS enabled:
+Hyper-V does not implement the VMware backdoor used by VMware Tools.  This
+flag has an effect only when ``KVM_VMWARE_ENABLE_BACKDOOR`` is also enabled.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 3b9f53bce2d9..18c2d908eaa2 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -968,6 +968,7 @@ struct kvm_hyperv_eventfd {
 
 #define KVM_VMWARE_ENABLE_BACKDOOR	_BITULL(0)
 #define KVM_VMWARE_ENABLE_HYPERCALL	_BITULL(1)
+#define KVM_VMWARE_ENABLE_NESTED_BACKDOOR _BITULL(2)
 
 struct kvm_vmware_exit {
 #define KVM_EXIT_VMWARE_HCALL	1
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a2196d8f60aa..bae7065fb360 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2408,9 +2408,12 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 
 	/*
 	 * VMware backdoor emulation on #GP interception only handles
-	 * IN{S}, OUT{S}, and RDPMC, and only for L1.
+	 * IN{S}, OUT{S}, and RDPMC.  Handle L2 accesses only when userspace
+	 * explicitly requests that L0 own the nested VMware backdoor.
 	 */
-	if (!kvm_is_vmware_backdoor_enabled(vcpu) || is_guest_mode(vcpu))
+	if (!kvm_is_vmware_backdoor_enabled(vcpu) ||
+	    (is_guest_mode(vcpu) &&
+	     !kvm_is_vmware_nested_backdoor(vcpu, svm_get_cpl(vcpu))))
 		goto reinject;
 
 	return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
diff --git a/arch/x86/kvm/vmware.c b/arch/x86/kvm/vmware.c
index 8407dccf81fd..066f033e7ea3 100644
--- a/arch/x86/kvm/vmware.c
+++ b/arch/x86/kvm/vmware.c
@@ -117,6 +117,14 @@ int kvm_vmware_hypercall(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+bool kvm_is_vmware_nested_backdoor(struct kvm_vcpu *vcpu, u32 cpl)
+{
+	return kvm_is_vmware_nested_backdoor_enabled(vcpu->kvm) && cpl == 3 &&
+	       lower_32_bits(kvm_rax_read_raw(vcpu)) == VMWARE_HYPERVISOR_MAGIC &&
+	       kvm_is_vmware_io_port(vcpu, kvm_rdx_read_raw(vcpu));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_is_vmware_nested_backdoor);
+
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port)
 {
 	return kvm_is_vmware_backdoor_enabled(vcpu) &&
diff --git a/arch/x86/kvm/vmware.h b/arch/x86/kvm/vmware.h
index de1dc8971ec6..e2ba0b8b4400 100644
--- a/arch/x86/kvm/vmware.h
+++ b/arch/x86/kvm/vmware.h
@@ -24,9 +24,19 @@ kvm_is_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
 }
 
 bool kvm_is_vmware_hypercall(struct kvm_vcpu *vcpu);
+
+static __always_inline bool
+kvm_is_vmware_nested_backdoor_enabled(struct kvm *kvm)
+{
+	return kvm_is_vmware_cap_enabled(kvm, KVM_VMWARE_ENABLE_BACKDOOR) &&
+	       kvm_is_vmware_cap_enabled(kvm,
+					 KVM_VMWARE_ENABLE_NESTED_BACKDOOR);
+}
+
 bool kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port);
 bool kvm_is_vmware_backdoor_pmc(struct kvm_vcpu *vcpu, u32 pmc_idx);
 bool kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode);
+bool kvm_is_vmware_nested_backdoor(struct kvm_vcpu *vcpu, u32 cpl);
 
 #else /* !CONFIG_KVM_VMWARE */
 
@@ -52,6 +62,12 @@ static __always_inline bool kvm_is_vmware_hypercall(struct kvm_vcpu *vcpu)
 	return false;
 }
 
+static __always_inline bool
+kvm_is_vmware_nested_backdoor_enabled(struct kvm *kvm)
+{
+	return false;
+}
+
 static __always_inline bool
 kvm_is_vmware_io_port(struct kvm_vcpu *vcpu, u16 port)
 {
@@ -70,6 +86,12 @@ kvm_is_vmware_backdoor_opcode(u8 opcode_len, u8 opcode)
 	return false;
 }
 
+static __always_inline bool
+kvm_is_vmware_nested_backdoor(struct kvm_vcpu *vcpu, u32 cpl)
+{
+	return false;
+}
+
 #endif /* CONFIG_KVM_VMWARE */
 
 void kvm_vmware_init_vm(struct kvm *kvm);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a98f28651f7..2d1297036564 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -18,6 +18,7 @@
 #include "posted_intr.h"
 #include "sgx.h"
 #include "trace.h"
+#include "vmware.h"
 #include "vmx.h"
 #include "smm.h"
 #include "x86_ops.h"
@@ -6490,6 +6491,10 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 			return true;
 		else if (is_ve_fault(intr_info))
 			return true;
+		else if (is_gp_fault(intr_info) &&
+			 kvm_is_vmware_nested_backdoor(vcpu,
+						       vmx_get_cpl(vcpu)))
+			return true;
 		return false;
 	case EXIT_REASON_EXTERNAL_INTERRUPT:
 		return true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bd4142763f10..6b6ed02d6063 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -119,7 +119,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host);
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
 #define KVM_CAP_VMWARE_VALID_MASK (KVM_VMWARE_ENABLE_BACKDOOR | \
-				   KVM_VMWARE_ENABLE_HYPERCALL)
+				   KVM_VMWARE_ENABLE_HYPERCALL | \
+				   KVM_VMWARE_ENABLE_NESTED_BACKDOOR)
 
 #define KVM_GUESTDBG_VALID_MASK \
 	(KVM_GUESTDBG_ENABLE | \
-- 
2.53.0

