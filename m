Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61AD3033D8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328028; cv=none; b=so5lO9lo7T8kUpzTI5zr4ulJ3NTf/o5HJ2ZQXqQDBElrMkgE/cfxYLjk5ydNWjXbhsefX5J3effRD8FgXA27vVlJfEDz0uN9a0MjqtAloKVEYvTdOdzNOFfkEtZViKlvreFWa3Ux3Ikg84/Pq1hL02tSiTddMZiLWDm9t+WuDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328028; c=relaxed/simple;
	bh=8LkfFMB4XG4EiUlUUfCp5eNP3of8+WWy7c96tMRZBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBe/jslMfNZlA9De7BdSqaIe+4ufrEept5ZXevT3uPK+BkALlLdYGgJhiKQu1nbLUm3x3NirR8NSMK3wM1yHRQDCnviLTVRF3/kn177D6k+g0f1VzL46FbyI5gbFdMLnxfMuU2oPptnjCkUclI64ud9uQLhmxupi1moGt9IINBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYpysU1S; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYpysU1S"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4626fdc829aso1143951f8f.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782328025; x=1782932825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DfCmQjaXvxIPY9LgYjyAuGOJaOamYtsKcoImA7m2aMQ=;
        b=TYpysU1SznbTMV35edVzJSUxPkT7JRDvjKYgwA1JHNLtU52BD6gQBBMWdHlnR9Z5c1
         SxyO++NTChhENqfcp4dB+gqyG4Rnn8USi+gbzJkx/XPGDGcFJQMccOOXYFpTilpYgL+S
         VPHwE/aqzE8L/ZCTBDwYFS1zZfKpoNPx0B7bKk7beTuti2iWeI/eNxV+wk/4F4cD7xMc
         eLC5pqIH/vFEebaBUjdZmiUxvkfBW4DO1D+4RPULlPcgsVmDNZSsNeBa/4ZPnl9RDq+v
         Fat7zr5TkeYMTdQ8I2x59RkvMahgt2fm4Hm/nrb3eERWfSGqLHEYz3RKJW/i5Ri1h7OW
         AGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328025; x=1782932825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfCmQjaXvxIPY9LgYjyAuGOJaOamYtsKcoImA7m2aMQ=;
        b=AHD1gL+FhBmJZAVtqoYUpfwy4pE3C/3s3Wi1w3L2cG17WIaWbi703xV+SgvPep99lC
         rsb79U6Q8lnlWt8Tze1klmk3S3m168i926jLXh5IHIUnofWOhdTrQbpu1OZ6r+Q+sw0n
         cw8oCeZMBCqiH/2EaN0pGSCOL+3ODMkURcVdC7MflokkZlb254ICMoxGipba6pg3DkcY
         cG95WnA8m7+DsjmWS/XElIaxbWlF4JVUF4J/sG3x5hABkrG4veNdoxSkfYGxxPpwzmE1
         b9Fd5cnKzmReaF1Uij+3mnwiaF/vYviJPuXg+LHz3MRQuJYfyWp4u2mes0FUAirYOQ+O
         mlhA==
X-Gm-Message-State: AOJu0YwNvFoLUqOKgu/JyGI2ctw3ddkcCFcVsoqLe6E4/HzYoqaFZDvk
	vwsbidEKlvJNkVv6gQbsR3B1cgP+tD2q2absgaz1KHLUwh6HeJCJlcQV
X-Gm-Gg: AfdE7cmQXeMWxiMZEoWgRr7d/Xjbchsyd7CS87NFZtA77RQJLxYojubkhAzGoEMByy0
	EigUDFMabrOAGeXefr2+vN8KQ615K/p5IU2T6hR7vdmrAXkERECAn0c+G6No7+sqnnBYbelAI2G
	OK8zS6FvzWvP5tQccPkQnW6IivfVjmZ92L8dNe5ZLmOQ7m7q/evgIJuUuLECqqjUFq7sbon7atM
	kAJrkPW80k/qDp+kFt1bMw8uKVrev3paoacz5ZoQ5J1tOvROdnLKah04mmfjo9Sz5xwr4baE3TZ
	QIp2uvYaNIFamdxpowPZMnDJq9tZAnLOdxVe3OjPr3/Oo4nuCZcqrFNmEIMOxfMODDK80HyjzPp
	3QvY/QCynJwcxqlOzvFVVi2wQ5ys0KMezEDgZuRjIpDmCSWydtEZQPLyBWqiSZl21U0OYly5PQU
	u9j7aeOeHIgcwBRcbZDIwsPDJc0Q==
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr133374295e9.19.1782328025219;
        Wed, 24 Jun 2026 12:07:05 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d9csm8843587f8f.12.2026.06.24.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:07:04 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Date: Wed, 24 Jun 2026 21:06:53 +0200
Message-ID: <20260624190653.2893-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. If that addition wraps,
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the page-count calculation. Also make the
memlock check subtraction-based so a large page count cannot wrap the
pinned page total.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/vhost/vdpa.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..090cb8693 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
+	u64 pinned_vm;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
@@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	mmap_read_lock(dev->mm);
 
 	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
-	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
+	pinned_vm = atomic64_read(&dev->mm->pinned_vm);
+	if (npages > lock_limit || pinned_vm > lock_limit - npages) {
 		ret = -ENOMEM;
 		goto unlock;
 	}
-- 
2.54.0

