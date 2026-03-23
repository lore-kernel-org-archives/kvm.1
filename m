Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1E3845DE
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310328; cv=none; b=r1KWUakygNBLJn1buu9j4uJ9bNj+p1uOZqaACAXYVlDYXXKCfnrx0j7chcsOb7ZTSctzG4Y0jaYTY6G6jrlhoEECbn4VGO/m+5FT+/3lPY+AuA6gIHQniVd09t8OyFnAoLzgTfgv2Q3oP5xtgRWzg0A/tFd5dZoALBvD3CmC8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310328; c=relaxed/simple;
	bh=nufixlrxKDA9RxLJCcKgJiD/jb0wnKOqEaMV67UGvLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RlWYdQLg8OjAdtMXMpslTPJuSw4aL/5bYXaECRacOZJEOBtonMTVb1hTsjrdGVpr7vCwLlZSBhwARvYSW1qZYkdPeuVjDfG4nGCDQ+qBf0fLLOsYkh21D6Qve04iiLvp+N8u8D1cP2iGKQ/4kKtyrsN9Q+h3IXm5uUTX0iWh/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmziZylm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmziZylm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso1042954a91.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310326; x=1774915126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z81MLxHKunKSpfd9G8Gazc1UStxzf4ZSRozQrfTx8r0=;
        b=cmziZylmbR22KBlTJw3YBAD0h4KEiYTt9tBnAaZDYK37JZj0W6BZyiNKKc9M3n7I5r
         /WHbloHMOkUlcII14sI7xSLS05UQBchd6XAG+EvifXbxp4mUSH6FGvpCeef4YkYJUtjT
         lgJx1Vm593wZZaOxauARkMjMgMWvaAwjiEiPfRBD8RtAmPrmSLv3TYRfkzFuLtyEPyIq
         FgAF0zDle4ohJPldBYPAibP7B1s1tv20mQ4QDNQPL/nazzyUHuF2urlQMN0iH7TbNIzb
         FDO9Pze8JlqjHWUpv2Xt+M5cVeJS7OQjjr+WZP4WOPcXhsYY1VNek09kjKM6dTUxKvdq
         ZSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310326; x=1774915126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z81MLxHKunKSpfd9G8Gazc1UStxzf4ZSRozQrfTx8r0=;
        b=OETrJ5SjWbknZGkS1uBxQNr0fiVxEcJct4bFqBxMkrZeDvGhp7h7li4UC2uMt+ujQr
         3BAMgIo/iHRxAovCltuPFNP7slF7v3utYaRNpdb5QXFfq9Wr7eb2TJyZ1Rzj3KUS9bE6
         B83MHsfv5LaiyF7yWbTc8Ejar/8iuwLCkpi7Rs9G3OIrX/00sBFveyERQ3g6oiaEKiPX
         64SF6yOLyE1jGXAEfItB4tOUjDqEJHN55/MZQatIatvUFqOCkQuTu9rH0+gxstey/57M
         Y7Fy8bYXQPOTbjIwHccQLf/FusGYL/zOvwi8TVqWNCzIjwcBHGV9Kc9MX7oHdntLiZsi
         w3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWHKCjRD3DHarIRZqNKCvskP/gNF9x91ZszzEJ/1Yb2OcT2Ans/Nl0bJTCd5e6gC8jSQTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFU/23zGosmd7HVhCuMasf6ZUf/IGFNLum/71SaBZKhc6+6QEG
	dA8/VfR5FRYcOuMimoCNoTqfm5YjMKY65ROF+RK7/8k6NBg22zsszJDIVHmTT5JgF9THZ73aAGL
	wkjmJY8Zse6mkWg==
X-Received: from pjbfs13.prod.google.com ([2002:a17:90a:f28d:b0:359:979d:cee5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5390:b0:35a:275c:4c27 with SMTP id 98e67ed59e1d1-35bd2bba27cmr10391028a91.2.1774310325767;
 Mon, 23 Mar 2026 16:58:45 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:57 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-6-dmatlack@google.com>
Subject: [PATCH v3 05/24] docs: liveupdate: Add documentation for PCI
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

Add documentation files for the PCI subsystem's participation in Live
Update, generated from the kernel-doc comments the code.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/liveupdate.rst      | 23 +++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..04c9b675e8df
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+PCI Preservation ABI
+====================
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..d56a7760978a 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -70,3 +70,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
-- 
2.53.0.983.g0bb29b3bc5-goog

