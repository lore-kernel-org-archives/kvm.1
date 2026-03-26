Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1BE421880
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549091; cv=none; b=RK9XDeJiK9yg2yGQ0ujptWv7+F4ldYYyVrCsBg6F8feqnsT0/R9gpfLbW/r2+YP7Nr+uJ2AzwOuCXyCCtcN9OzsGPQzuHdDpfFS0W/MpBzlhfSyNnKZm4NOOvZySH+F9WRe2WEl6o/e9I9UhK8SlxFc/bqeP6pF4JbjbQFt6nLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549091; c=relaxed/simple;
	bh=vRU527ooK61F8J/EBmObXyVR1fL0SuQzz0JB5ca4i3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhbujLEo50X9jZYmVDHDq6f7SpFo9/qyLLf3+5kuT1lBGYdVYh7kNVR7F/gThY5XlVL1v32FvZsQzNYTByCbEjgo12jpad2mroixl3tDNTD3VInilwBRnxBKxYh1xeipb5tDHs2ZAlpVjncFprC5TIfN7mpB9JIBX3NMTQFGNkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkQe0v99; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rZEAr2Ff; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkQe0v99";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rZEAr2Ff"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3max8On1ZuAYoYMSIpCEX64J8cd14WUWIyCVRHJcuY=;
	b=KkQe0v99rK1s2bamIwiLUsGuxOb5mVeCSDGyslxY6oKl6umEI4eA5UbXOMt5JEyzjPZZn0
	GIlbA3YAOyGHQn3U5rsK72eDCmQJYf1NAivBapv1zmKPrhWh7NsPAoGcwe5Aqbt59MLW9M
	zmLfSIsb9iLgOa1Bme+CtQLPtThlR8s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-_56Ex5hrN7KkEPn2n-S7kw-1; Thu, 26 Mar 2026 14:18:02 -0400
X-MC-Unique: _56Ex5hrN7KkEPn2n-S7kw-1
X-Mimecast-MFC-AGG-ID: _56Ex5hrN7KkEPn2n-S7kw_1774549081
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b99add7f3so318468f8f.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549081; x=1775153881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3max8On1ZuAYoYMSIpCEX64J8cd14WUWIyCVRHJcuY=;
        b=rZEAr2FfBQNJ1bfJ32ZMoYs5Qc3hrRqi+JoTUlgZPrvcghj8pw+yk37WEixZZL65LA
         oT+n6EH9YDl7YkY5gRtFaw1e3UEcMHOnmCHh3zhwY0BV0DHoAHGQFTmhk2PIH6wbZ2M8
         ykg1s29Ysfp6FUarjBib/6oSY7AFoA+EsxVUC4S0fvNFh8vngVrtq/4ISvQgb9NhA4C0
         deEB7eoZPTO+8C3WoH//Guu7+HhuCKmXtK936UmP4AqIRInvhHzNV+Fyyaph91iZwQet
         ZQa9zxrzKfwo6HgYaswMc7pGMwS5fS7BLVOtnl6ZeNlrKCD1S+tcUnVHpmnrYNW/p3qp
         pFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549081; x=1775153881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3max8On1ZuAYoYMSIpCEX64J8cd14WUWIyCVRHJcuY=;
        b=O+YSsSfx47Rli4hLmZnep8In+iy3fTZZnVNUGMqqYQVSvyLS0shcqNOld3apoKQ4Kn
         gFC+rOigF/dLHc8wDDfKKunOt+KR9/y5tnBTOXKMLDcoNEwRz2TX+IT19fiprw+uwI4m
         CFhk1X3V2Q9SUn4yayqShtG7n51W0N8Bd+viTHAlNfbfmEzpc9rKFDtyYiDmh/AvFYqD
         zm3q+GcXhZROk8RKhx1zuhZDL41RzeYhlgC+8ns/HtAgyTx4uwXGgc/ReBOebuaEJshA
         M8qPWxVGpWfvKuYE/FSVmaecJ9T8pt5XmM8GbOWs682j3B6frlNBZbRCQKk+MbfvsIR9
         d/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVB1Pb3l6VN+cdKseTmzkmOBFjHuoMMwKO91Kp3FzOFym/ApyI6IYjf/iAGuDews+V6vQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvbz73KKnk60SBulwUgUDM6uLvtiTCJlsyQ6C6+zaBJNO+WOeC
	Ujt1Soc5ObAT+lzxBap/j1fk9css2LsVkzgYpllqX79/e2R9yjTOIwBJ2rKpfS2AObrhiW6HHSW
	dnPC71fnnhFGOhTaFViXMokWuE0skRbLLm3Z75i34LfCrgd6Pm841Qg==
