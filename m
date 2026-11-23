Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407785;
	b=Xd77ul3xBrqVqpvfXKuxZuMVPsiR5A7fV0eNVqxWMU0lGRCe2Q0WsHsqqDbsRSqy7/T4
	 SleM5d01Juz++h0WHnvdFo5HAjqb/vzbn5avuY6Do4SVegFc1oOrhYKkQT5l+MNfRMum+
	 idkLBUJDFxAi0TwihRt+xc9sb/S8WfAR4pX9yfQT0cy6ymliFZq4RQ3snuBNUm6aumyKD
	 ffBNOoOqS6xaorLQur5OedmEIrvJPgvwcMQKLueweY+xe//gwUOnCH7sHBIrM07xikarz
	 9zr7sgb0oqtaPg2ZqPkt8rZnlAu7UCi6qAvyCnNLwYxI7w/YUokztjUmFbR5pZhHXZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z7nPTI5arwtfLvJ1u0SNc3tfHxfngmeM3rWmqkRPFe0=;
	b=vl48i6Ff3xggvBrgqDjcEmq9L0wCfYwQDGvYtXEq888unrOkB7gEnaMnYQDNzErZPELx
	 Cupcxc9ot87RM01owVyqfOKnyB8PJuA8B0kxscnoOjqlI04Xu5q/f1TY/O9S2Yy9x2qdz
	 Y/hIm5hz8iHnQWNHpSgxQCts9GwDqN+xvqyHqEFzPu9tCv2z63c6oIYuO957HU9KR4SUk
	 I1W+CYwgG0sf6BNH1lqByP6s/nfyEouR4JuPwm0RjvrV/dzo6vmVLwjMESK0M53ZiQtfA
	 PYI2MkbmaeIygwT9mWTNedtafUABJsgePDJBul1P+mGh5Zo2+prC7zUgxia00cK/jhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Akvb2KTo;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D92606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D92606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=Akvb2KTo
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f20c3aaa5so270410485a.2
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 20:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795407783; x=1796012583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7nPTI5arwtfLvJ1u0SNc3tfHxfngmeM3rWmqkRPFe0=;
        b=Akvb2KToJ3Ak1XsuDnYKBtbnhh9DBx5jCOEwkXgnAWKJ1gOMmH78uj2GxxBO9gCO6t
         GMt8G8Mqg3loK9qNScCW+6j/7XOvuTeqYCQZlHM1+earUWSLsh/SpnyfnGV70d64iCPn
         6hvDtDHLV1GNruB06Gsukzt+tYEQ3lamByTnCv3vBIwLPmRqUNcdQl1qzCVH9tnVjpXu
         3zp+Ixy2fD4tL6Nyl3HL9sKrUcyufJGYp/c7X/CwpDeNtlSJSGClfjEqPDCnzSGwdrCt
         Q4LD2xw+qGpGsL1TrBKx1iV2YizypbOUYUfiSsq6Shnz3VoWUz9cg7SEZzBRjnTSABfn
         9BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407783; x=1796012583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7nPTI5arwtfLvJ1u0SNc3tfHxfngmeM3rWmqkRPFe0=;
        b=ZFmSLKsOSgCsuHbYhoNEal74T7y9U/PmZ1HS1Atnn3/CiHUuxwk4iJABICgFuk+qfz
         LdcPgLnCYYoQxosACLoYecNlHVvA5Xbn2mKUEQJZ+sZvXKeO7GhAwF8vSKMxwR4dG4ym
         XyotZbD7812MV2R+lKYXnp3X56vkMnftS1FR6UJwBKH/wNG3AyjGlrc4pIDfrNWLmtcG
         deTh07A3WmpRk8XAzO43fA2qdFUKBb66G0SS/dId6NGem35PwVpU+o5bp6+2LcKloVGR
         aqGti/E3CBYAXWYOXdFjgpVL5SxR6zO+FxeOWqRM2JUK7hNnVWibH4GrHDlDuqxoILpN
         9Udg==
X-Forwarded-Encrypted: i=1; AL+hErEUBd5h0l0xVRdiJEmrSfFPQtsfKnJlgeguzyLAyTHs+L+AKNh2Uw9urru1kyEBc4AoyVk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yPo5kNQPE0hgryylcrrunh4Rq5f3YAW1n4N7wh2QtsGvLnslk
	ITjF+TfqaXY5ZLAwXv5FcIZZXCtxXaCfZrilXfkFt2yp5EEvTuXaGtANh405L2lTcg==
