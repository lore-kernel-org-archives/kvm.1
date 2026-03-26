Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899163A256E
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549096; cv=none; b=Dv9NXrE/xNSwGm2edfktsCP6VZpntUjVdaQ0WkKPolpFsEWUMM2vECLm0HY6tsZPzLqEGiknOH4YeOKxapkk4DrYMP6WTRE1n3sZH6UdeyFyKt5zcUosNhBATC4zJCWemFj+YLjlXHPs6dE6cQE2Gwb1YrlQh71MAkoniO/5J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549096; c=relaxed/simple;
	bh=5gpuzpBc3Bpn9SAXMiqC3JXeJEFjr6zURoeZIrXOkY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnYTKkZeDFLglCFzeTWmKJ8WG0p99RWD9GK3RZ9aTde55ASVrxVzAA83Pw+eH5dqyVAw+/GbjsqDCgSHTye0bJpCNn7DQDb5we1d0fI4IgA2eyhPjwFkfDFnC+l34AJvZjt/j56XIKZXAOczbEyfBwZalSVV7QzbynQqIO/krpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I27xFWF6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyBNexFh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I27xFWF6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyBNexFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40gLkqvYyhKvnAeiPGvS0laQA/Arm+OR7E3p28AiBGA=;
	b=I27xFWF6JhiU3ApgH9mZilcHqbALAewFRJUvST3Ypg3hQbJHcfVs0kvf3LJxAlNl8huAvC
	mBsuJUNUlA1kL3biGasddJWOPGDYKhI14HSjt0CUigzRTroMDQw4PsU0p4yVgpLoQyt3Yi
	QGgUB9am2buF0s+PU/YBijSNYCHDLiM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Yf-MCgw2M5C3MaW83gbUPA-1; Thu, 26 Mar 2026 14:18:11 -0400
X-MC-Unique: Yf-MCgw2M5C3MaW83gbUPA-1
X-Mimecast-MFC-AGG-ID: Yf-MCgw2M5C3MaW83gbUPA_1774549090
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso13564885e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549089; x=1775153889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40gLkqvYyhKvnAeiPGvS0laQA/Arm+OR7E3p28AiBGA=;
        b=UyBNexFh/SjBFfVcqbVJ1MPIOytQtHbzskaflP+m4oTwESrpM27Ll5OrAdYTKJ5xfb
         BPQyN7Be1JE0Mc9o6kXhMIR9YNkfd7Bki0iYwwnz7v0rkeuZoYChcPv5FrnjR8/aXcb2
         34UHCG32+rrtbo54+beb3dnsOG0o1OqveYEnWStD0nyo2hxoJEbFTUkh6MRhV1YRddH7
         iCoLNW3KiW+Q0P4PmS7A09IHqu1fFFUZtCAgIPLb8FjeHX5SBYoT6Tma1klSPkATgrGK
         2u9ppz2IqdYM8ZjtfYCGtqZiP6Bxj83WqwYVyVjuUxZIRoTBjAVlJ824/fTn7c0m7xdc
         xq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549089; x=1775153889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40gLkqvYyhKvnAeiPGvS0laQA/Arm+OR7E3p28AiBGA=;
        b=Qib9v4n/Iu/D+TVsRKxDK72OrfcRbRYjnmQG6qxOiQDDST7H/VJN8SujAziQp1tyEV
         VH5admlRDgTFBxKjpPcIUcbRtRDjo0Du7PGCqMFdTRN01E422Ja9osEDLb6jkvhntgFX
         11M4gKRdtBYtiaZSpSlsTtckV+j/YtY6q591XliQkaPY5dHmV58TpjuHvmvQyFcS+yPH
         GiAsYjvIrHbQ1sMGC4ZDqjhLZaG4mYzCGS1lgXSxfpOLKjbjNf4glEGl8SGjgZOA4Wdh
         ACTP5ACNGBqsZk0R7/uV5L0UMo76ArRegLmJ2YnLnya8T5FTwJ4ZwWzEU12YIor160tu
         OxHw==
X-Forwarded-Encrypted: i=1; AJvYcCW135Cuoz189OkHtdZQndxzZ0aWO8kXj/n+o8rBgr9So6I0MKK7WOQVNrNN9YIRekO4lQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvoUaWA6vwICJv8lEe3VM/ccUHgjtzkwdc0fVUT6tTFHqH0Ut
	wpfag7Wxe46CVVg5M9J6ZwG0vQ1JbPXXuXFRTXQPUm9m+NwJdTRbeUioP+roVwLicZCNNQZodjB
	GzvLBg9JQ078q1xONgeDyrWo4sK1ln9rL1tMWG3WLjARdh1ZmqkgdQMll+AvQ4g==
