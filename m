Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38A32E6BC
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051838; cv=none; b=FxW3HR2+6ceNAr4vxsbQYzhIf/fzRq5Cfdw8t35+BuaHl1iJL0Kt4ObR9ERkCI5di5FkT5IfF1x/x6yiP9bmu/xTuFSPDyK6GsMEfYDgi2IlPXBp0pG0I4aQMuvV+QyY2s+8Z96aCtdrvobhEiMMyVB1bW03TUXxmcAijYpqSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051838; c=relaxed/simple;
	bh=RwPqlGeNkb18wMTEDlE8OJyCiSTO793BGluw/5D5YaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYj5cRrBiS8yZmS+U/HdwlkjTQHx3OM7VuPHeYHTkcn2DYQLidOx5ih1FsEPmNlCZGzEmsF4wY1G6zxyfKK9k0gcnKuZO6fPyI0RFIG/hXIjk4hzmeDtD4Rbjkny0rDV4O5TF7rfSO3Ds8ql4Cq/ZBDWtEvUp/hPDPC+brRk9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhv156FW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qHJ7wcAp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhv156FW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qHJ7wcAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lwADGhzFduFsZYKsBEke3PE8WrGRHNnzI5qm22SisE=;
	b=dhv156FWo6wJa2enKFA/FU08UvrmhXdNeUlJCNRDwQR/8LAk7FelRqAn+PMoXBMxunDM3T
	WDmp41J6qbeVrLKjHRdtp1CjOYaH3GO1ai0GCc/GYITcwl8R+rZJRIQz6yilQw+GbK1RSz
	6Iy/EzBOGYEK0ew5c7vEFUcRr6gI8gc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-vakot6fhMsuRFgY-LuiKJA-1; Fri, 20 Mar 2026 20:10:35 -0400
X-MC-Unique: vakot6fhMsuRFgY-LuiKJA-1
X-Mimecast-MFC-AGG-ID: vakot6fhMsuRFgY-LuiKJA_1774051834
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48531e6012bso38454015e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051834; x=1774656634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lwADGhzFduFsZYKsBEke3PE8WrGRHNnzI5qm22SisE=;
        b=qHJ7wcApFET/cqpNbOAXs4ZWtaFPdnbOx07KYgMmUyrOhdwcN+Rr3KRfNCZtYCMOL6
         w0NVeYJ6wHl3S+dv4mLwcud82lar+nBda+Y6j2Nq1Fxn7wk7tuNf2UoUaEITW8pyLEq7
         YMKyb/725eGijUImIgAXgT/cDe4PIncqPM3HNrz+230MnQQLBA7rwF1+Iz6kQa7ccSYa
         zFAghGvO9kmrf0QM0Io16w2n7NkAoYP+9l4ZnsGpENoGFyrlVHzwnE9qADA6B8DDHTdF
         4e7kBl4ibpiXTx2Ak6fSl63vH2hC4zQFEbQva2eqlzwe+jA7p8zOxUTVuEQxzcJ9rEJX
         1Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051834; x=1774656634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+lwADGhzFduFsZYKsBEke3PE8WrGRHNnzI5qm22SisE=;
        b=adRuOB2thtN+vr+DOAFyHHkZViYzURe+KtH0O576VfJBiWY8tL0qrpUNueyQaROw95
         eW+0Aw0c6UJkb8IOVxeySqOE/N0z3f8YFKsYjSVNXpBHz6cu6LCPmwz5Muf9v61jlT8m
         IdAjjLcHr9hUqEl/bWvSKWCFg+2AwSu7Ek13XO51ymmf0jDmlVKWQ6v7eNcmnvISkhlJ
         VZD6xvCGO3qs2G2DBELBXirQIaFP/t+veHHR9iwV2NTdyDiuVL9vlmdjKMNS8U3qGt0/
         6RlKV3Tqsth2JI1wZtH0hA69KCPgbpZzN+ijVdQuQkO5QfTx+tJPz01rHH+r9evYkRrC
         xHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXL1U1VPnQRXW1i0b2lISdsHQRWHW2SVVR2yGKcaQPB3ZlLuVmouoLy7I29VbhjseVjEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMuujpp1NeHNZ5JdMMaXSdbdslnS1PBCWGBpPljmIcy8bSsGxU
	nQKrRKfdl7aokeRVcTJkYrxpS5Vw3Lb0HWtn4LBEJfbpiJ3ylENuPSvGrgAffkqIEkhTp9qxQ+6
	KN7r5fwNLHfwpQ7jqWl1LN1+OChCdXIojH6orVNgR2ffJ2g32qLwfdg==
X-Gm-Gg: ATEYQzxkwtNs9p51Mx5+7gvj2N0AICXNO6kng31q6cIR25VK/g5YekvQuvbrcCooBHQ
	auA3t7L0dnUQ7j6+beD3WQI72gLFpzBCwmIsewMWJQ7NebekCLj4T1w4ywrms4yI02urmJNF0pz
	RzJ8LQjUraAg2wlBQfwxSJv2ENnTTXUHYzkN0nW5vaudCjNW1xVUerfXo0L21j8a72Fi9oJIy9z
	Dnc0uFz0j2Bqf1VXQfbMNpOL/H41X+1jZCEYLkJaBFllF/sQl8AkHA0KhG0geGjBa7hcP8ewKEa
	Ghyp5KSYXh8AsM0vw+Z+eC0Qi+xY9e0dOFUBiVHmrI2DCAr/AfHrO711GOB+i33sJHmxGts/ZZi
	7MJQaJeELxafylMK3DHt0dkojlhSrOfKkSrbVkr3eZxroURRtdrjDrZzhVJEQoXc2wVDEEexCNX
	DFNJ2j9d59hwfFXTmPKEW0Zve9
X-Received: by 2002:a05:600c:8b45:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-486fee0d6ebmr66589975e9.22.1774051833870;
        Fri, 20 Mar 2026 17:10:33 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-486fee0d6ebmr66589665e9.22.1774051833456;
        Fri, 20 Mar 2026 17:10:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe82ae69sm91545145e9.9.2026.03.20.17.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 21/22] KVM: SVM: work around errata 1218
Date: Sat, 21 Mar 2026 01:09:30 +0100
Message-ID: <20260321000931.1947084-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

According to AMD, the hypervisor may not be able to determine whether a
fault was a GMET fault or an NX fault based on EXITINFO1, and software
"must read the relevant VMCB to determine whether a fault was a GMET
fault or an NX fault".  The APM further details that they meant the
CPL field.

KVM uses the page fault error code to distinguish the causes of a
nested page fault, so recalculate the PFERR_USER_MASK bit of the
vmexit information.  Only do it for fetches and only if GMET is in
use, because KVM does not differentiate based on PFERR_USER_MASK
for other nested NPT page faults.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4a4f663b2bd2..d3b69eb3242b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1955,6 +1955,17 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(error_code & PFERR_SYNTHETIC_MASK))
 		error_code &= ~PFERR_SYNTHETIC_MASK;
 
+	if ((svm->vmcb->control.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE) &&
+	    (error_code & PFERR_FETCH_MASK)) {
+		/*
+		 * Work around errata 1218: EXITINFO1[2] May Be Incorrectly Set
+		 * When GMET (Guest Mode Execute Trap extension) is Enabled
+		 */
+		error_code |= PFERR_USER_MASK;
+		if (svm_get_cpl(vcpu) == 0)
+			error_code &= ~PFERR_USER_MASK;
+	}
+
 	if (sev_snp_guest(vcpu->kvm) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
-- 
2.52.0

