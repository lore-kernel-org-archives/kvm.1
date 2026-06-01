Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713438B7CD
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303246; cv=none; b=E3emOTg/TP50oupQN3qvK00qRVZwMZq9PetfBqsIKPkyWSkowgDKcEqlck8zqeHoQcauZ4n05Ga30kS5NuCnsHAt8U6UmEyARP74CCx+6y/mhq1s1z3hZKfTe2NnJs8zt+Q1mgC2vLsl30kUc+tgRXrkMYxMt0nVFCAzZfKzLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303246; c=relaxed/simple;
	bh=cv2+u2g16bKW6cttSGvgPuxUbJctbV+2nzyrkjnxCq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sm0xUj20LIXPnASzv+0TA9kvNcDfbZdezv8bQE36iGZyuxCcLczhF8pDmsOzcaqm1+M99vsbZLLyJdP/tY8j6bTFBwhJ1KerZp9PfWzViyjOWQ2ze2obbB+g9RQw2LKJXh+0F0RxlLuxNQdtNiJFoZ0R9p9awvnr64uQnFN7RwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EiZIuo7V; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EiZIuo7V"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304fb780deaso1830021eec.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780303239; x=1780908039; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ll+oI1aiVo6jQ8q3ONEacIDuvDvctWXx2EoHq5khZvA=;
        b=EiZIuo7VgMPF+ifrJGdo5WYs1aGUhuk8G48yxMxisWKiPlZeoFbViTrjwkA/rfaZid
         1RefurVVKJnd3cd2fhKEXLazHboNvrvSP54lqIZNe8CYCcODbYu49XwJqtdQ0AMtJjAF
         O4hvAbHYe+ws7i091Cv3pe+5yQuNQTZpPRzeiVKCeWtxEfuCOKnGcQWPfBHYsICO0foX
         7WHQun05Ujmi2+XhfRYy6Aw+lTFf03SNLVuvotKR4JLN7hQAHOVQCGlTysWnDwhIgUPJ
         1soRPphVCwtg1vvS5pYSx0ITTCQUOmhheUlE6XGtlVgpoI2gX4zYSh+y+DzwCkc0pEXz
         U6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780303239; x=1780908039;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll+oI1aiVo6jQ8q3ONEacIDuvDvctWXx2EoHq5khZvA=;
        b=tXuFUK5bX87sVgovSz3+wY3nNRQfTr8Stkwr5ZQegLOfAdER+ydebVUtPfUYTwSrWg
         hFFXrBoPcoo1qy+WqqnL9MEomZ8ElCcRIAbjJVWQnygesXLlFvM3xu2S0MarzojoyCNB
         v9S5Y1bPVsMzNRShpPjbVwkjmfamAeFg3gJOLMeqLv4nYYJX2y2xKjc0Z6mZjZvHuyXR
         c647wTC26dyaDwnnxQ+qfa9QWf/o85s86ipjoOpBL8LEhklYH1qx8xhwqkbZCAJa2TWP
         rkEN/c0isAMIscxQ2HDcH3tsu167J52ccT71f+51sm1RsCCIs0+bLv33v1GqUzEmNws5
         4Qjw==
X-Forwarded-Encrypted: i=1; AFNElJ/p8W9E3Al+/z4f1hM6mK3t4n9D5euYKvq1yYOVjW0PS6SpNjevVwmn4PIUOyLncNezBAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+2abNm1l6Fqb9qZ7fuxswDbGwum852cLBGAmyQuXM2B1Aum6
	6y8jsleX5ndf3wMcXr3ie+ubUB5iWApu9ySWq1vFuFAQ8/Zyz61EmkGMW+zZX9alnW7wkF1BwKY
	rZxhXn7tj4UwbYzcFph0PG1Yp4RvsawCXVLSVqxN9hBwndEPS3XO087iAwb2tGkG0GRNEktRl2q
	SAzl/1HM+Y1J6IGred36SBotYBz+wZLvscwV3w7LN4nt0=
X-Gm-Gg: Acq92OEE54XkLI704S5XW+mx5aXti7JfhSzojUlvF/UmR+F+xg9wBS9SKI6/ZAxZXu0
	y+s2lhWWjW2xqqK0vnvbKI+7IbStysTVZFt/lHaQ0VOpZ2UU/rfKb1uR8EyfKrEnAg27mzxSJFF
	eZ7UE3d35aFYeV33yOgiuJ2BuPSfoxlHHnFsvUn2Vo+Zz8kHuN2+1Zu9GtxqPhn7K/T+kBWd8f9
	7/QfQ0K+9m8ifgiaTBO6NSxXQktL1AFDl6gTsq+BX+Ml2Wb0OFgThdiOjomE+YwZHS7pJ/14E/0
	2zLtM8epxFWVE3jhb808Yl3byM85CTC8eIqFYV+k18s9hwgwOsFyEwq5a/tLLNknt7kp5tL4m7G
	FuEeUqxsXJuE53Jgqy0e8epmtVo4mWmwLDKhKjWXfFCA7oFU5vo9a0fOYsf6wrhFVNBPeY/19e6
	LLft3ENT68w/QbppqspZ10c0u6BfERoSp2j8gHJMEUWEklUk+jayJi6AEHARkupuQA
