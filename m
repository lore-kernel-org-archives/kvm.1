Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB633D4FD
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598026; cv=none; b=VtJQEKFVUV6/NEFaUdICu+MZokQhkPmo6yKqAt4LAZQ4/19S3PjAwKZ5atE0DjGhJLEozFi2NcW2u19LG/fNE3v5YDDHkAxlMD2I34Cpju8Kx5PaSBADSvS/tGjMVltGiYC2W8NvToY/AoRQiUCoUKstI0oO4hst245kfDCgezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598026; c=relaxed/simple;
	bh=aayhWfa/WCdX+wIsMHbwVFmzp4pR3hbjjy+Med1n8SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfBJAK/WyMJvVW3fvut8A/NUZmh+fVvJMLhwjZAw63Qy9voJq63j5FDccTPueKy/7hkepZvpYUi0s8M52GPqns0UHuVYQQB0GmPzT4AIIdCSkrvfGowU8BNvw8NSrERn+Tje9IRf1e13UOQQ7Y9erKOHF8GjEu6hbWj+TIIhl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWVBj7A4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ltX8nmKQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWVBj7A4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ltX8nmKQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778598024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RXu/1xV5Fho5X3BEGmaQ3gYe0lRXy6kbmIyYjyV5tkY=;
	b=MWVBj7A4QthE9kWvvZlaLfteikhiHivsRyqKlurchCM1naprXipu6MjEEeLoB8Rvy6agRn
	/A4dKGWGFjPSO0Tdmo1TgOl5IZ2/8EHr0pD5gYB3LEVePBaWIGYAJk74S/wzRVr+SKdAKW
	QAT6OPiKrIZ9JMCbAy8/Sor9vE3IG/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-D5ZAN7aiNvewUH6bG7o1Aw-1; Tue, 12 May 2026 11:00:21 -0400
X-MC-Unique: D5ZAN7aiNvewUH6bG7o1Aw-1
X-Mimecast-MFC-AGG-ID: D5ZAN7aiNvewUH6bG7o1Aw_1778598020
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e60b55de2so49988275e9.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778598019; x=1779202819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXu/1xV5Fho5X3BEGmaQ3gYe0lRXy6kbmIyYjyV5tkY=;
        b=ltX8nmKQBcE29+MedgZxU9Cfe/T8z9JrmGaWptL/gC5Zk0QGTBMlkGrE402yK4xssa
         pkQ7qLbOpJX+q7ZGa/YKY3KuutPCm6ScGygOBECOz5qVFxlQQbE9/HrADDyaUx+jTrvg
         JTx7WjCCuzeBDcC2zCOq2OZ0Gup3KtLY3bPZ0sLAQyk5WIYuxMO+Q9/9A0F+UMyrzp41
         WqBJsmhKSeLyRS+v7JvHATqSgaC2VRAR6qoMXq5NjqTPVth4WzOyIERLKCgp0Lf4yc1i
         2GDircVq6IAaTGQNJDyLhzA3u0U2Tb4pNkXtF4mBf2/c0MJZ51uY/wm8fBkiOyhxp+nM
         cQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598019; x=1779202819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXu/1xV5Fho5X3BEGmaQ3gYe0lRXy6kbmIyYjyV5tkY=;
        b=Rapv7qrMWLjeVtF1jAT0tnBFylluTmaB5aI9ZdLAphWlnxlpxM8PlCSQRDlFu8XWVN
         iWUbtpxZKVXceFcTbONrtDn6d3tzUhPzAsYUBWT2f5ConRwbQwL07YLu7GXghsTjD48S
         Ek6jgsQ+WAYuEJi5aZ0PITbOUVuu0pO8ebsXCLpME7x+LrtDIHKWnFSWKWPee7vwfXDf
         8/AMXRMh66+g+PcD3rITSfYr+0HDhbHaDi7aBk/9FO+l6VkP69WPjQxCcQyFfyDhCxBt
         0iUicdpyaWsm2prNa7wF2p1noqzPV2fJ9SvIAfKa4vIG9kQeX5u8psujOUKpUFmdE9yV
         Jqeg==
X-Forwarded-Encrypted: i=1; AFNElJ/bVvZdT2GyxN3qFZBYrMpzf0tuNxagluCtV2D7sUcNTlz+EpT82ohCFbrM380WclpC+K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwyMfUiOrVlFCrnNodvP99l8/sts0RlEzerPv4stKHUhdwGcB
	H+SK5z/zXN/tDIICJrgWVKhw7Q6v2aMFY/x7mNW/u63Ww33mgVMiqU+UNdDEhMuPYSvKLIegDPA
	WY9d1ShzdkZbsJxdneN7dbeE5pnuMuhKt9ufOkHhXbYFe4tH4WfyZLrxrvsq2cg==
