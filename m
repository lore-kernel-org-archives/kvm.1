Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170033E1206
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662975; cv=none; b=GPNsq7SYnDovs+soYDooesUkJ3je1MqVxS1+wbdFfgUKvZzh0Pc4B/tcGr4Z/wPQN0xE1gDpNdXy4VnH+n4teE4ee2w3168HsLhPxctubVGo4PBqLwWKtwHehs9vskFDzdgoIwPPNSzn3++nTQDpm3XvtSJufFM7Pq3QQfgoWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662975; c=relaxed/simple;
	bh=ZsDJpj7MSSebIDfPfyhxOzylV0M1CI6/K0n6Hjt9nKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qibu1qJrQ/bSKb6KWC8i9Xst4cyAN+u28YdPh5kUAQKvOVpXX5C//wVp4mzs3RkYDHW1RX3QbzY3UNQ4lDw4fUbfXadASaq6wZNAo3EQSsTfPoSuoaAVtpCgjmQyhmiJYH4B9/WlLrSQFHrmpqNCi9ytGKzZMWNPXLDsmEIp03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htCDIupp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htCDIupp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv7ZOujT48/Fy6/YhH8RYKG7tAQtoFH4Ofc00619ouo=;
	b=htCDIupp3yN+TTzhEn2OElBZllcn4Q4noTzipQ9GnML//Pd59i/a/8g9QIN/0EDuEJtEWE
	b/mPexGsjN1i7ijkYgcnuKYsISgl17FR3/ym7PaGIzxH8mNsPli09yj93DftsvveJAxoiU
	P/9pBZj8aa9YLRYUYF3A5/o+G5Qyst8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-vKJ__5ZZP0eJWUc6tkdTkQ-1; Wed,
 08 Apr 2026 11:42:50 -0400
X-MC-Unique: vKJ__5ZZP0eJWUc6tkdTkQ-1
X-Mimecast-MFC-AGG-ID: vKJ__5ZZP0eJWUc6tkdTkQ_1775662967
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D178E1955F56;
	Wed,  8 Apr 2026 15:42:47 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08CF5300019F;
	Wed,  8 Apr 2026 15:42:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 27/27] KVM: nSVM: enable GMET for guests
Date: Wed,  8 Apr 2026 11:42:17 -0400
Message-ID: <20260408154217.458420-28-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

All that needs to be done is moving the GMET bit from vmcs12 to
vmcs02.  The only new thing is that __nested_svm_check_controls
now ensures that ignored-if-unavailable bits are zero in
svm->nested.ctl.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 5 +++++
 arch/x86/kvm/svm/svm.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 863040ecec0e..3c45adb70946 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -470,7 +470,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->exit_info_2         = from->exit_info_2;
 	to->exit_int_info       = from->exit_int_info;
 	to->exit_int_info_err   = from->exit_int_info_err;
+
 	to->nested_ctl          = from->nested_ctl;
+	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
+		to->nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+
 	to->event_inj           = from->event_inj;
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
@@ -832,6 +836,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.nested_ctl &= ~SVM_NESTED_CTL_GMET_ENABLE;
+		vmcb02->control.nested_ctl |= (svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);
 
 		nested_svm_init_mmu_context(vcpu);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4957fa36890c..55baaf833e63 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5372,6 +5372,9 @@ static __init void svm_set_cpu_caps(void)
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (gmet_enabled)
+			kvm_cpu_cap_set(X86_FEATURE_GMET);
+
 		if (vgif)
 			kvm_cpu_cap_set(X86_FEATURE_VGIF);
 
-- 
2.52.0

