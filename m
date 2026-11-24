Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491209;
	b=X7M8jve3tD+/QPEEXtyUCrC1OWzogRrX/maeMSz9oloAbpJkEv5NJ9bQIu3FvOLNLpKq
	 iNq3lkILCi/Y2hfJUdVeKV+KlDRnHdibR8se3l6H0+QuKVawUrqeOxlKQJgdQnkhMYAYa
	 uwBaBbeDNyaB1FSE5JrNuH5/ny+JBadFTAthaTTpfXRB4eKuSSXUlIzUVu7a9Xy7YNKV2
	 VmGnP7bxEO0MqwhZsPORqyhI0g+3OguZ2qZzp3xOiTl+UnbN/dS8zoSIz23PJZMhvVyY8
	 09a841WfPz/d4V+ZJttwuYPLgWRrnChIwNJRNDZ4oqrBAKgggXj5rGW8O1WGyW61E7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HtQGXmDLK1knncRVdCTkTy3fQnI6z6mdkboXAFgFAyA=;
	b=XAtU7G61yaK44ysod/Zt2U9oLONl91FUJuB3IuZ0IsfrrQY32lJc6k1JrotosgmArr8e
	 qmigVxr0E/Tj4+mTwwPQENxGL4lupgs/WiNyLJkm7cpbXNqJ7G1HtdJbpe9d5cIwWk0Wv
	 72LzsSBl0FNaJChGAJT5w6BxttfxHhDqFMZKxr38BhsyULy9oVMY59DsaszSFQJfZWte/
	 kpBA5IobgVAQXpY42ccEiEcGpqFBRiJaEPETQQbaJAnAa1yv18GjkWmdWUFveT+0Xu5Xa
	 pNajDuHG5JFaGmSRU60duHLin/zVNxssECBrriMZCgRca6v1aIUYE0vEY735fSRvtWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x7KAfRMZ;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF5606A326
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FFF5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x7KAfRMZ
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b3bbd46625so907881a91.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491208; x=1796096008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HtQGXmDLK1knncRVdCTkTy3fQnI6z6mdkboXAFgFAyA=;
        b=x7KAfRMZvLVFOXhMB2PcYGsAy4G7uaTxoKpMUzCfoSIe0xYloNEjewCI75s8aJNr63
         wb8qz19QiKmBPoFFzOGcGBcuyOmoUSj5X4HfEeMdTmFuAdFaLrFF3FQuypMadypOX+bl
         EGt5QUOnt6MWjQasSPVnZNdnFlTvc/LxIzWrR+ib7IW3mRnmKM7E0pAdT2460lUF76/V
         9C5QNSb+0nZ2D4BhU42onL/KOaDDW4dBewk2NtQO0LmdiUDuXM5JOK9HzsmCF41f9sql
         6QDlXoAa4rbCaAnSW/8JsAjEPSR3/Q+4uNw2VKp1N6RgPf+cJXZ8xEfxhmM7QbhQSyMf
         3Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491208; x=1796096008;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HtQGXmDLK1knncRVdCTkTy3fQnI6z6mdkboXAFgFAyA=;
        b=b9Z64edjCCnoGAC9ilCdF1tGqqnecjCozEOovR2Zk9G7xu+nKljor8Lv4UdMg7g7CU
         zJDb6ULQNvrXHMHRTfXbpZZio69dccA/bLbnURMuMkB2vqoc6ltMraIBdhuPrArNCVyC
         6CwcTMgvaH9QUMIXjt7MTgQwMc05uJQYY1NDWCewlj+B71dLK4RE9rYaDtuiNNWvHtM5
         7dlxO+GhS/g32ucYupVp+k1juE+0QZYkfizO9f1aIuy5nMBenBMMbq+A2ALI11WZSJCC
         lcehR4lYBe4qu0L6Md1dG0djpfo8ts2moGACzZfW92/cG+vqsZ01g66FoWW2cLPcz557
         ADgQ==
