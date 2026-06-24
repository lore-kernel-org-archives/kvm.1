Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD926A08A
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337919; cv=pass; b=ZSocK/ttNSRprAQTG7JE6aiYFxApQgOIaY6trkS5ifOlne+lxZJUhbm6FY54QL000UkDYR5LS9Frs98xjTsOvgaMqDM7K4wnFWnnPy5E07vHZWguNVOgxDC+3cBni2SX36e8SxAj5jHHdPPokDeIu9KhTq2QdWCeMn5ExVt37HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337919; c=relaxed/simple;
	bh=WaN4T3fbz8Ix268G4AelzWRoHuaajgHJySjLnaW2MDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NBzd63H8vajr8cKyfvZZ0lcnP+mMl2hTtn9bnPVd/mzllOiX7+u9g857AppEumy2oqBNHlo6X93e0kuC1X6TrkXORvea65UuO9NQ4ulsTf4q4747ndkNfwy9YRhZvqmlQVE+wlMHcuMKY+qIMss1gT1Y6ue4A2g3QHvb6DwmmaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF/Bc85L; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF/Bc85L"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-805f5d1a6c3so16287697b3.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337916; cv=none;
        d=google.com; s=arc-20260327;
        b=bz504iPiYWUerEWynY7EwgqGz/n4f2v9LBHLeUYuoZSKVJ5xtD5/tzbqYFA6xo+eC/
         5e6N+E1Ja2Ub/ygWdJUsCqLYRnXOv8HzuoExQGmCVr/w/lT7+qvLIM21O80Omdpz78Zm
         dkBradCuokNw+E4jZaORA281ZkoUTnH9xY1vEmceqxSWVS0gHXSixZMJ4JTkOVHAV2S9
         TCKRXtP99z8Jl6sZKOKgjGkIlDHyWJ2dynG74oW6y1JMssE3iW3VVwM2qlPMiWBKCeCi
         vLBQaEBC4Z6DxChGaNYxIv6OzDs5G2vPnQavoPRxj2JCtgOTtuA28FXwoQ/dDwFWtRDI
         Y21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        fh=xc2eALkLyu/79v4P7ONAVaYK8ZG68T84O7ikAdq+y5g=;
        b=jFBK7jp9TtFXuyxMZfcIxtJguvHaZHKcNNur9O+i295DUXoThEkIY2y3ui3E+Jys0j
         R83DpKuv9dZkt1ofHkJlzyQU+JJ8NlfuqF11KP2OhjGt3kstgsnkVsKJWqqq3WmTota+
         wpA6bu80p41l5RL5fLQNbgh4Fr9u0oQfFVYWb7uSNZQxEulezLwECPEPTbnZXhAmLbSB
         IXRL6HdL2ALVDcfwgbeYF6ViGGiOenTojLyhTUdV+pDFkqqdwGZLIdWn/ItQMo1iC1Fi
         2qunJtRuXx/WQaI4UH65//40Oi+WwxuoUu/FTewQPz+nWQiAAU7n4bRZ8tVj/QpVsqQt
         eEBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782337916; x=1782942716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        b=RF/Bc85LqTbcwUVVB8x+8gfAWttuqs6TPWRM+ddZTH30IRk4Gfr2IUHh229ngysJRc
         jIPnOR7AtPxnRMLg1GnDi9ae1VajTJGEZzEpmtngXorhQ3EGaZC4jGR6UIYQxmLdELWV
         F85eBolqrrpfeYCuXeG/zpKhtWar+B+HZzXfhafHZDotnuBQf5q0fx+b0qbwPphAYssJ
         bQvNZylMbU+Y1K//xRp6Grt75ajYRujDc3kM3LBNe2cUUyJZ6cL8cBYs2BOb6yaOWiGz
         XGyaJBg7EZf8P0LrqGYDU5DO9e7GLHiUJj2xpV5N4KNiZAy3JzuDgwoXNHhE8KWtYcxe
         2s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337916; x=1782942716;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        b=JtRgolU0tY3RUA/I0OFDMdcfYgczsNPVPnOQD5SnWfcj20UUHxFggvA2U0h03dpDXK
         LuC0NF0ZszZoqaqMTI/oBpzY3yNR2enaQTE+DksqKlY+nhKQ9eLThh657xscwEOoSWHa
         Aj8llkwOqu42f4Ehm9X1FRNQqR5bJe8Qzh2x5BtVwGLvrp22jRClUM03YsTse1t30DSC
         aBuvvE2bBgYV3YfB8e0vkfuT2WqedHo9znwCC/ykJRZ26GJzu+4jfqVPmO6YMIIz6SwE
         1aNIkNpuk2Ddiou5DOA3Of9RH5H7cmLb8efbty4SPWNVWsZzgzwho4vDnpVOhsgXuxmp
         wMtA==
X-Gm-Message-State: AOJu0YxunfuUcEmhGvFb278ZWy+4dsShfKTofTDCIX+QUkRXyI7FPfVL
	KRvmGd7ALu1l+V0V+n9As6ZPZN0qH7tFa6h0LVPvqP730lVJ+/XAEQT+6i8y1I7A0VqJ3VoYco5
	oINJAtr0AoiFSux7VUVRah+vLw0+HEaA=
X-Gm-Gg: AfdE7ckrQgvAdHh8KYgxk8O8LPuR8Xk2dgsf/a/1MHg3qbzaqr7sMqkpACVDxpjEFQr
	flOm3ULLwuTfg36Detd7VPKQrg5k63o+MpZkTqPYynfJepX5GZxkdZpg+bXcUhfMpfBp/wbYSMV
	bnqLxU0WNA0swZXu07ao1TFwdU1PPJBHsmQOwqpQmVTyiyMKcEg47JYqS3dpaVWXKfxizhbNZqt
	+VBq7YB5vk8ApcsJTCIKcjW0k/wUrr54+KOuvIXU0qanAtL9TdAuvThqe6RgHprj0URmsSL
X-Received: by 2002:a05:690c:a98:b0:806:8eaf:cf1e with SMTP id
 00721157ae682-80a698b8b07mr44057b3.25.1782337916257; Wed, 24 Jun 2026
 14:51:56 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:51:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:51:53 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:51:53 -0700
X-Gm-Features: AVVi8CdHz4x01_NrUP0s8m15X4RCCzs8WdYKYti90s1WpO20ye-Hi9vgV_npMcM
Message-ID: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Subject: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on 32-bit
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

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
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
