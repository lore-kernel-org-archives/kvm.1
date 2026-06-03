Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA555436347
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484305; cv=none; b=XEslMLJriCH1LCVQMP6d2afhtIO9kdytp68k9BqDW/lzfnCi9WBVGw3mIdnZF9zCG38myrFFHTkXlUelL4gQrVkjO9qxwqlZk3j2jt5Zs6clXHADHXZ42tsL583qSHbKQPYS/m9R6b4pjiGs9aw9RVs7kVgH6Uu+VE2LGXXrLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484305; c=relaxed/simple;
	bh=uGhlhaw8FKlDLXT261XQKolFsUWFnCaqY7nW8k90AiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Be292OsGceLzyYAW0IMJu6iHbNTrgvVxdb+8u7n6jH3pBHPmlJiDXZJbJiWz3HH1Wb++tWQeQ3AmiuPLPeS3HdT8IETr16Qe0kkQbyLP1+0hvUFgl1hWmdbBQNLZ/WdgVVzw52D1vXfPsKkKdCpSZOWIYfdHtAmgE7h6QQTFiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMasT6f2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMasT6f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2SVIGrCB6MttCzDE0j3sPFqyLMhK1UhS8dftKLkZo8=;
	b=HMasT6f2N+rILsQNXLzOCHAPKYE/LTkq3XOtG1ERhJENRoONAr3r8CSc0qkI9bWof8r87R
	tcZIdowiZaqR1ArfIat9JxKMW4PpMYwo3+xue9N9PHh0O0luF/NHgLF6e51+nZYp476j9D
	PayDiirWbirm2ZL7eRjHAkjLwFAzk2s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-cnYophKxPOOrjjN_fggQMw-1; Wed,
 03 Jun 2026 06:58:17 -0400
X-MC-Unique: cnYophKxPOOrjjN_fggQMw-1
X-Mimecast-MFC-AGG-ID: cnYophKxPOOrjjN_fggQMw_1780484296
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B75E8195608B;
	Wed,  3 Jun 2026 10:58:16 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 440CD404;
	Wed,  3 Jun 2026 10:58:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 02/24] KVM: nVMX: remove unnecessary code in prepare_vmcs02_rare
Date: Wed,  3 Jun 2026 06:57:52 -0400
Message-ID: <20260603105814.10236-3-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The early vmwrite of the PDPTRs in prepare_vmcs02_rare() is redundant, because
every write it does will be performed by prepare_vmcs02() if it is actually
needed.

In any case where the emulator or the processor need the PDPTR, either
is_pae_paging() is true on vmentry, or a write of CR0, CR4 or EFER will
cause a vmexit to L0.  The next vmentry will refresh the PDPTRs in the
vmcs02 from vmcs12.

In fact, the original version[1] of what ended up being commit
c7554efc8335 ("KVM: nVMX: Copy PDPTRs to/from vmcs12 only when
necessary"), the writes in what is now prepare_vmcs02_rare() were removed.
When the mega-collection of optimizations was posted[2], the removal of
that code got dropped as a rebase good, so reinstate it.

[1] https://lore.kernel.org/all/20190507160640.4812-16-sean.j.christopherson@intel.com
[2] https://lore.kernel.org/all/1560445409-17363-31-git-send-email-pbonzini@redhat.com

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4690a4d23709..1bd0839146fd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2623,17 +2623,6 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 		vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
 		vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
 
-		/*
-		 * L1 may access the L2's PDPTR, so save them to construct
-		 * vmcs12
-		 */
-		if (enable_ept) {
-			vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
-			vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
-			vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
-			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
-		}
-
 		if (kvm_mpx_supported() && vmx->vcpu.arch.nested_run_pending &&
 		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
 			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
-- 
2.52.0


