Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0991430CF9
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438737; cv=none; b=Caclw97GyStL46XuAA4RBkmnEKh6YdtmK/F5Z04F/2wb719fyXaf/IwV8gu56Z+ux2XmVWZAkeSwES7ioMEWuxjjUShTgqY18+/86noE57b6WEZa8KYUVEailq5DqlXfjawNa6CELXTvv6DC00OdZ8HX2WFAuKExyHokMIaNCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438737; c=relaxed/simple;
	bh=WlxI6D6l0R5RgwB+XCAILtOwfVKifVrQwkT3eMDmrR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSzXOh0cM5tFHBMPxvmE3sijDI2puCTjkvQbJyitp592tp8tQRPSlTrrCCav820+r5LhTLqVo6X4I9XvRLLgukWiTDyVohd+6BkUM4c5V86vgKIRr3UgOvXU/TqUV/DL4WPAjQOftKM2SbmCSf/rOHtlwKx+0Ld0q2y/fcI7GmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MmjH9P0K; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MmjH9P0K"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so5020095e9.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438732; x=1784043532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=MmjH9P0K3E2AunaKnGG94wC0VVYj8cpOvWmGsRK/OKaVA9NvRb8DIQZ1pmpY6aKx6+
         Mh9SJbU353ZwUt61sFItSAOcbmwbbRcb8V7bn6T5XJCdCnf4nJah1QbXV3gmOqEpv5y0
         BlqfDR3ymtTkdEh8Q/z4Fs/WKPvP4MkRntZ/KmtPkUychE6pHwJZ7O1JKLo8e576aHaC
         w1RFtzhg3T6zSmOIKZDJLL7VltpO1rbdlO3n2ToP3bmg1ELTdbqpiZkeTC3GHI4yyeBA
         hKDp9n1qiLLDN/JExEDVBKhvkcBoVsnzpwf70Lh5krwZCPoQIqGtBQJY3nRCju3+migS
         eOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438732; x=1784043532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zo+1xXtjNgJHcWwxARuTM18XLwUMS607PmqY6oQlf94=;
        b=pWNLQBupLc392llPdYHzXAVfv8P5DNJcQZpGpNpA4bgIXeif6Kb9fEJf3EmF0araks
         3Gb9+ytqIIHsR6E4pLhOLGEt1RxBflgrekCeW4VkgBLe7yTWNwiVRXg+5XviXKT71Doa
         RHST73BpSpYjHpQQE8KMWRA4xboyfde92GfvqdT+UzycGLNdBVYpeZ4d8gp/q7FL0GaJ
         u2DKW+PeVNEn+0xS1VY4jkJ5dMeoPNjSJJadOkBfRJl91QNYcSv5Pe0isup7FRbW1HF6
         Kk61eBvUwyL1hr1tJzhlDRRGZmn68VifN219ud+d7uY7FYmR+OKXlQZ3NiGDBfHZVxvj
         1KKA==
X-Forwarded-Encrypted: i=1; AHgh+RoVYfTkCfSqeB5OWXI3YjPHBcNEAedzCKTLGcWJfFAJhwLCCxPsjecP6s3O0OnkpHo7Lq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZA7yND0TYLWDuFrkEhBllaHTAbb9EjoMYqwPL3GCmppZxW7R
	46u86eV7DPr+OKS5VcLFIfRqCgQT19kmSGhjXIATsNPc0wp7aq6lGUUwGSKXPLmfR84=
X-Gm-Gg: AfdE7cn3zL+LX/+Mv9BJ7jl9qO+LdkC3roKIIz+2NsmwAtJdIlSzLbPqLq5SNVc8o96
	dqDVTH5A3BnzK2R8nw3laLW/25Hb+MgAz+WUj6ATxXevrkHKlsk6LRzOcjYp9/cJqFuFGKYd2Rn
	IqJIEGH4dMB3aKA0WoUZW5v/Xc7UbCp/IfexhMW/b5L7QB6idtBfEUFHMX9mifkK4Htmq9+uFB7
	wRp7GVgFzVMGELzWj1MA7KIpCN9nXOoGiaLWQgp54Sx7cEwBfGnIblDuMAQK9HFNA+rX8Puessw
	7gOY0MeTvEx8nq2b8JmMVkgx0m0EphMuny72TGJwzxtCdBLbJXw4Z0YgH1Ifg/pkR6PQ+FchVnX
	KjTyxh1bVG2JjE5eJCfUZuycQ9IBsHcGLKauL1YbCo7dgCbf9si41FvOm6hD8BPg68QdJ9CtXPc
	OynxiXuve08OYo5W9QwJJpVrIAoiWLOjzZdqyPsbO/iQt8lmdJdlmry/F06wUw1urgxpLfihxHK
	//cZPMYYSbGLw==
X-Received: by 2002:a05:600c:8010:b0:493:d117:18a8 with SMTP id 5b1f17b1804b1-493e1011e8bmr32534765e9.9.1783438731805;
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
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
Subject: [PATCH 4/4] module: Limit ELF includes in linux/module.h to uapi/linux/elf.h
Date: Tue,  7 Jul 2026 17:37:07 +0200
Message-ID: <20260707153819.4172541-5-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux/module.h header is included by every *.mod.c file to provide
`struct module` and other related definitions. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions.

The header currently includes linux/elf.h but this is largely unnecessary
because it requires only the base ELF structures, such as Elf_Ehdr and
Elf_Sym, which are declared in uapi/linux/elf.h.

Replace the linux/elf.h include with uapi/linux/elf.h. On x86_64_defconfig,
including linux/module.h alone results in 2.2 MB of preprocessed data. This
change reduces that to 1.5 MB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..7661faadbedd 100644
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
2.54.0

