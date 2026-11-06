Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950463;
	b=rokYVZr5ZWXYkdp0MilPQVceDB9/3F8wfHitjdvs8CMbIVzlgcUHax+WGVMmwpvuvvOq
	 q/ejkru5KqloADFkEEsTfTc//8Kz01FYE+Ngc/xb8zE3ld6vmkmZUWqB9dqxyFkZjSo2c
	 B0uCb1dDSWCtKyI5yJKvgU/SOo2qxxQsFM8jdW+N0pE2a4xswCHbsVzkc/mkHx3DqebfV
	 n+xjY8VEIEJWiMQ+3EtLSDHcAAYdkZWirm88Cuw4l/O2i7rt8W30GVlAkNBQMlUP/vk5A
	 fpyLxT4ISlmc6OCRSpHeE3NQsoideGbNwRY71cATqUu6QzoxA/mOTkKg4FGa5vprsYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AbTjU5VgKHU5JHUvbhhvUYidldO0hkFMVSdnbcZr87Q=;
	b=riL9JXDLb0HNeGnO8EWJJTKa3x3g6hWmQTEFW/sXTTLAnsw0EX2jIK9wQIXz4HtliE1M
	 7uKr51x6GwFwTXSQT8HAZzFlh52ltinQRPnz2RJatDP6EWjKErtU2IFhvrF1wz7tymUdK
	 eFECtb6h7FDYylLQuVQxcaVbp9/1pnYQfeKEZVvDxph7Jg2Tc4vyiQE9vDCcyAi/+kWED
	 GGZL0k8TBHfvEVh5SLCyazKQGV9sIGdYP6N+LAFbxdt+awYS1MzrYA2+bx7R5Pl27LIDR
	 YX1hJ8EXIfehkBqeWgrro37SMM3kvVK2pSSTqaGS0bnFLYP101Jmmb9yo0Ql6EZJdwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bahtqESa;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B1606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 07:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E78B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bahtqESa
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc751eddf25so183744a12.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 23:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793950462; x=1794555262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbTjU5VgKHU5JHUvbhhvUYidldO0hkFMVSdnbcZr87Q=;
        b=bahtqESaNb1gLa7lfwE/1sAs4xVn6/OlczKf1G3zila6DbJDnBbh6S1LfLmy/Uwgyq
         C9LM3ayLlPv1/gYBjvHwThh3C4ab/3/f6t7K4BKgAODc78F+3WQF2YGtUHwaUJJasRn9
         1OcYR7c8uHWiC9YKGsCzwfos1XLZpnjKkVb2xtuY0i9l2lJfSmgu2TJ+eA1laPCIyw49
         eeGsc9984PCuxSOgr9AI6gTYJNH6iyfwnAuf/PeVPzxmPh3FKNGLHRBOFFkazu+PU2jo
         3LLWY2zTSkZWk0+MloduzUWu3vVekaSZiG6q5ZH9GP9zRZ0h7OY9tTlacB2cpwCzmEwJ
         3ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793950462; x=1794555262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbTjU5VgKHU5JHUvbhhvUYidldO0hkFMVSdnbcZr87Q=;
        b=PK7pNvIKfF2O5RKvjRVg5aGYw/sFBVqsNTfcRjun2oEdmEWgibrCmUNEQWwFyXyjZ8
         ab6iBYHdnIETAlCIg5lnBWVIe8ll21MV0tUYCesXfrkWkxxS16nvTiMMuFrXLTvwU3EK
         zqz/ZqyYv1azNZfKAA7ppsayPN5IS7gDXHzVbFt3trAy6G23QJPxKhjp2V7UvuTXtuG8
         VWy2pMvmxRMwloYsCnjbOm1EG83E2+vjyDN6lKrYtTE07S6h2r5TwOmsiR6OnxceKOU8
         UaUCtG6Y9j6mT2ZxiKWhCKD8b6jFndCgCJLmkWf3a+AxcMJMGpM8IJlKILA5zibTKNE4
         M6Ug==