X-Received: by 2002:a05:7300:e683:b0:304:6139:5a3e with SMTP id 5a478bee46e88-304fa6c856dmr4249256eec.34.1780303238426;
        Mon, 01 Jun 2026 01:40:38 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8011818eec.27.2026.06.01.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:40:37 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v4 0/3] KVM: riscv: Fix stale FWFT feature exposure and
 enhance selftests
Date: Mon, 01 Jun 2026 01:40:33 -0700
Message-Id: <20260601-kvm-get_reg_list-v2-v4-0-c88abc81ebda@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIFFHWoC/32NQQrCMBREryJZG0nTNG1ceQ+REuNP+9W2ktSgl
 N7dpG4URJjNg5k3E/HgEDzZribiIKDHoY8g1itiWt03QPEUmXDGJSu4pJfQ0QbG2kFTX9GPNHB
 qlc2lkpk20pC4vDmw+Fis+8Ob/f14BjMmVWq0cTm453IbeOr9f4hhtFSCacEyUQi982gxwMYMH
 UkXIf+UVL8leZRkJVNS6apQyn5J5nl+AefyIuEOAQAA
X-Change-ID: 20260526-kvm-get_reg_list-v2-f9f36961ac6c
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780303237; l=2947;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=cv2+u2g16bKW6cttSGvgPuxUbJctbV+2nzyrkjnxCq8=;
 b=QEFM2HnqlqG5bHx3IhEROh5SwyPigoKja7/0XOoScGW5b16NGP83UspWRkyDguvyYkMGfrzB3
 3eOybZtDXYOAptXjGu3eEokQHAx1Pp+Uh/tkZj9jg5Zky2T5bwI43kc
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

This series addresses a bug in the SBI FWFT (Firmware Features) extension
where features could remain exposed to guests after their dependent ISA
extensions are disabled at runtime, and improves the related selftest
infrastructure.

The bug (patch 1) occurred because FWFT feature support was cached at vCPU
initialization time. When userspace subsequently disabled ISA extensions
via KVM ONE_REG, the cached support status was not updated, leading to
stale feature exposure.

The selftest improvements (patches 2-3) enhance the get-reg-list test by
refactoring the extension sublist infrastructure and splitting FWFT
feature testing into separate, properly-gated sublists.

---
Changes in v4:
- Rename the title of cover letter
- Disable preemption when running try_to_set_pmm() (sashiko-bot)
- Remove check_supported_reg() (sashiko-bot)
- Link to v3: https://patch.msgid.link/20260528-kvm-get_reg_list-v2-v3-0-170969a8599f@sifive.com

Changes in v3:
- Restore 'supported' field with init() callback for initialization probing
  (sashiko-bot)
- Add NULL checks before calling feature->supported() in all functions
- Fix isa_ext_enabled tracking logic and restore isa_ext_cant_disable array
- Add sbi_ext_enabled tracking and enhance dependency checking (sashiko-bot)
- Refine code organization and variable naming consistency (sashiko-bot)
- Link to v2: https://patch.msgid.link/20260526-kvm-get_reg_list-v2-v2-0-7940a401454a@sifive.com

Changes in v2:
- Fix FWFT stale feature exposure by removing static 'supported' field
- Refactor get-reg-list test to use unified extension sublist macros
- Split FWFT testing into per-feature sublists with runtime checks
  (Andrew)

To: Anup Patel <anup@brainfault.org>
To: Atish Patra <atish.patra@linux.dev>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Clément Léger <cleger@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com
Cc: vincent.chen@sifive.com
Cc: zong.li@sifive.com
Cc: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Yong-Xuan Wang (3):
      KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension changes
      KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros
      KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublists

 arch/riscv/kvm/vcpu_sbi_fwft.c                   |  34 +++++-
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 138 ++++++++++++++---------
 2 files changed, 116 insertions(+), 56 deletions(-)
---
base-commit: c7832534a8160276cccb9a8cc8cafb5614c579d0
change-id: 20260526-kvm-get_reg_list-v2-f9f36961ac6c

