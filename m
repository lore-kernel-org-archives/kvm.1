Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441740;
	b=O7cxxEC2KqeTnhjbwJDMxzVSNBXQiKD3pM98Rcqjscz3aGplxtoNhZYX1LY6qYvRTFNR
	 +gperG//m0xh2ZP3VTlJZm0X8WWkl706ustUPXYLh/fA3RG6xhusi4MqGnGWQKeUzSpdg
	 q6QaJkKFAej725/0XMkX7B0JSWTX82RJXiXLs2C4jC5LcBrHv8Ecs3wDqOQiri/W4fAUC
	 3aRszYEJH+iEDdqUCsxIaxdOVG0vhYnhYmzQmg5Nu9C9B3vparzPOFM1jpneoWKHUl/rn
	 wP86ca24y8Gwylanp8Xw3J/lGgsSn7I7Ibn532U/KvBGBWTvDcpPD6ayp+mJV5nAxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Q+6J/DQ7IMd0v2V2aVaoHh1rHXWM0PUb0FqkcNSz188=;
	b=ewHNp5jkTcOEwgdeCh0VbPVBOLOvH0/DBWX6yheg48UtOj+xFEN6tplRloUa8PquAx4M
	 j/5qTV02U9ZFNN4Yl1BClN5tFYXKzkS3qQY1SEGUmQdXNkhyd5c+FLKLXicn0QAeEn27S
	 CTbBFanGKqvgZgc8waQCMFSQW3ESWj+CO+jRH9BfDtRStdO0XbMc1g2MUzvdgrDQaAzXf
	 UQmCKL+i/QmPX4sXBWWMPtTbhubm1Eg6Ijw4ozk9WDfvmFiHWv9vQt9iB/tpGBUQ8NoTo
	 jt7ZddPaGM/cW3rUocThYbBY8uJErLDuMcOQ3ZTEoWxJy9+0IM2SVhqMmeITPWh4OJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K2mivfA2;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E07606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E07606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K2mivfA2
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c734afb8deso4283964b6e.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794441739; x=1795046539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+6J/DQ7IMd0v2V2aVaoHh1rHXWM0PUb0FqkcNSz188=;
        b=K2mivfA29B3ATToRg+o0oa0LI0CShsYZov1CvZfuilRb6ISgP8hmq/lKS5I9YZui+M
         TlKq/B9cLkes7zFWE5iVKPeQ0bHU/EWmoM6MNuERHnrnKd+AKBdquNugH38PmpCWI4fa
         WkGWO5X1BXT+6kMonLfoUqQrFs6clhde1sGoaPxG3u4+J9T1+uY8wVPD45uZLtI3JJbK
         Cchrp93646GeeN5QWaIpGwDzHp0XtvczGPjBNWnQvkv0NyyNfzdSNG8Pv3u5C1hbhxq4
         Tu6jTxggl0hz5SElxOkeB60gzAu/IlXd3OrBpXIQysWNh4Z+u2AZof/WKI64sioeOrwM
         39UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794441739; x=1795046539;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+6J/DQ7IMd0v2V2aVaoHh1rHXWM0PUb0FqkcNSz188=;
        b=yZAC5AlYwqSd7ACdioU63+jl7CyakEIdaQYRJ0ftaFNlHQlK/MJ7UhToM/BvGssLs0
         3VWHhySoeVbyHCXsb+Sk/+IRaDqfcK5Zqd4dgK5fdTbf7LZ6bHoZgZKbXsjPqYAxE2TC
         Ar+ozDs14vMh205LNdWsvW796wfGsVE1GubBvWc7awtfeENYcb7A6sFntYTuN8VLC8fU
         we64Xo6hIKN8gfMjgqtZdIXXt+H7XKYIL5nWEr6189sBLYMuEsBicTLiVNLZgn/q9pqz
         j0Sm1839jxbHbWuWhS1aRbCXh9/KqNZpugY5XlYMrAjYxUzehb/u20CVjAezGfdDipXU
         GRgQ==
X-Forwarded-Encrypted: i=1; AL+hErFwmGwCzS1Mr6dVR/YO89NYNSSPay3hy9AM+g4+SHuu79DAoCujZQb+6/qJKlrhEqyS/Og=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AZ7pEHmKg2QF7xHt/bDZwHqaxqmAg1TdAlA0PmkUe8/N85dEL
	Sx2dRBVgO1mYS+fP5K7hfQ1NbOAfvr09WJxr9sdN6joQhAAOzanWSZvau4RfP77ijYsv99gd4wO
	YTDtZ9xKHYTdCGg==
X-Received: from iobjf8.prod.google.com ([2002:a05:6602:6488:b0:9cb:53d5:ffff])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:13c2:b0:4d5:295c:a82c with SMTP id 5614622812f47-56b9771892dmr4190007b6e.57.1794441739057;
 Wed, 11 Nov 2026 16:02:19 -0800 (PST)
Date: Wed, 11 Nov 2026 16:02:00 -0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112000200.3005587-1-jmattson@google.com>
Subject: [PATCH] KVM: nSVM: Mark VMCB_CET dirty on active VMCB in svm_set_msr()
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

In svm_set_msr(), writes to MSR_IA32_S_CET, MSR_IA32_INT_SSP_TAB, and
MSR_KVM_INTERNAL_GUEST_SSP update svm->vmcb->save.{s_cet,isst_addr,ssp}
(which resolves to vmcb02->save when in guest mode), but mark VMCB_CET
dirty on svm->vmcb01.ptr instead of svm->vmcb.

A stale VMCB_CET clean bit may result in the loss of those MSR updates.

Mark VMCB_CET dirty on svm->vmcb instead of svm->vmcb01.ptr.

Fixes: 48b2ec0d540c ("KVM: SVM: Emulate reads and writes to shadow stack MSRs")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..eab11fe50312 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3181,15 +3181,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		break;
 	case MSR_IA32_S_CET:
 		svm->vmcb->save.s_cet = data;
-		vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_CET);
+		vmcb_mark_dirty(svm->vmcb, VMCB_CET);
 		break;
 	case MSR_IA32_INT_SSP_TAB:
 		svm->vmcb->save.isst_addr = data;
-		vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_CET);
+		vmcb_mark_dirty(svm->vmcb, VMCB_CET);
 		break;
 	case MSR_KVM_INTERNAL_GUEST_SSP:
 		svm->vmcb->save.ssp = data;
-		vmcb_mark_dirty(svm->vmcb01.ptr, VMCB_CET);
+		vmcb_mark_dirty(svm->vmcb, VMCB_CET);
 		break;
 	case MSR_TSC_AUX:
 		/*
-- 
2.56.0.567.gdb80ae8cd5-goog

