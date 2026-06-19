Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4E390986
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874343; cv=none; b=JXUOxtM+Rl3tuTr6HkcZLKYRo/2bW0Lw60pgBRqhA5r5D5TLcG5S0z8i+DR3k43vwQJHbkvQOL7s/+LAVT6jN6l3wShA622HwE82BA+tfEZgmanvoHPupQiRuznavCW9SX3whOn+i4epvja0uVKnU9o/YRqA7fW9BmGsA6twuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874343; c=relaxed/simple;
	bh=+HHA6dDvRTU1tKKYfXe38IJ1GKhRe45ap5fAWDZQb4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8d6WBIrcD8Gd5wGUcnNiyD79przZ6D4JLDabP6fhxKeoEPMoYtgb3mmYruAGCjEbo9EN71PyxY0hmQJ4NgOTBzTCxmg5cLtVXLB0xZlp0+7vJLWjN1iY8QudVmW0ZsEqPR7XE1FKYieU1y2u3R0jw6v0awy4mQGRgNA8GJTs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/ugE2/z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/ugE2/z"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4624c1409c9so1627991f8f.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874340; x=1782479140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by9u5EKjsb+5+gHbsiBm0Rf3TJxywMdtV+jmRIHAyvY=;
        b=V/ugE2/zxkFiZROWAztS0LpH3lc09KrrkF9DIeApFmqUqYrHKBbE19AbKazYvEA8KV
         iQBmXdCz9C/xxplri2lrXJg74PQuUCc4i8bNNmRHpSyuxF3dEz7D4zGTyikeWGbmvo88
         XVkI3rvF1z5wgKfQ9xK237rt5rW05hMVDR4Oj7nv8TTJzvzW3WeJZ9dYXSAso58jD75b
         oksUrbGf4LXWPzzFJHW+FcqdsEqFUaUp+Aw0lbyENK1XrtxH0Y0ReL5OT379QoRQv0Fq
         QJGbqU4T/g7jk0cT2SrpvzKJW9tAWtIOEsWYpjL6QUBLnVDheMzPE+z0AWDO37jkJd9t
         Mh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874340; x=1782479140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=by9u5EKjsb+5+gHbsiBm0Rf3TJxywMdtV+jmRIHAyvY=;
        b=bhPHci3n7gMhHFUw+DTWWTAlQ2xG6QVldcg40HR7DZFXFLvK2N+gPbaWVBMQNaIvni
         xlJ1Ky1Y5WP1sRbyqrLfzCtz4DetHs6/eP2uRYGriOVEysRNIXJt7IRzaBe2874Cnrkx
         GAzbeE/lspG5qisV4Lj0e1UfnKCRQhVzRpuki+HIhavppnRvu2qJYHzKQKBr2tBkWg6/
         eEu/M0Q9f71bA5ga0JpQQi2h8UddTEQwNhJRrfqT2Edc8vEyL9cTSIoIsiNUbe4uJLHd
         ggSo+zQo3/ZAePjQvIsog78QftQdHuXp81e0aRErt2e4pjJeut/d7OyGsYM5vTayYuxs
         DFsw==
X-Forwarded-Encrypted: i=1; AFNElJ/svKZgiCtiCljHcKL2W3Gb5Odm8nSCkE3Z8MCQgRoiq04ua0vACZ2SgN1grgMvr3HyNls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBr5xBNNhBtOo460c8yZYHhIXWHoyNuwEZfdy7wb9Eyi7pumkW
	FnYegSOHYQbqRx4v7exSeuRGkYAP27yEiKIpjsvG2CLhmSTxZRQyonxvJqeAH571LBk=
X-Gm-Gg: AfdE7clLOQFDpd5VlEgwauIW+grTwJ2Y59H6uL9Lbp6F4dNyyuhq54R0CN5S8DrraB7
	8immgrTJTP8W76CL4XdPe1kkdMmvvjTZ6I4ZnLVfBFAUDJzxgh9u5SwWmWc8c7YUTqEYAa3GKp3
	ln4Y5WBG09HW/J0bI/mTLRfBnyvXrWRr9bVrxDZ6ZkoAWjzMUkExt9S602WanjCYNhT/3krpFXa
	4HJfkPYXo0PF1e5Z8d4I4LhY6OR4KzwGdVG98qPzzgk1WZhpO5ssGiD7yzJc8IRRclijMBY075c
	gxoH7sOnv5JSxovMnlI0WhHe0tUQch/MIUrEWlJ2K19PHviClaeQj4uFRxkY9pbHEYnVSNHyTxt
	ZXNOJKS5t1F4pnZKFBPF7Ta0JXDRGUWF9+u73rmg6OGF6XuTrEwcUkm/OHMSQ/2TuEmtim21tfF
	jf3dyDXCbmvlvsOwC1ex9+Ado=
X-Received: by 2002:a05:600c:c088:b0:490:c2a2:e91f with SMTP id 5b1f17b1804b1-4923f59f2c7mr60670475e9.35.1781874339752;
        Fri, 19 Jun 2026 06:05:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49245711032sm23657165e9.0.2026.06.19.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 71C7B5F917;
	Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v8 2/7] tests/functional: update anacapa-bmc image
Date: Fri, 19 Jun 2026 14:05:31 +0100
Message-ID: <20260619130537.820184-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initial version had the wrong DTB which caused issues with image
corruption [1]. Update to the latest version.

[1] https://github.com/legoater/qemu-aspeed-boot/pull/7

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/arm/test_aspeed_anacapa.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 27f8bd8b56a..b16c6035c95 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -11,8 +11,8 @@
 class AnacapaMachine(FacebookAspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
-        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
+        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
 
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
-- 
2.47.3

