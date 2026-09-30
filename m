Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C736572663
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789881; cv=none; b=ZBmbrxmHZ4mbWpSYMNUeefbfQjigCUXSIFzeymc2UF+UVFRjg4hHx8bb482KQPAJB3aLrZsQQ0R3AXlrFYTj3IiGMI/r6iZNbLtH4NZ3prYugAfzjhFnSKi3UzKJztV7mb9i94uMZJ1pFTeyBh21Zd3lXQ/jZZZNcbzXWHqluzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789881; c=relaxed/simple;
	bh=LOOaXZKoe8wtNLN7lBkVfIcYsnvbxMTumouxwIMeXQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpKxijWcJrGIR6fGsHqoSn2fg7BiOmzVteH3ATi9X9CLCzFDMrpkPY/yu4yvtQJOb2kpS8CpXTeweUwHonOvPgTZnKab0pgfD8V0MOD3lcSsb1dWWCjpeOpFF4SMLMZdzetBVaEhAe/YpNSy/V1b/lvs8QWu1DUA5RlWuI+K4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/LZelHo; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/LZelHo"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7e6720b31so13165a12.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789880; x=1791394680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zgtt+cYSmfb6riOCPMQjLHtlD/tz8jpFy9BwyzLAO7g=;
        b=D/LZelHo6x3T/gTQa2RBSuu36vrYH/0pKG6Jnnv3owp+Z4fKaIuJ0it2Nfn5LC0Ja4
         a/i/FY6onTQYBm2lvdePl7mWyizIcFm2yjMa7OFHbRDS3nrCrjBdFc5efWyYWNHqkWqd
         kifGwF3ToWBXu6tH3oyqNvGNELV4R0He6QYDM2ReE3TWfozEbxLFvjojYI4eylzTphBc
         H1xwyTK3d3uK4LCvcWuUF8D+6bAwkh+1zun3DSf6UHoGjlMrvhTy/NTZ7IDO3HmM/dI+
         XY2TKtgTYpm52Ysez0MLkGBblZG8psD1nxLdrk4FCCh57WEK0QiHtTrLk//O9JywnK4N
         ygSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789880; x=1791394680;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zgtt+cYSmfb6riOCPMQjLHtlD/tz8jpFy9BwyzLAO7g=;
        b=mXTOc+TqcP7JKls91HanE9yszFZQ58IARDpneQA5MPnTXx6caWrxAC38t70B6o615x
         OKS8hNzkYrAQ0bkXmbS4Z1tPauIcmVAro49p4DhmqFoqdFubKUniQOCpIP/i+rdytEuU
         ileZ1B1wbptC0gDWuTwRy362mWRh5zukpjXxCfgoKkUiEPuQvJ36aaDHZHk0B3lAtgRZ
         foHCmu5DlBSgRHDAmMHmN8K3Lizy13OJIvUuLzsXct6hmVNNQVdPkbJpQafRNE6oLTW2
         NFzf4IuzBKOQH50BvLuuIElhk2knZcNr5tZpFeFgiCjb6PLIpgraUxlRoIfv2L+7CPs3
         P2wg==
X-Gm-Message-State: AFuF++kz2YeTo9pa5J32W7gD2sN005edQMdtH52jSddmbyulAsGvv1jZ
	og0QuDfjZYTSs/3iXqxYgtyek5ehCG5PD8D+VeYdwwcG4DHEpftikiJqukCY4Kcjp+36+kf/LWZ
	ZUInSKw==
X-Received: from pgbgf14.prod.google.com ([2002:a05:6a02:2cce:b0:cc7:b470:94ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10e:b0:3de:517d:fd86
 with SMTP id adf61e73a8af0-3de9e8511d1mr1994255637.35.1790789879386; Wed, 30
 Sep 2026 10:37:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:31 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-18-seanjc@google.com>
Subject: [PATCH v3 17/21] KVM: selftests: Verify that KVM saturates L2 TSC
 freq on {under,over}flow
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Extend the nested TSC scaling test to validate the extreme ends of what
hardware supports, i.e. validate that KVM allows L1 to scale L2's virtual
TSC frequency up/down to the architectural maximum/minimum, from L1's
perspective, and that KVM saturates L2's effective frequency when L2's
frequency can't be virtualized by hardware (which is possible when stacking
multipliers/ratios across L1 and L2).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/nested_tsc_scaling_test.c         | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
index 1d578af393bd..4cacd87f129b 100644
--- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
@@ -193,6 +193,7 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l1_tsc_freq, u64 l2_tsc_freq,
 
 int main(int argc, char *argv[])
 {
+	u64 min_freq, min_multiplier, max_freq, max_multiplier, l1_max_freq, l1_min_freq;
 	u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
 	u8 frac_bits = kvm_cpu_has(X86_FEATURE_VMX) ? 48 : 32;
 	struct kvm_vm *vm;
@@ -257,5 +258,39 @@ int main(int argc, char *argv[])
 			 l0_tsc_freq * l1_scale * l2_scale,
 			 (l2_scale << frac_bits));
 
+	/*
+	 * Test that KVM saturates L2's frequency on both ends if the resulting
+	 * L2 TSC frequency would be below or above what hardware can support.
+	 * Because L2 = L0 * (L1_mult >> frac) * (L2_mult >> frac) needs to be
+	 * distilled down to a single multiplier, very small/large multipliers
+	 * will underflow/overflow the minimum/maximum multiplier supported by
+	 * hardware when L1 and L2 multipliers are combined.  KVM's behavior is
+	 * saturate on {under,over}flow, i.e. to run at the min/max frequency.
+	 *
+	 * Note, userspace can only program L1's frequency in KHz, i.e. can't
+	 * specify an exact multiplier.  As a result, the minimum and maximum
+	 * frequencies are different for L1 vs L2, because L1 is constrained by
+	 * hardware *and* KVM, whereas L2 is constrained only by hardware.
+	 */
+	min_multiplier = 1;
+	min_freq = mul_u64_u64_div64(l0_tsc_freq, min_multiplier, BIT_ULL(frac_bits));
+	min_freq = max(min_freq, (u64)1);
+	l1_min_freq = max(min_freq, (u64)1 * 1000);
+	test_tsc_scaling(l0_tsc_freq, l1_min_freq, min_freq, 1);
+
+	/*
+	 * SVM takes a 40-bit value (right shifted by 32), while VMX takes a
+	 * 64-bit value (right shifted by 48).  mul_u64_u64_shr() isn't (yet)
+	 * available in selftests, but mul_u64_u64_div64() does nicely since,
+	 * albeit more slowly (performance is obviously not a concern).  Note,
+	 * because KVM_GET_TSC_KHZ returns a signed 32-bit integer, KVM limits
+	 * KVM_SET_TSC_KHZ to INT_MAX, even though hardware (both SVM and VMX)
+	 * supports much higher frequencies.
+	 */
+	max_multiplier = kvm_cpu_has(X86_FEATURE_VMX) ? -1ull : GENMASK_U64(39, 0);
+	max_freq = mul_u64_u64_div64(l0_tsc_freq, max_multiplier, BIT_ULL(frac_bits));
+	l1_max_freq = min(max_freq, (u64)INT32_MAX * 1000);
+	test_tsc_scaling(l0_tsc_freq, l1_max_freq, max_freq, max_multiplier);
+
 	return 0;
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

