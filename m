Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E50471423
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039234; cv=none; b=K1uzemqFCNNvZoWOoz/BaftFa2LBjVr99LSrj9NVkjfwCpwZkTolu5TjaVLIrRfU9OoX3LAqcrdM7CRr5XZKtJdGCToIpGbqeF+wwmKyea/sXYqdM83FfiWrqn6lxDeGrg+QYM9W3K2ba/4Lv4RTxO4hPFhpphqxjD9ScVQJ+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039234; c=relaxed/simple;
	bh=ESWEqDGYRZsSI1vcfclv9pR44HBFCQ1nMUmN+kbVMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovmNU+42tjtYnxQzzd6hatjJg1wWFtcv2az+2f/v9NvXsYNd17vQvVoUOhCi6to9A9d763pnj8WW6TixOblQoRCgZOmvf0IeA5r/xBgantU3U7TkRK/1TcMG+xvOY3m2t9bYWuXA+zoq3yJeFj6hmSqQOlB2lSlqu/V/lpQRAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8H8M7q2; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8H8M7q2"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso816713a12.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789039232; x=1789644032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ud3KHnoKUMFq1OptUmIGX0jhhR0g2r5px+2b5AftXww=;
        b=n8H8M7q2nW4nxh5dqRPo5d7MjCn8RrbMtoQb1+7bGepClxkD6+YqtMwCsrHNwcSQDp
         GjjUl4lhYeisQe4kgzip3XGq/7cSuxwFAA5x0dCF2NBUvlWcshspNSXSOEaa21k56ZWR
         T3sD42xcGWuMQRmKFoHUgo3psJsBJKu7/KDvHdNhrH1e9gbNIGqPe2QmeeupV9yAoN/z
         WVpFZ3Iu9j37TwLQ+mGRVRmayty4NKVia6hK1GxypIKCxGGhHaqRfmKjkeEEbfK1QVe7
         dADO2ni9uPHZ9qC+yFi7PASLUeA+DGKpbmGhPFag/IbHQDK6CFTBXgqmyJmjQsNXne5+
         /F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789039232; x=1789644032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ud3KHnoKUMFq1OptUmIGX0jhhR0g2r5px+2b5AftXww=;
        b=JcBgiuVs4YczALv0urPvufHtZKn8CoOHf9ZwU9wcxpmaSFQmLL6sLsHpxbtWRXs1nb
         FjHXiCIamiIvlHsjAqEGykM5lbAv1qAInhnq93+B+MiHeX3K2J0LJsNhPbJ0zfRtPaA5
         k+sx/bNb4kq0mgxvD76+0JK7cmM5doJODEHcSDDViogYZWo57W7Rh/TrIhPZVRIzKiLP
         no/6ZaUOGe7FxgG+7JXtwF7xL6WpsWOQa8lkH1LovU1DHq8J/2gzbZ8JV7sKZzwgp7pd
         Pzq4HxrUtzflaNne7KQG/4TOHWntLr803urkmJhYPBwSt86+KgivXq04LbVo3soVrwUZ
         QKtA==
X-Gm-Message-State: AFuF++l8B6D/cUm/qgBk4Es0iTD2QU1HQ+ganzQhdZUpElcm41tkcZyw
	vpwgfT/KTpuL1KtIvDzdr5ByltpYjqq5hRyyY6+xj14DC0SB70TyjGGf
X-Gm-Gg: AYBFou3yeKTUrBqZE7QMWeCyDmQHSmagy4T7lCTdj59WFTeq8h62zMG4hhbCp/xctBj
	x8ybhGoDWkejYLdOwtF9HUscHmNLNS7KyslHciIx4bxacYWQSI+4LCqvgtb+xhr+33h83XpZHNM
	53WpQA22UZTF08iJQZOPpJwO9asQBlkZqKahfapUlqX213JhmAwHlgp5ChnjWAY8pDUoQQ3Es6K
	MvRqkXdB+4cDIpicKKjjrsD8ISjbRVlvdwnXBXTRK/QGoKJZHItbLSRAfLN8of4i7LRzz/o7K4c
	+aFOWeK5CIHdCgg05pQnw40jrDp7NFqZGOWYfLkHAq6guUVDRZ+3Iu+S5pX5hocw4q3BtFhiV1O
	LdYRuTkYSshulUizGYPmawyfeEonvKczPkg41ord7e/bEdJy+yjl6SwRz5Dgse191qa36w9x1Q1
	kyGoG3REmICOSpDsgxjvX+p9Z+fRf0DcjVBchseCPXpoHQtEcC/ZGEfcxiVxGr9nNuuH1iDaby7
	reHVON1BTL6bOPtD3UZeIEeas4hFvSx/z30RpDfCQ==
X-Received: by 2002:a05:6a20:9c8e:b0:3d3:aec2:4dc9 with SMTP id adf61e73a8af0-3dacbf2502dmr10956041637.21.1789039231579;
        Thu, 10 Sep 2026 04:20:31 -0700 (PDT)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc46b4cd51esm6832464a12.2.2026.09.10.04.20.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 04:20:31 -0700 (PDT)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [PATCH] KVM: Simplify backwards dirty ring batch check
Date: Thu, 10 Sep 2026 19:20:27 +0800
Message-ID: <20260910112027.34581-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backwards coalescing path shifts mask left and back right to check
whether moving the batch base would discard set bits.  The shift fits if
the distance is no greater than the number of leading zeroes in mask.

Use that directly.  Convert delta to u64 before negating it so that a
positive delta, including one that wrapped to S64_MIN, is rejected by the
unsigned comparison without invoking signed overflow.  Use __builtin_clzl()
to match the unsigned long type of mask on both 32-bit and 64-bit builds.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 virt/kvm/dirty_ring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..8f39047ae7ab 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -170,9 +170,8 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring,
 					continue;
 				}
 
-				/* Backwards visit, careful about overflows! */
-				if (delta > -BITS_PER_LONG && delta < 0 &&
-				(mask << -delta >> -delta) == mask) {
+				/* Backwards visit, but do not discard set bits. */
+				if (-(u64)delta <= __builtin_clzl(mask)) {
 					cur_offset = next_offset;
 					mask = (mask << -delta) | 1;
 					continue;
-- 
2.43.7

