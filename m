Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BB3DD870;
	Wed,  8 Jul 2026 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492515; cv=none; b=uefgUVKWPsVjZuLW43Oxf0meDoSQMJf6ULGq06F0jIzNnBMOd3bCkm82yjBth03vxsJxI7Typ5XnuIgi0ZduYJQzm1bjxriZFOHT2fsp/MKzD2SKEUVdfzEdLstO00tcNwdXYE8YtAlyeLHNs8j5bSZABlRDYpaGv/sdsrQXpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492515; c=relaxed/simple;
	bh=BOSNca8ra6axO5kJrUdXyxN8T8/kOrRVLbEkH3QzTTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhOl/fLm/TnYqKdgjZCm40DzNIFogaYSeZVNpyJ4y22GdfpGpfQ8qWnlKJWO3lOONGAmnH1VqRiOdUh/iGdqQ1etupluOlSYQS9D3F6LK86vrTfMNyLO0k7PVJXb0aoLipXHujolydzO3WY48kMSRYyQIlod7GwOrTOUe0W+2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgY4ZMnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgY4ZMnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2631F00A3A;
	Wed,  8 Jul 2026 06:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492513;
	bh=95u2tDCvK6An7tqTpoD5tq0jTG8+cj+mlYKQfDXUYZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgY4ZMnWJ7NEWXE74tZFEo7rIV7aX46mLmhZi2tPANUI5leqXEIa6cra+R+yKpe2F
	 fv73dpaRiYmrRDAHkQlBeNf537C7KfDNEk04P3Kv9W8Wjmj1sGmlXzE3Ath0AFwT3C
	 NxWSHYsqlv+u/SZq9RxTxyjRVejjrWXN3lJ6F5PRJu3rDATU2qhbghvJplE5LfpXoq
	 HVgjg/HpUiEOrQnEPuljzCwCBQbE4Uz9oldAD5OZ1vg4ozAdnPTqw2nrqyJt+oYHq+
	 FmjABNTcqNYWdr693fSkgb+vVuTu6EnRvbjWZXOoXHMVbbBA9aQfobgrogSrBR31Py
	 pm8+mel0HMrSA==
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
Subject: [RFC PATCH v3 06/27] KVM: SVM: Add helper to check if Secure AVIC is enabled for a guest
Date: Wed,  8 Jul 2026 12:02:04 +0530
Message-ID: <5e077730f0d598623cca4438617f38cf04820196.1783490022.git.naveen@kernel.org>
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

Add a helper snp_is_secure_avic_enabled() along the lines of the similar
helper for Secure TSC to check if Secure AVIC is enabled in the VMSA SEV
Features for a SEV-SNP guest.

Note: Enabling Secure AVIC in the VMSA SEV Features puts the SEV-SNP
guest in Secure AVIC "mode", and it is up to the guest to then "enable"
Secure AVIC through the Secure AVIC Control MSR. While the use of
"enabled" in the helper might sound like a misnomer, it reflects the
fact that KVM has no visibility into whether the guest has actually
enabled Secure AVIC or not. For all practical purposes, KVM assumes that
the guest has Secure AVIC enabled. Since a Secure AVIC mode guest is
extremely restricted, it is in the best interest of the guest to enable
Secure AVIC at the earliest.

Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
---
 arch/x86/include/asm/svm.h | 1 +
 arch/x86/kvm/svm/svm.h     | 2 ++
 arch/x86/kvm/svm/sev.c     | 8 ++++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 42ececa8963d..5857b942957b 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -311,6 +311,7 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_SECURE_AVIC			BIT(16)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 616e45624f4c..1157d022bac1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1013,6 +1013,7 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
+bool snp_is_secure_avic_enabled(struct kvm *kvm);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1050,6 +1051,7 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 	return NULL;
 }
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
+static inline bool snp_is_secure_avic_enabled(struct kvm *kvm) { return false; }
 #endif
 
 /* vmenter.S */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..686227a15328 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -211,6 +211,14 @@ static bool snp_is_secure_tsc_enabled(struct kvm *kvm)
 	       !WARN_ON_ONCE(!sev_snp_guest(kvm));
 }
 
+bool snp_is_secure_avic_enabled(struct kvm *kvm)
+{
+	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
+
+	return (sev->vmsa_features & SVM_SEV_FEAT_SECURE_AVIC) &&
+	       !WARN_ON_ONCE(!sev_snp_guest(kvm));
+}
+
 /* Must be called with the sev_bitmap_lock held */
 static bool __sev_recycle_asids(unsigned int min_asid, unsigned int max_asid)
 {
-- 
2.54.0

