Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669481;
	b=g9ydCPPuKBRDUpVcmqrICn6PxGLTwVL8tXL6wRvFCADvdlB/6xZG88mGqdvjI0VQs1ft
	 fiTOJkkTZOWwqhepHi0nbZP6a9uRQhKiFtcS/TXMufZOmy2zUqNf2iiLKUJTrh2pDa3u1
	 LvXsEfkh3Zed/iDOlBmrijlCCbUynJDGbHxt9/TxXbUynwe+kSj4DCVTE6juGME+J3vnc
	 qnRWvlbG8x97kLChvoK6HDYqbVA/Sw7MKEnZB2+2vk5KdlSqAmoTHGChVQEG9iILR4eMm
	 AceXfZ0Mj6WD41S04QGZD0LfShrjA+hJ0wF+Ab8TdrpleNb+Z7zN0PfziZxG6hI6row==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cH1jlSFhK0mGHsLxV8dy+u0fQutnOY6cmJtrmOpCEuo=;
	b=nFN6f1Bu7IjRocy3feQljQuK8uhw/ZNTZNbM5HgeSXxVeEvEzG16o/P2oy0IboiZ4Q4K
	 5e77U9NR8EMfUnDsUcFJWurhQis8xd/Y9+cIefpMbN1DLhiJkUEmc9zvSJSYdKst3gue1
	 S08kLo4o27k9gbuNqV3bHtA3NMBE3IoyKei0Gc5VchIu5BMPW7gAjqKW9NE3FcX2F3Gxs
	 LypnLYOOH5ouhvE51zPxNLAdCIKjrGaMFsFFs3JsOnvtySAtcxiJK9OkN1Ga1b8aSpN7c
	 iZ5W/0Pr2zJNP85Bh7OinwJ8scyJHCJRaLGzj8ThXDrAHjY4xfPHU6Ao2HsFK+yinSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnTxjq8t;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730F606A326
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2730F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PnTxjq8t
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso14036102eec.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669480; x=1796274280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cH1jlSFhK0mGHsLxV8dy+u0fQutnOY6cmJtrmOpCEuo=;
        b=PnTxjq8tI6kCOP/bPiuHjw9C4iCyD6ht5hwFtgXbCh3meDVFqTxo5OLiizJ2qpReyh
         QhIOfsEQBp/f7ZQ6yr9Owr8iYS8YaGc7TPtFrHgArzrhX+TUp3EKXrqitdrvnru+8UP4
         lhZfjlJ0FZuIi0lC6pv5HL4XaZR4NJpFpsr4zcWOMEqsX2e8bmj1X2rgrvMdrD2XcdaS
         J2lreDfdAfxiFStLZNbD052GaMmaIVnODlmbuDi0rfKMQ7UF7wZtADxXPt+YzqEv3nVx
         Lfnlmh1Ka/Z4661KecWLSYq9stGu687K4YCbxAFkzb6t7boQcSMiDHKNy7VTJ4zvrWE8
         iPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669480; x=1796274280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cH1jlSFhK0mGHsLxV8dy+u0fQutnOY6cmJtrmOpCEuo=;
        b=P92y23rCmUMGM+xeZX0lJFJFbB9GciqmTE9A/Z2OrgtURlo8jC84RiqV6jqV0bmnhJ
         /BjErDhfe/vx8NdO/PLrVRsN2GxwPDw+mVVhXDVF3Wd5yEQ4bx7lk7r4S5xzQS8/yxCn
         XX6Jjg/W39NmQIuPQylXexrAjENQWLHQi4SUHsFDtKYliFGKI7ikQwOW91rUM3AfLAyI
         mj4BiKd1Fdlo24CDDK8LbN5alR8pTF+6xAo87ZhWoGOJRGpihZyXo+nnr7184HIETKVd
         oPCgE4G+1gDZz8DdVzSQlhV2yBpfpjufGs1mzP+SvQYv2+UMbaoJqEQ/P6XX2LKL3Mes
         be1A==
