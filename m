Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763C325A2A2
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051816; cv=none; b=i8ixX3h3ZHTI1Oj27ja1NobAOGc5Q0bcZ3haEI2anmj0gKFHojz3Ma6Ma5+0N9fnWCovbWmwV8Gywi2yT4yiQ7PH5yuF3qczJSvF8CXqq1X4x+w22c3yuTvW9XkYKgm237XuKyfgRKQLQnFd/Z86Up6b9mrYFAQLCWoG/dDQDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051816; c=relaxed/simple;
	bh=m150tyPF0qz+Yniy1uibRcAotrXLeoPzs7/NaMKpPOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sity00UpprXQCoFoI0OV/lPm1M4UJnXjK3noTCUgG4KeFaE+3ML3jfIaHLG9116jtyKnF6Uab21aQ/y2OQpBEhwOcWde66p8+r0rsR38ux+s5kNR1U9SGkFGnayshOe3SWzk7pemtjVWLjm1RXIZqUVw81nzCUzce+guoBQba+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5YdpAYB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWwZJ9zF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5YdpAYB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWwZJ9zF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73seKWR51q+TIpru2UraHv6BQGSCJ+KST2GFL+f5EOY=;
	b=E5YdpAYBKSMgUJD33GHM3wQ1/dtW85zuyyo9GjACtFNlHG8eD4COIm7jlnuaN5g40R47Lb
	fdz1srxB21hxuCHSSbXBn4lesdxjCSUAO8Q3p27S5OLdrbDh3tE15H3hGtQsmpSlN6FQ+L
	j6GzSVSu9P26WzAMQdSyn05lYxzdqbk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-X4sGMgLTMwqjo6v5i_WviQ-1; Fri, 20 Mar 2026 20:10:11 -0400
X-MC-Unique: X4sGMgLTMwqjo6v5i_WviQ-1
X-Mimecast-MFC-AGG-ID: X4sGMgLTMwqjo6v5i_WviQ_1774051811
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b4a9a3bf6so490399f8f.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051810; x=1774656610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73seKWR51q+TIpru2UraHv6BQGSCJ+KST2GFL+f5EOY=;
        b=XWwZJ9zFh9f6TKLxwTRRSL2rnKInjOOCaA32w0hJvilFaQ0SMZj3bl6IBWFB7tmuga
         a08UlrZPdVzUShGZx+uAWtMwjMaWcqa2Umk/MNlRjjckmCSrhQwpiXspEG8BUQgEyI7A
         aJz/n4DLSMF52S11vQUmMqM4UKuP8ZNG9UGo7Z4JIT+zCHXmkJX7SplEiHFWJUxcFOjA
         jMOE6DSE/3z3iHsP+9jD+fBnnKbF/y8JCnzOsfIlbotUBCfAKTGJp6Oh+mOrYw0fYyaj
         OYm7jgQvAOB1I14t0Qf4+m0z2az8xwy5+PKf+d4hnK80TahtDHi03kF19sIaajz8Ymes
         VKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051810; x=1774656610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73seKWR51q+TIpru2UraHv6BQGSCJ+KST2GFL+f5EOY=;
        b=UKEfkuhSW/O0nwQi0hTKdeDnR8n9uJF1Xa+aKFlSZ7I4mWziQRcBjpMsCYjCcGImG4
         tawMMwcwwhLCS7E3ccR2mKvehxLghUrZkCRPeUrY7lR/0fIPH2c0OV4wuZlW1Qf7i2yE
         SVottndeqqA6lqnouAhYy5m4nBcCA2TL+o5GzLmglFJ0yg9KvrKHxAGmnbmlrSvRiAwf
         0GFPo5985iy/FO6b+kGWj3TOQzRrP6CPI4plW40+JRdD2/0YFuGGshRrGe7Szt6ENQku
         U+bTvjYLegwK9HWvikgLA3ObnygRKUgBWS2gXWs7CPMZkilS0m7z9ILtgpKJrKEGIXI9
         Bk5A==
X-Forwarded-Encrypted: i=1; AJvYcCUv0mdwabw06BRvqL8sves/TmW4uaKwqSxF0i8SOSzjB8EScQ7NoKAZnWrgmyssbeWhuqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBx/tL+HLrd6ydopHdmWcNGrliKFk8BJ0bI55sUrIFcET87J8U
	GJjKVe6+sXUaoK5jtnC/zc4YCrcNxhZjreN5bKCrh3OGZirywJBgqfvExayJVcpcec+hKzRihmE
	aA1FTEka2OXoMciTuFOnavjRxG3upMCRlMJ84rWq+Q9o4MaZj6aOveg==
