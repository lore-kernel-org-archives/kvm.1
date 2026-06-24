Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B1279334
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297055; cv=none; b=s7dhDZ4jp4/8bJioB7L3GzFcbUdVm11qKZ13Rd9hXs8yAsxtQuTlCA9KEIbb1c8OP23LXDr5RFT0V8v6JarOMyiECtT2YFL+LIZU56Wi2cPKLFeld7Z95YDXge+Lqs0Yjnlu9Lm2OumgDmLhIy4W5OZrKVV9M8WLbnsXgX1NmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297055; c=relaxed/simple;
	bh=/NEa7w1FO/8xvWSy/oeXYT+FZXax//vnpkEfJSTqO5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIIZLGnZXx6BDRfbbzcIXGtUI84K7Gf/8o1IhHwFe1RS4yn9tKd+RKWrBQ2csYQp3EqDOOsaM57L0CA2K3XCoA3H7JRuE2L1ol25Y8pcHi/qfwYtiP6dUqgoQBrS2HCUgyfsT5zJn8zajJ/fiN3uueLSNAS0/5ZU/ybjjzK4Ak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xm97QdDE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xm97QdDE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eeea039ebso525859f8f.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297052; x=1782901852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcUw6dVic7iy+SWHCEsbAuTBlDckpX0jLlbUXwwqlgE=;
        b=Xm97QdDErvfQA7tOORHXWyWqn9NyjNSQeYwD8Braj8oZV9iDEt2VcitJtORuxj3Ph9
         44nt7zb9MSKH5ictyntmmD/OZ94Ybt7yLPgjwAedCXfbK44WP75oVwWVJ9qDzZoAT2Dx
         G0J2IKSSoBX4Pgn/SHc4UiyisqLwUsNg9hQixEULNTHeMZNtUDM28i/mjPIkVUSghADu
         0/3ufNBQsDrCjDR1BdG8flL5kz85GxpuG1y/TXjQf+5K5z3zzhc9kERcipBnFGdw1nhG
         EKFMGxx1EhQhzT1vghEUpt4atHIkgOVHrF1NHLc3ptyCzhv3oURj9UcFQXyJxP47e+Dm
         h4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297052; x=1782901852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcUw6dVic7iy+SWHCEsbAuTBlDckpX0jLlbUXwwqlgE=;
        b=s8Tpy4zaCz0CYDrTNzGH/mBprKpXuq+e4ju06zllz0QEEkhRIbwiKcfA/RwlfdKGmO
         PvZt36+KDWy+VG5aVEgPdupQOsWt/JXNfTLjK5T0dclp/10+s4edzAYJZtGHRFAS+9NH
         QwonNcIEc+iVaGuLjw1/3/BU8qk9HPiz6PPiKtIlKhVPj3d4KqPQwcrph3xtDMvuqkBD
         KEoy0NG2WfaEJ6jtbBcUpixiUiM8oyLuvseG0MDe+bt8PKs1BsYm+rcOd9uLLFov0k0q
         l3qEiOu3FkzTSkJV9+CE1SWEaAjdW2ZTj6/8f3nP76v5G53hxuD7f0kCFZZrjFbSMmET
         bg7Q==
X-Gm-Message-State: AOJu0YwxOSM4/DDnVZk/ZUsOmIQVlzdRxfMNG45R/S+C+wjRzA+7sEvO
	/u9H68mAvacNiUEUZme3lQb2WRgB/u7PPmjoIatOZjiNiJEBapm8WdHp80/Irlm64mo=
X-Gm-Gg: AfdE7cmzwEtHDmV7YSWDGi7qV4EOp8OgnKUi4n1QoSqSDiEos7L/Eo6Dnx26IYb4WRp
	Jh7eBm+0TN44p5MY2f8+SNqwquv3rbzgZ3bn/Kc0foLr8W9+SBguWsGGnmz3Zz8iGbektqydvMJ
	hmgQsbQYOHy86+xkwKh6N0pGwQYD6Fy87M04Pt+MqOYvTzqXstpuiECzo8yd481A9dfwS7u4Rz7
	ZF9C06Hqb5Uy5U6YWqQafnh9gYV2gZUsx1DCIeC1Rg+LSwE13bRwfedxjStgimwWxzd5FuIYbeN
	WIAw6VMihbDcac1IrMjwXGja9NPECwXEdjO66PlznPW3MozgnO8cFdPcIMZXooD0fi9YIYk2NE8
	lE2Wh2dSxTtbsEkqlL13aDLWNzdBaUZF/efemH8NWFatLiUjoRv1SBXSB/61joOCYL/3aN7OXvB
	qSJ2oVow1fMqCj
X-Received: by 2002:a05:6000:1789:b0:46c:dc80:7627 with SMTP id ffacd0b85a97d-46cdc8077admr574890f8f.26.1782297052187;
        Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm5827376f8f.9.2026.06.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id DE8655F8E5;
	Wed, 24 Jun 2026 11:30:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v9 2/7] tests/functional: update anacapa-bmc image
Date: Wed, 24 Jun 2026 11:30:44 +0100
Message-ID: <20260624103049.884930-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
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

