Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491218;
	b=dj9s+wS0UVtvZ1whFji4juV/5p6U9BN21yArJlNyRRxPQ8yPa6hdGNd68I89HOb2bMKm
	 TODT4APEp+sq3qToO9jTmfyOCz9FV9iama9NnGAWo+tm9mFG81c7N+iK+KLSCyXuD4C/e
	 Iw1hIGzsQNuU5/VFZPBadzA4bbpAaIuGauTgqDpiaSivI6kVx5vFntW/2by/cEh5qi2HW
	 9Z3raEl/mutWFOWoe68e+iZkvqQjGi8WtDwP2bqTve4eEkQXr27O2O4Ii4TkG6vWSRtaR
	 TuXMhn7+jBh9P1f1hZFanNNn4nXySSmhyP2RLTqtAdpkpt/xcf4UeH9qJNRS+z/XAAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wj8SC7VUDAGsA7/l9+3e1xtsohCAj0LdZM2x+Y37EQs=;
	b=qZ1UgJZZW7morAYYpmTera55B1ISUeoxZXdYYSjkp12LFbcspavIOXXA/cEFNN/xoj+p
	 7/zOWJnUg7yi2FEVOWtSj8KGFCoBwsjcE51bn8r7NfdyeIOfY8ysPfANO/7ZI/9Aa5Zqy
	 WYBxcUMMSgPkyr0E2Puv+TsVx69QLQiSa1/cmqQYc8PDYvrQ7RWoP+z2oadrdbQwCity0
	 hhBuUj1tbyEZsuuMGgE2HPyPjSur+ISzmOCxvFllj06Ug7fLoFoVQ3KOUEma9JDee8GHA
	 VNClzYBOuAK504kRu11CBlIVOxw4SBfO7vwxfjq+x4CvkaXFw8WtYgk9XTUbBG48Tag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gs9lhhOf;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DB606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 608DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gs9lhhOf
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdd9779aac8so662246a12.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491217; x=1796096017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wj8SC7VUDAGsA7/l9+3e1xtsohCAj0LdZM2x+Y37EQs=;
        b=gs9lhhOfNFnaLBtsSJI7wjtJzJJzC9AJGxvTLGqRAnSuXuQ6MOqZCLk0c9cGY+6Auu
         4DbyBcRB/6R2ZgvRr+9027i0MtbRVfftVbdGnnjwq2kbECaTq+GUaQPdDhLpdSBwcve6
         aqnA6YjMVIHkqxALJJNSRzkLYZXRGtFnMqjlQEwKgv+2hgsQwpZrMOANc9iyn92T4zTp
         EkAO0jnHlnYckBOirYBmUJ3ExXuZppMPWiUMBe+5A2ldH/1NXsdlDqkYk60LDu0A7ILp
         HaTnT0m2muOevY+Y5R4q5x+N8MWIBN7tMhWBVUU++80+bNaYC8LwvK4BXRaNxhYbCldv
         oyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491217; x=1796096017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wj8SC7VUDAGsA7/l9+3e1xtsohCAj0LdZM2x+Y37EQs=;
        b=dcoE70WBrhvto3xaUhkP9orod3wTvYVVr5eN5iwodhQghH33LUaqvTKeWo+48D+X/Z
         A8069cmiqy3A7sQySVOa3PjEFFW368tOEjPbBUEyn47fZCjhBRfWS1HGn8pcr+46+5E/
         +Q456aPKPA6SdSakUWrpCljcCAF8Z0D9PiO59k1ejoHTCTsllXSQ1GqOtkHd2k69BFeg
         PGEWm3tJUjMdkmFs9mv6LrGO0IBzykwoKwm+DYDXSqnx3Ig602mNYtsuIBEQ2DKXl1N3
         T4sjvGW3UCV1QmZcTNwIwMZkR/ZveOQzWENbx2q34VAl/KCzILrw81DubaEDDyZ40VS0
         FAQA==
X-Forwarded-Encrypted: i=1; AL+hErEfmUDWVFCvrIACXBMaA9yq39ktGiAKFx+im5v7NfDV/qgM31QcBrjr7a+DfqztBu+2KAQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PK9aT2UjYZHzwzKKdFRzcAHJPyO5z4p/Kdy82gN/kwq2bGFHs
	ScJIQUQhfEo0njhGiAQ09tV7bT7FR5l+5rllQPXo661jzyXuM3/A+VfA
