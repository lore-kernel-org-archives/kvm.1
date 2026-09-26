Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D79376A01
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400786; cv=none; b=p5D3xKBdHwk2ca5ELUxc8N23jkKKZ41Etu4SyCSu7ghqIsLslKC0tz3cgj5BXdwLIws6xxl3JJI0D5sVbrDImrm67FFCPnr2WLyj5+mtB0eZBffyi+F9kFse2grP8PeHBmgWS7V1k5QpQVgGfC9bLWFwU1YhBKbd/tCMNoWQqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400786; c=relaxed/simple;
	bh=GN8GZruQXYRaF7EO63+YgQk2i0jrLoiCCKQQn3gDa9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OU1jpiKSpJRS5uvNFVEH1VL1LCwgwXFqMceK2kUfJUmgnv5Kx1NRPqewb00m1idzt6iOoRqOwyz4MEcu3qg3RXBriG7TtG/Z3WZN3Q3pSNv9Jp4jaUjEDJPp/JI6uXHzmH2j4J1PKbazd5FJbR4bG6IpN0rMntu9q6ihPB34zmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agVEj3Nt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agVEj3Nt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+M2+L1H5egwQQlZ0xHrmsDhZ8xEZMT62MEpuXSNGixQ=;
	b=agVEj3NtHuCpIMukOblWUfRIU7baU+kuTrCcGd1Vwk8/FjTfkI8TWN02/VoZBP853n66Mg
	QAVzOviOKkCUxSvg62LPwZh+j+O8wT47cvwrxCJNf365q67wL5Df+HEXNvn3LOKnrbsTMj
	NANiaLcRSSLehDWRW9rfvERTWpQ5tPk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-43i1mL1sM4qBU_AMwsrp5w-1; Sat,
 26 Sep 2026 01:32:58 -0400
X-MC-Unique: 43i1mL1sM4qBU_AMwsrp5w-1
X-Mimecast-MFC-AGG-ID: 43i1mL1sM4qBU_AMwsrp5w_1790400776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9400A1800871;
	Sat, 26 Sep 2026 05:32:56 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A11F1956086;
	Sat, 26 Sep 2026 05:32:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/11] KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
Date: Sat, 26 Sep 2026 01:32:44 -0400
Message-ID: <20260926053253.195597-3-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

Leave control.erap_ctl and control.clean as-is in the VMCS if VMRUN fails,
because as per AMD:

  there's no explicit architectural guarantee about the behavior in the
  presence of VMRUN failures. So the best thing to do would be to assume
  that if VMRUN fails, the actions requested in the control fields may not
  have been performed.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260904170642.3291466-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index afbaaaab84ed..b63e7c69aa1c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4625,17 +4625,17 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (!svm_is_vmrun_failure(svm->vmcb->control.exit_code)) {
 		this_cpu_ptr(&svm_data)->flush_all_asids = false;
 		svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+
+		/*
+		 * Unconditionally mask off the CLEAR_RAP bit, the AND is just
+		 * as cheap as the TEST+Jcc to avoid it.
+		 */
+		if (cpu_feature_enabled(X86_FEATURE_ERAPS))
+			svm->vmcb->control.erap_ctl &= ~ERAP_CONTROL_CLEAR_RAP;
+
+		vmcb_mark_all_clean(svm->vmcb);
 	}
 
-	/*
-	 * Unconditionally mask off the CLEAR_RAP bit, the AND is just as cheap
-	 * as the TEST+Jcc to avoid it.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_ERAPS))
-		svm->vmcb->control.erap_ctl &= ~ERAP_CONTROL_CLEAR_RAP;
-
-	vmcb_mark_all_clean(svm->vmcb);
-
 	/* if exit due to PF check for async PF */
 	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
 		vcpu->arch.apf.host_apf_flags =
-- 
2.52.0