X-Gm-Gg: ATEYQzx1yAVjvVegiMgODVqaptxsn75lBw7PdmWepuRhwLYKJ3x8v0A34xGoPgRGRsx
	WBLQNWfDbdl++jr+JhDIeHLmlM72qPKY1xoQ/WJ/01xmKHaBJXPyaR95jkGezI+XSKwjo0YTBiG
	k80GY7de3FKx3nwGbra9aAfqJmUUpT7nEy/ggmzphdxsUN5eTOGf+kZT4aD5ZIYNW6Emssv8ISS
	kD1VCPl+eXsI5zHG121VcHCkLCPEsptHq+vLLhrSzP+2+YA9gKxoNhjZezLBYQ907yIhVNDMrbJ
	khVULQVQQuhTtv0Fny+IxHPVgd8qAhPbSC5hVkD5Sk6udaMULxLYMXLAaL48ksF4ZPxy3c3SS9+
	YRXcki3chXT6igJcx7qYPr1CNfsWjUb6C3s9Ct5YXKh/NJLYluHF3g92Q7LWmIJ4OoJYUFUA13f
	ODp1svAImtMW9hpo981B8t0GPz
X-Received: by 2002:a05:6000:2dc2:b0:43b:4aba:8f44 with SMTP id ffacd0b85a97d-43b64287241mr8001819f8f.45.1774051810534;
        Fri, 20 Mar 2026 17:10:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc2:b0:43b:4aba:8f44 with SMTP id ffacd0b85a97d-43b64287241mr8001798f8f.45.1774051810116;
        Fri, 20 Mar 2026 17:10:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae132sm10122385f8f.6.2026.03.20.17.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 14/22] KVM: nVMX: advertise MBEC to nested guests
Date: Sat, 21 Mar 2026 01:09:23 +0100
Message-ID: <20260321000931.1947084-15-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Advertise SECONDARY_EXEC_MODE_BASED_EPT_EXEC (MBEC) to userspace, which
allows userspace to expose and advertise the feature to the guest.
When MBEC is enabled by the guest, it is passed to the MMU via cr4_smep
and to the processor by the merging of vmcs12->secondary_vm_exec_control
into the VMCS02's secondary VM execution controls.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-9-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    |  7 ++++---
 arch/x86/kvm/vmx/nested.c | 10 ++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2a6caac39d40..035244ccbb5e 100644
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
index a0b4774e405a..647dffb69d85 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5839,7 +5839,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_npt_mmu);
 
 static union kvm_cpu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
-				   bool execonly, u8 level)
+				   bool execonly, u8 level, bool mbec)
 {
 	union kvm_cpu_role role = {0};
 
@@ -5849,6 +5849,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	 */
 	WARN_ON_ONCE(is_smm(vcpu));
 	role.base.level = level;
+	role.base.cr4_smep = mbec;
 	role.base.has_4_byte_gpte = false;
 	role.base.direct = false;
 	role.base.ad_disabled = !accessed_dirty;
@@ -5864,13 +5865,13 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 
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
index 7c55551a2680..7b0861d02166 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -460,6 +460,12 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 	vmcs12->guest_physical_address = fault->address;
 }
 
+static inline bool nested_ept_mbec_enabled(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_MODE_BASED_EPT_EXEC);
+}
+
 static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -468,6 +474,7 @@ static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 
 	kvm_init_shadow_ept_mmu(vcpu, execonly, ept_lpage_level,
 				nested_ept_ad_enabled(vcpu),
+				nested_ept_mbec_enabled(vcpu),
 				nested_ept_get_eptp(vcpu));
 }
 
@@ -7145,6 +7152,9 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			msrs->ept_caps |= VMX_EPT_AD_BIT;
 		}
 
+		if (cpu_has_ept_mbec())
+			msrs->secondary_ctls_high |=
+				SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		/*
 		 * Advertise EPTP switching irrespective of hardware support,
 		 * KVM emulates it in software so long as VMFUNC is supported.
-- 
2.52.0

