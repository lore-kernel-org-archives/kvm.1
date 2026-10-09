Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562A317145
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511187; cv=pass; b=u8IzRXssIG8l9RBjkPpdwTE3xXWlq494yBuIQDXyECOKt4DUYjictazBZXzdvw4ubU+HLGCYsODZkgVEn2gJDR8i96iJIgC6xTCToiiu8Vd1oUx7UAp4I6jBY8SZxmAaMTW55e4e80EYcMLq+t2PyMtR0xYr/0/7dr0zmFjzUP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511187; c=relaxed/simple;
	bh=yqtnp6B6FTM3QTJaiUbEanQouvPTHeGKm4iP1qF+XcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jANu2+k5ovSCial+4D011SzjX5lSGAzLgoIDx8T/s0v53Ad5Y1mniFhGfyG4XHYGeAh9wOFOC6sAW4Z8RGjfVWUTjORUs9oog5Ngte9iFypRYIWJz4O7aTeejR45zu81XzAVpmX7xpGheWzqZQREDiWr5Rz2ut5c6KzIsPtkxA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfl4ZipQ; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfl4ZipQ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e635220b9so263186585a.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 18:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791511185; cv=none;
        d=google.com; s=arc-20260327;
        b=R8k0oqH+tnFEYp9/0k4s5x3PcbrrOo3HnsKoaFhhwyz6PnpzR3YLTySx/1eN7LQcGC
         NTLU60rfE/vb7RUgCQNttjVoWBqWlbaVokSXaBAiPuJVaw4duqmlKIb+JnxuAylLCeOn
         3XLNZAJOeS1rTNCwyeFwH36XwQp3yPsieUxCThCWWTtKd6ZyDMNTXQzDaSkCqhL+oRSy
         xpLJk7oI09+xUuh6qMm8buXVYQzHaalEHmk8khQOzj6CnKK20Jm42rcJiasd1LSRglcK
         8TgkjmZaT/u1B3b8Hs9TNCwHT3212RLws9k/54Yvzuok+C00bqmUC2hoRWFagZgIwYZj
         iuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        fh=xVAfN+vefKOnrIiXmfcam/jT4sznSrapHz2I0TUa0dA=;
        b=OJ1MELFix8xmDtO/k0U+10Xn5VD23aqVYDWgSPcCzoMK050nwj8D46tjq9XMGYxDdZ
         LkVl8uOjGck8ly2FxeyjF32JDqmolYax/CwQvfLEUvOzBQQNLFChzEHJgLtVvzlbhCfX
         9juAJ5wOy7h3bT9W8UOoIRdZ0cno2C2Sh7A0TzT+rhsSfAOqDm71RuYz16bi3Y1VtcWz
         5NH2nAkWPTUVy7rrjXvO0F1g5UUaccnTprvbxuyzf/43ULsCQlSMUYxw2Gnrb5MImjxJ
         Q7li1hcT1+Nwxr0rbNwZNpdk/dojTiK7hfz8nIU4OOdoQD8Ah60zXIvUowFLh8lkXsst
         +b7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511185; x=1792115985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        b=Bfl4ZipQQX5njrGUplZu54Wh0Ghaf0C4zwgzKQuKmrJPSy5jtkZOOIOjom8+Zr8xSl
         PZqzHYdsUFNqE370oULwPulWTvfuYra4iVc/u0OxKt5PI6giOMb+udXSxYEkNAXwjRLJ
         ZzU3y6jRLPMJZtied/ixlJocYm6tdyIBfuo6dnrKMJzaG543eLVF0FtWssEIYfODRcjA
         h6/rzbMc6iRBVEQlz+XMHbC5P330Pv+Edabl/ip2guiP0VQ4GqZP1w839PVmORA6bWkM
         n2zDySFgC6icDp3vqzGZ5G4v0dqShql7erdpkBWE289zoBcZ8LQmum5IVMkRQoVkEhF3
         TusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511185; x=1792115985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HbEcrbrw+e0HaKnSxXudM+yTSGQcwHmdEo8ih7z1ToI=;
        b=yiqFwmlRLTagwA6sdINRTZPOx8OvYz5XcKXkWuWF/OMAF6xza//OB5GW93e8jS6VvS
         owRcd31Oc/Zf/apPXoZ6nzl47E03/EN+Ht4tlEXirG4zyru/eyOIq3bCzLaaqtAc2tM7
         sOruG/NIOdmA3/oAjoziW4lxg/OArynQohPmZxt1p7zwiW+Tte28zZy3MXdchmTwDTDB
         t4hs5W4RlzuxUPvYLXP5Pt3lC8wBAAkk3RcCJuOo9swi04jntTAeNtwmZwf4vLy/luxj
         yf27CLom9cL9Vt4GT4K8fIr2nHn/RJSNPtyYQPbZ7Ip747yh/5e8F2uCs7kUje/Ruv5d
         hlrg==
