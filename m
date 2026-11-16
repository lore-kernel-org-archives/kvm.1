Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799674;
	b=N4Tz9I1ENNgPKxGt3015VE2UxfY0f/9tOW09vu6iTs56tphogsWlu2Y3+IErwXg0qcOu
	 9oYaqYbTEkSmxqe9WUKv9IQqCCUR2fJ6uHsCZM5h2t0R8EbADmNeH++pwzylGLZvRViOo
	 HcIyyV3TSYRPNvuWNqKgxOwhQZ2WwiIeHWhuQFezBdQfVqBy2unE6s0Deezw3iBAwNgav
	 rT489kM0km5Ci1e/duJ0/R1YRV8IyyfQ98R8jiH0p+xVl5EjlIkAkMp5xjONQrjs8F/H2
	 wgxwg0LKH/XMWJatP25n6LDvO3efKpnykif1ppsc94WL1iW15QtefgZahn67qkXh2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oOw9FcgkKeryukGH2zABKUHn8dpCkgMG2LnWEZ8xwEo=;
	b=3DeCE8Nn+ONxUHJ7rhUXpfI/e75kulTQ3IdP/h1jd+7tLUdNWN1UdxDwYwZhQbJcsVQ8
	 Ewor0g80Que4avM1z5MLH4Bnp8eI7QzaB2xthPBpGHPRFUNkZUp0TBFhlVfyMc2Lze5W6
	 oNBxi/e7jTXs1MPxZwnNeb+WBUKc8LNGCsKVkIdz5fSuwLNkap0NVE5JoFr5k94QqQqft
	 iAvJE06CSBcI3kq+kg5Plh/LHhYU4LYvp+A7CpNt0FV2c8SsYVa6WsE6wzmUF8jFHJgQW
	 4/3cqbuCrZDOdBksX71HaU6zF/IaqOT/H+wsfpvkt+RT7kt9vjQPMyfhhepPZPcMiVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aq+Y0uTi;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7952606A880
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 03:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7952606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aq+Y0uTi
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1493664a91.2
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 19:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799673; x=1795404473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oOw9FcgkKeryukGH2zABKUHn8dpCkgMG2LnWEZ8xwEo=;
        b=aq+Y0uTiqIfoIyopGR02S8RwhmMucgmmdGmfpJijaK+iXHz5Xs+hfDp6svj+edBbjF
         ePzOxIag7iqNRMZ9HqcHATP5DVG3pBcJ8a44lanHUM6Plqj3ftjuS2EB74mT9Ktf5qix
         woaSDlrbFZrZsrEJRqwXRxB/QctJRvdWIMj6qCPPlUxAKv33blJDVnN6TqWEggLvxjpT
         d295Miludt8sPTu3EVEi4efHAKO73wSzQgp+xVJoU+SgbFcTuq6rVK7X3hqbxuFy29C8
         wd9UmFlK5Awr7j+v2vqsUuDdf+NCBImsL/cz3V8oTnMQgn2J3yIYPV5bdOc+OoQ5Py/Y
         Ev0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799673; x=1795404473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOw9FcgkKeryukGH2zABKUHn8dpCkgMG2LnWEZ8xwEo=;
        b=ifWz4hXz6nX+7TUj1PmvBDzj5Zfs5kg6A0uDcAjobNHndcTJ8E9jTssUFr44LNpRWM
         yj3ZNS/DGdSCDy9j6mMwvQYWba/eoN7xjDpQGmVfSTe+8dUK0j6HZCNknz83ctcCSe36
         RlQ5Zg56VPfsyhkP5ckfazJrP0w2QeLmgfwLtwLlwwdMCyHw5NJ2uq9r4xF+Fsc8PSoM
         HDZvRWDuMBxSONExyCwSsa+MBIl9n0XuE3A0i023j5MmiHeMZPPe4CboFLIe5mFKK7uo
         NFtE/7nm9D0lZTw+fJwKRn7g05YdCVfWu+uPvILDM2GxwrPEakYoKs11R8r1lNisR3eF
         A3eQ==
X-Gm-Message-State: APuU4Z/rfb787CuoaM4/ONbfAYceeBwpQhOymqo1sKk7QXRLyaj+L0wZ
	U14AcJ3fwco7zKnOQzS6quQONWkisUAh3Fbm1Nl/BE8T5AszBX3dm3AX
