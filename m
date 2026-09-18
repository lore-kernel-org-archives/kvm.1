Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8F5111A9
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747522; cv=none; b=eYVFeKXw1EOtVeohdAwcax+6j+P/zRRgzqUpYjmCC+azoPR5Ol7mUCXOEae1Q3njg/JwFFCXhqmgNinSJv2WTw/pnqG8sOrCWlBClV+28uqwblQuWZ0vxmEJnRzXzB7Ga8wIE/S5GBPlgJolzpoYu//90dcBxlpfg/1wRumuQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747522; c=relaxed/simple;
	bh=cOI0RAoQy97P9npu9EIGH+tMQjJx1JRj7SjKcDInChM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JRr0/u6x1mWspR6T8eQEzs0WuLBcrrXR5NsdEuz4TN/TI68ciR+qE6IFJuyvoUeYmi5pWrSlGpY/E06KXvYNeiPm5mU8PFryjXiJdA4XfXQTRTC74eRi6wx+2BX2MX/MPHhjwDgLXdMW9NV0zKJYfJwBVnzH6rIizXoODq9ped0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfmZiCY7; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfmZiCY7"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85602449126so1854062b3a.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789747519; x=1790352319; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unXnQHfl7O6IYkwSNLEzXDjPIDBkaOiWJaYXq+gOmlg=;
        b=QfmZiCY7wXf/qMX9UWDVvR8M3tu06JXOIlJfGRVPQSu9Le02rWdNEryETXFf4MCiag
         NBDAChqT6xWUT5qI+2Gd0GjwstpFClmNFr+XCqakqzo+10JcWds/PukZs5l07OMdG3J4
         T4TGbX/QlxCui1xj4s0mmw6tjoH0onI5/lbgvx640/F4ks8Q1zNbC5rEgl8CPl9yLMNq
         EVVycmUG11oUV4HTApx3jt5DAuPONbRwv/mtfxbHYaVIt8zILKnOkNJo5x4xrMnnHYli
         2Rb2yhQ0qyMqkFPc65B5ZSiMkbjJUUxKsKTkDK/s+WEGntw4edHrhYN6Ck86HQ3IJh6K
         Q0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789747519; x=1790352319;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unXnQHfl7O6IYkwSNLEzXDjPIDBkaOiWJaYXq+gOmlg=;
        b=GtMbQXJxGb33TbN8r7ZImrqq+eyhmDN6MysYQyzPfMs4ihhG+Ub/GaC62ys5k6DNYz
         qAIjwG6RxFc5Ny79Im6TrscZPnOdEtirHBiwNNJShrCTeY0VQ0bU+Uohx6LFU1AwTR9m
         b+JiVL/NR4HrlE05Ifxe1FxQatNHj1G5uJVSKiFH/PvGulzTshZtQQB+L1g6fikvW05a
         lOklmX1JQ56aqWNRnvvWe/W5W+JJC2NwkTZgMU2LvXpACAxgGYRuyvb9QBOyrPBOfz8U
         kkdIYknlmy/oba27iaxb/kmpFim4ngIlVCTovi+SO9Xcq0rnDfOymspGqcDumVXlmMOy
         a8nA==
X-Forwarded-Encrypted: i=1; AKwUvBzEPYLok5kLwcECA5aITLF2wi7I1TX8c27+TqD4KgCaurI0d0wEe3f60s8bnIPDgGyz/ok=@vger.kernel.org
X-Gm-Message-State: AFuF++mdbtlHi1Vdv1UZYp1ZSGHquHcZrMJp/NRDXhXI5f2BKagH9cf2
	01vfWSLfxk0Y5c9nPwFk5KCOqBYbJQzDsZtjiSgfTYyfNd4oXJlj/BHp3ORz80YKu+4IoKOfDkv
	88GYCog==
X-Received: from pfnn7.prod.google.com ([2002:a05:6a00:2b87:b0:871:1f86:b3d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94fb:b0:86a:59ca:6cb6
 with SMTP id d2e1a72fcca58-874ddff72a7mr6173681b3a.20.1789747519214; Fri, 18
 Sep 2026 09:05:19 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:05:18 -0700
In-Reply-To: <20260918113631.634233-4-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918113631.634233-1-gokul02k@gmail.com> <20260918113631.634233-4-gokul02k@gmail.com>
Message-ID: <aq1hPuxq2yIeflyH@google.com>
Subject: Re: [PATCH 3/3] KVM: selftests: Delete the unused guest_snprintf()
From: Sean Christopherson <seanjc@google.com>
To: Gokul K <gokul02k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Gokul K wrote:
> guest_snprintf() is a varargs wrapper around guest_vsnprintf() that nothing
> calls. Its declaration in test_util.h and its definition in
> lib/guest_sprintf.c are the only two mentions anywhere under
> tools/testing/selftests.
> 
> The rest of the family is alive: guest_vsnprintf() does the work and
> ucall_common.c calls it, so this deletes the wrapper and nothing else.
> 
> No functional change intended.
> 
> Signed-off-by: Gokul K <gokul02k@gmail.com>
> ---
>  tools/testing/selftests/kvm/include/test_util.h |  1 -
>  tools/testing/selftests/kvm/lib/guest_sprintf.c | 12 ------------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index a6a3e1657895..fbdf0e0c15d1 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -238,7 +238,6 @@ static inline u32 atoi_non_negative(const char *name, const char *num_str)
>  }
>  
>  int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
> -__printf(3, 4) int guest_snprintf(char *buf, int n, const char *fmt, ...);
>  
>  char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2), nonnull(1)));
>  
> diff --git a/tools/testing/selftests/kvm/lib/guest_sprintf.c b/tools/testing/selftests/kvm/lib/guest_sprintf.c
> index 7a33965349a7..6caebb456f3d 100644
> --- a/tools/testing/selftests/kvm/lib/guest_sprintf.c
> +++ b/tools/testing/selftests/kvm/lib/guest_sprintf.c
> @@ -300,15 +300,3 @@ int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args)
>  	*str = '\0';
>  	return str - buf;
>  }
> -
> -int guest_snprintf(char *buf, int n, const char *fmt, ...)
> -{
> -	va_list va;
> -	int len;
> -
> -	va_start(va, fmt);
> -	len = guest_vsnprintf(buf, n, fmt, va);
> -	va_end(va);
> -
> -	return len;
> -}

Hmm, I would rather turn guest_snprintf() into a macro so that it can be used in
variadic functions.  I can't think of any reason why this wouldn't work (and
emperically, guest printing works as expected).

---

From: Sean Christopherson <seanjc@google.com>
Date: Fri, 18 Sep 2026 08:57:37 -0700
Subject: [PATCH] KVM: selftests: Make guest_snprintf() a macro and use it as
 appropriate

Turn guest_snprintf() into a macro so that it can be used by variadic
functions, and use it in the ucall APIs instead of open coding the VA goo.

Reported-by: Gokul K <gokul02k@gmail.com>
Closes: https://lore.kernel.org/all/20260918113631.634233-4-gokul02k@gmail.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 12 +++++++++++-
 tools/testing/selftests/kvm/lib/guest_sprintf.c | 12 ------------
 tools/testing/selftests/kvm/lib/ucall_common.c  | 10 ++--------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6a3e1657895..817d4d5ca7cc 100644
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
 

base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 

