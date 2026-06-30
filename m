Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680233B6F4;
	Tue, 30 Jun 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863244; cv=none; b=s7gQyxSWd0CDhQV99zBiJAM+lbYRzTbCcmAsUw8uVrAKTUTzqOqAwUvPuqvIdFaakOsLvvnDJ4YSZoKi+wmN68nzX+KLvgAG3rZD+ua8dOtj27QkLzIvXFxwOJ51hgT4GFHRfAP4to2icQ+SOCMVv4aSA/aRzHiUv1liEibhyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863244; c=relaxed/simple;
	bh=VyYUFyAvILIdWgMOwQMb9HragiUDXDRbbm/3vHEhTVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObJCblu6EmGDOYzAnqXncifeimXtEpa0OlocXqzxldUf2uTc9uRWq5WULCCI8jxcvHCaivd+9ZiU5RwkQraO/uRz0XxdC/b7We2wDmjoKyJkRw4dUYGHmTU8ABlEVfhLWxLYJi0p6jWvO5CZ7k1c9+0+viAIcE9C3Rop5z8I380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLGWypwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLGWypwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B831F00A3F;
	Tue, 30 Jun 2026 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863243;
	bh=6Ti7qoXbQ1CEl/DmhJyJlJ8CaIzO0Ev0cPpHb6vjvmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLGWypwQAqeafuCnVyWfi9AGglcn7fGpXrg/d0onNPyepyK+InXbVupwe/uMJRmTI
	 kb6EtfyJKvgyE/FTcXhMO43U46XtWICmkgBkLb5woR0reCgR01lkT6mr3m8XcsJhhp
	 wXE2XH3TS4xqAkh/jzt62Tb+zuZVMwOFezWKg8+WwDIhYeVjDETNqGpkg0v0LEGv5/
	 d+msfE4w5YKyQf3n1oEya6OwhAqafFOClfP+65hESfsVfTbcz9pQ1RxDV9aeQL6XxC
	 JAbFxrSGnMMKU8akqwYcvHjILnTNcelFoypanfftdZnEPX7Bh/AmQ61wAXpYP7IRWP
	 Lh0qgTKegmfcA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 3/7] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Tue, 30 Jun 2026 23:47:11 +0000
Message-ID: <20260630234716.3039031-4-yosry@kernel.org>
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

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

A nice side effect (and the true motivation) is getting rid of
the #ifdeffery when initializing efer_reserved_bits.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c | 10 +---------
 arch/x86/kvm/x86.c  |  3 +++
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 45170df0ce40b..17d4c813a9e8a 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,16 +19,8 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
+/* Enable syscall by default because its emulated by KVM */
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
 
 #define MAX_IO_MSRS 256
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8dbc0fa302a8b..a0b2c40d93c21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6892,6 +6892,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	if (kvm_cpu_cap_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

