Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5D3A5E6C
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549102; cv=none; b=mH1SgkGT0f/QgYklil5rqdbDqGXu6pRBPND4ncu/Th4W5LJ+wrvV3LiEke/gMuGohmOGIXZs5VU8X4Nwc8vgaYFQM4hNIACtma2hB3g4RtbLubHlTl4cYVkRB6NiSayShiQR4y7KzYyoyXVD18qhSwIyDKlNWPsMPD5KTgch/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549102; c=relaxed/simple;
	bh=wxUwamF/IKNL7Kc70Ut3PK/5eglbJ9lwMhvIc1yQTt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VR6zMJ7MXCV5dvQJ79Gnr6QqF5ZYVOzrEDtmJ6RZ6FkHbPytbdq6sLY4XHycOpQmmNaWdnEmkMooNLdz8OYz+zGRmZvJ7vKdHTNlhe3N0yh7rqcs0fGNy1syby4o/FQH010kbRCfkI9+112zoKrRiBRpoBdtqhZt8XmvEautIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1Y48QjT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5o8Qn+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1Y48QjT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5o8Qn+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1WDpr0IL4SQV6RsU7jl8CHh1K80JMh2v894DAgZmmvE=;
	b=P1Y48QjTx6v7O6Fx72IhOZ2553lQQ6s4f5DX3/zTb96spsf40SWkK0ugkBityUa8EVYBZ3
	t1m2euz03dIkxFnFVnT4EfH06GG2hSpFfiVal1jp7U/1YM2PN5CGKg2/5YItghQS+S+snK
	CsqrYi6jgtzatLF0iLX7ADM+jdNuIwE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-HH2OJIzJMt6pfCu2kDkcYQ-1; Thu, 26 Mar 2026 14:18:18 -0400
X-MC-Unique: HH2OJIzJMt6pfCu2kDkcYQ-1
X-Mimecast-MFC-AGG-ID: HH2OJIzJMt6pfCu2kDkcYQ_1774549097
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso13982885e9.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549097; x=1775153897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WDpr0IL4SQV6RsU7jl8CHh1K80JMh2v894DAgZmmvE=;
        b=b5o8Qn+Ros+ONr/IP91QUHizDB2mL3w5+ma4DGgiPc11Rq/AL258vLQRIEoOXpKaj9
         Ot9oaL0Cl+N8Xgu97PC1tj5GCtVuKArMqknTjK1iqpfluw5CJxjsUSgc47CkSMophkA2
         czzaYxAdqrQ9H03Ypo3AUbAD1vta7jdI4VSLchzV2519/jsry/FbZ0AbI9kzBPT/PrKD
         TG6WremUFLm6Shz8DFIOeq2UkpBumeNUI1w2VRpfsLivHDbFc6j+h2PjmL6HWezfkpBw
         ZSLvigA8lpWEEcnlB+ON2I8vR4L8hQLi2JGCsSzclZQFJyJTmTq+9Av1h4pPDqeHPZSQ
         cLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549097; x=1775153897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WDpr0IL4SQV6RsU7jl8CHh1K80JMh2v894DAgZmmvE=;
        b=bMQ3XTe6rJScX0XcdpfOvLzzp3GtT/TA0ffaBbwOccEpzuZlc7BlVvAR99A4AG5xGS
         uoiAKIChP3sayqfccDDcvlFEpm2JnLOhdNI8OMXOgqHDAa29XnlPcjtswrRdhD7mpG0D
         u0KViDt1njyzb+H2anvVu25d1YkS6D5o4ycpus5dflPYf1d48U4ov81mp1P6aChOtZtL
         nBfTveJh9rab9iDNr4LQEhXDeewouNv32+ZOkOKI0HI8xn7MS6s2W1I6X7DDCVpGz+q6
         EwFvb95wrkXR9PBzEmoANrNQ5FRscGaOI0UA9+y2pMpJ+tZQhOv8vYN3iKKhQEDbhAWA
         Y0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvFCDYe2ba0uURKbErG961983oh/qJkHJlFZnJocII/4K3hDpDUKy2CW14LbGygE4Cjcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQU93B3enEOobWHdlb+W3piWKTOF9w1rsahlkUtRMIUGaawa6q
	p+PVF85XW2rggGS1kj6NInP69z6jOhXrICNvWKqIiouVdDuwFB0wsbd2lkOT9UZv7gIuTuy1WuM
	oQcFLnOq80YIw84r3k8azoesu7Pa6zRe0uKfLhjMWecb/Fq/Fucv1zw==
