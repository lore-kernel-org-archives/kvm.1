Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A7382369
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310321; cv=none; b=uI4oCT6lDA4NGHgSGV3y0/7zSGwa0N40yZrT6kYZ/AlLlSHEEsfKYoqrIvRSQ2J9AxGhdk2lvXQyVbke3xBv+Y5aY3IbXIj+y5z71jUqdAnfvNsHdymrLriSiJzSLJpLNX9bpCaMFWxb7qdf98uF4Z4tHVcLbcJIokIT/TdDiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310321; c=relaxed/simple;
	bh=sFYnTC/23rpMheriSt7XZpSxHX7Zbfc4cUo4vPsisIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNgyHglNnUy55JN4ZTVmU/M+M7K26OAYabfKJZwVLLkQPkbEKw9fUDQod/afz75hXFA7KeOr6/pIWaSvBwZ/eXB+VbYnUV4ta4mjcY2dVgA3QuYvzEew9eq5TxDF2el2fL0jiH6/vXKB0iyJxw2xlRDqpSLUmNNOpZXVR3fN9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oz480YzC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oz480YzC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b064884a7cso335538775ad.3
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310319; x=1774915119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zq8TWEDbszxKidgDH4WcoGu6pRsZKEzAg4VfsbVeec=;
        b=oz480YzCt+c6CJEXIEK52868Ffi03PTUXOWjT25cqLhAJ7qsgq8ChKLTTPtI3aOdz2
         aSrWiizprrVIp3s0kjIxDHXdYPUAxA0/FquUC/i/9Yu1arfKnXjJNeEX46j2LE9lZeX9
         03q5jQHn7pkd3okd0dEBDhpiGllQFKMaFKkSwHd6p6oGdbgJmD2GZqhEFH6ZS8KIbXb9
         13uTFfCCP+yQjN3iVO+4GYSrXswtwnl3txuHbMv8LLLyS0H3L5ZeYmKNSCmBqU+X0tQY
         4socm9pL+L32mm4ab37j54UlWM6QMB6WuFlZ9fs0ii9mpnJ9FQ99WlnSWvBh9ql/cbSi
         Ef5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310319; x=1774915119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zq8TWEDbszxKidgDH4WcoGu6pRsZKEzAg4VfsbVeec=;
        b=Fn15JpErgAXD07MR6CAxwXfboAIEReklsXG6PR923flZziP22M+sa0LgAKGFCfhHll
         dbPyZCTVwsknfVnUtinV2w1/xLpYGZUcs4DMl40eCHg8P7x8N7N2Y2aXzGgDJ7mH8xSZ
         th0cNBJ9mtPtXR/TVAAtTNJUjcBZF3Jgaluaao3z1Bh87rF5XinwxMCRs9a+RXmp7fRI
         /uq5Djp5fGXsRJg7Voz39axiB8jRgCOMe3D4nvrYe502ZNj1TvYnBeuDKY+eGj4PrV1U
         1CjRSGwsjqZ4Odp2v6CEuf8BYGZ9icmfKXlWLzi5QaNtEokqLORjOIB/LX6ifGDsviDp
         Ka5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn55fXRGhjpLo/tMjtuH94S3qRP855KZQrYrTh7+nIBc1azz50R2D7IQdmeCOavYZkFk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqnSr7Vk5w5IyHIlwlruKonl1iuAFa+aehizOJ59gzUlVNE+2S
	2dKWBKEynOzoawJfgCG/ZvugTQflM3YUK8H/jyyXJEK/3viorAgXK6YfL1VdpvnBTonuobu1uoE
	CCAmpsh2XVyE+Lg==
X-Received: from plbjz7.prod.google.com ([2002:a17:903:4307:b0:2b0:5cee:2504])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dace:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b08271a32emr137995625ad.17.1774310319196;
 Mon, 23 Mar 2026 16:58:39 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:53 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-2-dmatlack@google.com>
Subject: [PATCH v3 01/24] liveupdate: Export symbols needed by modules
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Export liveupdate_enabled(), liveupdate_register_file_handler(), and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 kernel/liveupdate/luo_core.c | 1 +
 kernel/liveupdate/luo_file.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421..59d7793d9444 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
 
 /**
  * DOC: LUO ioctl Interface
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a38ea4975824..cdc48d49e5e5 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -866,6 +866,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -884,3 +885,4 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 		list_del(&ACCESS_PRIVATE(fh, list));
 	}
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
-- 
2.53.0.983.g0bb29b3bc5-goog

