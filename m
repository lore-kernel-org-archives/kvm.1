Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793057F73D
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883501; cv=none; b=e3TBBmQdshK/vhG26ryQfTeq7Vo9yAzX3z3Vdia2HGK4CZLUBheQp6f0MHDpTm6wp4gLGiB7Q85LGQ6BDIp07XBGssW6lpLPw2Pgg7SltA5BqPoqQHsECE9pmdpXe8CLodsdMoHBOGIY0NlED80TKIKe7B+z7DiEw9x2k8FYg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883501; c=relaxed/simple;
	bh=PoIZefIYgemK9yZJ4YbXFzvrGW+3EnfGu14JP84JhVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lE1yYJmqR14/WT3SXhvoMHzlimfm0v/+2fzfbw2BLnm+GGLQm1ELKwKAfXZ2RF8ZWrNTJxnN2Z90R5dOCtfrFbEfodnMa4HuHdZnC4Vws7G9dURsdwI3rwR3vhnEHdcaZYM//AznQpwISfu57cnot8hoL+XUAfOQiE0a/GsWO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQh8aQiS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQh8aQiS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39682983a0fso5158658a91.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883498; x=1789488298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udEwa8n9rLXAHa2zU6AruMqakZJAsEvaZhfj1mlF4oU=;
        b=HQh8aQiS275IMskl2futVye8miZjnPRPVcRHRjpN4m5eJFvEwFl26e3iBdFbtw7MMf
         89fGFLmhqKrmoWEfTHIEBokyCNC6ZYFWPOUZ7i0y0ilBtHQxHE/jtsAdKMO2uCMBudrt
         0wOmWbYugf8iIoTg9tsVq0+UIX32zop3iRkM27MZ31xVpqwRyNoXmfR8y53SuQbdkO69
         vqrbFq9M6rEKiRPS+stKofqdU9sftr5kAs37PDINL7z93bs4gyI/BRtVGa2kUuefJ2ur
         13lEFjI6+nY1VCIig76dg/wMiymXN9RJyUxcS3+WVr5OvYGmTcNjnZAcVJFW+j4ISVDh
         QMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883498; x=1789488298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=udEwa8n9rLXAHa2zU6AruMqakZJAsEvaZhfj1mlF4oU=;
        b=Wt6E+rwIF2F/bmPFwXNzzcOCmnbGn3Lv+Afnk8MHIb4s5Vwr1AL8S5Lyo1dEg+S8pG
         NPWj0lekiJmELZ3pZzvubNobZDY/AtnTBy+iQvuBbzu5ghGsy3YopAGP6DQJt0ZmiILJ
         y+YP8nKmo2hRIuLOfI5LVBOhUWDm9d/395afyvBuIy/Ggc0NnFdZJHoRqTP1119R/8ic
         trJEJWhXjfVyCcvh7mbom5Cf+dQQR6i43M7Sp3ijSDwDOanaYO6En7jT6KdcdhLlNV1Q
         63Hh++MTPYrl6Wvz4ry2mx6pdCvCihXjEjOVQRzuO8fhaglMcU+rKiQeJYiBrf/RtXzY
         TZNg==
X-Forwarded-Encrypted: i=1; AKwUvBx0mODpPPQUHTehzzDCxmXiAMFyBPWHjA3VtaKxUS3C5lV6/L4/pPLpeE6woqx8oHaQhJc=@vger.kernel.org
X-Gm-Message-State: AFuF++np5W2zY5GeynUCviiSR/U0ACFHUNsudsF5M3yPoK8XueMPcvZO
	PnOEegP9JBRbi62BQuGy2Cqui4OgY12PHG330w+ZnafbYmDjsZsnuQDy
X-Gm-Gg: AYBFou25KJBoMo091el3srLeyD4qqiKT6HCHxIMjSrkIHZ6A+RB/gc7I2qP4kLet9dN
	ljD8rfgrSjgcXu//n/3rPoC2rbZ4h33GH+T8Sjku//KDAS20I+/ZnSW+pJe849xpc7gTwcl/W7b
	72qreLiSoSpfh0gRofm6sF2mVN51lFtARaU7jwPtuYZsySaqVZQKy+WrSFVUSJ7fG3O0CD2+Vas
	nwj+YgDIhfafiZGzCIvjqTov6+Pzeanjymhp1lMq5/0OXbS7Y4fhNUUOLjRGAH2hJavifnBVAFh
	0uPBUIhnGLzYX7kJf0menLRLo62FBN+mah+JUBb8AoIQt45d6fPqGYoQMTM4o+CO8p5GGcxBjJx
	CtY5nlT7GdRiZ5WLBtRHCFz9qb7sd+I8x8Z77T6RCfrWa6/d+54SNkBf8caUbDADubgbIVuDRQz
	tBO0PdjpbdXw1ek347ckX/gxdo6l99pYTjziZGEtwxHaXDxY+2agtAPDAoSLuLtur003DMr53VR
	Lsgc2ZOioH4
X-Received: by 2002:a17:90a:ec8d:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39b261002f5mr41870407a91.6.1788883497638;
        Tue, 08 Sep 2026 09:04:57 -0700 (PDT)
Received: from x1c ([2405:9800:b670:b64b:3ef4:ec38:7826:6c9b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33825669695sm14204525eec.3.2026.09.08.09.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:04:57 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	shuah@kernel.org
Cc: hpa@zytor.com,
	binbin.wu@linux.intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>
Subject: [PATCH v1 1/2] KVM: x86: Reject reserved CR8 bits in KVM_SET_SREGS
Date: Tue,  8 Sep 2026 23:04:25 +0700
Message-ID: <20260908160426.6547-2-tharitt97@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160426.6547-1-tharitt97@gmail.com>
References: <20260908160426.6547-1-tharitt97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_is_valid_sregs() validates the incoming CR0, CR4, and efer values but
never checks CR8.

When userspace passes a CR8 value with any of the
reserved bits [63:4] set, __set_sregs_common() forwards it to
kvm_set_cr8(), which rejects the reserved bits and returns early. That
return value is not checked, so the ioctl reports success while the
requested value is silently dropped. A subsequent KVM_GET_SREGS then
returns a CR8 different from the one userspace believed it had written.

Factor the reserved-bit check out into kvm_is_valid_cr8() and use it both
in kvm_set_cr8() and in kvm_is_valid_sregs().

Fixes: 2f5bb3fe5835 ("KVM: x86: Move the bulk of register specific code from x86.c to regs.c")
Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
 arch/x86/kvm/regs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 8f66438989e4..fad31b59c622 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -440,9 +440,14 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_set_cr4);
 
+static bool kvm_is_valid_cr8(unsigned long cr8)
+{
+	return !(cr8 & CR8_RESERVED_BITS);
+}
+
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8)
 {
-	if (cr8 & CR8_RESERVED_BITS)
+	if (!kvm_is_valid_cr8(cr8))
 		return 1;
 	if (lapic_in_kernel(vcpu))
 		kvm_lapic_set_tpr(vcpu, cr8);
@@ -565,6 +570,7 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 
 	return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
 	       kvm_is_valid_cr0(vcpu, sregs->cr0) &&
+	       kvm_is_valid_cr8(sregs->cr8) &&
 	       kvm_valid_efer(vcpu, sregs->efer);
 }
 
-- 
2.53.0

