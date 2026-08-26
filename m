Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3C3630B2
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775433; cv=none; b=ke2J/up1X6qIMb27Hmv3LE6xBOfGFF1AJIP+P0zD0Q+W8ViJJ08YRBKZ0SzeW4JFdubsxd1oq7P7bH7So4nIZMXsBzf/nhpwHU9Y5a7ZHkGUoBUhDV1gKT83+GHXnUQH5Ts3/kr51DZmiDB5Qqz7/A4cfTjsA+asZlUnsy8aqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775433; c=relaxed/simple;
	bh=3Pduo1gHVDIUUt5sDBfU654xzH3NpDT0jtFbBzAYHKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzEh9kqi7wvfxW9wUQnQANXFilqR62yVSrW3Xgf5kxbxnUnG7Co2cM50uLNMiO5EdGmUORqP7/Z45KVGD+HTC0IiS9YG3y3hChpuDsy18raBFEqXZdAY42Rd73igmv34fa0iNXwcUKFigo/5MZs3n34t34r31r+VhIppwGEunlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VPWOFY/N; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="VPWOFY/N"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d5cad1a6baso14518535ad.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787775431; x=1788380231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QhjGgYTatBrHOcQxWsDxDksd7v3LZqmlD+U/i4Av3LE=;
        b=VPWOFY/Nj1NZ4RktRY0Z3H6xTeuxBcS3n54MAU71fZUSZmwH56ciowhwLmjn9I55W3
         pKQIwGww7siRGWLsc/y68bd442NQC/KYfF6sPTWKffHodsWjz+RQvuPAj1Pchp8HbxgS
         bDs7yzVJVO5Z/ncipvOwZB2EFZMTqqYi+jYeklcevgQzkt6QHCnNBUWxN/9XYrr0kyWj
         cVaDGVU1X/cmC5QP+FmR5zVrHHlPb3IcvgwPmNv1gd2dXCxjf6P+Wb/4I+37IzYhBzQP
         qFyVewDMDgq7h7pWn0TF/5H5OCXC0C/lMM57s1zsHSzOHZ09nBZ4lTNdXcgdV/egR94y
         XNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775431; x=1788380231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhjGgYTatBrHOcQxWsDxDksd7v3LZqmlD+U/i4Av3LE=;
        b=VYZtFAXzAgkAW8D+PywbrDIllwcZZ/EKSlMLBcwurvWbkeZWqH8bORTZ+JWGvH3GmJ
         TB1ZavyZYKHe9QlbJqAAAZ95g3hZHp5b9dvr8vK49q+FWCxhRu13kB8lmDPh90cEEl/P
         HnTL9xjzh6O/nvkiY+hrApezRPq4OxPueMz9XBHJsI46XBUSjPM/br/mYfVfp5UiLWv8
         uuCsFNrbledBVy5O3g92xgruBbDO930K0iN1KWP+0iLwh3tmqoS5caHISNPw9uuwrX7E
         qMHeQVCLW2PUIq1PWyEGgnH27TLykGJ7BecEq5cxuEnC///5360jdvgQO/R7W2NvOn6I
         fNQQ==
X-Gm-Message-State: AFuF++nJUHoWmWY1lusQ8CjtwwNs0wAawMq9QNXCbfA4dFXKAd1o/fqC
	A2NmJqq31axuwqBYdSpLCMAJl0n1KHJ/si2xe3QJhQ/xanVgdNqSc3ZEacTwKHzSWmw=
X-Gm-Gg: AR+sD116vcbTFzmGSpmMDBVHAnxlGq63Hj6af8mELeUbjEqC5gZkrFtuE9LN2a4xX0O
	AoFIKJ55xgj8U+sicCI7o52Ag3h4v2ktJQgPTmF8PT5WNhOSguf0tWJpKanh3TJKAlEdUsrt1Iz
	Y/lrQsIw0kYyk7xLopYgOWUq3IlZcZmr/V/A8AxX7tm6d/DHJ8x3ZADVUuP0xPAIr/V+KdTi7Z1
	0bKbtkClH+xa51LFRhB0myhI17cHipNv5yYXnkL+JcfsWkzUR7FP8v5ks+07MVHEuhVV4dmv7oR
	PnNoCoSJO4Q9wSLZRMQmtCtWJID31HAikIRavuUme1PVJtmvU4dt66zzYba2c3HRTGCL6NE3LjL
	Yb/CBTOyivwmYyOvfPrWXXbrot3MfdYJK+DUAXP5Md3xbxv4Bz74pnCuFKv9a+hS5XAbRW2U3wq
	2Lkj5w2bKG1YArHKHx3CUSVyqcfCrMT1QW8b41CAFdGsdINUPcRopzEFMKk0giHQw7vqjlXhaok
	iftOqj44rZ/ag+/50fKP5KifuWfpoc4ekrV6/K5oHy9DwxBsXkXgMqINZU=
X-Received: by 2002:a17:903:1104:b0:2d6:e401:9676 with SMTP id d9443c01a7336-2d707955aa3mr161833925ad.1.1787775431276;
        Wed, 26 Aug 2026 13:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:957:eb3d:7323:2ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60b59dsm11179738eec.3.2026.08.26.13.17.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 13:17:10 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kimjw04271234@gmail.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.6.y+6.1.y 0/2] KVM: x86/mmu: Check write tracking in all address spaces
Date: Wed, 26 Aug 2026 16:16:53 -0400
Message-ID: <20260826201655.9198-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please queue upstream commit 0f38453cdb2e17566ccb7c0f3dabd5bd21caca26
("KVM: x86/mmu: Check write tracking in all address spaces") for the
stable trees. It is in mainline as of v7.2-rc6.

The fix is absent by code state from 7.1.10, 6.18.46, 6.12.105, 6.6.153
and 6.1.184.

7.1.y, 6.18.y, 6.12.y: please cherry-pick the upstream commit directly.
No patch is included for these trees. Commit 0f38453cdb2e applies and
compiles unmodified on all three, so there is nothing to adapt:

  git cherry-pick -x 0f38453cdb2e17566ccb7c0f3dabd5bd21caca26

6.6.y and 6.1.y need adapted backports; they are patches 1/2 and 2/2 of
this series. On 6.6 the upstream commit applies but does not build,
because KVM_MAX_NR_ADDRESS_SPACES and kvm_arch_nr_memslot_as_ids() do
not exist there. On 6.1 the upstream commit conflicts: the function is
still kvm_slot_page_track_is_active() and the tracking array is
mode-indexed gfn_track[].

5.15.y and 5.10.y are not covered by this submission. Those trees were
not assessed.

Jinu Kim (2):
  [6.6.y] KVM: x86/mmu: Check write tracking in all address spaces
  [6.1.y] KVM: x86/mmu: Check write tracking in all address spaces

Each patch touches only arch/x86/kvm/mmu/page_track.c:
  1/2 (6.6.y): 26 insertions(+), 6 deletions(-)
  2/2 (6.1.y): 22 insertions(+), 6 deletions(-)

-- 
2.43.0
