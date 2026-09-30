Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006851FCB2
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789864; cv=none; b=ZxYPdz9vYYzwSgDHKQNLkWk30sYa0ZabL8RqWCF/kMb5/GfqpijfBNdcXgP+U8C06eGpnOGfyzu30QWyW+DofROeBUh60VCIaIc/DGWcGB335S2C+AC4Q+bI7dVx121y9Rms1Q4+suN/8Q5gkqWET54veXRBOPXDNwV1cibA0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789864; c=relaxed/simple;
	bh=1FrL7bu97zfN/4D0tUEYh3oW3DF9r1HY0IdUq039N7A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l6SHtB7Q3iMYSKp6VX2KbJKeBjt6e1/UKLWvOi0e4lY8AKhd8/wYuBkhbkpKPkMq5JcSkZc2TfL8suoVRwTlaaZIBTAQRRZUXpj/N3INKj0WZnZ8+zCs8v/79MYCq+U1sBA5ZdupvVMQ5U3QonDWsGPe88Vy2FHgp6T9kmS56to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lH/AYcXw; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lH/AYcXw"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso3312772a12.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789862; x=1791394662; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TNoV+xrtaYnXLLhF2q2fZGwhlGuvnMAptZyoyMGef2M=;
        b=lH/AYcXw65OgYWQ1hfYa+J1TE2J2ogobYICMb4JdVWs+dG6BaMS4yPV1AoFdGaHV9y
         a+bLtQRPMQ5JTJcsm7R48RX/45CgqsMhVqsMMzcOuo2iSKbjAd8bgzHx0ObS6Ypp3bcL
         A4J9fn9Z50kXulizV/crhA2v+Mh+BAi4lrzAntKbGNNcinF/r1LW9a3DNSNoh1v00HWK
         Z1dorCmGBtdajGuRKCTGJvH14BZn5MASINJ/FymU7WbFRnyrS2wsdyr8km1efzjc+sf9
         EZLsVmmvfcc/qi3c3lsxVISHlTl0oZSQPDwENUI/ichg8l02gZkF8yfqD1bfne0fvXJB
         zOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789862; x=1791394662;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNoV+xrtaYnXLLhF2q2fZGwhlGuvnMAptZyoyMGef2M=;
        b=brQgxS2Ec2nUO4FK6efShi/sUcfLV/Fq0/Kc+D1vbB4vTGznGLi2rYk5df+DgH6bCK
         ZdYE8MnYTESgLlXNZO9AwjLeBH7fS36JUq5ZGgdjo1WQhzy7yXrTRP19R2J1mEVgp3dh
         bE3goybaYKzpGgGag218SJffZ4orplffpGWBXyr5CAFeP2lm5YlfK9fzuF/0oUo0j/25
         nroFdjuwL21hS1rAKzcPK/h+tnfefEZSmhcVd8Rw4FSiYHE4s4UIWUTbsIYYzVaBa1uT
         yUeusEVgz95GmvvpebicDksHHGvc9C4askEQ7DODCSc6sOA86x4/zNiOq85C37ErkA3p
         Emeg==
X-Gm-Message-State: AFuF++ky5+Ddply+Y7qSXg3wf9XCe08N1JnOmgUrnOD4dFUsCOv0nKz5
	3Kd7z99RHG73oNuU8RFxP1XMK1Q8w1UywNKuEa+O4H2fc8u0bQx27hrCCCKDybQ/1+bpCcZxHZO
	wMARRrQ==
X-Received: from pgdg6.prod.google.com ([2002:a05:6a02:51c6:b0:cc7:d03f:4d50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734d:b0:3dd:85a8:4c58
 with SMTP id adf61e73a8af0-3de9e69d1b0mr2145252637.31.1790789861905; Wed, 30
 Sep 2026 10:37:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:18 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-5-seanjc@google.com>
Subject: [PATCH v3 04/21] KVM: selftests: Use KVM's pRNG to randomize L1's TSC
 ratio in TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use KVM's pRNG to randomize L1's TSC ratio in the nested TSC scaling test,
so that reproducing a failure with a specific seed is slightly easier.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index c763f4cf0f62..65de46f80a3e 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -166,8 +166,7 @@ int main(int argc, char *argv[])
 	 * referenced by both main() and l1_guest_code() and using a global
 	 * variable does not work.
 	 */
-	srand(time(NULL));
-	l1_scale_factor = (rand() % 9) + 2;
+	l1_scale_factor = (kvm_random_u32(&kvm_rng) % 9) + 2;
 	printf("L1's scale down factor is: %"PRIu64"\n", l1_scale_factor);
 	printf("L2's scale up factor is: %llu\n", L2_SCALE_FACTOR);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

