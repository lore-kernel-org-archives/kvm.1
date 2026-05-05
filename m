Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ACE4C042C
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010794; cv=none; b=nb6dFnIG/A0wsiVMRjuDqjoLVZ+SibdE/pQgHjf/lO0f2jqVzGxIWnuJW+/7srPto7LUMhAJEsreg1ro1stfqWIqFo/OzLYN5sVZNqjzcgWWniAAAgFV6y64GzOv4Pw+7QOUMqJLFaIb/JDobYZVeIBCLuML36fIYL5T57P10BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010794; c=relaxed/simple;
	bh=jfvm/JnkfbaGQPdbMd6FbQ2YV2ugfIWTAz91e6zk7U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plLn4+KVlHeO7QAEzvnmsbqTVtGUshH9dIbfxSRlVxBcMMZf0yjvVom37A/TZNC/ucgOC198j6qvPW4Vt/GMD4i6UdtA9jTr0C51u2ykA4gt4FU42uS7+7Tidty4TOHGADuMOIpTjBqKGtp1mti4K/M+HzM20jiTuq46Z4UQAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feIgyA1l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXQ/IDRv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feIgyA1l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXQ/IDRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gfkifHMFZcUI+UK6c3nYqWoKDoO6Dy1f2zDJck75gI=;
	b=feIgyA1lq/LjPRZc9uVncr0lm1mBilu5Z5srfODGbQgYU+vfh5GPoWCV5hH6XivOHKFSYP
	TvE6WxFTzFVuXsN1Ng96/mv6K5OnlcapLW4fJG0IYQatyxUDnTLfmJwnMp26r52312tYQR
	CkT7ADfogDuwzaSPGSxQwvnXzNCwJ+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-J7V22uorOi2Uy1MNx8Myow-1; Tue, 05 May 2026 15:53:09 -0400
X-MC-Unique: J7V22uorOi2Uy1MNx8Myow-1
X-Mimecast-MFC-AGG-ID: J7V22uorOi2Uy1MNx8Myow_1778010788
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44ffa15dc73so983264f8f.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010788; x=1778615588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gfkifHMFZcUI+UK6c3nYqWoKDoO6Dy1f2zDJck75gI=;
        b=OXQ/IDRv47Bx6AMLIEKkjX2oYFQBhVnIrU1tmwwAfQbeFYASy5wMq/HN5dJEmGh2th
         7/+1sf1l9jY9pF+Jx7vfj+/V6gkTjQ4i+lWnmbq/txCpR619rJK7QUEjvPZR4da6wbuJ
         D7amuohkVQd2p/LMzAOWjvLDfMtITm0bUSBEU1rYsZL0e31fH9Xj3s3QhmYfmfYZwY1e
         dykzaE8YSlDE8ojxcNetUfsJMEtLJXOsH789bIoU392UtpbLqL0hWA+WBN1cVn7+bEKT
         RblVVVlWgLKRvqk6Dx/wnYTY/ks/Q2L3u28K/LjHk4sLYovvjmJmO5/Cs+Kyf86KuBYA
         MLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010788; x=1778615588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gfkifHMFZcUI+UK6c3nYqWoKDoO6Dy1f2zDJck75gI=;
        b=IQyqD2jozslSdc1ughgrj3lkYpX0MlBCgOyP4OIc7dKumbT4Wxo64xxKv5j2wvwfnl
         Xs5U9FCWyEzpdPwsUYnv6X88Ma12y1AtunQBv96XKUvEuKkXL7rIzZ9wAONoUVGI/LgK
         Alw/gJ4xjWWK4K9KI1K6L7WfLsHhQYdUS6YFiR5FosjoAjL4CtaWRbXNazcGlZFsNozg
         7wr+E/4tfeqJaQZ4yuwHcWntZKgVbLnYNCH7bKLFpJuauyns6INVZu90QeV1Lblekmzb
         MLVqd7A0cBCcM96tB48+zv6e6DJSIBDMACzmE7AnRI5UbMeOXQ6vk9P3Tl0Fvmzv21ri
         9elA==
X-Forwarded-Encrypted: i=1; AFNElJ/rlE/DHRhA7V5RvXR1S7bURuAt0O3e2YdqBl37Py9ANw7cbmrefZKi5e0WpUAWLNVv3zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOSsF4erljKg4TtI+OMm3qH9X02wuj/jgFVpHcO8ox9mpRmOg
	kHKFfFkxgrksiEY3KWSTeImqN+ycjS8SD6dGU8Mo0vC8/QV74FaWY64KzFD/cxqlQYF+IsldInr
	7p+4A1FYhmLAhXCbSZkAQFDeCW+wE2pv/1YRvYZNcr+c+JA9r49ygMg==
