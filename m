Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4D4E9C36
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731424; cv=none; b=goZ3127gQ+PEF4tZ4Ttucr1nBQ5vpCIry5FQbk8prqtwQOd26fRNBxxhZPyAqirBeVWoEEbFQbQLtzmhlsevaqXGTsnlZQKTA+1V3Xeqg48WEwd1RLXGaHLVC/Pwp8XxgBFJunjH280oQebWLmQ2kN6nwmev4CIu41MfVkMiq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731424; c=relaxed/simple;
	bh=FjLFcy9UkF/Nj9OGXk9eYHGkRZAuPRURKY09ueTbAiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IodDC5HwskkPci4arUtyF843m6Y0kiDCbdf6TkKqcxwm4VQ3s5lFYp7t7JTZOwHQW44ls0FrKrxrMhDJxWebbcexjhsmYAdGAjNsbJcpBVDJD5tz27DayMpvfRXfqFToM9NHAQgFs6aaCkW3229fBYepl8su4kA/LWi89CtQHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9/2wU8g; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9/2wU8g"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso5141945ad.2
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731422; x=1790336222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knn7HOFJI9QIw3xJhFEBCduwXPGFO8ZK6ZsJD7E+H7U=;
        b=A9/2wU8gM+DaAVEkhUSXfmbk6NKwquohucX86tuhF9DbvZBtopN0qFp48l5fnT22VX
         sHYOgQib7+5vXbiA9/vs+1RgvACXwRXWPMjLaaJT9sCf4xexwc9AhHGUdYGKvCEVjkha
         o6FmdNkMkB6Aqw9yY32+LC3aCTRkc0dzLcjt7dK48hecsVfoZNNxsbAhOCjHUEyeuDni
         GXo5Jd0pU1dJqG3CfyeMtCa4goP4h+/dFU0G5F/oL54Rm0IjVpDEm/cf6ektCW8AhCk5
         8KkhdQIvXwtZm0Qkfi51ovSklQNCohz8B7IK4781vVVhDPEduuxHKp73GvoqJwwRiIoD
         bvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731422; x=1790336222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=knn7HOFJI9QIw3xJhFEBCduwXPGFO8ZK6ZsJD7E+H7U=;
        b=rxijSwuOrLqck/Vn/IQHAyI61FN0k6ifV5oK/q3JlUBf036HFYrj/0qdv9SqbJYbUp
         HsT3SpZA+s+EMd//k1QBe8Sq0H/EX4ufAWEkFdgzSM0EnjsGzabdecAU3h3c9fHA3ZHP
         8qgpprVmIVk4Au92AKN4KmNKhbdt5Rc2E4EtH1FDuGHZfx++PpTfPaN5hNxBrWIVLV3Z
         cMIRGn6JuUHKx6qDRTV3Bsp83ZpFzQXN9AAaorWfEBH24XNj38HK64IN9uhShXI8+93j
         bmY4dOHYthY/EnLg5HUfYC/ZqMU2eD9B8wdBLxgBC2KEvZbhrO66fFil4r+IEhAYkBL1
         7rmA==
X-Forwarded-Encrypted: i=1; AKwUvBxrzLZhs3GClG4h2247lwms5LItpUk8M88A8Tf1C1HUaq/kQhnhOniDpQlSJ5RwocR5utg=@vger.kernel.org
X-Gm-Message-State: AFuF++lq5YcgAWiLZnu1cdPr0mpm6YPLXhy8Z3ZJ9l0ZliNc0ooecypB
	NtCDmXbJn2KdKJEW37VFPTWpLDBtyMV4yuTZVn9zCl/rBKeiZsOZSoWG
X-Gm-Gg: AYBFou1eBCLbuH4UoA6QNUzhg9aGvnQliRmq+UmFIN250H0aEHEXj97Mu7j6VOnCUII
	ZXwDulx+TmgUDCL/MghCU11HRTzRm7b48gyDkM+nomWT0M0LwUCweV0lHpd3HJcCgSJsrFOWjMW
	QdV+wTjlCjza0gUppHX5a4Dd4aqyoFf0fze/F7zBX6+amWz1y0vjDb29TmIUXYg3Uones9+nVMD
	kn52h1zY5qOrdv4FFXuc8gfZyewLLFhh0GhY1+JNKD901z54iNRW/K4bnRU+w7FlfeznWkJQdgk
	l5lpHzxFK1eA0gKruv3JOwfHuLL+1UYW8rjwZAst1nDrJh5oA+RYSGPjrGjzwK1yhEunioD8uI8
	7u31HxQaoENLhuTp4/IHzlmcBBOzNGiT/aTqxatt3mZUA3eG8YRrkbZsRtI8NGI9F8PUJ+S30Yc
	gzNJmbjI9of0xYem5cW+nBO3B7BNn7Cqd3/yyuaFIVOEz8gNhqvL2fqI4cCw5r5nKmehJylfaZy
	1gR7774Uz4j
X-Received: by 2002:a17:902:f645:b0:2d8:d4d0:792b with SMTP id d9443c01a7336-2ddb1b79d84mr49699935ad.15.1789731422080;
        Fri, 18 Sep 2026 04:37:02 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2876839dsm4203059eec.18.2026.09.18.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:37:01 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: selftests: Delete the unused guest_snprintf()
Date: Fri, 18 Sep 2026 17:06:31 +0530
Message-ID: <20260918113631.634233-4-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918113631.634233-1-gokul02k@gmail.com>
References: <20260918113631.634233-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guest_snprintf() is a varargs wrapper around guest_vsnprintf() that nothing
calls. Its declaration in test_util.h and its definition in
lib/guest_sprintf.c are the only two mentions anywhere under
tools/testing/selftests.

The rest of the family is alive: guest_vsnprintf() does the work and
ucall_common.c calls it, so this deletes the wrapper and nothing else.

No functional change intended.

Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/include/test_util.h |  1 -
 tools/testing/selftests/kvm/lib/guest_sprintf.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6a3e1657895..fbdf0e0c15d1 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -238,7 +238,6 @@ static inline u32 atoi_non_negative(const char *name, const char *num_str)
 }
 
 int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
-__printf(3, 4) int guest_snprintf(char *buf, int n, const char *fmt, ...);
 
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
-- 
2.54.0