X-Gm-Gg: AZFdTZeNG29gNKDKu+NAcjOjCo4ndc5p2CuyFXQbQYZNJntCz4QAUzE3bjCNg5zAPr2
	GQ92CmBPViDbK0ZojMWEnIfZgkPIXe2omz2WGBgSUgahIzCjYYbJvg/vPs63PqyS1Q8KURO1ZFB
	uIQbCI6vgiWHwKe/Aw9pbtPpouYVYP6W2B473CrbicdkZipoHX/SZ4VgAZiGMiylu7CEQT1wh5l
	lt9NMNUdXPlgWUjfSlVDXTSwX4JCgtqNgpiM91R/UJeEIthGcO3ZW/uUZah78/aAndHkBOrwyvV
	iOteO6jwGt/GAZN8RDl1kNplsA5LmmLaRBtbj1XxshiOMK7mJcR6wJMT4VFe6qT374gd7gdnJtx
	R8UO+UdTbFcTHQduwfPdf+fvp8lYfOgkdxPk6qxa931EAOIXyAFgxhulp3uulhE5BVk6c8c30B0
	znuBzx7c/YIOxQW6Ak5jK2//flgAjwHqGfUi8dILCK5baIA4m/D0aeZTAJFft09agWUsHpKuTQV
	e/1ZDsnoLk7wRvaJkHk4MdvNz3seD3oCDQ94IDYQmU1O57fdEo7qBi2pcXUJ5kmiidI0LsedG+q
	GfiLsTNOaq+hXxJ4twjb54oKQPWEVyx30rZaVxuUhw==
X-Received: by 2002:a05:6a00:414c:b0:87c:e44e:5694 with SMTP id d2e1a72fcca58-8c87c3882fcmr11093633b3a.21.1795491216650;
        Mon, 23 Nov 2026 19:33:36 -0800 (PST)
Received: from q-Legion-Y7000-IRX9.. ([223.86.210.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm6495773b3a.3.2026.11.23.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 19:33:36 -0800 (PST)
From: Bingyu Xian <shanbeeyoo@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Bingyu Xian <shanbeeyoo@gmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: selftests: Test steal-time dirty logging and RISC-V STA transitions
Date: Tue, 24 Nov 2026 11:33:26 +0800
Message-Id: <20261124033328.612894-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series extends the KVM steal_time selftest to cover guest RAM
dirty-log tracking for steal-time accounting writes across architectures,
and exercises RISC-V SBI STA shared-memory state transitions.

Patch 1 fixes get_run_delay() so that missing or malformed schedstat files
fail explicitly instead of dereferencing a null stream or returning a
fabricated constant that causes polling loops to spin indefinitely.

Patch 2 enables dirty logging on the shared-area memslot in the common
per-vCPU test path, clears initialization dirty bits before checking
accounting writes, removes the v1 #ifdefs from main(), and tests three
RISC-V SBI STA transitions: disabling an active area, re-enabling the same
area (matching the SBI calls used by Linux RISC-V guest CPU hotplug
callbacks), and replacing an active registration directly with a new area
at the end of a second host page.

Changes in v2:
- Split the get_run_delay() error-handling fix into a prerequisite patch.
- Move the steal-time accounting dirty-log check into the common per-vCPU
  test path and drop the added #ifdefs from main(). (Andrew Jones)
- Separate RISC-V SBI STA disable, re-enable of the same area, and direct
  replacement of an active registration; clarify that the selftest invokes
  SBI directly rather than running Linux CPU hotplug. (Andrew Jones)
- Drop the MADV_DONTNEED check, which discarded guest page contents rather
  than modeling migration. (Andrew Jones)
- Clear initialization and transition dirty bits before each accounting
  check so registration writes cannot mask missing accounting dirty marks.
- Force bounded runnable CPU contention instead of assuming every KVM_RUN
  advances the sequence counter when run_delay is unchanged.
- Size the RISC-V two-page region using the host page size for 16K/64K
  host page compatibility, and fix Author/Signed-off-by formatting.

v1: https://lore.kernel.org/r/20261115085457.889873-1-shanbeeyoo@gmail.com/

Validation:
- RISC-V (QEMU TCG + H-ext L1 KVM): all 11 steal_time cases pass; local
  controls confirm compatibility with skipping zero-increment STA updates
  and immediate detection when the accounting dirty mark is omitted.
- Separate local 2-vCPU RISC-V Linux L2 guest run under L1 KVM confirms
  SBI STA detection and 3 CPU offline/online rounds invoking
  pv_time_cpu_down_prepare() and pv_time_cpu_online().
- x86_64 (host KVM): all 8 steal_time cases pass, plus fault-injection
  checks for missing and malformed schedstat files.

Note: AI tooling assisted with review analysis, test rework, and local
verification; all changes were reviewed and validated by the authors.

Thanks,
Bingyu

Bingyu Xian (2):
  KVM: selftests: Fail explicitly when schedstat cannot be read
  KVM: selftests: Test steal-time dirty logging and RISC-V STA
    transitions

 tools/testing/selftests/kvm/lib/test_util.c |   7 +-
 tools/testing/selftests/kvm/steal_time.c    | 233 +++++++++++++++++---
 2 files changed, 210 insertions(+), 30 deletions(-)


base-commit: 23c62304dde29abe92013d85910d03a77dada35d
-- 
2.34.1

