Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160738D6B3
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177526; cv=none; b=ERIxJIw/de6yzKxinIQQubn4zh84Z121qMIo1Zh2O5499+DWgl0B3Tq8mZMw0HZ6NPMEFi7G0904I5nubALLv7rmntOHvWghKeqfeLsTY7omu/VPJ0hGmemJXldjo239LrN2H8FmtBCtjC6TaT2IfAbPfy8kqT8S4yOlIdIYSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177526; c=relaxed/simple;
	bh=lXoyEpibePIMwN7X8+UZ8Xzd0ZU8KaHfUstvDxz/4HA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bqm86YrF18Wv6wRj1zH2sFdOCQc4dnmrVo/ZtPYXhrJWBtrzy1KkP5cY7aDc7seANGYlA2ZfaYaz51vtHX+kjylipLwMNj3iavGl5VtGTm5mcRSSWThD8Yx1Zw1wpYNzA/lyXkAKfXGjyr4Phq3O/i/sNCibMzPo5Z0gGonUZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYaKCPBl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYaKCPBl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e9577ceso487352585ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773177524; x=1773782324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ/NCAm6P1x5beG5L23G1Uyw+WvXuMXJ331NsI7Ka2w=;
        b=LYaKCPBlkhKyVMPapldS9FV6Q891+YO5jSp9GPPJujKB+5v4oijWy77OF8DwqknArF
         HeHWm7daUDWnfm7CntSB9hJNB6F/aD1rpONWIMybdM9ChgnSUYOWh86GA94TgTB9GfrT
         yP+iZYBBhKhUecY8iA+PN155rqvHPHAeqISrHglJ1jpmbsZ4BRv1m3/9PPeg71nkuy53
         M1qWMJmwRUSd1nS+TY+UXjOzRj/LEzNVB1E4/dQnJpSY6M97/xW7Dx6sefDzQKcj52fC
         FKyVmukMf8e/QIJMyAvlwcXxECXhjGPAsuHZ+XF2dIx/BPmQAGs/UAU31TwnT/9UGgjb
         5/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177524; x=1773782324;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ/NCAm6P1x5beG5L23G1Uyw+WvXuMXJ331NsI7Ka2w=;
        b=YoWpqJ6tezX7tZouYS5NSUDI0PkY/bwgeXxeZ7ptXKJPUo9+tpSDBb/LY5Xo6wYaoo
         kj2VWbXIPQPv/Tx+BBOD2zwS+bdetlQyWYUcgJ1wdXXLL70/DTSLWhqCeybJiF9zhvtC
         agJ72cyx2ppJJPlFLGSQo9snf+DeLoGkxb7CN1d2/ZAv68jsZVFocjVmIQPryE0tSGny
         /t6qwiBOukqxnAlfsUfkdZ5ZtkZ6TTuZoLxoSgugZdW5WpJjq9SxyqUBPhwKVZxKChCt
         /7z22XZdL3VphYF3vLLWxue193Q0Q0hO6iUcMVq5sAB2KIsQ+PnO4yuSbPFfD3Zmrsr+
         EJ8Q==
X-Gm-Message-State: AOJu0Yw+msErqXyHCRANmWiAGqiSR3r/Xaq3kXuvzq37+zCRDEID0R5y
	TozdyW6S9r+mk1F9277mbV8JBfZRT6bAF5JykBIlwCED4Jx7WUSJqktWBdfhsY1JiRg7ZHgS47E
	UQyHsqA==
X-Received: from plmm19.prod.google.com ([2002:a17:902:c453:b0:2ae:4964:6fe2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8d:b0:2aa:d67b:ef96
 with SMTP id d9443c01a7336-2aeae85b0cbmr1783765ad.31.1773177524108; Tue, 10
 Mar 2026 14:18:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 14:18:39 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310211841.2552361-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: SEV: Fix a CR8 intercept goof with SEV-ES guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srikanth Aithal <sraithal@amd.com>, Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a recently introduced bug where KVM incorrectly enables CR8 write
interception when inhibiting AVIC for SEV-ES guests, and extend the SEV+
smoke selftest to guard against similar goofs in the future.

Sean Christopherson (2):
  KVM: SEV: Don't set CR8 write intercept when disabling AVIC for SEV-ES
    guests
  KVM: selftests: Verify SEV+ guests can read and write EFER, CR0, CR4,
    and CR8

 arch/x86/kvm/svm/avic.c                       |  3 +-
 .../selftests/kvm/include/x86/processor.h     | 23 ++++++++++++++
 .../selftests/kvm/x86/sev_smoke_test.c        | 30 +++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)


base-commit: 3271085a7f1030ba9897cab60452acd370423ff1
-- 
2.53.0.473.g4a7958ca14-goog

