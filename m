Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8C15665C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727225; cv=none; b=E0irCOVSgFf40ZUqC6H2bvcpRcwsmxpb4LqqXQzddAvtekMcZCB8IWncMjXjWTtKVqgKBpK2aNO3WzNYCYB8Ifhd0lFq2tfqaa7DrJlLrshWF+4yZrQVmqDBJEbbZPp9+VhzXvkecZHocYKuAozhiUJUmXw79dmv8vfyQgmG1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727225; c=relaxed/simple;
	bh=m5ij7H+WOu3d+FdzUMjV0W5SB172f9eg+/qElhh79/U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BJElebvGC9MTFYZ3rlXvZ96crrZnqmJqMy4PliJIHTD79zc0jYeOlNhz5170zmdm/5S5WIVIAzD8nPXPf7nCwpIZOnks3chPFB+z16ubqeNLFeNp0eFoUKl2SHz0Cd4HUOFHK75NtpQAVKCADUWxIH1P6NMi9iJVaAbDOZB9a3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RskAZc32; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RskAZc32"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df7bc60df6so37091095ad.3
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790727223; x=1791332023; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T0OAgQm7l6+Lkk59NFimwNySx+EGaZwacAEZ61B6wks=;
        b=RskAZc32n6MhdOkV1Fc72AQBzMLtcXl05rsCkXeAR8t5uoMQZVEd/KTPN9AofKG++P
         baYjaKBHE1lwFiHtP+o9lrLAzRLqRF2y8wwOuQwZEP3GnQB04ExWf8HpfS178h7ML1Xy
         YC6iKSbfv3mQ14CS4GzSaWmz2pypgLNXroWd3zHw1PeAmi/eGCxwZZ2KLeDjdKb0D/sv
         gTtgNPjVQ3NAubkD1FyY3hoc68LgxU9RiglE9gvNY+owDKMuGSF0uwnC891BNI9GU2tp
         sV/66F36vTfqnsAeC1D3a3bK67aPiw7spAVSGzJLwN6k9RAkeCweTY61KSZyYS2yKTIl
         otVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727223; x=1791332023;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T0OAgQm7l6+Lkk59NFimwNySx+EGaZwacAEZ61B6wks=;
        b=sknGJ+KFHOCo4LJyl8pGHApntobpgYzoFjemGjroG6OfDZ9EktgZSl6nw8Nb8XeG1g
         ALB9+aKZ3KjrSvAuG0deNMiwN0nR3//D4Fju9+EUCD8NL27EnPpqiOu0HTjWWLYWriiz
         rb4WIAUsd7S55vzh3LvImZk6BsFOAmW/oMdKnoU+YUAcnVeqEtWeP5NwDfnZjwOVqCJD
         6NVbFpLfx8K2YvHfB/z9NP4tNDRg24YFPYhX35O7WLMi2+5cg9SmRA9Lpv3NOyIlQdPU
         O3Oh9vmxwZvaWac4uS14h8XCVgmNgXyy8vZu3sKHwNdDIO8F+qNJpJHQ1tqMWUe1CVXD
         C2fw==
X-Forwarded-Encrypted: i=1; AKwUvBwXs6Vg34GQ3oeCUzlBh3/zZaP51NDnu6NvmUWPzeX/cke7GTFUKLx2Qm4bHvelsKcyA9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5MQfcV2I9dwQE5oU0pzeZGI0mOgImBiXcn5qGZVfNoDe9qgKO
	9PjzuyhNCSyL+a57TUNTGalUgb+D2mK04+hTAjUJ3MZfKfAgJItcpcYTP4gopJx2zVOvOysh60d
	+ycEITg==
