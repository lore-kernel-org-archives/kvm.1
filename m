Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E63914E9
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731464; cv=none; b=QFWw/asSLO+RB3p08YG5955QBRnnnBwpGlHUAMjZuNM3nrXzIhky2/JUWoDNqfzt+Z6PPC+976QjvSyRwIZYHovnfHc/Xa56lgMDDtymemf5YQTaCIVU/E2mhlNtuLdfPjRzNH3anBnkaHaP0PWvPRHph2dPtdbxGAq4qNLVoH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731464; c=relaxed/simple;
	bh=9sUbCyd02ndB1VZKJXATLmtcx8shFR5IpEb5QeZDF1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+LLERFReWp5IpXyB3fVcPosshEj3FzuadSvgmuumwP6j+lagv6TS59r39ASDZqkYHExUfpEzvmpV/O0ElYiYjYTpcDfQw38WYADbBfeIdyaBKJ0pC/X357oD+rbj0+V2psGOwy/UVLIr8negmeeDpXuoGoTHF6d/ysZWOD1DxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoUOUrmN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoUOUrmN"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ec6188so3614135ad.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731462; x=1790336262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ntrLxvkPRzxkiBPzxXVvlYCVy3b1/R3WQ+cKHpiMbM=;
        b=QoUOUrmNZ2PIJ8qXuRBIy6lnFPR/exlA1f4iHuxe9MNdwdy2ivBKb9vkpFK1RZtF8P
         /oVs9D3PbOhTxXFynkaIoeLHAe54EQ6iQfTQnwGhE+BMT4Q/oRFOeowbnPh6m8AuqNhe
         GVzLC8rmp65H/RG+f2tbzVFsDCGvf+aToexkx30sVjSU6m3VWB0QCiGuNysKl9OihoDs
         mIr+UjyleIG5UF/rw/+cQazy9euZyIUcs6iAslX3F+FaY5SsorDpUn5z/rOQldJWuuUl
         /cp6/mnmNPGL+XKNXGXFB/nDDniNDAi+0K0qn5CfJsZbybX8JUiXuUmb/KQMAoHpNQCi
         ilHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731462; x=1790336262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ntrLxvkPRzxkiBPzxXVvlYCVy3b1/R3WQ+cKHpiMbM=;
        b=SpWOIE4SbKXRJSd8XdEVWffDayzgUneXZRz3MVCidch0ONI6G5O1sGzLony9/SK6w8
         fj2XUzrY5bxfp1CGBLC7jdd7NTWQF1GeLtGJrhpSmQzcgwSNt5//ZeYtTKrLyeSqcvHZ
         bgfYK2fNZBE7IqkBCI3Orgbae4UvKkzGl5k90mnIPVu41jPHMrWaG0s29JA1uXLFtj8z
         Tv6axRiyM0SfJzP56IK7lyawYdp8Ue6IRbcgYhKzX6r7NP49euzHeDIVJCxz6ldTFWMq
         cY03MSXcSy0A7ib8nK+AiLDfXSQH6T9ZjlD+Gckf5Lz0DRC07Bu2aFTJCH4n0SyyomUI
         I4NA==
X-Gm-Message-State: AFuF++mMhYAbdZiHHVRSdOVB7iFpyTflXmM3UPDISxOGAJ4XzH+4d2K6
	zLHx1y/gv3muDaaJmAy3o6WDlUz/57Msp9fjXJdk4dt2QdxkmtuLqa79
X-Gm-Gg: AYBFou24WTvIBdUzVnn0Wf9BXqog8+1mWMdODrEB3raWgE5FOxDrkmzEa9h4NQis8ah
	s/xj8iShHl4IK5vQj5oD4kwF6gZBQR0f9luHOlFAgQWEMBbNRnRSOA51zA82vk7fL7fnfDcT754
	vUHvSGW5oIFSONJxzIIbN4cuvmUKT/+bV62tskU06I34055VKdE+sRJytoSECGDgwHJjNlKLPQN
	P5qS765PtGm1ERsLji6PKZthOicyP2jSlHwsbSjwc8i+vbQOB/g0FV/LL5+sXmjKOhLL5CvpFcB
	7aYXAGC17BynQYWFRwSY5rkwlYbZESffQ37tv1nrXCD10OytRKp0SjjpyPN/TEClNSy5vFOfQyy
	JzHlneupzqNKZtUbVVtCDnmCU9Y9nNUvTE+H5AYWPAlPPWe2WX2afCZ57nzTm7Uc5cZ5jUVyJd4
	rxqlj1+B2zkLoVwogCDx8/1mQ61rECMUZV+rSAugWEhA1aCikBdvs3nc0M2/yjaQ095jBXJj6Oy
	OIiDDYoZeKWZs4TfAGcAlboP1bLoBXeND7YZ7tVRoFaUmUf+IoDug==
