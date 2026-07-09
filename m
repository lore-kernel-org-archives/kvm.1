Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67743373BF2
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615680; cv=none; b=hW/qXTzdIApLQWbin9tXfQWxxB8mXexAiGg5WpMDfdLidS+RYkA101YuebuZvdZUgo3slP2Fpr1c906AkdNHhY1GB9Ru306YTZ2+k6GSgAdBpRe2tDzT5wWTb7HrLa6SdwAbArI8evtBaYV5brIEdGmlhRsJIkCiarVHRjjBwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615680; c=relaxed/simple;
	bh=l8azDO1V+A9zH7SZVFYyRnG3Q6u3OzWf/+Ivbv+sPKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZjkrRaptES43AmB7RHBMHz/T7DbPTiiy0Vey82PdvEer9luB9Z0Zo+WvvS2qkN7cUsM9IAcTym0oyg4ZWwTgc1e7RlUzoKFMlbdvj7qDqXpvsTkl1gzpmz4+I76soyXBShfTJtRgGTqfMMJFdC8WDS/wHwXXUx35vY2UA0+P+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hkc4PfeD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkc4PfeD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ce7d2adef4so5444265ad.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615679; x=1784220479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bugrw9ZAn9zVjHgJbS8tolPWSEIE1MhjgoMVhvy2STM=;
        b=Hkc4PfeD4Rw6Ahgud1zBQSFM5LzRawNvlv+JLDShmbc+gWBRjaUz+vIX7h+zWRqIns
         A1+nIFvAGbIIF5Hjpp+mwtmV01gzQPJ3DytJ/FM8vxsvxhwLijCRslH/3pQbD1bsi7lq
         q4rRnar8JHAD4XebwoYldv1+lfsKV3pfVnhYVbCfZf4lIvIltGY22vhBCBdnTfv5Wdk1
         qBS1bgSIJGiEDvwqDRIVszNQHP8PMZ/svpX9tNXhztQJ8946xP0WmhjkGlRnMkh/1tbl
         xkVH3kuu3tmsaqYPbTmZPGLsMDY+m3AvP0Q6AGBr8VwI2M8wN0p2rpL2Y+CfgI6jk9hx
         3hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615679; x=1784220479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bugrw9ZAn9zVjHgJbS8tolPWSEIE1MhjgoMVhvy2STM=;
        b=DPpXjzOxexkml0fh0vaDvX6/mJNGKNzMpSSGasNhYw6x/mJc/emO2x5f0WrYHau7YZ
         Cf87OYqVK+FFqy5c2MVC+7SU4RxRvyP2oO9cUVLCV+pLqWYkWGTv3Buge+q48y7RwQl4
         dc22jJDYIsCXXOxw2wmZgxvJN9VIFdfJQSXHbtqKLU8+S3K1Y7O2Q6mnrRGZxTzMkNH7
         pZKsqdgsdwDqZ2WL42hPNapDIWUA7VksovKCrxuTgJTXEPAOE6WLItskvZxkFA5i1TuX
         8YHRP9wviBlE7UElr+nBRsatGkZSBXofm6hs6dNrlfHJUv8YgBLJeH3Sg2VL2ORc/58b
         P7AA==
X-Gm-Message-State: AOJu0YySGQ2MMMpvHLMYHF+/CdkOFWu66ZIFgHpauQPAWZH/0GmYN5p1
	N5KV83qcT6X3GY4ATVWT3aaU3EKeKOpsOvXLMEate3jRSm/GZgZjsNP4
X-Gm-Gg: AfdE7ck49SO4lS/7VKOuAR/oQCOAtiOzTOFoZwle6DLU289m59yDgL1WuhtiKvIOr17
	vNo/dZkp5/yivZ4QOQnDqBfb99pGDLKjidsI4LacuMSI4HtKgG8lvIaCF1FRr5lr03LeZ2DtK4E
	5Xo1g8og53nAjPktWjp3mQqOk0JK//aTnvtITeG67a9XcLJMKlozc3LfBhcOKyLsSRRPezBN6Lx
	FKcxe8lqSfCdsqDwqk6O+Rnw9CD7eDJWq4GLsJdC1wW6x39K41/StHbmEmI9HmflrDNWvFI4pl9
	PFCZTAz+NZQlkhmPfciZQCoMkoL5fco/sSswH6ryaN/DdQXQ/q1DSjIxRyYG1gOqnTQJil4Faoe
	hZZoIFnWFk2c5Ltnkn1LSOzVPy3PLuVeigC4k3TrvWnHSR8HfwTRf3euJPEUTwvhYblS3qW2pD1
	U7IRtGOqsUxuu5I+PCiBPEaPnaLOq3aPy79s4=
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:6c08:2842 with SMTP id adf61e73a8af0-3c0bd1a82abmr10253601637.49.1783615678611;
        Thu, 09 Jul 2026 09:47:58 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c4ddsm35709287c88.1.2026.07.09.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:47:58 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v1 0/2] KVM: selftests: SEV: address two TODOs in the SEV tests
Date: Thu,  9 Jul 2026 22:17:49 +0530
Message-ID: <20260709164751.621326-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series fills in two pre-existing TODOs in the x86 SEV
selftests. Both are test-only changes; there is no functional change to
the kernel.

Patch 1 adds negative coverage to sev_init2_tests: when the platform
does not support a given SEV VM type (SEV-ES or SEV-SNP), it verifies
that KVM_CREATE_VM rejects that type with -EINVAL. Previously the test
only exercised the VM types that were supported, so a mismatch between
KVM_CAP_VM_TYPES and the actual KVM_CREATE_VM enforcement would have
gone unnoticed.

Patch 2 makes sev_smoke_test capture the launch measurement returned by
KVM_SEV_LAUNCH_MEASURE for SEV and SEV-ES guests and asserts that it is
not all zeros, instead of discarding it. A full attestation-style
validation is not possible from the selftest (userspace does not hold
the transport keys used to derive the measurement), but a non-zero
check catches a PSP/plumbing failure that silently leaves the buffer
untouched. SEV-SNP uses a different launch flow and is skipped.

Testing: built and run on an AMD EPYC 9755 (Turin) host running this
tree, across two boot configurations:
 - SEV + SEV-ES enabled, SEV-SNP disabled
 - SEV + SEV-SNP enabled (SEV-ES unusable)
Together these exercised both new rejection branches (SEV-ES and
SEV-SNP) and the launch-measurement check for SEV/SEV-ES, plus SEV-SNP
guest creation and launch. Both tests pass in every configuration, and
checkpatch is clean on both patches.

Hemanth Selam (2):
  KVM: selftests: SEV: Verify unsupported VM types are rejected at
    creation
  KVM: selftests: SEV: Sanity check the launch measurement

 .../selftests/kvm/x86/sev_init2_tests.c       | 23 +++++++++++++--
 .../selftests/kvm/x86/sev_smoke_test.c        | 29 +++++++++++++++++--
 2 files changed, 47 insertions(+), 5 deletions(-)

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.43.7

