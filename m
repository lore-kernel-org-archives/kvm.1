Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047C366810
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385839; cv=none; b=UaAvMmrj9S6QxALhoNqmxd7yPfAnnHT6D63X+k4RG+jQbk/kKXuWYLRzS/t9oRRL+8oEeu0cvoJexHdrpGYkQtvcO8KGWxtG1PchND+45a9dirOpafx9BZH4bQ9YIbk1UAb8wzXn0d2HRWozhVRUbSseXvzeIMj3NJlBUIpdwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385839; c=relaxed/simple;
	bh=yipGvzU0XSoeO6SPfV8USfkXqLZQGUvVOj9vOK2YYXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VcleWlan3w3avABzwzVUELrtDNOKr2QmPZ4xNfJpY4tR5DchdWyvxzgiGtKUpgVp/5yfoNk6tC0xuPqom3tTsc8e+vMZcncvplRvPOqQUtpnifKzqWbe+MG2iTW46DNoNAaYdk0i4/YkhiF4vlThAZNH8VC9f319kMZF1YN9SLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlwezNEg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlwezNEg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829a72475a1so6795338b3a.3
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773385838; x=1773990638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbW9HHXfBj/RUZsSrrL2YIjr4l62JaW5V4xI8hWdqmQ=;
        b=MlwezNEgGUMDju0ZMnfmfWM4OXQyZqsW7mI0OWH4q74kXmHOF/TCFZdX1BZK7nTHHi
         iAm7t75JnAMO/u3NXzQZBGv1M3D+rz7sZYccvYjAGmZBPcuyFVk63dG2h8Q8h0NagXHD
         NALwsUHeBVBYtnRRRxdDkT954txF2ByS9i3O19dBGUSIy3/cRi6GGUZIgCyPqbWVZv5q
         JvLFUU7KvADKPDD4wmXQqYPmfWAdKUQQFDvhkjyLK859mzLz3UhKtXr8O4WhDo7frrVq
         TyX2BlZxZmx5uS77NTjd9+iwDuLY/Ia+CyzosXaquy8/eeH6W8iNghWLBqYxaGt/P3mX
         78Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385838; x=1773990638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbW9HHXfBj/RUZsSrrL2YIjr4l62JaW5V4xI8hWdqmQ=;
        b=Llz8Kjdepi8dzWyOPG80B/VOafZ3yO6nv5IAXReP2pZ2PMDmuDhF4tiNwL33H18BgK
         1fOZKU0pBVU/4oWEdGirpa3EXvZta73wpD0nqwWmnwE9YPmCnA04pmea5n4gZZgU+/Op
         pVMnC/N/7z+tmEAmZbnYUvRs10cvOSoRZdzW27jNc4tVaAj4yzIdb+93IE/z3/EoGcBG
         1evNWcQp1qO1T+BXNO9Neu40kq9j7/A9UoaUA0st1jzd6toj2za9McnXe1j+hXfTp2iX
         xXGFbZaO4jFqFG8T6KhwYOVbckqmCF0elyS2wLqd0MyeF13Up1HOeApJO5eJzUvf4aX3
         BGeA==
X-Gm-Message-State: AOJu0YxkkkX3MjJwmmVoZ58ZCHML8HFN76t2A6RPa3dZ9uxPvlYIrCWD
	XZSOH89GBhic3kDbNUqK571sNbifoQYgxyK3JQYOtpDXZu86juH4RE49+EQJCdhlw/dBNjJiK5O
	ZjRpUhDKf2uq0uQ==
X-Received: from pfbmu17.prod.google.com ([2002:a05:6a00:6e91:b0:829:880b:b4])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d99:b0:81e:12f1:d8a with SMTP id d2e1a72fcca58-82a198d7062mr2091526b3a.34.1773385837675;
 Fri, 13 Mar 2026 00:10:37 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:10:30 +0000
In-Reply-To: <20260313071033.4153209-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313071033.4153209-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313071033.4153209-2-chengkev@google.com>
Subject: [PATCH V3 1/4] KVM: x86: Widen x86_exception's error_code to 64 bits
From: Kevin Cheng <chengkev@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, yosry@kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Widen the error_code field in struct x86_exception from u16 to u64 to
accommodate AMD's NPF error code, which defines information bits above
bit 31, e.g. PFERR_GUEST_FINAL_MASK (bit 32), and PFERR_GUEST_PAGE_MASK
(bit 33).

Retain the u16 type for the local errcode variable in walk_addr_generic
as the walker synthesizes conventional #PF error codes that are
architecturally limited to bits 15:0.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 arch/x86/kvm/kvm_emulate.h     | 2 +-
 arch/x86/kvm/mmu/paging_tmpl.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index fb3dab4b5a53..ff4f9b0a01ff 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -22,7 +22,7 @@ enum x86_intercept_stage;
 struct x86_exception {
 	u8 vector;
 	bool error_code_valid;
-	u16 error_code;
+	u64 error_code;
 	bool nested_page_fault;
 	u64 address; /* cr2 or nested page fault gpa */
 	u8 async_page_fault;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 901cd2bd40b8..37eba7dafd14 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -317,6 +317,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	const int write_fault = access & PFERR_WRITE_MASK;
 	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
+	/*
+	 * Note! Track the error_code that's common to legacy shadow paging
+	 * and NPT shadow paging as a u16 to guard against unintentionally
+	 * setting any of bits 63:16.  Architecturally, the #PF error code is
+	 * 32 bits, and Intel CPUs don't support settings bits 31:16.
+	 */
 	u16 errcode = 0;
 	gpa_t real_gpa;
 	gfn_t gfn;
-- 
2.53.0.851.ga537e3e6e9-goog

