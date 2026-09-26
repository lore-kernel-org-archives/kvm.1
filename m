Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38013A48F6
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406082; cv=none; b=W9hKMvhWNKONGcs+dWWPzavhpP6DNAUJtAANvc+wZsOewLTOO1cCLtBPxbJ+oIrOoM0caLCYxb3ndNz8xOA+Lo9goy684Zy30+LuQIm84zYzf3wxyJ/enb0DSFGfyDLvCbY0kkVsuQb6BBWqFPyGGHPTNxHPxGscZeTOAyYwcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406082; c=relaxed/simple;
	bh=iyNuhiQ28xWxVRH8cvr1IcOnQL03Lf5Muwod8UUuRFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHq0A+vu2XGHt9ja42SBbb0E9UXrkWWvucelzqFj8q2f8zwZOjpj3TxRhXN3birbpLApi1eG46+Byc5cIqvykVZj+LXVPBa7y9gh5dfIKwBn63qbT6aAbLNZxJqWjd/nKJTM11fQNgGUnbBFPd2/vnnoGu3RC6JHw1mfk6R9gXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRJKAdZH; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRJKAdZH"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso1976331eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406077; x=1791010877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjKPIsB7XPfjiOJv/P7w8oTcFul76ata5y5bWuKERHA=;
        b=oRJKAdZHHKmLSZyRBVDbuHdt64iEPmydQWhsZeStRp5t4TfGungS8qgUUOH6x9DFB/
         0pxKaeyV0fGl+aAVlme1T8Quf0Vn4ZxTHq3feXzQpIX7XIhzD8+88aKju7Hpi4lvndOz
         9dSxnFdgaC8IRMf0QU9xoizfTMnBp+6XL8cEspSg+BDRk9xWCybWVvc0uqDY+ODTsocs
         dSPcbot/FiBQrTmH18sTTVTYh+GOobQeRVN1qay4PeVfeC8SnVQvMuxoJpWr9JVCoEaE
         5Qo91qLQjLmke5OFA7JPlq6o4FP7cnuI0lwXmRATTJGA7LeS8cuHPJyyNkWjlhvbPA8a
         dueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406077; x=1791010877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjKPIsB7XPfjiOJv/P7w8oTcFul76ata5y5bWuKERHA=;
        b=qDQH2zb1gpSGrpoJXm6oIsRg24TBF0hqu1vmAsAAdBfrXW02HdMpePPKKIwKdfQpFZ
         D1WjEmYrX6EfidDAT5qkTBUNahbjuGoSLzF8XPWIUiUyWVjQIjtm8NznlmCnIhlLA3Xk
         0TbBdF0uTU2nm7xHUp0lz8wuJWRdg4rJEIUXkn4o2c62y9qfV/+yaOzwElEIHNo5k6iC
         JQtntiiwwFu4cy+3oLq/k9XKtejNk7EGWO4vkgt/9BRWhjjFUqeJwSwn+z0JgENPrYqZ
         vNG2KgbZ9lecudEAtm14Fhcowg38hYHgY5NbofOOEskRz03dD362emf2nlLYHL3/zBai
         jnkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxes6IzkzBdFTUFw3tP8eiqXj11xZtVSm0YawacIa00/IquvI8rkAGYFPujE7L+AlJEKHk=@vger.kernel.org
X-Gm-Message-State: AFuF++n3Sj8+AX67U+2S2A53aRlaygGkrqezh3ua2hMNLAN/HvBF9cxS
	kv4VRdPOtUfjcOVD8J/MeFR0Lokg7YU/zT8XOiEqbFghYG+pFkpAoqPE
X-Gm-Gg: AYBFou1OEvinJKHSa9/5Sw49F3SfW0GuhIkbcwXyPQk7up2Ay5UnLIJKkCj7csmuktk
	nHTsWxj3YoQgbhmOFoz6n6iid1Yg8bJ7SxPLoNS2+isHtEI5QXgOaEKEf6jYtj5WVGAbSqpzoLT
	siQYwt4YrocwbYZ0nBw/oY9Y8dsmXl486IFt167phLC/21aWs8ZBSEx/edUvvQxyUW1yEwPoF0G
	CyMyzdW6b/yVv+FHs9gqHPaWtZXMRpZIBxZLEmFFrwH65m8I2F3HFJBg+tE8FJqmy5F2QwcQZfB
	0/9tF7rUN/U2dcM09TOAnD/NpV63fuwY05GcDksVs6TbJaxDJQ5CijeVXuXOh0ovuG53uLqi21S
	1/EaisXlh0e48EYzv5PpraGp22N5DD7v4NlaD4Tkg01lEK+vjf0VVslQtvzEJniP109OjIiAJvJ
	q9GWjsoU3hEvA2qXMnOsE/GTiSJ9/npO0yLGv3HgKoaysopoGReZIZdnarWSMWxQQpLqYfDfE3j
	wF42u+poH30wDfddo3b1DMs8P1jyf4=
X-Received: by 2002:a05:7301:712:b0:32d:205e:31b1 with SMTP id 5a478bee46e88-342705b8903mr2066052eec.3.1790406077527;
        Sat, 26 Sep 2026 00:01:17 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:16 -0700 (PDT)
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
Subject: [PATCH v4 03/55] target-info: rename target-info-stub.c in target-info-def.c
Date: Sat, 26 Sep 2026 15:00:02 +0800
Message-ID: <20260926070057.1234-4-luoyonggang@gmail.com>
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename target-info-stub.c => target-info-def.c (100%)

diff --git a/meson.build b/meson.build
index 732f0a885ba..51bc0905294 100644
--- a/meson.build
+++ b/meson.build
@@ -4330,7 +4330,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 100%
rename from target-info-stub.c
rename to target-info-def.c
-- 
2.52.0.windows.1

