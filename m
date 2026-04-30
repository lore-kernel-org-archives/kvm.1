Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52044CAEC
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561701; cv=none; b=d1VvIhstA/iiB9UQmG9KsFpSF05/wndvOapWPwwT7mQfEfD6PUmiimVzfafOZ6mh7tRQthIWR/OR+FAPXEmrqpV40McNCrL20qyU+E1gW/X3x8sS8wYTxg9MwHZEBJlmhxQjwb89oojDj3v/TKd+MIgJrFFvziwnTHjYaY8LmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561701; c=relaxed/simple;
	bh=Ikxx8wYPGa5Z+o5s0fjJ6ZzD5n/6leMlsJt/lKwgm7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP/wxj4rdwT6w9Gi/FKbgOSSzAkXexPbTlXSsecg8q64cC6jXcWwap9/11+oGqf/rG67Tln0i0YbVQ5vZj9Jucfnn9RRcinra0xpHwSk3sO+sWMA9GVmR0Yb1r9OboTW6lQq8xHpsBdmDw0Xzc7683NJqUd9oD5p1fdiYluV3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8aggmFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8aggmFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROsMQfT03fFELQ1ZZYQ/4nB7HH3HdhzPEBDKlF7YMiI=;
	b=I8aggmFd8kjxRDRNcKF45WvVFt0nJRmeWczU6YrhtDqy674f8IuaKQXUrdbaxiDaKublTV
	ryY910LHYZO5lfvoGQ5SILLnhbb0/IbduAT6DdgQmWFYA89qVVOUgYbt6GczxQe8CqH6VR
	Kz0nc3IGL4DmxtRoJEkfzbjqWK0Rh4A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-hxVhi1gXPvinpFabibuGXg-1; Thu,
 30 Apr 2026 11:08:12 -0400
X-MC-Unique: hxVhi1gXPvinpFabibuGXg-1
X-Mimecast-MFC-AGG-ID: hxVhi1gXPvinpFabibuGXg_1777561691
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7EAB1956048;
	Thu, 30 Apr 2026 15:08:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31582180034F;
	Thu, 30 Apr 2026 15:08:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 28/28] KVM: nSVM: enable GMET for guests
Date: Thu, 30 Apr 2026 11:07:47 -0400
Message-ID: <20260430150747.76749-29-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

All that needs to be done is moving the GMET bit from vmcb12 to vmcb02.
The only new thing is that __nested_copy_vmcb_control_to_cache now
ensures that ignored-if-unavailable bits are zero in svm->nested.ctl.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 6 +++++-
 arch/x86/kvm/svm/svm.c    | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 74a1df1cb84f..3d1fd1776e19 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -489,11 +489,14 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	nested_svm_sanitize_intercept(vcpu, to, SKINIT);
 	nested_svm_sanitize_intercept(vcpu, to, RDPRU);
 
-	/* Always clear SVM_MISC_ENABLE_NP if the guest cannot use NPTs */
+	/* Always clear misc_ctl bits that the guest cannot use */
 	to->misc_ctl = from->misc_ctl;
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
 
+	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
+		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+
 	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
 	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
@@ -898,6 +901,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+		vmcb02->control.misc_ctl |= (svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET);
 
 		nested_svm_init_mmu_context(vcpu);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fd79874c5f4b..a82471a6d3ea 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5504,6 +5504,9 @@ static __init void svm_set_cpu_caps(void)
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (gmet_enabled)
+			kvm_cpu_cap_set(X86_FEATURE_GMET);
+
 		if (vgif)
 			kvm_cpu_cap_set(X86_FEATURE_VGIF);
 
-- 
2.52.0

