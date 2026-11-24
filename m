Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490479;
	b=nZ1Y89Dciuu0Y7ULw2PfgJNTNpGs+Bt0QmAhCCOcr0KDRHCs8rszBcCy+Ngd/v25oGgY
	 gm00FQbUQcmrtKtcKVU6eAqluYiR5G+rgAzW8GeuHhvbi8g+n1/NtlcAAgwXfGjjzt6+n
	 t9JmzaKZW/Sc2B2Ngbtqwhf6YUnQiJa4HjUtPf6S18GqsL8fExH3/Mc5n1TVgQzyZmNo5
	 impP+0ae9ABCd60YBF6ZacD7gSWs8Td1ywke/rAZn1nwn30ZLQJ+799TH+KJF4rpUTqgg
	 Bm7VxaX1QqbEZO8GWYxLxKzM+WtxMsJdt05eFrr7G91lPdPThrZX0oL2DmgRLYk2MfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jHIMwXv3ZcrbF6OScgT7Ey43aT1h/KB9DJylqx/2mbs=;
	b=EZ1LW+TJNk0JV3BwDRBJ+4irTx8lp5Aqb+Wzi9Fr9mTbGKy39fc4TOlNEejTVM897f7A
	 Vi7CV//0dxWDBlyVNLw4s07r5SF+MF9bRR9CzQo2vrzNnYxJ8sS3tQoLmtMF0UkaSeOGX
	 sG4MC6EkY2qn70f1MUJjPFBrvH0V5zrfQEbes/Vx11gyeIks1n9cCQ9r6E1y6z609fT5y
	 /mvfbBGw0MicMe8QNssUniHxPM0TULLxPvMXZUo7oPmK9681OPMZQuSoKn/DcpLftgGc4
	 F0dHcLHlOiWzYvPZcB3Z7SUn27iHQkGCe7MO6OYnM2d7j1JLiTue9GHLR9J4D7gl/oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFqQU++l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EC606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5EC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFqQU++l
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso4772005d50.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490478; cv=none;
        d=google.com; s=arc-20260327;
        b=j2rcAcY/nC25owXxAlXF7bHJoB1x7aPQSEWDo6c6DLzYrJp2gHOwNop52LgTO2LLMP
         ZMdqIzEG9n/yK3z8UMKA9KpHPrEPeQ3/95RAv6hQMogwYdGmy99tBFK40fYgnvkWw/kw
         y2uHJRvTE+AH5JZwPBn8sio2S7MKhyEFjwrLwzJSfYOOW/GukH0sq4t/NN3j7noIcq8b
         dyDR32fU5IwYnSvV6K3ln9RQElmbFspS+KGlpGtw7wLa8Er69LpX5Qr0bHBDkR4QOQNs
         Xg3UQ0pNCNs5ccguXSpFqeMOKqpmym221eIs0l7prllTioAIVwAA6neloyJkxvNEw85H
         MHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=jHIMwXv3ZcrbF6OScgT7Ey43aT1h/KB9DJylqx/2mbs=;
        fh=EQqNnEgBs4Jv1VEnjUY7+9yeq/XBxXlvxOHma0SwhDo=;
        b=Vc4DqptK8Q/eSz255zLy9s6WHNG8DRxaIboBimJBp5wAnQUt1qBdcfwBo+6528rI/v
         NnJ428rK77vIvPSO7fp0kfcWrnDS4s5qIeF5kSsYdCHpwqE5vlcsCYEKHTYPLtC2tQKp
         CQre/+cWYREhmyNGazeyv2hXIgbAhoK0EJjkfXLP18s+PaNYbrRl1wry9viJil7P/sAl
         myf0r0CJYOXhKzLu77q0hCKy5Gz10ZBJzSGh+SV0s5lt9ajf4nUXCG7Zw57jtavWN8sc
         wwQq2JICZj0HxEYG0MZd2r9eF58cFNDluYzk10HvgvPLzxz78ok8uQZ9yCtMBMjSTuSX
         lqJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490478; x=1796095278; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jHIMwXv3ZcrbF6OScgT7Ey43aT1h/KB9DJylqx/2mbs=;
        b=SFqQU++litvNCE4OyWBG72+9X7uTv2jnEUfMyXELiXgPQuo8jFkCOL2+nWPUix3qFj
         ztN8YW0uUKoHKPXZATOv9FgDzlqDrNTUkWhBmxmbiG5JohWU29pSDspTQuznbxlLxZ2W
         tYYfy7keIEn8rTp5dRibcS/9DpDTbw9F2qwIIXLOvqVgEjU/gSr6QVGV1q19/Zn4j9mu
         KPHE+O/XTs8yZf4oAdMCB4Ch5/xHe8MxSLkke7vQ0Rfer/0XWqaFiWrSdMbMCM7tGRwo
         pUyE/fRq/gTMLZJoasAm8oCKFVsume8KTUTpDE35un76jrTI9TCUDv3XIbv1WiOMIb9U
         1hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490478; x=1796095278;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jHIMwXv3ZcrbF6OScgT7Ey43aT1h/KB9DJylqx/2mbs=;
        b=exhNHMMSg08BrP+kqvdCq4PYwlEu7sU9DrPQfWTG3HCLQamyD0nuEZCrE8IolM39RJ
         gOakHSa2VPSlN3xLKIKHj0QpDFY7O9GaggOwQeIyT61z6DV0jXU6F0ABNLha1cuTP64X
         geDqBHoe96s9163E2sjnluhT/+/2C0cSbOyC4+THUYA+5Jdv1npOmlV0hOWp5xKN6r7F
         uGZKMvP14M4ssIbKfKKYFhTdMCVGKQbJ2CElIZR3DWXWXlY1fRjnThHUa0r994WaGYP+
         ZCvh5nBzITcb+INulGFJWZU6mSlZP+cs5ytQaAUsIyWw16cTDH0fKm3imMU6+eK1QEvJ
         gnIQ==
