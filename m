Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975017A31C
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494430; cv=none; b=rC0Jq2nsreRymgM+VHybstUkI56vYmjgMVh5Ph9k4zTBD/zg3V925Ac3q7I6/wPSxxZTdmIXQ0QL9TOGnyRkTSZ51Cpt7Vh+PQ0N/aFeOoEeFNW5i/vqllQWpuzlMt8pFL6734ZFeSvHaabckAxfoAPR2T+W3oMWGWAqN0OywCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494430; c=relaxed/simple;
	bh=nMSJFVr0TrhdE4ljKUSOx4cwJTAooDnzufTwcTH3Whs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ndxaMcoZC2GVjsudaCs1waduA5vpPzkaLQrLxalXJwEgQBUmIdjrMJsTi8CrFVsnLOqZZ0tKSj49l+LVtZbQa/iILyPFpygPsfz45cKsKqjC332hoL/XVAFEC3frSshDeE/weiHG34KX8hcRVXGN5uMQ/q71BOxx52XjumKTmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9sl+b+f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9sl+b+f"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1733127a91.3
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781494429; x=1782099229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2rvojVLS1d55N6BPyuEoOHN6DHrIDzWcczFK27664Q=;
        b=b9sl+b+f/s3f4dblg/e8FJC2jVSSM1YN5tkHvVbT8E/gA3jybegMCLJbG2+EMAQt6V
         xsMEbBr2R+oYLsiCXdUxSpHhwX39mCXkpmuvppC6vS5NNGGXQq4tIM5050nNq9K8YmCq
         wJqaBDhPjVMkunQV1IiVNGp8rFs173Gi/DswxzKPkzVTKcx05jYVjQO049T5Cr/N3n3k
         6QDJJpAptYnSyWFDmCebjFQg67R+3wSx6AfFQSpu3dx1R7VdMn8T67+8eou6awVGrG3E
         xtSpvis/hFNp0SeL3d4paeE94Vcggp2ZaZLv+D+wjctXi2y2OitCIp1Gbg/S9DvDLDEo
         1QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781494429; x=1782099229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2rvojVLS1d55N6BPyuEoOHN6DHrIDzWcczFK27664Q=;
        b=dUXXmSrNNtNqYXz9EOtjxvSNTZUGRUb1HAY2BFg4WKhNCUFN7V+Sqf0JKpVvbv/DgL
         AtMqVfR20VBIOHXbYcTU0swrD/vlDC1GyY+PJ4/J1Fb1CNethPK6T4h9bkabJTqhqwN6
         f4PhvQUJK9rzeo4cGRBtcSJ6DDI2G22MjLyNezbjMq4sFAiVFFzkIlLttHxOygLzvNgj
         W4DSnyo9M+Es8M1X9dlsqcLQ+Xvfk9u7/ksyg4iFzTjNRHmvoxgyX73C6cV5859+vaAf
         vSI26kzabr2oOSMuGnwBjqLqwiSaDnGIFGyY9+eWRJJZTjsJvgR81+ZpMRljumA2A6yT
         +fEw==
X-Forwarded-Encrypted: i=1; AFNElJ9seLAuZ9dW66SInzYpMATDdXVBwbmKRCRveXHApvc3JxpSzzRuVpPGRqWrAOsS4Ks/SuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFf8UGBi6/VvZyOvwDvqAWLmY1dRi9ZHr7jAnEDt1Yw3cDsTPs
	QScGSFewbN4QN6pSPFVQt7iNH9reHH/KBA+tUC8mEBjS6ILslxKSp531
X-Gm-Gg: Acq92OE0z3VEI+xIQHfFoJ7VzvGjzz6Y8SCokU95Gg29xRdmwN+vLNXQ8A3AaRKaYsW
	Rbv+kVj6zLF0MvXV9LtihVcgAHLm/7c8k1qJmlBu0hYxurN5rIZ+JChtH1g5VMFe48mhTm6fES4
	phwHJnOzjeWGDe8A4SybbarMSjfrBcY9ChjT5nAztRqcGlIsheXzivkzCsXQWCUOksaw/57fgxW
	5Tn4YdsQTr/qKns3OlNrBh300nR961y7W+u4LefVqIz6dYh4qLJO4ywvvy+Xr3oUCBr0YYRbxvb
	qe822EoU/K8je1jJWVLPaiqz2b/oEGBgi32FgM5wqrJVMAQpUJjOGr6pmLmCUts+cDx3JWD7azF
	ZXf/DPqSNECHKPsMabGy4wpHoldcxcOBtOL7FsnOF/IuYTBKAhA9nTQr3nWj2TRraKMxekOqmYk
	yKvHg/L+k8aMm0y+ZlYVJaHvO2KIvI5IdEk4XLT4qa0DvrrQ==
X-Received: by 2002:a17:903:19eb:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2c41188b334mr130331905ad.20.1781494428646;
        Sun, 14 Jun 2026 20:33:48 -0700 (PDT)
Received: from localhost.localdomain ([120.244.221.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm85094975ad.41.2026.06.14.20.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 20:33:48 -0700 (PDT)
From: Saul Freedman <fre3dm4n@gmail.com>
To: qemu-devel@nongnu.org
Cc: Saul Freedman <fre3dm4n@gmail.com>,
	pbonzini@redhat.com,
	mtosatti@redhat.com,
	kvm@vger.kernel.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386/kvm: Fix CET SSP MSR read feature check
Date: Sun, 14 Jun 2026 23:33:38 -0400
Message-Id: <20260615033338.1563854-1-fre3dm4n@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_get_msrs() adds U_CET and S_CET when CET shadow stacks or IBT are
enabled, but it checks FEAT_7_0_EDX with the ECX-defined
CPUID_7_0_ECX_CET_SHSTK bit before adding the PL0-PL3 SSP MSRs.

CPUID_7_0_ECX_CET_SHSTK belongs to FEAT_7_0_ECX. The current check
therefore skips MSR_IA32_PL0_SSP through MSR_IA32_PL3_SSP even when
guest shadow stacks are enabled.

kvm_put_msrs() already uses FEAT_7_0_ECX for the same shadow-stack
condition. Use the same feature word in kvm_get_msrs() so QEMU does
not restore CET enablement with stale or zero SSP values.

Fixes: b6f85c5e4527 ("i386/kvm: Add save/restore support for CET MSRs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Saul Freedman <fre3dm4n@gmail.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e35288..3f4a241 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5021,7 +5021,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
 
-        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
             kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
-- 
2.39.5

