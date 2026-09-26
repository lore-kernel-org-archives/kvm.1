Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95483403E3
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406146; cv=none; b=RRTIPTFwNcYXq4FY0th7VaqDlAF4jfF2/qXvFdE3IsPTbPv1G37WAocj6022bIQ8LMgVt2cGTAvG0aFbe/VSGkZyuZOmstmuJUBYC5whnA2QhpwZSulA3x6V7RPgI/FBq3OM+MB1AS1mgoK+jSPWpw4YjEKnhAlRKAqHoFlpoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406146; c=relaxed/simple;
	bh=peqUd6TPX+c9R28JUIBZP9wL2AhktP8yvEohe7SxWHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4lU7iU/q3is37S4cAb2efujMDdv5toI/T31fNvWf+p0+pK3uYC2VjYGc+zxqun0vujf+4dt+D8Ltt3CtgClwu2U1Lc8M94IMxz3St9MgaL7tfJvvxYnnJxsCTW+QYvJSyXlUoVsQ51oTVLg94K48g8wYtBlCLWSppvDyKDfitw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hamTWDrH; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hamTWDrH"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so2109014eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406144; x=1791010944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnOA8ZdlJhQBU9fK/Dc46VHKpyYEAW7BmSzf+fIYK8U=;
        b=hamTWDrHjUlQaiMRAuJjO/KI3JVLguNcvCapsRR35KxHe6KMTr+5qaWCI8o+d8Cqes
         TRUpoZ2giodj4lbtTQsau05XrHRf5Ku0A9oif9w8jknx/NntPBTCatlPCn2pYIBhlYDb
         dxfMOtfFHpyWEW7KxFbIH3e+89evYr5LhpBDhPVMHyjhqiKkmmywn4oPdBsSLYx+pjux
         2zvUMnXYRlLNOWO9jEX1PqW11fHVembSKZ+eXXqfJNa1DdFuO/G+oLnJ8g9WJSAD2PNW
         4yKcByy4eky85Sf1pQn8V1IXFraGbZ0FBp3QInYCSs3CopiEVP+ocFF2g33+ism0krIA
         caTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406144; x=1791010944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnOA8ZdlJhQBU9fK/Dc46VHKpyYEAW7BmSzf+fIYK8U=;
        b=HOjf996dnCkgQNa3LvN5KAAVDy1YWEGrHtfzqcZKbTtFtE8HIXdmylUrikLI2pZed9
         4uOAOJbnYYz6Rpgg2GailJqiedcOrS/GJctugrsf7Df1khFCYiV6R/ZpIcx4QhLz4qBS
         ZNncuYBfYbusNwmUyDETICC/waJCNB+U972G2QITkMPw/iE+wu6kfliLNUtu3cqhCgdx
         qr8DVeJuSLYoQSopZugmEhN3BGsjdbtX2oUq2MeA2XCE7QSilxTyStd0yZuxOwMZyIiQ
         4hnwdjGEJDbAtmH+S5Z4kCCtJTL3Y2AFlrk6hjtJfPaixNvw7WD81tGvehqWg8EKnORD
         /Z5A==
X-Forwarded-Encrypted: i=1; AKwUvBzfYeGtWN5luqmQiBpsywKrNwj50t9am9vqox145Ip12jxYVBSd0VlpfmlDNeMxbMsPiCM=@vger.kernel.org
X-Gm-Message-State: AFuF++majonO9LmXTlQ3nM4FSzhYjKpn5DVmbUF9C6EFdHVqI/7bZuMm
	Bxpu4QAILw6zVk0mQFnAUEMSUjoZHlIjLxN5yR27y15NkFvZqfhmJOeM
X-Gm-Gg: AYBFou3UgJRPcRYz6VkZwhQobjojiU1foiXXxAesboFt9G+ZybolOBR2UwE7SHUdJaG
	q2cwQ9bi9MfXHo6gLJiA0kG84gS7pasNTWUEOAe82G0vE7Qp0pwa4uLIzqGk8S8z2gvjJFO0mMF
	/ZJ7Fc1vjnpdSeomB72F33FGLMBxyvSNvTMwlahO53lJaxgjOkTQ0KTC+C4Ie/oslwoXQhP9FZt
	XAuAckJ8hehkhgYU5b61Ldfg4fRFLbDrTENN7RVVfaa+IEnoZ86JpCHQDRMOuYy64J1aBxYxgGs
	INdpoQkyKuTOL3bFQ1QaipSsl5suIMgjeE+LfFs/HZ8dlAy6UWKjhJ5+HfgpFgqLxVbaGFnN33G
	LSOKF5VcIMXHHdakqQtpmCEm+NHL5HLZYn0HagGTEBbcISK6OKx929tdMldTGKMmx+7EWlQS9rt
	flLZAxfe7c77kcxcdBn2R64VcXVlIP+isRhQhDPbG32kuwgTTWdBhkd6cCqoqjnlTx2/cgIP3+A
	ywcKkugCTbFronFhmYVGBJAIQKaIQn3mb/4C17ILw==
X-Received: by 2002:a05:7300:bf9a:b0:33c:357c:d33e with SMTP id 5a478bee46e88-34272466706mr2124882eec.28.1790406139317;
        Sat, 26 Sep 2026 00:02:19 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:02:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 19/55] tests/qtest: raise aspeed_smc-test timeout to 12 minutes
Date: Sat, 26 Sep 2026 15:00:18 +0800
Message-ID: <20260926070057.1234-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two AST2400 block-protect cases walk a 32MB flash 16 times each.
On this host that is about 220 seconds per case, so the whole test
passes 6 minutes and meson sends SIGTERM at the old 360 second limit.

Raise the slow_qtests entry to 720 seconds.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8c53bb2e30e..aef99d2bf52 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'ahci-test': 150,
-  'aspeed_smc-test': 360,
+  'aspeed_smc-test': 720,
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
-- 
2.52.0.windows.1

