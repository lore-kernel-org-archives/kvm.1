Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58487479861
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351549; cv=none; b=uZPmJc5aRdIEqaidqT2XsqVG/qHliXhfL0C+OGtLsi2Qk4Trgi2Z60kkficqDXP7JI/RJumApm/5sobgHAIa5z0mzbh4axSbqgf2t9bXBGX0ELpEsj5Y8PhtvmokYSlM9Ii6L1wuDe65EGjRtdkS7zwESDen/3THp4M9PgmE3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351549; c=relaxed/simple;
	bh=6OQPemUbrtEvn35mHWX6wGaAzq7fYLjqo+G0OX7yMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaSu/2/dYo1sXeZDbw+I2Udk9Mw7zsJfWUsUvBNlIzdqtsf9aNdSJW3UttyaA8Ab+7UDTbCRIf0WG5/INiQGPM246iywXZZE2fLq7pvvgSJG/NFq05gFb0WqfxdUBGOnmzAgQcYZd397/Okb7pNge6lQOwQyZ6hv47LUPIJpfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGEUikAx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGEUikAx"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8485b358552so1503632b3a.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351547; x=1785956347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCI3GixEP2KXXtfpULqWtW8LurdBltars+anz7Y6MWw=;
        b=qGEUikAx3ZPCvNiZ9YoJerKvYjbWQzgtQyR13iIh4thtXE0DkII9Aiqy7GYcyXlDph
         TTWpSB321t4+KrWUEpfpp8B685mtBDUAsHIEUJM0biWAHFEp9eJoVUgetYy+7Z1GIKmk
         6Ej94LMh6BN8F+SKxZVr+fWNi3qt4lq+56z3Ox5mNwg+eI6yda/FhiYAMjz8YxdASo3M
         1Ue743G5EdCOWo0LLuT24CTjWSKyGAUG/UZi+FBJv0sJPco469k7lArObCuNH7HusZLX
         oHQzqqDDjwtrU8/YmBz34w+XQ+De9+9lz+R9g8Gjpoo2OVl7ObTQ5wiFSH3UCdPch4Dr
         XXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351547; x=1785956347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCI3GixEP2KXXtfpULqWtW8LurdBltars+anz7Y6MWw=;
        b=m4MemUZ7VIQRK52/wfKcNivoqYH6obh/p6BFlRUiRoVulzNheWge63JeQx101aTIl5
         iW7WYRPt4hjjttuGQAGNqawTOmsACxn2BndmNU88PyqdRg60LoVyk4ciyuLYMz7QSpe6
         GCEzQHV00/E0lNPSekfHzZUX2RLr/EHsszlUNjvwvjSPWRINbgB60hewRdeWiU8LwS/a
         WW0DyXj9ZC/N1ToAxk8o79XeJjMPHXhMqkPFaoqJggSJU//36JTAsjT+eyTqH7NA+XRk
         ++FCLj4LtItcR6uB+sHBAG6j+/F0CDh4NljZpbPYS08rRi/Cm7PECmDMk+9g1RmqCuVp
         0eDg==
X-Forwarded-Encrypted: i=1; AHgh+RphdnIHUvZmAGUdi187RSfrKRrlIYfnduIK8dYmZXET+PTcqmn3eEeyhRRJ7xhRffptvGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2RqFPQ2dNQqU6ZbCTGY+dVowMuiLbLSn99rrypJoIiZ+e9fk
	U/bcb4Ui9hKZwgrrDrlQm506klEXu+VX1wrWLEHRO8BgioLXhfOx2iIN
X-Gm-Gg: AR+sD13T5xQISmD+c1bI/Zd83xU3pNQKM72SKYM+NnWHVCWVUpKdaXb45QKBieUGymz
	CiX1+SVmpbA2TzHtm7ijSRhcZvlSHFWnU4coUjdrbmWum+U/Y0a1C82rGkD+f4Zpy8SzhLBsBtJ
	ISbTzDY71L9MZ++Nrtkeg9ui1CAZ2H0h0oHmXkzeUR6jXk5b9Cx7Eq4znyBIvVXG02XP6qtoeU6
	D7AgxT4X1B+gkp7RSIFQC9iEeCYvITjQkUf3e6a+jeavQZHaPNYfgjThddOGUvio4qTKz1M2W+b
	LDvrKcDADbZnylD51PbeLSK65uw+3XrXjL7IGekpPv7d7MG7x2c6ris7JqAhBhg1WTxR8Ymn79R
	nlPIsDjnDWLz1yFis74P9DYyu1JHrjTrGg04FAfgG/EezLK4DBV6jEOo7srw1fEQaBNVqxpdpPO
	4v8VgzYTYY4m10Ivw5dq1Xffi76wxtJkP4W13ZpfYbToYpma57kv5sLKvqO2dphsEde9mciJuML
	exboLA=
X-Received: by 2002:a05:6a21:730c:b0:3c0:9c19:6586 with SMTP id adf61e73a8af0-3c8ba5daf6dmr9429868637.64.1785351546675;
        Wed, 29 Jul 2026 11:59:06 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:05 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 0/2] vsock/virtio: fix worker access after virtqueue teardown
Date: Wed, 29 Jul 2026 11:58:26 -0700
Message-ID: <20260729185831.3247971-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-vsock workers can remain queued while freeze deletes the
virtqueues.  This series prevents workers delayed across freeze and
restore from retaining pointers to deleted queues, and prevents the RX
worker from refilling its queue after teardown.

Changes in v2:
- Split the worker pointer changes from the RX refill fix because they
  fix different commits.
- Use bd50c5dc182b as the Fixes tag for the worker pointer changes.
- Keep b917507e5ad9 as the Fixes tag for the RX refill fix.
- Use the suggested out_nofill label when rx_run is clear.

Weiming Shi (2):
  vsock/virtio: read virtqueues under worker locks
  vsock/virtio: avoid refilling the RX queue after teardown

 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)


base-commit: 51b093a7ba27476e1f639455f005e8d2e75390e4
-- 
2.55.0