X-Gm-Message-State: APuU4Z+jVtJo5SEZK6Nsh/fPWAWo7/xwgGfWanzxnLQEABI0DRmDJlI/
	UO5gIm+EDPU/cIVtzBpTB/Zb+ROrW+AnQhBk54vyqB2I/I9IzEzTpsU5vGcs+Q==
X-Gm-Gg: AYBFou0f3U96z5hCw53Kt480mPscW7x8M2iURY8DbVIqFG97CgcSZPYYQio0RAGOAQH
	3Yd60XEQBdwvZZz7aW56PSZ0SMdJD8feXkiONX19mGTmqDuFV+FRJsAnk/POtp18qQXGVQWHAG0
	ZRPhmUoReAOU/2caT9HzLM6+rvmbTNSeMtEg8zO6e2bV3Xw8lQTzwg+qSKBmCjWnsgFtuNHc8tF
	q26TRnvIG2cMRKIFHdiwuzdBZAvQa4zeLUuYmBKHXC9x9MbWP94WLiXFZEeLVgjni4ioR8ZXfv7
	iYSrScsGMRmil5QsfBN/BYKUPalo6IjxqDilkTPVdXDl8Ss4PQrafih9TJpm7r/esejTgY40vvF
	zOz6HVE87ogQLn/s29BdMnu99mMGYfIylK8zKGTprEtTHlFzysd1hikvB//3rcsBZUwlAw3VZrl
	7eIzCZ6tM0LruFXDldGRG0fuevtJwsIaOJ3UgR/xJ0U/BjA3mSt+Jv9bXuSD6N7ruF0W3iOd/+B
	VJneA2543yawFS90PfyItXuqY2JK+Q61gq5tJxQoXAKIcM8xQKEMLdAaWF4dp76ugujRfTdZIrM
	9TERpn2qIGI/41Y9pxlIvDX22tKJdiXHMf6r048rsKWDGmcWDsFljWBvgfXUP4r5Ygsa97V7JGx
	NbnutXmKiRIe9K0c9SiI=
X-Received: by 2002:a17:90b:5866:b0:3a4:ad5c:d48a with SMTP id 98e67ed59e1d1-3b0db71f3e6mr1534708a91.67.1793950461920;
        Thu, 05 Nov 2026 23:34:21 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7ca4b03sm2218365a91.14.2026.11.05.23.34.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 23:34:21 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: VMX: Allocate struct pt_desc only when PT is virtualized for guests
Date: Fri,  6 Nov 2026 15:34:17 +0800
Message-ID: <20261106073417.86867-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct pt_desc is only used when pt_mode is PT_MODE_HOST_GUEST, so
allocate it on demand instead of embedding it in struct vcpu_vmx.

This shrinks struct vcpu_vmx from 8384 to 8128 bytes.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 arch/x86/kvm/vmx/nested.c |   2 +-
 arch/x86/kvm/vmx/vmx.c    | 167 ++++++++++++++++++++------------------
 arch/x86/kvm/vmx/vmx.h    |   3 +-
 3 files changed, 91 insertions(+), 81 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f0d75f5a968c..d6d068778741 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5456,7 +5456,7 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	vmx->nested.vmxon = true;
 
 	if (vmx_pt_mode_is_host_guest()) {
-		vmx->pt_desc.guest.ctl = 0;
+		vmx->pt_desc->guest.ctl = 0;
 		pt_update_intercept_for_msr(vcpu);
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..bc046238e90c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1234,7 +1234,7 @@ static unsigned long segment_base(u16 selector)
 static inline bool pt_can_write_msr(struct vcpu_vmx *vmx)
 {
 	return vmx_pt_mode_is_host_guest() &&
-	       !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
+	       !(vmx->pt_desc->guest.ctl & RTIT_CTL_TRACEEN);
 }
 
 static inline bool pt_output_base_valid(struct kvm_vcpu *vcpu, u64 base)
@@ -1280,11 +1280,11 @@ static void pt_guest_enter(struct vcpu_vmx *vmx)
 	 * GUEST_IA32_RTIT_CTL is already set in the VMCS.
 	 * Save host state before VM entry.
 	 */
-	rdmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
-	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
+	rdmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc->host.ctl);
+	if (vmx->pt_desc->guest.ctl & RTIT_CTL_TRACEEN) {
 		wrmsrq(MSR_IA32_RTIT_CTL, 0);
-		pt_save_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);
-		pt_load_msr(&vmx->pt_desc.guest, vmx->pt_desc.num_address_ranges);
+		pt_save_msr(&vmx->pt_desc->host, vmx->pt_desc->num_address_ranges);
+		pt_load_msr(&vmx->pt_desc->guest, vmx->pt_desc->num_address_ranges);
 	}
 }
 
