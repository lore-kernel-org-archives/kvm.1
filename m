Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9613546FA
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730818; cv=none; b=ugWvn2Ef9ju+2REDeBbpalSJR55KLK4ZkwRFB6GG1CgA3E5EDGEHvB/9Fdo7IZur2PUOdbuqmfqskZYBMumdOVmHu1qHt0J9ZMdIM+BX4REWL7x0tXGwmOCRvw+5fwDNIHuSuprBASWDUk6alZ64MdNHXTy3HhFNAA7B5Fk+a/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730818; c=relaxed/simple;
	bh=qNaxT1lfEbT1LPSsEVh5+AezcCglRx9kPOdT2poCI4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Isk2sc2xs108/bD/AB4Bode8v8p7bLkaWoHCZgeLhohKDHZL5ve00y8cDxreDTjPYAuQESr6PtuB0Q/IKOVK4s6epjcBu08fCRb9NHwMZuLaHAo2SmJ4DEDQPcbApKnQqCH7Vo7+4W8be81P+aynAfPhYNMy3Fl8eKak8hfN7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hxt/4maw; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hxt/4maw"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc7337e2a7so45755645ad.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730805; x=1791335605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlcl2f6ewwzrBjcQFC4aq+Z9uRrmySkT+V2ro3tMTk0=;
        b=Hxt/4mawJYjl3cUtn9/4R7/pV8adjVj12k9hjy/nnH3kQXwxnvrbhtrrbNqc1poZpb
         1Tzhhi9p4rXFC3xxUFBMy0uUxfjhvFvvmP7DZyzmiPizBhS8r6eRgdqJ8kNHrI9BGzzC
         a02FzqwsychuqMHWPuMtNyJWFEUNEch2TuuVGm3FCE6woHQkhp9hoQWyDJpp+GsgBuSZ
         jzqFekOhP3tADLohTxtC2faAtJDlm/hVProkACiQGREKJNQt56gZZ+OUFnGxnAn1hkTI
         ZRcGJXdwTQqbizXMkcBIVHBpsBRiYSB9C7RIQd//el2vZ0XyYMLiv/4NM56jtaqOlh8i
         E5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730805; x=1791335605;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlcl2f6ewwzrBjcQFC4aq+Z9uRrmySkT+V2ro3tMTk0=;
        b=rft3lkSRF4mz4v8lb958mbMubYOKy8ORb6NLe6BuPQADdt8/L1Vcmxzz1cRmoAgwV6
         7eTYXLvK35k4AFPm+Hic3XoxQs9d29olnAfn4REU1aiemb1yLVZ9sG/3o9X4Lpe4S5Mo
         GV/9rGtShfM1/gIS7/dyQ7oDQFqua18fDgLYOI1Afq10pggbZx0JuZeaKjeNpX9XZZif
         spa4u1oais5rc5EaPp9de3UYoy5k3bPNWxv7fwMVw/tUASWBHcUu7YdPpiEGch2SzC4G
         VjHEa/5Y/2Qh4DsX+Kz3XRZTY6PJZ5O8L11bP6uV+iB7l5TQcLEZzde/dkgvBX5d9SaB
         n7dA==
X-Gm-Message-State: AFq9FYIyW7HmE7OzkzQy0nwMALqlsbMYrYd3H3cYEgKALBqn61G3Ekak
	eyNP/Yk4R4C6iuRJtmi8I4i7R4gv87vakA//ttICZzBIaIoiqurZxPyRuL/OYaavsjaIhU2rVlp
	YH4dswA==
X-Received: from pldu15.prod.google.com ([2002:a17:903:108f:b0:2e1:2a71:d15b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37cd:b0:2e2:de62:2b22
 with SMTP id d9443c01a7336-2e2de622b87mr6202935ad.49.1790730804937; Tue, 29
 Sep 2026 18:13:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:09 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-9-seanjc@google.com>
Subject: [PATCH v5 08/12] KVM: nSVM: Disable LBRV in nested control cache when unsupported
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
the vCPU does not support LBR Virtualization. This lets the cached value be
consumed directly instead of re-checking X86_FEATURE_LBRV on every access.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 8 +++++---
 arch/x86/kvm/svm/svm.c    | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b61149814acc..aca2bbc66f47 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -527,12 +527,16 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 
 	/* Always clear misc_ctl bits that the guest cannot use */
 	to->misc_ctl = from->misc_ctl;
+	to->misc_ctl2 = from->misc_ctl2;
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
 
 	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
 
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
+		to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
+
 	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
 	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
@@ -550,7 +554,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
 	to->nested_cr3          = from->nested_cr3;
-	to->misc_ctl2		= from->misc_ctl2;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
@@ -737,8 +740,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 
 static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 {
-	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+	return to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
 }
 
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 775eccfb7b24..5253c0143666 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -882,7 +882,7 @@ static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
 	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
 		return true;
 
-	return is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
+	return is_guest_mode(vcpu) &&
 	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

