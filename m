Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A23101C8
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365146; cv=none; b=a/9iJeuiyoKkJhHxM9nHXaaVo6/PhtWvgbvSURdV6gN6NS+1zkq7rHGBzkvp+KcxHsRrlo7UgkECn30TFfziE3Y+U8/1DusEhTh5keHS8kcRVU5qStv0efRX/NDY0s3CUEWmA8RYzfjsFtOE3CsayjCf5s1MK1nGAA1cirOcd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365146; c=relaxed/simple;
	bh=7m9TSkIprBQnO5SnKEMtRqur5OBCaZU7a+82O7NNe8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsyzqW3DpWVeJX9FTnH7/bJLnKnWeS8XSoWvabRdzUoqcWoTkvv5dIusL8n2cerQ5xl0Y3u101yKwyDehsHB8fguGRcf8Ha0MEWw6zYT3Z0f0TVsWqXPgGV02b1txRL0TJzlHI5POtG2IAEPGnRHGaW3+OM55UkqTrpET3i62vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI16++ZH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI16++ZH"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so11834679a12.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777365144; x=1777969944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+jLeOsk7xNnSzOzCqVVJFK8K7hUB/KB4pNNUZN70BM=;
        b=DI16++ZHqDSVFE7ldw6cfr/ixcDGYqvKWZClvJJLu70ZZXmbywp6VK1QRHJVm9FDv6
         XNjTS8WRLhEh6U1ZQo9tw9H5DaUhALpb/xfqKbC1rDZ87SuAPMj2dxPoXGc2TimlroFG
         6DAmCc9zb0awDrKiYMftkLNJXMyzkndF8o6F2HdbWapY92ZqWdYndloXBqA3jckfXKlE
         ccjRRgURYx9PI17CLRO7B/+L8hsQy5Sd+fswYcZVwsn4Ph9LVOI+zOMSshoKJR3fNa2g
         RcazcAqjl/TiH0m45R+IURwOimZJ4e016wPtJ6lKF0CZJ5i+jXl7zBwUtxlQ9rrYWYPe
         ko1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777365144; x=1777969944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+jLeOsk7xNnSzOzCqVVJFK8K7hUB/KB4pNNUZN70BM=;
        b=Ve6bi1lTjUAyn66VybuuKyA1XwPn8BCY0lKbVqF51GnV4NQbVosUAIF8ogk3jmTv7f
         RDXnCoOoYEVDNjuLp4CdSgSsQ8G4OT0IPK6tCnECHCrtrIbEP6srSnD0gtc1ToThgDws
         pfGAyQoIZ1DpJRlTb8lUX2x4zmRz3lh2nGbsGapNiux9s4NIHZ3E8Im6vESuUSlttyFn
         eeDC+HvqzugcMI+xVtWgrhSYd1V/BaQSf2i4ABRcJueXqz1RjGSFfvNwOYhrYJT9+wls
         ZNhX42t3JECfBVt/wuXsFokJ4CQI43vDaVDcHOkxuKgxkkaF972ZsH/FLm+MVrne8RsQ
         xnsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pY5R8RiPF0Q+qvOG/grAJCRf8kO7blr3+/HvIgbzhGD1UhobfKhfmOKr/EPfLcUkcVAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXAabe9KmB+mcInGO/gH2kjQAQkVmDvmnUV03EcWP/6vLBEFe
	nBYX92hSc35zvO4S7FZwiId7O5yjuCL2ASDbb8b7V4bTyiHZA+/1bjQi
X-Gm-Gg: AeBDieu7FJ2fLWyYfZGaUeaUrl1/X4gcB6X0TUG+KHOKAWv/hPKAfdNUAZst/zcB6zr
	meyMku5SDtKPkbANk9ZgOAqAo7YYtams+vKnb4zQTI6+D4FfYRjp7IxcLYGhANotxaKApsvhpRY
	ECq2AmxoBfgZh+fIQ4EFuuQPQ7SeS/lOtMOi7vP8MlffHJuVJ0txqtEQ5jZkc1jz05dseaYhA6m
	vun5FHWX8eftH8GnfrcCGybKsvVRqNvXRshxdQiv3n1iMIOdEILGb5EGmDSWhcfGPqV/htGGyR6
	HcP0zeswAGOrpyS1eWuKJ3tZzf+Cc89jOtI7hvhklmWCGIzI+3l6ww3HFgx2HFjaXo52KUEofo/
	4sZV7HjvJvyeoqtAoKzZGEXWajcSeR1t+CCd3vEBEmGdvpz4uPUDG3KcXW5GYSO+MFDJn7BGV+H
	7c0hz9RvNuWNF/KYzOITIIc1+XDc12z1SO7HapEmHP/o4dmw0WZnegtA3x3k452xMMdZhDriCxN
	GUDjsszlodGI+iP1EOjhxyhBhaIKZIOxQx5XA==
X-Received: by 2002:a05:6402:1f46:b0:674:5b2c:d42c with SMTP id 4fb4d7f45d1cf-679bb04c1aemr866693a12.3.1777365143488;
        Tue, 28 Apr 2026 01:32:23 -0700 (PDT)
Received: from arch-piotr.tailb7ebba.ts.net (226.55.classcom.pl. [195.150.55.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67ccdc8sm456152a12.4.2026.04.28.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:32:22 -0700 (PDT)
From: Piotr Zarycki <piotr.zarycki@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: shuah@kernel.org,
	vkuznets@redhat.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Zarycki <piotr.zarycki@gmail.com>
Subject: [PATCH] KVM: selftests: Fix typo in comment in hyperv_features.c
Date: Tue, 28 Apr 2026 10:30:37 +0200
Message-ID: <20260428083037.1926902-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in a comment: 'vailable' -> 'available'.

Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
---
 tools/testing/selftests/kvm/x86/hyperv_features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_features.c b/tools/testing/selftests/kvm/x86/hyperv_features.c
index 130b9ce7e5dd..f943c748f9ff 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_features.c
@@ -457,7 +457,7 @@ static void guest_test_msrs_access(void)
 			msr->fault_expected = true;
 			break;
 		case 45:
-			/* MSR is vailable when CPUID feature bit is set */
+			/* MSR is available when CPUID feature bit is set */
 			if (!has_invtsc)
 				goto next_stage;
 			vcpu_set_cpuid_feature(vcpu, HV_ACCESS_TSC_INVARIANT);
-- 
2.53.0