X-Received: by 2002:a17:903:1446:b0:2da:eb8f:b4e4 with SMTP id d9443c01a7336-2ddb1add397mr50997485ad.7.1789731461660;
        Fri, 18 Sep 2026 04:37:41 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb7527582sm6431355ad.17.2026.09.18.04.37.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 04:37:41 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH v2] KVM: Use check_shl_overflow() for dirty ring reset batching
Date: Fri, 18 Sep 2026 19:37:37 +0800
Message-ID: <20260918113737.13606-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backwards-coalescing check in kvm_dirty_ring_reset() spells out "the
shift left must not lose any set bits" as a shift-out-and-back identity:

	if (delta > -BITS_PER_LONG && delta < 0 &&
	(mask << -delta >> -delta) == mask) {

That is exactly what check_shl_overflow() means, so say so directly.  The
macro also rejects a shift wider than the destination on its own, which
subsumes the delta > -BITS_PER_LONG term, leaving only the direction test.

Compare the offsets as unsigned and derive each shift from them in the
direction that applies, rather than deriving both from the sign of a signed
delta.  The forward case keeps its explicit width check, since there is no
shifted result to validate there, just a bit position.  Also use
BITS_PER_TYPE(mask) so the bound comes from the mask being shifted, and
BIT() for the individual bits.

No functional change intended for offsets within a memslot.Comparing unsigned
does change how a wrapped offset is treated -- it becomes a distant offset
rather than a small backwards step, so it ends the batch instead of being folded
into it, and the legitimate entries gathered so far are no longer discarded along
with it by kvm_reset_dirty_gfn()'s bounds check:

	harvested { 10, 0xfffffffffffffffd }
	  offsets reset before: [], after: [10]

Such an offset is bogus either way and is still rejected by the bounds
check added in commit 577a8d3bae05 ("KVM: Reject wrapped offset in
kvm_reset_dirty_gfn()"); only the collateral damage to its batch-mates is
gone.  The new form never coalesces where the old form refused.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 virt/kvm/dirty_ring.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..8a9728fd7c09 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -6,6 +6,7 @@
  */
 #include <linux/kvm_host.h>
 #include <linux/kvm.h>
+#include <linux/overflow.h>
 #include <linux/vmalloc.h>
 #include <linux/kvm_dirty_ring.h>
 #include <trace/events/kvm.h>
@@ -163,18 +164,21 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 			 * is scanning pages in the same slot.
 			 */
 			if (next_slot == cur_slot) {
-				s64 delta = next_offset - cur_offset;
-
-				if (delta >= 0 && delta < BITS_PER_LONG) {
-					mask |= 1ull << delta;
-					continue;
-				}
-
-				/* Backwards visit, careful about overflows! */
-				if (delta > -BITS_PER_LONG && delta < 0 &&
-				(mask << -delta >> -delta) == mask) {
+				unsigned long shifted_mask;
+
+				if (next_offset >= cur_offset) {
+					u64 shift = next_offset - cur_offset;
+
+					if (shift < BITS_PER_TYPE(mask)) {
+						mask |= BIT(shift);
+						continue;
+					}
+				} else if (!check_shl_overflow(mask,
+							       cur_offset - next_offset,
+							       &shifted_mask)) {
+					/* Backwards visit, move the batch's base down. */
 					cur_offset = next_offset;
-					mask = (mask << -delta) | 1;
+					mask = shifted_mask | BIT(0);
 					continue;
 				}
 			}
-- 
2.43.7

