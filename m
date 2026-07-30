Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A244607E
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435875; cv=none; b=I/DZ0E2ikPC7ADZexn0pIPk6uN9F78VAEIBjS/Be/VmYqhZ/kwr1KmB/JAMEiDLEndnYtKmQyElOacoDIvg5OqYEmqSGea8LMKPnuaeyMB6H0d7g4+ZIMHTF6ol92rSZjxaCKAU1vpRfuCkNEmc5PY9rFmLhavlU7VzbEItr630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435875; c=relaxed/simple;
	bh=WmC0rz+Iq3rxPGrf8sHcUVcKnqR8nA46jesqA2w8hOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pRdTyRYl9gzz5TAYb3cK7rAunNNKBhvPLx5bVYn3lRX881thuxw157sChB6fif3dIZ0+QGv2Jysb4BUjY20a49GsPlzkt02PL8bKwRMtai2nv5os1qM8ArZfdfndX53wtUJAlSKTSI9GneeCcRezlH+W4ldXcqdlT/25DgDYT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FjJ4Yi3o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjJ4Yi3o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so474795e9.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785435871; x=1786040671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PWg5Br4dovuA6zfdYwI8dsMXvZRa2U86H6MD/QZgnCo=;
        b=FjJ4Yi3ow4AvKLMqQ61zzq1S1NFMu5d2UFAk/QaIdIGrQuK8lFzbJBP+bt5KVQxiJe
         M2LJGMPC4U5MT5zHY6pEpnHnOLOR4egQu8+vRGg6dJdKKl6icCjfL8ImlvTlE3JYebkd
         BFGN6DYgpMbMHHgRyx/AA04J7RON+I1tX4Nb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435871; x=1786040671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWg5Br4dovuA6zfdYwI8dsMXvZRa2U86H6MD/QZgnCo=;
        b=Yrko3WEsrgx9GDwtOBQCGH46STLqmrX1e0z/ZYFQyrqHYBFXEqi06gYmVQ8Gk4u1oc
         vcFq/Cr1hyICZWuEfjTiLmEkAPagFy058nYeekJiQ5m7bGqMGv+9BklHHVr1lEmrkqtX
         CTTdweii15Z/zhu9zBmUO4bOrsGJDMYjBpmKhK5iK7gt/HG7UtYNKdQu3eBOgWIXzQJG
         kNV1oTRDCQTHsx3z23f4PDCLfkP9Oc6giHrfEEM4MlxVtW8fltm8oPC/K5TeCTiMjUTx
         y+X7auJC7kpwWWtHVbpNugpjlKxgqgKlmCBpyeDHm1TO41h8I2NXvBjZQM8+Dw4KGhlo
         0+Zg==
X-Forwarded-Encrypted: i=1; AHgh+Rq02b+4kmIXaqFqf5dYyrx4X7A31Ctj88VfM6HNRSY7jq0yJRXHiVj+XAFh0blIafX4tTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0ziNzD1F7xDNKvUUtTgZL70aiPWInvXlGaFb09PMph//EjGf
	coqdZGEQTTunPparZptdBYS8xu/V6N15toYEOk6l50Cp0GwE/brb84SxhU9IBatInQ==
X-Gm-Gg: AR+sD11Yzf+svpI9yC1aP408cT/YnzXlcrDKTDCl0o29epzGAujH22YCaZHERNVvS51
	W2WfFptudkJfX/VGlLnJAM4Vg39Sfx5orraZiR/DkoRDwYnG06yLePGnYwdmc9yZ/3oGwTse+jX
	/b44i6hEkZDdHtQibV5tpvODyW0qVUMVnrl2T+E8ENFhG7qf6iwsBPcUan7mhQrLsqhJdFdqJ5i
	8HWIUdpfZn8jcgyiwqDQp5hEI3DfWXpMeublc9L75IPeLjuvhBW6loTXiuL4c5glKnMREEcUAwi
	wf3s6bMytaGOrj5zR2srNStI4sChP/eBV5qwFtkx9Bc1gCsZK5v/3HOGiGq4KFruqENyLBxnLsh
	sJaO+9xM/+dMHRdpYdvwDMUKu/RRV4EHqhiKyMfJdg3BZx0yQ2WAWtUziFKt8enAI58GSLc9flH
	eNYr4Am2RnP9NVXcU4xs0iFzZwjtXdQx/uiyE901dUF+wlyYPCbDWHd7zWHQAV2WnNJrZeAooT6
	u3oPlivNkjumo9HaT8d0WD+JKvrc0aTi+Qlkp7XPWRY1xCoAVZZdRjwz15jtGhfww==
X-Received: by 2002:a05:600c:8b51:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49800e6cffcmr53667995e9.2.1785435871010;
        Thu, 30 Jul 2026 11:24:31 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498010aade3sm84008685e9.14.2026.07.30.11.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:24:30 -0700 (PDT)
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
Subject: [PATCH 0/3] KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
Date: Thu, 30 Jul 2026 18:24:22 +0000
Message-ID: <20260730182425.1223530-1-dmaluka@chromium.org>
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

[1] https://lore.kernel.org/all/20240614202859.3597745-1-minipli@grsecurity.net/

Dmytro Maluka (3):
  KVM: selftests: Fix treating KVM_CAP_MAX_VCPU_ID as inclusive
  KVM: x86: Fix off-by-one in max_vcpu_ids bounds checks
  Documentation: KVM: Clarify that KVM_CAP_MAX_VCPU_ID is exclusive

 Documentation/virt/kvm/api.rst                  | 13 ++++++++-----
 arch/x86/kvm/x86.c                              |  6 +++---
 .../selftests/kvm/x86/max_vcpuid_cap_test.c     | 17 ++++++++++-------
 .../testing/selftests/kvm/x86/set_boot_cpu_id.c |  4 ++--
 4 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.55.0.508.g3f0d502094-goog

