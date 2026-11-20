Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173915;
	b=0waHsaqj8apxccVDgsuffVvZN1Se4wuC5RiTsoJiaKd3qRO0gtVOqQiLKP56uRPSD+XF
	 5lS3po5Mzgc6MDjJZqaaRnYvnh0PsfqYgwcsT7IZvB+8ZU9c5zuD8jkeCiCh5AZR6dVmh
	 F9qQBEiEhVJO+IbAXRMODg4pPdhmVs/eGbQ4zgmqD3K0+RxqgX1sIO9AjyTpkm/px70Hn
	 7ROjEp+Ti5py0aASuYzsDSQJy/xTcV5SRdkGdBgWs0GIO9oC7TlYUjsXVaiF9sR11o3jG
	 sjHPNtbdXpYN95Ou+wFgfRUpFNUBdxIsIuZgKn0bNXA8PBwUKQpb2as0eFmWE3mqMkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=T/oeAUI0ByDf7dPHx/8xzMZxbOAspRa0FQ1QEHteMRw=;
	b=aRdTANaOzewldIeyBk3jl1ztIYn9tKJlUFHXQ0xfU1b4RnwEfiW3WHIsncCeZPirmJM0
	 59BOhSsUbknLH9bLhxdduYBKs4zJhuLEL/avw8oKDJZvOZV9URk2onnTC+LgAD2Pi0kXk
	 9jewEZxvIXqgLpsup19/SO95Wbo8NNynhcawVLCnsp4rgfeYUKhFws97AHNTgb6keG2Cc
	 T1LHQ5yB+A2OpvWIg/0YfozH+gIF9R9WrwNIO177XrW1pW/MdSvY4YNiXoz+BocgmKYdv
	 7KNjE6Zn29xGbVkXifpFBwoF5zLt03/2c6UpNBkwPDP/p/k6Upvbm3RYqwuSza1C9Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=LEDGdlRJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D16606A325
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 11:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D16606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=LEDGdlRJ
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49465892f7bso619029f8f.1
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 03:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795173913; cv=none;
        d=google.com; s=arc-20260327;
        b=QPkOOI8B9IMTIw58TOPvaUJwRuMPVb0Psa58x+dVBMhKT3BaU4m5fWD2M6thfK6ZAh
         l7d/+8Iq+zSBNC416lOTFk0nSxymTNgzt2Leb0f82qwKChe6XZNAzDn8F0/OysVaxpMU
         Ri3DGzjFk5Hkq8pCe6fBVvn7FvIvmD0P+s+T5pfzitZ6OHuhLYcBC7fjRFeCX+wTxqEp
         JwSCrVYoUTwdNzGJI7xiuPnQ039V3wDhXkwTxUKPgdgjdEkIFnxti2G7Lh83c8hnD+MS
         eZicLhGnBmaUB655zmmt2BrA3veo4M5gBZ+3fJaTFgu2CvxnvvP+2BannOWNCuDyU7xW
         +jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=T/oeAUI0ByDf7dPHx/8xzMZxbOAspRa0FQ1QEHteMRw=;
        fh=yPjn7V+z2KDQvGG6BGYq/77aMX+EdqlKoecSDlZ49ME=;
        b=WjoHr76DAnDYfoZgyMvVQ53QBil8Eesq5fgm1k7XI2efpix1m4Mbzeh1NYwB6u8Iqf
         Dhqloshxg6+hbrCKG2HHCAJXKJiTEb2/BJNqoTeIK6WZ4maVzt2pbKDqJBW7soLpJsLX
         6sSnfQehCIruNSQF9ABbRUgJTZBYbNCueHIK7pY7kNX5tV/vGfAZ0Vf4z6LuyNuTVDrV
         CviAOk6UPzZPQcVGtLgJsQzw1lHhuy4qEowGPLJZtUFIbsQLmuZeigUzXWu+pouIFLmt
         FbgUfhnURnotCxYRMd3b8jJ6mZLnpmB15gujWZKKI54CJACc39i8dlwQGv5iv6Umn2OI
         7YFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795173913; x=1795778713; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/oeAUI0ByDf7dPHx/8xzMZxbOAspRa0FQ1QEHteMRw=;
        b=LEDGdlRJfUZdEgO775BxyiUgafkJKiUUg9X09f5a5Zx8xaxSzU5nUM9QSpvRaJfr7V
         wwlHdEPdY5g1R26R0MJMywTSKfZvaCm3F6rHkgsh0SSj70p7fq9kBDWAxeXOBr467ILU
         RElE57kjQSQwA1gPgZPDts+3IariWqcqC/DNiUxMyzZRlR8evf/M6lgJTmUtMTxTCpA2
         XxCP/LIj6QPGO3ymx5scv57Dbxftq/wzemf32x7TXQzyYFH0HFjfLXPTwLKgCHczhn3Y
         ulZp6d8wD+kJL75FAgp+Ged6qwylZYYGt8sJixbqcSAGxlbk+4Zl6mGmzj56JFAV/0L4
         +Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795173913; x=1795778713;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T/oeAUI0ByDf7dPHx/8xzMZxbOAspRa0FQ1QEHteMRw=;
        b=K6qMuCR5cyZoLUolJqGLSJRUw8U0nwayYHwH/b8ZX/s4n3/4kw/BrOMf53Smm6fYEu
         tchhRoHGuM2wnrT7n1XgMJniuYYmT58k2QiboHTUZggNEy8GpVcPwi6DePCp4Gv2dwoO
         1hjc6nm7IWQdXWv2La9uXDnM0LZxv8OVjvAasL+vKX5a4uZixh0UAhfnWW5PoIpkKhyn
         UFG8qk+Eb0Q4IIuoOYnGEaRQn9NLIT6iIx1MOUGbB3kQ9zxyIaOs8xEXgKRuNrQIv4Ru
         m0PAittVRnrQ1h5VLcxZmQB/MhDsBU9HNenkLPaUqYY+RN+HOU3X9x3RcgcHkskRbOKz
         Assg==
