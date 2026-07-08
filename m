Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ABF3D6CB5;
	Wed,  8 Jul 2026 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492453; cv=none; b=X/IrDhEzomESacEvVjq10Gca2FpILPp7zmL14oi+buy9xFLcMkGdIIYi+qlWKGIqGcRMB5m77ubm0jrOE1luwXoGqh8938aQzvDAYajkeomTE4uoB108p0E7IGM6lBqI1RkMdrwWh7C/DAqEJKWfAotSzUk+Dj7OR7/6CnCf2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492453; c=relaxed/simple;
	bh=lMh8zglzSC7jN4oI6G4ZklNXGEiK7nR+L2UQYoDbKLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQVUE9UW7VVT5a0JzOVJzlzV5xia/+QN4K5nbExRCvUQqGDk25dRomhdFLaYVOoBHgtxghZSD600nCeamaf87FwPEMy3q9ataMvdxOGEtkArwbHvyhx4QnHKjdiynX769G0MJCp24W3fsSisMYebyDMNBJmnRicegAlZ7HYrabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGLlQLuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGLlQLuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA93E1F000E9;
	Wed,  8 Jul 2026 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492450;
	bh=VL9SoI5JXfo0fjaokslxw2CWfMKeEYOdQy9PSeGRFHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DGLlQLuXIKkL9PSy7eP8/xS4qXPSpKHWTw1LsEsybRncVZdywM+J/AXYbgvfQxPDj
	 t0kzVuAu+qn67joY+YC0xKTVOVBWTyRW1og1tcKZLdyMCtmemRhwKpgXIBiJte3lCh
	 NLgoxE0kLFt049QGgoG8zjxzW+Q28/clwQJzqoNUIVJ6bk6qLz8B1XTIcJwaZhxG71
	 /hOHFTfUd3B8J3NJ2gnouZEzjSTbIP0YXZ824XB8iVpi4G4rWJRSMa75deVRWTu9e2
	 2GCL6VV2pzpX5aa09l7KSudraCvSn3/Gz2UqRWgdPLVDX5hOkfWgbG/VG8eb3FNfDS
	 z75+prBod2tyw==
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
Subject: [RFC PATCH v3 13/27] KVM: SVM: Warn if we ever receive AVIC_UNACCELERATED_ACCESS #VMEXIT
Date: Wed,  8 Jul 2026 12:02:11 +0530
Message-ID: <b9002fe252bb71b733cfa304e6201b3e4780d1e1.1783490022.git.naveen@kernel.org>
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

With Secure AVIC, all AVIC-related exits are NAE (Non-Automatic Exits)
and result in a #VC in the guest rather than a #VMEXIT. The guest can
then use GHCB to request specific services from the hypervisor. As such,
we should never see AVIC_UNACCELERATED_ACCESS exits in KVM. Add a
WARN_ON() so that it is clear that something is wrong.

Note that AVIC_INCOMPLETE_IPI is still possible via VMGEXIT.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/kvm/svm/avic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index bfd758369b5a..bf701e604a85 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -896,6 +896,10 @@ int avic_unaccelerated_access_interception(struct kvm_vcpu *vcpu)
 
 	trace_kvm_avic_unaccelerated_access(vcpu->vcpu_id, offset,
 					    trap, write, vector);
+
+	if (WARN_ON_ONCE(snp_is_secure_avic_enabled(vcpu->kvm)))
+		return 1;
+
 	if (trap) {
 		/* Handling Trap */
 		WARN_ONCE(!write, "svm: Handling trap read.\n");
-- 
2.54.0

