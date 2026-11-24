Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490486;
	b=sp+qnwJJNbR5sUzDhkwuDuISYZq0mOJByCGcsP/WpiFC3tmcdwfHyvmkeCMuxwr6MCNx
	 kyNPscrQ2lMXz0TFpiqRlVB4IwclOQ+oBe9mW99RLtDtYaL6ETr1sxffhLhl53qnEJf1X
	 fyXJv4YqR5SlqBrBksGzkcBunr/PPunLMykpuM7qMMlmfjIoockEdQBrPcxCNteCIfZRY
	 ZsWU4xS9SP51tmdZgFUAZYHi9N9TN1kGrV9KwNxr3b3EqBbCSWo0qJvIHlN+nbDD6iMbs
	 yUXworQapRPhN1TABxHCISaW9z1czV4d+OFmJgk0yYPDnKikpJ6khOTuQF2WnBlEcDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
	b=UlvSsy7MFY770B1+BZs8zQTuAwrjt8Uc0uf2njL6tai5G4NWdzkvzsg6uHV8O1BhYzWL
	 jl3pMY5fovJ7DQh+m01PcbXIWmNOMSDAYDfTWWcU55xBTzo9Y5E0xUwvGYwd3LuyBf6TR
	 1A5X0yhGZm2tB8LrC8qUKP22L/D+vI6as7PRXM0uecrahY8Rzuwx8dLLu4ViqslPXAYTX
	 EWvc2CsKQDW6zQDlYjVsqwyhOWEWRTxL0xyMeJ/KrD0fNVxZF3LSa6CUbnyK0YXBCOb/T
	 +9cE/FZGMtKad35RaOrHmWHeyQxNsWV30LEzo6c4S3WL6/5VJcpJX+xmogp3dZYHuIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmI+LAuy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F35606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 03:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5F35606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmI+LAuy
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67da7d18f2fso4563690d50.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 19:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490485; cv=none;
        d=google.com; s=arc-20260327;
        b=MdNCoGxYQnshvtiSAwD7HZ5ZKc48vFUJf5MxllSZrLWewVkEpTcZPpcW1b/WAqSg1J
         kzIQqpZJBXKyGpjPqeMYL8jKg0LpYYnsOO2EOlCKWRHwkNarIMjA4yEOpBoiGe2pUZOk
         Qn9oiLbCeWkb3EvdHwdQOEFyL6U6wAtCOjToDUAWPYdnWuMpVeUyU+80zU6R/8kJ9Xrk
         gJDLZbfhWhrH9Ty9MvTW5Zcuq4TW1XeKvFubSa9VVgJYkinuQLGL/x6Hiey76hnH+KZj
         blGbischMXfeefXLoSIE2NCF2JYcZPMdU8Ey7KfEvNb5rOeE2T1a1wiLOX7/PFRdmb+R
         HdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
        fh=4yGelnTkN9GwR8tClmYGBUC7HAUUVyfFjcENJOonKM8=;
        b=VXpMwHpZxLvg5GodXpEBQyIM0vEvM+zTtKybjfmzXfN39p9N2xOsx+huC9mkkzO694
         dXbI/CVUF55aDocJM6kaqF13AlYU0IlLmxL69jqnOe6z1w4DpZkR98jE1zpSJxyhUPhT
         9yg930E4UVj600Us5EgLnHd+tEDhLwk5n4Lpupno5xlQ+etJltZuo8B/qE6aCiXwcQNh
         gtte8IFSAeuZZ3oOhi4kYSHUAN42HodgX8h6X+FQ7UgsOayJrBrfgud1rZtPf1hKkKTH
         VBURcIpRLHDTpunC3tmvQF5SGJrlOWTlTMF5/HTrXl6TF4nL0k5hKNOCfMGyF7WjThiB
         VoDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490485; x=1796095285; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
        b=rmI+LAuyldYcf44pUy8kH7oMq0zUqfPhESD5U4ochalxZoPJjlHy/8KyMQgOHd+ed/
         KQ4TSVQhYhzOnB6gYNAKM5cQm2Vth7GN48lELJWaa8f6EPH7fslDd01scqTGbW3IdS5C
         1RUj9yFrc/rR6NNkUuKiGOwabZJftGZcc4K+zfwix1YukgFpMcbL+DcuohdjG85jsvsA
         F8yFE2Q7b1Pi6a7X1IHHh4JhKOwXOcfpiwsoSzQToJ5gbawLF6L58zYbVdWh8AcF8JYP
         +kI7vHRd7LXzn9gvBJO4foqeCx6anBwLr5hhxW7VLiysnfM9QpAudD/ARW17WRncBRRE
         5XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490485; x=1796095285;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Nl+jLjFcED3vClIKXM3yAqVJJrqmqx+RtOw6zm+9fY=;
        b=opbOESKD1tU9dD5sun+JjDuywVDC3hU/RTP0DQNgcopRtKaP0xi7VA0KIOKo+O5cTB
         0157AE2+GKr2kqwDvJHaiPeTJzrwESTjXSb6kRPhZYLWLSATjVI8HnAqNiNryTtiONCA
         rDoXaHijfjwSv9ewUGkzr+/c/Byk9IUnsvyAd6erjulxpFRc1xfftvUcKFYW8AWOT5dM
         LvUYgwUfJz2ZagRWKbKVKKgwMMOTUaCoW9XCXLxkwTKyLdT7PdAhxxGkEpuA93EVdbUY
         FOdgrfSerSA4bfF+D0SbiOgF0MGDRsTVDHIiO6+s+hrPVpHSZZLpgtsZRWdXlakTfUdE
         jJQw==
