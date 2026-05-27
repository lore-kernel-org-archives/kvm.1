Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C03CFF62
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883567; cv=none; b=OhHSoR2tdeOqNsijzVV/G/JcSJTIyN2DtIt7TLH8JpSOI3DBynQgTvMZnopdA8wpznN/ZLSYuy1irrjkB1fKtL90OLMK6bx6tgfhSMyrkpCdpDSJSXzSU+Uif7Vrg/zXxSrRqEqmiHHnbVs7c3j7WSbIjfF3y7hQagnizUO7s8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883567; c=relaxed/simple;
	bh=gvEiPlInglo0r74PX397+vNMGGG0xuISgO8KtDoW134=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxbPrHv9sTFYZIp0/k0mSsueKMgfGTT4DCTxZX8WA4qu/EyxNLOWBby6ivuKsLUEozS4EmadOpE5c+LSfcT+JHHu0AN/03WLHlDT7U2OVFPAvi+nfjzxYAxh8K+1nLNW8ZsnzPIJY207mSyeNDnV9+NAB6mDFgkUujAHYpYnUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfL9VpEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfL9VpEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779883565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nya6UNu0l453v6wwHI22O/+8/iCoTX1TEBOmb0+3No0=;
	b=GfL9VpEAHzVPJSPu8DS8ZMQ2HRdYs0DR7EoA9kPX8Q4zrcppAtmYaMeXBQXTms88+RCt/9
	CYzh0hVRxeeM9EtGfnZlARglRrdGYIjVd9CnCnKBt4/AYtpK7vP5M5zmIK6IBvoDA9fInf
	rw8teSyXZIprBOgfZgLv8SIeZL5kDCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-iqONmE_xMwuSF1GvHH86sA-1; Wed,
 27 May 2026 08:06:03 -0400
X-MC-Unique: iqONmE_xMwuSF1GvHH86sA-1
X-Mimecast-MFC-AGG-ID: iqONmE_xMwuSF1GvHH86sA_1779883562
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0CE91956096;
	Wed, 27 May 2026 12:06:02 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5520C1681;
	Wed, 27 May 2026 12:06:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 2/4] KVM: nVMX: remove unnecessary code in prepare_vmcs02
Date: Wed, 27 May 2026 08:05:58 -0400
Message-ID: <20260527120600.20696-3-pbonzini@redhat.com>
In-Reply-To: <20260527120600.20696-1-pbonzini@redhat.com>
References: <20260527120600.20696-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The late vmwrite of the PDPTRs in prepare_vmcs02() is redundant, because
every write it does was already performed by prepare_vmcs02_rare earlier
in the same prepare_vmcs02 call.

In particular:

- load_guest_pdptrs_vmcs12 == true implies that prepare_vmcs02_rare() ran

- the assignment to load_guest_pdptrs_vmcs12 matches the gate in
  prepare_vmcs02_rare(), other than having one that checks
  !hv_evmcs and the other !nested_vmx_is_evmptr12_valid(vmx)

- the condition for the late move is a strict subset of the one in
  prepare_vmcs02_rare(), because the former checks
  nested_cpu_has_ept(vmcs12), which implies enable_ept, and on top
  it narrows it further by ANDing is_pae_paging(vcpu)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c1be8ef882b8..f86a12fc29ec 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2721,14 +2721,10 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
-	bool load_guest_pdptrs_vmcs12 = false;
 
 	if (vmx->nested.dirty_vmcs12 || nested_vmx_is_evmptr12_valid(vmx)) {
 		prepare_vmcs02_rare(vmx, vmcs12);
 		vmx->nested.dirty_vmcs12 = false;
-
-		load_guest_pdptrs_vmcs12 = !nested_vmx_is_evmptr12_valid(vmx) ||
-			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
 	if (vcpu->arch.nested_run_pending &&
@@ -2831,15 +2827,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	if (enable_ept)
 		vmcs_writel(GUEST_CR3, vmcs12->guest_cr3);
 
-	/* Late preparation of GUEST_PDPTRs now that EFER and CRs are set. */
-	if (load_guest_pdptrs_vmcs12 && nested_cpu_has_ept(vmcs12) &&
-	    is_pae_paging(vcpu)) {
-		vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
-		vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
-		vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
-		vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
-	}
-
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL) &&
 	    kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu)) &&
 	    WARN_ON_ONCE(__kvm_emulate_msr_write(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
-- 
2.52.0


