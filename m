Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798107;
	b=3j5qED9XMIGqNKk+olqhDFyOuW81vkbGe9mdT3Scmnl0ztM8gi6kkevcrmVaVjfbQdoA
	 fiiMMVY3jcy9X8GltQ1xJn9F0Sv3TLDvcDWRXV9doqigwKLlSPdMeN3bzN7mIB4NwDob1
	 oBYZUSK4IrgAAReQ2BRUJLkynWyhiwcSyklMuvqtPY47oaZSMNTTUpgDhLrSCvDDhapIf
	 LPd4aYG6B7Hh0OtduYNbIbyJmlTZvLtqJOofabjKAW43u8ibmiGKfoZ0JfHzE3vtMXEni
	 BOmqOGUtvRo24/iDPWWIpbXLvsMgYvel/TTFKQDfdUuIV/kys/rwkWr9MLmvcLYunGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9yLw/WRCc0A3tXBtnMdNXih0KVmDX6sXBP0GZLNu6xw=;
	b=ggyOxN9b0dDXZgopzDmstyRLRGRQl4yo1uSpR7Nf9jW+3raARRBvjB042lm+gjV6eyX4
	 E9mN2C0aWGN+wJopQgF+hsl2bbH0klYcX+7OJii85yyFnORJtt/KufawT+j9WJV/UtcKl
	 tD4KXVH9IMATDzd/zPonvWv0nHG9MGQoDbIB0zE9vwpexQf5J81LY6L5LkxJJ3XLeNlvw
	 gxPlqx8LQ/g/ae6u72cVUuwwo9W8wXuy+tfFixJO7nNP5aJtDwGNnRMHzz3NSvTs1ljR+
	 C6t6B83cBtuNSXP9wL+ksnl/IgUwP1Le2tBf3f/28b4hMoUQNUlYpEVpq2WkhG6Z+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd9iF9kp;
	arc=none smtp.remote-ip=74.125.229.137
Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D63606A337
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 03:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D63606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sd9iF9kp
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-1397ad3d891so444209c88.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 19:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794798102; x=1795402902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9yLw/WRCc0A3tXBtnMdNXih0KVmDX6sXBP0GZLNu6xw=;
        b=sd9iF9kpJwxa1VQzevX1dTaoID8Pa30ReWCDLPJmBSbUyY6xnKcAKlmhn19lEVJSQ6
         imGeI6NTtdIo9tSo6QY4d5BFyiU9r98SzL3YS70SoiNq0Pgt3FlMc/BZ/GB19Kn76qgO
         xAbRBwiYzszsYWt47JHmRnRh3RmwK1ax9j4wOOK9rCuYTJi11jrkk8xsp04Ap5MmSh6u
         nDjedpehZ19r5oJ9zmg0hW2Akr6OcR+/VHixwUNLMu9t3pCmCzeKMckfSeWiy76czYMg
         g3DMoWzuemA9b3UGGOwGFSbfK/fflj+sggpd1DIOFHYz95mTkvSP8XhihGb9DrxV1xf0
         u2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794798102; x=1795402902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yLw/WRCc0A3tXBtnMdNXih0KVmDX6sXBP0GZLNu6xw=;
        b=owYLNxPbN3KkctPaMnVfpGMZBVJUJrTB1kl9T2ihcyJySuCaCYNCNA683tny2MnWNn
         T3qvi3FKUDQd2AXi17Cl3xM/FvJuBeMEyE8ywK7dsKJE1rqedudHeBcdtCrp4cxQA/AS
         pNeiWdY1IcyJbwV6Jwdp9OYXY6dCs7aTpsCPE79yR4oITUQSrENK7AITpg8/KQt8euzQ
         GqGdC/khDFRargAgJZG1a3pdFtJPMaVoKaDYtBwwd3bzzhmGpZCI4nuBZdt16UNJLJ78
         nLGaj2E+sgV/BdClyiKqjkKODtuSNMpHDEfBGbZ171D3EHx4uAADY89piCN3DhiJlp60
         moEw==
