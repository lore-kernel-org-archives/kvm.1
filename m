Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802C390CB9
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309596; cv=none; b=uLI1HNDBkoDVvjRVN+/DLteIr+2Zhna7TG6E/JVK220XDMFTKi3+Ch6d0rH/CHC62k4OQhUZP5nwjaJGeB5tUV0XPXiPoB+n5mhV3P1hiuA8jCFEWFqNBseaeniCwqt3nGwtG2KZzM7+fm+0bqpuuiGvh0iU4aRQY3qe0M0kZ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309596; c=relaxed/simple;
	bh=i22xps6LCObUD2kqUTEDbNF8C3JLN3ZsednxQoPzcsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jEvFgqB9kdy6frSGN0COiQAyjeh54K0GNTOJSojAieTRscuShKu1rAPvb08ewfFZ6RCOzuhLAf5UAOSNaVeuYTJ737eHacjjGFzFI44DWyXU1XXLbBgLbR7ADdCQ02FhMmyGbfYBedHiXSgNDAp8zNRc5sSoDVYdpWiuapMsr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NupZPTNE; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NupZPTNE"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304e58292d3so6285155eec.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780309594; x=1780914394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+2YxV+6v8HxHah8ejk5xIUKcFmR0bUuiOdbEsVMnZo=;
        b=NupZPTNEnACt2rPmSZ2tHUbxyiGQFcr03S1flHmh13BV8at80fPm6AGwt+g+fi6zu1
         woIos6B/kUeV/G22aQGxp8fH8DdYF2Nk6Fzu6iISDVNGUkdbGm2QgitY0GukuAfcuggj
         4wXm1fRb5kz7f9pd1SeKHRixULxiAxEYAYDrDrbE/+LFRPc6OYcDRN/nQd4PMsVjh7GA
         ui7IGJRZzOQjl/8TfuffThxNe9zLJVtCQsQusHoLsARHCM701K6v+qqWG3zR51iAZZXj
         CyuxkojrElwIgbp8oYxfvxowls9B+BYp3b5xOuz310nWnenziMsTzpMl8qJgxmz4mkcF
         VcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309594; x=1780914394;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+2YxV+6v8HxHah8ejk5xIUKcFmR0bUuiOdbEsVMnZo=;
        b=DjbxbvULgZcE9aKZ7JPDhqDkf7G7y5RmuTqEVbbpB7+8pbP5QXRYKf0yOna/lf94ut
         abEb5MAsbVaYueJyoTwLLUyzX5CUke78FZKshh2cM5XNBCNGznxDU0mhAlGWn1Y7M2yG
         KVVjfNGpLNBKlEuUNqsn8JnJchIamB5OC1b1mx3g0DM0V3PHS30vkBluaqoznBuCZxLz
         EyGKfAn9klCeaqclWmK9f82HQNpe06yqtAPkNbSPiChn0HN2uMC0Q0tqb4ojkvAkgX+N
         bNaPvhyOgtwhPqMjxR55/1bmIVgsRDnponXDP2VvBnood2+b7kaP5KRGMrjqYpTCSWiW
         ijPw==
X-Forwarded-Encrypted: i=1; AFNElJ/k8/FBik2X8tx/XTrYnfmnbezyryOUCxZAc2FKJ+tNmbO1fkL2MbOW+XrSD0RM24M0KBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhoB5NRAtN9ggTup1eX40emSR5A0R/5UtJ+rVjKOKZtox8fP8
	a3kHDFJU8Zpewq3S+woivxGLwzKJa/tj350PumBegdoGDv1abj6O1Q0X5y6iSt4OrOI=
X-Gm-Gg: Acq92OFmOT5VoccMWeYy8M2J8AQRkQFMPVuaBj3oXDJUhWi3xWe2LC1knwa4wub7FSv
	RZkxomw4bn4S0nLpDZq6RY45nJ3eeGYZnq0pZgP9OW1fOs2DVAPydJviLQpLyL5XoKLwwYx5+ik
	KTnBFOHxV3T6gmPx7H+PLfAbbS/xD3cGU2d5mOBQ1+Lab3fIZZe5WA5YjLFUWXogjEO7A5coqpV
	ULeJR06rmdaVQcDS/ysHB4tx/zP8nmC34e8bTNIzCDiDOPys8DzGWRiGAQIqx4lsHxGl5qbzERS
	FvhTCTettL2BhJeqY2XafWXTDTvtJMycBHMY25jqO7WchAxcYfXsqDIGrsEmLLXlYBhLG9B+blT
	D6mwBr0PsA6d7/Z8KKIaJN7ADkWhC2FNx1Ao254Xkq2/sVOZWaHZwei4MFUdBczZL5anOfe+Cie
	V7GCuQdMHRivc+cpff9iFze6URBrlsJY/2UeQ+y7dHCx6010L4WsVg/w==
