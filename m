Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CA3B19CA
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377210; cv=none; b=PmBX4Etoakuc0kWg3dAUN7pGfa7aO0Sa4Z0lsbK7IyBEL3FWjcPgmjlQ6qt59O8fZDjmxNFJyBE2/J/1K0pEwP5dSrd2b25dLUIH32F2dRcj0zn70EXp3/2cg2XYkNhE53zms9Wcyt9lSNNw7WtxYfd5f3fAuGfw55tQB1DVyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377210; c=relaxed/simple;
	bh=2X8/jum//xZ0f+SN9cbbr03JGwVSHCzxGaqVw6BeINo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2lUxN6SxaKKtD77VMqUPwwaVyS8vlHPY7ad6DXwRx5uy7wI2BGwzY0ZP0Sb8EQvUyx1sbZ/SRLMP8RynNNcJQxDN5chXxvM/qsURPy3DrFM+cfY4Ieht/opSoUn+qVBAXTrYyVuVdFE4b8c78hkVvRmEC4DwyWl1VrKtdvmMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FloevjQz; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FloevjQz"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso976567a91.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790377208; x=1790982008; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qzSxjHb2QcK+7g63sm1k2kEt6ZFi0JWPS4a/uxJvDsA=;
        b=FloevjQzNiE0FAT4Fx28SY2NezLDAqm3sDc0mOtG/3KqeOYKgqpc3cGzJaMyjGNVN2
         m8lZbwLRdoBxP+0l9zLxvw4+pcMlwz5PFRLzOLFlvgXrPjDKvFpQ9+9QUdvmV9Jvuvfz
         69PBzCQefwbs/gKSVyLakkxE8spJm5lSUgm4Rz+dMvDsjtVk91tqMMuWGJ1ByudGGvwV
         6ajjLRuiP5rISaw9F2o+Y7FlsACs2WeHtTYaIpzOEAeoAaRrx1sjlA2u6k/PCW3wTo49
         9+ZVCmKKVoVNjf86uTzY3/pHY31AjgtRAu4JPYlT5lIu7QyNlSZ7t8m5Eq3K4S5QUmYk
         wIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790377208; x=1790982008;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzSxjHb2QcK+7g63sm1k2kEt6ZFi0JWPS4a/uxJvDsA=;
        b=mCeRcv98awXtJtJ8XZNij5Sq3WU2KWNdJ7PkYl8LCWqHBtZgl8SD3HI0we0/crvUFK
         CTf7y0O/lUaDsVpqUM3o+N+PVn/2ou0bdkK3/11S7QU0VguF0LIlu0DpOEyahoVfmGfl
         8Qwp+zZkQCIpH21gkYlmXDhg5tyGX0OvbHe3n9swuVeZY6DGdYSGMdiTVypA0Wzt8qZc
         VIahx/BX5WpU305qm04N2JtIfmAJgqLgntDa0MLT6tUP8Q3MHA0SQQHq0abPwNchvKsy
         IOnuM8FU/ql+gd4Mvnx2aaJjUZR+0JIVA4DHxiP+uyWVqUWvLz88KMwc6+cLlj8hg+bJ
         eQQg==
X-Gm-Message-State: AFuF++l0R996RQAcYItjRGGdach21VHioSpCUgsu0gUtFws8qVLDRBoR
	layx6MTAWCZfBMoa7nEoR5kRKr5uRTuGCFsKQTVdVj+k8Ayo9X3aAfX2klUoLipjVAeAXvzWh1R
	9y74ieA==
X-Received: from pjbem2.prod.google.com ([2002:a17:90b:142:b0:3a0:6f00:2a50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d92:b0:3a0:7d60:44fc
 with SMTP id 98e67ed59e1d1-3a098e2e6efmr5930721a91.57.1790377207968; Fri, 25
 Sep 2026 16:00:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Sep 2026 16:00:01 -0700
In-Reply-To: <20260925230003.2362261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925230003.2362261-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925230003.2362261-3-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 2/4] x86/debug: Run the "debug" test with the
 host CPU model
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Run the debug test with "host" so that it picks up features like Bus Lock
Detect.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/unittests.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index eb953249..cddcf642 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -485,6 +485,7 @@ check = /sys/module/kvm_intel/parameters/allow_smaller_maxphyaddr=Y
 
 [debug]
 file = debug.flat
+qemu_params = -cpu host
 arch = x86_64
 
 [hyperv_synic]
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

