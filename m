Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF31530DE2
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169420; cv=none; b=dJXz8ApEwZn7NdBfE4aOYLiyTwT1p9E5cz5ELaXHmIrIu+mggscxBOEEDBl7DXOOs4dNh60fr2ofSQ8ouHhRCKbVpYlVD9wJkMKlcL5X7lU3TnPsqRgv01q7LaGYqAqj1+zD4/ezdCMvnW03gEhE5XuzDOioewK8gQ2dE96xncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169420; c=relaxed/simple;
	bh=sohrdeYoCLhBUgagmcehvinqOyWMRKJH2GxxHw4w4N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxIYXi1z0V8tGmWzUU7ZLHkCbdWeeXQDZPT6MyfSIMAeocJRoBsz8z2hZzZAf+mRglCBVH9ROgCNHqYQ3Drykwrxj1G9/2UyKIBA5kzf8Zce2uoG1Tiw+oDhkCco23eZLmKrOEv7alQkU0/EPM0VqrSS47HrZv9pK3w51P2xZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWw9tBDd; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWw9tBDd"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33175556ebbso526356eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169418; x=1790774218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gngFNJ3Klpuiy2qgGGYHVsKQcajQAru1FZZV3MRnyY=;
        b=ZWw9tBDdhoJpQdHyYlmZF7jGaOzXtzS2IVVEY7NUL6SjEYKS1jLO55pMQRmM7nyW1B
         07qEb9IBcX/KDk1h8IQFu7XyqqVxBvl3yilSiCjqgzWCl7YNIMya0uG9WUwS7AIJ/GGz
         7wMyDqsMgkNrs7L8Cp6G/ijT5y97TpvPHOX7I1VRX3yyX7K0kgWaj+Du3FtwkcdH9pqw
         9NL869izaIQlNaoj7OOHI4wzSNuAhQ4TlQJqTuP2X/N+CYACMNUEokHtLgfy0uFbsZFs
         s7UU6ThB/b6QTLIqRf8iBlCZv6EPmybZqbtzrVLkBMbscStaO8WTSSP2qDUb8hx6UNut
         TBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169418; x=1790774218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2gngFNJ3Klpuiy2qgGGYHVsKQcajQAru1FZZV3MRnyY=;
        b=jH23kwjWqNd7NeY9vjfD+v7jkugDRUa6FhHDASl2dCG9XJAur7q+0wtRllby50b3uc
         NvuRmAk4A2TU1DxkPNTmgW69MKaCvlngFoMuyxaqB65rNwFMvbeF147U4N6fTbcavzox
         /vKp6ULYdASRSu4cixB/0PLmCLDRfMo6Uvw7hh66blqvyiF6+ZaSe+cRPwbTgGU3FXDn
         b1Zxise2LUjz1R2U+ep8/QzzDuGzwo6GAyR5dXEQJdt4W2pPRbJVqMnO6MJHrxj6EiQy
         e+iH7CoXRz2Jcvr+Kdq5blSeU6fdDSGjRG11w70Hau8ceMpmxH6sYxjDGZqy5yerAZEq
         8cPg==
X-Forwarded-Encrypted: i=1; AKwUvBwrVSDoYePJwJGLPP2A1p0j3l+9yaxQ40dWNouDHliGJCyaLlIfyuVXtylaJxabdKxFnaY=@vger.kernel.org
X-Gm-Message-State: AFuF++m60Q972Xpuo7pfqM8TLoY1CJ9TGJZh786ZNmiLtod4eL940KTi
	FCIjFK1ommZCpmcreUd5kbBCeX+/dSULxLNTHBJvnsC32xf8P/QY7a8N
X-Gm-Gg: AYBFou0FZTTZ1ynHznPYgFnG10qRNRDP/MJeFlB8ksO4hBMxjg5yIzacIZ+61kz7hH9
	+T8OzA/gF6CGIxFFYVOrupuWGZDK8o8ZqA0JrhPg+0BMb+HsbhJgf6q2Fi26jHwmlcaVZvjYfqG
	/ygI3bd+6iuT6wQBtHChPmm+Rq0WWCIwi6gWXwqR1Ld2UPO3TkyMTPS3tpeOnctvGjTI02ZlQ12
	OqpjUdMoMmMil7NUI3hEaSdebFt/h4Y2LvQgp91I/VK/JqWOw8D52gXcbo1EXXP1WQb1X8DDru8
	G/CdJCi6WlJlLqIApE0pKgkpJ95C5/vzqxBd4IhcD4+n+DaAMdDqqRwnGpE+VYjQHyEpv59+jJZ
	zYzjgdeKcvfeZaTSzOuznOYpmXkhuJQrf6z7fmdQMubEBNwG+SdxQ31XoZ4BIVN/6wHRzppAd/Q
	kxAWpXOabhRzSITXh9s/N/ZSI7zvg6mpkF6xKTgIwy3ttcWvtIHptY4/fXc7pVDc32NdcYUnx9i
	rVdLo3O9a6/t/R4UlChF8RuU+os00gWeqCNqiq79Q==
X-Received: by 2002:a05:693c:8808:10b0:33e:6b65:5eab with SMTP id 5a478bee46e88-33e8ddbef60mr2484078eec.26.1790169417968;
        Wed, 23 Sep 2026 06:16:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:16:55 -0700 (PDT)
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
Subject: [PATCH v3 001/114] meson: stale qemu-version.h only when .git exists
Date: Wed, 23 Sep 2026 21:14:35 +0800
Message-ID: <20260923131635.1894-2-luoyonggang@gmail.com>
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

build_always_stale for qemu-version.h is fs.exists on the source
.git. Matches qemu-version.sh, so a tree without git does not
regenerate the header on every ninja.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index cfac634cf13..f17665c667d 100644
--- a/meson.build
+++ b/meson.build
@@ -3546,7 +3546,7 @@ qemu_version = custom_target('qemu-version.h',
                              command: qemu_version_cmd,
                              capture: true,
                              build_by_default: true,
-                             build_always_stale: true)
+                             build_always_stale: fs.exists(meson.current_source_dir() / '.git'))
 genh += qemu_version
 
 hxdep = []
-- 
2.52.0.windows.1

