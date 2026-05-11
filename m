Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C1374178
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499484; cv=none; b=H7Db68myBMsORQMhs8h+c9KuExkRpm33E1ZTyReJ+xyK/ZyufIQvCohQXlJJv3Pv6udJZeLCdzczV2QspKWNipkCTKL8t/O4DuzHj7qeGVvqe9C8uFc30D4SkUj5BNLN8rWkWq148MMbe1x1V6dLi72ULjxqd3cIGplcJa9nVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499484; c=relaxed/simple;
	bh=eaY6TK+Qpe+lIaRuB6hMveOfH0bKxY7FKAgnCBah25M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VaRcx5NzFqxmJ17/K6d9QY+VKauXps9MsicviLm/mvOBejECN1SiYWZwf+boijW4hOYC/XAf9mRMbMPtQwgpCFRKJG37qJnWY7DTveyaN+0qlXN303l11SEX/zOhGyX1E76IM0MqSkIzGgv/1qpnwDD72UXYKjqwZgU9hTIac1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYrKEV2v; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYrKEV2v"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso26497395e9.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778499481; x=1779104281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzm1887tbi5TpLOTPTV8msNtv3UBrK/MPRsLv3+5U+k=;
        b=dYrKEV2v14rwfKI8jnlPESyjvvZnNDJuuwiuTtWx6Qi2At/wOwN5BKKiOs68Md6+uk
         owjbQWjws9pu7TAB3TKlbGZ78WtJ0D5/IfQTx0CGDflYQckwBEBvLRnWVduqcG73SsBD
         npe0ROPc1RTK5ZmwgTu/fYiUBKzccjDgsDN+yrMzAdzGmr8vNuRbkFPQDaMVJYPJo1TI
         br8NP8BCqt+SFWa7MxvcetbeRxLuwUVMLG7Zepmy8CFQv3aUH0THWxCRO1Y+YQHPgzA6
         e2Ga/T6OB4dgdXHtq+l0VNbLvv5tYCzatl9GbZnwi2jXRMhZXLPPEkIMSFwV+QOCB/1r
         XxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499481; x=1779104281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzm1887tbi5TpLOTPTV8msNtv3UBrK/MPRsLv3+5U+k=;
        b=Tj506oJSHEGbXypg2BLsJYar9HH4yHTKPF5Kl8BAFOWQdGfB9J9XK8T1EHZEoLb3Tb
         B4faVnaGY7zyZgvsSq29e/u+0RzAFvMGr2BXu9KBdw3qXXrnlgJshVePEq4Um7+UUTqQ
         niZ04kTXhq0n/IU7XoSUj4z5OrVBpfwzVbu8bULc5EaRKFiI6qxraADG5dSzKqaLj3gu
         qLnob5dd1iA3zirHzssCYpHp82uMPucWOJmijRRwBnuTFMP+VWOJIIzlpzCG2RFt0po0
         9+P/blKEay+4+aiKOCo8KzQA3jDgVaajvZUE8ejL0GvTMftTKY3M6/Ra08EUgiBGlbUa
         LE6w==
X-Forwarded-Encrypted: i=1; AFNElJ9/urbVMkjPzevW34c71InlYhVcRXiONR6UTWULELKv8t7rNe+0G3gXZMq76SB7MMIIUpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHEuvYKei24Ehj8biMnaoSeuQuNH3lVSv7x/KnEfV78w6wEWE
	se7R3lVF2o+Qns/4gdYOsOpAnsoxYO80kGwJbyGzmtFUjpr77C/RC0RwCHHNqUELWzQIBwBsMq6
	TxA==
X-Received: from wmfq17.prod.google.com ([2002:a05:600c:2e51:b0:48a:5970:2007])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3055:b0:488:ac01:72de
 with SMTP id 5b1f17b1804b1-48e51e0bc2fmr222188565e9.5.1778499481339; Mon, 11
 May 2026 04:38:01 -0700 (PDT)
Date: Mon, 11 May 2026 12:37:58 +0100
In-Reply-To: <20260511113759.610924-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511113759.610924-2-tabba@google.com>
Subject: [PATCH 1/2] KVM: selftests: Fix MADV_COLLAPSE build failure on older toolchains
From: Fuad Tabba <tabba@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

guest_memfd_test.c uses MADV_COLLAPSE unconditionally, but the
constant was only exposed in glibc 2.37. Distros still on older glibc
(e.g. Debian Bookworm, glibc 2.36) cannot build the test.

Add a compile-time fallback that defines MADV_COLLAPSE to its
kernel-ABI value when the libc header does not, matching the
established selftest pattern for sometimes-missing libc constants
(see selftests/bpf/uprobe_multi.c, selftests/mm/hugetlb-soft-offline.c).

Fixes: 9830209b4ae8 ("KVM: selftests: Test MADV_COLLAPSE on guest_memfd")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index d6528c6f5e03..45990ae5f1e5 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -23,6 +23,10 @@
 #include "test_util.h"
 #include "ucall_common.h"
 
+#ifndef MADV_COLLAPSE
+#define MADV_COLLAPSE	25
+#endif
+
 static size_t page_size;
 
 static void test_file_read_write(int fd, size_t total_size)
-- 
2.54.0.563.g4f69b47b94-goog

