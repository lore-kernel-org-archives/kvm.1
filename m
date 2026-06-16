Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1326B973;
	Tue, 16 Jun 2026 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570547; cv=none; b=g0ehpxvBGhGqVa0DhLwVzORxvM3Edfxlyk6wurIXXF/QKYQcD1QpzpLE+bwdizemj7mCumBR9jorodW3rASXN/TkSzDTOBD0QelyEF8Oj48LvSIDARVDvrG9PkTn9wxa1y2YBkfTeCG2afAU7d24evguWuM9+Jfro2/9Kmf3KI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570547; c=relaxed/simple;
	bh=Phelvbavkhk2x/Ji5A/nzLz2+kt2x4qyisQKk/KIoeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5wcr8kbIjKAU/5rfn3nzJ7yjEVf+Jh5MZp9LLepMp+Vi76UZfAQBHuoW6VmciL9U4Iyeo325evVMsm9qTv1xWCpNdA/639T0wNLJHKetb+/LRyQua16DaWulkTsB7OXHEUcCjDo2OORcEqcHxkaR9OnDNvOVeRNDa5QfwA6Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkGz+bIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkGz+bIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EF71F00A3D;
	Tue, 16 Jun 2026 00:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570545;
	bh=oi+PmDLU45wyjolxwmIOhLQlSO6Q0srjNtqYwb477XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RkGz+bIUBQMUumSWP3QIkWGU0gMz7fAe+WS9aAVWw65cjf9RTguwpd20kr2ImZVkT
	 5EjvNAUXPrdDIHgd/i4QDod1/CqQFBzl+77FFAc6mzSsf8Kj/hwfDz49MyS4DRAg1j
	 eANcsKp5eSiw/1mHs98yZtZtke7/Ihwwu90IELWOYjLE+g0NDpFUCsM4Zv2ZxPRuFK
	 RX31ix/hhua4D0L/RWd2JRB/nuDlbjd8UU4Ty1HHYEz2F1M3AzhGBmZK8p+SfHfJtO
	 QJA75sUHM4gURgQ4F8Arpz4iPRdFCTndemMqnBCQRB1rdqfce7O1StC4y0laVFVi4u
	 3LjUD3ERtlHaQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 08/25] KVM: SEV: Stop using per-vCPU ASID for SEV VMs
Date: Tue, 16 Jun 2026 00:41:37 +0000
Message-ID: <20260616004155.1435766-9-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

svm->asid is only used by SEV in the pre-run check, to update the ASID
in the VMCB. Otherwise, svm->asid is only used for non-SEV VMs to keep
track of the per-vCPU ASID, as SEV VMs use a per-VM fixed ASID instead.

Initialize the ASID in the VMCB one time in sev_init_vmcb() instead of
checking it on every vCPU run, and change the pre-run check to a stopgap
with a WARNING.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3c873c88894b3..f5173cde76173 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3555,10 +3555,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
 		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
 
-	/* Assign the asid allocated with this SEV guest */
-	svm->asid = asid;
-
-	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+	if (WARN_ON_ONCE(asid != svm->vmcb->control.asid)) {
 		svm->vmcb->control.asid = asid;
 		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	}
@@ -4763,6 +4760,9 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
 	clr_exception_intercept(svm, UD_VECTOR);
 
+	svm->vmcb->control.asid = sev_get_asid(vcpu->kvm);
+	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+
 	/*
 	 * Don't intercept #GP for SEV guests, e.g. for the VMware backdoor, as
 	 * KVM can't decrypt guest memory to decode the faulting instruction.
-- 
2.54.0.1136.gdb2ca164c4-goog

