Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64582BF010
	for <kvm@vger.kernel.org>; Tue,  5 Aug 2025 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420759; cv=none; b=hWQBArSP7TJEn1Wq6BMXI/zGI0tQnSC7RoQ4vbihk5Dqhu4MPxf1j491nUj09J08mv0Wg2nvmH4WDwyLlSZIVh2rznWDZS1JUA5NwbhRkFy6Qg+pP7rFrDzGVX1cRsfTRbDJ734yyo6eETMWT+G94Uii1kjmst1z1QUG2tFa3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420759; c=relaxed/simple;
	bh=/sPXmM0Zs1fLp6muGCf+tjOXJkyB32siq6QuACEEbu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AH7v+6YXAZsTN5nLLTng3F2liLRRqY483U4g/eY3PgCxg/hYpxRQXVLrDQ0/LVl9oYhRmMQdw1iZXRMqlMx+7eUbn+dQ64F3S47cA8hUCRM5zuyLyrAwZesm6kaBKQdIWMVY0CtX1dZNFlV64Fv8kpfSqHgqy7814UozL5gaeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Do8gQd6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Do8gQd6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bc9259f63so5059641b3a.3
        for <kvm@vger.kernel.org>; Tue, 05 Aug 2025 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420757; x=1755025557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oCGEKAkbeIoGipEXNV8T0RUXqCHxNcix8LcZk/J0Axs=;
        b=3Do8gQd6Zgufyho4I057T0TokdKhRR4BSHkUQNflkztGtIWnCwyPowTcQjJvbIS1lO
         vRwOUze9Lmc6ECoi6TW0iaJUdJUp6oscjVyCsu1v/Tx+7VsNkAck/U0LCo4cWrjYORap
         bsf3MzCp+BtlPYnSt0xvOnJZiOHrtqXOAOoIgkHdrE/hkwdhRXT8/Yl58SyxQZlfzKXh
         3ywmuOkJw/xzIiNoxNOnYNuLOTRPZPRfCyj3BGITlQPcgNFYxpX22MhbA/681QpEdQfI
         31MqCq1759KB4YXfLElR13Lm6HLJAkAHTWn1VjKMk3G3q7lB5A66629iyQKI98NDb38m
         vUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420757; x=1755025557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCGEKAkbeIoGipEXNV8T0RUXqCHxNcix8LcZk/J0Axs=;
        b=h3vAubS32cOWZKRGOZTinZO9yS6eZ//PAq6yKUImDxPgC9hT9McNbGYLpMEBJJGIF3
         lBqMVoTBhlgx7o8pp/hmNEvPH5CgwskyTbpFaX4XE100HfqlBr8FXknclNKBkbmvBgx/
         P4msOmuk4QdfsQ12Cb+0q85VGR/ObLmKf+5mK6qpPqwhR52iVR3v5yvky/NlHsN7VQE1
         ROYeWYZRMM2msvfgsSJHv+JanF2hvOiDJKIRTMo66el3rvpbNRTIqf4HuQZDsxypLO97
         vixlKdvjJ44MsfUlBbkp4jEYyOC/UkOka+Ex/kp0QxXfzFwcscgr4w7eBEEY3MkQRbyk
         CzAg==
X-Gm-Message-State: AOJu0YxZTTxtc9qw87tVgKhYb+GMqDcB7o96pdLv3rT4Dt3u+OY02/+F
	tfgM+aCNd00BvSBAHr3+mb8Sd1dC7I8olbPofcrk1Ww+sHIQO2A9+ndnu9NV4h6NdR38pmMXJ56
	RYga1hg==
X-Google-Smtp-Source: AGHT+IElV3TzNFEvi73astSTm6isgDxLFlXWng4KtkNOcbY0eY9l7+S3hsyx3YXtIUtoz742t5l8ACYhINA=
X-Received: from pgah7.prod.google.com ([2002:a05:6a02:4e87:b0:b2c:3d70:9c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5481:b0:240:a06:7837
 with SMTP id adf61e73a8af0-2403146a502mr275717637.17.1754420757037; Tue, 05
 Aug 2025 12:05:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:23 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-16-seanjc@google.com>
Subject: [PATCH 15/18] KVM: x86/pmu: Drop redundant check on PMC being locally
 enabled for emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop the check on a PMC being locally enabled when triggering emulated
events, as the bitmap of passed-in PMCs only contains locally enabled PMCs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bdcd9c6f0ec0..422af7734846 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -969,8 +969,7 @@ static void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu,
 		return;
 
 	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
-		if (!pmc_is_locally_enabled(pmc) ||
-		    !check_pmu_event_filter(pmc) || !cpl_is_matched(pmc))
+		if (!check_pmu_event_filter(pmc) || !cpl_is_matched(pmc))
 			continue;
 
 		kvm_pmu_incr_counter(pmc);
-- 
2.50.1.565.gc32cd1483b-goog