X-Gm-Gg: AZFdTZfpP3jNECMfatzjk+/+BfLiZtNyeQ9xtnFbNeOtLS3t/ESzPY4BtLAqZPLcgBF
	80Is3/T9GJrxeaP9GhjX06qe5kBZt01pXFGsUg25wZjvGs/1lFfdIaKwxaPaAyzdH5gjBYcZqmS
	CKtAPeQJp/Roy0ISkUukOe+HWL4EUIsnUT+KFM0hXUynqYunzD9Ln6RvWuiRTIlccE6UpYHuxDh
	O7Axv83GXwROozO9pFieWu8IgsgfhH0qulpeF6JD9sEuparQax0Ort2vgYNCtWyuN0zj0VJUHES
	jd2DNv5AG/u5hkC9bR/VQmJG3tubenUiZNrxP+8SKbHfIbio9P5CAeGysAbDP9KmvwE+SrG/f04
	fOS0vwoRzyIgCwLLs6ArWIApX1UOBqyxaJ+8QfsDkyRxJwVIpDrN7O2utTNl2LlG3zxS/fkwg6S
	v8rhS8XpC87Omq2rlG2qLqT8RxJqNr24kQSpzAbKekzNe1ofL24P3f3ChvO4/Re+cRGux5MjGja
	078EZpn1PvbhlQD8z5yjB7dl2vM916oRHKadPX2WByiJepTlQz/HdRIl3JD459Z/B/J4yifsZ9C
	/+QVpQ9rZ8eXfSrU2TGjH8MudT024O6YyEyJ/snBG8/atTZ/+DvK
X-Received: by 2002:a05:620a:4397:b0:93c:8e3f:3036 with SMTP id af79cd13be357-949ba827abemr1807820185a.4.1795407783349;
        Sun, 22 Nov 2026 20:23:03 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34a38bsm717421185a.13.2026.11.22.20.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:23:03 -0800 (PST)
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
Subject: [PATCH v2] vhost/net: ignore extra words in VHOST_SET_FEATURES_ARRAY
Date: Sun, 22 Nov 2026 23:22:59 -0500
Message-ID: <20261123042259.3484334-1-hengyul@cs.unc.edu>
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
words from user space, copies the words it supports, and then reads
every remaining word, one at a time, to check that it is zero.

That loop has no upper bound and no scheduling point. A caller can pass
a count of U64_MAX and a pointer into a large zero-filled mapping. The
ioctl then stays in the kernel for as long as the mapping is readable,
and a fatal signal is not handled until it ends. On a v6.18 debug kernel
booted with preempt=none, two such calls from a non-root user, each on a
4 GiB mapping, froze a 2-CPU VM for 56 s with soft lockup reports.

The check is not needed: the extra words can only hold features that
this kernel does not know about, and they are never stored. Drop the
loop and ignore them. A nonzero extra word is now ignored instead of
failing with EOPNOTSUPP. Unsupported bits in the words the kernel knows
still fail with EOPNOTSUPP.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Cc: stable@vger.kernel.org # v6.17+
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Changes in v2:
- Drop the loop instead of rejecting counts above one page (Michael).
- v1: https://lore.kernel.org/r/20261122120919.1718445-1-hengyul@cs.unc.edu

I found this while comparing the behavior of different kernel versions.
I used an LLM to analyze the problem and to draft the patch and this
message, and I analyzed the result myself.

Tested on the vhost tree at 44293796526f with KASAN and lockdep. With a
count of U64_MAX on a 1 GiB zero-filled mapping, the ioctl now returns
at once (before: EFAULT after 27.4 s), and a SIGKILL sent during the
call no longer waits for the walk. Counts of 0, 2, 3, 512 and 514 with
zero words succeed as before. Unsupported bits in the first two words
still give EOPNOTSUPP. A nonzero third word now succeeds instead of
giving EOPNOTSUPP. VHOST_GET_FEATURES_ARRAY is unchanged.
 drivers/vhost/net.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 631855064b3d..f6b59def4a21 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1802,18 +1802,6 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		if (copy_from_user(all_features, argp, copied * sizeof(u64)))
 			return -EFAULT;
 
-		/*
-		 * Any feature specified by user-space above
-		 * VIRTIO_FEATURES_BITS is not supported by definition.
-		 */
-		for (i = copied; i < count; ++i) {
-			if (copy_from_user(&features, featurep + 1 + i,
-					   sizeof(features)))
-				return -EFAULT;
-			if (features)
-				return -EOPNOTSUPP;
-		}
-
 		for (i = 0; i < VIRTIO_FEATURES_U64S; i++)
 			if (all_features[i] & ~vhost_net_features[i])
 				return -EOPNOTSUPP;

base-commit: 44293796526f4343639f87b2acc53811c78b5d54
-- 
2.53.0