X-Forwarded-Encrypted: i=1; AL+hErEdommgJVMwZ4WYOvhpjICO2kYsieN/8s/VwXHbaupyfqkaICD3Qo+nokl+Yd/LxAOmshw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tQ6h8MxXBR6VJLP7xQUWkAUvgL7mc8AZX76z426ao/gubT6HN
	o3q5dDToc+trUxvjlp9cPr8h6ugp3PY9Ivu1WqgocSlfqb/6gD/w2hyz
X-Gm-Gg: AZFdTZf6SZ6Z4n6ST1HcZC026U5vtjolz23SrUeBQhW+Gc2k3M5dpuxsD8slv14k3r/
	xVCfNuuGeRCeL9ogZgEa/o+zdiV79+xOYu05GKyIsZcwW+H/7oTqBjNLbNySM8gejKnW0owcVj4
	PI/hrvtJmbBCtjYTx5//XYdLBNyhtgOOEl2QAYd3U2ucsF3kY6DfsSJPFG99CSbuWHGPH8khdtb
	Yrp0PdrC6Gf3CRgGG8UFo6DzTCvsuJIv7uJ+fva3yzjFZGtUftlY2zMrg8TJNMWVPXp290cCEmE
	WjGAz7PVSy3MJtmh762pgxSzvKRqhUyjH57GMIgd/+pqH5Tgux1nAkwMWw/Ylw6kK4tAmGHDJtv
	WMmPS/WsEAv9t2H4hH52U4wmDlb7ovqQMPrURNtXXoocxt13sQtmYKmwrglgsuQTy49Y0j/EFrG
	mMWWaRclXgJiuB8Pll/JTdgJ09fzx7MkmahUL68PgNpB1S1B9Atu89lx6Tc8+YM1m3jFEPQwQGw
	Dj+fHy7svnGgfLgzNWoEA7jr4Z3wB2wCy0jRNxKFWA/gVZHGQlWuNStqk0bVky1f8G/l/rxlnqb
	u0BDgs0jDWAz8mlxGfNS8nNBzCtIjqUiseoFnbZO+Q==
X-Received: by 2002:a17:90b:2247:b0:3b1:83aa:5b53 with SMTP id 98e67ed59e1d1-3b41c98a1b0mr13226363a91.58.1795491207740;
        Mon, 23 Nov 2026 19:33:27 -0800 (PST)
Received: from q-Legion-Y7000-IRX9.. ([223.86.210.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm9122009a91.0.2026.11.23.19.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:33:26 -0800 (PST)
From: Bingyu Xian <shanbeeyoo@gmail.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: selftests: riscv: Test the SBI STA shared memory lifecycle
Date: Tue, 24 Nov 2026 11:33:18 +0800
Message-Id: <20261124033318.612773-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <av77j8rN593sxIDh@orel>
References: <20261115085457.889873-1-shanbeeyoo@gmail.com> <av77j8rN593sxIDh@orel>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Drew,

Thanks for the review. I should have separated the scenarios and stated
what each check establishes.

The enable/disable operations are used by the Linux RISC-V guest CPU
online and CPU-down callbacks. The selftest invokes SBI directly; it
does not run Linux CPU hotplug. Hotplug motivates disabling and
re-enabling the same area, whereas active address replacement is a
separate SBI transition. I have reworked the test to cover disable,
re-enable of the same area, and direct replacement of an active
registration separately (v1 disabled the old area first and missed
active replacement).

For dirty tracking, the intended property is that KVM's writes to the
shared page are recorded in the guest RAM dirty log. I have moved this
check into the common per-vCPU test path and cleared initialization
dirty bits before checking accounting writes. main() no longer needs
the added #ifdefs; architecture hooks select any protocol-specific
lifecycle cases.

The update checks now arrange runnable contention on the same CPU with
bounded waits instead of assuming every KVM_RUN advances the sequence,
with a small prerequisite patch making get_run_delay() fail explicitly
if schedstat cannot be read. The revised test passes on RISC-V and
x86_64, and a local control omitting the STA accounting dirty mark fails
at the expected assertion.

I have also dropped the MADV_DONTNEED case, since discarding page
contents does not model migration or establish a content-preserving
backing replacement scenario.

I am posting these changes as a 2-patch v2 series.

Thanks,
Bingyu