X-Forwarded-Encrypted: i=1; AL+hErFp34cfDuTRp5v15bF/Ue1GWo/YpnvAZPg1inCtUqrAjxwSCBstOvWwDHJNCIJY/HuTPMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G8cL7lp4p+PSUdUUxO/0cw4uLVgbwSHczHLDGnJWiqPJY1kRd
	6BFpU2Qq6uuiezRgh0/V4kOWMKtQl39GHIYdi9c20CLSCIQt9Un2Ve6RJMuy1LfDjao0jV2Zol+
	9bqDRdw6KBxn5OPAGzSseB8Q3spMQF5zXv1NkTMG87pMfmQWiSUaBZOA=
X-Gm-Gg: AZFdTZesMiSoURFW+HGZwbQhu8AXenJPHKedR06Z1CfTkXr0lBFbTPc7xxZ5c+VEL7X
	q9RHchO9N39My7dIrWn+P8/XOScjSi/HhZOPzDLTrs3Bm9dWk+Z0wgNm7w+eR7AMals/Oq+i5NS
	G9ufriHMwrGcKHWHD7jiustGHaIY7LMwFfHXQIoZhwi5Rsv+kbQCXygXvHwX8gRwukbgwOqk04D
	OTYl0JNxzkiGjkBelsWgDfQBfUnpFkuGQlCJSyKvzO+Sx659IiUq95O1UJQF6npcGMollhRdOBq
	2/h0d7j2KkbPtxl+RSYN4cGteq49lneTioprfd0FcNf8fasJCPgX/N25+VcRIsFIIqsTF1a88lb
	0cXkNCcBYi+tqrdrMRrduAPUBAqwCgCZe2b1/hxfe5pJSpmei7bRCGSMl+TbjM/EncYjxkTacPv
	CaYkz3PtZi+6lDHyD57Tblewh4ucsuDGa6ImUDLz50pkhZ+qtZtDFiCcb3yn3620uYjsgOyF0eQ
	Q==