X-Gm-Gg: AYBFou2lL9Lzxw/aiLgWeA3SrMja24Yssyf/UCaxc7s6hof8eaq2sJwRUwFnSUL5nbn
	RbCjim6g24S/DV+oZLC2/joK8oY1HVylXZgqKHcoerAuy2sEZPKeiRTe075ZMEBf3wRq/FmF9Qa
	4psNMK1behLSmvNiNTr2X6e2/S0UpGrAxHrfuV65p74saXpur8IkGTm5y2o8tqwr8/8QpmyWmIL
	xdQXeTGFCC4lsHTyn4B/KvOlIS6Z2hIZYvG171/uSmCUeWNE/c178AWSMcMbBejELMkbwyr52PL
	sAg2wS/ie5W1HTKaXg+i0nrekkjnZ5CcYs55d2OolwQWWwXBa0uQPgO22n6/xFp8GbVpI/vwLnU
	1Gx8VA4g/YUNUn7DNExEmJ4Vb1aySURw0VcsXz7QnrOwkvpi+DkmNvRJNUa7spdUemBtVJNiX/Q
	+LMO4lU8S5HpBU45yu4aosuGeIbAVJpYZNyQayvryCYTvrNMwCRbrRR+qtF14xpQ2u1SBQyUhja
	YaHBCJm5DhbkOdzlr0xOy2FYDH6hETeExvvip/xJ+ogDYuoICDPKLw8LYPtL/vgFO2N0C+fdOkS
	6UVvmvdZQIV0q4E4Ai//i7T2WBKJ6hIc7ztjvzUkY4AfxtiJ2ZBSyX9NMwBDGg8B8CyP50ne
X-Received: by 2002:a17:90b:2251:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3b1b0a408bamr9662417a91.22.1794799672996;
        Sun, 15 Nov 2026 19:27:52 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm18998570a91.15.2026.11.15.19.27.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 19:27:52 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH 0/3] KVM: Rework how halt-polling stats and per-VM debugfs use memory
Date: Mon, 16 Nov 2026 11:27:45 +0800
Message-ID: <20261116032748.54582-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces the halt-polling histogram Kconfig patch, as a first
step towards a general plan for KVM stats.

Take a VM with 8 vCPUs on x86.  Each vCPU has 1104 bytes of stats, 768 of
which are the three halt-polling histograms, i.e. 6KiB for the VM.  The VM
also gets ~95 debugfs entries (one file per stat, plus a directory and a few
files per vCPU), each costing a dentry and an inode, i.e. ~70KiB, all
duplicating the binary stats.

The plan:

 1. Counters stay embedded in the stats structs; they're cheap and
    monitoring wants them always on.

 2. Arrays and histograms move to a separately allocated block, controlled
    by kvm.extended_stats (default on).  The binary stats ABI doesn't change;
    the values read as zero if the block isn't allocated.  (patch 3)

 3. Debug-only data goes to tracepoints and is aggregated with BPF.  Adding
    the halt-polling time to kvm_vcpu_wakeup is enough to rebuild the three
    histograms.  (patch 1)

In addition, kvm.per_vm_debugfs (default on) allows skipping the per-VM
debugfs directories.  (patch 2)

With patch 3, struct vcpu_vmx shrinks from 8384 to 7616 bytes and struct
vcpu_svm from 6728 to 5968 bytes.

Peng Hao (3):
  KVM: Add the halt-polling time to the kvm_vcpu_wakeup tracepoint
  KVM: Add a module param to disable the per-VM debugfs directories
  KVM: Move the halt-polling histograms out of struct kvm_vcpu_stat

 .../admin-guide/kernel-parameters.txt         | 13 ++++
 arch/powerpc/kvm/book3s_hv.c                  | 11 ++-
 include/linux/kvm_host.h                      | 24 +++++-
 include/linux/kvm_types.h                     | 10 ++-
 include/trace/events/kvm.h                    | 16 ++--
 virt/kvm/binary_stats.c                       | 29 +++++++-
 virt/kvm/kvm_main.c                           | 73 +++++++++++++++----
 7 files changed, 144 insertions(+), 32 deletions(-)

-- 
2.43.7

