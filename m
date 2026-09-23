Received: from mail-dy2-f22.google.com (mail-dy2-f22.google.com [74.125.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3924352FE4B
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169699; cv=none; b=p1eQ1AF7d98xgzmAY7uzt1xIqkL77RA4AjK5G9vILBiZL61y/k5LFYLGYciCV4/szgekCLNHVoz91k2p2vZ06ESdd+v578RQekHTo+swkXt3TJ/3NgkYaN9kzWVwtFOXFSgD44yyjD2ySZRewCEYEjXV8AkfGx0lQfHsPPjnD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169699; c=relaxed/simple;
	bh=xoZTbIsxQiqsgK8OvtICCCUeXsVGSaciTovA5JICEbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spvIqepqu7cZpkw3XCmvTMabbQvUk4bxC1kp30rGKlq5edvoWOzSQYng2vEVzCqwiCn6FzEcLX/61PZ/kGmLfIuu9lfMcFUbYkzuhrYMz/Yv+xf0w6LwwBmZBQyUivGTbk0ph/UY7kvUQ6KG3cEj4jCLH+2G7gP8LZzcvfo/j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzf8hDGp; arc=none smtp.client-ip=74.125.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzf8hDGp"
Received: by mail-dy2-f22.google.com with SMTP id 5a478bee46e88-33bf5a1c4d9so901851eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169682; x=1790774482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xe2eD+AiZP/2qt9dfiB6B/fVlOtPvZaEy5H5CusisPI=;
        b=Bzf8hDGpPaf6Kjs3mIf47RZ0Q7NMOjRFb2xIyE8PjLWZFTnMCVuya9UGy//Y5ihn69
         vQZU4U4q5k1GVgylpekSfkjxKXWgAppTVl/uCHSn8YWgbybYkJ3rKUecE2N9uW2yVfmR
         PnfQ+6G8cAbtZpNyRypop4HpUc4/R5iG/4IHi+itRWXIIQIQTY/vSejHicNL2tfXzUBz
         wqqOsBGQpL6wWC1n5UTpM2UfkDGeo/dwYYUEaeqIINZVUWrIyN5a/4QYnwxvkS0+C1wf
         q0nXYaJj+7nnP4on0XdItz7SyOYLkprYG0omCcLV0ipL+H77juDXKl06PhHoxItFs0ts
         GYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169682; x=1790774482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xe2eD+AiZP/2qt9dfiB6B/fVlOtPvZaEy5H5CusisPI=;
        b=LFhlYzdIuvo4l0L8lbr0r0OOBL4+NbbFoFdebX7/7kttMUDAVZv5OAn5lMkBZ2DXdo
         44mX3YwkSynWzPq6hWPwzZT8rpikMLEMgyRwWovnBI2vwhXJMK4XvDGYdfqqPih/XQ7M
         ugKtK+kNj7pjfR/6dnrsyyP6XBh5W4JLIVLfv8pdBihT8lLKbqQT/VkQuVHNh1JxsrrX
         OvJSKCqoiX5kZIBG/HtB23so/8K6Q4WUkT1uq/XxFSnUS+qfhY0F5/781xqhJQImqfHZ
         QQo4OoOPUKOIe1T2pkqBtnB6GVmEiq0YZsHUKeWQc1tZdxHum80YlYCx5HbWhppAxfbp
         JcKQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/xMoEqXiI8UAxnu7tyAwHOlmt/YLrCrACYyez/AuwJ0dwM5r+XJ0ifBvvhml3FRwsa3s=@vger.kernel.org
X-Gm-Message-State: AFuF++nG6qVoU0f10OnelfqivOMicFYYkcOXcjJeEcZMwDhYrFtDxkhS
	Qv3ro2UiZkeOGch6rr1ZQvcjU9pYgMrN77A6qA9SaiCvKtYVMVqC9eFS
X-Gm-Gg: AYBFou1joEx+Z/Qg61YxmPo5YQNEhHfwgAIe9DI8fh7rCUmOstEIchlZXYiqQLqp5/4
	5ooWXMu8eiDeS+nWUSQCTkMoMgGjvccN2kJdlUbMJYLuCggkArRL5FHacWdUVtablg9Y3pMqRVE
	yS0IJ2Z98IdMoaH7WnE9gJBtmuiUBXpOOa1z88NpQBxpuJ/2Y7K4YeliRALFVLmADHOMNZs7SL6
	vfyRbsZ4/qi499px/4djz5ai+VGH5/RYxHaeG0GEEQaDxHOq2DiH47ZyQKsRCvcJwbgpH1n/20s
	UJy5NYvoTPXZlS5yQ/Rc/Y+VnI5feHy+Q+PzQ3EtAes1iUTg3ySiK/DEKUSGPAA5TBrxVR4PHRu
	iITt+rPIScRmCHh5jY+FZ6tR7xd/qRs281slngEqRxzqfDtYdNUpjjnBWcN4xw/woxLG+jilvmU
	mA3foOFNf+3NaXcmtD+zZm0Rd3J0l1DNCE2xYYbZedOerFwn0Bcw38D428XFBu/o+LhMmzzQb2B
	9ccz8Gbf8eLsigKZIR7WvlHJwr3Kw4rXtky9XiseQ==
X-Received: by 2002:a05:7300:8242:b0:339:7909:9782 with SMTP id 5a478bee46e88-33e8d9ce7f9mr2561360eec.21.1790169681656;
        Wed, 23 Sep 2026 06:21:21 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 026/114] hw/intc: use target_long_bits in IMSIC geilen
Date: Wed, 23 Sep 2026 21:15:00 +0800
Message-ID: <20260923131635.1894-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Compare geilen to target_long_bits() instead of TARGET_LONG_BITS so
  the check works when TARGET_* is poisoned.
---
 hw/intc/riscv_imsic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index bf0434e96fd..30fb60cc312 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -52,7 +52,7 @@ static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
         return;
     }
 
-    if (geilen > (TARGET_LONG_BITS - 1)) {
+    if (geilen > (target_long_bits() - 1)) {
         return;
     }
 
-- 
2.52.0.windows.1

