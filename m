Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82153537C7;
	Mon, 13 Jul 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966232; cv=none; b=QiF8zzwGYN9t5YSEbyQbQI/ryPOQMRjQ/5wrJPjlngsThDipqwfgwd/3dD8dxXm8lbxk54oPgi6NC/5bQZTENPWj1F9G+j4ISuq7jsAIiJo457xU6TMcmdEhT9Z0xAMloGUJuKjVNeHKCaDDLZ87OCXtBf1mFYw13wiYyDBAMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966232; c=relaxed/simple;
	bh=AJRuSTuddkXbW24z/b8GNYsqeagP5Oa/MR2ZYimUMTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSSrtovvDaEvhAszOhgwKLhG7bRtrctErnOZSdSV9ZXdBb4iKinrlmW7WQy0CJuw//wOdvhC2H9q9uFz33TLaHjf45UFyiDHCx1tZy2eLyL84F0Es/ydNysL79AsVkmREcuQzrAUlgmml3vMfqCVj1l9VD5Gn2dkurm+qkQjeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OESYIH40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OESYIH40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BD51F000E9;
	Mon, 13 Jul 2026 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966229;
	bh=4suZMk4zoyDPvF3wnpE9m6QUNbYKf58CpmE4xIgfaWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OESYIH40+bfxH+DEgZoMyu99AO8xAvLIISaI1NWeTqJAiKTbgaBOR2SQEHWLG4y97
	 BDXAg9R9Wj2gZ91ExIqUCc+HTSu+4jo7Ojhqp/2du0zKUoutW80zdfarSFJ8LNtOC3
	 Qyat1OwG5yiMO3hiCj82i6wl2q/WrdHPJrqnS1lBCylA7BuHc8Lg3Ag888gpk/+3p0
	 NubjelATgMc6ROg1vO2f267d3ki5bF69dnEs5GGgFb4SC7aR994+U3wWipwNEJDW7Y
	 GICETWMk6f2flTrSfBBMvdFfdP0r+feDIeKCoVMNfUeslwap0j0dcwoEg7bcdgnBgl
	 CeUwu7zvFuHZg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v3 4/5] KVM: x86: Reverse the polarity of efer_reserved_bits
Date: Mon, 13 Jul 2026 18:10:19 +0000
Message-ID: <20260713181020.2735367-5-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260713181020.2735367-1-yosry@kernel.org>
References: <20260713181020.2735367-1-yosry@kernel.org>
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

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index a7394bdae0295..8e33b87b5e8f0 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,7 +19,7 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-static u64 __read_mostly efer_reserved_bits;
+static u64 __read_mostly efer_supported_bits;
 
 #define MAX_IO_MSRS 256
 
@@ -605,7 +605,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 }
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
-	if (efer & efer_reserved_bits)
+	if (efer & ~efer_supported_bits)
 		return false;
 
 	return __kvm_valid_efer(vcpu, efer);
@@ -618,7 +618,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & efer_reserved_bits)
+	if (efer & ~efer_supported_bits)
 		return 1;
 
 	if (!msr_info->host_initiated) {
@@ -652,13 +652,13 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 void kvm_init_efer_bits(void)
 {
 	/* Enable syscall by default because its emulated by KVM */
-	efer_reserved_bits = ~((u64)EFER_SCE);
+	efer_supported_bits = (u64)EFER_SCE;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_efer_bits);
 
 void kvm_enable_efer_bits(u64 mask)
 {
-       efer_reserved_bits &= ~mask;
+	efer_supported_bits |= mask;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
 
-- 
2.55.0.141.g00534a21ce-goog

