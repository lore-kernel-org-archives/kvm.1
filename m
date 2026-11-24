Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519565;
	b=U29p/MnfM4b8Nh7zEo0aXjoADfFpHe/rHxHBju/WYNOt+SYdX0gPQM0QEcyMAGiaK7oX
	 r9uGRrfvtalafsNaNUOSrx4udsz3w0qRUB/GuSB3731JakMpRhxxr826WAO4q71zZhV32
	 k+J8BPu8XTlQBZ8CCrlZ4IZsGWjqU3eejgHgdSoypcaH1743Ib4rdTBnYeY8kn27de9G+
	 TzmA1csUPkMGMX4zidsihcAgCJbgdBIj5XUUh4U4VSbWoVO4N1rWLahMcz8SYWwYHqNE6
	 uNc/ENoMoGv2jDT1vRmtk9F57J9QOF5VTyng7kmIKtZjRmnPbeT915xNVSQz0OZ/6qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9TNOCQ9H2d43t/BfxCXyI5HmguTA6zQAvY+ghFt+g5Q=;
	b=gJ3RdQrR4Zyaj/TiqY/Wrnq/inWko/ndTqUI+UhfhaJSV5xS/PYuQi28/b2eGcr9huNJ
	 VuuVjAVDqalFrdjKkHN8O6PMjiobXpn5d2yMSw9/x554aZlLfZi83W363Lln1g5mB66Q0
	 ChUgn3+S9z2JdnOSLQZLADSna/YJqHtmnk+SHmVQS2vrWH7V5NWSKoK8uRkoyYVt8gxlS
	 9P/SY9EejyulPtDLVaS94n+rhulpgKh9cSMdIXxpguGp63YFNHfplirsKKBP+KthNvm3T
	 6K1n2H2xH/F3yNKcJEyECeobPZFnvD0r394LlFkkY0sOm87o/jDgaeTMIMiraJpkoCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFHm8jS+;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926E606A321
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 11:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B926E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFHm8jS+
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so1548727b3a.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795519564; x=1796124364; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TNOCQ9H2d43t/BfxCXyI5HmguTA6zQAvY+ghFt+g5Q=;
        b=SFHm8jS+fgMk6r2G85enm7NYKIzj4reVyjfEVHLhaRlvkkwlzKfhedJmyEmrDI6+6h
         4nXO/aX5Sh0Ptt+YB0XKHOcFG9mJJEezX3sHudI8Jd4L0agxNdVYgFOEK2bBP7LuLSZQ
         reWdn7u1nOTfkCsTbvDN1yOoLBDD/SWf1nJJJhuZJemebfdrzMWyH11cm1Gs9uh4Aw6L
         8r0tnrePpNNftbcrvEHC38vzwDg7XseBsRzH2X0hLrng3gGCDOsVQDik/FqIo+yoFBQo
         VfEVbhZXLA/67TywPBiHT7io+1wuKYMrdDGcRDdDjsUUyAvJn4TgEc+5hhxzZLpHU82G
         1tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795519564; x=1796124364;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9TNOCQ9H2d43t/BfxCXyI5HmguTA6zQAvY+ghFt+g5Q=;
        b=g3lLJbal+JbclszPm+wh4j7RTTwkMsuqtr2NuO4FFswFWBWJrxKGNZMhTBUqulKI4+
         jnSCPaSjAx6vOLYnlogYSckrxv2ti9QA5Hbne8nswED10V8nsCCa9bmUTK8lwVBukWr3
         lQ/b5whsQmXzQ45ucY2/NL0Z5uq0cGDAdASZDst7toWAyIJIhgj3y+DmBm+TvBXlPAEt
         Np+RkqD8HSOML/2kUFmEtpWqwtiftp78WHuKfjAKlx5Lvf5z9P4VoLi3SuqYpIvApWdw
         tT16JyzD6BWlq18O7ixaWrQBMib392LMmapQeYig1H1Sn0XR7aRmz2rBHpe/d3j9yNv1
         fbeQ==
