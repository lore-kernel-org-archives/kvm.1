Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795349366;
	b=KFKLV7V3dm99WkgvrYguZtXQdkRx9Eg+r6P+wE4g+OV9nnRQ3oS7OcD5sXnMPc+2GklL
	 X/VKdYBHqSqjn4JEK639KzqIyLt8utjvfrtzVgYewhXkWwjFGvn9Lpi0nPh468jQFy/Od
	 D53zLGe+J3I/oxyZUhLuyXMUGbNauyZo5mImbdKR+TxM3UNi+JqRi5Oz1flJ7eRuTvpz5
	 UysTOI7lMqK1T0rjdALDyxpwU9Bq/fPui9pA5p7QohjBZyC1iJk2SdyXe0p+NrJzL7+1q
	 hausU1a0YKVmb6bCfOncC+L7hfDgMMXZPNddW4exY5Zfaw5ka5n0IoR12aT6Qb7f1SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795349366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
	b=BJwYXR+O59+69TjZpYzJVxZtvdKIC++dzZkV0sRCQiawCsKfJlSc+elIy122CHEWMDOX
	 SenoUWocM3rzLuhmCm7phi7sR0obW2rC9swCUfUyJ9OYofOn13IuSmqucnsSJvqFMj4/B
	 JymHzxFLKuS41wLFE7mhh4pG4a9X83X7FChh+3Wch67uvtKhZbbb8l/OtcWelJUbv6g8e
	 gmLhjboYJKtJOZO8izbkGB3KHbqBmvTKHouKuDlYJ0+evWtaBsRZrxdsVtq2D952unmo+
	 bkRtkpkvxe+KCuXuh0FyDCCfaTzgOn1obf4Kj5p5i6YS/4BM2/WYiyyEuowQb5aVVww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Iv2edekw;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A471606A331
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A471606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Iv2edekw
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67da62357acso3177324d50.0
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795349364; x=1795954164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
        b=Iv2edekwCcVIQp9JIMsfLhk6KtoiV0WhRuD1FoDIRhUZsxLA2kgzsksYDDlnY5NdLj
         QTmbmISW8g0su/g5+BFFz+65uDTd6p7xZ4n5+iHa21Cf9mBL/0iwxOGqjUi2dR2vr9+O
         UyN8+2lSQ4KEgbwZTJIMOzO7HpzYQW1qneGMuVKZHYveD1XscsYYGBp1JauYkNyuMvpb
         DQ7lS29jTR8iypzv1awMBPRFuN0pyyKlUiDxvXF8n04RhcYHVGPSRlpXAdX1TW/U8O78
         8HbEkFnVxM2h4kREUrWn+N5bIMsV6ge5D3B59Kkdro3yg6DDF/VJptuL1Q4Aj+GXRvTl
         WGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795349364; x=1795954164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vo8KO2KJ+xe5NqcgWpWn5sRi3V4otNrp6pD7wdiaeIg=;
        b=aRiI5gOpioqS4glPTNC81MKs9WW9Bb3+4PBoB+lT9vDp9HdzqSUB7pyK8V8huQSKFB
         SCq/Z2jpnshaWIaoOBwfhbCL1rvgTRbW9z2K9UQ08QZtvJmTK8qlSIaFu21OILiPn++o
         +uPYHjQq4OH3JGFHOCnvDD5COtCtOmakWe4P49l1VGoP+VMmfseOkzTcuNqm4GRu3mcL
         eEyD7c6GcBkBfDk/xkuDnpg1WlHmsWiM5Fa3jcuvYsz1/pCGEa9qC6309XSr3wmok02h
         ey2FgIA2l4pxQ0v7Mgu3WBSnNoShxJ9MaA084TYxD6vD4gmko92jKUuZDk7wEGUjWs6s
         WFsQ==
X-Forwarded-Encrypted: i=1; AL+hErG9+7LKTcfyuKxTGh5zEzl+1ygI3hac1M+SUg5ykSCWLl3IXOXHzBpzkOaqaK2DRF3keNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aCxHF5oYYNLB30M+xFEp1pl124LzpL5Gg6RUWfuPeEycNotRX
	Am+KLRyRr8inCRYInKms91GMj3lNs3LqYVqKD8iUHwqUkPJzBH4isXJhfmpJIk7qgg==
