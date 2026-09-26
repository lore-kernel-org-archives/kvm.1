Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C81368941
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406232; cv=none; b=f+xn9z2Lp2Dzisk84yGIc3NqNU2/4TLYDFYwzBmYbsF23yw7ODBWJPZB41wKfb43UiWzVSxOh1+UtlEVLhHbQzJ8EaG0739l09f7fB0gdBV7uaU+N7gWAtVBaJEBgVUeWGuOloOMqgGvA6Jt673dF3RbeF04NeA0cJ6/Sob1S4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406232; c=relaxed/simple;
	bh=5ihDSteUMDVJNuB7TRjkXpzqUQcO9f9GPZf7NIeGX2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOwXd3pK7vdl1b116ZRWcuy0Gk9HA58C3u5qDEAQFTR5WItuAaVsKksocmjjcjwOnaXMi4Gt6fZ6U+K49uoI+defX5xqGnSNjxQ8j0v2aBSZrZuT8VKBG7fYEaKaUnpPocivDX+Wypeu4KKeVBTR60jy6RFAXTNJ02RdgQyaeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYpXgm7p; arc=none smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYpXgm7p"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so2110169eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406230; x=1791011030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UC1ipmtg+SLu0sRvPQ2okBuPTuigAuP3T2b8CJdvCdg=;
        b=iYpXgm7pcO9Za/UZcxfHmF3gG4lGJ3tbLdcE45gmJ7AikCrrqrK2OBMfir8TSyKEHJ
         f0pJ2chv/Pq0CaPyl6XKIsfk9n2onzGsNB+UNjssQ3LxbbLOGHoA0hheI6/+Lm7BgFYX
         UHEdezLiH4DciU/9l+4CpZkvpPcffcIEX0GP43YJNbkrqGOZxKnOyqpw2KMIbbD6I4CY
         DVQAShGZSJ+IqFRlQ60XFfOZ4ByJyrB/slcSF2VzINoN3H0vkrziIF2e3YMAWYWcqd/Z
         DOMhv4kj5L7YA8zyc/Fs2Y+Xtt/AOJfXEKjlGg0DUwEpO6cBRTKLygi/tMWo9CGp1nVE
         dciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406230; x=1791011030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UC1ipmtg+SLu0sRvPQ2okBuPTuigAuP3T2b8CJdvCdg=;
        b=EvYJskrfIbufC5QoAL6b9YiQqbIjeVqVzFrwQy1LtiWkL3UOoo/Zg59TcDZ12bZ0+V
         9LaOAhmf4thS0fIGkm961HE103AOgUF3w0RgJgpg4JvJ9WTHsjnstP2a2tbPgQBC3bKh
         H8JPqh+fqmKfrXvnFKGLLdIZEVstpftrmjWvHrumU3qqyGOIe/LRNcNMJRfj5hldCb/f
         GDiXOIoSzWXpV3FfwFppsT790yEB8VhXtOdPjKDOOwaw0sBeBvyS1nJzW7NIejlrG5jd
         TvMryVqdnm3ii2WFsFteDOsjmUfFKs3gYZRMXQxNDy4oTCHLMaTmSiU+d/givyiv4m/V
         cUWA==
X-Forwarded-Encrypted: i=1; AKwUvBx/3TNh6be7dDK3aen41KqSO0DO5wtqDq64ONJZNH19coRrJWH+5f4iLk02L1nwWDS0OQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kR+nvqI3wNNOmUeiI9hlQ5eYMB0lF4zqBgEFdj6221sp6jTLGt
	U77L2BYVSVuFMQh1Ostmhi1fE0bjV58007JGwL36C49j/4pmZvwxOrRE
X-Gm-Gg: AYBFou244Hhj+VnWMNQ1+feAY8ncmBO4MFXhjvlk8ZmxYmNeA6+XpprjfwobFUNGZN0
	zWf3DWWkriAcizedZRq418x+5F2U05IFr7/h5dCNcnTsf6Uv+rOtPz+I35H1xRiF/IIWQ3x1owy
	KT/8c+Rw4oi1AhrhCxSWwhmuPtzgKCC0R9FH5MEsfDOJ18V6l7NboW2g2C/Wz/PRqKvgcOZztUZ
	4LWQN+zEHIa8BXt01pM1IDh492YrEyvTRg18CStkcuZWaPdeOZIwGwGhgUiiYHIiydQccVJmVzE
	iBckx6E4FC2RTdIF6tMTn9Jg0NZ5mg+58V+swBqXTrO0xoH7H8kPa2mrWDKco2JCCL05rAGXuk6
	qxx52R8SUJ9oQM1yItawKR6KJ0+mvQp3VZ2h8xYHKovAFGMZOtF7+u7JbZGXsch/06ZYfuGT8sW
	3/l9QTzoHaRhkArXAh0EA0OBtt2uI3l/Oam9PvoQ6KxSBAQks01eHI31b1FT52gdLtABwWwBL1h
	r4RhnBo855wf2HNd+j2yQL4+3/8dN1ylLF6IQrysCM=
X-Received: by 2002:a05:7300:bf9a:b0:33c:357c:d33e with SMTP id 5a478bee46e88-34272466706mr2128947eec.28.1790406230275;
        Sat, 26 Sep 2026 00:03:50 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:49 -0700 (PDT)
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
Subject: [PATCH v4 42/55] module: load every arch-tagged module when target is none
Date: Sat, 26 Sep 2026 15:00:41 +0800
Message-ID: <20260926070057.1234-43-luoyonggang@gmail.com>
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

The none target allows every arch-tagged module, so modular
qemu-system help can list devices from all architectures.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 util/module.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 8f8e6994f11..2e08c7f03a2 100644
--- a/util/module.c
+++ b/util/module.c
@@ -137,7 +137,9 @@ static bool module_check_arch(const QemuModinfo *modinfo)
             /* no arch set -> ignore all */
             return false;
         }
-        if (strcmp(module_arch, modinfo->arch) != 0) {
+        /* "none" is SYS_EMU_TARGET_NONE: load every arch-tagged module. */
+        if (strcmp(module_arch, "none") != 0 &&
+            strcmp(module_arch, modinfo->arch) != 0) {
             /* mismatch */
             return false;
         }
-- 
2.52.0.windows.1

