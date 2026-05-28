Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17003D5236
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966860; cv=none; b=NW9OedOk4XCcKo8FPXe5oASOfpbZOz+w5AqGrwHzHRQ01O9C6uqlXhZ4TPfl7izFbl8XTLOKrTheD+ims3zssUK3O5jtjBK1wHdcHSMuD3tYl4nNAZ4OUDD7xfTQOnGiLfCyqfkZFLFdXEV4RPT7VBgXCdGANiWT70nGPhqu1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966860; c=relaxed/simple;
	bh=gttg+5qAZWEFQqYHVSIcofNzP8HUzFyz3hUN7CUc1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9Y87QBwCXwVfYOHfYgt+KkuVTF2sogdRiUJSJDffLpdjNiNJv/D1BcDz+6I7sztYuObsxyQJCNlHQW/F2MnMo+eZQD4jACqPxAsJsnZOIJ7rNBFPuz6qoKrBBPkM/lmubIs5dom0qlugvM+JkHZvDQ0A8xMswIfyesdf7FIbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=re0Z+s8h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=re0Z+s8h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="re0Z+s8h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="re0Z+s8h"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC5CE6AFDC;
	Thu, 28 May 2026 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lphgc/lXXbp5mVkKaVPjsuOLrtCq7NDy9by+xJzbl7M=;
	b=re0Z+s8hAf6H3dxwNblF6c4jK3mUQFYoN3wd2covSfMzagX8AxYy5ubcXe/kJg/pxB0XSf
	m3zQpMEieuDvVDcoGlcPVhVarJ8T3KPYLcdb5nJfrWuAza6Pgk/PKRNbyKTj6n9dqRJ7kk
	pTBbH4k/m6iqaoj34PLei2W6QuFAn0o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1779966856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lphgc/lXXbp5mVkKaVPjsuOLrtCq7NDy9by+xJzbl7M=;
	b=re0Z+s8hAf6H3dxwNblF6c4jK3mUQFYoN3wd2covSfMzagX8AxYy5ubcXe/kJg/pxB0XSf
	m3zQpMEieuDvVDcoGlcPVhVarJ8T3KPYLcdb5nJfrWuAza6Pgk/PKRNbyKTj6n9dqRJ7kk
	pTBbH4k/m6iqaoj34PLei2W6QuFAn0o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77C2E5AD61;
	Thu, 28 May 2026 11:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBMsHIgjGGrEMgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 28 May 2026 11:14:16 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 3/5] KVM/x86: Return -errno instead of "1" for Hyper-V related MSR emulation
Date: Thu, 28 May 2026 13:13:55 +0200
Message-ID: <20260528111357.264809-4-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528111357.264809-1-jgross@suse.com>
References: <20260528111357.264809-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]

Instead of a literal "1" for signalling an error, use a negative errno
value in the emulation code of Hyper-V related MSR registers.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- use -errno instead of KVM_MSR_RET_ERR
---
 arch/x86/kvm/hyperv.c | 72 +++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4438ecac9a89..809752a6d0ac 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -167,7 +167,7 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 	 * allow zero-initing the register from host as well.
 	 */
 	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host && !masked)