X-Forwarded-Encrypted: i=1; AL+hErE3eLM0pULndF8F99iNo6r8ze/Rt7fl8n1FrGYsevUgEgATqdmNn/HZugvP3GLDttu3FLQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CUSXgn3C+09StUh7BB08Nu0+x/uOKpuOMnWpjpfpHqtN5BlfV
	gZwU2931kgacACtpN0YOEHnIByBXH2yfJeGmw9Kdtdmao1tyTjhQvToQ
X-Gm-Gg: AYBFou2N+jCa6yIkvxrugnVxK2p9oVQYLHGkq6RVry+2EWNsASe6xmZJ5uoyTPEt3ID
	qHqd3zhgsf3LZstka3P+cKrGZ328AOBJswzbqhPVAtaiBHfsC7wgoLuab9yoWXWpI1pSrFSzo8O
	MP7CPHnCKZ+AW/+jf8vFV1ngx6duLB++BLvcBAAcdwEovFhZdEpknnnyWC0HSI3njMp/JJvub8w
	Ap8vd1Mt52gr3iCchg6x2VFFiWCaa5v7MsuVJFrJE1Me455xwQVxXdmSDamYqbXfljhz35Uxqf7
	7zU59IQXFQTyeKmUMAznBeKATLqqpLrjo/6YRP4L4PUc3sjsC+dV2cUQ/MFd/itpJyO6xfwv1hj
	KeJwvTJkvC7Aa8zIYoLWP0RlFFnMzmPvWIhP1EMz92L4e2uagKjUWRs9ZZfoF536uLaPJhmdtwM
	5P2BLwEVL79zOvTrEkacTJFrfa/JLW0YxXJN/xtk96B0C5pW4GVakUxvXgYJ3jiV5QVdTiQOxJQ
	WHIo7xUNqZsQBrhApOETA7pdnjZdO2qNjMvcPzrzg1/0WF0QGpYyRZWmn4xkv0FCUfh1oD08Jk9
	FbGMEG7mrkdHWBk1/fyYkDGLj/jlPeuIelE+NA47+YLZ4X2WJw7tDmvof2Lb7ZYhG/wcrXNd7cH
	Lzszd2seCjfw0OfnRirQKGITy5IefS0WpBpafig==
X-Received: by 2002:a05:701b:21c5:b0:1b5:514:6a23 with SMTP id a92af1059eb24-1b505146aa3mr8786867c88.13.1794798101579;
        Sun, 15 Nov 2026 19:01:41 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm29479863c88.14.2026.11.15.19.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:01:41 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: yishaih@nvidia.com,
	alex@shazbot.org
Cc: jgg@ziepe.ca,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com,
	leon@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] vfio/mlx5: Fix an unwind issue in mlx5vf_add_pages()
Date: Mon, 16 Nov 2026 03:01:30 +0000
Message-ID: <20261116030131.15346-1-dennylin0707@gmail.com>
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

mlx5vf_add_pages() gets a pointer to the page list of its caller. If
alloc_pages_bulk() fails after some of the pages were allocated, the
unwind flow frees them with

	__free_page(*page_list[i]);

The index is applied to page_list before it is dereferenced, so only
the first page is freed. For the other pages the code reads the memory
that follows the page list pointer of the caller and dereferences it.
In both callers this is a dma_iova_state that is still zeroed, which
ends in a NULL pointer dereference, and the pages are leaked.

The pages are allocated with GFP_KERNEL_ACCOUNT, so the allocation can
fail, for example when the memory cgroup of the task is out of memory.

Dereference page_list before indexing it.

Fixes: 089803c40193 ("vfio/mlx5: Enable the DMA link API")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/vfio/pci/mlx5/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 04180035a7fe..8e8514f2660f 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -518,7 +518,7 @@ static int mlx5vf_add_pages(struct page ***page_list, unsigned int npages)
 
 err:
 	for (i = 0; i < done; i++)
-		__free_page(*page_list[i]);
+		__free_page((*page_list)[i]);
 
 	kvfree(*page_list);
 	*page_list = NULL;
-- 
2.43.0