X-Gm-Gg: ATEYQzwru/blJvrGSW5Vc6fUMbCtMamK/LpE6H4hfipr+2o2cnJFTOWPmVIS8osEFHr
	qP/qGw4XWV7XGluZqs/daGHoCybTa+yPP2DbH7UAWfWZroz//sqLjvAImDuTyTe6RlXYXHEXwBl
	vExrTk9Kp3Im+1evQW5GntQpNEhfqSdaabEU12+tz3HuhDbi6uP3WKvg8mK8H69atWkTdC1NdiY
	wQUQi39pk/qyg9IEaAY4VU61gUVlYxw7A/I5J9mukDH9kG4joRnk/ESe5h0+X1AN/arohV3us5w
	PTgK/0CzVkFKjaYJjQSPAlFh0km4Hqbxw5T6mEghv/rPQv3PrydZIDOQmSd+GJ0+ZeR9z/JHgaq
	cu7gD+EacXhXZ229JH0v7Tmp9iIOUbo7JknmJWWZfXVZ7zuygTST1R70XWN69XyLWanZTPFy8nb
	zFwHZo/v3u3EBPWHPvlvq3LaJm
X-Received: by 2002:a05:600c:34c1:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-48715fd47a5mr121812875e9.2.1774549097103;
        Thu, 26 Mar 2026 11:18:17 -0700 (PDT)
X-Received: by 2002:a05:600c:34c1:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-48715fd47a5mr121812375e9.2.1774549096577;
        Thu, 26 Mar 2026 11:18:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d38f52sm10686885e9.0.2026.03.26.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 19/24] KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
Date: Thu, 26 Mar 2026 19:17:17 +0100
Message-ID: <20260326181723.218115-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While GMET looks a lot like SMEP, it has several annoying differences.
The main one is that the availability of the I/D bit in the page fault
error code still depends on the host CR4.SMEP and EFER.NXE bits.  If the
base.cr4_smep bit of the cpu_role is (ab)used to enable GMET, there needs
to be another place where the host CR4.SMEP is read from; just merge it
with EFER.NXE into a new cpu_role bit that tells paging_tmpl.h whether
to set the I/D bit at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 arch/x86/kvm/mmu/mmu.c          | 8 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 50a941ff61d1..df46ee605b9b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -413,6 +413,13 @@ union kvm_mmu_extended_role {
 		unsigned int cr4_smap:1;
 		unsigned int cr4_la57:1;
 		unsigned int efer_lma:1;
+
+		/*
+		 * True if either CR4.SMEP or EFER.NXE are set.  For AMD NPT
+		 * this is the "real" host CR4.SMEP whereas cr4_smep is
+		 * actually GMET.
+		 */
+		unsigned int has_pferr_fetch:1;
 	};
 };
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 834ba9c0c809..94d7e39a9417 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -234,6 +234,11 @@ BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
 BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
 BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);
 
+static inline bool has_pferr_fetch(struct kvm_mmu *mmu)
+{
+	return mmu->cpu_role.ext.has_pferr_fetch;
+}
+
 static inline bool is_cr0_pg(struct kvm_mmu *mmu)
 {
         return mmu->cpu_role.base.level > 0;
@@ -5774,6 +5779,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.ext.cr4_pke = ____is_efer_lma(regs) && ____is_cr4_pke(regs);
 	role.ext.cr4_la57 = ____is_efer_lma(regs) && ____is_cr4_la57(regs);
 	role.ext.efer_lma = ____is_efer_lma(regs);
+
+	role.ext.has_pferr_fetch = role.base.efer_nx | role.base.cr4_smep;
 	return role;
 }
 
@@ -5927,6 +5934,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
+	cpu_role.base.cr4_smep = false;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 31331fe10723..8ea248e1918b 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -486,7 +486,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
+	if (fetch_fault && has_pferr_fetch(mmu))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
-- 
2.53.0