X-Forwarded-Encrypted: i=1; AL+hErFj4vZXOLPDXZwXyorAgZtS9Wz3B2QiMLUBi5ahefX6YKhKzwELMXnKcMIzyNrslt3dnSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IuvLO3HYhZrv4iRacnbjfVJuj+mwhFWbwdPQFuwtAI6fXlSpL
	uTY8pLn3yN80WXQsx7UUEjBLtewJ79sedqJLgmIetkq4/8gNxuRTJu4oZBNnKGZ9yl7eJOzk
X-Gm-Gg: AZFdTZebpRdTj+6LAaSfRxPu3RYW5jjkLkD5DUfDZujCgph6NoNPtTMppufLpgfNu9Q
	BtQwEzpgTZjccJz55u2VWXUM2i/2sTjCtEQIoSxFGRXXQez+xGvj+EzzHtlpScfAE/gOFTVDMW5
	VbHnM+aUdv2C+MG5lS1HMpjhfQOVl65L3NRAfG6UPmAWDfU84o5+yQhblq9dQn7yXXrPCJB0DqS
	wIo0ONyUvo08yt1ekKjfaYQvbsl5jwaVPb5wlb2m9oldfOsEsYrjT8AXWShiSGcABUEPf9SoHxn
	RipTicnKFGGmLyZya6wWcjEK+BhoHxYujPt5yrYwtEM4gqHF2p91Cada2PeLGvFDmkEsUBbIOEs
	PNJ/EfhJgBCWMywiZeb/aAa1CnVP6xH4ZiP1HklaalK7+soZHqGm147qJUsn2LraI/Hpvfsj2YG
	9R9/6qeazb4ToSA9VHdBJ95QV6+0QtdJxh78OX/5mbWSEmhkuGn7SkkvQ1TF0MvWmOlWUI2dmBm
	suVtnV7QOPXteMtAomrci8ik0IufwPU8r3MUGQB/wf8znd9ylZ3Nq9O/bhqngr3lpyugVmQnzUK
	04vpIOZ0WKoYlOKQfdXQGlZddhhpG9+Yv1TI9k0qF4itsw/eRVyUatZ1q2AAP8za6rScH5FkzfM
	yVTpKny3ts8lF80lAXzirluBTd7uIPPs2DAvm
X-Received: by 2002:a05:6a00:1807:b0:886:cae0:fb6f with SMTP id d2e1a72fcca58-8c87bcbd126mr12076225b3a.14.1795519563690;
        Tue, 24 Nov 2026 03:26:03 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8ca64ec4b9esm4903088b3a.24.2026.11.24.03.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:26:03 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: yishaih@nvidia.com, alex@shazbot.org
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, kvm@vger.kernel.org
Subject: [PATCH v3] vfio/mlx5: Read the resume buffer pointers under migf->lock
Date: Tue, 24 Nov 2026 19:25:59 +0800
Message-ID: <179551955962.71139.3396358892015584482@gmail.com>
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

mlx5vf_resume_write() reads migf->buf[0] and migf->buf_header[0]
before taking migf->lock. The migration file is opened with
stream_open(), so concurrent writes are not serialized by f_pos_lock.
A racing writer may free and reallocate these buffers in PREP_IMAGE or
PREP_HEADER_DATA, leaving the other writer with a freed pointer.

Read the buffer pointers under migf->lock, after the
MLX5_MIGF_STATE_ERROR check.

While at it, move the f_pos check under the lock as well, as f_pos is
protected by it. This is not a functional change, as f_pos is never
negative and can't get close to an overflow.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of mlx5 VF
live-migration hardware.

Fixes: 34e2f27143d1 ("vfio/mlx5: Introduce multiple loads")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
v3: correct Fixes: tag to 34e2f27143d1 and rework the commit message per
    Yishai's review; no code changes.
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

