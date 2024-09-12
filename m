Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1919F42D
	for <kvm@vger.kernel.org>; Thu, 12 Sep 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126871; cv=none; b=HtITvvC0gvoFgCyjEvQlIKb+mrVytMfYzlqfKFvNqjz0pARdvMQrWE6Gi2PoeIqMrOSyAQ/7Dxy+hDgtGl5ikGVp0y5uwicU/6tndHDDOuEikPEt2Ix2CSlZm9gqPBK7MV7tQFaBiQPNh/lYpHtTbwhMCIubQSD4ygRx5DQ+sHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126871; c=relaxed/simple;
	bh=E1Pu0CO5CUPU0r7PLYod3ULL8E40Kpi0/doRJL/zAuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rC1j5BJ/ATsMIBVlRjKb4NUG+VtJwodfq1KR9Nb2PPUNB65tL0uMiudzff3qjmQjm6gB1uQ3Ux0SQQoMuV2xfOwJWLsIVfpqWPa2t1amySubrtLzk87nB0DhpU/7jnLlnQImeHHQovmn4nfmiSzWBrpTThih2xQGHz4TfuGvYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fIvIiFu/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIvIiFu/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so1298245a91.1
        for <kvm@vger.kernel.org>; Thu, 12 Sep 2024 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726126869; x=1726731669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSalypF+pMQKKa4uNxhVuqSrJY5QTLcHY0WTppEbuVc=;
        b=fIvIiFu/zSbfJ1iN6cXiUZEZTvCj5r2rySDJfOEwBjCToTUH6Wli7DjU2bWwj7AdG6
         0aVb2J5tFyVPbVjTQs5E2gFdKqt31XS96GiLLDFxgWW6I7S70G3LYB9/shcb7bJKTDd/
         9sh9G54Yi+LYrzjYGA9hgkCw67en3txYIWHz4ulaY6igZncoj4xQfNZ0psHpWL7gJmvV
         Qpu+xbLQ4IW3f9QFkeWkhHrtJScmbX+O4FUNFzSQiweX6Uu2xyAnVk6DBxtSUKEiy7p/
         4jOR41xgFS6ji10wEBjJkhxmuxNnPQQOE2ZPlCik8a7W30xwXPlMUFza3qagCJ7QDP3u
         DPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126869; x=1726731669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSalypF+pMQKKa4uNxhVuqSrJY5QTLcHY0WTppEbuVc=;
        b=AVnXt2kB1+5MpJ3Mmi9htpIfCTeHScOUagS7qy7lNXxyxjMLISzDbKD3RuHcwu3hWo
         uw5lChD56KWI+Y515QNuNgZklgr4p/bzGps9ctmdUCnd0FPouKeZ8blS6Y1jcBUlaXHA
         kqJyJ1iAlLG/gfazmsnjrMCAd1djvY0fqUA8Byo4jY1AdPAFHmHcT83FPFDuEike9Zu6
         VttGO1cxrXT44vMjQUSBUoy9qBNGiHIYVYqj2+taaSTRin1lCRlZNS6dfPr37XvvwJl+
         mlIhLyc1GuMJjlHBRVuje0v4dfV7xeUVadkoDj2+r0I0nhphtTPNBEeKV+ll64p8ZJ5P
         mryw==
X-Forwarded-Encrypted: i=1; AJvYcCULSrkb8Rz/1IuWKP/ZAkzzTh1CB19MRpDjAXftcU517/hOK+3tzUYQd4StxwmronN33Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamZ1jSexTbDpTKvxePB7tBUL4N5lfOgtmivx+94hMTyN+CELT
	+G49pzA/NTtowdnF8CTQBDevvOA6VZLou+McWhO7xiort48bEX9tZ8aV3RWB4ik=
X-Google-Smtp-Source: AGHT+IF1YUkgbI8Z5QYhP8g1gpLzhK5aYcn1/M3ZoEOkopdJCnHdCRszwAZ6uD2z8SDokzvFEDBk7g==
X-Received: by 2002:a17:90a:8a14:b0:2d8:a943:87d1 with SMTP id 98e67ed59e1d1-2db67211d37mr14855931a91.13.1726126869060;
        Thu, 12 Sep 2024 00:41:09 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:41:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Laurent Vivier <lvivier@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Klaus Jensen <its@irrelevant.dk>,
	WANG Xuerui <git@xen0n.name>,
	Halil Pasic <pasic@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Michael Rolnik <mrolnik@gmail.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Fabiano Rosas <farosas@suse.de>,
	Corey Minyard <minyard@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jesper Devantier <foss@defmacro.it>,
	Hyman Huang <yong.huang@smartx.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>,
	qemu-riscv@nongnu.org,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	kvm@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Bin Meng <bmeng.cn@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Helge Deller <deller@gmx.de>,
	Peter Xu <peterx@redhat.com>,
	Daniel Henrique Barboza <danielhb413@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	qemu-arm@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Eric Farman <farman@linux.ibm.com>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	qemu-block@nongnu.org,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <eduardo@habkost.net>,
	David Gibson <david@gibson.dropbear.id.au>,
	Fam Zheng <fam@euphon.net>,
	Weiwei Li <liwei1518@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 39/48] include/qemu: remove return after g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:39:12 -0700
Message-Id: <20240912073921.453203-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/pmem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/pmem.h b/include/qemu/pmem.h
index d2d7ad085cc..e12a67ba2c0 100644
--- a/include/qemu/pmem.h
+++ b/include/qemu/pmem.h
@@ -22,7 +22,6 @@ pmem_memcpy_persist(void *pmemdest, const void *src, size_t len)
     /* If 'pmem' option is 'on', we should always have libpmem support,
        or qemu will report a error and exit, never come here. */
     g_assert_not_reached();
-    return NULL;
 }
 
 static inline void
-- 
2.39.2

