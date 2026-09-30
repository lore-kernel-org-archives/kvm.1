Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AC56C63C
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789878; cv=none; b=udHxDUh8yQcvGsyz9yKBTQjkgPoNz9J9idXKMjzLkhgphHDbq8GUEqASVy0v37FG5TTEfseaJnyVp2DzYtQm/YHloXkrkhdEv5ZHzv/s39i0Cy7vPXlDTUfqQTLfvvcdsbOzmpWke2Nfj62f8Z1njEHWihbUTlZ1iaoKmJBm8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789878; c=relaxed/simple;
	bh=UYlYFWKz2yUT5DSS+dWmZ+7t6pORCHntp7z+e+YfLkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hYqqAHkqmB8BDPKar1BHTcOW0HU8Q+CQSj4Z3uj8agV78o3S87+Phx1LLvt7HuWr1/KHQOWRQog8Un4qyvDcN81sSWXFyYCtY+vQxfWPdk7fjW28mUINnt8dewpAldfSyZXeDoDpP79ZbwbHHaNlfxGPIohNxN3V/dr4j0k1LYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5ETp6X1; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5ETp6X1"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d9057fab9eso59232125ad.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789876; x=1791394676; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4kpxy8IypVw+6oSZYz7BWKaExvROB4Eu+3y+VgEc0X4=;
        b=H5ETp6X11lQ2/Pi02I0fHa8ErOfJDv2iot2OkLPYJzLROhc0qw2Afmp5C6RBHbfQJE
         3Ldj92Qizu/q5Vptx/hoWvoyMK3p3I5f54nn6avz7r9DNFOM5HFsPnTX/CYrs72BAB11
         j6trF9Qvd6bXRMqKMIkmqMiwbd9niU0/AIv3ZBvHFDN156/mY1qpXFYZms4tNmy7SNTg
         DPXECcIzN0lbovrhqqJyyJVzSubjZw3J6WW/8MwqPoZZgw8txeBn2iOljFc220R3Y5Yf
         /gxEPRXzAV+1h3EgYw5bLxwrXA9YR3cqNpTd8NUgi2sbfRG1uOb4FhxWDhZ/LgscEebR
         0QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789876; x=1791394676;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kpxy8IypVw+6oSZYz7BWKaExvROB4Eu+3y+VgEc0X4=;
        b=i59DvQ5gkhV0vlBha270Gf4LgeySOCcvxYo+rnkvf265eZb91q7pGMv0eZ1GB4saFX
         a5FzNKNxfdbFrYbYJlV0xz07reoRACw+DtQ3Lb0Y9/XC8fxEqT1cD6Roi+PvqX8mo1Nv
         2pqhSsYyf100Nw/KRSe2UZ2/0f9jjxCizb8RP49chWasv5y0+xv/18BezdvTCnpmu7Sh
         MsnOkKX2vSmjcMaUXWRrPbJrvBl8jrtJDADrQw/M8lXrKu65BA4FWNUJWKAsjygicaCC
         ruSOXFXqskQYhnSHWFE/0MZ41fhe+KzcslmNSf5mtorQKwA8ob/gIA486IMY/1zdvQre
         xh0A==
X-Gm-Message-State: AFq9FYKCfG971kbMYcYTeIf8RDr9hZgVwds1V2xBvqkDYePSPiaTD+F2
	JUmotf65Ky2D4X4J9bumhQzqJ/g7/y4CZ1LVB0A/KrXvoSMom/094zWwxLGCbTTIlfoNr/JBnIb
	EzS0AJg==
X-Received: from plsm16.prod.google.com ([2002:a17:902:bb90:b0:2df:ab33:9c53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c5:b0:2df:b5bb:7d12
 with SMTP id d9443c01a7336-2e2e4b7cf7fmr17846995ad.46.1790789875665; Wed, 30
 Sep 2026 10:37:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:29 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-16-seanjc@google.com>
Subject: [PATCH v3 15/21] KVM: selftests: Sanity check KVM's default TSC freq
 in nested TSC scaling test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly verify that both L1 and L2 can run at KVM's default TSC
frequency reported via KVM_GET_TSC_KHZ, e.g. that KVM_SET_TSC_KHZ can take
in what KVM_GET_TSC_KHZ spits out.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index a8f9307ed2a4..ee8fda310e33 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -223,6 +223,9 @@ int main(int argc, char *argv[])
 	tsc_end = rdtsc();
 	host_check_tsc_freq(0, tsc_end - tsc_start, l0_tsc_freq);
 
+	/* Sanity check the frequency reported by KVM_GET_TSC_KHZ. */
+	test_tsc_scaling(l0_tsc_freq, l0_tsc_freq, l0_tsc_freq, BIT_ULL(frac_bits));
+
 	/* Scale L1 "down" and L2 "up" at a random factor from 2 to 10. */
 	l1_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
 	l2_scale = (kvm_random_u32(&kvm_rng) % 9) + 2;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

