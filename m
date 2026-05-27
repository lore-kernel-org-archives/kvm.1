Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA94404888
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886258; cv=none; b=RHp+yMZlF0nPSWOK+HHIwwwnkPkz+jbXLcI+UME08lkF1Ac3xyem6VG7HKTCgfuxROJ4tQ51O/NjiMqlworr0htyTxi34kAml8U9tZB7fmj+FBZWsAlRpsdxeCOHzBsprenw3ASF53P8hNyTYG3BtkGHV8Rwd2EVAcU1HHGUKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886258; c=relaxed/simple;
	bh=QsfV9o6uyG3fZ0Cm0ZVpAXQmYPVs2CM/4Rt6IDqxWek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSEY+firzQ7t6lbNgrcr0GQg2D3W+aSuGDDLbVhauXatmG/BQ3wiATyXDK6yrtM8G1jgQqgFErt8452xCeSZagWb6kRqg1RkaXcej5+VSlzFYmXcQvnonW44xiptR5lQiKM+VfXmA5JH3T14IhIHdVhLtx1HsXFsT6pmL6FU59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJfyUSMz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJfyUSMz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso131661845ad.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886256; x=1780491056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o69E8eZZ8xoY19N9nOZcNtpgHKzR1JbFW5hWEhTv7Qg=;
        b=eJfyUSMzDh9hrsG1ty1kqcTpg2cIHpQ4ydzGRYTtx2lfjwK+I0NTy8ChAveHHcbBfV
         OwNXiQ31xZIdvKz0s03vdqIWUwzlLJyTbEmvKpR6Yg71VXji+tY1MJ8AOJetO0UgGBpg
         uJHgL4qa2qsdIr5uqzgfs2I6tuojxAlk6Do01Ed1UilT7Z7ppHcYgAj/fWO/gwxAp2kL
         Q3Dm3SrysUnCVzLgVGfKfBZVP06u917sWGaytt7F03T2KKC/mCsoxNH8SvL5UY3L7Ju4
         zEDzQZ1IZHAZRmSCogk5o6B41OS3iecUMBjtXjDkbWYEg0HbtLktSiYpde2wWudvxrrY
         tK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886256; x=1780491056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o69E8eZZ8xoY19N9nOZcNtpgHKzR1JbFW5hWEhTv7Qg=;
        b=bY/c4DinGq5Je6HxqQz/5H9TD1Q2tJTkog/wb2O59YsrQ0ibfv4e9mjy1Nutir4Zqs
         ZwdXaG5jWM7GlOsC/rXHagOC0OLdakEM1h5IGzN2rfxihvTBNEOfbZd+PB5WJe6piERJ
         zGxNexY0axh9sT1pOsp+jSIAcAv+kgAoHq4Vrs2U9cCwoAYn717lWqo+kdf6w+kpbJ6K
         pZYEwvbX9zP7p8zh8Z0bJsPDlq11x88Qz9LgMmQiyyHsp4xBx5LJvd48nKcalWylZC9T
         KjjWh0Mtupz5NcERIPMJQeuYLRkVbbUcGkXchw/pWXFOxatN34TDT2nzjcKubzx9Sq68
         7mHQ==
X-Gm-Message-State: AOJu0YxglNgUrdclXZXhUlNOdDalSMlr5MldNeAxVOyEsKJsTeUtlqNT
	ILuhe9WLHtbMhMjJ0IEc/J+Ezk5yXSWazppLJ1vlpPBMm5rV5h0v2j6IPWjDBQ==
X-Gm-Gg: Acq92OFunAcSdr9mDvcNIle/k+rpzVgLI9vQD+NnW16FZdmfYYCgUrGgFXJDaiZ63mU
	XSFz3LWfQ58kTTKEkuBGdm8g3TaCxQT+czyDlg709E/nusDo9o0XFPXVDo+rIF25zgyrF4iZwdt
	imUWKDAZ0pKMwGI6SoXG6mm5/JO8yIprKbXke+PiHG3eYVeaaK1Wws6V4CjQBXcICR8XgK+RFUv
	dpbRikk9N7kLAOZgXLMkmkLk+YhqZtzsYqbQ8YGnutByoDUYHrksVoMstr81n6BL8qrM4O/PiPc
	MZSUHi0ceMCX5yqhuvbecSdMSfpSB/js/dAwuV+NLH0xBdqC6XH3RMN0r/yeYR8WELlaOXwmDB5
	eadh8yZ1PCih5f1V+4OB1K+B0QdijrlrveepfbQLE7kWFNhVCnEooD2D5w0X4xaZPTFXTo3cBUU
	JXtVIMTL9Vz9v5omzFuazoU9yul7HrdRDVgM/rD53vkdyd0oznCw==
X-Received: by 2002:a17:903:198b:b0:2bd:c2ec:eec9 with SMTP id d9443c01a7336-2beb05ef6c2mr253654725ad.18.1779886255305;
        Wed, 27 May 2026 05:50:55 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:54 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 09/10] KVM: PPC: selftests: Use u8 instead of uint8_t
Date: Wed, 27 May 2026 18:19:58 +0530
Message-ID: <206327ff71a118e0a87fd3eca5c84afc6e3e6142.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 6ec982b5a2c7c ("KVM: selftests: Use u8 instead of uint8_t")
made this change from uint32_t -> u32 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

It uses the same method described in above commit.
      git ls-files tools/testing/selftests/kvm | xargs sed -i 's/uint8_t/u8/g'

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/powerpc/processor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 0a65fc3a8d9a..2c1e95c8aa9c 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -256,7 +256,7 @@ gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
 }
 
 static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
-			 gva_t va, int level, uint8_t indent)
+			 gva_t va, int level, u8 indent)
 {
 	int size, idx;
 
@@ -283,7 +283,7 @@ static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
 
 }
 
-void virt_arch_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+void virt_arch_dump(FILE *stream, struct kvm_vm *vm, u8 indent)
 {
 	gpa_t pt = vm->mmu.pgd;
 
@@ -380,7 +380,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	va_end(ap);
 }
 
-void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
+void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
 {
 	struct kvm_regs regs;
 
-- 
2.39.5

