Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEF3E2AD7
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654600; cv=none; b=tZSTQEPrjgCLTD4TjH4aM5flnDO8+NlOeSOJWEYcnz+PieOB0X1D18Vo3DZkHwpxB6xekN/V18uM1NnCCdk5NQRQBGyDDWAHege/sDvwGUrn0rXuOxQHrQ8XIZL+7PuJLfuxxsgMv1cwqKkY+miOvqYlXfuo/dZh4tAW/KHn7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654600; c=relaxed/simple;
	bh=hwzN7aNlJ2wxS9ZWnQFgLPxc8hv3AZhs4ribMUFVqWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Njz9TBQdb+sQDlpIdvrEp1Ryd1GLCLW213bRLjc1+jjCDLA/NrxCv2pMHyMgpGWRJS0QZQVsmddI5Dx/dMUdcD5o9KXkbrjI7yPsf1AjVPrMIFcqs0qZhKzyXbm2iXou19IpUqEodj4ZzTlo8tHRHIk3fpwhhzIpbwkerTS8z8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J2pFgVBZ; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J2pFgVBZ"
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-671454dbcaaso325485d50.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654598; x=1791259398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=mzexoA4Z4hMergF03Rxj6qDmO7qusurAyxIAMB1lLimKqh10Sjz2rtXOgqFGWyHirK
         3aEluUikZiTLnyCerUV+4hrZN5XvaQIwLsME98lbiAovifCYiAi9qWMNZcQL3t3+PGOx
         /s5iTOniGS7tkRB6d7VN+KUGOu8yScORRbyVyndIVVHWlxJVa/Qojw+4XKlXrQ4t/uVX
         LSkUSRualfQgDLvFiCpR/67KeXPP9dE+8UlyByTCuyJs24V9NkP5uxhySzRBchwfiBTe
         m8Bo+EnJsjPBHGBl2gWtLKmJDIl0naXh0skOuOvXtvvprJCAjzeYO015NvnvDuKbitVn
         P51w==
X-Forwarded-Encrypted: i=1; AKwUvByI7V/VTj9mlkoIgoj4tc4LvU5E/2L230Ql9RVjYuTzWRFQ1+jNhJ5vjepJs8IWugJk4vY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw3YOnuNwhcopHim7NV30GYS606mn5oa8s1rgPWxMANrtGgD1s
	VAgE3g+dW1tOROOOeWmn3ilYY94PZvvjun4m5TSwT/pT2BSi4RIiOQ4D/ULxBdahz3TkjI5VG9T
	OKIUmw9C6H+mmiZ50H/8U4wIytd89+LcmnMmiWcSEKkInirzus3Ag3LMcKb6V8tYy4IHJacFnKn
	CfwEQTt4nIMil0AZsikYi5C2Qd2usw9XHm3jkiPxXpP6CHCR2BLXzg2qb2Snd6cAHdXtWrVD3vs
	uHW
X-Gm-Gg: AYBFou3/vuC1XGd8EUdRrlowUeDZUOM5j4uNNAsK81Xad+jRSjWoQ/YqihxbJc0p9Bp
	VFY11BQqGsxPWySVRYNLQvEctjmo+zUu2fgcHvNApDvp70sMFiUM5YOOIcbOmUJWM2S5K97WLoe
	GA9pgA/3prje6KlEts5hbqk6AZ/GA8Ft2/1FL/Boqqygxj+5b8gZ7GfQSnzcgfn6D0cYePi7lwc
	4q2YK5ZAvEinIeoQ6d7OEM2HEgeVQb31/AFGq8WM/i2LMp5wtZTnN70tVmzmzkI7CxxQga4h3ls
	hR+VRAFzafrDFf6J/n1diERNEScDUUli8mzQUbbACquK13emRjISM8RMnt+FDBs/zPU2oz9DRRK
	c4XD9fttHgO0IJYRhT2pJbOcO3TR9rbQftOT1rLH46oNirgUJ9akhY6UvzlDM3nYTOTgWFP7x7e
	OnaUN1rLIjEs2b8qUVoeig8y98euVjH3yK
X-Received: by 2002:a05:690e:1301:b0:66d:fa2:63d0 with SMTP id 956f58d0204a3-672ed8e3d6amr6457338d50.50.1790654597643;
        Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-67412d9bdc3sm1690040d50.1.2026.09.28.21.03.16
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33baaba6371so14196787eec.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654595; x=1791259395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf4+8fPuDTBmj6DTA0OwZVxSovvEfEo3g6LDTXOjhgc=;
        b=J2pFgVBZHM/fAYXBIqK0/AZxOq/6YSGIL/qKx8D5ACk4THDMXEn+y7CpCzCt8uAWke
         pNQfQ3sU+6Kte5+o+X5ITV615SfqaNQ48T1lR1rglF81HJ+VpKIsc+yJM51g9tVqknPx
         w3kg3JpDvpGwrexpl/4noHhn+sLyrJTgrO3HA=
X-Forwarded-Encrypted: i=1; AKwUvBwRyZp/MIlgKyQo8vmkrFIimC7QoGTpIVlDAiV9N7bhQ4E/9NAVW4GacJfR9gVgyEX9uAY=@vger.kernel.org
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863814eec.8.1790654595177;
        Mon, 28 Sep 2026 21:03:15 -0700 (PDT)
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr11863746eec.8.1790654594365;
        Mon, 28 Sep 2026 21:03:14 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:12 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 2/6] percpu: Bound decrypted storage for all x86 encrypted guests
Date: Tue, 29 Sep 2026 00:02:51 -0400
Message-ID: <20260929040256.543767-3-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

TDX also needs shared per-CPU buffers. Use X86_MEM_ENCRYPT for their
definition and placement, and provide page-aligned boundaries so the
architecture can convert each CPU's whole section before registration.

Define the boundaries in the SMP template or UP data as appropriate.
Drop the unused DECLARE_PER_CPU_DECRYPTED() macro.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++----
 include/linux/percpu-defs.h       |  7 ++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 64bc2bfdd2ec..145fcdbbe9db 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,11 +368,13 @@
 /*
  * .data section
  */
-#if defined(CONFIG_AMD_MEM_ENCRYPT) && !defined(CONFIG_SMP)
+#if defined(CONFIG_X86_MEM_ENCRYPT) && !defined(CONFIG_SMP)
 #define DATA_DECRYPTED							\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..decrypted)						\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define DATA_DECRYPTED	*(.data..decrypted)
 #endif
@@ -1022,11 +1024,13 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#if defined(CONFIG_X86_MEM_ENCRYPT) && defined(CONFIG_SMP)
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
+	__start_percpu_decrypted = .;					\
 	*(.data..percpu..decrypted)					\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE);						\
+	__end_percpu_decrypted = .;
 #else
 #define PERCPU_DECRYPTED_SECTION
 #endif
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..fdb666a1b4de 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -169,13 +169,10 @@
 	DEFINE_PER_CPU_SECTION(type, name, "..read_mostly")
 
 /*
- * Declaration/definition used for per-CPU variables that should be accessed
+ * Definition used for built-in per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-#define DECLARE_PER_CPU_DECRYPTED(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
-
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DEFINE_PER_CPU_DECRYPTED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, "..decrypted")
 #else
-- 
2.53.0

