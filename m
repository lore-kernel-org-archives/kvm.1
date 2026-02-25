Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F932820A0
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982477; cv=none; b=AYiCPhrUwUJWo7nH2Bykzd+u78URgflsESvvnJ9Oe7kj4sLVoTN4jaJbZcStIzuewDEbLYfEMt3Eg+CdKUhBzXx536FDBurHWPle7Ohap3p8yAJsR3v/oHxrbVE/zLy/5mpNfwoJEP/HjrHlhTHur/MA/7HiggN2ftU6Iaj1R2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982477; c=relaxed/simple;
	bh=XAkvXmxYSWcnAm2ngYtj/+yAtyCpKD+kGWhH+fNj3zE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dTY7DFC2sPo3GzhDpodN3xze03WBrXZqzbxOn7VWTNHqDu7MWPksTah5OAiBHXXG+OFgXjlZnnQdEi+C8UJ9SaTsEc1dbmXVKFg4lGn+WkV51vnB1B9uIL4ExTiqR1Fm2WekD5nBnFQnMCT2GXnD6hqyfQNFxQb6g856wQzQpjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txXm5jUT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txXm5jUT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3568090851aso39449517a91.1
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771982473; x=1772587273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cC3kOG4PMTKHbBJlg/C79tGxZ75SzIpZ8/Nyw/YcEt4=;
        b=txXm5jUTtjG2qaNQibAT1ILeyH3rvkgFc38bzZWG+lkFX9V1r8ZGBOu47LlMZLzgvz
         5vlSmFhKkw9UyDkDMXeG8ppHMEEnez/Ue5Buau4uDtNL1XFR5rheE5oFPV+ng1v1yuiH
         Aa44i75Xd4SGFNMPlcWyvFhEg2wEQmatg+KiQRqJWtuiktbpJrNbjjTrjPyKFFniXH8n
         nzTmrYYPQOp8ESklKI9HC9VylQSnJoOgC4LxaEDpCAPi8f8KrdLOp2Z/K6aqcs1Gy8XL
         lo7ki9o648kzXuqxVnaKrm9Z9pXjeHrrOhvo27sY+4LgJTFBCuz2Sqm93gKPb01cHwij
         FQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771982473; x=1772587273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cC3kOG4PMTKHbBJlg/C79tGxZ75SzIpZ8/Nyw/YcEt4=;
        b=vaz8zZ5s4c6rG7Dt6dBUM8NlUH6g+JOEQTufdFS2lq4TbTg1aLqvq+VabPzdqjEnnu
         PlU1M0IJaGjZdfzxeC5XkTf+CK1DqUbno/dCpo4HaOqgY+q8M9PioTIPEUTew7nhtADy
         ZD5kvZ1hkQBhJAPn6folos8v8h79P+hXtbYVy2dHk+xBjfZDxf0pPACD28u4CRePkc+d
         pvKLS3ezJBD/VGKSo+r1ytCqSOiSgu6VLdI1pMIcTnjwS7LMIqCF3dNojMisZC8N5CpE
         hMH4/Z/s5AJhV8LYbNPX8N5IX0sHPMsysqb5GEhjhXBHkC4fVTjge15nvkNXOOfMagCQ
         dr+A==
X-Gm-Message-State: AOJu0Yw2sf9bIRglrzzIfZyCZfB+kNtwW1eKY5b16ekMHWFdQACvpGzz
	jHTtFXxccysfqe5eew1xoBAoyalBGflNF3J3mm1UGDhsH0Bjc3axs075Dr4CmfJ3K7gbpVE8fDo
	VtzNOJw==
X-Received: from pjre10.prod.google.com ([2002:a17:90a:b38a:b0:359:41:e301])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec5:b0:343:7714:4ca8
 with SMTP id 98e67ed59e1d1-3590f08c0e8mr548564a91.15.1771982473219; Tue, 24
 Feb 2026 17:21:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 24 Feb 2026 17:20:46 -0800
In-Reply-To: <20260225012049.920665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225012049.920665-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225012049.920665-12-seanjc@google.com>
Subject: [PATCH 11/14] KVM: x86: Fold emulator_write_phys() into write_emulate()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yashu Zhang <zhangjiaji1@huawei.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

Fold emulator_write_phys() into write_emulate() to drop a superfluous
wrapper, and to provide more symmetry between the read and write paths.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/x86.c              | 20 +++++++-------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ff07c45e3c73..aa030fbd669d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2097,9 +2097,6 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
-int emulator_write_phys(struct kvm_vcpu *vcpu, gpa_t gpa,
-			  const void *val, int bytes);
-
 extern bool tdp_enabled;
 
 u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5fb5259c208f..5a3ba161db7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8102,18 +8102,6 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 	return vcpu_is_mmio_gpa(vcpu, gva, *gpa, write);
 }
 
-int emulator_write_phys(struct kvm_vcpu *vcpu, gpa_t gpa,
-			const void *val, int bytes)
-{
-	int ret;
-
-	ret = kvm_vcpu_write_guest(vcpu, gpa, val, bytes);
-	if (ret < 0)
-		return 0;
-	kvm_page_track_write(vcpu, gpa, val, bytes);
-	return 1;
-}
-
 struct read_write_emulator_ops {
 	int (*read_write_emulate)(struct kvm_vcpu *vcpu, gpa_t gpa,
 				  void *val, int bytes);
@@ -8131,7 +8119,13 @@ static int read_emulate(struct kvm_vcpu *vcpu, gpa_t gpa,
 static int write_emulate(struct kvm_vcpu *vcpu, gpa_t gpa,
 			 void *val, int bytes)
 {
-	return emulator_write_phys(vcpu, gpa, val, bytes);
+	int ret;
+
+	ret = kvm_vcpu_write_guest(vcpu, gpa, val, bytes);
+	if (ret < 0)
+		return 0;
+	kvm_page_track_write(vcpu, gpa, val, bytes);
+	return 1;
 }
 
 static int emulator_read_write_onepage(unsigned long addr, void *val,
-- 
2.53.0.414.gf7e9f6c205-goog

