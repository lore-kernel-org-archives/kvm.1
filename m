Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641534;
	b=U984lle0TxZxvjJhiCgsE1PXL/INmVuRq8VAHcVTmKcJ+NkP/B5EqCJiq7iaSjbUUwxU
	 fdS8bDpu8yf9FnsoHE00CPJSfLDJKC7CTRVYzS0QTF7GmLCH/lWB6q6NPyDWeocuAFhPJ
	 rhg4vdXGZqYDSBuDR+0Kn48C4EU3+2jRvAs46Nk3TjRDslE05uYnnO566bahye5Z3cnv2
	 As20hCXOSPTn9yOVcjB8ceSctuGqIUC+jHDlLXGiw9pqOxgk7QhCdgfVcPtyAZMCIU3Kz
	 T2PQLLEbLmMdcVAwdfYj1WuXMGggVpPXG829BjgmPawS+53TDmODrH1BYHx/8ZKPczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641534;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=A4ctNs9aRed/MgT3Q6jRNIu8zPar0ahhuNw/oxAaFI4=;
	b=v/jyihi83Zj8jG2a2daDZ2zKDQwELQou/yywUpCDkGizOfhgjCV+hw6EfvUDGMto2MXg
	 TQ7ZbT2Un3J/jitivQGIf7KYuw1lXDhZqgXI0XnQvoNFg//km8Dxs413HYUUhznEiHJyM
	 k2y9KDD3OYY4CIHpKPvExuQ0Lq7g4845zALxR+h+935ouOKA7vsAh5b7UxKb8o4CdSXlb
	 Gzx8dIqmax3umZxuRrXHNI8h8+cnSVUOAi01NC2brELMWmoHWMqlB2kzQOQkhCx8s0Nkc
	 5+A5H+yUIafXcIMy5JrXVxPd2NkjxZtyhJk4Qqr59OM2lDzsPsfM3Fz2LfluBai0HBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HOR5Peta;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03D607485C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F03D607485C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HOR5Peta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4ctNs9aRed/MgT3Q6jRNIu8zPar0ahhuNw/oxAaFI4=;
	b=HOR5PetayRUqZKstcjG7o/v4lqh1xZ8VlSJnfkv3MUpMcYatefbevbIrG/bg6isb74F+Vn
	5eIwy6GPG3IqUWNt7874LQrJeV0M7Y6vOL8Nth/bMOPNXpGHgPs84cBU5muGbPqnpywjp1
	Z3anbtc80uDyic531NZlQen2NTR/9Ws=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-_kTlxDbkOS6dVg0L2yjygg-1; Mon,
 02 Nov 2026 12:45:30 -0500
X-MC-Unique: _kTlxDbkOS6dVg0L2yjygg-1
X-Mimecast-MFC-AGG-ID: _kTlxDbkOS6dVg0L2yjygg_1793641528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A29FC1956070;
	Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30BE41800347;
	Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 39/45] KVM: VMX: mark VM dead on shadow VMCS or eVMCS access failures
Date: Mon,  2 Nov 2026 12:45:06 -0500
Message-ID: <20261102174512.8903-23-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

KVM ignores failures when reading or writing L1's in-memory VMCSs (shadow
VMCS, eVMCS), allowing execution to continue with stale shadow VMCS values
or silently losing updates.  Check both the HVA cache initialization
and the cached memory accesses, and mark the VM dead on failure; these
failures can only occur when guest memory permissions deny the access,
and terminating the VM is safe (though it precludes using memory attributes
as a replacement for e.g. userfaultfd, and only leaves the feature usable
for security purposes).

Likewise, treat a failed read of an enabled VP assist page as fatal too,
otherwise KVM continues by disabling enlightened VMCS.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/hyperv.c |  7 ++++++-
 arch/x86/kvm/vmx/nested.c | 21 ++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fa41d036acd4..746540e503e3 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -18,9 +18,14 @@ u64 nested_get_evmptr(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	if (unlikely(kvm_hv_get_assist_page(vcpu)))
+	if (unlikely(!kvm_hv_assist_page_enabled(vcpu)))
 		return EVMPTR_INVALID;
 
+	if (unlikely(kvm_hv_get_assist_page(vcpu))) {
+		kvm_vm_dead(vcpu->kvm);
+		return EVMPTR_INVALID;
+	}
+
 	if (unlikely(!hv_vcpu->vp_assist_page.enlighten_vmentry))
 		return EVMPTR_INVALID;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2ac4a366ace4..bde151de0bf7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -861,10 +861,13 @@ static void nested_cache_shadow_vmcs12(struct kvm_vcpu *vcpu,
 	if (ghc->gpa != vmcs12->vmcs_link_pointer &&
 	    kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc,
 				      vmcs12->vmcs_link_pointer, VMCS12_SIZE))
-		return;
+		goto error;
 
-	kvm_read_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
-			      VMCS12_SIZE);
+	if (!kvm_read_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
+				   VMCS12_SIZE))
+		return;
+error:
+	kvm_vm_dead(vcpu->kvm);
 }
 
 static void nested_flush_cached_shadow_vmcs12(struct kvm_vcpu *vcpu,
@@ -880,10 +883,13 @@ static void nested_flush_cached_shadow_vmcs12(struct kvm_vcpu *vcpu,
 	if (ghc->gpa != vmcs12->vmcs_link_pointer &&
 	    kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc,
 				      vmcs12->vmcs_link_pointer, VMCS12_SIZE))
-		return;
+		goto error;
 
-	kvm_write_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
-			       VMCS12_SIZE);
+	if (!kvm_write_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
+				    VMCS12_SIZE))
+		return;
+error:
+	kvm_vm_dead(vcpu->kvm);
 }
 
 /*
@@ -5091,7 +5097,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		 * do that when something is forcing L2->L1 exit prior to
 		 * the first L2 run.
 		 */
-		(void)nested_get_evmcs_page(vcpu);
+		if (!nested_get_evmcs_page(vcpu))
+			kvm_vm_dead(vcpu->kvm);
 #endif
 	}
 
-- 
2.52.0