X-Forwarded-Encrypted: i=1; AKwUvByVuKiv5u9tETxCZOEh6jF8+SYQSKeUtGUdWKAgIdtx0Y/neNn73sQ6IbWsQtMabt7YyKE=@vger.kernel.org
X-Gm-Message-State: AFuF++nKGdxKtbMexhn59daKmLgSC4ZvAVsMBFdfao/Sot8BFlXLn3v5
	Tfs8SN3hLrMKzAwwvg0DL8c2eRJ5fe9cEnNdS0FGoNlqLpJubPzxaKrni663G+J/V8TYC7wX+lr
	mGWCNRJtL462JhRsUFxdxceUk/xSrxE8=
X-Gm-Gg: AYBFou00KjxF2SS9aeJ5ZWzsdFj/a7Z+v/bxeU6pSoRPD23O+vnU1VvoUVPtdegu3mT
	V3fi7MtrVuPTL75H3mx0zehkMqq7jilGBdLaghT3OJJx6IKwP/YHOfBJ7x6AwI+xSC47ssEBo1C
	dplDqSKxcfXet5rrAlTqKqOpOPgrF6gLdGhQuPgX9kFjAY1N3ziSPe1vxQ4N0NeC3K647YT8AwO
	lk/8n7ZJAh1DfJhmIL2M5gYcRSH7ZFSJUaXOw1FjGqofQ/WckUSViZ/8+eOCixYRgX5re58KnN/
	5oYIV0tXEoWXVc4eccb/0jZNhH+p3Y2WSKdY7MnuaabjXz1L3ua+H04=
X-Received: by 2002:a05:620a:2796:b0:939:6c31:2318 with SMTP id
 af79cd13be357-93ebd25082amr66385785a.34.1791511184421; Thu, 08 Oct 2026
 18:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002074551.318789-2-physicalmtea@gmail.com>
 <20261008100352.706042b7@kernel.org> <20261008100424.4c65ed9c@kernel.org>
In-Reply-To: <20261008100424.4c65ed9c@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 9 Oct 2026 09:59:08 +0800
X-Gm-Features: AclHuK-M9H-4p3UtOJsHP4i-PkRC8HxqoHrUrMNCxQPZMxSFCUBi2fgLcuQpjSc
Message-ID: <CAJwVaMJihVPQmQNXNojB3KSMCyZkK=1tBTZoxffLmkW9LoZHJw@mail.gmail.com>
Subject: Re: [PATCH 1/5] vsock: split socket lookup from locked RX processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, 8 Oct 2026 10:03:52 -0700 Jakub Kicinski wrote:
> > On Fri,  2 Oct 2026 07:45:47 +0000 physicalmtea@gmail.com wrote:
> > > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > > receive state machine that runs under the socket lock.
> >
> > Please add a cover letter to the series and repost correctly threaded.
>
> Ugh, I see the cover letter now, just thread things correctly when you
> repost, please.


Thanks for the note. I will thread v2 correctly.

I am still debugging a conflict with eBPF sockmap and rerunning the
performance tests. I will send v2 after that.
