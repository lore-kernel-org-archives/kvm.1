Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6F38F935
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805962; cv=none; b=ngdhbLtHtTnic63kqhRHjcmmO7QNaJ/IQEzG3tSA4oDmZY2iEcEI2xfI9EDe+SMSvCHM96hPXc+10EdSTWnL8BKATHn3UtMyNkF/t3cX4YEgG0sxn2KAV7MsPkBti/uwlRcbevJ2kmnzBYuYI//k8K8BkGNaHjwQsPfWOKtobZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805962; c=relaxed/simple;
	bh=7nneyVx7k7xrEDZv0nl9gc2vrg8v2b/keKLgPkrNOU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJXnTis+uzVhm7ydvOcPlDkOm6ph84rGx8ULOn2MtF/wWLH/lH7bXbZj86XpBllU/u3Qq5UXaTEkGg4pqgbHeQw/5Iw3mgyHbeFoKnPxkNGjTf70G6RoFlXiva55Ofusp9OLLv0Yhw3czKp172ZdMzUts9/9xblS6XA6ww+L72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l05uRgsm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l05uRgsm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso12081255ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787805961; x=1788410761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEzr0jYee/fARbmWPhLxuBfGYBmn4khYyL4pUGs2CjQ=;
        b=l05uRgsmde9ziZiAkR6xFPVmo4ark2OKWExizHJnevSQOVY2ICmzWawhuGbPRqc1yd
         WHjxRTs/y7LMZessUhYFfzwIph9RNVbwhG/mG0+nPQQhW9939gtWxDMi7ZnnwmIjmgGa
         99jzK5dESXfDDVCFOreehCxYLsBV+NYJFG8s79kKDkegL0BYixLoBiExyT1CEKjY+lcK
         bXYH6cBkt+q88cXbQF94F0WVkk7BFyc3mgX1EYrQ33QqdP5m/RhZgbx//DZ8qpDHHl8i
         Lm45d5Bv3MkKC1awjRxzYrogY8av99bOlkBcRuGD24nNU6XUtEGvfowlaEiAQnaIF+TD
         uQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787805961; x=1788410761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sEzr0jYee/fARbmWPhLxuBfGYBmn4khYyL4pUGs2CjQ=;
        b=Rm/ak8EiJmj2fOyGGgsp1LFBG9d7SWzAZUpM8l5bKmKKiizT9++chv+F45rOPYiSCU
         duiXqr7gFmnCgmPQYL8V+TRe+sXFS5qjh9S/IkXXgg74sn2L+yD2po4vUwVEocOeNFpK
         ZKrkuogc0K4KFvRh+nfgkrOtXLIGIJDww/fjNIL6w/GqGUg+34cxFdWSrrNSb3ehMRW4
         StwcGRVrlXLcwmrObfXbQbAa5ZdsOXtYiWsqC4RPpDFPS/6Jyjqs8ULyu2BvfSeKCuOM
         eKMkLfLvwWSGDxilJvl+RGhIm9jU2sqcMQ2/lkwdvo/GyrzqyoFLvDSzo8iMCTZInCe3
         Ju6A==
X-Gm-Message-State: AFuF++mqPhz6ejJYWodld3xVUmjwQdjuiv4edZUIA+4CPHS4jvVzUzIh
	hz59iA5pbS9zcxBThgWd0n8yN+Z83kORKQAvYj8PtUv2CfpAwR8jG/E2
X-Gm-Gg: AR+sD12jYIDkZP1F4OrEv6dJQnrsEV/emfpeKoTjyOycdHfQHyMx3Zo0SWCYKeYt2XS
	/QzKZaSUeTjag2FECoVJXpDHNUg3Gk6pgZ8sCittKibMVm/hgsKSlGhn+a/z4IUX3BsZTOwk69j
	lMCOIOcOYz5YZBHUGtOyx/1dUasjl7ZudmdMShawhiAZsRH9vANm4JsEBb81onSnoDFyTzRbzwl
	ZcWo3BVAqZt6keUqH1HLaqv1EpEyFi2EiaSo+5MeS9cBhKm+mlBjca5iBc3xP2vbq09B9ToC9IP
	Y7O+zuw5GQM7qWIfnsNEEjovxujQTV4hNqFm9uohrLYCu40u421LXXOkCbcYvA6oFP/rcygy/6f
	bCkv8EQlyYNQbioFBwfEtwlrrkkpxlbfmarYDRPbVArRmbCmdGdIlQYqjzKvBFdD/VbzysSTZB9
	1Sy8YLviyXAnSSs6vzpt/TplJAdo19Uk2ElVzP8e9q2KKAxGc5jO0jwLnh6QkLAl7VUXN8wh5tk
	JH6yEs28wY=
X-Received: by 2002:a17:903:320e:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2d707beaf8fmr248904825ad.12.1787805960656;
        Wed, 26 Aug 2026 21:46:00 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3285a5f96efsm2270583eec.11.2026.08.26.21.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:46:00 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] KVM: selftests: Add a helper to read a vCPU's APIC ID
Date: Thu, 27 Aug 2026 10:15:33 +0530
Message-ID: <20260827044534.2900285-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260827044534.2900285-1-hemanth.selam@gmail.com>
References: <20260827044534.2900285-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading a vCPU's APIC ID from the host means open coding KVM_GET_LAPIC and
picking the field out of the register block, which several tests already
do.  Add a helper next to the other APIC definitions so that a test that
needs to target a vCPU, e.g. to send it an IPI, can just ask for its ID.

Handle both APIC modes, since where KVM reports the ID depends on the mode
and, for x2APIC, on whether userspace enabled KVM_X2APIC_API_USE_32BIT_IDS:
read APIC_ID for xAPIC, where the guest can rename itself, and use the vCPU
ID for x2APIC, which KVM keeps equal to it.

Assisted-by: Cursor:claude-opus-5

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 .../testing/selftests/kvm/include/x86/apic.h  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index 31887bdc3d6c..df8815bd57af 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -79,6 +79,26 @@ void apic_disable(void);
 void xapic_enable(void);
 void x2apic_enable(void);
 
+/*
+ * Reads the APIC ID of a vCPU from the host, e.g. to target an IPI at it.
+ *
+ * In xAPIC mode the guest can change its own ID, so read it back from KVM,
+ * where it lives in bits 31:24 of APIC_ID.  In x2APIC mode KVM ties the ID to
+ * the vCPU ID, and reports it in APIC_ID either as-is or shifted left by 24
+ * depending on KVM_X2APIC_API_USE_32BIT_IDS, so use the vCPU ID instead of
+ * having to know which format the VM opted into.
+ */
+static inline u32 vcpu_get_apic_id(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic_state lapic;
+
+	if (vcpu_get_msr(vcpu, MSR_IA32_APICBASE) & MSR_IA32_APICBASE_EXTD)
+		return vcpu->id;
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic);
+	return GET_APIC_ID_FIELD(*(u32 *)&lapic.regs[APIC_ID]);
+}
+
 static inline u32 get_bsp_flag(void)
 {
 	return rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_BSP;
-- 
2.43.7