@@ -1293,17 +1293,17 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
 	if (vmx_pt_mode_is_system())
 		return;
 
-	if (vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) {
-		pt_save_msr(&vmx->pt_desc.guest, vmx->pt_desc.num_address_ranges);
-		pt_load_msr(&vmx->pt_desc.host, vmx->pt_desc.num_address_ranges);
+	if (vmx->pt_desc->guest.ctl & RTIT_CTL_TRACEEN) {
+		pt_save_msr(&vmx->pt_desc->guest, vmx->pt_desc->num_address_ranges);
+		pt_load_msr(&vmx->pt_desc->host, vmx->pt_desc->num_address_ranges);
 	}
 
 	/*
 	 * KVM requires VM_EXIT_CLEAR_IA32_RTIT_CTL to expose PT to the guest,
 	 * i.e. RTIT_CTL is always cleared on VM-Exit.  Restore it if necessary.
 	 */
-	if (vmx->pt_desc.host.ctl)
-		wrmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
+	if (vmx->pt_desc->host.ctl)
+		wrmsrq(MSR_IA32_RTIT_CTL, vmx->pt_desc->host.ctl);
 }
 
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
@@ -1717,16 +1717,16 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	 * Any MSR write that attempts to change bits marked reserved will
 	 * case a #GP fault.
 	 */
-	if (data & vmx->pt_desc.ctl_bitmask)
+	if (data & vmx->pt_desc->ctl_bitmask)
 		return 1;
 
 	/*
 	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
 	 * result in a #GP unless the same write also clears TraceEn.
 	 */
-	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
+	if ((vmx->pt_desc->guest.ctl & RTIT_CTL_TRACEEN) &&
 	    (data & RTIT_CTL_TRACEEN) &&
-	    data != vmx->pt_desc.guest.ctl)
+	    data != vmx->pt_desc->guest.ctl)
 		return 1;
 
 	/*
@@ -1736,7 +1736,7 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	 */
 	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
 		!(data & RTIT_CTL_FABRIC_EN) &&
-		!intel_pt_validate_cap(vmx->pt_desc.caps,
+		!intel_pt_validate_cap(vmx->pt_desc->caps,
 					PT_CAP_single_range_output))
 		return 1;
 
@@ -1744,19 +1744,19 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	 * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write that
 	 * utilize encodings marked reserved will cause a #GP fault.
 	 */
-	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc_periods);
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc) &&
+	value = intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_mtc_periods);
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_mtc) &&
 			!test_bit((data & RTIT_CTL_MTC_RANGE) >>
 			RTIT_CTL_MTC_RANGE_OFFSET, &value))
 		return 1;
-	value = intel_pt_validate_cap(vmx->pt_desc.caps,
+	value = intel_pt_validate_cap(vmx->pt_desc->caps,
 						PT_CAP_cycle_thresholds);
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_psb_cyc) &&
 			!test_bit((data & RTIT_CTL_CYC_THRESH) >>
 			RTIT_CTL_CYC_THRESH_OFFSET, &value))
 		return 1;
-	value = intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_periods);
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+	value = intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_psb_periods);
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_psb_cyc) &&
 			!test_bit((data & RTIT_CTL_PSB_FREQ) >>
 			RTIT_CTL_PSB_FREQ_OFFSET, &value))
 		return 1;
@@ -1766,16 +1766,16 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
 	 * cause a #GP fault.
 	 */
 	value = (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 1)) || (value > 2))
+	if ((value && (vmx->pt_desc->num_address_ranges < 1)) || (value > 2))
 		return 1;
 	value = (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 2)) || (value > 2))
+	if ((value && (vmx->pt_desc->num_address_ranges < 2)) || (value > 2))
 		return 1;
 	value = (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 3)) || (value > 2))
