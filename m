Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE523E3C50
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647081; cv=none; b=BNnTTCOg+Bo1Uors1EsYQkBa0GzcJT5/p1fWGvg5xxD5QZBZ6MR4UP0/6uKWxmykyMbGcNqkurz8o8uFR3iadIMiZSl33HBY6uFwGDK3NVXpjbD+5uDGmGYTMz7XcxDDg8wiMhv3az9zZiiBBNykxZvaB/vXrLlJcUKNJslFZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647081; c=relaxed/simple;
	bh=GC6ctnqH49PdSJv4HAShbCKDfdndlZxHBrXCNy37gbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkUt5h8QgTXiRGTIX64hWf6O4zNbi5guPuheZkWy2gRFR15PoOOcFpwiITXzl+kRbiWOAwHW/lNz9ziiWsZJ4B1UWJsVaVCJYT7ti3luTxQimeQp3UPjcj/O33ynnILvn6qzGKs9ytQN8w8YNIWiyxDhN9o3cQNGZmVDghMAH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JarH8Vdu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JarH8Vdu"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so5329116a12.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647075; x=1788251875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hN2Jmy0Yce+ny/9mzHdZVPdF+NxcdzE2Ab9UDeAEcWs=;
        b=JarH8VduvcjbVEcYX2S0ITjFhtfajhPeRrDVuLtIB/650L5r+3DQOo5cDtVlND42ef
         LEbi5LecOgQWEme5ku3Xi5OQXJHTPYuoNUnruuZ1yauemORB/20zd8hXG9xNt7eTVxNk
         JWCaV8skOxZxiRQ2f8qEpeOgjBm/94oAp1mibEABaVvhGFHDMPE3Jix95XxrgUwUqfpA
         ECyvGAEQ4NyE5c0I9sqCmXwyyvcazggaFOkI8L6Nk/VQ0xhxZbnxgfTGWHDrqLhKlqWM
         AcYR4h4n6qPWYsh0q0KafEE1mcEKpnINAKPLZr2PeiIgvONRrXttKvvv2QrQgbaGl3xy
         fu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647075; x=1788251875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hN2Jmy0Yce+ny/9mzHdZVPdF+NxcdzE2Ab9UDeAEcWs=;
        b=J2yIQ8VoPOS1zv4ctFBSJiaj12LIV0u0ks+PR4LFdOgBX0RPtPxlWA9eaKxXrIfz8a
         wBBgMwb/tuOLUi51OtAa+aWkCpsHg6A+PD8+12aUwt7E5opo/658xb1Cg2ZuqjhyoNyh
         A2pTOivRHnFsZpi/i25JXq2briX4p4LywoWRH0RCjz49pMP8q2YjUlVYe5d+1AcMeta+
         wLse3TA0PmMogDuv1cWIlvHk9EVi3kILjV3ufLc5ipLZ4/cctf2OYSpomuNgwfg1b5Mk
         ol1wSb5jyQixhUKFCyILI1VU3fuBUiHwNlRSKKHSoRwxgy+/xSBx472PCVMot6NXEaA2
         8Y8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpgmbTzo8VnCVmYzykMMRnnI/FipRqa/4RW1MSFezbyAR+d/JOl1ROAFr13T3G/Lfmq2xE=@vger.kernel.org
X-Gm-Message-State: AFuF++kA7xP/sgo5qTVILOpSRevD4AMvePCIc6sa/Td1pnVWJ8gcaMZe
	Ep1yZF2XgpUX7f87le9T5W/53AZRbAAeZvugzkZgQsZ5kyshe8SQThft
X-Gm-Gg: AR+sD12EMSEZpDJBzmFPHKhNM3fDmpTzZbjYyZGRBMOQsvCfKHew/cj9Xg8vYgt5uui
	gyyRY8oisYWdKE2vSMg8VkNINPeF+PS17L+HDnfa/B0kVvJUcMw9gERJL/o4vcPu73ilpPBmFcd
	xmbBKYFAQrNOXYtMiftGZlzrl8e0XIQ/h/i4jsVUspkJZzJuuy62aSoZ/pqqW4Qhl3Bq0mBOmii
	Gh6voxyqEc0+cfs5TXacoAOVDNSAOCTS48QH8BNfwbIfETwRla78/VrPUu4Olp5/jIb/MK8B+Sl
	Iny/FRpWrW/gS1qFluoUMMeO/ANTI05KIx3YHOuNoDl4coPQTEYJN8rtxwYcLa6+xaDary7J19B
	Qk6R36SZEb7xKPRKODjvK5LLoDXHykP18tz0QPaYMy8WsNSuh7sQy2vRcBFMnpBkJI4odq5cztI
	SDy9lHMAPgNGk6z87BP0P3F5hRuZzTV0+2bOoreEj/tQcQkIObUO8BQg96InUsO98/AZ7HKvBhU
	d/OCFtOA7Zz
X-Received: by 2002:a05:6a20:c90c:b0:3cc:22bb:8911 with SMTP id adf61e73a8af0-3cd2fe7a2cdmr66070868637.6.1787647074852;
        Tue, 25 Aug 2026 01:37:54 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e60abbsm1835887a12.23.2026.08.25.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:37:54 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev,
	me@brighamcampbell.com,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 3/3] RISC-V: KVM: Fix perf-backed counter accounting across stop and read
Date: Tue, 25 Aug 2026 17:37:19 +0900
Message-ID: <20260825083719.643970-4-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260825083719.643970-1-suunj1331@gmail.com>
References: <20260825083719.643970-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmu_ctr_read() adds the event count returned by perf_event_read_value()
to counter_val, which can accumulate the same count repeatedly across
reads. kvm_riscv_vcpu_pmu_ctr_stop() also leaves counter_val stale by
not folding the current event count into it.

Make reads of perf-backed counters side-effect free, and use
perf_event_pause() when stopping a counter to fold the current event
count into counter_val while resetting it. This preserves the counter
value across stop/start and lets the snapshot path use counter_val
directly.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 45dd5233340d..7d50490cc622 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -268,12 +268,13 @@ static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
 			return -EINVAL;
 
 		pmc->counter_val = kvpmu->fw_event[fevent_code].value;
+		*out_val = pmc->counter_val;
 	} else if (pmc->perf_event) {
-		pmc->counter_val += perf_event_read_value(pmc->perf_event, &enabled, &running);
+		*out_val = pmc->counter_val +
+			   perf_event_read_value(pmc->perf_event, &enabled, &running);
 	} else {
 		return -EINVAL;
 	}
-	*out_val = pmc->counter_val;
 
 	return 0;
 }
@@ -641,7 +642,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
-	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
 	bool snap_flag_set = flags & SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT;
@@ -679,8 +679,11 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 			}
 		} else if (pmc->perf_event) {
 			if (pmc->started) {
-				/* Stop counting the counter */
-				perf_event_disable(pmc->perf_event);
+				/*
+				 * Stop the counter and fold the live count into counter_val.
+				 * Reset the event value to avoid redundant accumulation.
+				 */
+				pmc->counter_val += perf_event_pause(pmc->perf_event, true);
 				pmc->started = false;
 			} else {
 				sbiret = SBI_ERR_ALREADY_STOPPED;
@@ -694,9 +697,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 		}
 
 		if (snap_flag_set && !sbiret) {
-			if (pmc->perf_event)
-				pmc->counter_val += perf_event_read_value(pmc->perf_event,
-									  &enabled, &running);
 			/*
 			 * The counter and overflow indices in the snapshot region are w.r.to
 			 * cbase. Modify the set bit in the counter mask instead of the pmc_index
-- 
2.52.0

