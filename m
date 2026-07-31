Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA347437861
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785510546; cv=none; b=RRidSWBKsq2j3zck4SwjCjAG4hSC5abwJFUEAP0OxJWGvRm9sw4p2nGVhmxocvAaDwdIQAaLoK7D1MRNZGeEtxCGBmc+SbYVmas1M5o0o5VFzVydsdC/KEyNcPsjFGrhPohUYaGZO3Kymv5YMxYpIm7uPtrz4JrFvQbUhxyuK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785510546; c=relaxed/simple;
	bh=ZLXgSTC1xaiI6a9LalfXnkq5VEO4QKxt9vodQK1/FG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWpE84X1tnhBpriGD8VDlFZZ3ZK1uf+N3adVWnxyXqLlOwAxjALhs34yNbQfDdrxMq25zEJP5WHyyp88k8aoXjSV69STrcOaG1cjvePx7JaZBTZazho5iCv/fEevu0ovxmCnUYN6gj83EgKWA2qsP+6aOMT/YyeDcb485DyYSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ADxyP+uK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ADxyP+uK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1391130f8f.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785510533; x=1786115333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0P+R2A756VjaLeieE8ZcHad5KvFTCwR/lqQP3cLlzg=;
        b=ADxyP+uKVM4UdQ0S9OvFXMFPQKYdm3vPRZNrHYH2IyvV0i2kbFLO7f3tKUMyN5ROYf
         qkguDENLrOoS1mtW6GaIWlwDcsf5HEJWyjAXjkhNGSNQw4+wSfUJypnBLWZ6qr9PrqCr
         Gye+TUTZwZrrH4gaolSkEmK7Vn0+3hxZFq6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785510533; x=1786115333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0P+R2A756VjaLeieE8ZcHad5KvFTCwR/lqQP3cLlzg=;
        b=RmxXg6Q7GE+LL6zSta39OMiy0N20Y/XoFufDkRrhbB8o+xR8Y1yq1/0LaelgaAvjOJ
         TrocwUeFCcT4cd74ptPagvpMiXK/nraHTnOmfi346du6xuWvUn7GBAqv9f00hIJ55KI8
         ja4+D+kKbOYZ80G6u/wsfpIu7oDnfitmnVZ6rF60N33Y6mpVqeRDyan11MfS6MPSFBwp
         7WrGF2sfiud3nlNM0n4UXJCn6330T1hmtjQOTMqokE45P2mHMYaogBczp80iNU7M3/Sy
         R9AOhOR5xIKyMAEivcl5uvgklY0v1ewgd38CVx/oN2ubIAJubDgzWqw+m3ibDJ8iix8k
         R1ig==
X-Forwarded-Encrypted: i=1; AHgh+RpE8z9A+oM+6EQQs9lAb7qUfnNu4tVm+2LAlk6dYailjAs5dA0L7StxLH+dbMT0GbYL664=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZ2boUDzR8fXgNwaSP4W+BYxFzRoKZdMss9sFKafw6sD1lmhs
	zEEiE7Fju5UKciVBYuinhwLvKqGuuJx39wDPbP77ZVH3fR7DBVsY0A6QsGPVZY19lA==
X-Gm-Gg: AR+sD10ztb6oEqtHxCWWIYJolSKphkkndLpnIdhFNdev8sENyyRKjsjPhGNL2gOUO0O
	47YIkKPpfDVj2ReMoA0IydgV8gSd4hxS7r7uxubP/iWmTFdP7wMXM7sPYdyV1mJaIKhKJ1xONhi
	x3Azn7G8VdgWWpdlSJXOPH4bVAPZjTUJyc7SEV+dvAl9spmpyI6XizpRKWd62QeO3xM8jwmCiRe
	KRhUBOEgAd2wqAz2L9n6Ac43YniJkJBI9qGcQy51QLzIhZ88bLlaPM/rstGqcYneO5xj8PFkMm3
	JY1K5NjpX6aNNMG3/0qMRr5N3k/r002LvRto4lkiksEbmQtR6qEi31kA9EombvKduwMQvgugZqU
	fl+9m7yg3vVTZsP/HzcEw4yjnhZdyHnJ8bleNTNWKuC+tyM5oKyXHBuC2VSqOL8Yi6VmWJIaoY0
	g6Kh7DltPoD5F9SKM26ZBir+Rt2s0hE/Q/B1Ju/DRkIfPmTk2xtUvBb0CT3Hj+099CxCfdEU1Et
	vhN6RDZtywKdCaL1pc6NZmcglThhHzrcr2jcJTKYagVpKyqkmdT2VQfMoArrv7j8Ac=
X-Received: by 2002:a05:6000:1787:b0:47f:673c:42cc with SMTP id ffacd0b85a97d-47fd72c3732mr37783f8f.27.1785510532009;
        Fri, 31 Jul 2026 08:08:52 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm5647974f8f.34.2026.07.31.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:08:51 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@grsecurity.net>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2 0/4] KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
Date: Fri, 31 Jul 2026 15:08:41 +0000
Message-ID: <20260731150846.1728164-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_vcpu_ids and KVM_CAP_MAX_VCPU_ID are exclusive, i.e. the maximum
allowed vcpu_id value is max_vcpu_ids minus one, not max_vcpu_ids.

Fix the sanity checks for KVM_SET_BOOT_CPU_ID and KVM_CAP_MAX_VCPU_ID
and the selftests for them (added in series [1]) to fail when
bsp_vcpu_id is incorrectly set to max_vcpu_ids, not to a value below
max_vcpu_ids.

Also clarify that in the documentation of KVM_CAP_MAX_VCPU_ID, in an
attempt to make this a bit less confusing.

v1 -> v2:
Split selftest fix into two patches, to avoid interim breakage of tests.

[1] https://lore.kernel.org/all/20240614202859.3597745-1-minipli@grsecurity.net/

Dmytro Maluka (4):
  KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
  KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
  KVM: selftests: Improve bsp_vcpu_id and max_vcpu_ids out-of-bound
    tests
  Documentation: KVM: Clarify that KVM_CAP_MAX_VCPU_ID is exclusive

 Documentation/virt/kvm/api.rst                  | 13 ++++++++-----
 arch/x86/kvm/x86.c                              |  6 +++---
 .../selftests/kvm/x86/max_vcpuid_cap_test.c     | 17 ++++++++++-------
 .../testing/selftests/kvm/x86/set_boot_cpu_id.c |  4 ++--
 4 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.55.0.508.g3f0d502094-goog