X-Received: from plem9.prod.google.com ([2002:a17:902:e409:b0:2e1:2414:b08c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d98f:b0:2df:a70b:2fae
 with SMTP id d9443c01a7336-2e2de52ea84mr5110035ad.29.1790727223042; Tue, 29
 Sep 2026 17:13:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 17:13:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930001341.3171558-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Make guest_snprintf() a macro and use it as appropriate
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gokul K <gokul02k@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Turn guest_snprintf() into a macro so that it can be used by variadic
functions, and use it in the ucall APIs instead of open coding the VA goo.

Note, using a macro drops the __printf() validation, but that's a non-issue
because in practice the caller will have its own validation, as is the case
with both ucall_assert() and ucall_fmt().

Reported-by: Gokul K <gokul02k@gmail.com>
Closes: https://lore.kernel.org/all/20260918113631.634233-4-gokul02k@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 12 +++++++++++-
 tools/testing/selftests/kvm/lib/guest_sprintf.c | 12 ------------
 tools/testing/selftests/kvm/lib/ucall_common.c  | 10 ++--------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3a432499b338..9ea5b8906dd4 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -238,7 +238,17 @@ static inline u32 atoi_non_negative(const char *name, const char *num_str)
 }
 
 int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
-__printf(3, 4) int guest_snprintf(char *buf, int n, const char *fmt, ...);
+
+#define guest_snprintf(__buf, __n, __fmt)		\
+({							\
+	va_list va;					\
+	int len;					\
+							\
+	va_start(va, __fmt);				\
+	len = guest_vsnprintf(__buf, __n, __fmt, va);	\
+	va_end(va);					\
+	len;						\
+})
 
 char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2), nonnull(1)));
 
diff --git a/tools/testing/selftests/kvm/lib/guest_sprintf.c b/tools/testing/selftests/kvm/lib/guest_sprintf.c
index 7a33965349a7..6caebb456f3d 100644
--- a/tools/testing/selftests/kvm/lib/guest_sprintf.c
+++ b/tools/testing/selftests/kvm/lib/guest_sprintf.c
@@ -300,15 +300,3 @@ int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args)
 	*str = '\0';
 	return str - buf;
 }
-
-int guest_snprintf(char *buf, int n, const char *fmt, ...)
-{
-	va_list va;
-	int len;
-
-	va_start(va, fmt);
-	len = guest_vsnprintf(buf, n, fmt, va);
-	va_end(va);
-
-	return len;
-}
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 029ce21f9f2f..e9df71197367 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -83,7 +83,6 @@ void ucall_assert(u64 cmd, const char *exp, const char *file,
 		  unsigned int line, const char *fmt, ...)
 {
 	struct ucall *uc;
-	va_list va;
 
 	uc = ucall_alloc();
 	uc->cmd = cmd;
@@ -92,9 +91,7 @@ void ucall_assert(u64 cmd, const char *exp, const char *file,
 	WRITE_ONCE(uc->args[GUEST_FILE], (u64)(file));
 	WRITE_ONCE(uc->args[GUEST_LINE], line);
 
-	va_start(va, fmt);
-	guest_vsnprintf(uc->buffer, UCALL_BUFFER_LEN, fmt, va);
-	va_end(va);
+	guest_snprintf(uc->buffer, UCALL_BUFFER_LEN, fmt);
 
 	ucall_arch_do_ucall((gva_t)uc->hva);
 
@@ -104,14 +101,11 @@ void ucall_assert(u64 cmd, const char *exp, const char *file,
 void ucall_fmt(u64 cmd, const char *fmt, ...)
 {
 	struct ucall *uc;
-	va_list va;
 
 	uc = ucall_alloc();
 	uc->cmd = cmd;
 
-	va_start(va, fmt);
-	guest_vsnprintf(uc->buffer, UCALL_BUFFER_LEN, fmt, va);
-	va_end(va);
+	guest_snprintf(uc->buffer, UCALL_BUFFER_LEN, fmt);
 
 	ucall_arch_do_ucall((gva_t)uc->hva);
 

base-commit: a0bc8e1d7a82bb143b8f8f44ae3a01938f37c2ea
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

