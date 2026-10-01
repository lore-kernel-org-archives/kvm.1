Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E52522EE6
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865162; cv=none; b=U+cAiZ8tE/Q9/LrxeT0tRGueW88N05gcKmEoIfFldeL9t36YkVWkn19ES2VmbCPNFFEr8+Oz8ZTCGMobSbTf4aN7sPlkvjxpNO4yyb2xrf80RKG3JzI9jhv6v5rIxQn33XhlnDJUZKS5RfsPFR1Ams21gZPGp5/Kr0gttpI7aQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865162; c=relaxed/simple;
	bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm+Ry+xmy9NCLrsbc1gt6y7GCr0MS9QeZHsKZkxkDsyKfUWZCV/l55QbvCZ/xu5Pb7hlkIH/bmr2PX34r4S8DrGXOo3DHxXL1BeQ8Di+ZPi2GZP1vWuor6WCrrE7njlVXyz9mBzNltFurWNgHM1xprPwZtUfOy/0Q1IAfwfVnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsZn1cOs; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsZn1cOs"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4c0da0145so1175495a91.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865155; x=1791469955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
        b=QsZn1cOsGW9gJSBEr3AUiFhi6dDv+lG34xs3Mef8LiBafeYJX+skrBT1NBhIXQBHYU
         jj6xuMT2tnJjwDESvv86Uw/zRnqEpEafJoeH2K+xv1hper6uzTKGj1f4bL6FcCpfTGd0
         EvmA2hfwBKytksucyYSD16iM6S8wtFJL25V5FkbDM+tHGtKJRt/slN7TnmiqxYxjtEwe
         Aroktd7xX0WaeBpkrdLqQNtC1matuazrPpiMuSAnxk5rAWXCrHCszGKMOSI6IAY6ra5g
         vwnLdPqafMdKVpNxDJ8dtR6+BvmPgvh1Gx/E7/CEG7/YHPzbVreCoEpLY9HVmGM1uoZb
         z+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865155; x=1791469955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzzViGtuG6ont1dJ14oM1FNYXdtgFlMYQZlw7fnaS6o=;
        b=y0S8Gkb0PP7bFncr57hniouIvMlchXrLvfTj9f5JTVjDz+/AApRikRksptUJyUbY5z
         Jog4iBMF7ESl381A/AtuKPOiJSVUJDgxNgEpFemgpvBZ409UOynVBSQ+C2JCpuRReV7Z
         WT1g2xYSbnbXz3Cj8c/hXK/m5n6zWJcNwpLOqB9zmT1IOkZWFz5UfNFKhnwdoeUklKzh
         S84X4Q5qbmnStfslJS0G+vLoMLmrosJXqRK8C0Ob4Pf7T/nZLYM3DcmlxHeEYcyBx+yJ
         cDo/XK20tXy5KvDJC+lWnkvypSbQtsZQAJPlsOmWgQM9dHp8T708bZTbH1h+yULb6/ZO
         BCSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxql00ziZ/9f1rMEvhoM29wtQq+hKe59lPzcz8A2mzc6HDXXU/zdWSLnrmuqNwvYZTErGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsEcGAMRnEM1eBlCg5F8dT4Z+6JVetWtpFZSKEHmrI72omQ6Oa
	+bzo8mwuvPsGpGuvDnnyR17cTgw9BzWqkMl3GcAMLNk74V5ToHwDnxaN
X-Gm-Gg: AYBFou0GXXxFDyQPlgk8LhxTze/WqY9w7oNy+yXeueZwj4OBVTDNope1nWN6cTrwEqR
	FvKXYDYaMlDOyyf6QWZ8yibCPCXmW6qOF1ET0H3tlFkp5zPEY8/pU+jJBjCyu/gpwGvAiUNZWgG
	551uF87edsmW0+gOwOpNfhs9GwwxmbFDQdvn09Hzw/IJTw3bpn7DV1ajKSu569BAQDcoasmX3nO
	jna3OF5A0rjE++1fv4oqS//Lha5vxKQ+r1hXIafJtJfwYjdX9DwrfFjIwvIG+STYK1+dK3IPDx9
	xrypBgiNfHBgTDig6R+0od1IUGulNhsBMv39O3sLpyNq+ZDFt4BfKcGkBPEHokPsS7EnuslonQj
	uOMhVeiEKYM0rAY8YgXE2NuG25WydOmRqgwxEU2ayBisCPzcZBG/Q6b64IzGPIu7HCB02Gvt3T0
	gcz1o8FZ4AGTXWo7KSdIHyauEd11Ohj/SE12opl9dhT86qruMszUWXBLKEGHUkpzDYF60xxvDXR
	kK3BwZ0VIM=
X-Received: by 2002:a17:90b:2b44:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3a4d1509d61mr3979683a91.18.1790865155377;
        Thu, 01 Oct 2026 07:32:35 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f478e750sm4964487a91.13.2026.10.01.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:32:34 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu,  1 Oct 2026 23:32:21 +0900
Message-ID: <20261001143221.3856511-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179085716831.31693.13222203434770065965@kernel.org>
References: <20261001121541.2983379-1-4ncienth@gmail.com> <179085716831.31693.13222203434770065965@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. I found this during an LLM-assisted manual source audit of VSOCK
receive accounting while re-evaluating virtio_transport_read_skb() after
CVE-2024-50169. I then confirmed it on vulnerable and fixed kernels using a
connected CID_LOCAL stream and a real SK_SKB/SOCKMAP verdict path.

Thanks,
Daehyeon
