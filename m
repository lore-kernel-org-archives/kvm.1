Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114345;
	b=BpRKwB6xL990c65q6qZK2CaVMTDsvLv5tflCa67+4ZBD0xPEzGEFKxAfzoWod7YXEDm6
	 KRp/qv76uCr5NVN1VIZAX7IA/FC6GS7aBO0A2V6TND6OFBiOkZ6peVW7QBzyH6Ym21fYR
	 0JWYI1jLuq28wtHOd0y1ahKYfreCS/t0LV0PrihbNS+EDTHw2AzCTdxFmRmcUUvHXKBep
	 errEyQ1Rhr8MoO0CbA5xI89BkWdrKQ0h7IBVcVd0gHhBy6RP9/9+dCdFDGo9cvQcxZNig
	 2yyRuwwUoG6GltBVeu4fBsWz2DLd86G3FymQXF8p+laW8Fssb6xjeX6F+ldRLy86VCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gDyW3lpBDMB0NqyM7GSJ8o96cb3fLFzZmtMS+6iJK0k=;
	b=kMuj7Q8VZnj3aDHZJVkVn9LywBi3IaKSx1oQXnX89RknwmkWDdc8SA8O51X3YeqVY/Jh
	 pN7gnqF9MziE3M/grADhpFoTa/ehjS6C+2lcm1uHaIzefQ5pSe60EMywlvj9fYpHeXBDQ
	 N1YN6OfdyzzpqBf5JQh52UTsUJgipad3mmEVzjwD/6I3gaMfW8gZF63PBH76I65Ep8AIU
	 /4KC6UczTUVypn05qslP/JT3I0v0oCG0XBeMO7m/vVGk68vqObbO/GRohhDH5f0J/eZem
	 sJfC+mQObpupojjEQ35SAI4WUcWM3nd3zk/hPfddkd3KByA1QhhkFNHblxuVd+Kd/jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mYp484Dp;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C660A5BFC
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B37C660A5BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mYp484Dp
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4fb73e868aaso248110b6e.0
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114344; x=1795719144; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gDyW3lpBDMB0NqyM7GSJ8o96cb3fLFzZmtMS+6iJK0k=;
        b=mYp484DpEeY/oHUMCOm9sqI0dW4VUQHG54G3nL6EO4NCkXEhChV94ldh9u6cCjxQRP
         Z2vtxQTgQfTSpUuPJOhDom2cN6v15ZfxEkSyujt4mZfM2xGJxwgj5ntKhOdaacfIMe5R
         BlCk4dgrSWqiGjS9mMRUwlAeEeup9ZKxqUMRRbM49mRrAuRTQvt9M3NHCoUUQP7OnUn+
         LOm9m2vnhuym2iWgvQXNYJ3xz/JOktcOSyBhXUE/sWr8Qi5NlbiKgufyd6Z7lAKASRWo
         SGyyVSug9La6Vt5wXN6UdHPDrJNFrQcaVs2JDNFjr6KzFdb8wJgvxNU29wTfnojXE3u0
         OXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114344; x=1795719144;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDyW3lpBDMB0NqyM7GSJ8o96cb3fLFzZmtMS+6iJK0k=;
        b=VpelHzb4n+vMza3hL7ZfDc94lFBL3k+7Fet6NRl5NR/Qy/VvRtXnSwQGbQmim3fWhu
         9Ry6WHinXpmhJnEsfomsDi2WKrXSw64bgYDrdY9R+2TpyGX4r7r+qV2u7TGIw/uWTZJb
         rgdXD849fDql6nAkX3OqrAJhleXvZ2ioJeOOsKt6+j53SevIm+wIJGzS+pZmZtwOk9/W
         irypQuJDimjW57NWgUCufGXbe9hpspODof0q/b4SXKEObgikK6WXjn6/ZYnxxL4Reaal
         bNVbfMPJyTMEbx+ahCAGUCCipZkXeqLM8dvtlv6blELFuEsh9sUDECRNTxd8nFtbZbC1
         YMZg==
X-Forwarded-Encrypted: i=1; AL+hErHAc2lATHuptkaTy3XDpMdOl7VtO6FS2AkAUGBR/Q00CyEW33GOjUcPvHPh0F8BCpn9puM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9c7FzkfqqeGoBxPkXAPuAXvXOfWAmSd1HIHSV9IeRaFd3Zf6F+
	/DiCf/xzOZoChUwnSV6EEI2CLpBYOxuG/G12pcE+SC8WgIpKD6+YkUot/O7RRZHYCveysopGaus
	U91PTwJsWwITYsnK0rfNB6YZeJQ==
X-Received: from ilef19-n1.prod.google.com ([2002:a05:6e02:6193:10b0:51f:7667:1233])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3189:b0:4ea:18f:64b0 with SMTP id 5614622812f47-57a0c19af8amr826925b6e.67.1795114343396;
 Thu, 19 Nov 2026 10:52:23 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:50 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-9-coltonlewis@google.com>
Subject: [PATCH v10 08/33] perf: arm_pmuv3: Check cntr_mask before using pmccntr
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the PMU is partitioned, PMCCNTR_EL0 is reserved for the guest and
removed from cpuc->cntr_mask. Move the PMCCNTR_EL0 availability checks
(cpuc->cntr_mask and cpuc->used_mask) into armv8pmu_can_use_pmccntr()
and un-nest the 64-bit user-access fallback check in
armv8pmu_get_event_idx() so host CPU_CYCLES events fall back to
general-purpose event counters when PMCCNTR_EL0 is unavailable.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 drivers/perf/arm_pmuv3.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 973d4abcb3a6e..9ce915754b0a5 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1013,6 +1013,10 @@ static bool armv8pmu_can_use_pmccntr(struct pmu_hw_events *cpuc,
 	if (cpu_pmu->avoid_pmccntr)
 		return false;
 
+	if (!test_bit(ARMV8_PMU_CYCLE_IDX, cpuc->cntr_mask) ||
+	    test_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
+		return false;
+
 	return true;
 }
 
@@ -1025,14 +1029,15 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
 	if (armv8pmu_can_use_pmccntr(cpuc, event)) {
-		if (!test_and_set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask))
-			return ARMV8_PMU_CYCLE_IDX;
-		else if (armv8pmu_event_is_64bit(event) &&
-			   armv8pmu_event_want_user_access(event) &&
-			   !armv8pmu_has_long_event(cpu_pmu))
-				return -EAGAIN;
+		set_bit(ARMV8_PMU_CYCLE_IDX, cpuc->used_mask);
+		return ARMV8_PMU_CYCLE_IDX;
 	}
 
+	if (armv8pmu_event_is_64bit(event) &&
+	    armv8pmu_event_want_user_access(event) &&
+	    !armv8pmu_has_long_event(cpu_pmu))
+		return -EAGAIN;
+
 	/*
 	 * Always prefer to place a instruction counter into the instruction counter,
 	 * but don't expose the instruction counter to userspace access as userspace
-- 
2.56.1.708.g77570a6a1d-goog

