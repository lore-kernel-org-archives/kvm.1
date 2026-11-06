Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991846;
	b=qFhmEcNqnNOWjOt3N4cpri4kgstw3GbemCVKP50OCg/4VVpe+JV9RGgqUscshWuCp1vq
	 h648lgyPx8NEXvePoBfjhopQYum9Zw63PQaWlT/rtPl6a9BRs38JH4UrZ/m1bRhoLXrR7
	 HPvwKvy8QKA5M/l+w/bpQMF3GE1W9xgozVJGYyYIfAm9gywgEl4Jex0gEIaLDeGnso8PD
	 UmsGQUPnOfhForuloqvbTfqJ7HeWgn2KSomZXWk6c7cWTrP0rBNF+Hw/lq/uMb2f+ygK2
	 pGBgj8KjYEHgvxtqwG0c8i3VadOnxRTJM0mib7X9SvZCllx4fD9j3aFa1lHNMLvy8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M4F+cGVjhTRlOYCUyyTMj5qF298Mym63HwKHgYQq9GY=;
	b=XrX36MG/OaPYcdbsf00TDqdQOxvM2kJszC0lQhnyhSMizOxgaJjGPbmaLqaalfB0rtzx
	 Ik+7aQchrXScc4L5q0DrA9elfRAvbMAciQMroiMrdyBSxs2Ds4Mp/ay0m4+9LhZLN+Zfa
	 K3lu8ETBkwMkz0P+anmYeyc20+JHIxCie+XegIp/SksV5YNVNY2RG5CJ1LiWp2FZLTF3B
	 zO4vK1EpIckc44p7Sx3M+mARyvFh1PK0l8lqaass2LU5joJdkrOxhoEX2YvNE4xmjIGhQ
	 Sx0eEQSCOmKCebpBC4uV9th+zAYaCyPIEHCNWKRpByP9/lNnv2IxfT7I0TmZGXyeRQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzh7aoIk;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2D606A329
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 19:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F2D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xzh7aoIk
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53634b8328eso8539681cf.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991845; x=1794596645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4F+cGVjhTRlOYCUyyTMj5qF298Mym63HwKHgYQq9GY=;
        b=Xzh7aoIkNhOsCEP8LMNJotTw4ppLWYt4+8Zs4xtTFC05WrzujXx3AxI0s+4q7iJ24v
         MOKiJ00/2mEt3GiP0mQN68YbT5tClkf9QHWpH0TOWbn8eAfKRgsEAxEOtseeM/vK+Am9
         y0Y3sub6EtjOq3MhYfFiSmadQ3RkhotEvoJocbrJt9aFmomcux/47b9Et+YQQXD8Rpgl
         y/iBFrmvXVRdIWxOM34JYjhoxsklMcalQkqHIJ+ya9HDbij1djgDL45wxw6ugi4IMVmM
         W0m08FZC0g+U+jg//d4ap15xZj9TfTMbxMOrWW3s3rNqE1JvUREuCkHHtsio66C2RlOG
         TMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991845; x=1794596645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4F+cGVjhTRlOYCUyyTMj5qF298Mym63HwKHgYQq9GY=;
        b=hnK3xmeWYYYXeMGdUb3KHZ2NnTLUkJk7NXFM1WuafLVmSXKFiu5J6dCUz6ETb55HjR
         nU618JdZC8aNeeLLDbvD61dyRl44vkfQIMzCfFUoOa/iKkO4EMdkoBvZLEeE2WM24dgF
         0uWvvGiwUNvNwECSPSkRYAfEozrJJJb4U5D7WedQpsOO8oiqmBc7ElhJ/mQm6KPoyNnh
         U+GmTcTMNYY1VQeaiALbKn5LAwtguMVh0TUpNF6rXuBGKlP1LYfTkQYTGU69nz3n/yUb
         H4BsRNLI4WOhyDRoMLsGkQ1sNRhO9pIvtAZ8AGJkK7JOa1VSlNxGozzEUms9D0tOpW43
         6bkA==
