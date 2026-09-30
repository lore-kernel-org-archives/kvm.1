Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A6522F0F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789874; cv=none; b=KhXZdGUJ+p27VNYAvERsqmV+RcbPIECUKqWBDpod0jU5tMQNP95zXGxHjXiPuht+I8f8HqBC5q8H9arBLVCUNLO/hpNe3OCzYIdyAkYN9snBmAYEjrafhQB0UrnD4wYsjuZekWJ993H8ZaKTDpsHoEJ/HB2ZGd94EDx5I2+9Mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789874; c=relaxed/simple;
	bh=sE4UstFJJDm93z/2C9nKFZnEiOFJRS3FGWFplpg9Q10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HpyUN4uoYCzgiABTN8fghXvUQgC3EhuLeMEosLY9xTmrHJvQcHptp9iTzgHrCLGuNnWCA1qbzu+rL+Ea1NKB1l/1n3YcT56uydJgCgXytZ2yc/yuZkxVHZ+3PgGhs2K3wjKrux9O5G+GDyxiZvuXPjyedaIul14mc6+M+zrs5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAzz6aQQ; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAzz6aQQ"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39533bb224cso7960987a91.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789872; x=1791394672; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3P34w1qL2JSmunI16hl66RzEZyrUpXazIWUsoHq6By4=;
        b=NAzz6aQQjb8GNYpWZqPX7kxq6dWhZ3yeXEqh3V/qeL1Rs/1fvDdl8GDRUr5NdeHoV9
         I1CjCQXNbMgdd9cj7gDTX5jovfLsv7KfyjqilcJg7o8rbdxX/6VHtCMahL+Ol8nYxs+N
         e37bm7r2jRsL5lp7Quobc+TQhzOUduvkZ8u7Vw0v6Ocx1CQemiM5i0Kpg1O+ePWttAA+
         Eh2Bd1tmdWTCbd+AgrstN4Y/mW5xIZHQiTNwcMnWZhE0lU3MiukpAl1YD6hgj+geSixx
         2LSfJJVE/sQF9fzj7MBtyu+AT08LskpxTMxaGOG/UoWFikFCMmN95QWslF1HhJE6UjXW
         lQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789872; x=1791394672;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3P34w1qL2JSmunI16hl66RzEZyrUpXazIWUsoHq6By4=;
        b=VWksljIUTgJcG/jefo7rMhp/iYiG1uEHnCuza1tClh6jJeo0hSTXKRRLPR2tTIbK1K
         RAy+JSaR6CNoXOgY650PLBYYISWnzC4+7S5a4TC1qrUgS3yuJeRnACCFTY4e4qhrOTD1
         0vJXr5wtZ32qWLqyOnQU7JH0QyIpp+saVKoBqncy8MrL/+n+gr/iKCWmHQ5N5M9ewe/Q
         4W3p9bTb/FKH7riBtLhDQaZXQdwFrd1mslymzy1RztJ48bp6qK0BppODd+d9D7AcBwjl
         lKzYi47HLZlFebAlQ8Xc0OWHSw9yHYHdgjkMKFkL4wZrCWpT9q/xBHntjy3w/2SzlCGY
         UhfQ==
X-Gm-Message-State: AFq9FYI/CVYABtRaRgWxE37R+3Oye4tT+HRIgYk7rDxWgdsCbyusCDa1
	ShiSQTiIEHL+eUzOVmhXomW6qeSTmQ2JOR3WYmivekeQ9q/5PxaitmZeH+YP47gXatnx+Ejp8JP
	ctOzvpg==
X-Received: from plco20.prod.google.com ([2002:a17:902:e294:b0:2e2:f0ff:32fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4b:b0:39e:6c6a:4b77
 with SMTP id 98e67ed59e1d1-3a4d1ddb4c7mr1601152a91.65.1790789871901; Wed, 30
 Sep 2026 10:37:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:26 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-13-seanjc@google.com>
Subject: [PATCH v3 12/21] KVM: selftests: Allow +/- 1 tolerance if expected
 TSC frequency is <100
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Massage the nested TSC scaling test's checker to allow for validating an
expected TSC frequency of 1Hz, which is achievable for L2 since L1 can use
a completely arbitrary fractional ratio.  To do so, set the minimum
tolerance to 1, and make the thresholds inclusive, i.e. for an expected
frequency of 1, allow the actual frequency to be in the range of [0,2].
Because scaling L2's frequency down to a single Hz makes the virtual TSC
run soooo comically slow, and because all of the math is done with basic
integer arithmetic, it's very easy for the test to observe what appears to
be a frequency of 0.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 8c96b8e501f9..d790ab36a198 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -36,11 +36,11 @@ static void host_check_tsc_freq(int level, u64 actual, u64 expected)
 {
 	u64 tolerance, thresh_low, thresh_high;
 
-	tolerance = expected / 100;
+	tolerance = max(expected / 100, (u64)1);
 	thresh_low = expected - tolerance;
 	thresh_high = expected + tolerance;
 
-	TEST_ASSERT(thresh_low < actual && thresh_high > actual,
+	TEST_ASSERT(thresh_low <= actual && thresh_high >= actual,
 		    "L%u TSC freq is '%lu', expected to be between %lu and %lu",
 		    level, actual, thresh_low, thresh_high);
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

