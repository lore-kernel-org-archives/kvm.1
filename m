Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910F3A3E97
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208896; cv=none; b=bb6FGww8H3QcMLSAHNIuC7jz7oqflX6lg/6XbMvWdYPr+p9GbnUrM+DljeJTc4SpM2I3n6KOnyV3/pGNMqi0tcVNSUk+ZYzXPpGzlMF6D5m/fzZOihafrYcZQAVtLspOK3EToxC0MEAQghUQJNStoETyBKy/VKTHrL3MLi4F+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208896; c=relaxed/simple;
	bh=KC+KeP2JowBZu3gamRptd0wuDLOAfNANiP0q+wCsnA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjP1RmQOeQDF4qVEaLw8fiIRr617y9VmN6CUnUOIYX0qjnoJmvXXULUqspDMUqKofagFPa9HCrI+HtXzWUNsK3X7ssWM+HgA80VrbIZN8WInqhQXeAhiLlkbbYerStm0HBoHiwPlGQbWqqCdvCzBFvmBFkJhsaHHxtn5HlsP9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R25zVrp1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R25zVrp1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c31212104cso1117605ad.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208894; x=1781813694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EvRjKx0eOYE4LeiPY86wRBYHx+SwyyhRAbMXyCGdk8=;
        b=R25zVrp17BCEqRvVoxi8QbpyhsuYRx2YZ5r//Ak6kUxL8XdBJ89lQ2egfQBazBcsZx
         NYwe7G6qlbQ0Dqz5qIPzI384UCHCMGgEpC+KJlAC/R3Xj8TIMME2ogeNhavkjQc5ReAy
         iStnfY/NuPdbhI02oJIey+HkAavNudVe3hwMSFEhpfDuZXDjH06e+9aWhuTXMDQ27U0d
         vhsGGSI23PRlsWFuQxmcCI9XmCORFP/+rc1FVKeWI7sWDi8WrKX7sn2nBR3xuRj0ZOOg
         f42hjcv9cxahcgR9XXgOYOsZcnwe6+Fjk82B2QY6gY+NoRyNEqqpDxADygBntVRSExj4
         4OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208894; x=1781813694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1EvRjKx0eOYE4LeiPY86wRBYHx+SwyyhRAbMXyCGdk8=;
        b=jbZFRDLb40KKCZvSHV++/ij+vtVSelQFfQhX7YecxoFgEzQFiPsXubQZhkTb8pNuvb
         cp9Q3fYiS9kKp4n4wUHr7qFnjrlWvtLXqTMwv9MnioPC2iJIEdepXdnXBwkeVf3o0RUJ
         ABuaKEDOu7xlxfXFdRnKq4NSvAqtnywil5GJitbGbb+8NrtIZx3vTOEzXVjx8B8gjOeq
         dWicyn0rZyWg4YPZplqurqXkb/kyBzpuD0QAeSw1MYv3Rk10VPEI90rFuR31l+POu2nR
         /bYvyhMWguOo161cBCZ78PqqbwuYLOC+N4iTu+Yvg48KBVDNlUUihjXKaQj+wRaU6Cyf
         k5+w==
X-Forwarded-Encrypted: i=1; AFNElJ/v8n0tdVcoR0KxMFXb0p/Ld/rXpnxXlqcF7v4Aotvj9b0FmNxyM/U9NuKhuGaeXfCv10k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DS+Q8ETpjuo7LV93NByQhGUIzT1kc0/dr38TWkjz8YYwIiBV
	ylGNqwpvrK0CUNr9D2kkKShW3yMg/8qUoVx1pYXOZi/UNlNAZ4/lX1Zp
X-Gm-Gg: Acq92OGOYac576E7I6ZBWx0gSDYCE/PeL6LRl9zJ6KKR25ktO1yc+HphvzJIfh5cbha
	GLRCg3a5pETJ2N9VMBkW6KHB4gBj9c/KMbX9qsPwGyPvOiefQJmolu4pRUfl+TbHP+MpCmm2p1w
	xQ8GEILYLhx4rUqD1LvY11gfBBd/kwhFiaDi53GvVb0bJr8TJc5tGgcsdz1YaZ9qAbVAtQTByKW
	xp6he6zSP28R+dmzZu5Tx09o28PvmkuGDcSUPIGE8jWz2DW3XzWYf8fzg3IJ9k5+my2B+TINSNM
	s/A1f29XVztQCDFlNUEMQIrJm2YwNvHmBzTFiYHto+AZEfH/fIgw/TpK0xPVSv5iKmxR9WJL2Al
	jfQ3dnbnfyhQzlXViDBUs75nglwn0+gJqkifeX6J1Yd8/WSempMzvgj64BOFC5s5A4s6V6qOGyg
	==
X-Received: by 2002:a17:902:e78b:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2c2f092ad9dmr52178155ad.9.1781208894311;
        Thu, 11 Jun 2026 13:14:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm288730475ad.22.2026.06.11.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:14:54 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 11 Jun 2026 16:12:50 -0400
Subject: [PATCH v4 13/16] riscv: Add a getter for user PMLEN support
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-rva23u64-hwprobe-v2-v4-13-3f01a2449488@gmail.com>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
 Guodong Xu <docular.xu@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=aIDENBFY4Tz1hqn0W61EOefEH19QM+HExbm6+TQTBeI=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixtscO7srcsmPNoumimeNn3glenWfu11coN68yXLxOYZ
 /5uzdfPHaUsDGJcDLJiiiyHj7Zkb33lE+37nPMHzBxWJpAhDFycAjAReV6G/yUubxnmvF/+6MZL
 l8/SJWbvGHYUuhnHuDRumFUzqUhm+xuG/wlJztWWR8uzsl2qWjYVRu3cF/DJ6M3TP4cnOldPNJr
 zmx0A
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Querying whether a given user PMLEN is supported is needed for
RVA23U64 base detection from outside arch/riscv/kernel/process.c.
Add riscv_have_user_pmlen() to expose this.

Link: https://lore.kernel.org/linux-riscv/rfuwa7a3ebe76udmnwyrssjy7shkkgxntvhwzn6oquysj4tuyp@xzvpylcfhz53/
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
[Guodong: replace exported booleans with getter per Andrew's suggestion]
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v4: No change.
v3: No change.
v2: Add a getter for user PMLEN.
---
 arch/riscv/include/asm/processor.h |  4 ++++
 arch/riscv/kernel/process.c        | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 812517b2cec13..febf51e127f70 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -214,6 +214,10 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
 long get_tagged_addr_ctrl(struct task_struct *task);
 #define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
 #define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+
+bool riscv_have_user_pmlen(u8 len);
+#else
+static inline bool riscv_have_user_pmlen(u8 len) { return false; }
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index b2df7f72241a5..5d9cb108a6232 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -302,6 +302,18 @@ enum {
 static bool have_user_pmlen_7;
 static bool have_user_pmlen_16;
 
+bool riscv_have_user_pmlen(u8 len)
+{
+	switch (len) {
+	case PMLEN_7:
+		return have_user_pmlen_7;
+	case PMLEN_16:
+		return have_user_pmlen_16;
+	default:
+		return false;
+	}
+}
+
 /*
  * Control the relaxed ABI allowing tagged user addresses into the kernel.
  */

-- 
2.43.0

