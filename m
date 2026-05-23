Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFF30595C
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554162; cv=none; b=pbTWO/xpEYWIM7zUtC7cVD3GJI2fiQhJco66XcNmXvI4FaCRWZEl0P54HVL0zDt9vJBi2nPjGqybYgLKZ6vAr42M89AApZVfRH57e1c7oRO+ESHG/V5rROLg7s7MZXiaQerucoRoB1CZs+srSPDnojGXUx+DWo5tWF0g2AJYPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554162; c=relaxed/simple;
	bh=SnLk0HaLAeDp9CB1O+cT5QTtRXJhfOlf8pVOAJpSIsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmqiTACty9agSPMEXU65vlWoXCwiJwUjW/QiETnKbW8P6bG9XgPa+N+BpzxkEo9z6cqVf08mOanfiv8DibJ8ccOWZvewJzZFZ/EAN5pQmjeQysW6JgW9QrWu7sKcGj/MFEn6/ET0YBSna4AbiKKJshf9gwOPXX3wB/LMBE2ieW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns5JaW3q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns5JaW3q"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-444826c16ffso7296445f8f.1
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779554159; x=1780158959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iqbi0SmV4l8cOiZU/jCD2RWz3CBg4dHUkTOED22sLyI=;
        b=ns5JaW3qxh1lKB1A1AMfQL/YNs5W71qvnoee8vLAr5LSlbmqX2Dqx/ltWDQ0JyqyQq
         j9Dyrhxwh+elQ1GwyrdeuUJ0eERgcDjdOIGbJ78IdpOsbkLY18/bJ4NlDgPuPnJclrlV
         IT4M8ixDjUtmC78JvcnUc0TZooSMJxLoKwDLeobqUeM5+CH0cc9ol1c0ntLESuS1H1Hb
         eEPuU+gpiJo7bagCd1eekOZIz/EU7Lt5ci9GXppLJqY2qCUBk7/qW5c6/QpMr/Rusbo7
         p2QWaZwx5gO9PUHjRAzf0HEFly+cqoeLuBvDSkzfQErmOz/PoG2DHXu0ERATHhxuDCSh
         2w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779554159; x=1780158959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iqbi0SmV4l8cOiZU/jCD2RWz3CBg4dHUkTOED22sLyI=;
        b=GGFcCZ7eJMZnhA6lZW6pk+4ClR9wyS2fn4aWxt8wiTmziPWzr3fugln/hGiUQAld9C
         f998vxfpeKBclrlC2P3giwwmUxJb5BENq/0ByoXfpL2kstWPkwqci6SO7+YZpw11XHlk
         SBZfzneMyAEKo+sFviRrlCrbRVhYOV00hKNumhKmSATQQKNrGbaFqNVQ8VDT1dp+q8+M
         9sazS6PMgRJwDvq8tT/hupREhmlsrK/uYcSOiL7gbCerBV2OUSxn1OUcdmjX76CFwJoF
         mVOvmQXw+tj7EbPq+1eYTIUDWd08GV22MF7H9ig10w/KU1n6ZD10hQin+W9bFnI26f4Y
         nymw==
X-Forwarded-Encrypted: i=1; AFNElJ/H5CrZIWNkXblrV4H7fUEzgSM3384LgFk9Zw/Bn4I9QVwW13/FivOSRW2So3aOvWv8pNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOsG2AsITjllQ2GAT5MugbI2bWqz1Ae6sFdUO4RUowTomon8G
	uOYKNzktIs3dl5Gpjch7kofYtI5/u4+x0wK+FQB/Rnas5TTSNvCDBs9G
X-Gm-Gg: Acq92OGpa3LSYIzrEfYN/8/SM1lH8La6mklH2P5JhEzWwfV2Oje/KzVZBSbIoeW9Uvl
	2ofXRDAMnslG06GhOb6oZlMLutOBgmoaMCuTEnv5x/nZ7Fw55ViNMKoqZbACZxTuYeT/7YBC+nG
	0mAJCgl42P2Y7JI7bHFLe3gvAHLoHIzLY3iTM2N3gtmYtUoyr/si0g/JngHKEi5VIGRQIOunW+F
	Dc8EvNZCtdaxil1XbaanVMTepq8qUDFykIMJX0oxIGVfMkeIbHSe2GG74tg4xbUtyY+foYwODBI
	WD1UoNq5yzDIblGzMCTZ8tu9PNlwyeeAE0Jxt+2Y8yH7BGs/WXvcSz3KbIsaM3+/nSpnEvwtVtW
	MEShoZRVAqHpuxQyaVXOxtKuWsftimm2ecXr1mi+6gL6RoSVR5QeWFw6OehxCsudxLDzWHZY4uj
	LUwQ8CvLtQxObxuy1YhYUliywILKtRaxAf34oZ6KZCCwZsNGywGiryuKSsCqeF+9M6
X-Received: by 2002:a05:6000:29d3:b0:45d:3cbf:bdda with SMTP id ffacd0b85a97d-45eb38bb000mr9671985f8f.20.1779554159363;
        Sat, 23 May 2026 09:35:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d493dfsm13521078f8f.23.2026.05.23.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 09:35:59 -0700 (PDT)
Date: Sat, 23 May 2026 17:35:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, mst@redhat.com, davem@davemloft.net,
 jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260523173557.5cc4f4f6@pumpkin>
In-Reply-To: <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 May 2026 02:20:29 +0000
patchwork-bot+netdevbpf@kernel.org wrote:

> Hello:
> 
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Did anyone else notice that is isn't a bug?

There is no way that a 'count of bytes of kernel memory' can overflow
the size of 'long'.

-- David
 
> 
> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> > to 32-bit values. The multiplication can overflow before being assigned to
> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> > 
> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> > 64-bit arithmetic.
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> 
> You are awesome, thank you!

