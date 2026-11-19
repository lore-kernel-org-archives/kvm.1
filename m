Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114638;
	b=fKeIzd6tICxNO2LsF8fFAL7vf+Me9MS3moVjcNFtnYzzAOBeG0jPbV8odbuHKftOY0TW
	 KaXHvSgKIg/UkJqidcvoSfaaR8r1fztk4lparL2S8lpCRhjBaHqxQlWkUsWSbD/2j0Mad
	 0U8Dk866EwTS1i2jWfBnSpMqqIYQK2bXbAJO+DC2ozeUYc+dZj8lHfA9472vR9YFn2QRx
	 BbegW5n+aXtuhYiR4NzYvbG6ddeEzkodssXWIKsrkipYN9RA5a/0cJpu4jR5qy0+zYJdg
	 vJ9DXBbL5nlX1NN1vEcqts20S/pyz83Br+kIpyNowvvIxQ/jC/r66eeQ00Hrb7wHYZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4nUk75+/T7kqFWG4XN4uMnU9rM87IXqXi4lX2hVLCCo=;
	b=ZNDnmLwFt4A4ypqDG8pEHqbujhfcFVPJ55/XYFRDwKiBziOsW4Phzv3XHRl/HpxL9+JU
	 /+D19b9+KdOTc2FsqXI6Yxp1iETkV114vRTHe24g2xTZVnskYtkKu/JY5DhmpAKM+0c8P
	 Rbc4s/FUoGOKsDWpYbMk4UOdlBSuWiN6pUvpdtUa6YbDeFi+iX62mt3dAQanPVuHZj9s7
	 Ol+VDhCwMQgieuIKCReLr9uXtR92mhVGVRNdFcpjF+smjy+k1k4sqQOGBRsrRwSB1LE4P
	 atniSI7DvIGIOKH4z2E0NSe4AMpphh3NwRSX6gdISZzjUnZ4+Qn70tN5PRGe0GBF86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gawHIi1n;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032B606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 18:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E032B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gawHIi1n
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b29df78132so79537c88.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114637; x=1795719437; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nUk75+/T7kqFWG4XN4uMnU9rM87IXqXi4lX2hVLCCo=;
        b=gawHIi1n/D5J2IXkNe0LBUVQSq/I7+gpaqDmVDfH4jFB2N/g1nzOcSezln+lOS5FZ5
         OJPtjsU2LWhKqi8K+GfgE11JI0cMXqRLABhDL8TpnovYqNL1RAdVI87GAt+S7GB78N3V
         zEFAveC5Be8IJpAJioQd1UZMTRluAOJ0h+VHADxKw54OV+ZFFo9cmnh/y55/PhJFbpUn
         1zDYv/aziwN5CmZIdzDdTCKBUIOhZ3zcreZpede3rOF2Wg4NpNmr0lFFf6uAMCl7UT3x
         35Q0KK5L64ZojdjJYtOVMVboa7QPabD3BbiD5HKjKNt4Epptiw0OP9mhXoTHrB0l9xT+
         Y/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114637; x=1795719437;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nUk75+/T7kqFWG4XN4uMnU9rM87IXqXi4lX2hVLCCo=;
        b=lUBracaRnt3vZXaNsnqS8hDRBdVDtMsCed6TwkS9E0DuN0xFXwSE55hbk/rO9GAvwf
         /bIxtogWUuU0m6GxAZMJVhH4FaUM6xfn0SknLg4AghskmHSMeZKQ6ezq03DU9JshYpY7
         Ow2hBNT8QPeOnkxRwAgRX7O/EQelLOBHGtivEJOwlZIN6WC3HLLa+NcOD6eXggpgigKk
         YOLqPVJbKxRVgsaquiyaWk2t5eb8bYgPdgtqIcptM+8yyHZh1UuG2RkiN8HHUDtxxCWw
         Mlop239ZGP/zYPFV9VBYDiGXGwpx58GyW+wzQ6BdT4Dxf47ig/R4uk3+RRF2kjySngEP
         NZ4g==
