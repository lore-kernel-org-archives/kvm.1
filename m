Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2533C414F
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790659652; cv=none; b=QQU9S5J2FDPTyjEDPML56WutbLoiGHyMJYnb4WZk+FKdF0jS/yt85CWLo4e2ATb0Xbh5FrmJk9OkKCsNheh/ggtaGR7iFYXyux3a6t9tLAJSm4HEHGA2lQcAz86jqz8renQoGxwkj6srfFZg+5G2UkuV6LAn2DiEt8ATTN1pnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790659652; c=relaxed/simple;
	bh=qEEI8aktSwTOLRHps3xZRdfVtwrSTMCF4gmb4m+bhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOdLnZuyAs07X6qtwGucsHqXx3ezKMzCWCpRgUlE6SLTIatO4bPsifGPw0HqIfW/f0L+H5cqnJ/ViYkJjTU8hS2aquQhiFg/Z8qxc25/t7NTV3sqJxPOOzwxwVUgTIrm8UlJ0NqRb/qZvu6/zNSXOUfgjEwj936mSW+2J5/iBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2PP1ieP; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2PP1ieP"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso4379312eec.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 22:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790659650; x=1791264450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8QN8snA6KWfiFUHUmB9j8vT4kxR/u7KkTNc9IaHvVk=;
        b=Z2PP1iePjB3jUJUSZ5uSiVRznFUG2v6amQY3UIDopqDnFfHH5jOEUp2CflB/vKVpbg
         Kfgkvt0+Sg30NVjT77Pn4uHfgpJY57RcP+s7kK3l0M5DyYwhQbQqtwedHKuSQIcAF0MV
         llZwgsBKF+PxC7iyxBL9tj8N1k0H7aU6RdYa2RJm0N8sLHzvcjIFRRxEMFeEoOEh3ado
         9dcFf6D5fTTuT48ZSZ31ahIUerhVbUZaNTO1f6emAOYmp3EiWQxX98NqgwicI+XfPDQr
         cVLsALd7K+Sx1Iy/3OaI7EMqLAshodR2HainmQnOIeC+Srr/UnVPR7ZAOYbcT9br40+p
         Z6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790659650; x=1791264450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8QN8snA6KWfiFUHUmB9j8vT4kxR/u7KkTNc9IaHvVk=;
        b=P7cZzNCUK101Y730T+KhBsS6NeH4ipKzebLwrnwoo9RwlN1fqV2qNo6Ng7cYZ8Vu6k
         847JsZuRrkV/XbRb8nmxxrVjcGH24SilPZwKVOXA86amKp9ak5Xyl7RIa6oLQQj5VwXM
         rwlBKjWDlxkE+Rpp0rwm3DT6GGUaSJVaPkq7O/flkb9EqO0SQ/kOaPkpVczrHxiWPr9F
         c6M42npL69a+UsYAtrBCqbUXQ7NHSq3hGO9pd3iF+rgBnMY+IjhHWhrDPsMiqFuM33hw
         lxsqQ72hP1kZaMS6qUO0oFvh3DrTWBI0LB7R8n1qaYP2onzzFpAKGPQePpSFOPmMdqVB
         T44w==
X-Forwarded-Encrypted: i=1; AKwUvBxbycbtVKFsgew7XT1G3YarM0Oy7ZNCcz7ZNw+y+19YffM9p1K4aiTrVonNRUYt6XXpBJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFd+js4+tIDk6M3Ej7yFK1vRHw341xxfQwURGZl6O59QQm6URG
	Qie/ja++ehRAMRINSn5CEifDKXUP6rhViCQqB7PDemR60tPEsiFVE+2dBjmcU6vS
X-Gm-Gg: AYBFou224rSD5AOcq+ZDTNzkK5hxM2YbcG5RCff6dhaQolhUK9SPnchjFNAhVfA0kaR
	fXEZPRxWOAU+nBTMA+8eWJmCcltl3EwokcRB/kVupW5JFeTbbNdLlNZAZhqgr/Ogct3hjyZvBWS
	q8TksW98OCk3U3aKllYvN5GhLZbWuQZJmjXRmcpqz3Ox5hC0x+L7dzNYecO7taxGtZNK0IrXuiX
	Fh1vVpBxBUxHgndvR/Ll8rhp9MsWOdgrKLySY8AyQaudKkbZtqLRYyXU1GkAryGdWpC3biUZh1b
	yS7qszs/ZuLOEqgKwNHpT0f+VaURzbhXSk3mB//fY50AvfTeOVDCMHX8R7VG6ox5Dey96rYq4CE
	FL/I6T7RBUGM/j/gGfcmt9IkYCeq7qcFEh+3wi5559clqiv2jUiwU6R4GWS9z9d2XKvxfpb2cJZ
	OJxYh2iMDVMCzjyZfGSrCoKkEOeKg9IujpHcEfYWUlIdBha4Tiru48FH8F25ecRF/Jtv/414fba
	SFzDgkKvEqFxRGkPo0lhg==
X-Received: by 2002:a05:7301:4204:b0:342:810b:9554 with SMTP id 5a478bee46e88-342810b964dmr11955549eec.32.1790659649933;
        Mon, 28 Sep 2026 22:27:29 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34b580fc50asm2092057eec.14.2026.09.28.22.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 22:27:29 -0700 (PDT)
From: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Xianglai Li <lixianglai@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
Subject: [PATCH] LoongArch: KVM: Return the actual error code in kvm_pch_pic_create()
Date: Tue, 29 Sep 2026 05:27:12 +0000
Message-ID: <20260929052712.470413-1-nagachaithanya9911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_pch_pic_create() sets up the default IRQ routing and reports every
failure as -ENOMEM, discarding the error code it was given:

	ret = kvm_setup_default_irq_routing(kvm);
	if (ret)
		return -ENOMEM;

kvm_setup_default_irq_routing() returns -ENOMEM only when its routing
entry array cannot be allocated. Otherwise it forwards the result of
kvm_set_irq_routing(), which also fails with -EINVAL when an entry is
rejected by setup_routing_entry(). Userspace creating a
KVM_DEV_TYPE_LOONGARCH_PCHPIC device can therefore receive -ENOMEM even
when IRQ routing setup actually failed with -EINVAL.

Return ret so the original error code reaches userspace. This matches
kvm_eiointc_create(), which already propagates the error code from the
helpers it calls.

Only compile-tested.

Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
Signed-off-by: Chaithanya Lagisetty <nagachaithanya9911@gmail.com>
---
 arch/loongarch/kvm/intc/pch_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 2b63b0c2c7ce..7fee60ae01a5 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -444,7 +444,7 @@ static int kvm_pch_pic_create(struct kvm_device *dev, u32 type)
 
 	ret = kvm_setup_default_irq_routing(kvm);
 	if (ret)
-		return -ENOMEM;
+		return ret;
 
 	s = kzalloc_obj(struct loongarch_pch_pic);
 	if (!s)
-- 
2.43.0

