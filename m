Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1C3F104F;
	Mon, 12 Oct 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848211; cv=none; b=aSbgcQs4ePRyp4LRRKDdzrOtSt48j5hwEhFT28jyLBvGKMO8RX4QV+T3QBd0qVbh4poY2PlvW9wnGSbVBew7l5YEsqT56mCzoNHj7OwXtLX8aJ0oWYejGktTuFdIRhpOshOy7zYcUo189UfUo1e4k70kt73SpNckxc2zkXlPZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848211; c=relaxed/simple;
	bh=ml7DVbGqYfDQg9Hai6j9eyQPHDSUSTpMSUy+WC+phTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szl1TRfLKHpofYXt6TX9nw5wLyouiU8ciIfoulw1enHe+k6Tx1J/p9zNnydOXRybppH7koGR7LWW5b1O0B9enQhdZebnJkt0xtTrQLedUjvXCkMMq0BC0WlnF1C5xz39LQQhtyywLr0LLHP5s3rZviLRFcv6r9HpdLTE777pd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM3982KB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM3982KB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B703A1F008A4;
	Mon, 12 Oct 2026 23:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848210;
	bh=/iuMhPTtxyjAD9hNZ5sMpi07jqL28HO+0YnQMKf6wec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OM3982KBuqC0IFB+d86KSAl78p2hnlfu6neCHnif/G/2mvwswr0tLy00Mgq2rILG7
	 B6GUquQAyi3pvOIp8b+y4hfa/5cIB04IOQRsi+LF7YcKDjHrQ7SqL4HUzYDZtaynx7
	 /DO/fgvjAbCBIprXawoBUiyTiXsQigRzdPgvVpul6lRSL6UKGG7aSck4KbSlLgrLe6
	 YTdZwKVSrSIVyVyHts+x0KHQxXTb4H2j8SKfYCNHjNSTW11bA5VX3ct9Mo84sT5lkI
	 gRCu3zOC1xuc6pCEuZYdIdVRdJHMxZfJtZfmvsWYLREGzgbw43YYF49EhUwWMos5/I
	 lj46eTtjVURUg==
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
Subject: [PATCH v3 08/27] KVM: SEV: Expose sev_get_asid() outside of sev.c
Date: Mon, 12 Oct 2026 23:36:19 +0000
Message-ID: <20261012233638.2546339-9-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