X-Gm-Gg: AeBDievZ9X8O4mbtMqgsTeYjvmWPEUh5z8cu5fLoMVKGm+9qqm/ofGnzCCA9QBcC+7b
	X7p97Zn6ezO01e01xT6Qbp4sn+hNOi66q7HMtZf0g5yFOSI97PAK/6yA37mEyDPt+xyXI8FwJ/Z
	L08r+Ira1t2berHOMkuJCbbr2Ee6SWrxJTGHkZaSL3Gi5wRzz2Et9Dz5OmuEd2uuT6wwsOuJHFg
	0N0anJttiPck2zTWodR3LKPEG1dOClOlh89Wr5mhUVA5Qvxa2OrM9v4dTbyLOm1sTOQKEGTYaaS
	O1AcdYm5mEj/yaKoSo+ZZ6RJ5nlvsR+LKN5LVwZlB137um+Qhvyc9On9nSogCwg7tD2ma+XiG/i
	WfM9ExEFM9jizfOONOXigkI2Gd2OirtM+qqW5TEWh8kbTmA1I0kZs++2gfivqObndl0Lpk53lNR
	TZprBhoTcAh6LUB1rLvSzL0lMm4NkMTqmwnW43NTE=
X-Received: by 2002:a5d:5f84:0:b0:43c:fe0e:5bb9 with SMTP id ffacd0b85a97d-4515b523fa3mr789622f8f.12.1778010788049;
        Tue, 05 May 2026 12:53:08 -0700 (PDT)
X-Received: by 2002:a5d:5f84:0:b0:43c:fe0e:5bb9 with SMTP id ffacd0b85a97d-4515b523fa3mr789599f8f.12.1778010787670;
        Tue, 05 May 2026 12:53:07 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524833e1sm6878462f8f.2.2026.05.05.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 16/28] KVM: nVMX: pass advanced EPT violation vmexit info to guest
Date: Tue,  5 May 2026 21:52:14 +0200
Message-ID: <20260505195226.563317-17-pbonzini@redhat.com>
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

KVM will use advanced vmexit information for EPT violations to
virtualize MBEC.  Pass it to the guest since it is easy and allows
testing nested nested.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h     |  4 ++++
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/vmx/nested.c      | 13 +++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 54aa5be50df9..ed2ded531e55 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -535,6 +535,7 @@ enum vmcs_field {
 #define VMX_EPT_1GB_PAGE_BIT			(1ull << 17)
 #define VMX_EPT_INVEPT_BIT			(1ull << 20)
 #define VMX_EPT_AD_BIT				    (1ull << 21)
+#define VMX_EPT_ADVANCED_VMEXIT_INFO_BIT	(1ull << 22)
 #define VMX_EPT_EXTENT_CONTEXT_BIT		(1ull << 25)
 #define VMX_EPT_EXTENT_GLOBAL_BIT		(1ull << 26)
 
@@ -617,6 +618,9 @@ enum vm_entry_failure_code {
 					 EPT_VIOLATION_PROT_USER_EXEC)
 #define EPT_VIOLATION_GVA_IS_VALID	BIT(7)
 #define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)
+#define EPT_VIOLATION_GVA_USER		BIT(9)
+#define EPT_VIOLATION_GVA_WRITABLE	BIT(10)
+#define EPT_VIOLATION_GVA_NX		BIT(11)
 
 #define EPT_VIOLATION_RWX_TO_PROT(__epte) (((__epte) & VMX_EPT_RWX_MASK) << 3)
 #define EPT_VIOLATION_USER_EXEC_TO_PROT(__epte) (((__epte) & VMX_EPT_USER_EXECUTABLE_MASK) >> 4)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8dd9d510fc34..d4ce55195a7c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -494,7 +494,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * [2:0] - Derive from the access bits. The exit_qualification might be
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
-	 * [7:8] - Derived from [7:8] of real exit_qualification
+	 * [7:11] - Derived from [7:11] of real exit_qualification
 	 *
 	 * The other bits are set to 0.
 	 */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 299d4ca60fb3..46b65475765d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -443,10 +443,14 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
+			u64 mask = EPT_VIOLATION_GVA_IS_VALID |
+				EPT_VIOLATION_GVA_TRANSLATED;
+			if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
+				mask |= EPT_VIOLATION_GVA_USER |
+					       EPT_VIOLATION_GVA_WRITABLE |
+					       EPT_VIOLATION_GVA_NX;
 			exit_qualification = fault->exit_qualification;
-			exit_qualification |= vmx_get_exit_qual(vcpu) &
-					      (EPT_VIOLATION_GVA_IS_VALID |
-					       EPT_VIOLATION_GVA_TRANSLATED);
+			exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 		}
 
@@ -7240,7 +7244,8 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			VMX_EPT_PAGE_WALK_5_BIT |
 			VMX_EPTP_WB_BIT |
 			VMX_EPT_INVEPT_BIT |
-			VMX_EPT_EXECUTE_ONLY_BIT;
+			VMX_EPT_EXECUTE_ONLY_BIT |
+			VMX_EPT_ADVANCED_VMEXIT_INFO_BIT;
 
 		msrs->ept_caps &= ept_caps;
 		msrs->ept_caps |= VMX_EPT_EXTENT_GLOBAL_BIT |
-- 
2.54.0

