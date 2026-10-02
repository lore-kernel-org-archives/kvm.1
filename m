Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D047668A
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958083; cv=none; b=dWm/IRGlTq+ClxcUZRUZQ3b1K6I2+pVzKU7mNGcVwJA6H2X5GUcndJ/C0tYadcc2T/vhpjVmnf90LYCNqvZiE1S+CdKFz1tA2xeG/ZlzYSuFPZ1JZSuWxlUA995Tt747hShxoWq45u6vCjOszynkPzgWt7fhCux0h5hK82PlNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958083; c=relaxed/simple;
	bh=OUNW9lx2TqTu6WlBHR9cyMo+8p2x2nYkWknXuRYhl58=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MQUiKWPOfFj+uibeyBaBDQalQqffJkGLk3/IquSwVZFE0MF3kpHYN8GTdkKOZBWXyB534HcTzjU8wv4n1J/NTJEhbf0FsWtAIF9NSoeMqGaPGudSuvp6mNU++cHwHAZhZkO5wU/KLO6iJpZ/RNZyca8Z1XfqmWRMZA9eESXj2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCrwdcVm; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCrwdcVm"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso129066295ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790958082; x=1791562882; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wj7vtePDI4uVMTZvt0YLmuTTBhBCcEQ/w6dfm8tbYEE=;
        b=qCrwdcVmB5xKwjw+MBiWYUoiQH4xVronoQsjHmCaab/liODPd+BdbCsfReXqtBnxGk
         3A0Rv6Cp4wQ3u+L/X2844dmtBoiQxVIOHilwTXR4HX2CV52k9rX7tRZy/kefrvy+5ch4
         R7SsuXtOwKekOLshtyvuS5gW9GDJwPYPuY30YTYUMLRB9aQ/raFxfhJWcfO+eralNIJN
         K5dD5fh8YGsA93rW5Knvssju8VGPYLpUsLDAytLVzi2VbnNnTfhzJeCfJ1h5PRHf+0O7
         Qkeccm6Dgnppr6zQXsqcNfJuMZtf1X4ewddzj5l0fZGzYAsnpoy0XPjfzPMkE3NYKpux
         YUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790958082; x=1791562882;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wj7vtePDI4uVMTZvt0YLmuTTBhBCcEQ/w6dfm8tbYEE=;
        b=eTEpNCbD9f/X5rN19/hUVu/zTJkLSJsqE4qzjwwpfCk8+jHUMfrUOd2YAQGGo1uRWL
         hVDX3a7bgB84gy8k5oIpn5sve/IpbsSZ7qsQ92LWDNWSt9ycjA4XjTvXj5yDTswQ8tRL
         wKUB5vbNrign5Zur2dRje/v0ujZf0n6ox1bcPR1JFaHTuVBI40dPg+Dfx70PQjC+7pyD
         xy+snSf4xXnxXHOek7UaL/YlEGzzmnzZK9swgt+MGVK5gQ9a0B66otVWFr3wxtf9/UGT
         dk9G5GkfAQhiYlnialeDqBtQFnEWeWhXqMGPcb4FrEmF2CS2KCH8XNBG/HUTLq3SnpD1
         qxrw==
X-Gm-Message-State: AFq9FYIU8u0GkF5pwFpPZgTLlwsaPQD+wqvbusnvSt9l33gm5jvy3spq
	mzKn7O7Qe0XbJTO4aIm+3cANovri/PlVfUd/9M4uN1+WURh+LLqBh79/5zjlX1dZpuHJWNCl7mW
	mUu37jA==
X-Received: from pleb9.prod.google.com ([2002:a17:902:d409:b0:2cf:bf3e:41f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54d:b0:2dd:c054:197e
 with SMTP id d9443c01a7336-2e5105ac0eamr844825ad.35.1790958081421; Fri, 02
 Oct 2026 09:21:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Oct 2026 09:21:19 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002162119.3957230-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/pmu: Relax overcounting checks to allow
 for 1 VM-Exit per 5000 nops
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Relax the check on the allowed instruction count range in the PMC overflow
testcase for AMD CPUs (all of which overcount instructions retired due to
treating VMRUN as retiring in guest context).  Empirically, modern CPUs can
overcount by ~150 instructions, which seems high, but is reasonable when
considering the main loop executes one million nops.  Arbitrarily allow for
an "extra" 199 VM-Exits in the loop, expressed as a function of the number
of nops in the loop (the "per 5000" math was derived from wanting to allow
for ~200 VM-Exits).

Opportunistically drop the "allow undercounting by 1", which presumably was
a workaround for the VMRUN overcounting behavior (which is now addressed by
tagging AMD CPUs as having pmu.errata.instructions_retired_overcount=true).

Opportunistically use the same logic for Intel CPUs.  While hitting Intel's
errata is apparently less common (doesn't happen on every VM-Exit?), trying
to precisely validate the counts when they are known to be buggy doesn't
add much value.  E.g. if an overcounting CPU happened to generate 14 extra
events, odds are good the allowed count would simply be increased.

Reported-by: Sandipan Das <sandipan.das@amd.com>
Closes: https://lore.kernel.org/all/2dd84890-3c21-4942-a9e4-8e07408620d3@amd.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/pmu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index 483f2f1f..a54eb384 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -578,14 +578,16 @@ static void check_counter_overflow(void)
 			cnt.config &= ~EVNTSEL_INT;
 		idx = event_to_global_idx(&cnt);
 		__measure(&cnt, cnt.count);
-		if (pmu.is_intel) {
-			if (pmu.errata.instructions_retired_overcount)
-				report(cnt.count < 14, "cntr-%d", i);
-			else
-				report(cnt.count == 1, "cntr-%d", i);
-		}
+
+		/*
+		 * If the CPU overcounts instructions retired on asynchronous
+		 * VM-Exits, arbitrarily allow for one VM-Exit per 5000 nops in
+		 * the measurement loop.
+		 */
+		if (pmu.errata.instructions_retired_overcount)
+			report(cnt.count < N / 5000, "cntr-%d", i);
 		else
-			report(cnt.count == 0xffffffffffff || cnt.count < 7, "cntr-%d", i);
+			report(cnt.count == 1, "cntr-%d", i);
 
 		report(check_irq() == (i % 2), "irq-%d", i);
 

base-commit: af828383c365d2baa2449dbb3ae2f5cc826f8036
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

