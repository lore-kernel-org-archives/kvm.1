Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21F427A19
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894758; cv=none; b=cr2LSB2WzWQKUGFjI0JkbiXvJvr11Ag/T6TQzsjDWhkXXFff3w725qqaw4jsLquCLH4j/eVWvL7BtmRXPcyJ7vkxU13lUlk9XqdGrJGFvYjzz6XJh3ZTNPbrxzE1ehD123H8ijRSGXzFk+2Dp/2snDO7DJr81Dn4UQhSBmtpCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894758; c=relaxed/simple;
	bh=54pCca4u/4SxaoPIhdN0+Yy/HhZ7Fwzo9FkBJGeh7rA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hU5p7ETga+1YVCLALfNJ0TiwUpFVeUEP+r3vC4HllcNFoRBrQVO4BU3lLAcRMkLJITde+5HFAHOTp6ySLSPV6BRpEB3JvhuciwRvERD0POTj4QHS9dWhBn1FWlhu7ouH5DTBfrw8boHIt21HE0LlWWoY/UpHpCzeoaWfgt7C9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jqt4bN8v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jqt4bN8v"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso132839465ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779894756; x=1780499556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jlmZgvXK0NiIBGQ2mBoJwIyVq3CTX90trN7/DiTSqu8=;
        b=Jqt4bN8vWNVmNkHvU/7NjC/614Tp2e1hPcjg7lVne8gunDL+syxoUZ8SWx5uIRvKkh
         GR4S8va8qYvwp1YRwXnWIsWyVq+TRy0ng5UZMsev86TNSU2XgsKfXBEjSaKAhckKS2j9
         xV2d8gdkREXkWglkX5la8PQ6FbIy44g+/SwBZEQ9i3i+gRAaBJIHLvO0zqNgiTfwADWp
         pyos+wRqBvDLsKsxqy28smscOocSqni2exqOTaCe6E83zLNtJJw23vRpGXA5e7WMsFrH
         s0D+NdfQXdHP7HeyJobROC9kF5xDG4PWbV1CN7PeFvvaGh3ame1pJKoS1jqxpbjpcA9W
         j4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779894756; x=1780499556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlmZgvXK0NiIBGQ2mBoJwIyVq3CTX90trN7/DiTSqu8=;
        b=kiBCMPQc4xhlqLZTAGVl/mZdVp0BH1Rc94uU06fYrE0lehEcGS/MxT+4JO3f8w8dYw
         8JVh+t+5dUWwIfvRYEX3hc1am6uoh7zTEbP4Qb4VduEOWrtNst90YprcuHj5/7SuFwyx
         COFCRUHjIUOydkCjL1C0YcHFWoBmVFfu3xv4yIoBtX4zf6faWt90cxX+jO/PQGrTX8vw
         O6+fqWanwzgji4XYRpdjxv+vX1SxSGBUg1Rwqbssl8WD3zT1p/gfeouBj1DMJNpOBp88
         uIJHQlaXyqOx451yCiSaQOri/FJGwxafHUzQg7a/mgsnXTkMCkPztUUb6u5h8NwPn/O0
         jgCQ==
X-Gm-Message-State: AOJu0YwiRwws9Rput1uxfK4O43YlvLligwQLVJgMiF9gexZKw2FK96mM
	Frrtq+x0MRv9ub2gtJtWzpMbpzxh4FI65c7DpslUmXwvTVKMB/nyQUjQiIBhpX6wcBIUpF6xGV+
	yeeQlOA==
X-Received: from plky7.prod.google.com ([2002:a17:902:7007:b0:2bd:9a1:9a05])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d482:b0:2bd:2de3:519f
 with SMTP id d9443c01a7336-2beb074f92cmr262118715ad.19.1779894755943; Wed, 27
 May 2026 08:12:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 08:12:32 -0700