X-Forwarded-Encrypted: i=1; AL+hErHPwAzGXH0e86Et3y1NDp73Xmyw5LDXZ6qgA0cqQWrv7mqI+3e1r1IQwyQ6mSeVkW1i2iY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z8X62TyPUQEvvq58oxLniXK8lQzCo268aAVES/EiN66w6MC6s
	vMRCbD9WiTqBBkbVWMZJ7EQLhIpyS/lqpUzh1/kC7d/k2E4o7/3PYtIvm0UHKg==
X-Gm-Gg: AZFdTZcFkebA64lQn4SA6tUsO8mvz9J0lnWyH7BAALl0L7bpMphKKJXjfu86HvIjPmH
	hTGIi9v+E5R2w28fP8Y3We1w/MsDrT/g0HZVPTaOfXqreNjsHtd/j4pYQEZ6lx/LbnL+XzreWL0
	DsMx+/jFcVzIEJ0yTPIYQbxc9DyGpPMfnBEFFurQZJSGHXKNDb4vDG+6L5b6sXbLRS7zeKJ0RLA
	t0qgbhpOX/3jIAI0x8jZAgLboEgQmf0LopWLGznQLSlN78n1H7MFFGyXVnLGhnn7m8rHQSPNCko
	Uh/5VLVjhPYKYdn4CYI7t56TZ8XQXr4TrEdNVT/lS1MN6DFMicsqAXF8V9TzfyKZpMuk7SyiFeP
	96Sz/tm7KkLJ/MnAmmtJpeZ/aSoEm15geJwSQbwws01ICJ9sAngQ3ncK8LyNTg8kql/eJCx0OPr
	5YNSWIn2whbhYAQ6F3DFdNXR/BT6fnYZ/+c2WGJwvB/OFAKQVY6ul1i4u+Ma85Ii/H9v9j247rX
	8Kmbiy9+a7duHcC1M5rroJFDMBJkGHmO9v3A3e5fuG8Zfke6S4vIu4bMzY1b24A4SBVaW3O5umO
	uSSwxjlULclqW9wGQGDyDTchtgpyrfnqROo1Rx2geA==
X-Received: by 2002:a05:693c:41cf:20b0:386:dfea:4434 with SMTP id 5a478bee46e88-386dfea468bmr861041eec.2.1795669480162;
        Wed, 25 Nov 2026 21:04:40 -0800 (PST)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm72015532eec.11.2026.11.25.21.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:04:39 -0800 (PST)
From: Gokul K <gokul02k@gmail.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Song Gao <gaosong@loongson.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MAINTAINERS: Add the LoongArch KVM selftests directory
Date: Thu, 26 Nov 2026 10:33:51 +0530
Message-ID: <20261126050352.1957454-2-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126050352.1957454-1-gokul02k@gmail.com>
References: <20261126050352.1957454-1-gokul02k@gmail.com>
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

The KVM/LoongArch entry covers tools/testing/selftests/kvm/*/loongarch/
and lib/loongarch/, but not tools/testing/selftests/kvm/loongarch/,
where the tests themselves live. The */loongarch/ pattern needs a
directory between kvm/ and loongarch/, so it does not match it.

As a result get_maintainer.pl omits the LoongArch KVM maintainers and
loongarch@lists.linux.dev for patches to those tests.

Add the directory, and drop lib/loongarch/, which */loongarch/ already
covers. The entry then lists the same two forms as arm64, riscv, s390
and x86.

Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..801de15e736f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14326,7 +14326,7 @@ F:	arch/loongarch/include/asm/kvm*
 F:	arch/loongarch/include/uapi/asm/kvm*
 F:	arch/loongarch/kvm/
 F:	tools/testing/selftests/kvm/*/loongarch/
-F:	tools/testing/selftests/kvm/lib/loongarch/
+F:	tools/testing/selftests/kvm/loongarch/
 
 KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)
 M:	Huacai Chen <chenhuacai@kernel.org>
-- 
2.54.0


