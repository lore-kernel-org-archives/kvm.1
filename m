Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551222FFDF8
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051836; cv=none; b=TzYyllGFONjt6wcdXk5XqXqCoGvNRHa1YTg67hpw9CRjnjcEKf5oWKInodE0aplHLBP1biPEKj1kVdIsFk8s7lWAFd2kjMZxMEd7Hf2NjKDR8mQm1Wk2zYxViocqr3DPRJNqg8i93C2V/IZI5GyH3nwvyR2MbcNst+VoJjr3kXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051836; c=relaxed/simple;
	bh=hR6ikdWuhI2qG+icGaUmLS04/GWkH1r6O8oArtk4uzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkdCljVznobvR/xA95enLS7ZNmfXJDULx32KUIeYtAV7kCPNGMR/Qn3U/nFqnc5oRel/p8FkRy1Y0h+lFtlDbyFrnU4unxYxAmtpUHRnB4Rard37/dsgoOWb3W/jcVz7Qf5qYsFwImfUiiKxEviPhQwxtN35olNNq+O4ky3N07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dju5+GpJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLEmIy9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dju5+GpJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLEmIy9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMltVXI0rnLkVBMnchf5NfLX7cwXpJxqWzPAkjBf7Ao=;
	b=dju5+GpJ8FW9CBKw31QsTQ8/8vVYCts3yquFTJdT7L2cMSOnLxdquLAfcR59UHR4238Wki
	EOoKIkiqVI3ObEWo0My51qRjndE6WsgOourgOZgRVQoxpnWVhtZpeppHDMhCBM0DEIZJt8
	OOhSFmJjL5escO7wM9M54A65/M7FG5Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-P_Q34oz5N6yJS2VSv_uqtQ-1; Fri, 20 Mar 2026 20:10:33 -0400
X-MC-Unique: P_Q34oz5N6yJS2VSv_uqtQ-1
X-Mimecast-MFC-AGG-ID: P_Q34oz5N6yJS2VSv_uqtQ_1774051832
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b41d45be4so2498271f8f.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051832; x=1774656632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMltVXI0rnLkVBMnchf5NfLX7cwXpJxqWzPAkjBf7Ao=;
        b=cLEmIy9iSI0GmWxz4PlRNzDh7R/Dvw8Q/037acIQKFqNWOfO3mgvmLpBXoFQd/REhk
         Al186fQw+u1aJOgTn2qCPmTOCk9Jn2mSUAI4ys2Vb1ATES5yiAWRpMDH2OjcBXuwnNDS
         OMN1PR6izNcowtAu7KgLX5p7W2K5GERvTKh6i24LiglVLoxDLWefNqSbR+5hkUcYScOi
         hXUsKBRdVUzGp4GPBwtue2csgwfE6iVD9KMesdsMvkB9JZaYaiWv4ifUQtyMKVh3T5dN
         tNPcLksAtW1Nqm73YkEyDNcV3ZPklbRkXgrl52AVe+jO8zAZECtBZmU/frh2hDooH/Dy
         DyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051832; x=1774656632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMltVXI0rnLkVBMnchf5NfLX7cwXpJxqWzPAkjBf7Ao=;
        b=N6JN6LiphZGrjv5kOs7gBtkBfse9aOC/xwEuWMNwsqNN1OvUj8J160pPOaGPDtxIcN
         ZjdBIOfI0y01J8CnhecMQUZeukGIMWybNQe8oppI0akzJsNLhFA6UUKNvCCuNYnRAMla
         VTy3ay1koPCgt76+lliw1jtNiXSA2Sx1QVixqWc4doqeRfPClb6R8Rw2dD/O//8m/BB5
         zXtxMaRhCaUGAfTer+KpU0aZbI5BTE8/g5g0qLNOg+aMTKcQq7jp2Z/e8VHn+KGyxvwr
         VXC4/T36wh2W/ZfGhsSdy7TVoeSrr6Wwe2ryx+TN71ADnuboqeeUWiaa9CMDUgSGcvNO
         V2DA==
X-Forwarded-Encrypted: i=1; AJvYcCXO8zeVUBQpoK4Fro9DXrKQRZ0ByYM66a4itTB/wCiKJSUSDrPbmdrTU2x1uR18sDmhd5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLcYQ2/5iFMGuX4bbn6x8UtAI7VMef6TBWS3AXhM3H5UbWQWv
	DKASMdREMUCvppnvp8NiPTjYyWTMC66tbvvw9FgAw6PBR89ETR9NHFgHN8keH4bgzhdqciTedad
	LvXiGSEE3mrmSnKT3zHBAwEJ4Ulifi8nR4NJ90FKQ/Bp8hGN+wjzlYQ==
