Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ADC34DB41
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406217; cv=none; b=K++cst2gnfYhIEkfh17+pXTG/CqeI/BZN0N1hXtIXANEh4YZ8kwi8qjwJMh7fF2KgTijri7aXNdfiwrFAnnKdiXx87tNbn4uJPQq6Ol5Qo+65HtLb99SwlqGQlVv1iDAgkgAifoiR1GuFha30x3kbgc0u/up3ivbvWUdwSaExeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406217; c=relaxed/simple;
	bh=BTgrpQDjxpYRq3G3R9OznRnDPAmx70zgky90y+6TASA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUarbn/UXewkXTkLnVrkD01GPSwObTW46QPtIRKuyapkN4/yDkwmoKe+gf4Jr7f7HNh5YCpVAwmKO1kYVRoAqqNnsMXF8HoBHlK7+l6y+RiW4p5V+buT0xIxsnaCeAT1jOwQ/PHKvr6Jx3eoGOeJYmSOo2miL/1QlwWexeYi7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6R4QGJI; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6R4QGJI"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace19so778791eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406215; x=1791011015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/KvXUSAQ15EFG7szh+0eupDvXY39FOdCzcgiBxzTtMs=;
        b=r6R4QGJIv5eOaizc9uBGQdTg/wbxU+8bimn60lZtYlq68p13vS8In/vl33p1DjYozB
         cwpei4KDdCX2QOfXOQXEblNdWJ7PtS8mWIZeyCb/tDeQyDg4ukq8N5sGPB7NwNfgrwzz
         9b3S6oyGiul3XT+ZBNkQt8keYmiOqYMdD2QnGewzrviomh1olAWRgJrBKQPn9SLbNECy
         YkZINH9HjnG9ru8ufEF9HPCe6R6WxtZ1Z+eyLS9GBXFW8EobpQREX/nl1CDs8ORPXZ+Q
         WtFOLZuoGzI37UY/YjhpBqkOds3y3z1jsqwsFJVHrw8NxNB5W5ja496ea63fv2T2gd0x
         vqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406215; x=1791011015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/KvXUSAQ15EFG7szh+0eupDvXY39FOdCzcgiBxzTtMs=;
        b=CiI6WT2cmE70SnAxSetXQweCixkrVUpbM6z+kWokasEJtn7g+lQKmfAMKaqICL+39K
         g/S3g7Ny9UkEIVlGUWBTOdc39M5/WwlzXS6HM8vR6e5kObM2bPWisdaw/9sTkFSVOBQW
         QvXabBPVBqR/FHuIfyeawhgGdAsNrbS/OZUrIgr/v/MQIzl52GZpfBtGcXZumatSPVZa
         2HJgtjJHIqixBZSuNDU/ohEa+RON5iJ+xfvAkfiE5Y0NK+O4P1mqOyPAfc8+h3JGVtPU
         cXuqzKuvEBtRfZBzyGJs6Ew96erGF/qCinv9a6Tu2upxu7j8M6rOZ0rU4GtE7vHSX0zO
         aO9w==
X-Forwarded-Encrypted: i=1; AKwUvBzLq79o3V2StiYzwpiCytn6tpoLhuUFz25ouStNhxUIBTiPGPuTSU1Acl1j8XZ0Re/AxIY=@vger.kernel.org
X-Gm-Message-State: AFuF++n5pc7kloYkRKtz4KAnI5wlqAzxeUVUxhm148Q1XujxMex94Dks
	k6fFKMzYIqfjB+coH7hlzq24EU519aBTSX96dJtAhZeRXUCloJJAeB5u
X-Gm-Gg: AYBFou1ZpLvxIcp9i9eQ47qRE3StVdue29i/TGv58Lg0jOgdn9PFf0pQKUbcN15W4ya
	Xj+oWPFCWEALSVvvIcGSbsAxIOw9e8eCwgXEtiyEvYVAfK5zy3qoYrE71DVXCiDQVnc1QXW3ptm
	kfG5xKQm3bDM5WH6kd2QpiIlVgAcXhNohxupLgao0gENiZkMfHtjwABx9scqnPHrBLQZ3221eXC
	TrFtwgOYhpZq9xmAv51/O4mND8FXgsd6eytNcxREFmB9cQX1xK6Q3VaRPGyls/n+KjRz9frjJ/y
	mOQ8lUX/e9rrW1+yHMZmrzgrZzlOc9nMWwI/Ysb76zBAxMWcIPKJN7AMdYFxmxQAiD4e874sQ7G
	CL7jWD/w8bwAT1v9sb25I0lU1rGo2tVbwaTQvgd5aYvV+QNFdZP1SlAmwpiGNw4M5TTUvmv/oU3
	aJGr5qEW0IGe+6y/wFP0+qOoZt4TCdROOjHOYp9VaOqcr9l7x+15w/9Nu6eRd4FHoiItK/DNZ8d
	ktYHp6kYgQzzNSKqBETyvUeFCFeOHA=
X-Received: by 2002:a05:7300:f588:b0:333:f4ee:da89 with SMTP id 5a478bee46e88-34273347be9mr2169044eec.35.1790406215338;
        Sat, 26 Sep 2026 00:03:35 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:34 -0700 (PDT)
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
Subject: [PATCH v4 38/55] target/arm: fold arm_ss into common source sets
Date: Sat, 26 Sep 2026 15:00:37 +0800
Message-ID: <20260926070057.1234-39-luoyonggang@gmail.com>
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

Add arm_ss to arm_common_user_system_ss and arm_system_ss to
arm_common_system_ss. Drop target_arch and target_system_arch
so ARM CPU objects are not built per target.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 0369f96b4cc..11815a0908d 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -68,11 +68,11 @@ if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
 endif
 
+arm_common_user_system_ss.add_all(arm_ss)
 arm_user_ss.add_all(arm_common_user_system_ss)
 arm_common_system_ss.add_all(arm_common_user_system_ss)
+arm_common_system_ss.add_all(arm_system_ss)
 
-target_arch += {'arm': arm_ss}
-target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
 target_common_arch += {'arm': arm_common_ss}
 target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.52.0.windows.1