X-Gm-Gg: Acq92OHW9bz68GsrikXIlOMkAoAbcvQznxEK9kSU4eAsmx9whrSERkaFeXwDV5R3KpR
	JI7beaUeoeBMasRqZ2MTL+vdddqwf2XNf/6ogyY+0WyHMJuaBndeoIHtV5zUv6j1VRZkoD3I2co
	cWqXtFDQTcN3TklaHQ8Hfr9h/1votny7Urm9Xoug0R1HyRJ3AA5tD6fNPyuhaGxNnlbtbZww2Ia
	e6iSgvmHEN4fQfyr7M8mibPStAV+OSyaTbxlShy9CbqX+aeGDjdaEQj40k+tWGJd+7J81J8kaeR
	ZysyS3T1REQrmaqJtZOKnKME53yqLt5LG9QCIL1Wjx9iEm5/QCBNhNOZiPZ7ObcaiB6fGUddKAq
	/0IAahH3E5U/jqAciMDgcaKd9VJijZhGC/Hi5/iZvBsaopnnx8DtMgUrabw/epWssfQHRw0ptL0
	uLZNAOpU+hTISm9nXftE6zpeVPP5es
X-Received: by 2002:a05:600c:3e0e:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48e8fe73355mr55649255e9.18.1778598018841;
        Tue, 12 May 2026 08:00:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0e:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48e8fe73355mr55648295e9.18.1778598018232;
        Tue, 12 May 2026 08:00:18 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm34317426f8f.32.2026.05.12.08.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:00:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: David Riley <d.riley@proxmox.com>
Subject: [PATCH] KVM: VMX: introduce module parameter to disable CET
Date: Tue, 12 May 2026 17:00:16 +0200
Message-ID: <20260512150016.2979228-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been reports of host hangs caused by CET virtualization.
Until these are analyzed further, introduce a module parameter that
makes it possible to easily disable it.

Link: https://lore.kernel.org/all/85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com/
Cc: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/capabilities.h |  1 +
 arch/x86/kvm/vmx/vmcs12.c       |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 56cacc06225e..31568274d8bb 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -14,6 +14,7 @@ extern bool __read_mostly flexpriority_enabled;
 extern bool __read_mostly enable_ept;
 extern bool __read_mostly enable_unrestricted_guest;
 extern bool __read_mostly enable_ept_ad_bits;
+extern bool __read_mostly enable_cet;
 extern bool __read_mostly enable_pml;
 extern int __read_mostly pt_mode;
 
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 1ebe67c384ad..9f96e21dc1b9 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -202,7 +202,7 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
 	case HOST_S_CET:
 	case HOST_SSP:
 	case HOST_INTR_SSP_TABLE:
-		return cpu_has_load_cet_ctrl();
+		return enable_cet;
 
 	/* KVM always emulates PML and the VMX preemption timer in software. */
 	case GUEST_PML_INDEX:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c2c33a5f7dc..49feecb286b2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -108,6 +108,9 @@ module_param_named(unrestricted_guest,
 bool __read_mostly enable_ept_ad_bits = 1;
 module_param_named(eptad, enable_ept_ad_bits, bool, 0444);
 
+bool __read_mostly enable_cet = 1;
+module_param_named(cet, enable_cet, bool, 0444);
+
 static bool __read_mostly emulate_invalid_guest_state = true;
 module_param(emulate_invalid_guest_state, bool, 0444);
 
@@ -4476,7 +4479,7 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	 * SSP is reloaded from IA32_PL3_SSP. Check SDM Vol.2A/B Chapter
 	 * 3 and 4 for details.
 	 */
-	if (cpu_has_load_cet_ctrl()) {
+	if (enable_cet) {
 		vmcs_writel(HOST_S_CET, kvm_host.s_cet);
 		vmcs_writel(HOST_SSP, 0);
 		vmcs_writel(HOST_INTR_SSP_TABLE, 0);
@@ -4532,6 +4535,10 @@ static u32 vmx_get_initial_vmentry_ctrl(void)
 	if (vmx_pt_mode_is_system())
 		vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
 				  VM_ENTRY_LOAD_IA32_RTIT_CTL);
+
+	if (!enable_cet)
+		vmentry_ctrl &= ~VM_ENTRY_LOAD_CET_STATE;
+
 	/*
 	 * IA32e mode, and loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically.
 	 */
@@ -4546,6 +4553,9 @@ static u32 vmx_get_initial_vmexit_ctrl(void)
 {
 	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
 
+	if (!enable_cet)
+		vmexit_ctrl &= ~VM_EXIT_LOAD_CET_STATE;
+
 	/*
 	 * Not used by KVM and never set in vmcs01 or vmcs02, but emulated for
 	 * nested virtualization and thus allowed to be set in vmcs12.
@@ -8155,7 +8165,7 @@ static __init void vmx_set_cpu_caps(void)
 	 * VMX_BASIC[bit56] == 0, inject #CP at VMX entry with error code
 	 * fails, so disable CET in this case too.
 	 */
-	if (!cpu_has_load_cet_ctrl() || !enable_unrestricted_guest ||
+	if (!enable_cet || !enable_unrestricted_guest ||
 	    !cpu_has_vmx_basic_no_hw_errcode_cc()) {
 		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
 		kvm_cpu_cap_clear(X86_FEATURE_IBT);
@@ -8630,6 +8640,9 @@ __init int vmx_hardware_setup(void)
 	    !cpu_has_vmx_invept_global())
 		enable_ept = 0;
 
+	if (!cpu_has_load_cet_ctrl())
+		enable_cet = 0;
+
 	/* NX support is required for shadow paging. */
 	if (!enable_ept && !boot_cpu_has(X86_FEATURE_NX)) {
 		pr_err_ratelimited("NX (Execute Disable) not supported\n");
-- 
2.54.0

