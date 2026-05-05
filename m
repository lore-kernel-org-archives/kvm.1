Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019384ADD89
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010810; cv=none; b=lAThhzYhuo2l6nZWpOCmYWDyK5uaF0951m3VV4pOnhuZh+1C79jTyKBSuHYaxjof+x89vFx4i7XtOaXF5MqGrkeQIAoDpp+VJQFdzECip2FX8L8oX2pKVgJXbEIssyXox9aP4lyMtRsXP8KhbB8E1GdH/gPRNCW9Ehz7z7IQfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010810; c=relaxed/simple;
	bh=FT9lcQD+L3zkH5bBSP7K/9dmqFtECa8WPyBrQGjSER4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lh9+yQAfzq5DbFO4zCP+bEMUIKvH1nXEXGp8R+hxBdmns+ssDVFe3CSwhbNTSVC6ydivlJ+iP2JmpM1DDkZzZnm1BESGJd4CQdXXX4g9qCnjyW2KHxLFZwGjgA5moUuaTdmiv1OQaQ70QqYsWFGWQZK3EY25GFyj3lH6IUuHswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzAon7eR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5Bu7/+q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzAon7eR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5Bu7/+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JW2NkdHUybOkD+rkbTyfynYD+3IdiQeIhLtvwGVvxoU=;
	b=SzAon7eR7bQgkRKvl3H5BoRiCtqNPuc4o7LUk3D+Luhi1ngnSjdbEflIe9T5sMmMTg03cY
	DZqk4BHgf2jiZyvPOz7cx+ozHsI8v5g87t+jmFin/LYGNwNhXza7Yvw8AIu58RZ05gCKWN
	HdBMCgpVemXSt/dtzi9RcL4Ta0swx9E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-VMRrdcNdMXCNIyxKkflisA-1; Tue, 05 May 2026 15:53:24 -0400
X-MC-Unique: VMRrdcNdMXCNIyxKkflisA-1
X-Mimecast-MFC-AGG-ID: VMRrdcNdMXCNIyxKkflisA_1778010802
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so3406620f8f.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010802; x=1778615602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW2NkdHUybOkD+rkbTyfynYD+3IdiQeIhLtvwGVvxoU=;
        b=N5Bu7/+qVHphwdpSrW2bQHGOqT/Ivc0PyraRpK9SJ0aHIF0Ole6/1JRIKQRqXiK6xM
         AGZZidz2fNvbuzkMZI0Gf2fIN6VBSlmnhVbq2HIQCxA66kAzIn0OehG40k3IFa6lL0hU
         QpE+q3ROiMSrnQs5C1MfJ/hSuEjor5hk/VYnosMozPmOuICIzybTgO3pilYSyO3OUH6v
         DB1EVEChr+fYzo1sSLmwFs+kd/ABKC5/xsUI9LHTN37drgpJvniJIMPMT1fhbDA1+rRC
         MD4BUpjwXJrc/YD4aeN2/roWPanTmDLhhDHzSVs+eWbVxz9dj6LIcXiXp486oCuTSXnA
         qGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010802; x=1778615602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JW2NkdHUybOkD+rkbTyfynYD+3IdiQeIhLtvwGVvxoU=;
        b=Gl4KtAEGCU9b+J4LDOZq1mAS+YRdCFzpr+GHFxqj11UQuX6iErIz0VfjLdZq9ceN6w
         r5Sg48kzlxgnyWbWcyK1nZIBPF6bJLhN8dKVslncC2H83c6LABLqD0ql6BmgHie93QGg
         mri1xZ2GGCH8THtloCP8IO1cSK2JxQ1Ev9ZwWj3YlR8X8ejBxkpyPTqvOZQUTqAxWDyt
         LsaA/G9UvwMvHAkNb58c1rCCn3gudZcgos9mnDDmGZIWFfwo2VcAhW9j4UKzrDpB9tzg
         NHVGjZ7vQZdlTmDlvwFtDi592Rg4gJoHrHvLQU8PLfHR6mNWiBdZMyGQfeH8kMHUXo2Y
         2lug==
X-Forwarded-Encrypted: i=1; AFNElJ/weTX03/qvJYJ6vq6nikmUmamn4moB86A4nzg1OmrklOCLGU2JXIgOfoxSqu7+zGN5wtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO83YGTo6VBy5a/N3KIF8vTad8moHrs6tJGPqxVEwp8Wy6kMaJ
	3md8DMFqfoY958yQoAUT5fGwszKJu3BdrUPXk40kOBCYUmf3UVmyqQ9S7iX6r1DSi8Nj4qN/10K
	4AMb5bJw1yIL2jCF57uMUnK0Q2Wrxa/6MAa0EbRPDK179pDyMUUPaeg==
X-Gm-Gg: AeBDievu62GZ6wTW4SLC9qmflzkk5sJDV0OAfFRExCtEsgqewKsMnUxGUgh/8AnEunp
	ytzCEe82lXl0fLHiKatXwVPsK5xL9I3e3WebSKLJn0kRzQZ9Z8+eNJTdyUH6jsZu0qMyLunmilc
	7l8ly15HLnzNGWaquSzRU15Thyq+c0GQ/94lbkcSZHRqJ9LQvTeK4eEDchubBXwlEaG17noL53b
	OX6fJX17Z57i05762aPXD1HGOruKs/stSO6eeRrCdJmm+VxRjxH69DWM0BVq+4XcYJitHRghRPw
	tR1mdM3KWwwFrtjuP6HYBGWflHlMp00LoXyshUCRGHPkJ16xh5nsItWucJ1IE6TGWyu5edUHrgT
	fooQXyD5v20rLA8jx+mTZePLa6T3OhX23L3KymjVKzM9noXXl2M4Mpv1TKQ/Q1sM5TGkf66Lc7L
	8Y2M2j0LLTtZ5cwX/Gs2E9LMOQ5oMlDpel6AUbxL4=
X-Received: by 2002:a05:6000:2910:b0:449:9aee:4575 with SMTP id ffacd0b85a97d-4515d3dc459mr832491f8f.30.1778010802261;
        Tue, 05 May 2026 12:53:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2910:b0:449:9aee:4575 with SMTP id ffacd0b85a97d-4515d3dc459mr832454f8f.30.1778010801819;
        Tue, 05 May 2026 12:53:21 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505558e213sm7083417f8f.25.2026.05.05.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 22/28] KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
Date: Tue,  5 May 2026 21:52:20 +0200
Message-ID: <20260505195226.563317-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
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

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 arch/x86/kvm/mmu/mmu.c          | 8 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 23a7ac8d7fbe..7dde4ca87752 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -414,6 +414,13 @@ union kvm_mmu_extended_role {
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
index 156bab8afbc6..912c8e97ef61 100644
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
@@ -5793,6 +5798,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.ext.cr4_pke = ____is_efer_lma(regs) && ____is_cr4_pke(regs);
 	role.ext.cr4_la57 = ____is_efer_lma(regs) && ____is_cr4_la57(regs);
 	role.ext.efer_lma = ____is_efer_lma(regs);
+
+	role.ext.has_pferr_fetch = role.base.efer_nx | role.base.cr4_smep;
 	return role;
 }
 
@@ -5946,6 +5953,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
+	cpu_role.base.cr4_smep = false;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 047400af924d..07100bbfc270 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -489,7 +489,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
+	if (fetch_fault && has_pferr_fetch(mmu))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
-- 
2.54.0