X-Gm-Message-State: APuU4Z9OMclO5Wk3B3x8fbeNeCgoY2EnSXclMYFgP5zBUa2wvP/RfEHW
	ef5nrVyyJSuiksOegmlgxVmTG1I2WyQkfhDn+/HuPnzavZtx5R60lAZacNolNiEVyG9oZLGzIFZ
	7Z52UKdX6RKT7/tGQ6CJeD7pzyjrdvyape2xnvzR99r6nY2YtX/5PMIAZOMY3ETjjQdLhjW8OI4
	EKAkRQseazfHFF2JtT76HCukkbSho6bvP1hWVquzm9UFJJ8pEP0IDltQ==
X-Received: from dlam19-n1.prod.google.com ([2002:a05:701b:2093:10b0:1b3:a015:cfb2])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:b902:b0:193:7fb5:2c3d with SMTP id a92af1059eb24-1b5568ec163mr426738c88.21.1795114636460;
 Thu, 19 Nov 2026 10:57:16 -0800 (PST)
Date: Thu, 19 Nov 2026 18:56:57 +0000
In-Reply-To: <20261119185659.889654-1-aaronlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185659.889654-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119185659.889654-2-aaronlewis@google.com>
Subject: [PATCH 1/3] vfio/type1: Skip reserved PFNs in vpfn_pages()
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

vpfn_pages() is used by vfio_pin_pages_remote() and
vfio_unpin_pages_remote() to count how many pages in an IOVA range are
already accounted in dma->locked_vm via external page pinning.

However, while vfio_pin_page_external() and
vfio_iommu_unmap_unpin_reaccount() skip invalid and reserved PFNs when
accounting dma->locked_vm, vpfn_pages() counts every entry in
dma->pfn_list indiscriminately. If a reserved PFN is externally pinned,
vpfn_pages() reports it as accounted in dma->locked_vm even though it
never was.

As a result, vfio_unpin_pages_remote() inflates locked_vm when it
unwinds a failed vfio_iommu_replay(). vfio_pin_pages_remote() would
under-account for the same reason, but today it only consults
vpfn_pages() for runs that start with a non-reserved PFN. A subsequent
patch removes that restriction and relies on vpfn_pages() being exact.

Check is_invalid_reserved_pfn() in vpfn_pages() so it only counts
externally pinned PFNs that were actually accounted.

Fixes: f6c84a52cc41 ("vfio/type1: optimize vfio_pin_pages_remote()")
Fixes: d10872050ffe ("vfio/type1: batch vfio_find_vpfn() in function vfio_unpin_pages_remote()")
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f7addfbe1aab..7bad0508dd21 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -641,7 +641,7 @@ static long vpfn_pages(struct vfio_dma *dma,
 {
 	dma_addr_t iova_end = iova_start + (nr_pages << PAGE_SHIFT);
 	struct vfio_pfn *top = vfio_find_vpfn_range(dma, iova_start, iova_end);
-	long ret = 1;
+	long ret = 0;
 	struct vfio_pfn *vpfn;
 	struct rb_node *prev;
 	struct rb_node *next;
@@ -649,20 +649,25 @@ static long vpfn_pages(struct vfio_dma *dma,
 	if (likely(!top))
 		return 0;
 
+	if (!is_invalid_reserved_pfn(top->pfn))
+		ret++;
+
 	prev = next = &top->node;
 
 	while ((prev = rb_prev(prev))) {
 		vpfn = rb_entry(prev, struct vfio_pfn, node);
 		if (vpfn->iova < iova_start)
 			break;
-		ret++;
+		if (!is_invalid_reserved_pfn(vpfn->pfn))
+			ret++;
 	}
 
 	while ((next = rb_next(next))) {
 		vpfn = rb_entry(next, struct vfio_pfn, node);
 		if (vpfn->iova >= iova_end)
 			break;
-		ret++;
+		if (!is_invalid_reserved_pfn(vpfn->pfn))
+			ret++;
 	}
 
 	return ret;
-- 
2.56.1.708.g77570a6a1d-goog

