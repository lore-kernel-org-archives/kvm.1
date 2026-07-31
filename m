Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928463DDDD0
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494082; cv=none; b=HlxZ99kRK9gMkdX+dffMeFj24qT3Gl29JUvAZXY1DRWNwQVhiK7NCJFOuAcew0aW6bPCbrcENuOnqoD4g346XCmtVn/Bfv2gVDsiMoEJNsBchEOSQI7CXv75iPPyPvCnHQJhWGRLoRiRsPkxrVcWP7Ai6KJAanFQNxeerhLpuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494082; c=relaxed/simple;
	bh=U469aFp4Lp1fRTMeW5nd1UcvqPVbOxTPZGKcaDLzNjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tg1H7gFdvZS889MhMsRWJI1cGAwaSW8L/OCGVsPgMbyUlctBTmcRyERezq+0LNYldtLuFDBGiOWbPxkbwf/GmC+5Pf7Q3NK0XaZ67n8nFNKwX4s4dBOdxLQuSgadp4uTDaiPQwidcsg5uO4n5Jq8cXGewYYm2bqKUHbaDrF0URk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg01bxG/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg01bxG/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso445372a12.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785494063; x=1786098863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sbNYQDbxVpxt5RpgjMtZTIhW1qly1fVv3fTNwcQpnVY=;
        b=Tg01bxG/++4rDUC6XWkO0Gtw95JJUvC6KVfCDon0sc2Bd8VDsLO+BUCkqCndBGPCYR
         h9MAkG4lotetWqGOeXRIBqO4hN4X9huNwgrCOTfgmlJQp91rjJLboQ40tiaJehX6tj2k
         B1n7Txq2+U1X2SRw1A5mH4BzUZIJDE12+ugu/MSowWdk1CS4tq8OXgvnEO5TEkRoWoJL
         yWVhU10CXsXPYZVXVI5XZsZu52MjgfYVGu+Hb0PTkOaZzRah0eUiA3GhzR1jzmcDquAR
         5R1i3FcA+WtpzXNk1vAL33qRWQ87M7lUbSJnMkzwyE4cM4K8+6JXiqdmUIhmV96jkG94
         KTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494063; x=1786098863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sbNYQDbxVpxt5RpgjMtZTIhW1qly1fVv3fTNwcQpnVY=;
        b=V3WiovOmXOQb3PGWNKHTbRIninE/TqVr/iTKOAWlgAARVNoyEu0boFe0b5vvV2XvFB
         lUHKKDbyIos/Kjj4l6R/H0T+Mdo3N8TIg2df+w2PwgUX3yHHfmfCc9MFVQ8zUsdT7n79
         wGEHwBjj21wDF9hA+JkKYKsZhrFMhqI1fq6xaJedI+dgQw0gaKTURRE331OCo4rpQNbv
         wnEmwACfKPMBNOTsGZXbqVHFM+X/9e8GWBhbE7fAdDUBXLIdIrk1joq42e3nnFyWn3yn
         E3Rqd7NoiEondNoKLRlY9elMdgpt1mdPxOfb6g75fFSlm8UwoEuK9Wkoho/9fXww1xll
         37Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqTs+Yx82qWzxAjbY+qzwARdoyhp4P4mSzcf5YA0qFMm6al2Cg358EpKfaEgbZ9ijMNyLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcEp/IWPR0auF6OrpcZuHGfvaZfmrmVSqEyGFBKtQECjU/KNv
	1g9B5A2t1/G3VFTpKkBM1M3QPdFK20WxpiN/JF0Fi5zMsraVJkQevcwE
X-Gm-Gg: AR+sD10GrTJRCvR5LDzqtaC91MjN/e/V0Dcdgw4gzWMlf+LDGLq9hl2wW/2yhXbiw7u
	pROsYkCeQ0wOoampASYOFvfYkZ210u1BpZvcjvVttZD7+f5B+oVViGwR7c8oUL476pkgsRMRDqm
	wHgvyQlPXgadBN2bS1ewVTH3wguwkg/0AqgBDXIXjvc00JdfNoQn/vGagx3ex0eJR0nlXW7AI/7
	9CxTpqrAIY+uAh8NMc2Hw9mUE1Z7gGMiZahrmTty8Zz8U2wxaR/szxHcgiyyMsI3PQM3xPYVeFN
	DF0ZZMzInTtnFYKNQmA1cUVSta+BMHNXVjPCPiOaFJDJvwuBjRZuuGd7JG3/jAhIKTqSvgXJLEf
	1EoYArvsf3PvgUQN29Y0EzgrQcN3YnEr8kNs/VMzEl97fA1g6hM377hu7tuPfgNUlHOfpWZa3Bk
	n1z/Q3RLemQN/+Y21V+XlwHrNKXxc3rHzCO64yGqPhiyeEfG4pLBs2zjirkuq7lWje8RWlWup9R
	w==
X-Received: by 2002:a05:6a21:1fc3:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c91b05e368mr1197360637.3.1785494062695;
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e0700e8sm4510601eec.24.2026.07.31.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:22 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 31 Jul 2026 18:34:12 +0800
Message-Id: <20260731103414.1746316-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104857-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested, split the changes into two patches.

Patch 1 detaches and frees the device IOTLB when ACCESS_PLATFORM is
cleared. The device and virtqueue IOTLB pointers, metadata caches, and
acked features are updated while all virtqueue mutexes are held. It also
drops old IOTLB miss messages and wakes readers.

Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
so a runtime logging update does not discard valid translations.

Changes since v1:
- discard the existing IOTLB instead of returning -EBUSY
- serialize the switch against all virtqueues
- clear old IOTLB messages and wake readers
- move the existing-IOTLB preservation change to a separate patch

Jia Jia (2):
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vsock.c | 46 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

-- 
2.34.1
