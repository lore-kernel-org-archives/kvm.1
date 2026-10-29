Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241608;
	b=hsGW6f2cUxgoepvmlDLwxD9Kmx+HnWzDuOoZr6vYU29EZOPxNgYiP9i58llwAa3RZZgi
	 1jUYRdxM7BYZwzkMS+uJ9HNtgSYl7WKQSZySfi9miwPQTxOOzxGEOhGouvlIV1Y2z1tiL
	 MFMGXrnDcMDSD6gMVZ4QedqgrXOGnsi2KHsBS3rKljJsVwb9spkZgG3GGXu71MFIgd9Ck
	 znbT0NXl7Yt7eIJp6E8eL4M8ipN6blnk5b+Y6zGyoRf4//iynCbDJNIqkrCq/qFL/Qu5i
	 K2vxZsUPjj/prJCFf8EaeqfbUmHwIZdSJhW2p4Cja1qHy9nZYlSm50PUJJ767gWEdww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=mGjN9aODgDZWsyKuNzIImj2EbIkJlnZJp0/pD8Vzl+Q=;
	b=l3QoRTmVP4Z52zFi3eYxQLX5emHuIEhvnsimpbtzBzFvwIlbbrPNTDZg39awdhijWFz9
	 mWePqhbdfbNpcsa8D7+B/iJ1owPBz8Cv8UFF0ErbpcSgyDZx7nFU6H5yC9wzCjY81BN3k
	 z6MCh4MCXCB4GEEfIMkTfM4Ugn51IVozbLQBoK61HfwfekuPpPPxf+FN08b3GL4ZzKvQi
	 TXXUCICgwa8Q+Q2mSriTCwOP8OG+t2Wh31O5FG2Kz6/v6rxdxKSp10M34uM6iXCoP9Zzf
	 bkshpidYP6auXOjv9cqWfYYUEdk6VHIZjqP8nXK/pv4mwYCG/Lm9bbT/4KnU1dqIrxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BWRQ1pb/";
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BE606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 02:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 629BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BWRQ1pb/
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a5971cf7ceso2252118b3a.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793241608; x=1793846408; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGjN9aODgDZWsyKuNzIImj2EbIkJlnZJp0/pD8Vzl+Q=;
        b=BWRQ1pb/eyZxR7ChrMzixFtXwQHuJO4CObtW4h/jzpgGWcJAk9ZzXP0Ehd60qELgCT
         Htwi31jDIq1duCWNNrxaKUYnYMb0pyze6SvMEPf+dQcnXgOvAFdXWQOHsQ8a30nCw+ME
         XombK+U+YLupuWO6ii4MX/tMznhLenTf9YomAhffwp4k3GCY3+VE99tD7RsNuCKaVJ0m
         KNXwUrsYK8rCSG8zuRTA2fLbIqAAZJ0yapFX5UUrD6yA31zkLJ/F/8zeJ68PsoEY74PL
         yAedEOgI47XM0K8EnH1Zgvxsgod6bzkQkFnyR8n9f4HTxXi7PSaViuttjPRqo1nIaLWq
         6RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793241608; x=1793846408;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGjN9aODgDZWsyKuNzIImj2EbIkJlnZJp0/pD8Vzl+Q=;
        b=2c4S0IsrjoQHxGuIplU2fNf50wq2k0kS+FxSGCC54TNpmLp2+N4flF5F370b1zidh5
         WSiHmkL0UIbZJV9rPli0dL4e+uT5DOuUtnyPf/0V/jPvQcU9aglCmRz49BQJGn9pB8VV
         i/e8k/oWIxG4ouXoV/co14ju0XTay74bM6jHFPQQjHyNROYemLVapBXNtdLvWFfs60ag
         /NDyN+qmH8g48gLBhRKRI9Q39sijHlRIGtbh22xuv6IIB0/28nsjrsjkcYUxmQqd1xQv
         6k+CALuL2FU013MWHdiNpmSgX70e7/q3gyQ1wnQDJd/uJHcNCPddTnlztrfGs6NnT5Xr
         Pu2A==