X-Forwarded-Encrypted: i=1; AL+hErH3lHgDqJbpTCWUFCwa2kPhagp6YNwgyklC11hkDzaGy5QTZppQy5zzUq+eUY6c38LUxd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0GnjrQy+FZqH62V/xfgZw9qnuPtliRLW+SjJFkmQb1jCxk1zj
	R9iZsqoC6RFTdYmGuUDRus99Ij7UlUqrQuBaRl5XpKCZ8xEHeUQjQbe2wf4qlPXV19L7FZ1xnrh
	+VBjsgJgl+o5/2CCpYa7o9ZzDTtb55UM=
X-Gm-Gg: AZFdTZd09WsA6jryEs0tYRuaz+0JBGHfqrNL4tXschrbgELgs/LR5/JJitmaB4/5yyO
	gabjRpXN6jI96Rbr+bizI+TQ5mX+4hujaV9Mr+oVYhMWfYmyfLUhHyPMKVDkr5D8Mj0CjOtOXhJ
	90IEGILGVgJPZ6R7TLB9f0Z6gP6TRjVK6rlPW4f2RzzQkZNTwRajkWN33w4n+/XIGM4EOBwcc2y
	s1kFVe+1hB9HhgmIZ728puwzDuP5o+06s/F8ilzXWsiq5qK626tdVnnRLlm1QQxQTcoQpigog3F
	qb14OnVOhX4ouejf/HDmPKWtQUqu1WkxCqdxZNXB+VPDWWsqhR5nLTuGgk4h4a7j8lOZWZ6ELvp
	g2d6pnwJUrp/5aQzku0uPcijyamCZXjXKF/tn
X-Received: by 2002:a05:690e:419a:b0:67b:e7b9:7a58 with SMTP id
 956f58d0204a3-67df44dee3fmr4263105d50.44.1795490484576; Mon, 23 Nov 2026
 19:21:24 -0800 (PST)
Received: from 723974502065 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 19:21:23 -0800
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
Date: Mon, 23 Nov 2026 19:21:23 -0800
X-Gm-Features: Aa3M54q6MdHyMzgb6kPLo2sKYPoa9HgwIHJfl5UP9FxNmXtO7vZ4QD_33O68uVc
Message-ID: <CA+OT+OMXvfjXQKzXPbTFzECXyNqFLjncKF+ga0bt6TcwhC7RSQ@mail.gmail.com>
Subject: [PATCH] vfio/virtio: read migration buffers and f_pos under migf->lock
To: alex@shazbot.org, yishaih@nvidia.com
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

virtiovf_resume_write() reads migf->buf and migf->buf_header and checks
filp->f_pos against vhca_buf->start_pos before taking state_mutex and
migf->lock. Because virtiovf_pci_resume_device_data() opens the file via
stream_open(), FMODE_ATOMIC_POS is cleared and concurrent writes through
duplicated file descriptors are not serialized by f_pos_lock. A racing
writer in VIRTIOVF_LOAD_STATE_PREP_HEADER_DATA can free and reallocate
migf->buf_header under migf->lock while another writer still holds the
stale pointer captured before the lock.

Move the buffer pointer reads and start_pos check under migf->lock after
checking VIRTIOVF_MIGF_STATE_ERROR.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only due to lack of virtio VF
live-migration hardware.

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live
migration functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
 drivers/vfio/pci/virtio/migrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c
b/drivers/vfio/pci/virtio/migrate.c
index 4b1e5502f0a..5e47f349511 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -918,8 +918,8 @@ static ssize_t virtiovf_resume_write(struct file
*filp, const char __user *buf,
 				     size_t len, loff_t *pos)
 {
 	struct virtiovf_migration_file *migf = filp->private_data;
-	struct virtiovf_data_buffer *vhca_buf = migf->buf;
-	struct virtiovf_data_buffer *vhca_buf_header = migf->buf_header;
+	struct virtiovf_data_buffer *vhca_buf;
+	struct virtiovf_data_buffer *vhca_buf_header;
 	unsigned int orig_length;
 	bool has_work = false;
 	ssize_t done = 0;
@@ -929,8 +929,6 @@ static ssize_t virtiovf_resume_write(struct file
*filp, const char __user *buf,
 		return -ESPIPE;

 	pos = &filp->f_pos;
-	if (*pos < vhca_buf->start_pos)
-		return -EINVAL;

 	mutex_lock(&migf->virtvdev->state_mutex);
 	mutex_lock(&migf->lock);
@@ -939,6 +937,13 @@ static ssize_t virtiovf_resume_write(struct file
*filp, const char __user *buf,
 		goto out_unlock;
 	}

+	vhca_buf = migf->buf;
+	vhca_buf_header = migf->buf_header;
+	if (*pos < vhca_buf->start_pos) {
+		done = -EINVAL;
+		goto out_unlock;
+	}
+
 	while (len || has_work) {
 		has_work = false;
 		switch (migf->load_state) {
-- 
2.50.1 (Apple Git-155)
