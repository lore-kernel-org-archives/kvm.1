Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3933F8B1;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863245; cv=none; b=pLATcUBsUqr55t1edO0DyNPELoPl/7qzjMdBfiSXn0TsB+R4T4hoMVCGeILHgZR9SEpbAcQ3mwU3DAyZuNS83ExHsleOy7bO4/CfwkFXXDc4qgktQGoOw5iMT+rcWawc3ZoXBBeiXx+dOSDQ0Z8W55ifEKFWQ3BL3Zq3+km3BYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863245; c=relaxed/simple;
	bh=e8dWE3cokleVV7iRAnnHxhYjEDmuPrhsTdovlF/Bg1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NluqL6ppTh73+GcCPQeRJZrK55jtSDTMvPl7iLMZYw7gg/v3uxtk3YnEFUcrO2uiu9ryZVVILYoisD+A8OP9tv38Hv5wO4c5OFwaj/LMrIqYUDxKmFBDcH4m8vgFnlOFmr79TKGonD217gvwVM3HCw1/8AQPmbrb4GYbs49LqIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atn/zQZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atn/zQZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4D61F00AC4;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863243;
	bh=uyD//5I7d+RgYpE2PxnmzpIA1BHlMfGQSfUNnMKtkck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=atn/zQZBHX+WVNDfvfXnvMSoNbK16MnMnYq3hKRECu411qPLgUIF5ocHYcJS7mNKI
	 zpNnMtPlLDoqzf5SF/DLvdka3A5XQiECaw/+/Tu8b/aiiRRjgvPj3mF+ZlXtkefpe7
	 tAWWz02xwWd/QuySygd5C+ul9Fjs6/jSxTPFOLzJ7kO3pyit9znJyDsPqwllHOUSRr
	 8qFe1i5rNGUJauLlVlxu3wqn5OOJkjfuIF0j6507n7Zf/k0do6UYYgaHRLy4ZZ2lwG
	 ywSk05HHwhvLUUPszcTAdyCeDsvMmff+jqfx6yNOXPAORkOYa14jJHT50dPdhNxwp2
	 AtYtieeTJrhCg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 5/7] KVM: x86: Reverse the polarity of efer_reserved_bits
Date: Tue, 30 Jun 2026 23:47:13 +0000
Message-ID: <20260630234716.3039031-6-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260630234716.3039031-1-yosry@kernel.org>
References: <20260630234716.3039031-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for moving efer_reserved_bits into kvm_caps, reverse its
polarity and make it efer_supported_bits, to be more consistent with
other fields in kvm_caps.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 17d4c813a9e8a..b9a16a27f6c23 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -20,7 +20,7 @@ module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
 /* Enable syscall by default because its emulated by KVM */
-static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
+static u64 __read_mostly efer_supported_bits = ((u64)EFER_SCE);
 
 #define MAX_IO_MSRS 256
 
@@ -606,7 +606,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 }
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	if (efer & efer_reserved_bits)
+	if (!(efer & efer_supported_bits))
 		return false;
 
 	return __kvm_valid_efer(vcpu, efer);
@@ -619,7 +619,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & efer_reserved_bits)
+	if (!(efer & efer_supported_bits))
 		return 1;
 
 	if (!msr_info->host_initiated) {
@@ -652,13 +652,13 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 void kvm_enable_efer_bits(u64 mask)
 {
-	efer_reserved_bits &= ~mask;
+	efer_supported_bits |= mask;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
 
 void kvm_disable_efer_bits(u64 mask)
 {
-	efer_reserved_bits |= mask;
+	efer_supported_bits &= ~mask;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_disable_efer_bits);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