X-Gm-Message-State: AFq9FYJHACyncRYT70R8Cu1oGQxjW3u9tcOegIezPFRm1DARrsxxwUn+
	LomNAhf91MTqWsx8nAgJrskWkGMLgEOm92X83OBuM7aC1ml6UYr8nVs8+NBeomHV2IX2b5BlM7B
	Av2ntu9FrSljQpQ==
X-Received: from pfnz17.prod.google.com ([2002:aa7:85d1:0:b0:88e:7f97:e965])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:139d:b0:857:726d:2e96 with SMTP id d2e1a72fcca58-8a6e6b19620mr3929384b3a.19.1793241607469;
 Wed, 28 Oct 2026 19:40:07 -0700 (PDT)
Date: Thu, 29 Oct 2026 02:40:05 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029024005.575065-1-chengkev@google.com>
Subject: [PATCH] KVM: nVMX: Synthesize advanced VM-Exit info for emulated EPT Violations
From: Kevin Cheng <chengkev@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, yosry@kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

When synthesizing an EPT Violation to inject into L1 in response to a
fault detected while emulating an L2 GVA access, populate bits 11:9 of
EXIT_QUALIFICATION, i.e. the "advanced VM-Exit information", with the U/S,
R/W, and X/NX attributes of the L2 linear address' translation.

