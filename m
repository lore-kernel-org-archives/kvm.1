Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD055733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406220; cv=none; b=HUK2oZYY7RUN/wgEhIP9QTnkG5yJ4VfF3HvraUVlDRWASG+gHsaXwrxFBf+faP82bnEcd2nsQuDXlWNs9V7E+LUtynmdlHp32x3wyC8gK0UtSO5LexchFQgJMaW65dS8pAHIgrQLXNVaecNEwp2JcqgX/CsBPwuIrsppnge0kF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406220; c=relaxed/simple;
	bh=bXKFtx302gHa7P7DQb/qVd7y7US/9psgrLsPdbxtul4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ2rY0cdBZwdliTqeQhQabx58z+tjbniW4UZBd2rdhxFzPUoFQWqb5+Am0zn1xiXgO4G5tDAKafXjLI3U2h5p7uL9jKxyFAEiefhhhOL+RoP2qsnyq7vBm7C/7/LFNeVXaKVrvK3qiYsOdVeDiqAGy6Kbhq7YRFEKkE5PnXCAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgIqbifu; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgIqbifu"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so2109986eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406219; x=1791011019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wEmknfoBmg3TeWeQqrxAB6fpgRVpCKeiHIEFEVt1/A=;
        b=RgIqbifu1VC4B0JP7W18VP4ijaiPoiEMk0m532WHcQdp1Jqp3BEIX+L3Sm4NTctNNo
         Zq3S4xPesd42uo5+CbEgn1Mx2bsUb6ZiJSgxn84GvGP7bNsfHo/KV1WPWlGm5dhQIpjg
         YVfKdvTYfKE00AG0awH3TUrprEhkMIaMWo1cdqBQ7jZR9Xi0ngjw8MIYv0NIvBKh7yNP
         4VQGEhtWWHuh6VHadAhPe0Xx8j7Tzf0Y8qjYyt8NfHTTSXXLFaSZJn9Ef1lqVFyQlVyW
         VFRwFB+vcjSRAUVW/7hZtpOqLNGMFOtMpdSMVsat2OIvjpfbsyW0hh5PUgju8SO6BWYm
         r+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406219; x=1791011019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wEmknfoBmg3TeWeQqrxAB6fpgRVpCKeiHIEFEVt1/A=;
        b=WW9PwTJaUhTXJN+vxZaXqIht3UzbPUDuB3XucKudTYIfbtH8JH6ZlbFGE8fp/p+nyp
         eE+b4wm7of9DoEZaDu5bQC0eGYQvgYH0FytOycCqcp0KJTi0QG9cEVkkE/WoIXnhpxRW
         0BnLWOiuQHAhE1HrilbTvroon0RG1bvfksDMbed4feIzq75qO/oeH8bhe59/atkxaUds
         jC+rscGvFaOczFbZgeT6NvMbGHJWoX9moyhM9iAIwgxoXimr2XGFAWPMDqrA0QPoXpgL
         F/lT4UeZOtykmkyeotHBdFKgnwDAO7TQ1Hv5U1l9JjBUMP9AFQMhbvZEtqxYo6yXl9yg
         7nQA==
X-Forwarded-Encrypted: i=1; AKwUvByIEbilmzQb4/86pJxwEpdNKQeVW2Ab7e1NXKBdQzWStvRaeGinKWgNOPACvya3+utv2Sg=@vger.kernel.org
X-Gm-Message-State: AFuF++lM8JHlYQf5+vBNHMokzvIq9r9R2qioUbYgc1gows2cymWHZJVu
	Z5XuZMAdZRrvOkAapOpApiGAhfJUFU+c4rC9fa7NFlw3VW2pKDoYCrxp
X-Gm-Gg: AYBFou1chQXd+9zJmnVi/CzK/Choki90jJyvG2+WY0cr43vJpAdACFaAEpxhu+yEM1c
	fU38B4dVlLaqFmpdJ1taGXPbTbJgwoDykDhexnAPE6AltSiOheVd6LZVrDhx1nvvgj3bzkh4lpY
	as88BFhKCZ/M6Hd9ndndp8ByP2qMLdFeblRfWiYZ/vhlA0xFoijdrUgwbXE4l56DRvGaDsUSbYu
	rSNWBwER+KdkmAooNvzjX6AQRgSOlYfClgc4WrDOEes99yFTFkrGFLQajDs8f2+vdb8q4ew3mJL
	pUFrqyam5VnElapLkh04DXGjV9Vk9crcRANMeCBEoQyyvqjvOFFt+xZMomNjArSVC3P722J2TEY
	ZVgsXVMV0y7V1l2EEPvfunKjSZZky+4waQjFWVxM9oH7r7asouFb0VHIQKoRMwFn2mYvfXeBdyz
	3qWCrP8xJd93ji9HPK7NKqSgCefql1tG+tTakeJw7Hnbqfqrwy0x+Ygh5muAdUq0CVytFZdgErL
	xBIADjFJ6ACGb28xKp96jCn+Zp72Xs=
X-Received: by 2002:a05:7301:4201:b0:33b:ea8c:811b with SMTP id 5a478bee46e88-3426fbbeb5dmr2159328eec.5.1790406218912;
        Sat, 26 Sep 2026 00:03:38 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:38 -0700 (PDT)
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
Subject: [PATCH v4 39/55] target/microblaze: fold system sources into common source sets
Date: Sat, 26 Sep 2026 15:00:38 +0800
Message-ID: <20260926070057.1234-40-luoyonggang@gmail.com>
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

Add microblaze_system_ss to microblaze_common_system_ss and drop
target_system_arch so mmu.c and machine.c are not built per target.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 9c1ecd1cf1c..93138637bf2 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -21,7 +21,7 @@ microblaze_system_ss.add(files(
   'mmu.c',
   'machine.c',
 ))
+microblaze_common_system_ss.add_all(microblaze_system_ss)
 
 target_user_arch += {'microblaze': microblaze_user_ss}
-target_system_arch += {'microblaze': microblaze_system_ss}
 target_common_system_arch += {'microblaze': microblaze_common_system_ss}
-- 
2.52.0.windows.1

