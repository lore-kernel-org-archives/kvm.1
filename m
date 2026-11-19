Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114636;
	b=yL0XFYf4uOZrPm+ozDPVW6gxRXCmELJWRGNN/leXZ+lSQqd9vQ1Kz8lXfL04MKKRE0Zx
	 8BaihntM5G5v5KI+iJM3bkZpdSvew1bCPCRK94E6h06FQt3YE1ljdhK3LNawO/5Jqgwii
	 bUuvIj6zedbNE9LDBL7x22Bg/ae+wBBD7UIgkNp4IkGrjjOI7N6FgyvBPdO35EZ4MN5A5
	 PVIpbW1MxXDPxquqBXqtiGtSpkB7gvqo34Q95nTulr7fYlEn1+wvGduTMnGkeQnHxiTz/
	 y+j9H1RG3rFumdnb0jWhaJsZUEYs/rn7EIKa1ZMnbH8bNg79trYJquWWjAnr961beog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=2izJfUDs9XTGz3sgeKZakp6Bf+f7RLOVt6c9wC6F/Qk=;
	b=Iyj1oYP4TpmmuxFbFK02WVWZXc0jQC8tZYcoAC+it1Li1uPkUabdLVH9JhPIi0ca7Gti
	 qJajoXAi7JCefNPNWlcbKG896FY5UnlXxp6ihU5jGIcUjMYf+wg/HQMBZC7+v/Qxrp8Zb
	 KhscFTqPlFFTtqIt4YyimaCnNSIgbSfhDOGWyiu2lrB0EeEgfFaM5P40+PF0OA5S1XhoH
	 4AppnylXg04ULVxFHNCsz7dO1tCXnpZOOhkw7H3zl5g4V+KOoMbSZdXg5KQ1Rqi3OUcso
	 pnx+h7wwoc37mwlrwqrWhR/VjqzBjyjHCqkdAovDBMlkwy7NB7IqHCRrC87P6OdxVgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EcOvIMqS;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88552606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88552606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EcOvIMqS
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b25d977b91so90480c88.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114635; x=1795719435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2izJfUDs9XTGz3sgeKZakp6Bf+f7RLOVt6c9wC6F/Qk=;
        b=EcOvIMqSTYHDHeCBGQIdSOQ1oDh+nL6nhGewobYSQFdUsefTFJ7SW8XtGIWz43QXP+
         CEP3fh706zxLtd6iWpp/huOGS4z8h9UoKeAdzsSLe7ZKG/exEm0pueKzXWw5D6kYogsu
         v4CyFN5LmRG9uVxWK/VltDwwQ5weqQED8kEJgaL0RIGipCQSblZMXjqpo4uIcIDCuW7T
         lLCApkf29TVpZqVovMlALAMDehCnCW9u8NO2uaPe3Wqxdr4hhEf7088TeJTIQlgP0/nC
         pIOPxhIulhaHcuQ+OH8hCJkrsSslLmMPKNlmu5G392btKZuTXPsOEB4w4LwcE0SAso5g
         1ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114635; x=1795719435;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2izJfUDs9XTGz3sgeKZakp6Bf+f7RLOVt6c9wC6F/Qk=;
        b=H/75lzvQYCcObomWewOL9l5C1e6CHAMUEDz4Ss96Vb8BtcH5Wbw2fM9YtxFEG6NNvN
         Cvc/O2RLxvskso1X9jphxMMnvCqgfFn9BkBptrMuCrvb1SiCgoYrNLJPgFBvx/ENc6z8
         ghrh9XYIwlMeWaVGNTf0eiO0xTqu1EeiyTmubdTqqt2EWtd3AvNBr2yyNDKIBCyS3+61
         rA6GQYe1DDUxsCFApSvWonDwtpMfm//ChB9w4g0EdwPy+86QLgQTh0rAb6eOiBgCkguL
         cbzU1AmHBNsYouCkGQtE7IJlZKhB05AI/TdVP62kxHfnc3iVtd/osoWOvJgtCQUbSYs5
         /QUw==