KVM has advertised VMX_EPT_ADVANCED_VMEXIT_INFO_BIT to L1 since
commit a0efd8cb221f ("KVM: nVMX: pass advanced EPT violation vmexit info
to guest"), but has never correctly populated bits 11:9 for synthesized
faults.  Originally the bits were pulled from vmcs02.EXIT_QUALIFICATION,
which is stale and/or holds unrelated data when the fault didn't come
from an EPT Violation VM-Exit.  Commit 96b067b59ad9 ("KVM: VMX:
Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits")
correctly stopped consuming the stale vmcs02 data for synthesized faults,
but nothing in the synthesized path sets bits 11:9, and so L1 now always
observes a supervisor, read-only, executable translation for every
synthesized EPT Violation.  Per the SDM, bits 11:9 are valid whenever
bits 7 and 8 (GVA_IS_VALID and GVA_TRANSLATED) are set and advanced
VM-Exit information is supported.

Fill in the bits from vmx_translate_nested_gpa(), which already receives
the effective L2 pte_access (for MBEC), rather than from the EPT walker
in paging_tmpl.h: the L2 page attributes are not EPT properties and so
are not visible to the EPT walker, and the nonpaging L2 case (CR0.PG=0,
where every linear address is architecturally user-mode, writable, and
executable) is handled for free as nonpaging_gva_to_gpa() passes ACC_ALL.

Skip the synthesis for EPT Misconfigs, as the walker doesn't initialize
exit_qualification for misconfigs and the injection path ignores it, and
leave bits 11:9 clear when GVA_TRANSLATED is clear, as the bits are
architecturally undefined in that case.

Explicitly strip bits 11:9 from the synthesized fault's exit qualification
in nested_ept_inject_page_fault() when L1 isn't advertised advanced
VM-Exit information. Previously that was implicitly guaranteed because
nothing set the bits in the synthesized fault, but now that
vmx_translate_nested_gpa() does, relying on the bits being outside the
"take from the fault" mask would leak them to L1.

Fixes: a0efd8cb221f ("KVM: nVMX: pass advanced EPT violation vmexit info to guest")
Signed-off-by: Kevin Cheng <chengkev@google.com>
Assisted-by: LLM
---
Tested on hardware with advanced VM-Exit information support by running
the vmx kvm-unit-tests, including a new ept_access_test_adv_info test
(will be sent separately) that exercises bits 11:9 for both native
accesses, where the bits are propagated from vmcs02, and emulated accesses
(string I/O), where KVM must synthesize the bits.  The emulated cases fail
without this patch and pass with it.

Per Documentation/process/generated-content.rst: an LLM-based coding
assistant was used to help analyze the nested EPT fault-injection paths
and review the EXIT_QUALIFICATION bit handling.  The code and changelog
were written, reviewed, and tested by the author.

 arch/x86/kvm/mmu/paging_tmpl.h |  3 ++-
 arch/x86/kvm/vmx/nested.c      | 49 ++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c..7023872b5ebb 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -508,7 +508,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
 	 * [7:8] - Derived from "fault stage" access bits
-	 * [9:11] - Derived from [9:11] of real exit_qualification
+	 * [9:11] - Filled in by the caller (vmx_translate_nested_gpa()) based
+	 *          on the L2 page table walk, if the fault is synthesized.
 	 *
 	 * The other bits are set to 0.
 	 */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..f7cee9b3a7dd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -452,15 +452,22 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
+			const u64 adv_info = EPT_VIOLATION_GVA_USER |
+					     EPT_VIOLATION_GVA_WRITABLE |
+					     EPT_VIOLATION_GVA_NX;
 			u64 mask = EPT_VIOLATION_GVA_IS_VALID |
 				   EPT_VIOLATION_GVA_TRANSLATED;
 
 			if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
-				mask |= EPT_VIOLATION_GVA_USER |
-					EPT_VIOLATION_GVA_WRITABLE |
-					EPT_VIOLATION_GVA_NX;
+				mask |= adv_info;
 
-			exit_qualification = fault->exit_qualification & ~mask;
+			/*
+			 * Always drop the advanced VM-Exit information bits from
+			 * the synthesized fault, as they are undefined unless L1
+			 * is advertised support, in which case they'll be filled
+			 * in below from the appropriate source.
+			 */
+			exit_qualification = fault->exit_qualification & ~(mask | adv_info);
 
 			/*
 			 * Use the EXIT_QUALIFICATION from the VMCS if and only
@@ -7499,7 +7506,39 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
 		access |= PFERR_USER_MASK;
 
-	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
+	gpa = w->gva_to_gpa(vcpu, w, gpa, access, exception);
+	if (likely(gpa != INVALID_GPA) || !exception)
+		return gpa;
+
+	/*
+	 * Synthesize the "advanced VM-Exit information" bits for EPT
+	 * Violations that are the result of translating a linear address.
+	 * Bits 11:9 of EXIT_QUALIFICATION report the U/S, R/W, and X/NX
+	 * attributes of the linear address' translation, which are known only
+	 * to the caller walking L2's page tables, i.e. are not visible to the
+	 * EPT walker (nor should they be, they aren't EPT properties).
+	 *
+	 * Note, bits 11:9 are architecturally undefined if bit 8 is '0', i.e.
+	 * if the access wasn't to the final translation, and must be '0' if
+	 * L1 doesn't support advanced VM-Exit information (handled when the
+	 * fault is injected into L1).  Note #2, when L2 has paging disabled,
+	 * every linear address is a user-mode, writable, and executable
+	 * address, which is exactly what the nonpaging MMU passes in.  Lastly,
+	 * EPT Misconfigs don't have an EXIT_QUALIFICATION, don't touch it.
+	 */
+	if ((exception->error_code & PFERR_RSVD_MASK) ||
+	    !(exception->exit_qualification & EPT_VIOLATION_GVA_IS_VALID) ||
+	    !(exception->exit_qualification & EPT_VIOLATION_GVA_TRANSLATED))
+		return gpa;
+
+	if (pte_access & ACC_USER_MASK)
+		exception->exit_qualification |= EPT_VIOLATION_GVA_USER;
+	if (pte_access & ACC_WRITE_MASK)
+		exception->exit_qualification |= EPT_VIOLATION_GVA_WRITABLE;
+	if (!(pte_access & ACC_EXEC_MASK))
+		exception->exit_qualification |= EPT_VIOLATION_GVA_NX;
+
+	return gpa;
 }
 
 struct kvm_x86_nested_ops vmx_nested_ops __initdata = {
-- 
2.56.0.313.g2479322e68-goog

