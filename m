Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C472517AF
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338526; cv=pass; b=DLz6QFS+0XU9KbENceJYuUTB9oWy5B28I9AEeYSHFhNV7ayAVK6a7ZrNH/MSI+uS1sROGGFLbdN2NPeK1I7xUWNh+8hU7QakDkNY0MgtS7PHDPlEZ+gMJmDHIciTLslV4rDXK7gsxgvmyv6mRjFGKxSpzFz01N2bQ191dUWfxHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338526; c=relaxed/simple;
	bh=7lfnvnV3tDsdkAeD8ENY3TZFcgviUe6OdssAmRPb6ME=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EwmFvdsfqzERsHsZJs2eR0O60Ng57E0kHWy0Finzw5ePthNaFzjbCdS+1p2YOmx03o9FI8lH/vwFHnEneeeUYUhkBygkwYB1vQcyw33QAGbEdwDlUS3WIKUIkodEiIKNEtTPYIsMWeZWJyIzCu+BiVhidFkBuJY2YUuUVQ1LwPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYTEBVPv; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYTEBVPv"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80814edb536so15482687b3.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338524; cv=none;
        d=google.com; s=arc-20240605;
        b=FpRNDfdX/cupKeXn1/tKGL/UXnxPw3iCerH0523/7GqoPq8LEEzK5mDNNH4l3qYEBW
         gpHgXpCTD/6p+TGwziFxt6hK9yGIeTnxiNx3/peleEaZfiQ0dXXLO9lZk5ya6JZJgAE/
         Wo0MUbdwieGJ78APGJcrN9ANGSrXpMfougpIK0CFBMI0BdSttA7BKIuXT285+q8zU+Ng
         1UK/mIm/0rAi9aTlEiTvgH+jZJkAJev24jhxfA2cuROj86eQ+V1KEt+oEPvZa79rF9sk
         Qh5WPJ3natyqQ+X2AjDe4S6++HoUlq65JjVGW1hYoZOAzuEYZ12D8oSeY2w9SBANihg8
         87+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        fh=xc2eALkLyu/79v4P7ONAVaYK8ZG68T84O7ikAdq+y5g=;
        b=lVkd1jmG8+yMd7WAJXWMtfTUapOFVvbA2WZEOxpieXv5aistJVfJ5EUTQXpWEqcu7P
         Nt5Ypeior4+meiK8NiOE+GvzF8kPj2tK7f9vZEcBFRFmj2IIanJbkYaECHVPV/307FU3
         anKYNgasZ2uWjkl1dn6ZBDvRs135KhZObFiNMaZJ/rnx6h+k+BIRWwldJA29kL0KfswZ
         kgK8O6hr+2cRBcwWiywgmvbp1h8PhnJoHm2H+hekY5wHr0W36/lZWgnMo/qNfPdwkHsH
         VCyzYJY8YuD3UFYWmLzNJ2xSrde4dxq5BQhW4JE72k2fZP/7+HqAWZzBzrohWkfc8avo
         xvrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338524; x=1782943324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        b=jYTEBVPv0Lq8+4hXuCybKJFhzU+GYv4nB7+oPItBwyD2Iy10+tL0hJhfAnIJPSvb5W
         nmSrzJImS6MvubZwWAFDCYrygJpoXiYK7ArvsqQzsK5uh3Jxy13bJfId7rjPLQ/yph/A
         tVbq7Jc1j8IEauss63loTziXBGbXib2MWMy7j2CmctutcndasghMnL3ofkZz2zdsUJ4v
         mbwNoYlEj+vuW/6tledvCuf0s7e6HGq6Cp0768V++FKwpQa77eheIwfmsq3Hua9oGSUT
         4YTs7TCyoRuxOtuM7XHy81zD4z2aC3J7mwGrff57hjudeYqMDBdMAzCJHiOXJ2XuG3eC
         eVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338524; x=1782943324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        b=KufdgtlbcoXJjecc7urGRC4fyIKnU59b00fLDEc5uzfKaTNyO2WciplszEgsnEla8q
         6RU1fz3vvPqcr9Mw5cvyTlj586opwinFogxrDSb4ihqiVE+rsZR2ZtAb1FLwJoe/aSJX
         lsz1Nxwf62A/0PTgr5bLJdXyzOJiQPiiapANnLuobNdEbiOxq26IQZKxL2iUbf0z4hgs
         Pmp1C/KS9DY3IHxAu9qFGrsV2p7y+xJEm/2Ivm+DTc1U3wSNAwexplTej1Co7K53jm6N
         77l6g8PdC4R0G7lNzvfxQYINE0/LYli4sX5PJzJFm3zaVzUIeEjsA3QMnIG46EE7y08c
         vEJQ==
X-Gm-Message-State: AOJu0YzkT2gOxQczkSZOOTr2lKo1jzMvbI/FZMBDduk5OeLIIhMQ8yvS
	sAkd2svN0jBcIrI4X4yeqNGO1XIrzIRszv4zeOR3oCie0OZeBP3nNAbxOQpErQcRs/5E39Ylakw
	0IHv3BX1rz6Ty2b2LZreD9v0+ZykscX4=
X-Gm-Gg: AfdE7ckSAvm1RacUzwGNeVLdNF62488iWsHox0UsWZk/tgaXI8uC2mdYid6oBY1DEYp
	4ahbMbFCRIQBsIaVrCjZqT9/LyJZdbnvN/1lWwbSq99IeHfsQT97jU4z8qRfPXvENCHbzm0YVNK
	phwPKY89D+BHqtk2JJBUQeUk0y35yqNqWjUSwAR3fvQzuGAqH/nJt8jVJdkHJ2F5+3YogyAwXo8
	UbnmPGzo6zcoJtLVCBtAbY3NX/RmDHScCMnqdbS800jU5H1ra85y2yZjgP9THcfW4c/kkQh
X-Received: by 2002:a05:690c:b19:b0:7f8:7e31:28ae with SMTP id
 00721157ae682-80a662eb798mr848857b3.48.1782338523988; Wed, 24 Jun 2026
 15:02:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 15:02:02 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 15:02:02 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 15:02:02 -0700
X-Gm-Features: AVVi8CdqX4PfLHQXiwpnwtEKJdmkwx9CQ3waCkhoXh_EjZA4ykU1Up_eDosLuk8
Message-ID: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Subject: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on 32-bit
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v4:
- Keep the Fixes tag on one line.
- Add Michael's Acked-by tag.

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
