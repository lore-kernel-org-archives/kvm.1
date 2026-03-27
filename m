Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDC3DC4D3
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605020; cv=none; b=BCGIquSJlJoiTGTl59GKXpKDfdKNIqlsOPetHNLrk55y5ZmRKiRjgsNHdgx4SeGcU+Lgg3eNh5cKofA5zymG0EMrEZb7SBEIz/4J8xM1JhbNRy2XKA5gbWm2H6I92rUHqZkqTA7sFLKUKzsvzSGBROpnSf2x1GEjkV00+xrFCbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605020; c=relaxed/simple;
	bh=1aRHN1HrhugAbrsj57xMZIQw+SuHFxSkMmOmPZurSyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nR4/mqU8OEfiaZlhKBIfI8oQ5zKiFV1T39W87U6LpbJ4+NdAvzQEoIQb4XzNJy1ODXSrQi/yewhA2N/5wok9gW5k17L3JjFGng98YYxvGDxj+xlvt3Bh2YhDktgx78lDFWpKLtVartDb67EdSy4VK81Z1rYT3WiuoGgkePdzJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBkVl5FX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBkVl5FX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb14227cso23505915e9.3
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774605017; x=1775209817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zqN6vtlGEDX03lb/OTEIHW6JMIqpybLFJy8KDMEuPE=;
        b=rBkVl5FXUkzDM6U3qEewoiOjpg6Lm9F/S4Iz+cMynolOcfIDlBub4WMKczr1mO0NGe
         nc9964HAZvmkuGwAdpL5yBkzRsVN0+gFErTIpdS19YO0uHrHB0WdAsLl2zBiYIuHq/t6
         6PXGjkfF7f0GY5l0aWFwsDIDWHXJX9sd115xhXVgBimvLMBEqPSWg8dGgDWPr2lQzwnr
         Qc5wAUSRHVt9jlVlEX6iEj1pO9G8+tjILCO4DMpr9jZ5plJf26ntBfn4pz+i8YbJ4oAr
         EPCkLoQMHGw8iJ44q3S1JHmVgtw6ArX/UcHbmrrf0AYm+CnFtvaS9YqKdQSPEx9Lec9o
         pxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605017; x=1775209817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zqN6vtlGEDX03lb/OTEIHW6JMIqpybLFJy8KDMEuPE=;
        b=Cw3w+XIvTSPYcYJQEQ/tZNdO4E9KHYfXcTdovYaC41QZXwUNwRSYSDw2lfGOa2SrnH
         E82EYom4kPvu5OUa8+vCKX5KKPQYzE9ewqt1VvJ2b2LT1T7cSkj+QGZM8jx4BuqVzObV
         VJrW3Zv+jKdWDavQPawwY4dQv/0ATxIjszrTklp6xQmp0GonwC1oO9amiVfkcALgoEax
         REAnq4GX1a4oxkPTLncYY+Om7uIMSETfLs/ZCzfpktPe5lLOn6On9F/QAVMXCVWo7e2k
         xOAtBybUfAgGQSdxb6/FKSlOTO1uwEcaeYdOj+SVgYQDhVtGPe4fCcC9bPSgDG2W3LMP
         rNzw==
X-Gm-Message-State: AOJu0YzUORyRT70F3SdFLG4ioEYSWZcgtGgfcTswAvGTa0lT2cDNrWOg
	gtj1TIXONHH6VGgikSQ7Tp+reCCudar45fgjLDtpRr6f4N13uoXDwlRoGEOaWq/QBpE=
X-Gm-Gg: ATEYQzzmo6uZAfpzLEvFpW/CTYjjovlGA6vmzce8WV2h+35nfWSs3e4YYTXPGDDqsqg
	JSDtXXSoudco2pXX7StfTqOYLpr4WOGjK8PamyBa5E4VJ4hLda82vaH82/+F1oY/w/9/pq+EdlJ
	FfT5tI03HtXLCcwojgSk4+3Fvlz4PGRe7R1tnxDMfeWttzpsNmHRAlJoPBrvymcfrCV7mEjvIDc
	zfK/cao9faXvNwwalLVSKoWB5JuTwluq6KqOslkHbD74bfYmY9pU7zJhmFaqxCT0cxBrGfAuneX
	LDtP2BaQLWI3H/EMxvtf/pWE5vIUysp/Xbeu//ZrEHY/+g5G7GID8qZSFM7KoU3lnLo4mhMFJsq
	2jFKhfoMiKfY9AkjTAJ1fz4fmqiyvtwt+JszqxLY8CKlRHxst7/G0qiha4QZGPdGE34WOJqKHXe
	+KrhfPhDot/DL20cO5MepFmey6GXBcN6E9rIyMuKdQGTA0XcUqjMw47/oK18w1v+VsvEadQfg6e
	bf+8N9ncqzMU0DoJ39QqrK+2qKIbyqkDP2SC5w8SqQW5J0=
X-Received: by 2002:a05:600c:45c4:b0:486:fe45:483 with SMTP id 5b1f17b1804b1-48727efbed2mr30344245e9.22.1774605016643;
        Fri, 27 Mar 2026 02:50:16 -0700 (PDT)
Received: from Techashi.lan ([197.185.139.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712b3d3sm13116965e9.20.2026.03.27.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:50:16 -0700 (PDT)
From: Chrinovic M <chrinovicmu@gmail.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	linux-kernel@vger.kernel.org,
	Chrinovic M <chrinovicmu@gmail.com>
Subject: [PATCH] KVM: Document next_segment() behavior
Date: Fri, 27 Mar 2026 11:50:00 +0200
Message-Id: <20260327095000.134105-1-chrinovicmu@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a brief comment describing how next_segment() computes
the number of bytes available in the current page when
handling guest memory accesses.

No functional change.

Signed-off-by: Chrinovic M <chrinovicmu@gmail.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..03ddfafe005c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3176,6 +3176,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_unmap);
 
+/* Compute bytes available in current page for the guest memory op */ 
 static int next_segment(unsigned long len, int offset)
 {
 	if (len > PAGE_SIZE - offset)
-- 
2.39.5