+	if ((value && (vmx->pt_desc->num_address_ranges < 3)) || (value > 2))
 		return 1;
 	value = (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
-	if ((value && (vmx->pt_desc.num_address_ranges < 4)) || (value > 2))
+	if ((value && (vmx->pt_desc->num_address_ranges < 4)) || (value > 2))
 		return 1;
 
 	return 0;
@@ -2219,47 +2219,47 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_RTIT_CTL:
 		if (!vmx_pt_mode_is_host_guest())
 			return 1;
-		msr_info->data = vmx->pt_desc.guest.ctl;
+		msr_info->data = vmx->pt_desc->guest.ctl;
 		break;
 	case MSR_IA32_RTIT_STATUS:
 		if (!vmx_pt_mode_is_host_guest())
 			return 1;
-		msr_info->data = vmx->pt_desc.guest.status;
+		msr_info->data = vmx->pt_desc->guest.status;
 		break;
 	case MSR_IA32_RTIT_CR3_MATCH:
 		if (!vmx_pt_mode_is_host_guest() ||
-			!intel_pt_validate_cap(vmx->pt_desc.caps,
+			!intel_pt_validate_cap(vmx->pt_desc->caps,
 						PT_CAP_cr3_filtering))
 			return 1;
-		msr_info->data = vmx->pt_desc.guest.cr3_match;
+		msr_info->data = vmx->pt_desc->guest.cr3_match;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_BASE:
 		if (!vmx_pt_mode_is_host_guest() ||
-			(!intel_pt_validate_cap(vmx->pt_desc.caps,
+			(!intel_pt_validate_cap(vmx->pt_desc->caps,
 					PT_CAP_topa_output) &&
-			 !intel_pt_validate_cap(vmx->pt_desc.caps,
+			 !intel_pt_validate_cap(vmx->pt_desc->caps,
 					PT_CAP_single_range_output)))
 			return 1;
-		msr_info->data = vmx->pt_desc.guest.output_base;
+		msr_info->data = vmx->pt_desc->guest.output_base;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_MASK:
 		if (!vmx_pt_mode_is_host_guest() ||
-			(!intel_pt_validate_cap(vmx->pt_desc.caps,
+			(!intel_pt_validate_cap(vmx->pt_desc->caps,
 					PT_CAP_topa_output) &&
-			 !intel_pt_validate_cap(vmx->pt_desc.caps,
+			 !intel_pt_validate_cap(vmx->pt_desc->caps,
 					PT_CAP_single_range_output)))
 			return 1;
-		msr_info->data = vmx->pt_desc.guest.output_mask;
+		msr_info->data = vmx->pt_desc->guest.output_mask;
 		break;
 	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
 		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
 		if (!vmx_pt_mode_is_host_guest() ||
-		    (index >= 2 * vmx->pt_desc.num_address_ranges))
+		    (index >= 2 * vmx->pt_desc->num_address_ranges))
 			return 1;
 		if (index % 2)
-			msr_info->data = vmx->pt_desc.guest.addr_b[index / 2];
+			msr_info->data = vmx->pt_desc->guest.addr_b[index / 2];
 		else
-			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
+			msr_info->data = vmx->pt_desc->guest.addr_a[index / 2];
 		break;
 	case MSR_IA32_S_CET:
 		msr_info->data = vmcs_readl(GUEST_S_CET);
@@ -2535,7 +2535,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx->nested.vmxon)
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
-		vmx->pt_desc.guest.ctl = data;
+		vmx->pt_desc->guest.ctl = data;
 		pt_update_intercept_for_msr(vcpu);
 		break;
 	case MSR_IA32_RTIT_STATUS:
@@ -2543,50 +2543,50 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		if (data & MSR_IA32_RTIT_STATUS_MASK)
 			return 1;
-		vmx->pt_desc.guest.status = data;
+		vmx->pt_desc->guest.status = data;
 		break;
 	case MSR_IA32_RTIT_CR3_MATCH:
 		if (!pt_can_write_msr(vmx))
 			return 1;
-		if (!intel_pt_validate_cap(vmx->pt_desc.caps,
+		if (!intel_pt_validate_cap(vmx->pt_desc->caps,
 					   PT_CAP_cr3_filtering))
 			return 1;
-		vmx->pt_desc.guest.cr3_match = data;
+		vmx->pt_desc->guest.cr3_match = data;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_BASE:
 		if (!pt_can_write_msr(vmx))
 			return 1;
-		if (!intel_pt_validate_cap(vmx->pt_desc.caps,
+		if (!intel_pt_validate_cap(vmx->pt_desc->caps,
 					   PT_CAP_topa_output) &&
-		    !intel_pt_validate_cap(vmx->pt_desc.caps,
+		    !intel_pt_validate_cap(vmx->pt_desc->caps,
 					   PT_CAP_single_range_output))
 			return 1;
 		if (!pt_output_base_valid(vcpu, data))
 			return 1;
-		vmx->pt_desc.guest.output_base = data;
+		vmx->pt_desc->guest.output_base = data;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_MASK:
 		if (!pt_can_write_msr(vmx))
 			return 1;
-		if (!intel_pt_validate_cap(vmx->pt_desc.caps,
+		if (!intel_pt_validate_cap(vmx->pt_desc->caps,
 					   PT_CAP_topa_output) &&
-		    !intel_pt_validate_cap(vmx->pt_desc.caps,
+		    !intel_pt_validate_cap(vmx->pt_desc->caps,
 					   PT_CAP_single_range_output))
 			return 1;
-		vmx->pt_desc.guest.output_mask = data;
+		vmx->pt_desc->guest.output_mask = data;
 		break;
 	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
 		if (!pt_can_write_msr(vmx))
 			return 1;
 		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
-		if (index >= 2 * vmx->pt_desc.num_address_ranges)
+		if (index >= 2 * vmx->pt_desc->num_address_ranges)
 			return 1;
 		if (is_noncanonical_msr_address(data, vcpu))
 			return 1;
 		if (index % 2)
-			vmx->pt_desc.guest.addr_b[index / 2] = data;
+			vmx->pt_desc->guest.addr_b[index / 2] = data;
 		else
-			vmx->pt_desc.guest.addr_a[index / 2] = data;
+			vmx->pt_desc->guest.addr_a[index / 2] = data;
 		break;
 	case MSR_IA32_S_CET:
 		vmcs_writel(GUEST_S_CET, data);
@@ -4222,14 +4222,14 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	bool flag = !(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN);
+	bool flag = !(vmx->pt_desc->guest.ctl & RTIT_CTL_TRACEEN);
 	u32 i;
 
 	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_STATUS, MSR_TYPE_RW, flag);
 	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_BASE, MSR_TYPE_RW, flag);
 	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_OUTPUT_MASK, MSR_TYPE_RW, flag);
 	vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_CR3_MATCH, MSR_TYPE_RW, flag);
-	for (i = 0; i < vmx->pt_desc.num_address_ranges; i++) {
+	for (i = 0; i < vmx->pt_desc->num_address_ranges; i++) {
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
 	}
@@ -4995,9 +4995,9 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
 	vmx_write_encls_bitmap(vcpu, NULL);
 
 	if (vmx_pt_mode_is_host_guest()) {
-		memset(&vmx->pt_desc, 0, sizeof(vmx->pt_desc));
+		memset(vmx->pt_desc, 0, sizeof(*vmx->pt_desc));
 		/* Bit[6~0] are forced to 1, writes are ignored. */
-		vmx->pt_desc.guest.output_mask = 0x7F;
+		vmx->pt_desc->guest.output_mask = 0x7F;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
 	}
 
@@ -7517,6 +7517,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 	nested_vmx_free_vcpu(vcpu);
 	free_loaded_vmcs(vmx->loaded_vmcs);
 	free_page((unsigned long)vmx->ve_info);
+	kfree(vmx->pt_desc);
 
 	if (vmx_can_use_ipiv(vcpu))
 		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id], 0);
@@ -7594,6 +7595,12 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	}
 
 	err = -ENOMEM;
+	if (vmx_pt_mode_is_host_guest()) {
+		vmx->pt_desc = kzalloc_obj(*vmx->pt_desc, GFP_KERNEL_ACCOUNT);
+		if (!vmx->pt_desc)
+			goto free_vmcs;
+	}
+
 	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_EPT_VIOLATION_VE) {
 		struct page *page;
 
@@ -7602,7 +7609,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		/* ve_info must be page aligned. */
 		page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 		if (!page)
-			goto free_vmcs;
+			goto free_pt_desc;
 
 		vmx->ve_info = page_to_virt(page);
 	}
@@ -7613,6 +7620,8 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 
 	return 0;
 
+free_pt_desc:
+	kfree(vmx->pt_desc);
 free_vmcs:
 	free_loaded_vmcs(vmx->loaded_vmcs);
 free_pml:
@@ -7765,18 +7774,18 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 		best = kvm_find_cpuid_entry_index(vcpu, 0x14, i);
 		if (!best)
 			return;
-		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
-		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
-		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
-		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
+		vmx->pt_desc->caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
+		vmx->pt_desc->caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
+		vmx->pt_desc->caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
+		vmx->pt_desc->caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
 	}
 
 	/* Get the number of configurable Address Ranges for filtering */
-	vmx->pt_desc.num_address_ranges = intel_pt_validate_cap(vmx->pt_desc.caps,
+	vmx->pt_desc->num_address_ranges = intel_pt_validate_cap(vmx->pt_desc->caps,
 						PT_CAP_num_address_ranges);
 
 	/* Initialize and clear the no dependency bits */
-	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
+	vmx->pt_desc->ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
 			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC |
 			RTIT_CTL_BRANCH_EN);
 
@@ -7784,44 +7793,44 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 	 * If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set otherwise
 	 * will inject an #GP
 	 */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_cr3_filtering))
+		vmx->pt_desc->ctl_bitmask &= ~RTIT_CTL_CR3EN;
 
 	/*
 	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
 	 * PSBFreq can be set
 	 */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_psb_cyc))
-		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_psb_cyc))
+		vmx->pt_desc->ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
 				RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
 
 	/*
 	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn and MTCFreq can be set
 	 */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_mtc))
