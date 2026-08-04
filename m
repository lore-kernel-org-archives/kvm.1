Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E13F8883
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812189; cv=none; b=QxnAIEp1lVl51iOnBJ7V2TZ8ojXFRJqeH/sDYHvRrvsdNtHkDvZeu02gBtgyHhUah+eUgFl91Vw475q63Blzl0LaLz1XuylzLFV2WYOHj1FMn9wRxNltCTVUDwNoQgmReLQltqanX+OgkqJgjfptGJd1F0UhR0j/UOdPlgtmpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812189; c=relaxed/simple;
	bh=zqrmGtNYwoSSlb1WHgT3h/cWLH0pWZUE4OokQlWtRek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC0/wOHI/Bfx6ZPqFOLyQoXdoWsvM1iLMBucS61MSjrnpNZz/Gn1XKCfqNJLCQGnKJxjVNLI8CT51/34fJHZ7GX65aMpbDscvk2EnhXHEJ+KFh9+Cryf28ALCWYNc4F32ScNpU4pV3s2gi33HZLUQbOHaUJ+2/9ojkhj6W0pZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7yQpDaG; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7yQpDaG"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381b831d535so4579969a91.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812187; x=1786416987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z1yxnvuZRVlxtf+BJKMZxwYjNsgm5M4Tjb/ynOLuWlk=;
        b=L7yQpDaGnaM95Z2wqzD1DbzPkNt69swtGsm/6n3ch9JPzF4qqe/UsgMJMQbnqpc1nh
         hcGYUyZgk4YbVzghGlIxg00VGx+48vPWp/+c03ZasT46QFT4pRmEaE4jnPz9qAAo71sE
         Dm/IoJDix2qqSamn70MXZUGU4RngOT2io3oV8CEnRgq+STsMjsuTAQIVIBre/GjZQOhb
         8lOZOx15CXt9tAby49Ug3r2x5xahMU8/0upRBaQVTdmbDSyxcYBhY3iPfYYFgkcI/6Kz
         hkHCC3CveF22HtuYV/3qaLgKrDe0fdEG91c32L/npGBP97aipW/Ok3j7CrX/Q+FyD2lQ
         SOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812187; x=1786416987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z1yxnvuZRVlxtf+BJKMZxwYjNsgm5M4Tjb/ynOLuWlk=;
        b=bNsxdg44LftQ6Q7Q5w7k8Z5qaLDkbh9n2Pyn+QdZssdRByOTYMnreWYl1iAv8Qrs0e
         6yecyk/drMt+PRN5GM9GemGzwS+meLFER0tdN2QkBi8AaaK0LGGtbFTm2ZVl76jrNe3b
         ftxd4ojXHqj6tHuBZqKOlBY8VcEQq2fygWM9u4tBoCpoVFJi7AEz5undObfTZ3fJ78fx
         syxjTNZgskhWN6JsNEuAl+19Ixnw8wYM+GCEiz3WCcRHrrd8txhxNCdh3smJTJabyGZ1
         TOo32k9O3SLgRIXL+b/2naVR+IZlSK/K5I4osns/j550ur62ZwxK9cSsKrjDlxV4Wntp
         SKNA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3bPKMI3X3C0NTcZ2hCT0J372tqIDgGYBga3KxdJMup9zVCn6mWqXcFGMZ/mZLqg/j4r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHCBpfCFWhvPxo4rqsI+aHiC+mnIZycOcRo7P9uAVBXgz3pj7
	9x/4AMHH+kTvAcZ0Q7d0e49YLiawUw4p3768yyroItzOxNEBU8u4Z3kcy3XXz4Edx7O9+uJ1
X-Gm-Gg: AR+sD12pyKdN1SxMlIXAHpG9gI/5TVnAuCr3zHPSz6Yo7AeZuDqhSbRaY9RtrovaEXC
	Aw3OlD/FSuHxWtlbRV9Xnac0ruFMZGlqPBHjC/oXcWH+MbQEgP+joQJ0nJcKEagrOOLTj0Ss6hM
	G1/h2807z+bltBBkDSZvVbEm6JD0qy/143+zuNdZU5zhfNjks12BVSAiKaGzVOf15SmpagTF5hg
	OCwddRgTz12Oaso0WdL519tqkHdFXYd9+QgM6OV45aOZwu6pQnRghOIcixfSjdEMKq4dNQPeWt7
	mrZR6t81JOwgnlBs551rm7hrfohCBxyoPPlG94VSE2cepgRJOBgbfh3uxpGSXxw7QBl8PeWUVP8
	dThqtoWYimeiddl6/aw+kOiwxIHNX82BWf5gIHKZ+lsmPUK/Qc49n3WPaPGFDXX3/Q8BOpOA5jt
	RJZsRzMjpBFnul/CvfvmQ5oSsKpHmJ6xDG+TCdGIuVvjdjFrTcGgTUYpqp4KNoPOzrYUJnW/km8
	davBdBUQAEGH/cCsIXWaHp5Xcg=
X-Received: by 2002:a17:90b:590c:b0:387:e0db:3fb1 with SMTP id 98e67ed59e1d1-38fbc59b1aamr11609901a91.42.1785812187080;
        Mon, 03 Aug 2026 19:56:27 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ef2sm45373175ad.4.2026.08.03.19.56.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 19:56:26 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: netdev@vger.kernel.org
Cc: Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost: reset the vring metadata cache on vring reconfiguration
Date: Tue,  4 Aug 2026 10:55:29 +0800
Message-ID: <20260804025621.16580-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260803014823.68623-1-juny24602@gmail.com>
References: <20260803014823.68623-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
metadata region, and iotlb_access_ok() returns early on a cache hit,
taking the hit as proof that the region has already been validated:

	if (vhost_vq_meta_fetch(vq, addr, len, type))
		return true;

The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
device IOTLB (re)initialisation and on vq reset, but not when
VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
VHOST_SET_VRING_NUM changes the region sizes.

With a device IOTLB attached both ioctls are accepted while the vq is
live, and neither validates the addresses at ioctl time: vq_access_ok()
and vq_log_used_access_ok() return true early because the addresses are
GIOVAs, deferring validation to prefetch time.  Once the cache has been
populated that deferred validation no longer runs -- vq_meta_prefetch()
hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
translating through the old mapping as

	map->addr + addr - map->start

for an address the mapping no longer covers.  vhost_copy_to_user() and
vhost_copy_from_user() consume the result with __copy_to_user() and
__copy_from_user(), which do not check it either, so a subsequent used
ring update or descriptor fetch accesses memory outside the region the
IOTLB actually maps.

Reset the metadata cache whenever the vring is reconfigured, so the new
addresses are pushed back through iotlb_access_ok()'s slow path.

Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
v2: add Assisted-by and Acked-by tags

 drivers/vhost/vhost.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..77c96993100b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
 		BUG();
 	}
 
+	/*
+	 * The metadata cache holds the IOTLB mapping that backed the previous
+	 * desc/avail/used addresses and vring size, both of which are being
+	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
+	 * region was validated, so the stale entries have to go.
+	 */
+	__vhost_vq_meta_reset(vq);
+
 	mutex_unlock(&vq->mutex);
 
 	return r;
-- 
2.50.1 (Apple Git-155)

