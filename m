Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399524D4886
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017777; cv=none; b=jPZQuSX40HcXAwDvrBA5bgGNhABMqG3OaIziYlVE9QScZDeaxzY0DCSASGdQkjTFqFp/b6Nah64R0fKkXTNaUsdpc3S8wUn4G4MV8Qp6sSWwMsjA5rCoqKggCTtK8x0HZbBOanXiJYH5kWhUccVcSFNwC7QWybZ3zGv7a0O9leU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017777; c=relaxed/simple;
	bh=wT1o/FxZXPCVJocG+G7v9/SvXhoQPw/SLYSAZuA+Cwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpcYIplh6isuYUM7sSNyJM5UsSe33X5s+S39DGvMdOqM+ntogUV4QlDiiae3M8Jkqypo0Bos5ksihPQ3mQv6oD6g9tUOvv4bS0rih87pDyBatAghou8a3QWmxLVhZtVVdzrik1go/sfnBTvWWS7kXaRVcyFLlppzYwiTAyf2rvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=QrbdOEzt; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="QrbdOEzt"
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E8C23F8AE
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792017772;
	bh=WBIhOlBUrb5LSRkLKCzEi1n3OV1RnmBzhcsSOFSLY10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=QrbdOEztkpthDG5ij8p7XL/JG+2FpXXvcTH30EXToLzFo2Lj8OncB6MDEE94KM0IG
	 Rb5UxVKuo8PGpA3dFrfNTNLNZaG/UDFAS3+icQgOAN4pGw16KqJuiM2rZ4Ik0gEhfN
	 y39jaFTE6qS0pbiMYeZSwlyaOfJfdD/PA0DJRyzvvxPRmpEGhzSFEZe+LCfnAWZ6lf
	 Xm0bfPXdODUQ2f6ow3eWaW5uIwwm0HKJQ7vQcUnAuL9MYqJ3GkDMYKHk7E5QHI8cF2
	 QAN1FGU9BotGU6wv5b/wVUhEgB/FgjRjZsXulCONVV+UwaTNDEIC7s+yxnV3Fo/0ty
	 rmRWFjY8MjiD7076JWVlRb+GSUd5hLVhBhUnVYPnkugrkf5tjejsu7wGqm2sddfLgs
	 yC0QdND9YU5qY4I8UdVPwhbYLXO67Y/SbbyqDFJZHb2Ip4wWaWgTAdeyRnhNSYIddL
	 ZBQXQtqPSdZwpB4TkLt0jNQtQd0/7vSITu6two5ABIWn+XVkf8OmiXuL0l7wUg0WPL
	 MWYdOuQdBBPOySSunDLDnnb3ABZ+QnKEyVjdw6Hr7gooa+/mKqtuLQK0Yl8n41MdYH
	 ZhnkUZTfrvu30Jv7o4524iXVLHn3shYwub3Z/O0lG4aLtYc67JB3yJvK8bayKAjZzT
	 StxNgZ3J7m0EREStNjiXqw7k=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a0228f4a1bso26993775e9.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017772; x=1792622572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WBIhOlBUrb5LSRkLKCzEi1n3OV1RnmBzhcsSOFSLY10=;
        b=Vi5cMdFLf51tOArG/ZeEFPUCpG7Op03I1CNyziy2sw2HrkeKz630sZC8hw+Yrc7vof
         QdBWF1gMWD7I+aor0X6mUpqC5y9RcNMYVrzyhiXGyqH13nNOCKAsMKeOEZssiFvF05Ai
         4mac25Ib1I0PzGVQR3Y+AD8Z8WI6l/+Oj8lCUgw+Z+RdHSqnZAXpCj9/sollhD+0C0/9
         APjMT1HiUCk1kZ/TFH7owPaNhqian74zLbLwNgy2GLEMNNVw4fziFVYJqgc2HbFjhy2C
         uLDT9HC5Zyt7KckTLdcZswNsOLT8NqIIcdYVt6+7Anws7uG3XQ/eWkyncrszuWR/KfI/
         ENKg==
X-Forwarded-Encrypted: i=1; AKwUvBxhF+rLS+2IBIT6pbmZ+PvJYic9M2XZLpuqL4nDE5zunJBxXy9CKH6s20ftLP7d3JY/Ya8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd3WImbNjG7AOb1F2qBd7hdY7l+Qs8GUPEutjk9jVe6nJ9D4uZ
	nzkw29h+7V5dCkoRoD0G7SeDdvSNhgXgt2+PGXKPUyimJG5ownIBU5zbT2s0QWTBlbD3bpkkE9l
	e5mhKKyHHknCL78kTbFn5cnhjPI9baCavOlgJlQEgSpHN1Vn8VncXjF3TeP0AsZbpltS1KYv11v
	F7IA==
X-Gm-Gg: AYBFou2RV7FTGitBugTdeSyO6+Vi3IgCwQHT+uWi4zv95ETVRZge+mC5B2sdiX1Qitp
	llyixJVDAKWTl0UIfczSO6bqnrN/YG3r0wNnJSu636miT9ACeHQAMu3357E+O1YBinzKnNY4nTX
	tzvAVZFWudVptpPP7tGPzRMTqWnCOoF92wp5Q/vxxHLdbxTnkiBQlvAAFKNcH3mChKsAxGBMJB6
	QnnQwixA7R/+LmFvzW064CQnu/bk2MOJLCkY2btPNvHKXwn9k2ayH+FRV9GfdpGQxQiR65aflBN
	65LOh/NBig3uafil9+oJAyUaaFz99GReVmMFiX4Y4LatiPJuNIJalJ25wI+kHO4ktRvpJ3t+TMa
	Z4GjFJpfWkMGSm6NGwh7OcaReQYmGZhp292S28e2tulsTCyvrx/LLz13m
X-Received: by 2002:a05:600c:e556:10b0:4a1:93fd:8f2 with SMTP id 5b1f17b1804b1-4a193fd0a16mr194079855e9.6.1792017771976;
        Wed, 14 Oct 2026 15:42:51 -0700 (PDT)
X-Received: by 2002:a05:600c:e556:10b0:4a1:93fd:8f2 with SMTP id 5b1f17b1804b1-4a193fd0a16mr194079785e9.6.1792017771721;
        Wed, 14 Oct 2026 15:42:51 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:513f:8595:22d1:d25d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bf63567esm23227965e9.10.2026.10.14.15.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:42:51 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Sarah Emery <sarah.emery@canonical.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] RISC-V: KVM: Allow Zicclsm, Ziccamoa, Ziccif, Za64rs in guest
Date: Thu, 15 Oct 2026 00:42:37 +0200
Message-ID: <20261014224239.963635-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension array to allow KVM userspace to
detect Zicclsm, Ziccamoa, Ziccif, Za64rs.

This is just notifying of hardware provided capabilities.
No KVM specific support is needed.

Add the extensions to the get-reg-list test.

Heinrich Schuchardt (2):
  RISC-V: KVM: Allow Zicclsm, Ziccamoa, Ziccif, Za64rs in guest
  KVM: riscv: selftest: add Zicclsm, Ziccamoa, Ziccif, Za64rs

 arch/riscv/include/uapi/asm/kvm.h                |  4 ++++
 arch/riscv/kvm/isa.c                             |  8 ++++++++
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 16 ++++++++++++++++
 3 files changed, 28 insertions(+)

-- 
2.55.0

