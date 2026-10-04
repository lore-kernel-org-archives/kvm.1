Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326C40682C
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099256; cv=none; b=jvTYpA/0uoiBPqZ1Mj8FP8y9kVP5+h3hPhJcTHlLwBqv8N5C4dBR0iCvYlT8HuD7yBOJKG/I3Y1J0Aa9WOk/48+yfTdQrrr2PU5HRKfJOGj46RKLP4Q/GeoMXuLGoIjla3ZGYJAwCVXuAi74pThtsER6rjjSx9Qw01oO9wBMenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099256; c=relaxed/simple;
	bh=PVwIXQQ5/WGjpPJCRs7zgHzHTHu6X07EUwTtNa24yqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4CmjIcqMck65l76xQfacCruDILI7rXMTAHlzXl9ve1ObPfr29KU4hbLKuVidhBtUNhdbCj/6DmcpaQFLzZl8edGDZQ+MfO5o1JrSP2a7C/71xTCKzHqopAnhbFEM3WnaNLaSCo3kiiGP8gshRFspTiJs1UifciVTrLoHs3PJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GerNWho1; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GerNWho1"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso350027a91.0
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791099244; x=1791704044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATqBSGgki2so7eu3mfXFJfLMGYQGWd86CLIs5RcaLgw=;
        b=GerNWho1PMFs3FM71jALYluT/hDPYCH1rkP7w7ib+mT0SnrbHYaxV2fodt2ANOKpVS
         +4g3FN1GvpPKMhWR63Nu7Yu5uBv8RaNxn13eX6XX5v4NT8Wus549VEaOmm/THcEgIpNa
         C6MNRyVj8WOFyZistXcmfax7a1t8Yl8emn/GHJDg9zxTxMhiINTQyAugQOuYVRSzTYb2
         4Z15R4LvCOkRmeOCt4Vz8Vgj1h3BT4kIe9s3lyziR6BSHNtmrIy3wEAgQQGJSHmi4seJ
         YRAUrGbPP422oTBGODLjn98gx5gL6aEntC3Ihfg/PYVt/8KqcPKB86YPIbeQJv7H+GpH
         qXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791099244; x=1791704044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ATqBSGgki2so7eu3mfXFJfLMGYQGWd86CLIs5RcaLgw=;
        b=NI26ofVmXylPnU//8v4sg5jXXbDPl6uko4pMY71+3RNNrJzPz1csrrnL3ylmcYFxXc
         4vLOm4V93kacPsPVAjZzeg10Q2s25zhBw2Dh06MAi5HFsiWZs5AcqRGBDvCcNXmHWJs5
         L9a7OcYps7ztNWPU35aCpFSRnurkyGDBlpvi6Ql8S+V6UnmTu1xf3YOwRHKHlS8PzrOD
         HgZTwEHFvXO2fT/NJS+tA9zWatIETe177XxAZPI021/tWUR78nAJX0XX5M3t40fa+pwe
         ahokl7wrf3yVjzSHFlJhA36oHTcoFLhl8Nu+iJDZg88hHhBtu893NAKa3lgME+ExNxlu
         46/w==
X-Forwarded-Encrypted: i=1; AKwUvBzPiR85YOjzV9GXzxzdrlXfkGAmzg+YWg1XQbtffD5o0dNCnJ/5BSam2SFf3AgzHfvfxwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsKlWXPzfFipBNyws0xZNN/vKZMmdm+BQvZ8n7qi+vfZwzZzT+
	gOnrtZ4g9UB/gKvYbA8V/xP4zDpr8Qnm++uZ7OJdSqUuRToxZuxgVFxq
X-Gm-Gg: AYBFou00B37Xu1fLcHCOXtrmeiceGBWY65wbQFFGRz6fdIWqU1uqsRp9qTHPRVXzSLJ
	uRKEGRNMdTKPoNYr+DJMMEv2PUhmEImtnC4sMnKLCLnluPqMCsFiQmR4TmaABG9+un9L/8Iw7a0
	nroysgrApEWqS18TVyY1umrnQEC9ISqi9A0vg5e2WptITw/agnt+FGpnINgSTrQV9lZdFmDV3Wm
	ZEW5xyzRwkraYEozOBRFi6PWADEehtgC+T5WGDpl2lYWlB+WknYbX0XClAlZPby0on7nLzoQ+PT
	j8QJS/TtvzUXruRZ1gnhM8FAErM3MwHpuNo8qoKx5OdjtZioXF5LJXmA2eiPHIQPoQ+REcuY3wR
	YZ0WHlMHwYKfSxaA+ZV/3WHCJMaIZP+6jgA8yg1I1mMrLUdDBxiKhwoQcUg3BPCr9I5T3l6NfnO
	/adoO7ST1QeF12Ycdpe5Qw0M1KXK4yBYV2Q3cHQiJO9Qqw6uUg0Ob2G1jGI6c8RPZB8l9MZES9c
	IYkcIKeTcw=
X-Received: by 2002:a17:90b:5310:b0:3a7:b2d4:e411 with SMTP id 98e67ed59e1d1-3a7b2d4e54cmr2200992a91.21.1791099244227;
        Sun, 04 Oct 2026 00:34:04 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4f3911sm5749884a91.15.2026.10.04.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 00:34:03 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
Date: Sun,  4 Oct 2026 16:33:35 +0900
Message-ID: <20261004073341.4034680-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179108986364.434549.5339286904514687491@kernel.org>
References: <20260930044147.3818241-1-4ncienth@gmail.com> <179108986364.434549.5339286904514687491@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both findings are valid.  V2 validates hdr->len before allocation and sizes
the skb from the declared payload, which also avoids the 32-bit addition
overflow.  I am posting it as a separate thread per netdev policy.  Thank you
for the review.

pw-bot: cr
