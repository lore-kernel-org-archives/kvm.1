Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506846;
	b=0EhvcP5xsAOFR8y+yVxTZ5l0T8ZJMC4sWN37PCidQxnGlSLcgkmYcYgY15l5ByXXIcEu
	 ZXi0ML/zFEK8v2ew7mFQ9LgYpC5zGyEIghKx2kXFogDT+hiBYbkb9iv1Ng8SjVQgL5Wj8
	 ks4oP0d6t07Hzb5Vj8rvKSJ2iZ+JrBgnWl5cx3YwywPmcBinzrbWm91fOoqfGER/EG1yj
	 2hOJ0PqJ34uOupWVesGbCnwj+taWU/PNsrsj4giYIFxie+51PDQFmrrHz8oTqGf+yc8dq
	 DwSNNl2j3KDwcyw5h++RNHqIOnmlvs6W7CdpW10ypNkj6Rc7FkDcIW3Y2MIjAho5DVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WMCk1svQCiAH5bw92tRVNfz+1k/iEYiycS3j+Blsm0g=;
	b=wfrfndL657CQBjI4sYP6qD3/ZtuU6CXYIaLYZYQ+DOv6Y/TJfjiAqMsFUuy6JhKV1xV7
	 hjv50Xl56yD9WdxJi2+DJ4V5FvHVrcTzWjYAYCJH4DhnK+cRu3B4/OGh9ulmIOFflVKKF
	 mhOwC5fsj2C+Q+ofkx1rmWQBrwjimIbDEw+SXR2fuNNpkzXVln3D8QhvFv6n3VwjFvbUl
	 J/LddFj5s3CDFUZYOB9WM3ao4Ops3c9RxRIIdeS3RHtPB8Izz7QLUai950ffIsYptPkY4
	 B1bZC+SrdNecLHAID0AXW1O47ChkemtBxYWEFZMRxLHxODpw66A5c4sK2L8OHPIaEuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wkISmoI;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9E606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DC9E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0wkISmoI
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso4242901a91.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 23:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795506846; x=1796111646; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WMCk1svQCiAH5bw92tRVNfz+1k/iEYiycS3j+Blsm0g=;
        b=0wkISmoI1mzJabEiMEfJGv54TU56e7W0VBABOrLBgY0ki+ff6L2fYUDN+x20/+ASbr
         DJ0bTdSvyfYnrEiTvJiYLEoyU5GCmKV+ftJdd2+CSCLNjzCJvwFLn2d1Jfu1mA0ugue0
         L1AzSYPeMDNnVJtyOki+LeylRbMGTJ2DvpLemCHwlV17Ut4ZQEZbbEbXl1jtWXRdfJ3f
         JdK08UMS8igYw+GFqzUtBr6jJ20wKbBh5pmrxm+YFfYVOvCjTSqcaBAWyi6ih+Ri5E6b
         JLOPUXksPG9LWvxb263y6a27W9kkHo6B3HXNUzTwDSgcNqW6UtqjvOSTdYCiN2lO3soT
         JMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506846; x=1796111646;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WMCk1svQCiAH5bw92tRVNfz+1k/iEYiycS3j+Blsm0g=;
        b=pewrZI3cIJkCNF6x6PlqaAasy9qa8hBsiuqpLR5i2fN6TkrOsuhQWzvfbW81stQ9Ld
         hiJhnSbB3JGRSMjWkO9r6WrSxpaKTQyDmW/SiwgvThHlHFYF3eTQUsFv550+Ftkru3Fg
         yQKHEJ5dN6tLxJMpf2/OPGXzNFvkQBQNqYkYB3mC3sLRVXwiohu93VriC36xaWe+Fvc4
         WFshlL8zrCKlKzVHflaukPk2orAPTNyJADaac8aff4+mVQoefheQcLKPm1aQT97bdNF/
         szIg1Uch2osqTrCpURwD3CwfBo0x6oVeiBXishNQhxino8y2+GQ4GbF6MdsYyCNoAYQC
         CntQ==
X-Forwarded-Encrypted: i=1; AL+hErEbwJHxISNIsBIzo7wWBt0zMVFPaI8ZBRyP+uJlHdwW602SdFbfVluZ4NPOEzIr9evnf6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+2xh8I0cHIYWk+tC5Ah37t7WkBoZLzt6NnAx5WuOSUCaBaY7O
	Jn+dIAoVsS54CZsdE4/oh9/1clCkKHUKk0KFISYIZQSt1cK73MhHMj/mNTeGplmRh4w42y90
X-Gm-Gg: AZFdTZdLsyh9D0CkSUe1u9WW4qWS1zolVLRchQCAzHJeCxntO7urBftUo7JQs9Gs+8E
	cRk8ifsGdQvgowLLrzN2hZ1ULRKYoKAcCcOTxZiydeM4YvJCyzUqIdDaMVEP9qYQCDDF9vqdXg3
	oNuWUruu9YoGqu6EgP1lZKaIzs+VRLYZI9qXoCyX3cK85nbpjhK21QrmxZAwDTdbL3/iG4DTZq5
	Qm5Jnu1UU1U735t3BhmpIwedBm0/e1MfoR5XzsO1lt0Kom047QjpyUSgIDisD76KLUDCjD1isem
	0AKeUofUuHqxrvUKj7WGiHot0mAHM8I+bSIKPJ/aV7IjBREG5JFhYlq8M1cHCVls+Y/+K/FGx0d
	tfuv/E0FUwqh6JuDqRBq5jULdWYeBJvWkbA7i2ZAeQ93+yDq+yDEinrQEYazKOdTzHpsq4EPX7I
	nOjtHJALDs+ONdIJ7+mdIHdsrFHASgRD/PuDOCiBK2ACN/QTDS0mLhF8DcyvV904ndYNZrh6svU
	LZBmSUekC+puKlRNcyNE6BglFL37sdWNv+8kUxeFtd3tG9d24Rq7R/q1lrieh8Mio9qjigY/Eim
	leSgraHl/K4ptPYIGIKzA9BhY0UiH6FeweHTEDu9K/5rfZKLGa4zFvT6JhvV9vsie3sDRHvbiTk
	uMC7o80cTHO/IRQrjwbS3EL6xYaJqJ+loVLnl
X-Received: by 2002:a17:90a:d607:b0:3b3:bcc2:6f8a with SMTP id 98e67ed59e1d1-3b41c96129amr8091678a91.35.1795506845627;
        Mon, 23 Nov 2026 23:54:05 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d97356sm24145658a91.13.2026.11.23.23.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:54:05 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: yishaih@nvidia.com, alex@shazbot.org
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, kvm@vger.kernel.org
Subject: [PATCH v2] vfio/mlx5: read migration buffers and f_pos under migf->lock
Date: Tue, 24 Nov 2026 15:54:01 +0800
Message-ID: <179550684160.38664.16653575201489890045@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

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
v2: resend via direct SMTP without line-wrapping corruption in the diff.

 drivers/vfio/pci/mlx5/main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index 18a6d224b1f..ebcc22bcb75 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -884,8 +884,8 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
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
@@ -895,10 +895,6 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
 		return -ESPIPE;
 	pos = &filp->f_pos;
 
-	if (*pos < 0 ||
-	    check_add_overflow((loff_t)len, *pos, &requested_length))
-		return -EINVAL;
-
 	mutex_lock(&migf->mvdev->state_mutex);
 	mutex_lock(&migf->lock);
 	if (migf->state == MLX5_MIGF_STATE_ERROR) {
@@ -906,6 +902,15 @@ static ssize_t mlx5vf_resume_write(struct file *filp, const char __user *buf,
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

