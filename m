Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944098;
	b=nkdiZU9tQ6MiIqcmDia3yND3u2sc4GjaetyWIZHZViOmVhlESdNWNylzw/Q1nn+Sy9tO
	 nqtmDMkJC/HB7th9T60Ffl9t28etgQ6ol0tCcITO5tdiulvX2r7kY7aD9sFSkoQN+CRlw
	 UOcoPgaso0A8xTyZQ6KwT6PYUWELH9g9VENABBLarWVHbcBm/20THqoT3mLDEPU0nFVEr
	 +GSUrnj3HUQlTZPrC3Y/F62SL1aP+eGSxZ01K2xyywFm71cNIbO0575R70FTcWC5oUhAY
	 e/oC+10rtfnqzcINSYAD/8hngfmaJKjWvp4r3SyblvU/xZlOzOczkVI9BOL6z0g8pHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
	b=jiSf5IBTJmnFLOOcmF3rof0MoCqEHtt7e8UkYYE8PMFb81EXae2fL9t2vrXjS2TTLuwE
	 iG4UI1Y/EDfHi9F+XkHsmQ6gIJppbBVVpKxz3K8u+jdRvGFzcV4OYBidtuZb0VtSBmNJb
	 iNjpettaJ1msxCiFwNsOL//Yy8PEmcxs/hSQAWOChjD9Etym8NnhrX+zCACDmgTyVcTS8
	 E+Uvp+0pbuaA7SaaxYAYQ+siergYHeLMHM2PRq8qUKo00rzPAW5PVVe+da9c1i0DxTEgg
	 yWeyfd56aQC9VCWXZHltbxx57tU22yQffzFlLAEq3OFExLzQDnPxlt1vZ4mzXBArBgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONk0HDpW;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B0606EEB0
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 541B0606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONk0HDpW
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5366463571cso2782331cf.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793944097; x=1794548897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
        b=ONk0HDpWZTZzaxkSAtxiRZVFKONuE/vUvC83Dl4aQaEr3IsTawTEUDxCFznTrubGsV
         b1kaQMKgT/zzhL+D694dm/LKqMpCD+2SBbRPbNYxqlSGMWALBSD+t/3LHjwfavqiMFGA
         1g1Aobhwb8axvoY4Xt2EiRi1eOGM0DpK09+mQIDQVLhpKrfu7drRcnSO10IONIJTiryG
         3AZYH/v9roEIx1sqY+WysBwr9dP8GBwKlbwYCNt22n8pkoJLhN9lp0zhvAyX8MazcMxu
         gML8jHMex8z+ho+H0ZExqenrBXV9vZp3ItYGt2VgWyrSeNduXmQReWFmgx8M9NZa0ghU
         QUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793944097; x=1794548897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAZ9IFW+Zz0SgqoelY4mhTjP7/bdw7XNlc/ioW2tjQU=;
        b=JvqYdZoFuakXWY5QpVitj4SBc+cjeBfg42Pyech7qfER8xXzavtwHWwgAst/MZAGpB
         u/npFHclg9ZmaMmBn+aLGzfxUggBjEN9x5LsSUMtPxLBdO3ZpNNSTkV9H6k6ScG6clwq
         Z/QdmEIya3IyrupzupVfOWC72bZVahhr7TQ4jcPmO+94E/RWBON36FQqYz8tliBBJw8w
         5xqvHa4kEoLU8seaOCEbZnw3qYENOQBjWK/sUnFfk4X1RKnN604tD4MPGOIPt8aEJDwR
         SBlbxv8Or6gqmGNTgiAJlFn2Ed9BXRvYWxehDpqZCPNJeuwev+hjg60pRCECM49sbqzy
         eqvw==
X-Forwarded-Encrypted: i=1; AKwUvBx9Q5RgD3NQw7sYGFMtU0KfS3p+hBiFMSBII+AdrUyYS9InMDid25ROhAAKoCbZ6/s1MvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+M/qSgkdisGsX4ijdJ168qYX015hyJUtNouyabmP5rrmHqeadA
	v74y18xPHw1tQ7rdvTABzqLrl7G2Wq8U7ullK2P9ll5JY7sYqIV5S7rQ
X-Gm-Gg: AYBFou3V1OGwgZShyzlV+vv78ENL+KGvFAU5fhJ4cgs4T6OHqRvGaZspVHe7O1uFy5/
	3rLkE6ARAtBXLL9ijzgwYoJKxyM4hxMoOvHuHJ+Qxh/7iVULXINca8btQaGnULO4Z+cKhjQlosn
	gVG+b8BxacfGhCxIUgReuhgY1YGYkQIoefUzmSxAvM6jJs1c0ZoFHZ9PPWkk/jPzwbAN2a2eIAT
	Ox6D5lgSDNit70Ar/ENqfOfhZAM0H/bt2r8BhVZ+t8xDuckbZBr9BZJtfmdCrUzVfQUg7PYjL1W
	6EdPBoTdTk82LH0klDJjTJXYXU4FEPidUkOg2dIY2THr0NFVlf5FatlAfsyjZMfyRFZY0MFksxJ
	oNys2NscTqeCyvC1lYSqCl1IvwkERk6HWNf0xoAuDECR1fE7oDpEFI8vEkcRTvX8wgp0UK41fC0
	pVK2TQYhXYfe1GSUIVa0OtHFIdYS3wX0tKdf1ibB4E55FvK57WzMdDi5xTjpUkfYSCT+w6kTjsV
	3kvjGq3x7GCXCMwZqcBn2ZHh80/jlTfoGlrAOGbBK/Ndkw2eV2GfmagPGQa/PtNDKyh32MkmiCV
	5AnffldaLMP5a72CSg+7CDrgsl87DclSREHsYOjIVZtcEjJR5fks
X-Received: by 2002:ac8:5c8a:0:b0:535:52c:a2d6 with SMTP id d75a77b69052e-54e100e5abbmr22180261cf.3.1793944097227;
        Thu, 05 Nov 2026 21:48:17 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26f1bd64sm11903521cf.23.2026.11.05.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 21:48:16 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vhost-scsi: do not validate vrings during endpoint teardown
Date: Fri,  6 Nov 2026 00:48:07 -0500
Message-ID: <20261106054811.281798-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_clear_endpoint() checks every virtqueue with
vhost_vq_access_ok() before disabling the backends and waiting for
in-flight SCSI commands.  If that check fails, endpoint teardown is
skipped.

vhost_scsi_release() ignores the error and frees the vhost-scsi state.
vhost_dev_stop() drains vhost work, but it does not wait for commands
owned by the target core.  A later command or TMF completion can therefore
dereference its saved virtqueue pointer after the virtqueue has been freed.

Vring access is not a prerequisite for tearing an endpoint down.  Remove
the check so teardown always disables the backends and waits for in-flight
commands before releasing their state.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/vhost/scsi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index e44044449cef..f0966f25b09a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2194,17 +2194,10 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	struct vhost_scsi_tpg *tpg;
 	struct vhost_virtqueue *vq;
 	bool match = false;
-	int index, ret, i;
+	int ret, i;
 	u8 target;
 
 	mutex_lock(&vs->dev.mutex);
-	/* Verify that ring has been setup correctly. */
-	for (index = 0; index < vs->dev.nvqs; ++index) {
-		if (!vhost_vq_access_ok(&vs->vqs[index].vq)) {
-			ret = -EFAULT;
-			goto err_dev;
-		}
-	}
 
 	if (!vs->vs_tpg) {
 		ret = 0;
-- 
2.43.0

