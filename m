Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9983C819A;
	Mon,  6 Jul 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367685; cv=none; b=B5wLJBw88OLRJM4RleWASqapamV0e6RPmeYpMNRZReX9h2olN0f+Mk18tC7dqAQqUhGIrByMNStmrSLAN3FFFUpUc5V3H6sOYMaYutJsWxzzmzgDxwzHqXh2GhPzem4zvir9mIn5Zov892QE3qxQIAeron7Z8aPsF9I0dPl7SUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367685; c=relaxed/simple;
	bh=r0abEXR+7ZsEZ/d3IqLIGVADmKXy/rJ/hm79XePwdHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLwpcCN0uGAZUkZnlCUNMNijcPWAsgm+DHNkc65DoEWVwjW/RnnL2osCgmXX/DZi7ikZWBiXbeLA3/LAS88pOKg1NkGnOn2zGSrDf1HEXpK018tvkFNsOZBlg5oMOsxstTPz6ia2taczpj4wUBDkYq9wMQOGdJoQZIEspfu2x9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMQDd1WU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMQDd1WU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C46A1F00A3E;
	Mon,  6 Jul 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367683;
	bh=txTRsS4azgfOK1sPCmyBxP7wGTwji8FVbplH8c5T1zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMQDd1WUHJLc6ottB4bbTpMgfw2JaZREXzmLT+wgq7KFEfQTOq/BKkBxj0MSyvy5Y
	 qStg+OCIEjCYsJ/5GzGGc8Q64mTBVT+TyeBqwMU11pzdW2d/HosKITMNuj8DxaoUt2
	 ghFzGSBujycs/95uWAZYDwloCWaX5tSDSozu9iz2+Ml6tenQ9bjjvv/GR0uKbtUJQ/
	 e/97/3E3Zwq3NVQTlZ4cZy4X738AXzmd/M8qRqQqC6O6IL/oXJPzl/p7KFiCHUqK7D
	 Nim73BYeoSAaPOFWwZCdOGoIFk/C/btBf223lCBO3hc8o1tY/FijwKLtTSGdh0C4ZC
	 ETuEngKEtrz+A==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 3/7] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Mon,  6 Jul 2026 19:54:09 +0000
Message-ID: <20260706195413.1966458-4-yosry@kernel.org>
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
2.55.0.rc2.803.g1fd1e6609c-goog

