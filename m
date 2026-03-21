Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27F31F9BC
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051829; cv=none; b=qoWYK0LxFP7C8/7TP9MbKNkU+AnTqK7MA1h90twDid1ZFVJj5OaaASQmQfmsli0HaVRAbPua9n1IyY82UppVgrzDLgKG4h0+WosdfRhZEHBp4hy9h9k3ZqpsGWzhAeHXlArAWc8rvElBGL/A53H4/VbwD58W2CPFLtBrvjKMD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051829; c=relaxed/simple;
	bh=lPKKspzfSofsN1QCipZepB+gFS9lQMHHN27fmiJ6Yxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUX1Ve0X34ntSonmgzKRMISy9YMSHeo6Z5zDtUXJbSs+7IRRS0vwlsfHYiu39wDOiasS+2ALsQ181JDghGtzgWyOTkQsFKASrbwdY30rz2o6kHg3j9GUhi9fR+MwKVkh8nygScIpsRzkE4bo7a87HfWU3p2nqDp6Au5apYvnFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLNjuX47; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWTz5egh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLNjuX47";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWTz5egh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dY59s6Dld+8zthkUpJxvKSdoBN1IRmLu6DOr1vsJ15A=;
	b=KLNjuX47fe4Qfp3JLyLEuXJdVz5G1Kw7aN3H2im7L+6kOaKSPNsjCNPMtN04qGPrIQCRVp
	eLDIzmmUi5A4i9OchW+pA4DapVj7h6rYYZWF6NKJlj5Jd6d5to42sbnDDp/N/PUydZCveO
	U5KNDtRbx6Y7fma50D0x+TGbGg0dOco=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-DHiYhPxAOr6fB8yAxoE0CQ-1; Fri, 20 Mar 2026 20:10:25 -0400
X-MC-Unique: DHiYhPxAOr6fB8yAxoE0CQ-1
X-Mimecast-MFC-AGG-ID: DHiYhPxAOr6fB8yAxoE0CQ_1774051824
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3d3d2d22so1779220f8f.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051824; x=1774656624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY59s6Dld+8zthkUpJxvKSdoBN1IRmLu6DOr1vsJ15A=;
        b=EWTz5egh3GfXE0kz3lzlxSTRQ2x351ePbmnn8uR1351Lcr5eZqToGyWVy2+ohr3RS9
         HEwmTPJJeInyFXRfwfl9TiZqeZvi1X5uU4Gw6mv+AdSGBbk3r9N0Rec1dhQZAUfN2rin
         C8fR77z1Has8qViG4N8zsv3stpVnjUq/gZd0bCnt6ntRv0KaWtJ9xN/XFnFk2jc1rbo5
         PXCsfIyF48lfvy1p/wvwRY/9tMWwUmp8/GNbY+1Nn9+lEJ1RredkQ6mtP2rFAGE62Vfa
         w5nAy7PvxEQfZ5dJupuj7K4js9iGwbEIoei7swn69+Hiax3ZrbL4rh/ybgjUWNxweY9Y
         86dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051824; x=1774656624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dY59s6Dld+8zthkUpJxvKSdoBN1IRmLu6DOr1vsJ15A=;
        b=mPaba3JzPAndoPP8+Ic2zUNQdENxCj/WY7h94hn5Ea4X31a3auNklfowpdA15NH6gr
         t8aQOGQZ0Ex0snah9R218msohk32HK1oWZq74OWAUdaWfINiAmPX0UzvPsZoump8CUyO
         BdHUGq2V7dIh6enroAfYrR1TPKSoIGHJaR3xDFS7MDFehoSDKCBXDfzOzoy9nCXvIbhg
         UjpNBts/BHXAmhQWTQRezV1fJIr00DjP0Ifg+h3rMP6Q47H9s6eAgh4FZcf9+424aqnH
         jzQbKQfgbMUrvaeFrylg95uidhqHxYI3mpgJ245NykBVGz4bbwnZod23ukys8otgJ3pj
         nDKw==
X-Forwarded-Encrypted: i=1; AJvYcCWYmDM/QC9VmpzP4fqNoGJaD/iEbhpqh4ORT7wbmX0fUqcW8jsCq0nvJ95CuoMHKwCjLvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yM1uAQjXFQEpIaZu9AVr/ki+MoX2FDTZNHFG4C1EJl97Bike
	eGcSy+vhxlq+Xbfkf3sqgumOQcn+4EB6Nyqz/hfQofRDcEAtGWpjn3DQnE7/8w+mynqYQ6XLb9C
	3b37ObPz+K+yr80CzfNJ5jGBVNyceLTSyyX3Cpcs4aWKpHGS97Mypkw==
X-Gm-Gg: ATEYQzxQGxexdUe+MHOBT3AbWd959HU2mY0N6+V6a8z29w2FtBOgvU8pfqsfGnRy79y
	9JIergTRbZCGnNFVZ7Qlj0XyJhhIsCjql0SuY2Q27UEgPoVZEkxA2bRYBBaUFybjfmPccSQuM2T
	jAauauN9jPP0muNpnwWX3BGeABWSvm/1GzG5KTlUvO99SrT5ld8W5Gt3q97dNLl91aWQ1M3wNgV
	vxSbefvvlKDUfdyueilV+n3L+BZ2XrmyheT2eU5JUc2ZOJXI5MkDh/USSdHWbKvj0zNW9TZKzjm
	/q4Eui9Oe4r9NQoSipnC733xH69gXHZgDu6hrfKKH7h3fzFdBI/R+v+z3s0T+dVikO1pX8dUarO
	I5FaHKizdDj5ULLmHtcyoNWLEQ5318kX7ohqfqGgfLVr/y6bITWeqOeITMI4xGHosYDlKVl2dxY
	fClUvxP8dz5/miR4QZLakZxtcE
X-Received: by 2002:a05:6000:4283:b0:43b:6320:d937 with SMTP id ffacd0b85a97d-43b6423a2e7mr8303045f8f.19.1774051824220;
        Fri, 20 Mar 2026 17:10:24 -0700 (PDT)
X-Received: by 2002:a05:6000:4283:b0:43b:6320:d937 with SMTP id ffacd0b85a97d-43b6423a2e7mr8303011f8f.19.1774051823732;
        Fri, 20 Mar 2026 17:10:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647177e8sm10573531f8f.34.2026.03.20.17.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Date: Sat, 21 Mar 2026 01:09:27 +0100
Message-ID: <20260321000931.1947084-19-pbonzini@redhat.com>
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

GMET (Guest Mode Execute Trap) is an AMD virtualization feature,
essentially the nested paging version of SMEP.  Hyper-V uses it;
add it in preparation for making it available to hypervisors
running under KVM.

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/svm.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 123c023fe42c..95469c7d357f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -382,6 +382,7 @@
 #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
 #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Virtual VMSAVE VMLOAD */
 #define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
+#define X86_FEATURE_GMET		(15*32+17) /* "gmet" Guest Mode Execution Trap */
 #define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index e2a29e1144a7..47353bef947c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -239,6 +239,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
 #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
+#define SVM_NESTED_CTL_GMET_ENABLE	BIT(3)
 
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
-- 
2.52.0

