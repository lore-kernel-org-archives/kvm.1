Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3148E25B09D;
	Tue, 28 Jul 2026 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198969; cv=none; b=Hr7UflrS5Qm2ESbrGbzRW3BXQ9IkGI8d83JkxhXU1hqIV1QUM8L4AD6HB082UQKovJ77a1R4hnbNizD3acNXu3Ew2NyickjIsGvbymdN5XLUemFC4A4codIqpXZaEpUmPeuzCTTW1TTX1kJJym4SfUVgijEbbF/jg9l5UxRyPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198969; c=relaxed/simple;
	bh=d5kRD2W5QulVHdc8Qe67t4evABE2u6O8TuRwkJyjaCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxjNXXPsC0lXD/aGJ9E4Aqjrqv6Plkbfhv9dIXbuR1h+KI9V3buBa+P5mfujIqWVAidNof5NWmU/XR6BpEfSZhpwXRvKWQ1RS9RzAjs7fvXb6K3iM7WcIJssM1fp1MNbJJ8sCPtejb1/zNB5zM1OIuNu4+3fCewIVNy1syxgHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVdcbBdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVdcbBdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBA81F000E9;
	Tue, 28 Jul 2026 00:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198968;
	bh=jZ7YtRvdFItjcaNUobN5KL1whLjAnlIbvgDeWbXyz4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZVdcbBduFUp6cm8BzxaqxmtkjlQxtAgh0lsbblCrg8LVD1TkN4RsE3a6U7jT71EY2
	 M7/UxoB8+33RXEwkkByioAW7I7JOAwBWh9NNJM3tgVn4/2kPEwRZOLetDLh+NQPPZd
	 B4FxgtzSEGdyT+l36JpypiBjqBDEcK3etP+jYC+RbDXSdZA8AyNS+BXHcdJwKbikyn
	 Aue6Z78jcq0zpqPhA+SIaY5PDFECckG+fqRNM6UGbR1OPnk696ydgBaQVEv95MraO9
	 K957WbWVqo7njmVPjePevre3y+FDr9wUjY/CjqQQFGg/Ef/zmNtw08/LUjWGeTzcxU
	 0iExOb/UPvBrQ==
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
Subject: [PATCH v1 09/28] KVM: SEV: Expose sev_get_asid() outside of sev.c
Date: Tue, 28 Jul 2026 00:35:38 +0000
Message-ID: <20260728003557.1136583-10-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the function definition to svm.h in preparation for using it in
more SVM code.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c |  5 -----
 arch/x86/kvm/svm/svm.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8717da0e9fe8a..3aac702f45b2b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -313,11 +313,6 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
 	return ret;
 }
 
-static unsigned int sev_get_asid(struct kvm *kvm)
-{
-	return to_kvm_sev_info(kvm)->asid;
-}
-
 static void sev_asid_free(struct kvm_sev_info *sev)
 {
 	struct svm_cpu_data *sd;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2f18dff023bc5..d41d189ecf4e1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -429,6 +429,11 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
 {
 	return ____sev_snp_guest(vcpu->kvm);
 }
+
+static __always_inline unsigned int sev_get_asid(struct kvm *kvm)
+{
+	return to_kvm_sev_info(kvm)->asid;
+}
 #else
 static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
 {
@@ -443,6 +448,11 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
+
+static __always_inline unsigned int sev_get_asid(struct kvm *kvm)
+{
+	return 0;
+}
 #endif
 
 static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
-- 
2.55.0.229.g6434b31f56-goog