-		return 1;
+		return -EINVAL;
 	/*
 	 * Guest may configure multiple SINTs to use the same vector, so
 	 * we maintain a bitmap of vectors handled by synic, and a
@@ -263,7 +263,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 	int ret;
 
 	if (!synic->active && (!host || data))
-		return 1;
+		return -EINVAL;
 
 	trace_kvm_hv_synic_set_msr(vcpu->vcpu_id, msr, data, host);
 
@@ -276,7 +276,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 		break;
 	case HV_X64_MSR_SVERSION:
 		if (!host) {
-			ret = 1;
+			ret = -EINVAL;
 			break;
 		}
 		synic->version = data;
@@ -286,7 +286,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 		    !synic->dont_zero_synic_pages)
 			if (kvm_clear_guest(vcpu->kvm,
 					    data & PAGE_MASK, PAGE_SIZE)) {
-				ret = 1;
+				ret = -EFAULT;
 				break;
 			}
 		synic->evt_page = data;
@@ -298,7 +298,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 		    !synic->dont_zero_synic_pages)
 			if (kvm_clear_guest(vcpu->kvm,
 					    data & PAGE_MASK, PAGE_SIZE)) {
-				ret = 1;
+				ret = -EFAULT;
 				break;
 			}
 		synic->msg_page = data;
@@ -319,7 +319,7 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 		ret = synic_set_sint(synic, msr - HV_X64_MSR_SINT0, data, host);
 		break;
 	default:
-		ret = 1;
+		ret = -EINVAL;
 		break;
 	}
 	return ret;
@@ -365,7 +365,7 @@ static int syndbg_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	struct kvm_hv_syndbg *syndbg = to_hv_syndbg(vcpu);
 
 	if (!kvm_hv_is_syndbg_enabled(vcpu) && !host)
-		return 1;
+		return -EINVAL;
 
 	trace_kvm_hv_syndbg_set_msr(vcpu->vcpu_id,
 				    to_hv_vcpu(vcpu)->vp_index, msr, data);
@@ -404,7 +404,7 @@ static int syndbg_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 	struct kvm_hv_syndbg *syndbg = to_hv_syndbg(vcpu);
 
 	if (!kvm_hv_is_syndbg_enabled(vcpu) && !host)
-		return 1;
+		return -EINVAL;
 
 	switch (msr) {
 	case HV_X64_MSR_SYNDBG_CONTROL:
@@ -440,7 +440,7 @@ static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata,
 	int ret;
 
 	if (!synic->active && !host)
-		return 1;
+		return -EINVAL;
 
 	ret = 0;
 	switch (msr) {
@@ -463,7 +463,7 @@ static int synic_get_msr(struct kvm_vcpu_hv_synic *synic, u32 msr, u64 *pdata,
 		*pdata = atomic64_read(&synic->sint[msr - HV_X64_MSR_SINT0]);
 		break;
 	default:
-		ret = 1;
+		ret = -EINVAL;
 		break;
 	}
 	return ret;
@@ -695,12 +695,12 @@ static int stimer_set_config(struct kvm_vcpu_hv_stimer *stimer, u64 config,
 	struct kvm_vcpu_hv_synic *synic = to_hv_synic(vcpu);
 
 	if (!synic->active && (!host || config))
-		return 1;
+		return -EINVAL;
 
 	if (unlikely(!host && hv_vcpu->enforce_cpuid && new_config.direct_mode &&
 		     !(hv_vcpu->cpuid_cache.features_edx &
 		       HV_STIMER_DIRECT_MODE_AVAILABLE)))
-		return 1;
+		return -EINVAL;
 
 	trace_kvm_hv_stimer_set_config(hv_stimer_to_vcpu(stimer)->vcpu_id,
 				       stimer->index, config, host);
@@ -724,7 +724,7 @@ static int stimer_set_count(struct kvm_vcpu_hv_stimer *stimer, u64 count,
 	struct kvm_vcpu_hv_synic *synic = to_hv_synic(vcpu);
 
 	if (!synic->active && (!host || count))
-		return 1;
+		return -EINVAL;
 
 	trace_kvm_hv_stimer_set_count(hv_stimer_to_vcpu(stimer)->vcpu_id,
 				      stimer->index, count, host);
@@ -1380,7 +1380,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 
 	if (unlikely(!host && !hv_check_msr_access(to_hv_vcpu(vcpu), msr)))
-		return 1;
+		return -EINVAL;
 
 	switch (msr) {
 	case HV_X64_MSR_GUEST_OS_ID:
@@ -1476,23 +1476,23 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		break;
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		if (data && !host)
-			return 1;
+			return -EINVAL;
 
 		hv->hv_tsc_emulation_status = data;
 		break;
 	case HV_X64_MSR_TIME_REF_COUNT:
 		/* read-only, but still ignore it if host-initiated */
 		if (!host)
-			return 1;
+			return -EINVAL;
 		break;
 	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
 		/* Only bit 0 is supported */
 		if (data & ~HV_EXPOSE_INVARIANT_TSC)
-			return 1;
+			return -EINVAL;
 
 		/* The feature can't be disabled from the guest */
 		if (!host && hv->hv_invtsc_control && !data)