X-Gm-Gg: ATEYQzyEz1fego1TzvTR4WyqrRs8tI2SilQVU4Iz5QwCppJf00SuKK/KRJn8w4RJxB2
	Syb3lFnqDCZx/Bx3BJ4v2dGqQ2FK/0A8etVKp9yCYsTtyICgpm7qC46PzNsBA1nrCDZl/X6r1Be
	k+5rfhAFSm5mWglzKEBUemvLpcqh1sSEPWRPabOxDWw6CjrSneGKOqQZv56jZHc6mHISQuVH6Ex
	wHNsQ00eHBTOlCvOefLMib1QwvjcJuwKwMiJmDS5cT0bvcdFzWtA1XvpWlhFIWpPtz2V7cv3gCW
	hDe4KEzUPrIyWoaf0f33xk6N+RA/WUI84u0X5uedowewk5CWhAVH18yui8q0kdAXyvn/JJfIPqs
	dSrLpwur0s/YZfyhKE3x60bJtpPSYCFWBomObwWnsQELD7vBX5SgesdFeclU4YoyAWBml4xYuZM
	2pe+fA3psIyIvvT3wwcTGj/kDh
X-Received: by 2002:a05:6000:2901:b0:43b:4967:2898 with SMTP id ffacd0b85a97d-43b97a2cdc1mr5218486f8f.22.1774549081350;
        Thu, 26 Mar 2026 11:18:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2901:b0:43b:4967:2898 with SMTP id ffacd0b85a97d-43b97a2cdc1mr5218274f8f.22.1774549079750;
        Thu, 26 Mar 2026 11:17:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm10797961f8f.5.2026.03.26.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 13/24] KVM: nVMX: pass advanced EPT violation vmexit info to guest
Date: Thu, 26 Mar 2026 19:17:11 +0100
Message-ID: <20260326181723.218115-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM will use advanced vmexit information for EPT violations to
virtualize MBEC.  Pass it to the guest since it is easy and allows
testing nested nested.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h     |  4 ++++
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/vmx/nested.c      | 13 +++++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 2b449a3948d3..fcd623719334 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -524,6 +524,7 @@ enum vmcs_field {
 #define VMX_EPT_1GB_PAGE_BIT			(1ull << 17)
 #define VMX_EPT_INVEPT_BIT			(1ull << 20)
 #define VMX_EPT_AD_BIT				    (1ull << 21)
+#define VMX_EPT_ADVANCED_VMEXIT_INFO_BIT	(1ull << 22)
 #define VMX_EPT_EXTENT_CONTEXT_BIT		(1ull << 25)
 #define VMX_EPT_EXTENT_GLOBAL_BIT		(1ull << 26)
 
@@ -606,6 +607,9 @@ enum vm_entry_failure_code {
 					 EPT_VIOLATION_PROT_USER_EXEC)
 #define EPT_VIOLATION_GVA_IS_VALID	BIT(7)
 #define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)
+#define EPT_VIOLATION_GVA_USER		BIT(9)
+#define EPT_VIOLATION_GVA_WRITABLE	BIT(10)
+#define EPT_VIOLATION_GVA_NX		BIT(11)
 
 #define EPT_VIOLATION_RWX_TO_PROT(__epte) (((__epte) & VMX_EPT_RWX_MASK) << 3)
 #define EPT_VIOLATION_USER_EXEC_TO_PROT(__epte) (((__epte) & VMX_EPT_USER_EXECUTABLE_MASK) >> 4)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index fb1b5d8b23e5..09e2e630d4b6 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -491,7 +491,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * [2:0] - Derive from the access bits. The exit_qualification might be
 	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
-	 * [7:8] - Derived from [7:8] of real exit_qualification
+	 * [7:11] - Derived from [7:11] of real exit_qualification
 	 *
 	 * The other bits are set to 0.
 	 */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index adeb5a29169f..4b742a19bfde 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -443,10 +443,14 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
 			exit_qualification = 0;
 		} else {
+			u64 mask = EPT_VIOLATION_GVA_IS_VALID |
+				EPT_VIOLATION_GVA_TRANSLATED;
+			if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
+				mask |= EPT_VIOLATION_GVA_USER |
+					       EPT_VIOLATION_GVA_WRITABLE |
+					       EPT_VIOLATION_GVA_NX;
 			exit_qualification = fault->exit_qualification;
-			exit_qualification |= vmx_get_exit_qual(vcpu) &
-					      (EPT_VIOLATION_GVA_IS_VALID |
-					       EPT_VIOLATION_GVA_TRANSLATED);
+			exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
 			vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
 		}
 
@@ -7238,7 +7242,8 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			VMX_EPT_PAGE_WALK_5_BIT |
 			VMX_EPTP_WB_BIT |
 			VMX_EPT_INVEPT_BIT |
-			VMX_EPT_EXECUTE_ONLY_BIT;
+			VMX_EPT_EXECUTE_ONLY_BIT |
+			VMX_EPT_ADVANCED_VMEXIT_INFO_BIT;
 
 		msrs->ept_caps &= ept_caps;
 		msrs->ept_caps |= VMX_EPT_EXTENT_GLOBAL_BIT |
-- 
2.53.0

