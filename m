Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B72882BE
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338183; cv=pass; b=gC2IXnp4f9PuGMmA0QTcdJofqACJR/ueCiCt72becgOh/UgR7ASHNUlOym4facOI/QP9jOUYZDsc6GcOVofuX84JZvV7TlQO4xGNli+lYVmtzuutEa0We32DPQ+IF+Vr4dTp9X5rDUms9LqAf+xKiQmKM9At2mCd48B3lL8JCFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338183; c=relaxed/simple;
	bh=O1T7BsM1mJR790dEAc6emGIwnJEEqVArxUUj+UuSsVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gpQolA2d10Yi+dEe9LX2HlQs7lR2hxMdg+YAZy7rd20z0zt50QbK9D8Lve+dDNzBnkj+QTGgxEkd+rWQdaJcpqMkDSEQ4o3y8rQSo74NHb45Zfju9dHARzbIP8JYzydX7QOAU57bHdAc1HmRD4P6u4dqNhXSCEMXVHPjZs+emuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln4PsI+r; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln4PsI+r"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7fe36f1be74so19809147b3.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338181; cv=none;
        d=google.com; s=arc-20260327;
        b=SNyrF3DvB2K16ML/8urbN0FA+mnSLtfjce3Uob2ivLSgM3wGm5eDkuEvwJW2sIt3Nw
         /qu15fSLZzrQOmAo4doUDtkqnsTMlI/ee5GST9rHSsJ3kORdfbbRAekfXkGWUjXqAj6d
         Bg5clTJHDwhdX/48HfxKrbX+myEUGQKgKXYbhcI709v4RPp+QI4JRJ6bu4/IPQAXkzV/
         eG+c9Q5UcgJ7VySnH2mIdY1oESQbIDbL3HIr4vnq1+OrT9wB6eDV2IyOG4FulAqp8WJv
         Cso8m979FTEnLn+/cu6T5dJMAnINGfp9zfeKEtbilEFWXT/72NMlzdIlErWJfMra0cHc
         F6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        fh=xc2eALkLyu/79v4P7ONAVaYK8ZG68T84O7ikAdq+y5g=;
        b=hZUiq35tjqAbHtOb5QlGUU874iDfJyHRdVodiNCVJ9+7u/AuzpXXatCpblpQ74mgst
         7aka+XtucHKK3528+XgOI9NF58T3nPJhfSBR/Q9XqxtCvyL2ENJzdaT1oe3+L9SxIjEq
         1047oW76oe3g+a2PBIOR2u37kAkUgxPO5CN9Nm7Dy3xw8SAUQ/svZbS236beqUzSCgtM
         iEtF/SM6IcY/eHLEiosaS3wlHAPEfvoDAgaBNGZTbJJLT0G6DiIoIvhopU0Fxw285ykf
         pFJSE7TpkukYZ8SKU03AdCNNRMp2iteLNfjl2EeEF6sfvJirR+dO3Qwo5ZRZoTEoUb1K
         Yn3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338181; x=1782942981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        b=ln4PsI+rqtXHS3wnZsR3Et7kSgmam43rF93aBQkrqd/QWwqExuOsFcNI0u69eJD4h+
         Hvp67N1n01WntAfy4NcJ9x1piKTk1KGpz9kugi16OuyxcTM3BOkfOxqmDeDDPshmIHLU
         ml+jY2rXCjfr1dzchYrnSGmdOXoEcyip2/p0enklvUeH1qL45QJ+PII7IS2WObzL80Yo
         TbMF4ZQsL/zQ/RazEFLVFymd1Fq9iSbWOcHpsA436NOnR7ZTeMX3B9XLL3yzIZ+qKp9v
         +RJbR3++4VbSJwJTySRuv5Ds5zeHLtN6Be/iRA4l6RLAoyo8nVn9wEvKEnRyIiD8u4kG
         mI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338181; x=1782942981;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        b=cbvTiqZyl6MX88AdpcQs8o2owd2pxdmQpa1ONbFKIh26gq0Y97BDCluJR09H98Qmep
         qijIFEmw+75RxzMiDbyYzLsc6RfMvVTBQ/5FTPpYlLbJQgvUmfYGkUEBDd4sJhNUK57Z
         lPhUvw7cP4h3KdTj8Yp8bNCQtkefOIw5LbCvUKwqcwIQvde/eyt0Y804jG49pv2WqTkL
         4zhUf4nRZgs8T9FQdRMyo7vzxng9RmA6MYR8N5kVVvNYvJcFASt/6gitYvBuANCi5oLk
         oJIDICwrMD8rNDQh5WCJNaPutvt/+UWPz8SmVj50o1KpYoMJ2Vx1pziz0scl3Js0vKxF
         yGuA==
X-Gm-Message-State: AOJu0Yz3HY0myI2iiJYd1ebm11H9+3nVO0caTrX+KzVYL2OwjE5iYzB3
	5Oj6I+vRm0l3Lfhg2CWoSnKFZBOSa27o34ow+aIMVfpFKd88CisO9RXLa6mHLwCVEkKFkBeCbCc
	ATnTdGjkzspoOPt0wCABjPEcgcMTeQQA=
X-Gm-Gg: AfdE7cntfT33KJnWJmCBTvD/FBAUlIj4jH7v2PVGha/9ERgwKajeoF9/zX7r+FluSQl
	PVrnTAR5B0A5i4HQGWj3JdaM1t22T3xIAw9LMuZmLjcUDpm7wcI14LsZQsLSXdhmHRSnm9sa3tD
	xDihyalr9HlPX/zTdpQhkXe/k1yMUaZKfvd4u0n4l2lOr5VrOwmoB8Xs6w9SNhrHBsahYnMhQdm
	FUJwR7sJ1WfQ9N54Wom8149CGELdMkfGnGHB4vZ/8bFyCZBhoxrjBWinCsJOLu92CICwaVs
X-Received: by 2002:a05:690c:e17:b0:7fe:27a7:1c26 with SMTP id
 00721157ae682-80a678089ecmr497127b3.6.1782338181128; Wed, 24 Jun 2026
 14:56:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:56:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:56:20 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:56:20 -0700
X-Gm-Features: AVVi8CciZ2XEwtuWFeWZQavetqbmxlWkUIUYW-f6jq5xGyaQanvMGnD6EWJ2eVs
Message-ID: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Subject: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on 32-bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the unsigned long page-count calculation.

Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
vhost_vdpa_pa_unmap()")
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v3:
- Add the Fixes tag.

Changes in v2:
- Clarify that the overflow is on 32-bit systems.
- Drop the unrelated memlock check change.

 drivers/vhost/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..38b28ed3d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;

-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
-- 
2.54.0
