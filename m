Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099D3EBF17
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174272; cv=none; b=gTr1vc9xAeluZL7HpYwmVioN4sl2OyZePzgvqZ+VYxBpqCFlr1u+llgrBVl4ALPTupQgh6O6q83oismHpyJ8qIgx5R9Tn3NmqwTEAhiTwNaEpLYrMVpBaFChPBQBZnna5Y0UJpZTVSQy0iQkSw2IpO9jAAaBCDJ0fdkrrQl2KIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174272; c=relaxed/simple;
	bh=nPf3/zpsXr0gYyMgLI8arjnB90SmOw4ukmzR/VbRl74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECOlPuj4K96KtHQ0Il9ZQ8FfFPpXLFbDwbG8UHy6J50S2aglU2S6ivz/pSBXxG2wLB4OzcHdT1riVp+z2trbYvml7EBBt7Ntepxr9R8n8lJERanvFhbfSFmzR0IgZc6dp44Snkgc80On97AUmu4MvSPR9Or2MsfWIPwLF3IPt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJhNgH1e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9bmNLd2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJhNgH1e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9bmNLd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7UyBjZ3bFL2zCPRfYGX2fdYuZKgz++d8DEbJHushfs=;
	b=dJhNgH1eO/RLrihlWXOu2xztnwUcCQtTPdahHSJdx9Zxv5JwQJPzbwbnHZ0H4vfiuM7Vcp
	5LumYYseKKzix1DPgNraWXh3SQ+/YXkIOtDy9YSo9yeGaznXjebGsQKcJXwaNEwQVY3M/e
	hTxZuhQG7IJ8+HyS0JDY5gQZXmGXTHE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-8gmJYn84MuiXmNl4cbSvYg-1; Tue, 10 Mar 2026 16:24:28 -0400
X-MC-Unique: 8gmJYn84MuiXmNl4cbSvYg-1
X-Mimecast-MFC-AGG-ID: 8gmJYn84MuiXmNl4cbSvYg_1773174268
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso29719385e9.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174267; x=1773779067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7UyBjZ3bFL2zCPRfYGX2fdYuZKgz++d8DEbJHushfs=;
        b=Q9bmNLd2IBDv/5GEckxB+iJYSWWzINQSiqxY8UTrty9YABwd3ulx8mU34AfhetJ8RG
         G4H3MFCBpHwblNgxRKhF2ra8/qQKUqJzrWv2Q2vxsvDX0xh03Op1lQcYb/GFs7O0k9og
         cjqrK+Ffj7itkCv69rhkAOklhOILHRHIYQJENAofOcgKfBpRH07234fcN97Xui/fE3A7
         E59H360puc6UoAIKeneW9j08Ks0OcYATGBsVFTODMvY8CHOLknh0FXkO0JVeGtHEbjKc
         GHzHZ0jranLq3GauD9yNJvmWvg0eLMFWozD7Bs/vjm1GHdar8sByJZhqEM1AvTEih5cm
         XeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174267; x=1773779067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A7UyBjZ3bFL2zCPRfYGX2fdYuZKgz++d8DEbJHushfs=;
        b=iv3kXFddi6h9qSigncFqjXmMHTX2laL4u8P2TkAGoPb5uHSg3zsGs/lPzlzo/zRkih
         /LXc6wB9O+nv+mCDxG7Iu42L/SVtX/DNC0VMypSUBxUP03500m4y+swu5fPp7wwmDzDL
         p/XVI6+nfB5tCMYZ6CzWc1Nq5JHFuJYic0NsrhVfIxwgLb30D0fXX9MAiFvJrWxFWnm+
         riHGj06NhmDcg14EvHHNJZyY2Ioby6RC0n5RClF8Sbl8eNPkIhXK8B4MYeKTCKfpk+hf
         nsKRiqR8hjsnXSbqacEGgileGGS05SEUxn78djDR3FgeAPjX+r6w/QXLRixYXz/ZM2iC
         xs4A==
