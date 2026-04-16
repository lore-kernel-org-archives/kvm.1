Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA9383C64
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381820; cv=none; b=cfInzzVXtElYSiow9cZVLjrkWQsMAw6SnEeGGPCCPt+ppzsSL9KrJYi7SwsngY46sbLfOoYeMyKqtpYRP9xwDP+mFF9dBZeNFvmElYE5NIGZZd96Nnx4Aw+gH4kw7CbH07OSZLxGtnHzQ/4v3IMb7ACQl4sy64spu2x88AHx0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381820; c=relaxed/simple;
	bh=XTF/Ml6zPKPfWMAwzbKlF2sbnfQKo9ci51FH3JVrn/w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pQZuGXapaeescVevL8dOlix0X5/vzjfFaXoQUq7nQcCnDfIZ8i4nTQroR/z5uvxwwBlxhxBS1iyWkPjn0PnTmUVpPTUN/Kl56r7HbWnUDXbdLlB/evAx6Oiwa7Za5BZdJR0GPtM6KAjV3/PWp28xCP42LnJGTn+loaAuwvuyMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPMU6WdC; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPMU6WdC"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d40278103so70990b3a.2
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381818; x=1776986618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcXVDSVlIDOLEOAoYc9j/aTZ1nVJQKX8oOKennXvDpE=;
        b=cPMU6WdCRW33DdZt0pY1lre09BjuRg2Ql0DlVUa+Pp5aC0NitSBmZbImZWTtr2mtZV
         3np5gYA3N3ipCuJbpwiZ9s2Kz1okQi0H/NWx/DQcnvwcZyyiL0Cz6rXi8ICVeY1HDBv/
         m2+eqvBijVV8f9DIq0DjEAtAoZZ4BajXcC9MgV9YqwaBUzvuXdzU6DUuz2CU61dzqwUy
         lHZDP7e7BJFHFkiF+lyaHbAR+/8E09aoae4JfBIoG9+N77mg14lc6HhqwWJ4WxChGCfb
         YhrN5UEuofmi2z8r8/xTxzE+ayg3k+1JKXSGgzq4gysPaAt1BlAHI1llPdoPRkfnZ4RB
         qVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381818; x=1776986618;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcXVDSVlIDOLEOAoYc9j/aTZ1nVJQKX8oOKennXvDpE=;
        b=cKra7cIJMWHPy2jeOXVkPBkT4MNDqq/ZWhFkbA2j+kYkMMi9HyC7BQNu/jd6j/qK8U
         fltVgmPXfh0PRif2y1O2Uor+maufgIrir1MEpHsYkEJ0A0bWt+0RkaGlQk93YXS9XoVe
         iK6gxRI/1UFJs3AJ1a+s3x4JIC9oM3xqSPGPCgcWfz6v+LyWByt7tegr8tzVmenH4T8n
         +BOZsuCgd5AiiZjM+NFtN3UJZHfBGLBfqnWu7IFOq1syudI7KMOEo1/onBLiufO16oAY
         Tv0GMlKQjx2rfOm3Fk6v0tQgz8ANzOin9FKp/Iat9Z7HmK8MsiyTjwJz8OnV2v58yYk6
         AR6A==
X-Gm-Message-State: AOJu0Yzz/BtDDijwC78PTJ0rXAsfPyH9GSzL+R/Y498SwKb6pPPBSm8i
	hoHaArX6ffWxXKLC4m+8YzIilkV+49UNegxIF1x9vvtQT6FQtinaNP6Jg015dHF/+ot/073tAr5
	UEDgPrg==
X-Received: from pfbg11.prod.google.com ([2002:a05:6a00:ae0b:b0:82c:989e:71f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2c94:b0:82f:656b:afe8
 with SMTP id d2e1a72fcca58-82f8c86db35mr223189b3a.20.1776381817575; Thu, 16
 Apr 2026 16:23:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:23:22 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416232329.3408497-1-seanjc@google.com>
Subject: [PATCH v3 0/7] KVM: SEV: Don't advertise unusable VM types
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"

My preference would be to take this through the KVM tree, with acks on the
crypto patches.  I'd also be a-ok with a stable branch/tag of the crypto
changes.

In the words of Tycho:

Recent SEV firmware [1] does not support SEV-ES VMs when SNP is enabled.
Expose this by revoking VM-types that are not supported by the current
configurations either from firmware restrictions or ASID configuration.

My previous version of this patch series [2] used SNP_VERIFY_MITIGATION
to test for a mitigation bit. While AMD-SB-3023 says that there is a
mitigation bit (3) for CVE-2025-48514, bit 3 corresponds to an unrelated
issue. The correct way to check for this is to use the SVN/SPL from the
TCB. We are in the process of updating the SB to reflect this.

v3:
 - Relocate the supported_vm_types updates to sev_hardware_setup.
 - Report unusable VM types as such in dmesg.

v2:
 - https://lore.kernel.org/all/20260324194034.1442133-1-tycho@kernel.org
 - compare SVN as above
 - fix commit message prefixes
 - supported_vm_types local is a u32
 - move crypto stuff before KVM stuff in the event of patch tetris

[1]: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3023.html
[2]: https://lore.kernel.org/all/20260303191509.1565629-1-tycho@kernel.org

Sean Christopherson (3):
  KVM: SEV: Set supported SEV+ VM types during sev_hardware_setup()
  KVM: SEV: Consolidate logic for printing state of SEV{,-ES,-SNP}
    enabling
  KVM: SEV: Don't advertise support for unusable VM types

Tycho Andersen (4):
  crypto/ccp: hoist kernel part of SNP_PLATFORM_STATUS
  crypto/ccp: export firmware supported vm types
  KVM: SEV: Don't advertise VM types that are disabled by firmware
  KVM: selftests: Teach sev_*_test about revoking VM types

 arch/x86/kvm/svm/sev.c                        |  40 ++++---
 drivers/crypto/ccp/sev-dev.c                  | 101 ++++++++++++++++--
 include/linux/psp-sev.h                       |  37 +++++++
 .../selftests/kvm/x86/sev_init2_tests.c       |  14 ++-
 .../selftests/kvm/x86/sev_migrate_tests.c     |   2 +-
 .../selftests/kvm/x86/sev_smoke_test.c        |   4 +-
 6 files changed, 163 insertions(+), 35 deletions(-)


base-commit: 6b802031877a995456c528095c41d1948546bf45
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

