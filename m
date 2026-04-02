Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A03D4131
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169087; cv=none; b=GdN0JLZ9MK66k85PVLBwJSASGRccOKg6DMufuFdGUvR/VhOm7xAeWNqDpfqH6LkLXYvd+n4NoHkA/jau5pWk0d1Ln2oMxRH4XPtp/Sr9rV4Z3EypMvybl6pebf+kJrE56p4yd2XzeP0HHGQpfijDyUqv1vtjdL14SvyuhuWkWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169087; c=relaxed/simple;
	bh=ZaLZ5gQqr0147GN/Lc0DeadSAPS83YIjQ9YpwTgNBjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BG5MVzwm9tSGpBl9A7VSI2G+BtDtL8/VpHHyC+ak/I6bzaH+oVCg7h/J0GHV44ODEN34ENcoiI3/z1zlpR8+D/XZDM4wypvcAbtoWo2PwvKXp2jxymrqNM/ofhjk6r7sP8L8F3wd2ycnNrgUroA+PbEuJjjDX0IqZU6lRQ3jCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWf0Ll8a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWf0Ll8a"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358f058973fso1384132a91.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775169085; x=1775773885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EitAmK80FnP6W5boJ91nHb8aM9ZxOtPro7KbAdjZ2GI=;
        b=AWf0Ll8aNN49x6DpK9pcXuU9v1V5wEBF1A4EJgoW410iwKEr9M6+RCHO/75NBUMksl
         Q3YLsMRykj4uqDk5w1rRRKgC5oCSyHkB5OqRclzS/gt7GfXFTFsTcPak7QvjeFFL1pDs
         EvleWaccyfLEh0MMz6wEioy9CnB1BYUTzCUOlGArfcw1qlRy5iebQqMhn2spj0pizvBC
         2CcbxboN5JpAAkJtLjt2nCVFV2Ro7ZzcHvUreMxU5DTPxqMqW5gmR31G+wNaALsjwFAP
         rKkhj0FRxV/1u4AuDTAM/CGKdEapnE2jEKk5qJITykMXjIseUIAWQyPKi0IQwuMTh+n/
         0X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169085; x=1775773885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EitAmK80FnP6W5boJ91nHb8aM9ZxOtPro7KbAdjZ2GI=;
        b=rvpoE2L9RljDyJLe7C0XFOhnooKpFjqrKMkI6m3LPdS82UJ8n/5LPGgtDaYrgYTyZk
         cuzcSnn47CGXC0ktoriqI1PN3qz5KnKnC8YPb7tPYAqamF6vRYMnfxmDxKD9FSdSbwaV
         6cJ5+7CLAtLLLy1j1Xgka+e3g+THuAGJTNhD40qNOOOX8g2TKgLA/r+P/zJ7+jcWhjK8
         djZSJGYalJt1W6b48V1OF5hMA2hbhcWhV2y2zemUKJw9gS64Dlf1F6XZoPLgGD5JRPKx
         GG862xenNJBXupwMB9MYWdGXIEIvL1oMWWNIVobOdX9thxGEDrnXihMXWTAOcfX1OKnf
         1oMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlCyvGMwYL2JhrzoMqhlTdMhFYb76EQxZ3xfx56TBhQBM/8Y7Jdz75/TdrGb/kKAWoftI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7JLGWq1OBqtyxn6UgDAyN1zfnFTIApmCLPuZjQZ13p1ZuXLCs
	OV8OrwEF65WBG/j3gNaQpSFosqL51OCIHTq2hi3/5QUvt62/vnTXZbdr1MrdWbAOHmypMXTEAtK
	wvp/LRrpxGSOy+g==
X-Received: from pgbdn5.prod.google.com ([2002:a05:6a02:e05:b0:c73:fbb5:af1b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d9f:b0:398:b178:a53f with SMTP id adf61e73a8af0-39f2f07f434mr520986637.40.1775169084899;
 Thu, 02 Apr 2026 15:31:24 -0700 (PDT)
Date: Thu,  2 Apr 2026 15:31:02 -0700
In-Reply-To: <20260402223108.650572-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402223108.650572-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402223108.650572-4-jmattson@google.com>
Subject: [PATCH 3/3] KVM: selftests: Update hwcr_msr_test for CPUID faulting bit
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add BIT_ULL(35) (CpuidUserDis) to the valid mask in hwcr_msr_test, now that
KVM accepts writes to this bit when the guest CPUID advertises
CpuidUserDis.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
index 10b1b0ba374e..5357281e6e4e 100644
--- a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
+++ b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
@@ -11,7 +11,7 @@
 void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
 {
 	const uint64_t ignored = BIT_ULL(3) | BIT_ULL(6) | BIT_ULL(8);
-	const uint64_t valid = BIT_ULL(18) | BIT_ULL(24);
+	const uint64_t valid = BIT_ULL(18) | BIT_ULL(24) | BIT_ULL(35);
 	const uint64_t legal = ignored | valid;
 	uint64_t val = BIT_ULL(bit);
 	uint64_t actual;
-- 
2.53.0.1213.gd9a14994de-goog

