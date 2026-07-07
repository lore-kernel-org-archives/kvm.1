Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3B42F70C
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438733; cv=none; b=gkU1H6eDkrbOWS8mCcn8e1ngMAasa8eSt3l4Q2kuvRAXGblhyuLFNpI5XLXaWAsaNqUf7guOdMyG4KnOI7Wy4gXji784zJMiRioTQSastnifIVsiVruxFKVf2+Wedxt7KhTnBLFWINK50LexRmMHwPi/XQy1jKHPci/EeNEYbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438733; c=relaxed/simple;
	bh=Oe/4C5CNRzZ9YU+v00jSZhbg5LdWqb5vYdjw2GlJdww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnJJwewpHCPG7YEz5Ft72FTHugxOpx/WvfylQF8CwIpg2pV7ZBNxjXw0NQRZARZqmYQaKL1kCfdvIUvLTvET7knosifcFGvoAoKKSAErQVr9Yw/WICmSc51ZwueVOT5tJM2Xc2ov6yYxddp8njpf+fwWd83sk/egRWzTxY/+kG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G1JrFb+o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G1JrFb+o"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b77b150aso39704635e9.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438728; x=1784043528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=G1JrFb+o6K3b2DQ4aApygcAtsuTlbZ//RZ8NQgCFFEcdCbT3ldUHbRDBV7BnPtt9uV
         amIGFzJ1n8vaPDUHwrkKlGGk3WEStRjCPWHRTq6wfCvdZFSnw4xyGXQZQlwt4UCjkbYo
         EG+3T8n8+zp/EfAutVDqG4s/AO2nYEo9NLn+YiLXvVYvIpBe2uLJ/26V2Pgyjo20CcTv
         Mg9TJbQTw8ga8Zop/C2M29xCiS8IehfpVnqoLu9vg66W+EC21tcwqSwcj+hggHGkAytT
         Kyr97wP0u8mno9kY4/+1zBtiDLFIRQ6u+ZlCLo13wedVnp3TpP0TQlpuK/OzEVxZZ+F/
         TFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438728; x=1784043528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdAECnz6XOdm9gtF7oage0nDpTFZQgV5yfQL0q5n2lk=;
        b=Evj+AZ9xdBVKLXdt0DZjTZI0CD+9ml3HCZND1Skn4BjEUktesYlkR8q34hE4WHVrga
         XHziVMgYsZ3HP44Fez0z52gyNCoE9MnJHxHvnvm7pFIXXFl2r4ghDClJXHJmhDpaNiLE
         ngRkbm/Nidk6R1mg0DD3QvHbDwm83yYK/ymnrArBMVUcWxn3kcPWFE9Cb3iGF5CrKWmo
         BATo21OiBX5Vsj4clNdgIFsiBurMhzqiZdTEUwgPI7x6GD+Kr6NBrFDNzSiTKK95hlTV
         Xtzl9M6mr/lq+/x1t6OiS2zuZBcL3uKlI8BQCZWUJl/fxOmntzQymS98SM8ctk40z4KL
         1SoA==
X-Forwarded-Encrypted: i=1; AHgh+RoProPFGeFhVCTZdKXrmIACLdOkTxoI+sLAG8csvoJGcUcnHZdRlxPlRMBdVk2dHE3Nr9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz914e2qqHLfDEjZKcl9SniGB1maSt5Urxyzn+KYxG98n3kTQ+y
	59KcdwruLRRSAgKSjaj+qUc6I1lV7dbS5td8rJjcAcp3YCDvuXKHlhnGhYG/8BjP+T0=
X-Gm-Gg: AfdE7cmoIMvBYFCzW5oEmLeYQlLyVRgia8Fjrji1VyvF7yVK/8Ff+DCccpMwwclkCPl
	mmFd7QMqMM/2EkRfltipy2CRrhEdGu7H4i8O0UOCU+c2eJQYZux3TwWPv0q7MbtLgNWMBKsVYkk
	ZyPvpg9ETfoVYIT+1lD/wIhtfS2wXVNdWPll086YVX2oCEKVH0AYhXw5XCWVokezXIkH6sdE7fp
	YHhrzQ4p2pmkLmaPRQBVs3oh2UljyQ3PYpg1pjZJVYzK+QagfpBPmTpi+Mpzh/sbN9GnunaDokV
	hRpwLJkcV4KaQGvOjGfmFw9cV9NFkLzeqBddwHXB6P+AUB/ZOdPkjTTX3IX4Jpcp8DdGR8ikbN3
	IH6UTCLwfYbzQZekBL6qhlgqgMVG+9x3M9S6W+MvSQWEEGDnXeIQ6bWRAcC5GKBKtWiyApjjOCG
	tPLCIgqsOaoVJ/SDXLZzqBJT4ZV9CSANHjV+DcZ7qRYXPVipybYHE1vTyoNdbLPcVv5B5HIQuG0
	abNrZUE0aOzOg==
X-Received: by 2002:a05:600c:3514:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493df05f8d4mr59362085e9.11.1783438728542;
        Tue, 07 Jul 2026 08:38:48 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:47 -0700 (PDT)
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
Subject: [PATCH 2/4] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:05 +0200
Message-ID: <20260707153819.4172541-3-petr.pavlu@suse.com>
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

Several s390 files use declarations that are provided indirectly through
linux/module.h -> linux/elf.h:

* arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.h,
* drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
  put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/nospec-branch.c | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..b62da9e81e79 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <asm/nospec-branch.h>
 
 int nobp = IS_ENABLED(CONFIG_KERNEL_NOBP);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index e6a264c996ce..4fe3ead4a091 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>
-- 
2.54.0

