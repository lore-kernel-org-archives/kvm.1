Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88963C3430
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149524; cv=none; b=r8tpo1EBLL3iiNpouU0wXi4OemLAWyBhPfsr862xuVsRdbLH9O2+lSCfaQXrQO5mFKqt49++9I2uO7+8RmiMrvI5FY0KnriBZJdhq5m2I748vIYKhdk7n2dOTJ57+xjUneLuDie2pHZUiZzYUzbW5SyUO5cd/KZO1XYNwtN7xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149524; c=relaxed/simple;
	bh=9lonrmz2Oj+AlTTr2Ep1+PMhz7iB0jqbo4tLGpzXkfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMMdBiXLnSL5Is7yenwkrwDPrXSjN4dYBf6ETNHdnOai/RuiFjhsLGXYa6Hm+VBiUqOP7/B4RN28XlB8REXrI40OmppgjoMdffqVWt0mnxUNceS3fKNeV4xQDz+Plwyxd6zTq9gsvAHcG1e+2HH0ZsVNoEys1jH277iQrNM7j6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXbJZT1X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXbJZT1X"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso11346675e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149514; x=1775754314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zFCy2/f6gXgpLVosgl6P0mdggO0d7nONWw8yr+5Eo4=;
        b=OXbJZT1X3lBXMXcj3MocLaodBmC6EfgypK6bSJjnezTvJwgSi3+XppJUzNurPdhd3t
         TNSz3za1fsg8pSoXi2hZVqHlZS/4BBeBYfL4fzYPdWnoVeHJYljucH7S/6FHBJY21KQc
         gvkeK1eaE4OSBspGYjXWixnT030uDRPPu/gzppSAtMlG1ZXw2JPYsy+3xNQdPor84kPZ
         gnBdPVmfAS63mMt4HTMH0y/DwFGhgkGE9DGgF+I+0ORyh4tr7/yVFbaFDk5uuE5wPA4n
         wbzPQ8ta9bLtzPk2+swYuQWo45g/ql546qyrW5Brr3n/fYm/uIYWZKQ62rznYBo5trCe
         OlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149514; x=1775754314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zFCy2/f6gXgpLVosgl6P0mdggO0d7nONWw8yr+5Eo4=;
        b=V1N3LGeVG7PJg39X2ZqgTkkLtxwP41Ahl7dxp23K9gSClWp99Oy5mgK+pOVe8xiJyN
         HJALwDLQvsWPShtuPh5BH3zeEe6m1xCeWe2pmPzTxFDjNHeNoYUFzc2WMqvfoIfBYGbx
         AceVJeD925+rAQ+grYx/PPrYREDMChxe/slzYUZ+UP0+82cG63Kyi6ala4/kxI5qLZlc
         +rFF7vkERJ5Fe8mN4dvlEooIrZnJwyRtdzmCxuWnAsDcMl8dCVv3pKPLPumVkad72tgj
         N4DaG/fFiKWraZvgHPMWbS+Loz8/XP0oMK8LZO/yW02QObCtoqA2q3W6hPFuy6LUX06X
         /8hg==
X-Gm-Message-State: AOJu0YwFvri5UC2RZM5PzZU+JEzcTA8Z2wmmPu0MQbL0e1Lzp/58swsH
	lDedKh9b4KCEud7QSw+EaQZYgX/wQ21brcIWwYJNj2bvVDf+e6nrH8ZoXMTspfbIChw=
X-Gm-Gg: ATEYQzzmZ1+JcwwmndbSy83l1P5kCvhOu10kGUPnHMHaiAUtxb55K+B3KgkwzzZrWMc
	UfUf7nlan3o26WU73YDZBWdzJc95lDyxqGwx1QvP0C8gJGyiDj+Ll/GXO4nJyE5oIndkEijsnE8
	YH523jz24Ate+OgaX89YCTpAEQhjEVKjWjOonXxFzpvcoh9sPs5+GfOWaMNdKhS7uqhQEIt6hLB
	RVyZlhcwxDxo0Q2A9jPMZ31Jg/xX3nTCsk7dXT2BJvmKG8WW6Wvnd4C3nNhlVR2/DiclI3jOCkO
	QkFNbmvaHVFu2eIymhC472rcCq6P/bR/0qbWwyFQNfx06B5JzC0MU9q98MHHB/aiu27SdhmVUcB
	yHoe5Jcr+wFYjOjAS9gyQYJg9CXhRSc+fBhm8Hx+XxkT+cDognkqGLk6WD0ulcEqy9IR7+vNPmd
	OxyfiH98KG8WMbtlDaoNCL/c9VBRHID5hDSSYUJVywiOoJXIBIH9bCT1nOP/1GPB8NUNoPedN5
X-Received: by 2002:a05:600c:a4c:b0:487:1c2:6a56 with SMTP id 5b1f17b1804b1-4888356844bmr156661445e9.3.1775149514437;
        Thu, 02 Apr 2026 10:05:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fd5680sm666205e9.1.2026.04.02.10.05.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:05:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	Anton Johansson <anjo@rev.ng>,
	qemu-s390x@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH-for-11.1 v2 5/9] target/arm: Compile WHPX as common object
Date: Thu,  2 Apr 2026 19:04:30 +0200
Message-ID: <20260402170434.94783-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

whpx-all.c doesn't use target-specific code, move it from
arm_system_ss[] to arm_common_system_ss[] to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/whpx/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
index 3df632c9d30..db31e928012 100644
--- a/target/arm/whpx/meson.build
+++ b/target/arm/whpx/meson.build
@@ -1,5 +1,5 @@
-arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+arm_common_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
+), if_false: files(
+  'whpx-stub.c'
 ))
-
-arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
-- 
2.53.0