X-Forwarded-Encrypted: i=1; AJvYcCUrOsccIwlwTMf/YZYMNrvlgMdbxePydW7qgXD17RFCs4SZov6WCWsWrEZAoC2P+e7RM/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqy6WD0UcyLO+f+szIdFG1mLzX9q690rk2BdUJ33g7UYolG15
	Ct3XAieQUVDWqQW6sUsbogv7thXSwhkxzsbjeDY36laHJgtJXmweFUd49RypWhrkYcVBnWjcRXg
	HkE0LCOWho4REuyK6gzrHeSNiWR06NjVf0ctnH7Od4+7ovaRJLXVFDg==
X-Gm-Gg: ATEYQzydpIh66f8Y3LqxtSbSDH4G9OQI4dWtIp3FbiqZF7VkQh7DksEQrYGbnuDkYD9
	8r9lhTEB5h4mXTOwGLCIl1uunkZ2JayoD/PduL7957sSGvM2Bj69xIwKkURdH59JZZOFfkGtaSN
	1sLIZQdlYPrXZSoXd2bo+s7DT7HncZO6+WpXSuPBSMv/MHiLepUfCcQwsqE+PdXopXqfdBkkNpV
	7pV9f/Rmmft2Xtm3AUC4e7PVDFWJQVeydaRROsaEzGz2B37PpEu/KyMkeUBZUOiyHhivcRbWlmM
	tFWDGPUn2CxBa8f21thnEV7vgR+FSZdT2Y7Vmn9GEsPIwG+Iyldc1lijqvTCKmC7SIcUym2VbFL
	IC8ipJ3Z2Qs95TFi3YmndU222sKd2nOqbKUGk61SV0kotveRlPSFBGupOqZZSeBWqDsu8NkTy08
	r2pf8xpAnstXHnZxIESAdy/pizoXE=
X-Received: by 2002:a05:600c:8012:b0:485:2fc5:3b0 with SMTP id 5b1f17b1804b1-4854b145662mr1316475e9.27.1773174267569;
        Tue, 10 Mar 2026 13:24:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8012:b0:485:2fc5:3b0 with SMTP id 5b1f17b1804b1-4854b145662mr1316145e9.27.1773174267166;
        Tue, 10 Mar 2026 13:24:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a9e549sm102081565e9.12.2026.03.10.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com
Subject: [PATCH 5/5] KVM: x86: clarify leave_smm() return value
Date: Tue, 10 Mar 2026 21:24:14 +0100
Message-ID: <20260310202414.406078-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310202414.406078-1-pbonzini@redhat.com>
References: <20260310202414.406078-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of vmx_leave_smm() is unrelated from that of
nested_vmx_enter_non_root_mode().  Check explicitly for success
(which happens to be 0) and return 1 just like everywhere
else in vmx_leave_smm().

Likewise, in svm_leave_smm() return 0/1 instead of the 0/1/-errno
returned by enter_svm_guest_mode().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 95495048902c..82e1d5526979 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4894,11 +4894,11 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (nested_svm_check_cached_vmcb12(vcpu) < 0)
 		goto unmap_save;
 
-	ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, vmcb12, false);
-
-	if (ret)
+	if (enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa,
+				 vmcb12, false) != 0)
 		goto unmap_save;
 
+	ret = 0;
 	svm->nested.nested_run_pending = 1;
 
 unmap_save:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e9fa59e92548..21838900f14b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8545,8 +8545,8 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 			return 1;
 
 		ret = nested_vmx_enter_non_root_mode(vcpu, false);
-		if (ret)
-			return ret;
+		if (ret != NVMX_VMENTRY_SUCCESS)
+			return 1;
 
 		vmx->nested.nested_run_pending = 1;
 		vmx->nested.smm.guest_mode = false;
-- 
2.53.0

