Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF53B9DB2
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186526; cv=none; b=OxF8O5eszdjMq1qCnQ6niqVnc/rUbDrqp0Qr6nnDWq9OSuao17asNptnK3DE5yB6syHqcLKhSQgltn09+8vBJ/ZgMJf7MZO2H/Qk/9vRATOzVt0qLDs/UFzcDr7CSoughEXnHkzYynKQhoiSYMs4yTlVzwf2MC2qqeyYEtQSx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186526; c=relaxed/simple;
	bh=+CE1sMVEOlVNGNuq/FjIldXhgSK+ycKYDyubuZu6f6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LPwv/bOG3u4hb8UEmkocGRUcQmNNyGZPortQeadpTR2lyoEulm+yYc8kQV73DRcWj/SiVb3VBTh/gI1peFI1rDSP0WTs/c2B/rEkUQGH522L/ry0IaYDrl0xfrEjwfBwDQ1p+g5ds/vvrCUttGiGylMOHOXcmNENXH8fbO8NbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYjlzU+l; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYjlzU+l"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae6961bff0so398923205ad.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186524; x=1773791324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hnqlr1WU2mcNUm5UpgctK6uX9nSxmpmXtaHcxlHX+rw=;
        b=MYjlzU+l+8u05Vsojp3Ug2veuYeL4oGpNoufcEfdVpM5ookE6kjUpYkFpHbP7uPHwl
         DBpBIK0jOaYgp+/oinj3vvrlnEwF+twzYZuwkuKtQcIkVAVSWOww7akDdjSkl91wmJJn
         D2gg02Q2orWZWzQQ1rpAAU3GQ2Id4QETLA2tsA6O2am+9CZKWJ4F5kR5NS5XqiItLMcV
         ULHSNSnk00SGUKvndU9NWFwzW9movX1Gvk/HGqTThSP2FRCq0X4sEvQ4b5hF+YmlEKFT
         hZQXUla0JszQo28hbnGOX9TK2VprSSUaXMHA+orxnfUfQBSv2y6d0jd3BHkhiTGzmgwB
         h+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186524; x=1773791324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnqlr1WU2mcNUm5UpgctK6uX9nSxmpmXtaHcxlHX+rw=;
        b=QOSkglgeWIwDGjB45p5f24SdR2T36oiP2M4GTFr87h7x54ij5/Qb82kgiVUN7IuGKP
         1n8T1VTgn/E4deYifxTt7+d8uQiS1MhcgdWtvIZ3o9rQaUD/GLnsdnWpJMpiN/aYtS9w
         Kb+AbT3ED1/Taa9vFEPygfXyrwtvO8N+z8YwZ3awbKPBgUg3RxW9aH1gCFVq7dz63NUn
         tNFMEvDbt8GqIB8b8jfPIdmYRZ/nhSEGcaKYH+utAfnA/F9a/HfvxNnI0B3n1tdjQVVi
         7Y1BGtWk3ESWUWd82OwXcagTLRu4mnopnSnjGlzS87lQ+tI21iTyDFawTPWWYDt1DGGH
         x1UQ==
X-Gm-Message-State: AOJu0Yzj+pZKLt8SvhqbqZRbKVtOfbM/dMtcCqr+3sangW3yQ7hwYvBt
	ISmE/X3PByoDZlnwrYWpkiItk/E71+Y9tnbmBJMe9jmUDuFhlgKBAotzgAJetm7VYbVil7p630r
	b9hHBow==
X-Received: from pgww3.prod.google.com ([2002:a05:6a02:2c83:b0:c6e:1eff:44ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2349:b0:2ae:7f49:dba6
 with SMTP id d9443c01a7336-2aeae7b9c7amr5610675ad.17.1773186524360; Tue, 10
 Mar 2026 16:48:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:13 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-6-seanjc@google.com>
Subject: [PATCH 05/21] KVM: SEV: Lock all vCPUs when synchronzing VMSAs for
 SNP launch finish
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Lock all vCPUs when synchronizing and encrypting VMSAs for SNP guests, as
allowing userspace to manipulate and/or run a vCPU while its state is being
synchronized would at best corrupt vCPU state, and at worst crash the host
kernel.

Opportunistically assert that vcpu->mutex is held when synchronizing its
VMSA (the SEV-ES path already locks vCPUs).

Fixes: ad27ce155566 ("KVM: SEV: Add KVM_SEV_SNP_LAUNCH_FINISH command")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5de36bbc4c53..c10c71608208 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -882,6 +882,8 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	u8 *d;
 	int i;
 
+	lockdep_assert_held(&vcpu->mutex);
+
 	if (vcpu->arch.guest_state_protected)
 		return -EINVAL;
 
@@ -2456,6 +2458,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (kvm_is_vcpu_creation_in_progress(kvm))
 		return -EBUSY;
 
+	ret = kvm_lock_all_vcpus(kvm);
+	if (ret)
+		return ret;
+
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.page_type = SNP_PAGE_TYPE_VMSA;
 
@@ -2465,12 +2471,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
-			return ret;
+			goto err;
 
 		/* Transition the VMSA page to a firmware state. */
 		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
 		if (ret)
-			return ret;
+			goto err;
 
 		/* Issue the SNP command to encrypt the VMSA */
 		data.address = __sme_pa(svm->sev_es.vmsa);
@@ -2479,7 +2485,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		if (ret) {
 			snp_page_reclaim(kvm, pfn);
 
-			return ret;
+			goto err;
 		}
 
 		svm->vcpu.arch.guest_state_protected = true;
@@ -2494,6 +2500,10 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	}
 
 	return 0;
+
+err:
+	kvm_unlock_all_vcpus(kvm);
+	return ret;
 }
 
 static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
-- 
2.53.0.473.g4a7958ca14-goog

