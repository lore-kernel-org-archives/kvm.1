Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2051E450
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803283; cv=none; b=dYgl0kCyW0prlY6ySoyGyYxmy3BgkTRe8BihcEuxV7q+TVsYtKx5vh/oE8B9s2sOoI/KJ70uILwAreYhk4rJcW2lNxJcBOrkv4UKfax8r/AZg7GXH1eciGA+XFwgrHSIKo/4vH9n8JKWhMc0/8vcKV9H/eaOPovRjrqeQPeGPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803283; c=relaxed/simple;
	bh=cUym6SM1y+xizCOvVF9uybn+IfnD1Er8+S7CeF88iLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYInnTRslUG5JSFF42pPX8w0aG3RUJvXV6kNZbiUUH1T1YrtJ3nycrXjZn/n14FCmHry1JOD+ZdhnLACqtO3pn7EUXlOKTHKf8Pqv37YAq35kH0fbkec/rkXMTWNCS8xb9PXrkU1MKA36Igw7BSy1dxHHTtYVwtMfzpUFV/KxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGdeNSYq; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGdeNSYq"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2e0bc619fso10854835ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803282; x=1791408082; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nCYSwZa2d4aSXke3tgGXEEYPihdbNPRRzkkGchqKWVs=;
        b=EGdeNSYq1dhFotAEwkdQxcaRf4RtHWl0fdM+qN/VKNlOoiKmddV9eI9gzxCkwJFyse
         bScvZI4tn77CCt0FMtjxDr0FHTzNwTgS9DOvgP2ldI/GDuudjNnHSgGe2t13v1oTZGa/
         bBtl+QqvLv3ApwvYLO2sQ3rCmA8yx1Jlb8cFOa63bXUqqCT/Z4ZtWjFaq1YuVcDTn4/P
         CjGXPKm+RL6R9z1m+p8MCSAMimK83wQy4kuEI38yKYj28SEZQzwD0gjWqoXKLNHMRp37
         XJTFxVdvqZ8DWHqyr3E9fA2RGfR9T5A1UpTytEnjk0befCmhfMIlKCrBg02T07KMSBhA
         ZD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803282; x=1791408082;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nCYSwZa2d4aSXke3tgGXEEYPihdbNPRRzkkGchqKWVs=;
        b=Br61X6Q/ueYRf3NXywgmYGp4v5chIKhRIPomyvdoc/VE6woMExHvVM1VjQ+eseiWoC
         N9r1qWehbSky1c8cq8cBm6tup40gDJtZV6Sh/ge0N1/unpgmZKmivWDiUEUf+hr/tZP0
         74pCcf76XmJO18TZmVNm//n5daBSP1JXn2S9rF9dZ/YYNsuVBe/kMYIzjrqSCq97Wmi4
         AV0vo8NXDqMo04hfXtuEJQ7ZinKq/SJKNlAi4Xgad4Dck3iCwbxFWWx81DiuR2E6s82y
         3+oYdhjU9tlDC7ayOVuhl4OiuAIclFlR0W1M7WSZIlujMWELWD/0HlhaTGJlFRjHWFVo
         EteA==
X-Gm-Message-State: AFq9FYKH7PVUjeGTZK+tbmvlE9nAqp9pa43tFSm9RjoVyA45ANl7fwYW
	gMJKbU9GZ6RMZe0cgtIRzC0Ka38YspDAH88+7c+EJU90PVf30KMFWc7s3Egrq5m21sEy+wTgHLF
	X/Llgng==
X-Received: from pljg24.prod.google.com ([2002:a17:902:fe18:b0:2e1:2a71:d15b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:2dd:ad74:ac2e
 with SMTP id d9443c01a7336-2e2e4a27af9mr20060035ad.23.1790803281439; Wed, 30
 Sep 2026 14:21:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 14:21:13 -0700
In-Reply-To: <20260930212114.3500045-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930212114.3500045-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930212114.3500045-5-seanjc@google.com>
Subject: [PATCH v4 4/5] KVM: selftests: Add module param API to check if
 nested virtualization is enabled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an API to check if the nested virtualization module param is enabled,
e.g. so that tests can verify KVM's own enumeration of the corresponding
CPU feature.  Provide a big warning above the API to make it as obvious as
possible clear that tests should use "kvm_cpu_has(X86_FEATURE_VMX) ||
kvm_cpu_has(X86_FEATURE_SVM)" when checking for nested virtualization.  It
doesn't really matter which method tests use, as KVM is supposed to keep
"nested" synchronized with VMX/SVM enumeration, but make the comment super
scary to try and prevent KVM selftests from having two different ways of
doing the same thing.

Note, the bool vs. int mess is intentional, because KVM's params are
terrible.  kvm_amd.ko provides an "int", while kvm_intel.ko provides a
"bool".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..3d3a7d9f2a95 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1472,6 +1472,19 @@ static inline bool kvm_is_lbrv_enabled(void)
 	return !!get_kvm_amd_param_integer("lbrv");
 }
 
+/*
+ * Do NOT use this to check for nVMX or nSVM support.  Querying kvm_cpu_has()
+ * for either of X86_FEATURE_{VMX,SVM} is the idiomatic way to check for nested
+ * virtualization support.  Use this *only* to validate KVM's own enumeration.
+ */
+static inline bool kvm_is_nested_virtualization_enabled(void)
+{
+	if (host_cpu_is_intel)
+		return get_kvm_intel_param_bool("nested");
+
+	return get_kvm_amd_param_integer("nested");
+}
+
 u64 *vm_get_pte(struct kvm_vm *vm, gva_t gva);
 
 u64 kvm_hypercall(u64 nr, u64 a0, u64 a1, u64 a2, u64 a3);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

