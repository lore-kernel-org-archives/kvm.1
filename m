Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF42274FDF;
	Thu,  8 Oct 2026 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418484; cv=none; b=atBWLVoUvqy43LJhTlRrEDrAICBupqoZoQxzwozBlo8ANLA6ex83QuAmmmdlwyFkfJXWkGAQp53SgbCs++HqNdwUwvtuUZaTnO7CkncoVb+lQ58QC+9wJ0GsJEsiy6LaMDFiyn154sjVWQQoVhmRn0A8m0nscEnGSymv1jV6pDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418484; c=relaxed/simple;
	bh=IyR19m0IXbwfJjKM8LN71rCRlbSr54W3diN3l3Yy67o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5QOhzhB9eyt3F9UdlZg45Im/5yf2ja1djkgUJ775sZqGFR6ctEIPoHZ7CnXBlIYRhoqO3leSQdENKqeiNBkm6fc9Bdfk5cvwrW4GU/GzZRCASTI2grr/QNERCKI+40z4abRgqWN5QTxJziIDNbvmOArqeNfl1bISKfGJvMbLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTSQxSiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTSQxSiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97701F0089B;
	Thu,  8 Oct 2026 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418483;
	bh=ZA7XhOZkYrX7nPi1RlgYZRYJ0bnvdCAnMfwNhRiRml8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTSQxSiFZcOj91JeifjStH3e0glsnv6FDryswBCDqQ6snAGFt1XgWMdBcaPrtxj9S
	 if813fUFcsIJlCH6zveH8mYyW2UVLgpAzWpL8DBmdjTmee7xgS1DKaBfmSH/U/3N8Q
	 Q3IRX0A/MkzH0QcQsXQ3qSq93tGfEeVOVXdVsXRRmzVPpAY8MuDWZoDCgmehEhLlGY
	 YNjiA2HGfKB8EW/DKw/0npJ2JzC1o6Zpg5gTEXSvQg7h6kPQImrARm1eKYgPFa4WTP
	 8V0LaaG9HRonF94rJDtxbjPefHu8xM/C8VsCmzYsjWf0TuLu4ExnKg7TuFBzbDzXyd
	 r9M6hTqARGChA==
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
Subject: [PATCH v2 08/29] KVM: SEV: Expose sev_get_asid() outside of sev.c
Date: Thu,  8 Oct 2026 00:14:04 +0000
Message-ID: <20261008001425.2458927-9-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
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
index b58e3831b8f05..706a91db7b44a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -315,11 +315,6 @@ static int sev_asid_new(struct kvm_sev_info *sev, unsigned long vm_type)
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
index 3b59561d6cc2c..14b57c5cdf916 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -432,6 +432,11 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
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
@@ -446,6 +451,11 @@ static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
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
2.56.0.360.g66cac248cb-goog