X-Gm-Gg: ATEYQzx7X/+fnEpAWmBXRb02t6rDv2YvhAqLeSNS4LvzSBmb8KJjvfMNkFhems3uEFI
	Q1nHqr/HgaSe0Yebvuwu5JBk+zYzcZ9xzE0fQqEXXXirSG2JMr1SVdKi9KaOsNZYK3fJJDdQ+Gz
	tR4GM5V4ngIpoomD4OVeisTv9JmrtXqqElwkbLdQcrU9FmYjhRbE5rkt4I17n02laUkAQMIccf2
	/Ar+KmLyF3r6HCJ65Bun94dfEDR34XVPrLzEd/nTZHBpjfTETbTjv3AecULNBTbSLIVbiO3F9bK
	pbbVFajl4GchtAdzKlfzI+fGNuvbvHQnkkFnuvRHrC+jc0alWWYGb5FkYEltzR1LnTiZl8RfcvT
	khQmQRl+jH+EzfYocW6slztUj2br3rmFjKa72B3RMVYEC1xJN1ptXxUzvkT44Nj73AUF/6/hgdR
	8fSJWnhDMhRuJg3x/P1lUcsy5d
X-Received: by 2002:a05:6000:2b10:b0:43b:3c53:283d with SMTP id ffacd0b85a97d-43b57729855mr9903523f8f.21.1774051831793;
        Fri, 20 Mar 2026 17:10:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2b10:b0:43b:3c53:283d with SMTP id ffacd0b85a97d-43b57729855mr9903503f8f.21.1774051831384;
        Fri, 20 Mar 2026 17:10:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm9497992f8f.20.2026.03.20.17.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 20/22] KVM: SVM: enable GMET and set it in MMU role
Date: Sat, 21 Mar 2026 01:09:29 +0100
Message-ID: <20260321000931.1947084-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Set the GMET bit in the nested control field.  This has effectively
no impact as long as NPT page tables are changed to have U=0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c    |  6 +++++-
 arch/x86/kvm/svm/nested.c |  2 ++
 arch/x86/kvm/svm/svm.c    | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index eeb8667a283f..06289b2d4f96 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5734,7 +5734,6 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role = {0};
 
-	role.access = ACC_ALL;
 	role.cr0_wp = true;
 	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
@@ -5745,6 +5744,11 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.direct = true;
 	role.has_4_byte_gpte = false;
 
+	/* All TDP pages are supervisor-executable */
+	role.access = ACC_ALL;
+	if (role.cr4_smep && shadow_user_mask)
+		role.access &= ~ACC_USER_MASK;
+
 	return role;
 }
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 617052c98365..d69bcf52f948 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -773,6 +773,8 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	else
 		vmcb02->control.bus_lock_counter = 0;
 
+	vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+
 	/* Done at vmrun: asid.  */
 
 	/* Also overwritten later if necessary.  */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 23cb4beea886..4a4f663b2bd2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -134,6 +134,9 @@ module_param(pause_filter_count_max, ushort, 0444);
 bool npt_enabled = true;
 module_param_named(npt, npt_enabled, bool, 0444);
 
+bool gmet_enabled = true;
+module_param_named(gmet, gmet_enabled, bool, 0444);
+
 /* allow nested virtualization in KVM/SVM */
 static int nested = true;
 module_param(nested, int, 0444);
@@ -1184,6 +1187,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 		save->g_pat = vcpu->arch.pat;
 		save->cr3 = 0;
 	}
+
+	if (gmet_enabled)
+		control->nested_ctl |= SVM_NESTED_CTL_GMET_ENABLE;
+
 	svm->current_vmcb->asid_generation = 0;
 	svm->asid = 0;
 
@@ -4423,6 +4430,11 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 	hypercall[2] = 0xd9;
 }
 
+static bool svm_tdp_has_smep(struct kvm *kvm)
+{
+	return gmet_enabled;
+}
+
 /*
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
@@ -5147,6 +5159,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.write_tsc_multiplier = svm_write_tsc_multiplier,
 
 	.load_mmu_pgd = svm_load_mmu_pgd,
+	.tdp_has_smep = svm_tdp_has_smep,
 
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
@@ -5377,6 +5390,9 @@ static __init int svm_hardware_setup(void)
 	if (!boot_cpu_has(X86_FEATURE_NPT))
 		npt_enabled = false;
 
+	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_GMET))
+		gmet_enabled = false;
+
 	/* Force VM NPT level equal to the host's paging level */
 	kvm_configure_mmu(npt_enabled, get_npt_level(),
 			  get_npt_level(), PG_LEVEL_1G);
-- 
2.52.0