In-Reply-To: <20260527151232.4058615-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527151232.4058615-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260527151232.4058615-3-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 2/2] x86/vmx: (Re)Add a nVMX test to
 validate load/save of DEBUGCTL
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Chenyi Qiang <chenyi.qiang@intel.com>

Add a nVMX test to verify that DEBUGCTL is/isn't loaded/saved on entry/exit
as per vmcs12's controls.  Validate all combinations of legal values (only
three bits are supported, i.e. there are only 8 unique combinations), for
both the host and the guest, along with '0'.

Validate that:

 - DEBUGCTL is loaded from vmcs.GUEST_DEBUGCTL iff "Load debug controls"
   is set, otherwise the guest should see the host's value.
 - DEBUGCTL is saved to vmcs.GUEST_DEBUGCTL iff "Save debug controls" is
   set, otherwise the VMCS should retain its previous value.
 - DEBUGCTL is *always* zeroed on VM-Exit, irrespective of guest controls.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/msr.h   |   2 +
 x86/vmx_tests.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)

diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index 7397809c..8b019f7e 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -103,12 +103,14 @@
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
+#define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
 #define DEBUGCTLMSR_BTINT		(1UL <<  8)
 #define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
 #define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
 #define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
+#define DEBUGCTLMSR_RTM_DEBUG		(1UL << 15)
 
 #define MSR_LBR_NHM_FROM	0x00000680
 #define MSR_LBR_NHM_TO		0x000006c0
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index e1f53fbe..f914924d 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11774,6 +11774,155 @@ static void vmx_cet_test(void)
 	test_set_guest_finished();
 }
 
