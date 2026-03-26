Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066C429827
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549104; cv=none; b=VF1LJsk6R3r1GqyShKK3GMVAL3Wnvctu+uW0e5Y44OhrjIPdORCKxuh4rGjKNOOAAlRAEaMEEBfZ7YEOgysuoXVlEtT8iVx2qmPdmoi1by7vrec+loc/nr+Okq2wlv2oa9Zi4GrbP3PqclIp/+iXm2zvF8V0SEfhbmCLnVrh1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549104; c=relaxed/simple;
	bh=2D2EQk2bLthISoFaweOxLF4/yTYZ7pD8jLqVulmh/fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9bdEZAV2yIZKcI738SWpbm/dGdP2yfBiddiISj9r1A51Dj8e9QGpYSKV/pMlaiaPtmSN+PIOx2TzfzNuugG42rscwQZ5RgU4AI9Zepf6zui5LuCtsETgHFW8BZFTP9IK1WQrmziDssFodJdlGFTt0lY68DK0lGupZ0W6mtWHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XczXcJ43; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuEGzXcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XczXcJ43";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuEGzXcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3UgqXdB1yN5qlE9l9MfdSS3raCgHzxdYSeSXyVGn9c=;
	b=XczXcJ43W8WfCiSKsiMCaexF1IJKAfnyhFL2Wun50dBtvYELjMUH6HW44OZGRRj2AgGcFh
	dtkIgL+s19/BBghfO21adhmHVKgs9buN1YOdb5ucGFe1RP0P2/50vKuCNsuInpabTiUJn1
	R7rxWOlE9DuCRuDG9Kyxe2sL0AwJl0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-J11lIOpZOwqa0g7MIST2kA-1; Thu, 26 Mar 2026 14:18:20 -0400
X-MC-Unique: J11lIOpZOwqa0g7MIST2kA-1
X-Mimecast-MFC-AGG-ID: J11lIOpZOwqa0g7MIST2kA_1774549100
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso21442675e9.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549099; x=1775153899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3UgqXdB1yN5qlE9l9MfdSS3raCgHzxdYSeSXyVGn9c=;
        b=MuEGzXczE4QncYzS6mmwepAOG9MUu+Jc9Ygad+mjzToRSg/EcAm/2W5ChTRvvMpV2u
         PAfNjbkN4fO3hLJVGqKf02ijdfvs4MzIguvA0dWk2jOYYYtHhsTSs+Z84+72OGG9vQMi
         yDv+Kf7P6ADAp/4+tGLbThAuqWFRm0IzFfjzg9NAAdTG2Lzb0rFQilHM/j2ReWNslYbU
         YJuVV3CEtyuUIU5GsKHLOTTs8a6nDJJ/n6FPc6d8ztQmvoDOgNEvu4IRrmTuYJp6f2ER
         v0v7aYs0aLmndfL8efKSRj0OW2S/n0Wg/9e5Q8g6369L8rSLSL6CKfPw8/kouzD7uLIy
         E93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549099; x=1775153899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3UgqXdB1yN5qlE9l9MfdSS3raCgHzxdYSeSXyVGn9c=;
        b=LmVeVl0blWDoiq/lQ2yyeBGJ2ak0c9iPpL4UeqClwZWm6oqXZYxAzpwoP04JIfcGKE
         SdSEj2kg5Hq5qmelvwsAPEWYEEofkNbq0CEHHxhiRpZz047+YBWwIK+biXZwthgvAC3v
         cG2gX2U14klsnINcodd3wG84+6jumwgVQ+vpD7RZ85qV3d7OisgLc7enrTmm6Hs/MvkW
         BkPBHwa62UczkPgjj0P5Goag3ImiSIGTv129qF6BXHOvHshJBz0YRI01AG3UZR9k7w0N
         csjr+bN/K5m3pomXWyxY+On1rf0DRNi7guwmcUWfnGk04xe9/OTTvp+6OKVhABBRDRGK
         wIXA==
X-Forwarded-Encrypted: i=1; AJvYcCXtu+yh3+lwKUEn3i8rIM2O9T+8uTnIHBmJEH1/iGovlunPeLXYF1yL0jLPN4YBJ27Wwnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreNMVnHomgnbKfbiypzjWA3M8hhp46AjdM3rmCk/7r8HSaP1y
	gMDXRAXK8JBpipvBTWr1m+l0JTeHWJeAWNptA4fvuma56a7AcCVsWMvFMPf3ZMyUSxrkarvh1g3
	8+pkKEj25I7cmH86WJu2YTM6HWPt5XTKPwXWo0VG0ohzo3ctpeOHy9Q==
X-Gm-Gg: ATEYQzzsMWLIBcfvTzIekvJiHlzXaAwBNsnuqKLDNbPA9zzlltUXtJg8CwCqQrVM+hY
	fSkimAl0NXy0+2XuJto+E+Ysy4ZloDdTpeHx0VMXgRkImqaqjykltv3rdqOqRy3uQBgXArNear+
	KdH8fZovZAGUJUupFC6N3WQ7eFAlezlPnf2xU1yTB/EdiTL+Ye0rXCLzMS1an+pqfixGDOvuhNh
	a0Nbm38Zyr3C8KUZZvZ3CHr0ze+SwtB8BLmMJsqX3z0hqC5DFmnKd+j7lwvzAumrx4+2WSi3lys
	JfoMEhLscxYqbDnsDt4epM2j4/JgN8NqlBsX3Gw/YjrX24FvW+r/FE/1B0YAJafWHYqPa6AtJ5k
	D3zsRraKc/JX3hyZ1q5CklD6rt3NQsZRwv06kuCsMwylhML3Du0CI+rQzv684iGkB3F6ESF60gb
	pMRsTemIbP8zSLqZKvrZlC+zb4
X-Received: by 2002:a05:600c:8b2a:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48715fc32admr129513565e9.6.1774549099541;
        Thu, 26 Mar 2026 11:18:19 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2a:b0:486:ff92:63e5 with SMTP id 5b1f17b1804b1-48715fc32admr129513005e9.6.1774549099053;
        Thu, 26 Mar 2026 11:18:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487209378e2sm18783295e9.31.2026.03.26.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 20/24] KVM: SVM: add GMET bit definitions
Date: Thu, 26 Mar 2026 19:17:18 +0100
Message-ID: <20260326181723.218115-21-pbonzini@redhat.com>
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

GMET (Guest Mode Execute Trap) is an AMD virtualization feature,
essentially the nested paging version of SMEP.  Hyper-V uses it;
add it in preparation for making it available to hypervisors
running under KVM.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/svm.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..9f876fbdcc3a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -379,6 +379,7 @@
 #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
 #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Virtual VMSAVE VMLOAD */
 #define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
+#define X86_FEATURE_GMET		(15*32+17) /* Guest Mode Execution Trap */
 #define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index edde36097ddc..03e9e0112b10 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -242,6 +242,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
 #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
+#define SVM_NESTED_CTL_GMET_ENABLE	BIT(3)
 
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
-- 
2.53.0

