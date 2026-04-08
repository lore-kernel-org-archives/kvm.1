Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136F3ACA41
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672542; cv=none; b=SOFH67cj4ByLG7Ivtr9kQkY3S2b9yRUfP6QjrvFQSr60pH7yUEnY0T8dKAV/GHi2oRpdFZNaQhH9rabtQpg96UEFbwzW+d+bDbU27h5VvG0UGXQY2lRdvQFul3+j0vG2N8pViHQEMXVEInAZ0Id1LZuYXLxzaqJ1KyCINft1F3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672542; c=relaxed/simple;
	bh=YNA6M7PbNblZF/SyHRJpBcxuEfMg5NfBQVvMe5BQLXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LojHY+wyjFyjoOoVdPFhK7o63h6SrdCyjDEBPgBoxe8LFX8chZezHFHDF6G7eht67yjy4shOPjMF7tkHwFMURAm/YGPmj00OLBLJS6b5627fetGFvBgTKNVUjdSj2vEpGJX4/h1ETJjhfiSzyRDMODWSDRPqsu4QaotpKpI/JHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV3pxZMv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV3pxZMv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775672540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KhWae+3aFBCdS13NjxOgbCRYHPEER4uggrxX3dDDkTE=;
	b=CV3pxZMvI7N5CrsWy5MRwc+X7YYqrXGbDuGwCbu/brse7ENQZ7gh7nCnWQfFWi+1VpvppX
	h2+UuvO2tyDAW/rGKuN8onp108l3tq9SbDYeeccMe4GpHaf7nYMezSNXFyAq7JAYGMVJMh
	AGR2gMV38EC0jXYwI0xYkKHj9e7al3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-GwtRKKJ8MRiN8NilZMMeuQ-1; Wed,
 08 Apr 2026 14:22:16 -0400
X-MC-Unique: GwtRKKJ8MRiN8NilZMMeuQ-1
X-Mimecast-MFC-AGG-ID: GwtRKKJ8MRiN8NilZMMeuQ_1775672535
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28E0D18005B2;
	Wed,  8 Apr 2026 18:22:15 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 586EB19560A6;
	Wed,  8 Apr 2026 18:22:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 0/7] KVM: VMX/SVM: use the same SPEC_CTRL assembly code
Date: Wed,  8 Apr 2026 14:22:06 -0400
Message-ID: <20260408182213.522713-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As discussed in the APX thread, this series moves the SPEC_CTRL
handling for VMX entirely to vmenter.S, and while at it improves
the code reuse between SVM and VMX.

The prototype of __vmx_vcpu_run() and __svm_vcpu_run() becomes
the same, with a set of bit flags for the second argument (which
can be augmented with an extra bit for whether to save/restore APX).
The register allocation also becomes very similar, with %edi/%rdi
pointing to the vmx (resp. svm) argument (patches 1-4).

(In fact, most of this was already done at the time of commit 9f2febf3f04d
and predecessors, but I had never tested it and submitted it... because
well, assembly is scary).

Thanks to this, the code to restore the guest SPEC_CTRL value is the
same up to the register names and can be dropped into vmx/vmenter.S.
On the vmexit side the only change required is support for
X86_FEATURE_KERNEL_IBRS, which is a single ALTERNATIVE macro.

Paolo

Paolo Bonzini (7):
  KVM: VMX: remove regs argument of __vmx_vcpu_run
  KVM: VMX: more cleanups to __vmx_vcpu_run
  KVM: SVM: prepare for making SPEC_CTRL switch common with VMX
  KVM: SVM: adopt the same VMX_RUN_* flags as VMX
  KVM: SVM: extract RESTORE_*_SPEC_CTRL_BODY out of svm/vmenter.S
  KVM: VMX: switch to RESTORE_GUEST_SPEC_CTRL_BODY
  KVM: VMX: replace vmx_spec_ctrl_restore_host with
    RESTORE_HOST_SPEC_CTRL_BODY

 arch/x86/kvm/kvm-asm-offsets.c |   1 +
 arch/x86/kvm/svm/svm.c         |  14 ++-
 arch/x86/kvm/svm/vmenter.S     | 103 +++++--------------
 arch/x86/kvm/vmenter.h         |  75 ++++++++++++++
 arch/x86/kvm/vmx/run_flags.h   |   9 --
 arch/x86/kvm/vmx/vmenter.S     | 181 ++++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.c         |  39 ++-----
 arch/x86/kvm/vmx/vmx.h         |   7 +-
 8 files changed, 194 insertions(+), 235 deletions(-)
 create mode 100644 arch/x86/kvm/vmenter.h
 delete mode 100644 arch/x86/kvm/vmx/run_flags.h

-- 
2.52.0