X-Received: by 2002:a05:6000:2489:b0:48e:2108:4d28 with SMTP id
 ffacd0b85a97d-4abb1baaa3emr5589260f8f.13.1795173913277; Fri, 20 Nov 2026
 03:25:13 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Fri, 20 Nov 2026 16:55:01 +0530
X-Gm-Features: Aa3M54oHwQOVnudG2qxplu2UhUX6GqklCT0V-Jph6298Y8vWTvDHUntIEuLbZcc
Message-ID: <CAAhSdy32nAjcz2vyN37Fb7nKc9jbUxWjUYjiYGda7NPhweJhTw@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv fixes for 7.4 take #1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following fixes for 7.4 kernel:
1) Validate AIA MMIO address ranges before AIA is initialized
2) Disallow GPA-width changes after AIA is initialized
3) Fix double free of the split page cache
4) Do not touch the envcfg CSRs on the SiFive P550
    (Note: SiFive P550 is based on Priv v1.11 so it
     does not have envcfg CSR hence this fix)
5) Set Accessed bit in dirty-log write fault fast-path
6) Validate PMU counter info using available counters
7) Fix G-stage page table memory leak on VM destroy
    (Note: This one was a pretty embarrassing issue
     which we totally missed over the years)

Please pull.

Regards,
Anup

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.4-1

for you to fetch changes up to e9bf49bbc4227048685c78f97e1446845760df4f:

  RISC-V: KVM: Fix G-stage page table memory leak on VM destroy
(2026-11-16 18:06:25 +0530)

----------------------------------------------------------------
KVM/riscv fixes for 7.4, take #1

- Validate AIA MMIO address ranges before AIA is initialized
- Disallow GPA-width changes after AIA is initialized
- Fix double free of the split page cache
- Do not touch the envcfg CSRs on the SiFive P550
- Set Accessed bit in dirty-log write fault fast-path
- Validate PMU counter info using available counters
- Fix G-stage page table memory leak on VM destroy

----------------------------------------------------------------
Davidlohr Bueso (1):
      RISC-V: KVM: Do not touch the envcfg CSRs on the SiFive P550

Li Jinyue (1):
      RISC-V: KVM: Fix double free of the split page cache

Pengpeng Hou (2):
      RISC-V: KVM: Validate AIA MMIO address ranges
      RISC-V: KVM: Disallow GPA-width changes after AIA init

Qingwei Hu (1):
      RISC-V: KVM: Validate PMU counter info using available counters

SeungJu Cheon (1):
      KVM: riscv: Set Accessed bit in dirty-log write fault fast path

Yangyu Chen (1):
      RISC-V: KVM: Fix G-stage page table memory leak on VM destroy

 arch/riscv/include/asm/kvm_gstage.h |  2 ++
 arch/riscv/include/asm/kvm_host.h   |  1 +
 arch/riscv/kvm/aia_device.c         | 49 ++++++++++++++++++++++++++++++++++---
 arch/riscv/kvm/gstage.c             | 22 +++++++++++++++++
 arch/riscv/kvm/main.c               |  9 +++++++
 arch/riscv/kvm/mmu.c                | 12 ++++-----
 arch/riscv/kvm/vcpu.c               |  6 +++--
 arch/riscv/kvm/vcpu_config.c        | 16 +++++++-----
 arch/riscv/kvm/vcpu_pmu.c           |  2 +-
 arch/riscv/kvm/vcpu_sbi_fwft.c      | 20 +++++++++++----
 arch/riscv/kvm/vm.c                 |  5 +++-
 11 files changed, 118 insertions(+), 26 deletions(-)
