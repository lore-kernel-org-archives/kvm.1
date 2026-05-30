Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13013A71BE
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160155; cv=none; b=kh1a4AeGl2Qx8YB31F+lBnIuuLIoaozn99x48D5X4IhQD6ee9t2E7VROs9kLo+2Qzi7XtmaoPsHa7JWxWVNa2wcOSCmMYiB6tYc+pGGkbw/MSW+IIkbu1buQw5PVt/fG+l3MSSy3sutuEci+GG53d78C2IwljpFs3aThFbBTdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160155; c=relaxed/simple;
	bh=f/JibM/Z8U0GmZ8VpS7vTkSFIKKx0UmcuQ89am1W1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t42ByYy5zILn35zukm0U6/U3ue9BBBqxvYwQ2S027YK3dHFLOxt9vNvomt+5zZbdsfZqMDSqAJQ23PnM4rzQR8/krXaxTOSDPZzTPfhTDO7jD38qnVQDlGQgB0VfXW1fI3rT+EuY+/bLeSMRW9WtoIldTmVCWgxatf7yCFhJYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vr5IJckI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr5IJckI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBJqn7A9uwH01+VXGW+KMltHwpd4ueg5LsNii60ADEA=;
	b=Vr5IJckI+oZrOUCjjXv9cKFGkUcHj4uSc2LSsa6O/bhahqSSgCNVjxN8biM6iu9Wjpogzy
	qcn/gzp6upIJXFlXeletlRZDgdlvaAYtvoq+zqilGf2gT9kRzZxoineGt6gSlxjmOTkkR8
	tulzImGAGFUlnHl8c1eniEUGXdBjb5U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-LPVpT5uSMFmirYqBVndvSQ-1; Sat,
 30 May 2026 12:55:49 -0400
X-MC-Unique: LPVpT5uSMFmirYqBVndvSQ-1
X-Mimecast-MFC-AGG-ID: LPVpT5uSMFmirYqBVndvSQ_1780160148
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BDED1800451;
	Sat, 30 May 2026 16:55:48 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D69AB1800465;
	Sat, 30 May 2026 16:55:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH v2 2/5] KVM: nVMX: remove unnecessary code in prepare_vmcs02_rare
Date: Sat, 30 May 2026 12:55:42 -0400
Message-ID: <20260530165545.25599-3-pbonzini@redhat.com>
In-Reply-To: <20260530165545.25599-1-pbonzini@redhat.com>
References: <20260530165545.25599-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index c1be8ef882b8..58f91e7921e3 100644
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