X-Gm-Gg: AZFdTZc5IRTNviKeK/4oLmALsbmz4Lfk5hVVYz+pbtSpTYd/M9avmhJPtLa340wwrEU
	qP6p+n+JjB9oGkmfSojLdxqi+p/87SyPgCJMZPWTcGRA76Kmz15bpBG40Fgr1/rlCFucworSMQv
	NokIpRB6r0yyOYbW6K1KfUEF/LRvq1hoXOtTIXrUPSdTeqJOziGRof8Iyr09yGK/6ji6Wo+c/hu
	qONXru6gpFASpoSWAjEZ8/rljeEIsA0imgBKC7CmhP0JOMxeBuDsYlr/B/Fl/IHJc8Jr715rcIg
	sYt655cpgx0pm1IoHItNbTTmZBUsGXwfRIRkJO9+Xcflg4/2+XjZlV4/ZV0e6T1GwixmGg+az0N
	F6t/Ysv29l7donmVhbwPpe7XE9t49f8fB5lSsqpM0UuclVhQw2OovnNYI6E/aWLyrUN0OkcBWtq
	yjeyQYOcRMu7GDMtherUc8E9BJxE2WPVgljUTdZy/UOOZQ+fn/U4wKSDpNw0LXmeEEgApjC4RFV
	5MzSJfWX2fK7ZrLmedG06waHcWYhfmtHTI22r+1aHTzefJnqesCjySP6razknGyEyXcJpcyBhxL
	tXV33hJFhIn4HobZ3tQ60qelomILp7UEMxazQmsCiks/f1t3cFdH
X-Received: by 2002:a05:690c:6088:b0:8b4:d26a:aa7d with SMTP id 00721157ae682-8b5204ff21bmr37330077b3.56.1795349364614;
        Sun, 22 Nov 2026 04:09:24 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201ba5absm34801557b3.4.2026.11.22.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 04:09:24 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] vhost/net: bound the count of VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 07:09:19 -0500
Message-ID: <20261122120919.1718445-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit 333c515d1896 ("vhost-net: allow configuring extended features")
added VHOST_SET_FEATURES_ARRAY. The ioctl reads the number of feature
words from user space and checks that every word above the supported
ones is zero, one word at a time in a loop.

However, the loop has no upper bound and no scheduling point. As of now,
a caller can pass a count of U64_MAX and a pointer into a large
zero-filled mapping. The ioctl then stays in the kernel for as long as
the mapping is readable, and a fatal signal is not handled until it
ends. On a v6.18 debug kernel booted with preempt=none, two such calls
from a non-root user, each on a 4 GiB mapping, froze a 2-CPU VM for
56 s with soft lockup reports.

Interfaces that take an extensible structure from user space limit it
to one page (openat2, clone3, sched_setattr).

On a KASAN kernel with a 1 GiB mapping: before commit 333c515d1896
("vhost-net: allow configuring extended features"), the ioctl does not
exist and the call fails with EPERM at once. After that commit, it
fails with EFAULT after 26.0 s. With this patch, it fails with E2BIG at
once. A reproducer is available on request.

This patch will reject counts above one page of words (512 on a 4 KiB
page, or 32768 feature bits; 128 are defined today) before the walk
starts.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on the vhost tree at 44293796526f with KASAN and lockdep: counts
of 0, 2, 3 and 512 words still succeed, a nonzero word above the
supported ones still gives EOPNOTSUPP, and VHOST_GET_FEATURES_ARRAY is
unchanged.
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 631855064b3d..22e06b44d2ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1795,6 +1795,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 	case VHOST_SET_FEATURES_ARRAY:
 		if (copy_from_user(&count, featurep, sizeof(count)))
 			return -EFAULT;
+		if (count > PAGE_SIZE / sizeof(u64))
+			return -E2BIG;
 
 		virtio_features_zero(all_features);
 		argp += sizeof(u64);

base-commit: 44293796526f4343639f87b2acc53811c78b5d54
-- 
2.53.0

