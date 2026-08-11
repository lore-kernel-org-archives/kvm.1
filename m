Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228392DEA74
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421354; cv=none; b=JkRE83wAJJ0SJgE7si85opvZubfx/Lt6OgM4v+vJXPrG7/6ngpW5v65FHtZYxzDNV88DOhdNVEYOXwDMku+qaJimJmS6vTBov/fuo5BfKvdIcraxb7T8LRvDywCX5yeNwN3rQ8f/ok5in77pUV4fDJdB7yJJI8a6SObx+6LE5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421354; c=relaxed/simple;
	bh=UCB0aqX38bCGfqeb+Q6Ir9SGHftrsvr77s24jRVQ2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JykrTCRjLqMlIPoz6yiOMHBCDB9GrORZZaQsBJOSnxDOpjhgkp7SVgN8X9FyCpgZj7uoOGqP2yAumbmB6sqEn2hcxONFzTO6EhOzzDa8b+qvg1D6N5woLU8/XCYZPqPxJH89VOjBPztcPzGptq4J1VkksH7hIY5grTJNRJylnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVTLis25; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVTLis25"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84867f07d63so3027833b3a.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 21:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786421352; x=1787026152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWXHO5w8Ni1sSCNzQtBM0h6+HBrXqed94gT9w5G/cZw=;
        b=pVTLis25uzeyFH2lKSc4q+/uaC3qM5/OpyXzbyoRblnXxf4wfFrP1KaFXJkt4BxbLL
         YsqJDlD6pyPSbAjGFFKRM3LL9TEgqhKiTtjs8NANtjwMyJLXR948V2YhhZ8rRclrVtQb
         /opoRk5O5o2ACsGy6OtSIKIHJ01urwjtZEbFoNz3ngWn/CVIXZpeENI1T6bQHcvNzvLz
         Ifm4Ae55bApxZ/pjKV4NSkx9Z5G7ArU5eICC7qWOZHwqa6Fmzh6IyKPTWX+rwclpYVGq
         c4RQzPz63IcoTVWPaGN9OfmPXJypchsJRENY0bCEEYZ9YQGwzWlmUrUjNooUaefLIOko
         JzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786421352; x=1787026152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWXHO5w8Ni1sSCNzQtBM0h6+HBrXqed94gT9w5G/cZw=;
        b=dirx/sXPCb0Adjl2b0mE+ZzepejXRYLRAhGyPdWO8mizGH/KtbfX08+YMmuIMp4OYy
         OteDGW3Z0S98USUIF4I2T9aDP2pWVn+ZDwVmJaGKCh9mcHnQGZXDeY3Fb/elyh+UJz8p
         Rb/Cg7RmvJ5FntzEHx9LdEAfTenuCY5NRE0NS43RGEMsMleg6K+wPcdnHQK54VwmF1IM
         kR6n33Yro44rUKySgEKeOmDwukFqaC8MsT4pKvvfpF/AZNgMhgc/WcExwXnvriFqr3Ek
         UjFUwkubZ4LL33GswReJA8/Nz7GjtJrgCm0Lw+CWWZY7uDUPgXQz8cdoypCLtY9kHO5f
         vBzQ==
X-Gm-Message-State: AOJu0YxkXYrcuD1l6Gj247u6HBV4LjnacWZvm2ZJhmrztXUd3wD1kAWK
	4N79brI0lcZjyFBpZwsCfjV2RwFhziWwf+KcOjoU8DmG7sgnf1YsQSFmxyWmbbHlETA=
X-Gm-Gg: AR+sD10Z9thhMoXkEJhyebB/GYm//tfLV25U59Z+JboD+u6xMvWxxdsG4n6VK3i0NwD
	eWjlxWwBaj1zJDi4zjDyViUEmm83K5YivqtTtu6JgU/TJuIVEK5CjNub2uO2E7M2uAUdqaFYYoy
	CmVJ6aTGxWjoIMzA54HlnE82HA/bBnM5gZ+P+NGrahnuo3yw85G8WVfXM1e6rcWOJ3ptP6h8D3/
	CzxnY92sSYUTzEdxT2CCdRvCF3Im5C5AVwRBtrx+OmMHJqe8j/uzHqAs3KCZbPVzowSqTkNhBi1
	ee0JP520OwoBH1a26imvPaR22mFA2Ka6sixOr57ECdFLzZjHGcjwUCFGhIBhtTGo6VAGgCmTUml
	nax1bvT6SFSwa3LU8NnP7TKVjNMrViXLF1VZBjDQIvcEdY2TVjVYgLT7T4+JnCCEH1HSevNwAmd
	exXXr+YzpBDKRkwpFcubjWdMX0/uk5Fw+4FRc4/XuzINdvx4BVbwD1hKxLD+rshrAZMqsRIiTBW
	h38hCVWxNA=
X-Received: by 2002:a05:6a21:4cc7:b0:3c8:e140:63a8 with SMTP id adf61e73a8af0-3cc2ba60827mr877093637.23.1786421352444;
        Mon, 10 Aug 2026 21:09:12 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c65005accsm29307eec.31.2026.08.10.21.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:09:11 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] KVM: selftests: SEV: Sanity check the launch measurement
Date: Tue, 11 Aug 2026 09:38:57 +0530
Message-ID: <20260811040858.1984593-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces the TODO in test_sev() with a sanity check of the launch
measurement returned by KVM_SEV_LAUNCH_MEASURE.  A full attestation-style
validation isn't possible from the selftest because userspace does not
possess the transport keys the PSP uses to derive the measurement.  The
check therefore verifies the firmware-reported blob length and that the
measurement and the nonce are non-zero, with the blob layout described by
a struct so the buffer and field sizes derive from a single definition.

No functional changes from v1; this posting only adds a cover letter.

v1: https://lore.kernel.org/all/20260807121308.1885737-1-hemanth.selam@gmail.com/

Hemanth Selam (1):
  KVM: selftests: SEV: Sanity check the launch measurement

 tools/testing/selftests/kvm/include/x86/sev.h | 12 +++++++
 tools/testing/selftests/kvm/lib/x86/sev.c     | 11 +++++--
 .../selftests/kvm/x86/sev_smoke_test.c        | 33 +++++++++++++++++--
 3 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.43.7

