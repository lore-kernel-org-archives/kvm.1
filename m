Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C1423A9B
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549094; cv=none; b=I67WawzSt0yX1O5S7vCoabre8uQTTPIdHcp8judIG+cXnAbn+yc0JIVv/Gz9gzvqUlfS76cKd3kXgw1EKaInUcLjbcBQXlgFXQFWxCwSTyj2sYW0+yptth/+98/oXKb8pu+RJjaDR+no3wzqzqvEVFPD8ZK6HL9R7c4uX8khMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549094; c=relaxed/simple;
	bh=iqpR+ue8PSAxYdmD9sNdud7LYdT3dwh4I8hHcO4//yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4N7VBky2y/FS5FalITlOSq+z9dCX3atHS+d8NPa0LRAKgZLwYevc+ZPALrM+ntetflaYe4njFYn1L6y1rbw5FE4GefkXVXxw7/xZw1v6/E5hVWz2DMZhu/gGK77lZ8+vGJAhpwvUrLzgPGpN9QiWTtsB7m1PSbpwBTU/0H3GWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ds7NToJm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrHLaaMV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds7NToJm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrHLaaMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMmfmDl/+uM6tnVT+23fk4z+uPIH04GvDwC4CoL1dMo=;
	b=Ds7NToJmJ8pkZjbJJ1v2SE3aYRYagbigJLYvx7cJxdZHDX+w+TdD/xrutXHRTlr2i9PYF9
	C8YbX/c2Ezixlmy/hIVOW+TTBhmHKOVRSMdHx4gDn2em38xzB8+ui7RSRp7e20VXl0fSnq
	gBD24M9Jd7+bqp8s65yLyfGUXcr7Zb8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-eetWQzBjPTSrwo-pKMkwEg-1; Thu, 26 Mar 2026 14:18:05 -0400
X-MC-Unique: eetWQzBjPTSrwo-pKMkwEg-1
X-Mimecast-MFC-AGG-ID: eetWQzBjPTSrwo-pKMkwEg_1774549084
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439b8bc43aeso921910f8f.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549084; x=1775153884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMmfmDl/+uM6tnVT+23fk4z+uPIH04GvDwC4CoL1dMo=;
        b=KrHLaaMVKWZaTuPGtPlejqAT2wQeKNDk4jpcrEf+OuyyuxvWyByFRgm6DQROKCw9TB
         EUB8a1BdIVibqe+Trq6akvPcw1VXjkX00EuWssttY18vW0dglf41na0fD5R2jzYOpjUx
         XiIpaHOgnZLwr/ICB24bvMiR7J+xwaNoWd5A7tKZJWt/Vbqe924BpHI8fps6eZhu0dwf
         62cuFy1BgCQ2HUQZLAZOnUfXJpIQxZZuPRHfdqYAkCKYYZhex3W8BlIXPKC0o9PhoEtA
         epPSgGb8z/8orSZ/lJmr2Exj8yCic5zPwWqPBjfX5WTILu/BstAXX/hMZjUW32QDhLXb
         VYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549084; x=1775153884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMmfmDl/+uM6tnVT+23fk4z+uPIH04GvDwC4CoL1dMo=;
        b=gH1XfVtCV7BJ9EbMxazkGo7BeqxkBAlwjj/qBLEJrSKWoeECl45THC8XmedO31ObTt
         Fd4yFqu6/L5l/2I8pWXQtX+YJgZwK5Nr2uKlmIOXB7GWiv5gmRuWLvKolpSBgD+Mk5P7
         y8WQ3jrPmjSfwjtRexLh9+3Lpi6+c1JCVB2epdyHuNk1O7Gk7nIN/Y/8XxrrIuYREprQ
         S5Eo4dvLiJ2krEN93D2tkCI7dHfAqRCmETaWVp7r9MZhYoxkhmFkBScLj/fG2Vpb82lm
         sTGK1AFxcM1EC4/JctUPIlagFT+9Ls6w3cJxxSr2ghqC96w9aWuF8EFQit5667ILP378
         F44Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS0MEkz+n3Q8msL2MCHCIQIYiYHzlbMykk8nDCSUgUQkevWgwsqYkQPz+gYL93xKThXos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzark2rq/fZaOeBSUHjvJrQdnJS05DkpxEPwCvumY3iNLg7fGFk
	rLhQtMntRWXeWXabo/j8uXJB3qThPoH+DwZJ7/yBiVCr0Col8sQ43930crM3NlqTyK90Z8OSzyv
	K3BrZn1cPV5PJjIg0Y+Wj+16/FKsXUMXNGC3CBaCp9mi5AgQ5kMWW/g==
