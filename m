Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A937646C
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137776; cv=none; b=EMw0pE87TkizVF6b/fDyT5N9x1OsRxJrWZiZiHLZDqEWbYZ++3sdGmOHRID4K2HUgTxwjYrPFZ6DOmn+MPqEKrQIl+jkZIZAQYSBpyU8zqqNBkh/fX/CknxldxB+SlsDcLcoJHtooz5v6yY2jpjXCQ1G+7pmPPOG6Fctgtcj5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137776; c=relaxed/simple;
	bh=Pxyy7SkaZki3YINbcV9JeBRCrEvwZclMHy2R8pz6HCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il4riSpemJ9AV2EyZPmq5TrZN3EjM43p65NkXn22+uKxsr7UAgUjW3p0IqBViHHzI1wTIe7IME5khI8g2DQK7YK9dOnSQzOz3EGgDlAPEj2YlzYfvd3fIAsjauwpuwKQCz95xj101mlX44So7ZdIoj1QHY9oyuZe4UX1tvs7TUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZL0VJDNM; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZL0VJDNM"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so6538835e9.2
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137771; x=1789742571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hTOm27yE703mDClupAq0Z6AjkqEMN3v+AI9a1WnvGB0=;
        b=ZL0VJDNMASO1DSxTC+o2xJcHbmibbqqYvPu56dHYyLbXUbfWsxcAmqW5sX/GjIlTdu
         4sSpWar5cV7eWlzFuO7/jYOpCMF9Li4vt2Dx+0oWaTCqL5rN5eQ7yIUDTa3Fb2upDT21
         MRt9vvsB5l/PagSu0XAgVUMnzX9nEDszYc47tAqiIOXYORfvsbF/t74S1xOsRX4W9AWi
         tlYt57KeCqawvkXVDIMAu20DIH/DHhSlwlTsIQiL4Z9Xj795L8s8AFMCSBqrFBrleU/h
         HHctZDhoQDFOeGoZSxJg3BIZtZirNKo8DiSBkoDowWBFFOewMxBxoFH/cdPnQg6vJHxm
         QZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137771; x=1789742571;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTOm27yE703mDClupAq0Z6AjkqEMN3v+AI9a1WnvGB0=;
        b=klUQ1b+wUGaZGR3L+vD9ZuGJ4HM/fSNNArAF7cQxRhJNBtf5ttBkS6f0HCIMzWcYoe
         CpOhvckrgTQXmew3eoSBLOoUGtcKjj11tGKzllwVmn6bqbIlv0uDRfWhhNT+Asb1t8PE
         ITnOCpiUEe/2yrXcULTSXupH4LBvUmKZTXLQPCnRAXfhKxWbfHCluJA1AsQ36PYMVezJ
         NC2OMD7N8Y1vz66pNKtktUyL7PR9CTon/Pu9meFriNh5YsoM0FXszsmv6woFISFyKu2Z
         LFj4EXS0DFLv/y5bMIhdjDs2pZzLCzAemGYCzz2pNP0AiyyAWyRTD01GBVxaBqS9Tx+p
         TurA==
X-Forwarded-Encrypted: i=1; AKwUvBzJxakG+34TvW5Q9/4VPbuYxUc4bobHq3CCIOhMgsOTLLQTWupcu7s7WRVFvH3FLsBrkSs=@vger.kernel.org
X-Gm-Message-State: AFuF++n6SIZnCNTDLX273v5lydlNq6qnfDxK2/NezgMrMsczMEiMDSPO
	9JiwttzgZuBfPNeeryxhGTuxq3ZjSLvUfrPZJ2z4sgv8E3UclAFDL/tE0o7bqZklJTw=
X-Gm-Gg: AYBFou1/unHGtHdFm21Xp9ycdqOpUqVrUbNy1AO9nTz+XuiNwYJvsmsJyiZEJ/n7Aux
	bBRKiWyr52MJYkdc84VWgRvUjBezQx8f099CoLC7l+Bp6Iio1eqxbMUxg2KmaC7GPT3wOuZ3lvp
	cYZKeQ8CmE2pK9CkGdUrEia+5Q+CErtQ0BxhoOekF4pSWoxvpTHYbiXgQfeF/1UsMKKOzDgXeq5
	CUizsputBRxPhKpU0bk2VK1s2mgmJFUHzNEXSXtCisgW5QcG0wGpHBetHYuv8wsoVBoQPBsedlW
	JXVoMH8Vjde0tn2XFTCC6SWwQ3JgWrZZ9PO+GOjGoWTdf6K65sMqCkSWDCC642kjNml0qCvekBN
	cgvJqbnoEurmg+bOehtscCGUjFdHy8pSgCNpddN1DGtk9jJq4aKMcHIVGDNhYwC7ltG2Z7wuZqB
	05D2XzOdmkMMUfYTuELUOp2TyGNbiu0UX374jTbCTM8oLo9KslepomQJ5al27gZZ09Xbyh66Y1r
	/4sYuk=
X-Received: by 2002:a05:600c:a0b:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49e618863bcmr93280275e9.4.1789137771393;
        Fri, 11 Sep 2026 07:42:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:50 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Fri, 11 Sep 2026 16:40:36 +0200
Message-ID: <20260911-module-include-elf-v2-6-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

linux/module.h appears in roughly 15k #include directives across the
kernel. This makes it a "hot" header, so it should avoid pulling in
unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..1ec9e121a24b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -17,7 +17,6 @@
 #include <linux/cleanup.h>
 #include <linux/kmod.h>
 #include <linux/init.h>
-#include <linux/elf.h>
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
@@ -29,8 +28,9 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
-
 #include <linux/percpu.h>
+
+#include <uapi/linux/elf.h>
 #include <asm/module.h>
 
 #define MODULE_NAME_LEN __MODULE_NAME_LEN

-- 
2.55.0
