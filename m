Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300DA44C674
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519529; cv=none; b=WYuTwMmSK4kDi6RGPQYy/e99nonKGbG1O1+23dhdR4uoMoZGtxN+26AYYKg4MYe7Bq453JGPvGFTZXR7tFjS5jKEoU/8sS6M86eMArrH5f3yGX5iYPzwZg2Hkd9fvAf/u7quJ0f9kb8xPP81AiWjg6U9xCmIg3B9oKEegMZbQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519529; c=relaxed/simple;
	bh=P9UMYWbtzdwQZFlzLRIZV+ZkrpzSHaARpENaclXt0RU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C8ss6LGBE5Bdz4BYFQyPhKfCGZZaUg6bh2B8XkHk9zif9MqxsYWFrGj+BVQ6ZODf/ZaIIHq+LWSAZwbIF80gDuJvuseawCMBvKu4QSjhFqai/NsL1W69LL1PvRWQFupQbWiIT+luPL6OaT/u4d1Mei2uA3x+WmB9VwcvqmKIicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wcw6mZDR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wcw6mZDR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2329704a91.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519525; x=1786124325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gqFEN9SNh9XdHmsXGDCS9ctdoEOLW1lYemPfuTEo4Fw=;
        b=Wcw6mZDRmr595mX1iiBjDUCErVYxUx5CQ7WUEviTENp9O/daT7qoRwriR8cJt9IoHQ
         zkmTvj3KbQk2QXCzNEcORyU9O1vtXuW9CGPLtDakaw/UYNakSSkilDdOsVlec6QIwpSS
         m4B7YSpO4rqadM0Sy6yasW8mNX81rAWGKzVOYg/Hl9nbGOC1n3KrDdemBnGStoYL/wMv
         TYovOLGFNxmC8J41/pi6l0fzZ7j63Y/YIFxi1hXLPCT2Hjj88v74DrbZbRKd9yQF/5Cz
         kBe9UKCU+ZZ/+jkUgurSXJwNAjJXY+UUfDAimM8ksAgjOMTF2I87jpfAm6RzrJwVfa2j
         3tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519525; x=1786124325;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gqFEN9SNh9XdHmsXGDCS9ctdoEOLW1lYemPfuTEo4Fw=;
        b=eZTuTsEWsE+y1QHFRE6x5lpTrqZem0IjASFxiWmbeVVD5WjDuhZ+xqik3Jd+/M82Kr
         9KhKGN7hoSVkgnYoEaxp/QfB+VwT6jnL5gz6FREwKJcAd52fRtbzTBYpaxUWb/UIlnRX
         OX4JaXcw+knypgsK7X52etyVljVjxCmvSVSPWPVkGT6AtZcHBR9w51X8Uh7GGn1jw52J
         U434TwNjsbF236+V8ka0gvnD/dTjAccVMatggQF7alaFoQHtYqv+izRAYSM8+zvrYbdE
         XEz3RV/pa0XWpwVIgMdGzBNrBbPhkU1haVgCVOE3smPIUg7Bccm67ZYZ703X1c2we0wR
         52hw==
X-Forwarded-Encrypted: i=1; AHgh+RrKuCoqg6E3BieV8Zy59/gArX5/1K93U96hP2flbaPMQfVeU/IDsx6Ufhm2AckKaEdXrnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyCNRZ+E/N7QBQmViKNrRTerBu7kGQxUcT4tvWarp2TLmJBzd
	p1hR2PhdnAxlHwTwMYCGZ+diyxCD4epbIghKTAwdG41UECEfa7qkgTSn8NEE2UjDqbxhTMjaMZM
	jBIc6Jw==
X-Received: from pgna2.prod.google.com ([2002:a63:7042:0:b0:c99:3b68:c9e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a26:b0:3bf:6222:2e7e
 with SMTP id adf61e73a8af0-3c92a51779fmr667501637.4.1785519524939; Fri, 31
 Jul 2026 10:38:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:38:37 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173842.2649391-1-seanjc@google.com>
Subject: [PATCH v2 0/5] MAINTAINERS: KVM tweaks and additions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

A few tangentially related KVM MAINTAINERS updates, details in each patch
(though the shortlog is probably enough info in most cases).

v2: Collect David's acks, drop RFC tag.

v1 (RFC): https://lore.kernel.org/all/20260428171541.1342335-1-seanjc@google.com

Sean Christopherson (5):
  MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
  KVM: guest_memfd: Move gmem function declarations to dedicated
    guest_memfd.h
  MAINTAINERS: Add an entry for KVM's guest_memfd
  MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
  MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry

 MAINTAINERS            | 14 ++++++++++++++
 virt/kvm/guest_memfd.c |  1 +
 virt/kvm/guest_memfd.h | 34 ++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c    |  1 +
 virt/kvm/kvm_mm.h      | 27 ---------------------------
 5 files changed, 50 insertions(+), 27 deletions(-)
 create mode 100644 virt/kvm/guest_memfd.h


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.55.0.508.g3f0d502094-goog

