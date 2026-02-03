Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223227261C
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149436; cv=none; b=my0SJhNmtI+DFoWe2hAEPCrtXjuVuwdXecsuYPNPxRiRr16RZe7F6xF89Y5c/fflC3EqMeF4zpIehAvDsZGYuhyRCy+UmQpLmwuuGiOf/AX/4y9VTPGfAHMrHJyg3fNL4cnjcffOPD8MoZFP5EaC6mpQj8e910zjDbgGP01Ii+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149436; c=relaxed/simple;
	bh=bnDpjcSrDoRNyjLvlvb/NIlWWObeZ/aDpAo97WaTceA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhflBrH4XBXxd6lzUEbBMK6lb6vrnkwkwpZYbhcnFFGn2/K8Z4EMLJsdM9Q1X//b34GHIQiHSMYhxyL/fGAjfScWzk27IdHdtlGMBJ+KpnXE4jNHNQb0Pd1RIw2uU6Gqj1xNXQzfCwlijHQgMIRhq8onoeIlv3IeNclm/g5RX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFNcUX6+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFNcUX6+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770149432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=49fvAypvxQjy5cbeO6yjyzJIKDlDs+aHkdGWaTIzEQM=;
	b=kFNcUX6+s1q04r8ql7o4Znq/aifEk3O6eT43nSKTQsMepdVVBjVGBQLIn2Dn/1zCfuUX+V
	QcFnKA1knTLmLqqDsGHeYxDzOYJErYUku97/sRxvpqiEC3crxd9cjfHOBHzmbAWR8iL/Eb
	Br5uvXiy3S+vY/VBbV7Kz/i9ylE4d80=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
Date: Tue,  3 Feb 2026 20:10:10 +0000
Message-ID: <20260203201010.1871056-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

KVM currently uses the value of CR2 from vmcb02 to update vmcb12 on
nested #VMEXIT. This value is incorrect in some cases, causing L1 to run
L2 with a corrupted CR2. This could lead to segfaults or data corruption
if L2 is in the middle of handling a #PF and reads a corrupted CR2. Use
the correct value in vcpu->arch.cr2 instead.

The value in vcpu->arch.cr2 is sync'd to vmcb02 shortly before a VMRUN
of L2, and sync'd back to vcpu->arch.cr2 shortly after. The value are
only out-of-sync in two cases: after save+restore, and after a #PF is
injected into L2. In either case, if a #VMEXIT to L1 is synthesized
before L2 runs, using the value in vmcb02 would be incorrect.

After save+restore, the value of CR2 is restored by KVM_SET_SREGS into
vcpu->arch.cr2. It is not reflect in vmcb02 until a VMRUN of L2. Before
that, it holds whatever was in vmcb02 before restore, which would be
zero on a new vCPU that never ran nested. If a #VMEXIT to L1 is
synthesized before L2 ever runs, using vcpu->arch.cr2 to update vmcb12
is the right thing to do.

The #PF injection case is more nuanced.  Although the APM is a bit
unclear about when CR2 is written during a #PF, the SDM is more clear:

	Processors update CR2 whenever a page fault is detected. If a
	second page fault occurs while an earlier page fault is being
	delivered, the faulting linear address of the second fault will
	overwrite the contents of CR2 (replacing the previous address).
	These updates to CR2 occur even if the page fault results in a
	double fault or occurs during the delivery of a double fault.

KVM injecting the exception surely counts as the #PF being "detected".
More importantly, when an exception is injected into L2 at the time of a
synthesized #VMEXIT, KVM updates exit_int_info in vmcb12 accordingly,
such that an L1 hypervisor can re-inject the exception. If CR2 is not
written at that point, the L1 hypervisor have no way of correctly
re-injecting the #PF. Hence, if a #VMEXIT to L1 is synthesized after
the #PF is injected into L2 but before it actually runs, using
vcpu->arch.cr2 to update vmcb12 is also the right thing to do.

Note that KVM does _not_ update vcpu->arch.cr2 when a #PF is pending for
L2, only when it is injected. The distinction is important, because only
injected (but not intercepted) exceptions are propagated to L1 through
exit_int_info. It would be incorrect to update CR2 in vmcb12 for a
pending #PF, as L1 would perceive an updated CR2 value with no #PF.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---

v1 -> v2:
- Dropped added comment (in favor of an incoming change that overrides
  it) [Sean].
- Updated commit log [Sean & myself].

v1: https://lore.kernel.org/kvm/20260203011320.1314791-1-yosry.ahmed@linux.dev/

---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd5..9031746ce2db1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1156,7 +1156,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	vmcb12->save.efer   = svm->vcpu.arch.efer;
 	vmcb12->save.cr0    = kvm_read_cr0(vcpu);
 	vmcb12->save.cr3    = kvm_read_cr3(vcpu);
-	vmcb12->save.cr2    = vmcb02->save.cr2;
+	vmcb12->save.cr2    = vcpu->arch.cr2;
 	vmcb12->save.cr4    = svm->vcpu.arch.cr4;
 	vmcb12->save.rflags = kvm_get_rflags(vcpu);
 	vmcb12->save.rip    = kvm_rip_read(vcpu);
-- 
2.53.0.rc2.204.g2597b5adb4-goog