+static u64 vmx_debugctl_test_val;
+
+static void vmx_debugctl_test_guest(void)
+{
+	for (;;) {
+		vmx_debugctl_test_val = rdmsr(MSR_IA32_DEBUGCTLMSR);
+		vmcall();
+
+		wrmsr(MSR_IA32_DEBUGCTLMSR, vmx_debugctl_test_val);
+		vmcall();
+	}
+}
+
+static void __run_vmx_debugctl_guest(void)
+{
+	u64 val;
+
+	enter_guest();
+	skip_exit_vmcall();
+
+	/* Verify DEBUGCTL is unconditionally zeroed on VM-Exit. */
+	val = rdmsr(MSR_IA32_DEBUGCTLMSR);
+	if (val)
+		report_fail("DEBUGCTL = 0x%lx (not zeroed on VM-Exit)", val);
+}
+
+static u64 run_vmx_debugctl_guest(u64 msr_val, u64 vmcs_val, u64 write_val)
+{
+	u64 read_val;
+
+	wrmsr(MSR_IA32_DEBUGCTLMSR, msr_val);
+	vmcs_write(GUEST_DEBUGCTL, vmcs_val);
+
+	__run_vmx_debugctl_guest();
+	read_val = vmx_debugctl_test_val;
+
+	vmx_debugctl_test_val = write_val;
+	__run_vmx_debugctl_guest();
+
+	return read_val;
+}
+
+static void __vmx_debugctl_test(u64 host_val, u64 guest_val)
+{
+	u64 val, rand;
+
+	/* Validate VM-Entrywhen save/load debug controls are set */
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+	/* Verify guest DEBUGCTL is loaded/saved when the controls are set. */
+	val = run_vmx_debugctl_guest(host_val, guest_val, 0);
+	report(val == guest_val, "Load DEBUGCTL = 0x%lx, guest RDMSR = 0x%lx", guest_val, val);
+	val = vmcs_read(GUEST_DEBUGCTL);
+	report(!val, "Save DEBUGCTL = 0x0, guest WRMSR = 0x%lx", val);
+
+	/* Rerun the test with the guest values flipped. */
+	val = run_vmx_debugctl_guest(host_val, 0, guest_val);
+	report(!val, "Load DEBUGCTL = 0x0, guest RDMSR = 0x%lx", val);
+	val = vmcs_read(GUEST_DEBUGCTL);
+	report(val == guest_val, "Save DEBUGCTL = 0x0%lx, guest WRMSR = 0x%lx", val, guest_val);
+
+	/*
+	 * If running without the LOAD control set is supported, validate that
+	 * the guest sees the host's value.  Scribble vmcs.GUEST_DEBUGCTL with
+	 * a random value to verify it's ignored.
+	 */
+	if (!(ctrl_enter_rev.set & ENT_LOAD_DBGCTLS)) {
+		vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+
+		val = run_vmx_debugctl_guest(host_val, rdtsc(), guest_val);
+		report(val == host_val, "Host DEBUGCTL = 0x%lx, guest RDMSR = 0x%lx", host_val, val);
+
+		/* The guest value should still be saved on exit! */
+		val = vmcs_read(GUEST_DEBUGCTL);
+		report(val == guest_val, "Save DEBUGCTL = 0x%lx, guest WRMSR = 0x%lx", val, guest_val);
+
+		vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	}
+
+	if (!(ctrl_exit_rev.set & EXI_SAVE_DBGCTLS)) {
+		vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+		/* Verify the guest's value is NOT saved on exit.*/
+		val = run_vmx_debugctl_guest(host_val, guest_val, 0);
+		report(val == guest_val, "Load DEBUGCTL = 0x%lx, guest RDMSR = 0x%lx", guest_val, val);
+		val = vmcs_read(GUEST_DEBUGCTL);
+		report(val == guest_val, "VMREAD DEBUGCTL = 0x%lx, VMWRITE = 0x%lx", val, guest_val);
+
+		/* And again with the values flipped. */
+		val = run_vmx_debugctl_guest(host_val, 0, guest_val);
+		report(!val, "Load DEBUGCTL = 0x0, guest RDMSR = 0x%lx", val);
+		val = vmcs_read(GUEST_DEBUGCTL);
+		report(!val, "VMREAD DEBUGCTL = 0x%lx, VMWRITE = 0x0", val);
+
+		vmcs_set_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+	}
+
+	if ((ctrl_enter_rev.set & ENT_LOAD_DBGCTLS) ||
+	    (ctrl_exit_rev.set & EXI_SAVE_DBGCTLS))
+		return;
+
+	vmcs_clear_bits(ENT_CONTROLS, ENT_LOAD_DBGCTLS);
+	vmcs_clear_bits(EXI_CONTROLS, EXI_SAVE_DBGCTLS);
+
+	rand = rdtsc();
+	val = run_vmx_debugctl_guest(host_val, rand, guest_val);
+	report(val == host_val, "Host DEBUGCTL = 0x%lx, guest RDMSR = 0x%lx", host_val, val);
+
+	val = vmcs_read(GUEST_DEBUGCTL);
+	report(val == rand, "VMWRITE DEBUGCTL = 0x%lx, VMREAD = 0x%lx", rand, val);
+}
+
+static void vmx_debugctl_test(void)
+{
+	u64 supported_bits = 0;
+	u64 i, j;
+
+	if (this_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
+		supported_bits |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	if (this_cpu_has(X86_FEATURE_RTM))
+		supported_bits |= DEBUGCTLMSR_RTM_DEBUG;
+
+	if (this_cpu_has(X86_FEATURE_PDCM) && pmu_lbr_version())
+		supported_bits |= DEBUGCTLMSR_LBR;
+
+	if (!supported_bits) {
+		report_skip("%s : No DEBUGCTL features supported", __func__);
+		return;
+	}
+
+	test_set_guest(vmx_debugctl_test_guest);
+	msr_bmp_init();
+
+	for (i = 1; i <= supported_bits; i++) {
+		if ((i & supported_bits) != i)
+			continue;
+
+		for (j = 1; j <= supported_bits; j++) {
+			if ((j & supported_bits) != j)
+				continue;
+
+			__vmx_debugctl_test(i, j);
+		}
+	}
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -11890,5 +12039,6 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
+	TEST(vmx_debugctl_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0.823.g6e5bcc1fc9-goog

