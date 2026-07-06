Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BED3CFF72;
	Mon,  6 Jul 2026 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367686; cv=none; b=KGdbAuISJZaOXzP4UM48Yi42v0G9QzPPFZxXHViab1DKNsKbSZ77NCtlmxFc6m6KU6yKe4p2xVnJ9Iz8fF2JffgN/ZYVTYCrFFQeqUTdIZPiZcbMTsFQD0+vidpojfCeZ9fb4wWGQaCE616nW9oz+g/I19dQ1AApRC7otTksN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367686; c=relaxed/simple;
	bh=zKLl8E3zCZsAwq16CjImPpRi1t9PXg3FpOT0m5H8I6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPu+WlP+0BOms4gUrNY7tkAU6in+wErLGNg7dC5cdbA4bEgCSH4/uOQS3+ePo6sS/UuCg4DleItC7n7YdZmR44pf3XAz3cQyYKJqW5zQe71x9ekBRECqgdUTnRGZXsLqTe/JYwDZuwsc8QRNHgPa7MR43TitGhVwWf4rcWDEgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wppf2Wk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wppf2Wk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546881F000E9;
	Mon,  6 Jul 2026 19:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367684;
	bh=bTahljj3RGHBJ9084a4QwpvYnQx2lpQWl+OVZREHBds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wppf2Wk+LA2hJr9m9pRgIiZVo9sQedhw7L5eQV0QMg5Rm09UMHiDHch/rgzQ0ZxK6
	 XrzZ3NfPfyMIbdhftGMMrqvwWXAaOXeXIgE3M/TJcz1VOC9fqdrZPQU3lvVR2XmIWp
	 wgttNzutefOEEiBuTcgNzAL5QkwI5QxmPsgC2CsSqVmOiacIQhR+nr7k3YCaPycL/c
	 Nj6pox+zstmqPLVw7PACVhPMSZFVfw5+GEQBmpmq7edU8vAfJbcYQZc+7EVjr9JKWe
	 qhANte+R+ihzCN1jYLTNyssHDxS9f36MOslMVvR1+1GXcpg4I8tyhXoaKbOeKFS1ql
	 +gLLhsgzmWoBA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 5/7] KVM: x86: Reverse the polarity of efer_reserved_bits
Date: Mon,  6 Jul 2026 19:54:11 +0000
Message-ID: <20260706195413.1966458-6-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706195413.1966458-1-yosry@kernel.org>
References: <20260706195413.1966458-1-yosry@kernel.org>
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
index 17d4c813a9e8a..10669c5418da3 100644
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
+	if (efer & ~efer_supported_bits)
 		return false;
 
 	return __kvm_valid_efer(vcpu, efer);
@@ -619,7 +619,7 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 efer = msr_info->data;
 	int r;
 
-	if (efer & efer_reserved_bits)
+	if (efer & ~efer_supported_bits)
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
2.55.0.rc2.803.g1fd1e6609c-goog

