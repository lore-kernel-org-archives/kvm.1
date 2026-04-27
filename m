Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8833B5318
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287535; cv=none; b=BZ9/abmhUv3j+J4xF8zvmLbnXwY18pV32Ri9qluh9Dm4fLJ8KHxY0PRqyF0mov4hkJYwg6YU00a8CM3yIkvKPlo+GpXIKwPNbOiXEUhgQOLwnOhyukdmvS4EjDPm9i8oJazDQjd0rQeWakgwSScfjbtOdp+lYuteDVve1a0qcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287535; c=relaxed/simple;
	bh=g0OQnFSRCId+GpcBbt2am+SsIlihS58YQDs81PipocU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bfeb985jMokO5EiUSi70azuUCLwhNr0VGdDLJ6UERUAacQxl1fn7h0xypt6A8SNwFOsZRXeKUVT2sD7kjjiX2FNesde2kVjYgcygktExtqulb8n6uyfa4A0ZToz4fVDiggt4FzHfGy7R/IMtOQFJIHqLe24iekE+FxuYFu1kmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iF4NU3Oy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iF4NU3Oy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777287533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rzNcTSTXNrXx2pQtf9NKbQCSfn1/8j5dG+anRL9mjwk=;
	b=iF4NU3OyIxo9rufD7Nj6VPYu+LZEQXJ75lxe6f9hkL4ZqlcZkjuv2ReOTI2bB/mv4BCy/1
	x5tvB1+gf6to2OyqkobjZd9UbhzHkLzfgT4vpugaqXOtODQw5hFZp/FOJ9NhwGOBYC4EQr
	vaRRkLnZnmAYrVvNZeyEajA6Wob0AXw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-OWQ0r0S1PBqzvemXewkbsg-1; Mon,
 27 Apr 2026 06:58:51 -0400
X-MC-Unique: OWQ0r0S1PBqzvemXewkbsg-1
X-Mimecast-MFC-AGG-ID: OWQ0r0S1PBqzvemXewkbsg_1777287530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5230D18005AC;
	Mon, 27 Apr 2026 10:58:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C491180047F;
	Mon, 27 Apr 2026 10:58:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2 0/7] KVM: VMX/SVM: use the same SPEC_CTRL assembly code
Date: Mon, 27 Apr 2026 06:58:41 -0400
Message-ID: <20260427105848.44865-1-pbonzini@redhat.com>
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

(In fact, most of this was already done at the time of commit 9f2febf3f04d
and predecessors, but I had never tested it and submitted it... because
well, assembly is scary).

Thanks to this, the code to restore the guest SPEC_CTRL value is the
same up to the register names and can be dropped into vmx/vmenter.S.
On the vmexit side the only change required is support for
X86_FEATURE_KERNEL_IBRS, which is a single ALTERNATIVE macro.

Paolo

patch 2:
- fix "Reload @vmx to RAX" comment [Binbin]

patch 4:
- fix polarity of KVM_ENTER_SAVE_SPEC_CTRL in SVM, which would
  have caused problems when the macros are reused for VMX
- adjust prototypes of __svm_vcpu_run and __svm_sev_es_vcpu_run

patch 7:
- fix order of ALTERNATIVE arguments for X86_FEATURE_KERNEL_IBRS.
  Add comment
- Leave @flags and @vmx on the stack during RESTORE_HOST_SPEC_CTRL_BODY.
  [Uros, Binbin]


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
 arch/x86/kvm/svm/svm.h         |   4 +-
 arch/x86/kvm/svm/vmenter.S     | 103 +++++--------------
 arch/x86/kvm/vmenter.h         |  80 +++++++++++++++
 arch/x86/kvm/vmx/run_flags.h   |   9 --
 arch/x86/kvm/vmx/vmenter.S     | 176 ++++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.c         |  39 ++------
 arch/x86/kvm/vmx/vmx.h         |   7 +-
 9 files changed, 199 insertions(+), 234 deletions(-)
 create mode 100644 arch/x86/kvm/vmenter.h
 delete mode 100644 arch/x86/kvm/vmx/run_flags.h

-- 
2.52.0