-		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_mtc))
+		vmx->pt_desc->ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
 					      RTIT_CTL_MTC_RANGE);
 
 	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_ptwrite))
-		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_ptwrite))
+		vmx->pt_desc->ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
 							RTIT_CTL_PTW_EN);
 
 	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_power_event_trace))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_power_event_trace))
+		vmx->pt_desc->ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
 
 	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_topa_output))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_topa_output))
+		vmx->pt_desc->ctl_bitmask &= ~RTIT_CTL_TOPA;
 
 	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabricEn can be set */
-	if (intel_pt_validate_cap(vmx->pt_desc.caps, PT_CAP_output_subsys))
-		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
+	if (intel_pt_validate_cap(vmx->pt_desc->caps, PT_CAP_output_subsys))
+		vmx->pt_desc->ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
 
 	/* unmask address range configure area */
-	for (i = 0; i < vmx->pt_desc.num_address_ranges; i++)
-		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
+	for (i = 0; i < vmx->pt_desc->num_address_ranges; i++)
+		vmx->pt_desc->ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
 void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
@@ -7854,8 +7863,8 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
 		nested_vmx_cr_fixed1_bits_update(vcpu);
 
-	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
-			guest_cpu_cap_has(vcpu, X86_FEATURE_INTEL_PT))
+	if (vmx_pt_mode_is_host_guest() && boot_cpu_has(X86_FEATURE_INTEL_PT) &&
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_INTEL_PT))
 		update_intel_pt_cfg(vcpu);
 
 	if (boot_cpu_has(X86_FEATURE_RTM)) {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6c9dd5b2365d..54de80390776 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -280,7 +280,8 @@ struct vcpu_vmx {
 	u64 msr_ia32_mcu_opt_ctrl;
 	bool disable_fb_clear;
 
-	struct pt_desc pt_desc;
+	/* Only allocated if pt_mode == PT_MODE_HOST_GUEST. */
+	struct pt_desc *pt_desc;
 	struct lbr_desc lbr_desc;
 
 	/* ve_info must be page aligned. */
-- 
2.43.7