X-Gm-Gg: ATEYQzz01+tsNP1FSrAUrwlU4cinZiZSBVWmk0zJ3j4Rccl9BQyNRT/qPgoAjqXJ40S
	rrnU5hz9205u28ucQYGH42f2k4489Z3gPKiSsGYXsEoYY3C+LdIXXOVN7OVogs/VyJ+n7EvFis7
	TpsRLQcAF/8CnfAtO/x9EFklnjjN3QAhPAbz3gxUk9ZQe/cz+fZAs60V7DfaTu+OxyWTGXWTv0Z
	jcN0TssGmAEbZzHh2+U1OkIrnEUABNOQzxmpPew19LxrnKfWQV19RnuA0Ovo9P5rfZRWhwyTkk9
	OnfpjM0aZwmareq5TgVEJ5WSrrY06FWv/q9yYvWUnAIAwe5jBNCTuq83dUVZDN3kp0FOI9pLiTk
	8p+JTWUyn/lBpl/aZFH4BYsol/xTGkiT3G0A/YDT2o5eil+CG7PCutmr4AZeIGCVtMf3ul/TFI8
	SIxZ3ZO7Ar2m995bQnxD7jxQzC
X-Received: by 2002:a05:600c:3516:b0:485:3bc7:a231 with SMTP id 5b1f17b1804b1-48716084829mr139187115e9.29.1774549084347;
        Thu, 26 Mar 2026 11:18:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:485:3bc7:a231 with SMTP id 5b1f17b1804b1-48716084829mr139186425e9.29.1774549083697;
        Thu, 26 Mar 2026 11:18:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm42456935e9.10.2026.03.26.11.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 14/24] KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
Date: Thu, 26 Mar 2026 19:17:12 +0100
Message-ID: <20260326181723.218115-15-pbonzini@redhat.com>
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

For EPT, PFERR_USER_MASK refers not to the CPL of the guest,
but to the AND of the U bits encountered while walking guest
page tables; this is consistent with how MBEC differentiates
between XS and XU.  This is available through the
"advanced vmexit information for EPT violations" feature.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/common.h |  6 +++++-
 arch/x86/kvm/vmx/vmx.c    | 10 ++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 40fa72f31fc7..48520fa1c8e8 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -100,9 +100,13 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 		error_code |= (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
 			      ? PFERR_PRESENT_MASK : 0;
 
-	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
+	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
+		if ((exit_qualification & (EPT_VIOLATION_GVA_TRANSLATED|EPT_VIOLATION_GVA_USER))
+		    == (EPT_VIOLATION_GVA_TRANSLATED|EPT_VIOLATION_GVA_USER))
+			error_code |= PFERR_USER_MASK;
+	}
 
 	if (vt_is_tdx_private_gpa(vcpu->kvm, gpa))
 		error_code |= PFERR_PRIVATE_ACCESS;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0c25c6865f91..65892dc6f478 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2826,6 +2826,16 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		vmx_cap->vpid = 0;
 	}
 
+	/*
+	 * Virtualizing MBEC requires advanced vmexit information in order to
+	 * distinguish supervisor and user accesses.  For simplicity and clarity
+	 * disable MBEC entirely if advanced vmexit information is not available,
+	 * this way mbec=1 in the kvm_intel module parameters implies availability
+	 * to nested guests as well.
+	 */
+	if (!(vmx_cap->ept & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT))
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+
 	if (!cpu_has_sgx())
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
 
-- 
2.53.0