X-Received: by 2002:a05:7300:6d21:b0:304:188d:d0be with SMTP id 5a478bee46e88-304fa674743mr5259150eec.16.1780309593836;
        Mon, 01 Jun 2026 03:26:33 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8176001eec.27.2026.06.01.03.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:26:33 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v5 0/5] KVM: riscv: Fix stale FWFT feature exposure and
 enhance selftests
Date: Mon, 01 Jun 2026 03:26:21 -0700
Message-Id: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE1eHWoC/33OTQ7CIBAF4Ks0rMUApQiuvIcxDaVDi381UImm6
 d2ldaFGYzKbl8x8bwYUwDsIaJ0NyEN0wXXnFIpFhkyrzw1gV6eMGGGCFEzgQzzhBvrSQ1MeXeh
 xZNgqmwslqDbCoHR58WDdbVa3u2cO12oPpp+oaaNNl52/z7WRTXv/G9IQvFKcaE4oL7jeBGddh
 KXpTmiqiPk7In8jeULoiiihtCyUsl8IfyGC0N8IT4iRUldGUqjqz0/GcXwA5nx8slMBAAA=
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
 linux-kselftest@vger.kernel.org, inochiama@gmail.com, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309592; l=3974;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=i22xps6LCObUD2kqUTEDbNF8C3JLN3ZsednxQoPzcsw=;
 b=wdJr7Ln1xzni8KnSJ57h+PPvQD5PuXrTrrX5ZA4mQYHmh+QPZPvxnYPYi+lb2+zyAgaCjKJRl
 lN/F+1MpxnlB2jG6KWSp0moShK6wfjKHRsHXLH+It30jxPYAzrEpTN0
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

This series fixes three bugs in the SBI FWFT (Firmware Features) extension
and improves the related selftest infrastructure.
The bugs are:
1. Missing CSR dirty marking: When userspace sets FWFT feature values via
   KVM_SET_ONE_REG, modified CSRs (e.g., henvcfg.PMM for pointer masking)
   are not marked dirty, leading to stale state after vCPU scheduling or
   migration.
2. Hardware probing side effects: The try_to_set_pmm() function modifies
   HENVCFG.PMM during hardware capability detection but fails to restore
   the original value, leaving the CSR in an altered state that affects
   subsequent operations.
3. Stale feature exposure: FWFT feature support is cached at vCPU
   initialization time. When userspace subsequently disables ISA extensions
   via KVM_SET_ONE_REG, the cached support status is not updated, allowing
   guests to access features that depend on disabled extensions.
Patches 1-3 fix these bugs separately.

The selftest improvements (patches 4-5) enhance the get-reg-list test by
refactoring the extension sublist infrastructure and splitting FWFT
feature testing into separate, properly-gated sublists.

---
Changes in v5:
- Add CSR dirty marking fix (new patch 1/5) (sashiko-bot)
- Split original FWFT bug fix into two focused patches
  - Add init() callback with try_to_set_pmm() restoration fix (new patch
    2/5) (sashiko-bot)
  - Keep runtime supported() checks as separate patch (patch 3/5)
- Link to v4: https://patch.msgid.link/20260601-kvm-get_reg_list-v2-v4-0-c88abc81ebda@sifive.com

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
Yong-Xuan Wang (5):
      KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty after setting feature value
      KVM: RISC-V: SBI FWFT: Add optional init() callback for hardware probing
      KVM: RISC-V: SBI FWFT: Fix stale feature exposure after runtime extension changes
      KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros
      KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublists

 arch/riscv/kvm/vcpu_sbi_fwft.c                   |  44 +++++++-
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 138 ++++++++++++++---------
 2 files changed, 125 insertions(+), 57 deletions(-)
---
base-commit: c7832534a8160276cccb9a8cc8cafb5614c579d0
change-id: 20260526-kvm-get_reg_list-v2-f9f36961ac6c