X-Forwarded-Encrypted: i=1; AL+hErGiC9WQwL03OsVG9trTfQoq0FZ/lSYVgSPcxSrw7K3pzbr+ONRbVKElosAnhigt/qivgeQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pWdycUREiBA4SYL1xa1oTE3BtyHTXW06tc2UrCbKpecfvZYNb
	tziDpsI3y6C330EJocHufDWMsDHMhI4HqY35le36QXOiXe1qCHrLsZY7uCdyW+XuYPSS8fXGzSE
	roaS+yx8yUv1E954qCJjNdfQb5zN4Xr4=
X-Gm-Gg: AZFdTZcyJkPAIrnhf96wFi5aj3Z1yJvZP6iZ05JLAgjNjhxP0A4bM+YnFdpZlfhu0ms
	ZgzzWvzlvCGiFI47laTxgjOkG5XYasFClW+npXJ0FKw7v/Idpi3YxSJbZFE+C/mIHz99uOSpb1F
	ocTLGk2cKythzDNGzhvgVs2f63oW/PXGU8MnDvqK6TWccjG/p+BH7/4beLett5yWUk+ccNTeKlu
	sAulHLL2kgsJbf9BM6e+ep2dTEPljXTt9OK+NUZENTx5VswXzljQFwYFbcemhLoLCFe/YmVG2C1
	7nTHGmqJ0Xa/Uj2TrDOqUrcz4Qr0/tLziXbjYBwAEFliQ3NpzNvtn9GY4QoT7v2lsG176efGCNw
	1erGFjcWv0GJZi6Nry8AhsJtKTYHMPgKUCEYY
X-Received: by 2002:a05:690e:450f:20b0:67d:b2e3:e584 with SMTP id
 956f58d0204a3-67df444a4cbmr2783073d50.90.1795490478252; Mon, 23 Nov 2026
 19:21:18 -0800 (PST)
Received: from 723974502065 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 19:21:17 -0800
From: Qican Ma <goonsomeway@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 19:21:17 -0800
X-Gm-Features: Aa3M54q8LZTNF9dYZve0SKaE8rbBeQ9IPeHggye-eXOPGuwzrJJGiwi3-2z7W9o
Message-ID: <CA+OT+OO_sYq+4dP60Z7K5UNtaZHKoEQmbAzLsR7YHQ2bYtfUMQ@mail.gmail.com>
Subject: [PATCH] vfio/mlx5: read migration buffers and f_pos under migf->lock
To: yishaih@nvidia.com, alex@shazbot.org
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mlx5vf_resume_write() caches migf->buf[0] and migf->buf_header[0] and
validates filp->f_pos before acquiring state_mutex and migf->lock.
Because the migration file is opened with stream_open(), FMODE_ATOMIC_POS
is cleared and concurrent writes on duplicated descriptors are not
serialized by f_pos_lock. A racing writer inside migf->lock can free and
reallocate migf->buf[0] or migf->buf_header[0] in PREP_HEADER_DATA or
PREP_IMAGE, leaving the unlocked caller with a stale or freed pointer.

Move the f_pos overflow check and buffer pointer reads under migf->lock
after the MLX5_MIGF_STATE_ERROR check, matching the pattern used in
commit 4ec5e932e636 ("vfio/qat: fix f_pos race in qat_vf_resume_write()").
Set done = -EINVAL rather than ret = -EINVAL on invalid f_pos so the
migration file is not transitioned into MLX5_MIGF_STATE_ERROR, preserving
existing behavior.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of mlx5 VF
live-migration hardware.

Fixes: 6fadb021266d ("vfio/mlx5: Implement vfio_pci driver for mlx5 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
 drivers/vfio/pci/mlx5/main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 18a6d224b1f..ebcc22bcb75 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -884,8 +884,8 @@ static ssize_t mlx5vf_resume_write(struct file
*filp, const char __user *buf,
 				   size_t len, loff_t *pos)
 {
 	struct mlx5_vf_migration_file *migf = filp->private_data;
-	struct mlx5_vhca_data_buffer *vhca_buf = migf->buf[0];
-	struct mlx5_vhca_data_buffer *vhca_buf_header = migf->buf_header[0];
+	struct mlx5_vhca_data_buffer *vhca_buf;
+	struct mlx5_vhca_data_buffer *vhca_buf_header;
 	loff_t requested_length;
 	bool has_work = false;
 	ssize_t done = 0;
@@ -895,10 +895,6 @@ static ssize_t mlx5vf_resume_write(struct file
*filp, const char __user *buf,
 		return -ESPIPE;
 	pos = &filp->f_pos;

-	if (*pos < 0 ||
-	    check_add_overflow((loff_t)len, *pos, &requested_length))
-		return -EINVAL;
-
 	mutex_lock(&migf->mvdev->state_mutex);
 	mutex_lock(&migf->lock);
 	if (migf->state == MLX5_MIGF_STATE_ERROR) {
@@ -906,6 +902,15 @@ static ssize_t mlx5vf_resume_write(struct file
*filp, const char __user *buf,
 		goto out_unlock;
 	}

+	if (*pos < 0 ||
+	    check_add_overflow((loff_t)len, *pos, &requested_length)) {
+		done = -EINVAL;
+		goto out_unlock;
+	}
+
+	vhca_buf = migf->buf[0];
+	vhca_buf_header = migf->buf_header[0];
+
 	while (len || has_work) {
 		has_work = false;
 		switch (migf->load_state) {
-- 
2.50.1 (Apple Git-155)