X-Gm-Gg: ATEYQzx70pse4l85xTBVLsRdW6IJnHi+vY/lrB6sJtzlRT0iSjMwg/UqsIvcL665cpt
	aGq8U+oM9rQOikbF0cyP7wXVM4+0l0mDsQ3kGUurgZZRqTZAmwX421XcVa11YmVopHcHWKHW0Ki
	KHGXlQjVrcTwhRRAKCxm56dMwj7KPiKQCP8fkdiF5yCrRdbvOm4xwn3uiVbPlpL8jUCr1kNVZze
	XXe+8IEIHcQWpopuqjmNxOx4pFCBXWJAUFkyaNm0tVGeHpeXNeR3EBO6fKndrXj8Im8xVOsG1ly
	OlUzInrgi5rmw6LOlAgVdN6LBMyDVghNQAYOGp6ZGZDBdoeUPiYhxt9fvGHmKcCEBHJkLvavJRK
	ypd0LDNuJWoTevLDyEpTSk9c0lJ31rdjv6oAmi42kLQm2LB7dr9ljXzlPTwDKTUU75ZYprZUrsW
	0ljy5zL3JVPThlXHrAikixoXQe
X-Received: by 2002:a05:600c:1d0e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48715fef618mr126829335e9.12.1774549089439;
        Thu, 26 Mar 2026 11:18:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0e:b0:486:fc95:1a91 with SMTP id 5b1f17b1804b1-48715fef618mr126828805e9.12.1774549088943;
        Thu, 26 Mar 2026 11:18:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d9fdffsm2929365e9.5.2026.03.26.11.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 16/24] KVM: nVMX: advertise MBEC to nested guests
Date: Thu, 26 Mar 2026 19:17:14 +0100
Message-ID: <20260326181723.218115-17-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Advertise SECONDARY_EXEC_MODE_BASED_EPT_EXEC (MBEC) to userspace, which
allows userspace to expose and advertise the feature to the guest.

When MBEC is enabled by the guest, it is passed to the MMU via cr4_smep,
and to the processor by the merging of vmcs12->secondary_vm_exec_control
into the VMCS02's secondary VM execution controls.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-9-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    |  7 ++++---
 arch/x86/kvm/vmx/nested.c | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 678ce021991f..fa1942b126fb 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -93,7 +93,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
-			     gpa_t new_eptp);
+			     bool mbec, gpa_t new_eptp);
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cd2418fe8708..442cbaeaf547 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5940,7 +5940,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_npt_mmu);
 
 static union kvm_cpu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
-				   bool execonly, u8 level)
+				   bool execonly, u8 level, bool mbec)
 {
 	union kvm_cpu_role role = {0};
 
@@ -5950,6 +5950,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	 */
 	WARN_ON_ONCE(is_smm(vcpu));
 	role.base.level = level;
+	role.base.cr4_smep = mbec;
 	role.base.has_4_byte_gpte = false;
 	role.base.direct = false;
 	role.base.ad_disabled = !accessed_dirty;
@@ -5965,13 +5966,13 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
-			     gpa_t new_eptp)
+			     bool mbec, gpa_t new_eptp)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	u8 level = vmx_eptp_page_walk_level(new_eptp);
 	union kvm_cpu_role new_mode =
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
-						   execonly, level);
+						   execonly, level, mbec);
 
 	if (new_mode.as_u64 != context->cpu_role.as_u64) {
 		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4b742a19bfde..1e84ca353cec 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -469,6 +469,13 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 	vmcs12->guest_physical_address = fault->address;
 }
 
+static inline bool nested_ept_mbec_enabled(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_MODE_BASED_EPT_EXEC);
+}
+
 static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -477,6 +484,7 @@ static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 
 	kvm_init_shadow_ept_mmu(vcpu, execonly, ept_lpage_level,
 				nested_ept_ad_enabled(vcpu),
+				nested_ept_mbec_enabled(vcpu),
 				nested_ept_get_eptp(vcpu));
 }
 
@@ -7255,6 +7263,9 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			msrs->ept_caps |= VMX_EPT_AD_BIT;
 		}
 
+		if (cpu_has_ept_mbec())
+			msrs->secondary_ctls_high |=
+				SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		/*
 		 * Advertise EPTP switching irrespective of hardware support,
 		 * KVM emulates it in software so long as VMFUNC is supported.
-- 
2.53.0

