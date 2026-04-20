Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE93CF05F
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720027; cv=none; b=uHDNjPgLX4ZquLMMJ8h7ZpXO7+v6BXFNb8POEwiK3q2TEe9kApqdQfFJuecRw3A11Lji9+3WG/BkLCMDjgfdtHyj31N8QBq3aM1/MiehS3gXCZKnmYK27k8eQgTxZJSmGdU72GJX0prK+tqwSWjL6rxDAGtH+cjSarVU7afInEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720027; c=relaxed/simple;
	bh=R4RRKP6Jjw+CLrer43S+NrH1h/WG+T88j7VztPPNMaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ta5ayhvcI7JnMocjUxT+eH+KI/xgk00RIkyMziDG/W1VIQ+HYuFvep0RP9Loi+CRw2kh4FKlmhSj9yZr0oqYEJHUzWYCKQu4sN8CtvJbWLISLwljlEKHIs/rGQPepiD2Ji+llZDMwIBN8evaifZlT6aQncR01U3hnXkpKmXNQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpYZKkRV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpYZKkRV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so4688665b3a.2
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776720023; x=1777324823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=U5TkYNL94NKu0U/OFCNswNWigEfxOEAkzVOSoJlSIOI=;
        b=CpYZKkRVqE2Cv4cBdiDGsizayBsEKxd14kJij1o+0vuhVXcvFEM96cZxrX5lnsnmYf
         Bh126Z30AZ2W66MoZ9R4B8KRA4JnJT+uW8reF+q4kSRVzm/WguXbVI2hJf614NmpPAfN
         fG/x528kxuvUr85f6aPN4rt1Khe5NUgvB4Ta/ba7y+tGMk2B4s+2CeVUUsOlehERpKWY
         10f7GX200CRPI9T7CZyukS3LlvxE/QbzDQv0Rz7wx4oXIE72Gh/2XvlwF3S3wT/QkrzI
         MsFFncRLOxwekwHVHNtk5ubJCR/YHzMeCe/hPiuRtfo9NtKq4umLGJ6W7Xm8eS/kwV6d
         eYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720023; x=1777324823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5TkYNL94NKu0U/OFCNswNWigEfxOEAkzVOSoJlSIOI=;
        b=ejVfVkQMftfgvHh762YIhYDxRz8zcY1wb1M8gjVEzaxHn242pX/e8doVQcJ0a7wgNk
         mndFpbWyHoK5Oxh3+JfrVKsTAbGK5+cd/psS7rkoM1R+BZx7Yl0+HNYDoZXS0Y40Dy7b
         ShMHPiliYQE+NBGEKx3TGQ9oALZGAiqehHbDAoNkVYG/djw0jRF2e4BWF8+p0E52cT4G
         hFaclQAN0e/YiYR2I0/mHfZ54ICYPTnda7eIRfv+JA1/rmNlvw+OkkcHE49UeCZV/d+q
         mCCpAhEIg38T8a/eAgMetJ1YgsTY25XCLrebd8NwUHMsEAmdYeMl/tRebgZxeVKrq4qI
         c+dA==
X-Gm-Message-State: AOJu0Yx6Jr4gddBjr0HbX3mQS7LU7NcTXnZ0rGZGTfX6TtwhiHYB6OZQ
	vqhUslss2cpJDL4rLxehF4qw6v8kZjpdvQ5DmfvvBXpq96IvKooKnhUJrlCpdHlMVj57vvDmE9x
	2Hhz/pA==
X-Received: from pfve12.prod.google.com ([2002:a05:6a00:1a8c:b0:82f:6a57:a9aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc7:b0:82f:5051:f024
 with SMTP id d2e1a72fcca58-82f8c8ca07fmr16761487b3a.27.1776720023205; Mon, 20
 Apr 2026 14:20:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 Apr 2026 14:19:54 -0700
In-Reply-To: <20260420212004.3938325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420212004.3938325-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420212004.3938325-10-seanjc@google.com>
Subject: [PATCH v3 09/19] KVM: selftests: Use s16 instead of int16_t
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Use s16 instead of int16_t to make the KVM selftests code more concise
and more similar to the kernel (since selftests are primarily developed
by kernel developers).

This commit was generated with the following command:

  git ls-files tools/testing/selftests/kvm | xargs sed -i 's/int16_t/s16/g'

Then by manually adjusting whitespace to make checkpatch.pl happy.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/guest_sprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/guest_sprintf.c b/tools/testing/selftests/kvm/lib/guest_sprintf.c
index 8d60aa81e27e..2a3ab9c168f0 100644
--- a/tools/testing/selftests/kvm/lib/guest_sprintf.c
+++ b/tools/testing/selftests/kvm/lib/guest_sprintf.c
@@ -288,7 +288,7 @@ int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args)
 		else if (qualifier == 'h') {
 			num = (u16)va_arg(args, int);
 			if (flags & SIGN)
-				num = (int16_t)num;
+				num = (s16)num;
 		} else if (flags & SIGN)
 			num = va_arg(args, int);
 		else
-- 
2.54.0.rc1.555.g9c883467ad-goog