-			return 1;
+			return -EINVAL;
 
 		hv->hv_invtsc_control = data;
 		break;
@@ -1501,7 +1501,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		return syndbg_set_msr(vcpu, msr, data, host);
 	default:
 		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-		return 1;
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -1521,7 +1521,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	if (unlikely(!host && !hv_check_msr_access(hv_vcpu, msr)))
-		return 1;
+		return -EINVAL;
 
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX: {
@@ -1529,7 +1529,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		u32 new_vp_index = (u32)data;
 
 		if (!host || new_vp_index >= KVM_MAX_VCPUS)
-			return 1;
+			return -EINVAL;
 
 		if (new_vp_index == hv_vcpu->vp_index)
 			return 0;
@@ -1555,13 +1555,13 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
 			hv_vcpu->hv_vapic = data;
 			if (kvm_lapic_set_pv_eoi(vcpu, 0, 0))
-				return 1;
+				return -EINVAL;
 			break;
 		}
 		gfn = data >> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT;
 		addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
 		if (kvm_is_error_hva(addr))
-			return 1;
+			return -EINVAL;
 
 		/*
 		 * Clear apic_assist portion of struct hv_vp_assist_page
@@ -1569,13 +1569,13 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		 * to be preserved e.g. on migration.
 		 */
 		if (put_user(0, (u32 __user *)addr))
-			return 1;
+			return -EFAULT;
 		hv_vcpu->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
 		if (kvm_lapic_set_pv_eoi(vcpu,
 					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
 					    sizeof(struct hv_vp_assist_page)))
-			return 1;
+			return -EINVAL;
 		break;
 	}
 	case HV_X64_MSR_EOI:
@@ -1586,7 +1586,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		return kvm_hv_vapic_msr_write(vcpu, APIC_TASKPRI, data);
 	case HV_X64_MSR_VP_RUNTIME:
 		if (!host)
-			return 1;
+			return -EINVAL;
 		hv_vcpu->runtime_offset = data - current_task_runtime_100ns();
 		break;
 	case HV_X64_MSR_SCONTROL:
@@ -1618,11 +1618,11 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	case HV_X64_MSR_APIC_FREQUENCY:
 		/* read-only, but still ignore it if host-initiated */
 		if (!host)
-			return 1;
+			return -EINVAL;
 		break;
 	default:
 		kvm_pr_unimpl_wrmsr(vcpu, msr, data);
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1636,7 +1636,7 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 
 	if (unlikely(!host && !hv_check_msr_access(to_hv_vcpu(vcpu), msr)))
-		return 1;
+		return -EINVAL;
 
 	switch (msr) {
 	case HV_X64_MSR_GUEST_OS_ID:
@@ -1677,7 +1677,7 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		return syndbg_get_msr(vcpu, msr, pdata, host);
 	default:
 		kvm_pr_unimpl_rdmsr(vcpu, msr);
-		return 1;
+		return -EINVAL;
 	}
 
 	*pdata = data;
@@ -1691,7 +1691,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	if (unlikely(!host && !hv_check_msr_access(hv_vcpu, msr)))
-		return 1;
+		return -EINVAL;
 
 	switch (msr) {
 	case HV_X64_MSR_VP_INDEX:
@@ -1743,7 +1743,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		break;
 	default:
 		kvm_pr_unimpl_rdmsr(vcpu, msr);
-		return 1;
+		return -EINVAL;
 	}
 	*pdata = data;
 	return 0;
@@ -1754,10 +1754,10 @@ int kvm_hv_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 
 	if (!host && !vcpu->arch.hyperv_enabled)
-		return 1;
+		return -EINVAL;
 
 	if (kvm_hv_vcpu_init(vcpu))
-		return 1;
+		return -EINVAL;
 
 	if (kvm_hv_msr_partition_wide(msr)) {
 		int r;
@@ -1775,10 +1775,10 @@ int kvm_hv_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata, bool host)
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 
 	if (!host && !vcpu->arch.hyperv_enabled)
-		return 1;
+		return -EINVAL;
 
 	if (kvm_hv_vcpu_init(vcpu))
-		return 1;
+		return -EINVAL;
 
 	if (kvm_hv_msr_partition_wide(msr)) {
 		int r;
-- 
2.54.0