X-Gm-Message-State: APuU4Z+K5XG+b5EHxy2sfrmEVQ84iUNB2Z8Ml/spmIqTHleywou/z9bi
	+ocaKyc4kWMHb1jBCpRvYByLZEdlPaW7Jge+pfpsZRf/95hBpJtkt8kJJpKRtu0pSpsKNSPlM38
	2pMEs7YEE3f1IhByDvLd4WIz6t+KNuScIftC32B1+gzN3fKLnvARbYiadmF/qjAlynD0RXR6wxE
	gaTGJAsxATrNSU3hHnhgMY3zs8bQPSTjmajuRAezK/eIJ4KjXNsyUO4Q==
X-Received: from dlai6.prod.google.com ([2002:a05:701b:2706:b0:1b2:375c:814])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:170c:b0:1ae:59d6:91cd with SMTP id a92af1059eb24-1b5568f522fmr390300c88.38.1795114634135;
 Thu, 19 Nov 2026 10:57:14 -0800 (PST)
Date: Thu, 19 Nov 2026 18:56:56 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119185659.889654-1-aaronlewis@google.com>
Subject: [PATCH 0/3] vfio/type1: Fix pin leaks for reserved GUP-pinned pages
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

vfio/type1 uses PageReserved(), via is_invalid_reserved_pfn(), to guess
whether a pfn was GUP-pinned or came from a VM_PFNMAP mapping. Reserved
pfns are assumed to be PFNMAP, so they are not accounted in locked_vm
and are never unpinned.

That guess is wrong for reserved pages that GUP does pin, such as
device-dax. ZONE_DEVICE struct pages are marked PG_reserved when they
are initialized, and device-dax, unlike fsdax, can be long-term pinned.
When such memory is DMA mapped, or pinned through vfio_pin_pages(), the
pins are never dropped.

Commit f6c84a52cc41 ("vfio/type1: optimize vfio_pin_pages_remote()")
assumed that long-term GUP never returns reserved pages, so patch 2 also
drops the comment that says so.

This series records how each pfn was obtained instead of inferring it:

- Patch 1 makes vpfn_pages() count only the externally pinned pfns that
  were actually accounted. It fixes a locked_vm imbalance on its own,
  and patch 2 depends on it.
- Patch 2 tracks GUP vs PFNMAP per vfio_dma for the DMA map/unmap path.
- Patch 3 tracks it per vfio_pfn for external page pinning.

Two things to call out:

- Reserved GUP-pinned pages are now charged against RLIMIT_MEMLOCK like
  any other long-term pinned page, so mappings that used to bypass the
  limit can now fail with -ENOMEM.
- A single DMA mapping that contains both PFNMAP and GUP-pinned pfns
  still falls back to the PageReserved() heuristic on unpin, because
  type1 does not record which pfn is which. That stays correct unless
  the GUP-pinned pages are reserved. In that case their pins still leak
  and, since they are now accounted, so does their locked_vm accounting.
  Closing that needs per-range tracking.

The DMA map/unmap path (patch 2) was tested on vfio/next by adding
device-dax and /dev/mem mappings locally to vfio_dma_mapping_test:

1. 1GiB (262,144 pages) device-dax mapping, checking /proc/vmstat (after
   flushing /proc/sys/vm/stat_refresh) before and after running:

     ./vfio_dma_mapping_test -v vfio_type1v2_iommu_devdax_1gb <BDF>

   Before fix:
     nr_foll_pin_acquired: 27471 -> 289615 (+262144)
     nr_foll_pin_released: 27471 -> 27471  (+0, leaked)

   With fix:
     nr_foll_pin_acquired: 18786 -> 280930 (+262144)
     nr_foll_pin_released: 18786 -> 280930 (+262144)

2. /dev/mem (VM_PFNMAP) mapping of a reserved physical page with a valid
   struct page (memmap=4M$0x340000000), confirming DMA map/unmap still
   succeeds with +0/+0 pin deltas and no unpin warnings.

If desirable, I can add the test updates to this series, though the
changes depend on host-specific device-dax paths and reserved physical
addresses.

Aaron Lewis (3):
  vfio/type1: Skip reserved PFNs in vpfn_pages()
  vfio/type1: Track GUP vs PFNMAP in DMA map/unmap
  vfio/type1: Track GUP vs PFNMAP in external page pinning

 drivers/vfio/vfio_iommu_type1.c | 147 +++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 60 deletions(-)


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.1.708.g77570a6a1d-goog

