Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE66361965
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535158; cv=none; b=VJQH0UP4ttBZUru75bm+Qdpm9gXfC+gyP0XfA+RkpYJwoWr7E/rEqBUhpzkqe3qWEycAbedj+Ls9B9gYdsSJQ2K1Yi2/C6cVjrCQK1XKXg5Vp4M8cXn71BPoc9/G6vLjgGKwxo+7TjaPqytb5nvXQ1VB/fSbDrsOKli3aTdSd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535158; c=relaxed/simple;
	bh=LWc2s4qZvBb3TJVfltvRwFaklDcNXyLXGRlUr4C/OwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfQLGxRwqPhQ4pj7k4a5GwFkMjx6nBd4XVz1N3rGFxmlHeCs49TGHTncvhuuT4cdcSa+AoDVgpf9oOWz06l8nQrQjfh9KW8Xf1rBm1zZ56eqvL+xj+89x4q5cb8TUQh7OyIhsYRwbz9b0koomdtSTYXVeUfbmqN3Gh00BiLjvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AgIxbS4l; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AgIxbS4l"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1545655a91.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535156; x=1790139956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6awU6L1NSAdZve1Go4DAFmiBVEoVbQdcfNtuUS9ma4s=;
        b=f6o5JoEzyRVQO/aqSvXXwi+cAufEo6D1xBAx9IFsG0ef14QrxFQYBwRdcbU3TQJ9X0
         ieG/lGYTNlwG+k2jfwl7KtLYRgSpeAuWQChyphilbvJUWRO/rzsqcBzFRbbts7HS6lcf
         AxaTR+RBvGkuPCd+kXp+rGOO+/3aR8aUnanxaRXZ+6s68q96OyDZ87ilncx2asTIZ26n
         XqBus9iP4wZUNqUfmjhAdukeEdjqdecADpmYURlkxsVkzpNGRCF635slkwZ/Ia5pfqer
         /F/sOUqN84ZQ4/pcoUXw+9GfNq9mRu4jkx/2XoY3mQLBOXTfZtYvXBDv/ye69XAYlz2a
         2+hQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/jykDGw5y/lnjtsZMXtSpOFdPldxoheQUmZrZ2HCwP85kULk17lVZq5EERu3+9Ykst4s=@vger.kernel.org
X-Gm-Message-State: AFuF++kzrO+JlFvfNadEUft5U5oF1saAjmJ9Lo6a6ssRnEGLmMRJmPPP
	cmNi+n9wacbsmexydDaNk3lSQBZMOnP+FsJR+1lcl1mBCKQJ5WeTBHV1kYkiF32acINfv+3o0I3
	s9GrZaVt1rb5/PKM0QpLAQ08MgTMp7ifVDwifTAyvUSrZ/PwUedeLo4VbNvEl9fFkt0vp0iXpln
	fTMVbqvYy4LLSg0s5uAIzTPTU5Cl+JnC4H1AbmUb7234qoKjryhelZWsm0wa90AG+i1g5jTr7Rn
	b/F
X-Gm-Gg: AYBFou2Nh5xSiC2r7kXPNTCIHj5Ochljc1VJqlFJjbHWjjrT5SBGvNiIgNdJWTDXVM1
	oUqPq8U3v97SsQ3dywkCHxE8sXNVeX7BlGFdo5YNcyU+K0EiFmVRgVWetUYxmL/dWQuhmfaQVGq
	+B9gDKloTCQJF31wGy5/luim9vsqmd6qWPzBL0F0CsSOq0FoQppJp3ypDmh/IKv2tqf90hmIA1q
	p+SUHB62kLLpIV20yoB/UyXoTQpzeHONKDrOfC5KdEpDZ2kd7SjGp9JWrru6X+KUU6ikb1r6Rl7
	nrmq2WNQCqDYpmL9WvlQNpfKGARuyoXfjsi7A5RkxwsRL6EGAqLJqNl6I0GY3wBFvPIrk40f62F
	oluwoKxKjK6NQYmkoeJS8yreIKHxYTJR1FXQXJJsSea624MV7vJidbn8WvaK0MGG6IKaOWIsl9N
	X9EYb0afyxHWtRYMXFTZIpHsFnKm+9f2kMgjs=
X-Received: by 2002:a17:90b:274a:b0:39d:f2a1:31 with SMTP id 98e67ed59e1d1-39e1e489a60mr2988814a91.17.1789535156127;
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e1c320ecdsm155939a91.2.2026.09.15.22.05.55
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc489e7a701so7503496a12.2
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535154; x=1790139954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6awU6L1NSAdZve1Go4DAFmiBVEoVbQdcfNtuUS9ma4s=;
        b=AgIxbS4l+sMGzOQKUymNIgMNamCZBEsk5FlD0p+PGzS5LljSWOGjmA8Qbd3KpX/tGK
         Ga9JsNwG9oSpFcbKpB7z/4M7GGHaU04iUlAhCCTyIFsJLRXbRZ7XHhtNcme5T5sNuCN0
         +CiXxYnC2nhU2Cy2+vrjWZjf/EgUCPiN6Zb9I=
X-Forwarded-Encrypted: i=1; AKwUvBxIBVzmGL7MxD5Jrw3SiaLmWTBRHeojnYoaz15EXQfP4/Pc2ZvnuRexOg6YwJ93f47Exuc=@vger.kernel.org
X-Received: by 2002:a05:6a20:4388:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dd5f57bbfamr2773505637.17.1789535154006;
        Tue, 15 Sep 2026 22:05:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:4388:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3dd5f57bbfamr2773437637.17.1789535153567;
        Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:52 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 1/2] percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU data
Date: Wed, 16 Sep 2026 01:05:39 -0400
Message-ID: <07cdda86e2c60b27a18023e2e5fae339b78db0ab.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789488039.git.zack.rusin@broadcom.com>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Decrypted per-CPU data is gated by AMD_MEM_ENCRYPT. With
INTEL_TDX_GUEST=y and AMD_MEM_ENCRYPT=n it falls back to ordinary
per-CPU storage, so converting a variable to shared memory can expose
unrelated data on the same page.

Gate the declarations and linker section on X86_MEM_ENCRYPT, which both
AMD_MEM_ENCRYPT and INTEL_TDX_GUEST select. Existing AMD configurations
are unchanged.

Keep the decrypted subsection page-aligned at both ends. The per-CPU
template and each allocated per-CPU unit are also page-aligned, so page
conversion cannot expose ordinary per-CPU data. TDX-only configurations
may need additional space for this alignment and isolation.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 include/linux/percpu-defs.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..1448e791773e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1013,7 +1013,7 @@
  * Note: We use a separate section so that only this section gets
  * decrypted to avoid exposing more than we wish.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..decrypted)					\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index dbe3267a0a13..54ce1442d918 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -172,7 +172,7 @@
  * Declaration/definition used for per-CPU variables that should be accessed
  * as decrypted when memory encryption is enabled in the guest.
  */
-#ifdef CONFIG_AMD_MEM_ENCRYPT
+#ifdef CONFIG_X86_MEM_ENCRYPT
 #define DECLARE_PER_CPU_DECRYPTED(type, name)				\
 	DECLARE_PER_CPU_SECTION(type, name, "..decrypted")
 
-- 
2.53.0