X-Forwarded-Encrypted: i=1; AKwUvBwt2eDu7KqpccK0NN0FG8A6XqEWPFWH+Nrl10+jmedJ+fLPptTfO7HglrEIYmpntgyko7c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hhxyhsF/bpyIURcalsG8ldXyOasLrW7aYo5/V6WGhShBJfdZy
	4cESohq1aviNVXXwVbAiZu1Iqa9vlpQ712rsCYh6Xl7bM6RqX2d5BHgIQNQBDQ==
X-Gm-Gg: AYBFou1Se+riRh++/l8VY6r+Q317pW7JXT7cNPs33EDF8Fwqv/cr6W7k/7DQxkcmD5G
	3sqscjGgca5ntiUoofXao25fmyKnQibgWm40cOe+iYUbPnnbq6lGYiHr4ohfytqfZSVR0lzRZAX
	Ur9tmiGEFIOkAVeX9ZXJQPKSe+zVLb+8svFiTu5RfgjCwniNjwTmGtGBsIv8WSOTx3teK/pgPq3
	KBH3nCKftk5RcoJ5AXCsn0fnIqpB2/vL9ofCfRq9dS1Ldktzt6nhrYDzjbMTeVaxfCCQT8ayzGd
	Bfn5YW4j0o8Qz/e46JRUl+elcLpqMvQJukFg6/Xu4Xfa2XDXP3ewbLwBumd9GImRUiwaOgQ2OHH
	BbTbyXPwbMllmS35AIPlnAq+jARJSNDbisGu9tUFcC6hyICzFFgpEvWS1V9fxqZZEsORF0DAEa3
	3fVZoOaRn8Ge9v726l2qKz6dYWVTZTlPVTZMXhYsdTdpJ2w8O8XeApoyTTMoCHRx09EMjOrURtr
	YEWquYkhU+1RHHFaoaLneQS4sgA8MhRtJOoOJJKIJOdcUwXpuH14Wdvvcg5DnGlsmX/ggwLZqdQ
	bfxnEgImbq+w669kS0UjmbmkTBos/BH2Smu8B1r3tkxBnKeOVOd6
X-Received: by 2002:a05:622a:a1a:b0:536:10a3:2b88 with SMTP id d75a77b69052e-54e1377e37emr50771971cf.20.1793991845345;
        Fri, 06 Nov 2026 11:04:05 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25785f09sm26979611cf.9.2026.11.06.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:04:04 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: s390/vfio-ap: NIB unpin when the IR bit does not clear
Date: Fri,  6 Nov 2026 14:03:59 -0500
Message-ID: <20261106190401.468289-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi Tony, Halil, Jason,

I have a question about how vfio_ap turns off AP interrupts before it
unpins the guest page that holds the NIB
(drivers/s390/crypto/vfio_ap_ops.c, v7.4-rc1).

vfio_ap_irq_disable() issues PQAP(AQIC) to disable interrupts and then
calls vfio_ap_wait_for_irqclear(), which checks the IR bit with TAPQ
five times, 20ms apart. If the bit is still set after that, or if AQIC
keeps returning BUSY or RESET_IN_PROGRESS, the code only warns and
unpins the page anyway:

	WARN_ONCE(1, "%s: tapq rc %02x: %04x could not clear IR bit\n",
		  __func__, status.response_code, apqn);
	...
end_free:
	vfio_ap_free_aqic_resources(q);

This path is reached both when the guest turns interrupts off with
PQAP(AQIC) (handle_pqap()) and when user space unmaps the IOVA that
holds the NIB (vfio_ap_mdev_dma_unmap()). In the second case, user
space may free the page right after the unmap.

My questions are:

1. While TAPQ still reports the IR bit as set, can the adapter still
   store into the NIB?

2. Can that state last longer than about 100ms on working hardware,
   for example while long-running requests are still outstanding on
   the queue? Or does it only happen when something is broken?

If both are possible, the adapter could write into a page that is no
longer pinned.

I found this by reading the code and have not reproduced it.

Thanks,
Yuho
