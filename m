Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7538F658
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374317; cv=none; b=RrNaNuR+JqH4d2c2HIYbojLekX+LfJEEur4PKl0bvmyeMip06HHudvVJBBNlXbAII4o97yvaQ6z4PmW2UxnmOwSOJUTTp6oDbsvHD0LMi3PP7/IkjiHrQ16BaPw3ChU8vFWMI1vVBHC6/hdvKqgYKxbNZDuuyCw3+CPQNdPbi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374317; c=relaxed/simple;
	bh=PM0pzWNW5Msqel+Hx92Tvt6GdHkJ4aT0CnEvPxb24Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pqcoRB5QpCmRXnPIZYYUAE1x7O791l2scw1nmXXT5+hALLkd3LrW7+5jyGDyk7oTplZSwjRleML1MuDehHcSYMsfJ2U5KDOTdBeemnnM9D1wVGQyuUlkVkOlwP0qteqkVY18GIuzUmaG2Tpr6W/pztIWoBRCzXedqVItkIJ4Nck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXwSDRQa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXwSDRQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ave8NpQXHCm5EHLHaZIHmnKE1VG4OaC/jBAS9sT7SSQ=;
	b=iXwSDRQaWOZnDBSh+fBi6iisue/ADB93pVL6kVL3QauQtt9IJGVBaJTz6Nd/ex5yCxb1zv
	VzurQogA8oOYNyMSF1/DIxfkIbEktRd2YCSx342UwQIlWbaQdMuh8UEi3/3Nq/J4BCrdrh
	0HXXFHW6oIk0FugaQzTxaXUiTWOKukI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-mIsBE1oENrGmrSiKADcADg-1; Tue,
 28 Apr 2026 07:05:10 -0400
X-MC-Unique: mIsBE1oENrGmrSiKADcADg-1
X-Mimecast-MFC-AGG-ID: mIsBE1oENrGmrSiKADcADg_1777374309
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AB56195605A;
	Tue, 28 Apr 2026 11:05:09 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD68D180047F;
	Tue, 28 Apr 2026 11:05:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v3 0/8] KVM: VMX/SVM: use the same SPEC_CTRL assembly code
Date: Tue, 28 Apr 2026 07:04:59 -0400
Message-ID: <20260428110507.11248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

As discussed in the APX thread, this series moves the SPEC_CTRL
handling for VMX entirely to vmenter.S, and while at it improves
the code reuse between SVM and VMX.

The prototype of __vmx_vcpu_run() and __svm_vcpu_run() becomes
the same, with a set of bit flags for the second argument (which
can be augmented with an extra bit for whether to save/restore APX).
The register allocation also becomes very similar, with %edi/%rdi
pointing to the vmx (resp. svm) argument (patches 1-4).

Thanks to this, the code to restore the guest SPEC_CTRL value is the
same up to the register names and can be dropped into vmx/vmenter.S.
On the vmexit side the only change required is support for
X86_FEATURE_KERNEL_IBRS, which is a single ALTERNATIVE macro.

This also introduces vmenter.h, which hosts common code between
vmx/vmenter.S and svm/vmenter.S, and which will be augmented
further by the APX enablement series.

Paolo

v2->v3:
- add extra patch so that it actually works [Chang S. Bae]
- fix incorrect reference to KVM_ENTER_RUN_* in comments
- preserve LFENCE in the eIBRS case [sashiko]

v1->v2:
- fix "Reload @vmx to RAX" comment [Binbin]
- fix polarity of KVM_ENTER_SAVE_SPEC_CTRL in SVM, which would
  have caused problems when the macros are reused for VMX
- adjust prototypes of __svm_vcpu_run and __svm_sev_es_vcpu_run
- fix order of ALTERNATIVE arguments for X86_FEATURE_KERNEL_IBRS.
  Add comment
- Leave @flags and @vmx on the stack during RESTORE_HOST_SPEC_CTRL_BODY.
  [Uros, Binbin]



Paolo Bonzini (8):
  KVM: VMX: remove regs argument of __vmx_vcpu_run
  KVM: VMX: more cleanups to __vmx_vcpu_run
  KVM: SVM: prepare for making SPEC_CTRL switch common with VMX
  KVM: SVM: pass struct vcpu_svm to msr_write_intercepted
  KVM: SVM: adopt the same VMX_RUN_* flags as VMX
  KVM: SVM: extract RESTORE_*_SPEC_CTRL_BODY out of svm/vmenter.S
  KVM: VMX: switch to RESTORE_GUEST_SPEC_CTRL_BODY
  KVM: VMX: replace vmx_spec_ctrl_restore_host with
    RESTORE_HOST_SPEC_CTRL_BODY

 arch/x86/kvm/kvm-asm-offsets.c |   1 +
 arch/x86/kvm/svm/svm.c         |  23 +++--
 arch/x86/kvm/svm/svm.h         |   4 +-
 arch/x86/kvm/svm/vmenter.S     | 103 +++++-------------
 arch/x86/kvm/vmenter.h         |  80 ++++++++++++++
 arch/x86/kvm/vmx/run_flags.h   |   9 --
 arch/x86/kvm/vmx/vmenter.S     | 184 +++++++++++++++------------------
 arch/x86/kvm/vmx/vmx.c         |  39 ++-----
 arch/x86/kvm/vmx/vmx.h         |   7 +-
 9 files changed, 212 insertions(+), 238 deletions(-)
 create mode 100644 arch/x86/kvm/vmenter.h
 delete mode 100644 arch/x86/kvm/vmx/run_flags.h

-- 
2.52.0

