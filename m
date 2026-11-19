Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114358;
	b=mXlhJ1QdiL8LeYE14XQUCJrqD8f/NvCQgW/I6XGwt6i8WOt1xFPfQCt9Ro5edCNfSlq8
	 8ZvQwiVTFRhyxDuJpJ5S2B5sLgJsg1ZDZbVUQVCmx67N5OwDzlsvM+aLE3Tq3dZX4I59q
	 RvmWBc7KzdZ23wdWVdo9T1osQ2fi6VkzDGfYjGjy9UcplRlxZ5KkmeErvcWlAupdjwkJm
	 eh9b2f7bTQkC2mXS9Cwckzk3BWfN/dSKfncz3Ot8Tx3F6BG4aDcNGX+BDZaRLxCWVTln/
	 YDP44lpiK3Y5FWuprWchVZbO2PDBN/qhDHQZM2VqjWWu7NWZ/GLa1/RwCT+CFGwhpuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZrQiJeW1/ZGAZNj9EqpY+oYKcoF1CcN9MBzVSNJZPxc=;
	b=wqoidsoNbCGsfFW4cBZIO70Bz+Eh3KXPe75wZ4gNjoKgM8nfStzGrZf828sU4ntEonZA
	 4ea5LFCRklutbJ8NMdkmo3bqDTlapwxKwgbfiecmEUwfkJ7iX2xE/wolB1EYuDXf73TN0
	 jH55m61j3pokPh+BgH2ZsW6dbwbNGzfJ7zi0XXdtvcE2oMcH83jlGeTUCLaUZQc1ZlgOB
	 aAnBimrJX3yJ2xYKJmjo1gC9QJcuJWoGbixGR1LzE/92w5aKcVmXwEDMrM3R6x4jnyQ/j
	 DFqudjmMTfg2hz6fib0dUKRtUnC9THtLA3nXVJDBg+vqnLM5Kdn1oFIVcAiZne0gR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djTQwvGo;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA8606E8D0
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4AA8606E8D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=djTQwvGo
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab8b4887d4so146097b6e.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114357; x=1795719157; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrQiJeW1/ZGAZNj9EqpY+oYKcoF1CcN9MBzVSNJZPxc=;
        b=djTQwvGouuLjxkWqR3c9bPKwN/fycxEJsz46gazrcL55seCy00j+IlwKtjdnHf423Q
         nDqhlPtjai7dC7ZgHo5qWbK5qUAefvDOdgQ63QdA4Yngef/ylXyu9KPSipd6OdWGf6oN
         6qdA2OSrq2S5LuamR8CrJ4IgvL3krCF9KruFSWJed3J5qHLxH15nreaOEc2auIvqb4+w
         R8mav+ERdQ2k2IcsqRDdXiicDyPX0bz0Nn56HIhrS5jMhVxVjzFcOuFB8maAUzMBjDwR
         /3w0OAvtg6Ey+mYrIIB7CtSMGY6zwpkOXXemuz3r1IWrr7q90Sbkye6vss/SyHrSO7Lr
         EWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114357; x=1795719157;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrQiJeW1/ZGAZNj9EqpY+oYKcoF1CcN9MBzVSNJZPxc=;
        b=HQ21nkLXQkWtA5dUOOONNGU362mce9rrbCDs5BZ+34DziYl1jAzN2QVZhWSiIiI1m6
         rmoFP5ratWOMTG+HJs2d0krMDGo1tB0faEjo3m4BFqva6MsCBA54UqdoklOD7EBKeO5y
         Jfn7ZP68e5dAvIPiXmpEg62n07R2VXfWBWSgQsAw+Vte2hHIpIBInHCCV+qy/G9Luntk
         UGesB4KYbaeo/Xajv4ZXM1qDqSE2qWCBbnXfxTOfU93sxtElmUqEbpSUWqveP/OjyTMK
         tFqu5a+wLw11vNFWywhYfzEWeAyvbEL+dlhRPUohus8pERfnZqiDuDv22lHxNjCY5pS0
         KXIQ==
X-Forwarded-Encrypted: i=1; AL+hErFx9zDKkFKGNKQlHvGt6hufsoGi1zv0AK391pPynpojzYBh09BtMuqiPGXse103pZ1qo08=@vger.kernel.org
X-Gm-Message-State: APuU4Z89LemdZHHKUKmwd0VgDPUq8uHGh6WDhcJFJbTdMazMfAfCM8SP
	ADFXKMouyP3nkKsQX9EOw1j7RXYw/xi+yg2dafKNSD4HsEMEZa6B6d6lcNlCKll/CMwekRhDDJu
	F2liBXjOLxjXAETB2nV+WyZnk0w==
X-Received: from iof12.prod.google.com ([2002:a5d:9c4c:0:b0:9c4:b80b:7605])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1384:b0:4ce:a4fc:a848 with SMTP id 5614622812f47-57a06a0da3amr989109b6e.6.1795114356571;
 Thu, 19 Nov 2026 10:52:36 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:03 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-22-coltonlewis@google.com>
Subject: [PATCH v10 21/33] KVM: arm64: Allow kvm_vcpu_pmu_resync_el0() to
 resync filters in process context
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, kvm_vcpu_pmu_resync_el0() only scheduled
KVM_REQ_RESYNC_PMU_EL0 when called from interrupt context (such as an
IPI reprogramming host perf events). When perf_pmu_resched_update() is
invoked synchronously from process context during vCPU load/put to
reschedule host events around guest-reserved counters,
armv8pmu_enable_event() calls kvm_set_pmu_events() and
kvm_vcpu_pmu_resync_el0() in process context.

Update kvm_vcpu_pmu_resync_el0() to call kvm_vcpu_pmu_restore_guest()
directly when not in interrupt context so that newly rescheduled host
perf events have their EL0 exclusion filters applied immediately.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index dbbe219ac874f..d3fd438a57b09 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -213,14 +213,17 @@ void kvm_vcpu_pmu_resync_el0(void)
 {
 	struct kvm_vcpu *vcpu;
 
-	if (!has_vhe() || !in_interrupt())
+	if (!has_vhe())
 		return;
 
 	vcpu = kvm_get_running_vcpu();
 	if (!vcpu)
 		return;
 
-	kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	if (in_interrupt())
+		kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	else
+		kvm_vcpu_pmu_restore_guest(vcpu);
 }
 
 void kvm_host_pmu_init(struct arm_pmu *pmu)
-- 
2.56.1.708.g77570a6a1d-goog

