Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAD371043
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137773; cv=none; b=aniVaZHIn0Igy4WbmBiLJVx48BVWcR+AKSdD0V03r74Nf62hjjxnzmk6Zrui2spkn9NFkgFYQjD2VU8XNbCO7fXd+PCa7/y+esv/VLiGwJdBh16Pc6jcflJLO+5kKZ8+t/y5hhxccD/3I6+yy3zDxFSfvrqjZz5rhwZeB2gSGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137773; c=relaxed/simple;
	bh=vyJh04de2eQI9xDXQLk2SsoY9d27ljdKRQo9PLvYs3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmK7SSwcXM8pC7upPYSz9YOJIR/BMhja0/t/gcPVIn/dKWeiwpU0ptzLeo9fMV3nhnUWSeCExYydfaL5mkriUaMjChgEgocV5aMIQ6NMh/njeYAdJoZrTYAfp1fUciBkAzcxvSbW3XFXIAgJwCBrmulsqGgwGMoBQz4uOqii1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ry9/DkDa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ry9/DkDa"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so11084115e9.1
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137769; x=1789742569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7y0rlVQh9abTylMWGDq0N15j8M2y0GYhOvmNvpShVQ=;
        b=Ry9/DkDaFZ4TdwpnSd2qNFVelkgZf0I+sK/vUSrXGJVDvUzGWKFLqdb8UxWJFtIRyd
         QGt2zLsY13XYCfEcx00KmUUPRDrGz+NYn9CJmX9yUyb6hq7gEJz42IC4MRCnwIaEcpdW
         tQUujaQLqeUNnfCJTTcjYm7FSljCpemBd6+PukhbHVRJ4Q4stj3C5SASxuwEvbjV0Osg
         /Q9Xgj+v7KR2zVR2teJezj0miqoZCcV0EC/BLQEfUdpZPOknI1tMHRR4RQUQMW5zLmKr
         P4KyxRefgvqyrABexKeT1gw6lYCx5pucDAHN4oMpIUKFHJiBPNydC9j33pcTbhnipiQE
         DZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137769; x=1789742569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7y0rlVQh9abTylMWGDq0N15j8M2y0GYhOvmNvpShVQ=;
        b=Dj1rm+pXLrp+CBmJMVZ9B4IXPXFig2RhCJkptvgVaSh5hErtQSXWh0x6T2jk0gANlT
         pYqHnNTqhbXIVO+GVabK1SMe9MWGtli9/bijZpbL30YcdVFnJCXrBG49rjNdMHC3fsVG
         Yt3cOiTDtnA7JNqu3BYWm8qW80pduGaOoi+AEY90OGGZlKubXtckuMYi1bIsbupouNns
         glZgYnadg654h5s+4Ph6uMAxE1NlOXDdEOEbTEZxPnE78R93Xt43+j5I+36magRU1fRx
         xQ1DqffN9M+ocdEIPS37KHN680erZuZiMnGnag4wik1qVEr9/3DNj45iY+WLE/ISK1mu
         LN7A==
X-Forwarded-Encrypted: i=1; AKwUvBwFeZ8Ti53kDfC/ct/6b4Msvxuq1AFnHitHnTGY4rU1KbU1kZRtO2T1NZI63ttlC5wyBeA=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ7evbyPx2J2JEpueZ+k3n4DnzlQY1ajvIP+D/owABQv6n08B1
	7NzRyuETZW8AvLyaocul0fuRlBjKg2WOD1njWucFSQq60BiFQH0ZgzfnRu6yTVjY4Ho=
X-Gm-Gg: AYBFou1kJvSrQ3eiuQTuiuTSA7dlZjEIko/CGJMdJFK5dppNkJLKlOq02iRm/h5Mo+Z
	TI80nYnZnqpFwJ8WQOyJwL+UrepUL9zm4KYcfk1IUMW0ZwhAPe/sbmBUtvieI24+ykDw/OInnx9
	vHBZZhusKZJ4D0etJRzRgetrelxNB89Z5DwlimGu1mHaKmxqYKYVj1QtjuvLuK0iLc6U1PF0E6b
	DR5U2e9dP+qSnhXYI5F16Jsdqnzqy4EMJb1PRT/izQr7sMlAzENRdiMLO0uq6QynisFnka8NaLq
	ZVR4JInu1NTiNdY1YkdJ90uOOvgvTgNGsLhpdMf4I8OSjZNOgQMW2fsM5Tv3dCnnBSo2Zydc8fx
	4XQNE0RhPQwUdBHFUT1947H10fnO7UOwY3Y4bOroiGzbjGbc0TmPNqfKR0Q3kODWjc8Axen1Phz
	1J3kbGzY80Ei5sZyR/l7dLUX/wpLxCY7UmTeoxKTVT3QpsaBD+bn1JTsb0lHOHgllvXkP6g8y8a
	IQQIg==
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id 5b1f17b1804b1-49e619bd068mr62359435e9.17.1789137768683;
        Fri, 11 Sep 2026 07:42:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:48 -0700 (PDT)
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
Subject: [PATCH v2 4/6] s390: Remove the asm/mmu_context.h include from asm/elf.h
Date: Fri, 11 Sep 2026 16:40:34 +0200
Message-ID: <20260911-module-include-elf-v2-4-954c732975fb@suse.com>
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

The asm/mmu_context.h include was added to asm/elf.h by commit 146e4b3c8b92
("[S390] 1K/2K page table pages.") in 2008, when the new macro
elf_read_implies_exec() used disable_noexec() /
current->mm->context.noexec. Commit 043d07084b53 ("[S390] Remove data
execution protection") removed that macro in 2011 and asm/elf.h no longer
needs asm/mmu_context.h.

Several s390 files currently depend on declarations provided indirectly
through asm/elf.h -> asm/mmu_context.h:

* arch/s390/mm/mmap.c: check_asce_limit() -> asm/pgalloc.h,
* arch/s390/kernel/processor.c: enter_lazy_tlb() -> asm/mmu_context.h.

Add the missing includes to these files and remove the asm/mmu_context.h
include from asm/elf.h.

This is a preparatory cleanup for adding the asm/elf.h include in
linux/cpufeature.h, which would otherwise create the following cycle:

linux/pgtable.h -> asm/pgtable.h -> linux/cpufeature.h -> asm/elf.h ->
asm/mmu_context.h -> asm/pgalloc.h -> linux/mm.h -> linux/pgtable.h

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/include/asm/elf.h  | 1 -
 arch/s390/kernel/processor.c | 1 +
 arch/s390/mm/mmap.c          | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index bb63fa4d20bb..e22e3ab25760 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -170,7 +170,6 @@ typedef s390_fp_regs elf_fpregset_t;
 typedef s390_regs elf_gregset_t;
 
 #include <linux/sched/mm.h>	/* for task_struct */
-#include <asm/mmu_context.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index e33a3eccda56..76b2c7478c6e 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -27,6 +27,7 @@
 #include <asm/param.h>
 #include <asm/sclp.h>
 #include <asm/smp.h>
+#include <asm/mmu_context.h>
 
 unsigned long __read_mostly elf_hwcap;
 char elf_platform[ELF_PLATFORM_SIZE];
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index ef7bfc87758c..8206f347e00e 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 #include <asm/elf.h>
+#include <asm/pgalloc.h>
 
 static unsigned long stack_maxrandom_size(void)
 {

-- 
2.55.0
