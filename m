Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506854;
	b=u5mgraiqs6iX8AHUPk0LTNjjRTPYZeUMXWJqEUGgp4lK5z1gfJOGAyG2Tn/lLiBXiXsq
	 k/2ouXr/3AQ59HY6ACM3rVL6L7BrUKyD7AjAgMuYHBXhZhv4KxOFllHOtXKyfnHyx/fzg
	 pBkLyFEChhKTwx7MxcNWTOgA/GbPvIcBmYvwp10hSpy+zNqvdFbHlFWNJOOSLQ1//GEYH
	 iMC22JQ7tbSatY/I8QYOb7L3qBfrtcC6m0UCmiCwB571TlM5P3np0DwW3JV8DK/2EQWfP
	 M4kSszsCpawsKej/GA1TBjR0WYn5Cjbl4mYV/8puCWfdYtvfkMAUGBDOvBC8fGUF0vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=be8DTSqz0uRSjqK1bO31t20Nom7D4O8lZZJ8fJFQHwM=;
	b=PRD/fFCL1Yr7zAfEB4v6A61B2oIesLyulMR2nTjpxTOTtiby44pAmFThGTX7eLuig+2E
	 ijPaaxYo2zxShef7gC6kG3DbikM6FjAYsCIM3r4OBw4x9hYuzFc+ayilaSDTm/2sf59PG
	 RS7cZa9aPRnGXPdFWi3z9IiDepu7exAfUUP4I4r1to9avd47uH08oqoJ4qOcYRAXS88wy
	 anO553aRp5o7MmwzqzAkr5WUDnMGCSoih04ulMfNkQpq31ncDm0hOP8PP5WiPiGmkm+DB
	 yb9QV4h6KeqjKBzhM9LY9tHGBYE2Q3sfInw7WV+oFY5STpRtuWG7XChAZ2UYwXEPJ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pif0aZ1/";
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E0606A326
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28E0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pif0aZ1/
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so1861124a12.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 23:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795506853; x=1796111653; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be8DTSqz0uRSjqK1bO31t20Nom7D4O8lZZJ8fJFQHwM=;
        b=pif0aZ1/Wunoh1jU8UkvwMpJYM2c71C7csSIrJyX5IKzd8Y8RYQLdhZ38mYGeLBLmk
         D+LaLh1Cr4ZRFDXcD2S21LK9A9pjyVT/6kguNjgaVTiGARBybDUtVSWKXWNh8oq0355Q
         txI2+OHxrhhNzjqaWKJe0efOzB77EXbRpEXIvnRFe0dWQ1Z5kf5EDGLNKQXK1IF7P2ql
         JYL6SIxtuUa+ikBSle9xecmqLLeUJYMBNg6pg5n649CwCB5hEdHA2m2HzHG8f7oYcXfp
         4RgzpnQAyDHXGDBt5B+INUZkizYNI26CdR/09A1quY6dzO6DT57L0lRTruO/yTI/h2zk
         J63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506853; x=1796111653;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=be8DTSqz0uRSjqK1bO31t20Nom7D4O8lZZJ8fJFQHwM=;
        b=llFwVVxm6sVfYJmqKBtkI5V9h+uWJjTd2Rq07U1JbAkk42Hn5CyD3XBPz3IkE4xQnC
         5WoMtN5qNciiiTZMkSRsasQAo8TsNiF8E+95ppmvJfaL88+4mPiayx9wgNvlS6O5V0AF
         gQDWOQ2UY4ummJTrGonBywkqo3LapLtoQimaE9g1mC7FLZTx9pG1R775z6ZSVBbdFXJ4
         V4U7dcv+I3S0piz3jBpaynQQJUpzjoa55F9UnvP7lR9rCc9ueO1WAmHker30Px0ocPHE
         DvbXHGJ6PVk45B2oXJRdbkP56iBPTDPRf4GguThqYoQX5xMjogIhvd5vrbRB6uQpT/iH
         mQ7g==
X-Forwarded-Encrypted: i=1; AL+hErG82FijfCEqMl+FD5eXGgh9j/0xRqI7y2CQB43UUwTFs+SOZrmYrtW4VvNS4RDq0LObzGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z22cU8tnweai1bXdCUZvXD6w/7vCDet6hO6V6euyyrrPWwlTs
	NCtIX74G+tUqqDYJqE+7DFW9bwp0JMqps+10KHNf1z81xIRYLEA4c7hB
X-Gm-Gg: AZFdTZctvr1kgE1BJ4rhu0nIBmJNiKzNBg07wZ2i7Jc+6m4yNz8aPWIhFZNqJxYPC7p
	hX1iJ9N5BrEwIddqb7m/vci+awUn928F+7J+iRBaVLM4TwgFv5N4HXu3A6PiPa53ubVtXNHzVJc
	1wptrIC+oymosvfgK22xKiVimVgwycjJfhKf1TmLDfZnu/uAg1LZOINkjIvZP+nYqNGwZpRftmb
	iJ7jXBYUQfkII33Lmees8HTMqH3pqHjMq+NHSDeOxUzVg5Y9BaYP5034QJMouE1P7OVqqrj07vW
	YY51xhVFRodMz/C+Jx9WP40OdjkqKUuLD5uYywjACkD9jZqFUj+0ZNuSkeiUwBzsKv2wEG09Vwq
	JkEAyedTDr9jG4jXcAkXmW2VmhU9d0xyaxqPnhJcC6cg2R3VbmWQOfwM1j1pKld4PGqEpmtT14m
	Cn6PMyCU2fJt2+bGxd6s7Ay2kGZeO3AKiD/a0pDRnaPHA/6m/1BiW16jwt94g4gO5jlo7cXo5j3
	YGV42TUGn+WuDhKFM53e+bkjZ7ayN8Dv9OXK6DADSgg/u99jrdFuDdtnfDuY3PCK3NbXAeL4AJ6
	dpXmOO4cqR7l+KeHurtBO4f0rbIvGAAxK57qgUUsKFi14TP4eIvh8dw0fptK0lkLvs+4PRFl/Ml
	qpE8/FY8eenmBiALzMTAsbbHXDaOZneWoKFLx
X-Received: by 2002:a17:90b:3e48:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3b41c98a343mr10773859a91.22.1795506852965;
        Mon, 23 Nov 2026 23:54:12 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm24871009a91.10.2026.11.23.23.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:54:12 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: alex@shazbot.org, yishaih@nvidia.com
Cc: jgg@ziepe.ca, skolothumtho@nvidia.com, kevin.tian@intel.com, kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v2] vfio/virtio: read migration buffers and f_pos under migf->lock
Date: Tue, 24 Nov 2026 15:54:08 +0800
Message-ID: <179550684893.38679.618538654837589800@gmail.com>
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

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
v2: resend via direct SMTP without line-wrapping corruption in the diff.

 drivers/vfio/pci/virtio/migrate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 4b1e5502f0a..5e47f349511 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -918,8 +918,8 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
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
@@ -929,8 +929,6 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
 		return -ESPIPE;
 
 	pos = &filp->f_pos;
-	if (*pos < vhca_buf->start_pos)
-		return -EINVAL;
 
 	mutex_lock(&migf->virtvdev->state_mutex);
 	mutex_lock(&migf->lock);
@@ -939,6 +937,13 @@ static ssize_t virtiovf_resume_write(struct file *filp, const char __user *buf,
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

