Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514051;
	b=w0n+dNXHJ2S6YioOcXCl3TTDNwH9+i58+TuGTo3cfZdaZB1uUkcy9GtB0y3vBcz40SA9
	 NybYu24iT2pcvnciEy4T+uf+Ww1GU6BjoIynD78xkRmZ2KG7SjP8iiRvZUQz8FVjORXFS
	 6KDsmaEcYapyJj3QO3P3+2dA66la9Nr1cbxZR3hKadntl69ZAZtIstgWpoBcgdWFFQteb
	 X/l517WZn9gBYFNFYdULoPTGMNdi4EOxichJmen5Ot4Duud6y/8csEn+TL8wJD0+T7+r4
	 rF7D1+O+BcHvI9MgQ1UBmpZ69I9W54Cwpaw0EMe7jcx2EwOqcNXQnKvWEyPRd8KeLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=oaPJYRLQOnUXY3GkH7jTJTAE7Wl3NuOEbtsp4Z/SUgc=;
	b=Q7Z3AogUWs3s5KOrGKAiKL7EtxAG9VGk9EuMf1/ebnfgvZD4Pv8cUliC0VcyBnd7+Tds
	 fo/kcbPxxXJ6ePLbD3Tt4b7A0ZVKz+iVpqIspsjPP1BDahDGXJ2J17l7WLe3eybwBBLNF
	 7KwEWepmTl17hj7J5Bd3Gqj90NB4G3XJnSzzgkvil+Q6UdhuW0iLDaQdYjVTBAAlsZBnk
	 87iK8r4JYDpYU/wObBu3EasA2TIwPIga4zEqB5tbxq/r0vlDChsuVF9oJGRpkVWd0/nP5
	 srNqX33SlV1sGm4RFJQs1pLWSzWKtQaz5s4XFjsYdfSpLYM/S1SWnTPqi6KPOV3Nr4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BuQzGhTZ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58D606A324
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 06:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF58D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BuQzGhTZ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a190c53a3so2775329eec.0
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793514050; x=1794118850; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oaPJYRLQOnUXY3GkH7jTJTAE7Wl3NuOEbtsp4Z/SUgc=;
        b=BuQzGhTZI+KMKd3AqJd6tbk+GDDIKP+orSREe1lCsOFmj8e48N8Y9Bekm8LL28stEz
         jyQeNR07S3Tvvmxp324XlNxfmn109Gi4srlgUu5TBQ2bDryrhHvqUP7b2nChw5lHDEY9
         5Sq2eYfcmNn5nxp2/mdG2JmSQIrl8BdnDlchxIkfDjUS3ZFerQt+qN+cBONcQea9/eiU
         Lm82dTsu20HN1G6dPMDjADLzFt5QDU7yVavVfKVf6W218D6DhEbpryzM4KHZG7c7baOi
         MVXZYNGCSwC/evPXhieRFIxV1vOhKLQxEvfuavDyvg3oJ3wxqYWlHn5DTRCKmPsc67Jc
         YwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514050; x=1794118850;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oaPJYRLQOnUXY3GkH7jTJTAE7Wl3NuOEbtsp4Z/SUgc=;
        b=O0Jyt0/59K/lJ24sKFUuXRvjH0JQYOz+iCIGbML5rg2AgWkqfKzQI6uiiC+Y0Vc0Sn
         2OnHH/I7wQmoXPWewYq0n2/5mK7g0usLfGrtONiNQpzSbFLfX8vx/kwHC++JI9dTr5ZI
         rfg0ccenswCkNeV6jazfUzZ8DZi6HjHwrAFoyXk+CwnjukG3Yq6yNYhj1KjBgXoMsmAE
         V1U1247s/GjhZ8f9K6ntXVgTuoXB7Wa/gMQcje51qKq3c9ry2iFDAprP9+M1FSBqTcKx
         LtdU7+XcG47jYdoTxhUQWpkxS2L4vNgnGbQWtFxrs6ba6YSbJqgOB7RiQc7sos+yjFn7
         q8zw==
X-Forwarded-Encrypted: i=1; AKwUvBwSyv43IEP/vg2wTG7sC/odVBpA2XAi2t0AiDqVJvqLYMwWx1y9ug2rdN/fqHUgVb3lYmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4PfJIAepZNFGLdMvAnGvQswiBqthCr7WoE5zRmVxVdm/QB268
	tdK7kowmm0jIWTef3AT21DrqyYxg/hiZJMPQObHnzM74bnyl+hHndXP+E89zg4nmRoYxUuuI7F/
	qK2lmVwKYSuY2mdW8+Q/QMCXxUg==
X-Received: from dybsq12.prod.google.com ([2002:a05:7301:710c:b0:366:233a:49c7])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4715:b0:369:f17d:efb with SMTP id 5a478bee46e88-36a3002dfe5mr13291921eec.10.1793514049730;
 Sat, 31 Oct 2026 23:20:49 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:20:47 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261101062049.998160-1-almasrymina@google.com>
Subject: [PATCH v2 0/2] vfio/pci: fix huge_fault write handling and add selftest
From: Mina Almasry <almasrymina@google.com>
To: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, David Matlack <dmatlack@google.com>, 
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

Fix vfio_pci_vmf_insert_pfn() passing write=false to
vmf_insert_pfn_pmd() and vmf_insert_pfn_pud(), which causes an infinite
write page-fault loop when vma->vm_page_prot starts read-only (such as
after soft-dirty clearing via /proc/<pid>/clear_refs in CRIU or live
migration, or on arm64 without hardware DBM), and add a companion VFIO
PCI selftest covering both read-then-write upgrade and initial write
faults after clear_refs.

Changes in v2:
- Expand Patch 1/2 commit log with practical trigger scenarios (CRIU /
  clear_refs soft-dirty clearing and arm64 software dirty tracking) for
  stable backport evaluation, per Alex Williamson.
- Drop the Assisted-by tag from Patch 1/2.
- Add Patch 2/2 selftest in vfio_pci_device_test (bar_write_fault_after_clear_refs),
  as suggested by Alex Williamson.
- Link to v1: https://lore.kernel.org/all/20261024015540.538758-1-almasrymina@google.com/

Mina Almasry (2):
  vfio/pci: pass FAULT_FLAG_WRITE to vmf_insert_pfn_pmd/pud()
  vfio: selftests: Test BAR write faults after clear_refs

 drivers/vfio/pci/vfio_pci_core.c              |  6 +-
 .../selftests/vfio/vfio_pci_device_test.c     | 83 +++++++++++++++++++
 2 files changed, 87 insertions(+), 2 deletions(-)


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.385.gac671c819a-goog

