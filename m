Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19945304CF
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169700; cv=none; b=aQ7H1S+nPqffIMJRoMux70xEqo9zTy6M3xTvNlNrWpL3nXq7ybqXAPhnCrIjuUDTLIh8eM1uI/ydGrkrqUleoogl9i7Sn/iIbc+zfYxk0oXOWl1xoYD7Img+f1UKv88sXLIO/eHNACvuGY7Q5bAx4rI70vETN5qS07hu8saWNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169700; c=relaxed/simple;
	bh=LWRwbrXMKQ4eb4oZms6UZHR4kVgKcj+pWE9HoBBFydc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKSYetKH097S1GoS5KhQ62MPcmLLO1/5UtzFGpbWwN3F9aKYE1BIaQOefOrVP2aTAbKNx0HuNepAkVq733Xr633vv5N1Zki3LekfIy3NCAPzmzHCFlmjkTehKLcCOvutAsIQ3je1kjDhz+NZlxy7+G3awFeyOjZN5bE/zkEkP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0CK8ds7; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0CK8ds7"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so622985eec.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169692; x=1790774492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huS4A6FsKFDWrrXfwa21/vS+oZaWC4wTWSJg3SCD6Do=;
        b=D0CK8ds7W6psy0KmzYhxMK/CAAP4ORvoj95BjwqmgM6Duteae7gUKBdP5Me90pefl4
         xf0qA6FqeId1AW8IgpqE3dxOagNYr3kqC9idD+K/RD3hi+TO6mRK5w0bozb/RHEt5Tm9
         L/dUkUpyKojZFLOK0XpkT2K05C6TdIJqfBnmPozH08qiiFRcUAcjdN9zwFyOOn2vOLqP
         jBs+nBEDxIGqKPG4HJqW+SNU4nRiptExh3AQjDQFOlYPNDqrGuVHZdudiNyluvf4S04m
         mu7Ysx3jpF63aJZVHtX3erDtr0qrpD0/UJzJjLSeS/RJ5sVf6Ux++lUHMKcSm/GsTRtG
         V8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169692; x=1790774492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=huS4A6FsKFDWrrXfwa21/vS+oZaWC4wTWSJg3SCD6Do=;
        b=J954EP8qaXrCSsTkOAKdZylLcvt3LPkoBxo3h+pm3WnkCgsxqiN/zTlQIXdH5otfKv
         0lCitNNCV5+WZn9zRqcNYMf1Ln0NwgtxemYW1zVjAQd/y2tVl2DO5vfjar+WDik4I/M/
         dS6A698nA8WaAcoWulLQRnnwZfP5AoFLrvI+CQOT00IJUorVrSs7wSfz8Wut9cOZtEXJ
         ssmg7vLxalmeZfzGxqKHK2wPMYiALsGrarCzeNQ1aQweRdbITlJTtEM7phjqyxYYES58
         efQ/Uht409y9BfNGDI3FwUvSlpkqTMQZvHmqqkjW8fz77rRVqesqJGHon4Z+Sj9DcRE8
         98mA==
X-Forwarded-Encrypted: i=1; AKwUvByq4QjOEZvZiw+IDD91QC+iE2m1Kt6d7ryNa4Ae8aPyxrxlQZDq07uWk15p+DVm+/X8VAc=@vger.kernel.org
X-Gm-Message-State: AFuF++mmuVT8cUpiRM1OwogVE90HLngsF7X3XCCExep2OFA53YY6tDMp
	3Yx9PJcp03bfLtmFhfsdgQxqzMXlxZx5aulUbcgUF/jmAKb2c3BMEsI3
X-Gm-Gg: AYBFou0oDNjnaUSwneWRFs3ruGqFyOZ4RTCdQk3Z+nUtCawDWadhKuLdCcvDTak3yBT
	dbr+FqZMQusHyjqQDQDgwE8fY/ueaAVB7Ia6BMmSFEczmRfvkrBphV+upLKMHosZnUgRbfkk9qn
	391QBVw9AgurYGN0Xru6h1Diosc9RYCGCdYjJTpx7pOcY0OuVaJw8ZShz0SowpW0uXtj1cb6b/1
	sLKuQYgPHz+mPr93yA8xKhltIWoCNeQpeDZTRF0MsxQWT6aP31xeY2alau93Pjn6Hz46bTOsxqJ
	5+LJMH0C/b6WdSwzx1J2YRdK4O0TepGRAB66OICmH87lUnb4LqtJ/D2YZol+dDPfj47hTbVMbBe
	DqIjlamC0oO6p6A+MELcEGZBwaY/VX644IIDoBqZ+1lPrjMruJflcyczgg4W1Uo1MqgD2q8BqzF
	BeoKUhmauEEg6JCgjyo2IX8Pwi8Qg/fY+Fj4Hku5379tIIcvMxf51lzPl2Xbtg3wAKzssX+Pmd1
	cbGwFH4Wb7qViHUMQR69rtKGxBBnk2CTIggtfqf9w==
X-Received: by 2002:a05:693c:42d9:b0:33b:e75b:cc42 with SMTP id 5a478bee46e88-33e8d7d8b7bmr2063395eec.19.1790169691801;
        Wed, 23 Sep 2026 06:21:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:21:29 -0700 (PDT)
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
Subject: [PATCH v3 027/114] hw/misc/riscv_cmgcr: replace target_ulong with uint64_t
Date: Wed, 23 Sep 2026 21:15:01 +0800
Message-ID: <20260923131635.1894-28-luoyonggang@gmail.com>
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

- Change get_exception_base() to return uint64_t so the GCR model
  compiles in libsystem_riscv with -DCPU_DEFS_H.
- Match reset_base and cpu_set_exception_base(), which already use
  uint64_t.
---
 hw/misc/riscv_cmgcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
index 0390996f78b..2086a33f08e 100644
--- a/hw/misc/riscv_cmgcr.c
+++ b/hw/misc/riscv_cmgcr.c
@@ -110,7 +110,7 @@ static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
     return 0;
 }
 
-static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+static inline uint64_t get_exception_base(RISCVGCRVPState *vps)
 {
     return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
 }
-- 
2.52.0.windows.1

