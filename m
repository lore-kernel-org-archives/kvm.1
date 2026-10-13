Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE610281532
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855914; cv=pass; b=b9ZqCzjVuyBHH+/nROvXnnUFhYqNRrThM3dJFyDGBjKQea677FUM8z807PvhPjJ0/KhhPvyuBm4ArVRdDQ0G7bl/6xuadF6M+v35ka10O2+Nhg/Mkd+X2fVFaIpRqWAuxJDKLk+UwxPHttQwOZrrKXyVRk0hE6EqKyt+vendHBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855914; c=relaxed/simple;
	bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJd2HH2A5701jqNA3hB3mIcWd2emTDnIUWWFgntuZLmNcw8xSJqrbOiepZsylX2B5FfgVfK7s+8G0ud0IfTTtNyVJ12n2s3FWyFCfnXvB7R0xK+5sY589PYZFzGd396h80G1Ul4F8uPe9k/MHJSNBUHFhyf8LXA1NyLJO+ZEdC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXsEqth1; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXsEqth1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53512cd2f85so32545271cf.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 18:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791855911; cv=none;
        d=google.com; s=arc-20260327;
        b=cHrxPltIQENMH04NUTjxnPwpBHxl3W6YpkDPsvMvdvacQSc4o4BmcsvHV8w3xXIm38
         gvX6pAsSNEuXk24OuM3LQjk13A2Ud3TH4Ab626fPJp1MOuR6riDpTC4WUBKNy5JF9Gwr
         GLe/plBPfdZNYdTC/M61BOa/NZPBVkP0O2VPPSwQq6R/MI942Xa1aI9mZOCF90plQf+Y
         0XySTE65XIQ4LZCqNitZIO8x/QOOIzdX747ZcewUNfAr6kWAbzRpDfYGqe9Dsd6hp/+n
         ccwXo/H5PoJHxid5aNuQkJeXfnV46kWMETpw0BmunMzEQ6A/fjwrnyJrzzryEUgIOlgl
         rr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        fh=Ftv6tZFSMjG/7p0tOp7yKqqfwOmluXRZCp351pJ2baI=;
        b=pMGx/vnl892Bv4lwz8Jw4Gm+wuZKXE6wHhnReznAxvMdTqGxJ6ocG5D5KOzAzI8959
         1MtLLxz0vywEtQLrUkgt14UFCxNUw/0aVksJG+tlFUkM5Asvvq3m2Z08+8Qq0pYgY1jR
         Sw+k+DKhP4zThnvW3PqQrmFOUNEXowF5uxVkjRnzQIA31viTq2ThjNICaiTrMWHr4cds
         AP8hL7dU08ew9iyt5wP5RmiCPPVNHzliGvHjGWuXywBzDZu0dRwuEzP9xZ84/hH4f+Eo
         ++/0WlheHfJ/cAAGYpvZNL2BHwIlFxDqkUEamcDMW+IVbADdLUpNOeI/xoU34wKxqMeO
         kpRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791855911; x=1792460711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        b=dXsEqth1P9jLVPPBygKZYVsdWxVsgJ001QvH6xJILCjdlHJNtXXFmUrPWXnAoaYPKf
         2YaADamCfb47RAK/+GZ5046cFz9FJJpDnLJkI9it/4Hq3rdXleE7Hxrl/O75O0aL68CY
         CcrmyphYhMN1nt6zk/rGRSdSOYgqW5fJK+YH8pY6JLdO/XMUNf06xVM9b1dvExYXqQ/2
         3bqQxG5m06URnmTFSCqEPcyziNcgwqLJfg6ayLpJ/z2JHxdF9KE7gcNPeWzmfheCD1Gp
         5mFlgszfUEdoVWbKZhQsP7WZsBQjnDTSjdR4BpWsN/47562yAJyrA1dDNr0BETOLfzg7
         CVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791855911; x=1792460711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cz+gED3n3VMR1ENKlJ+1/sgawu/JrM1+H8MqpXBZQP4=;
        b=DF2olJiU4Uu/teRqX8KkdLiBf1KogVyRoX4yFHvB7wMjD+IdInZjnOYWah6jbidPC7
         qg8hBgFBiLeRd5WF3ThiB3AWdCPAJewB5vTSyh5LSpAFe/llbvy2hQ4TYNoBT4wkGFY4
         1uq+jMF1yQ9d4OUnSuim0o42aYQKURveYiH1jkJzOw43Jb334+13xF98fvqnq5uoXjhM
         W8NmfwWtHNEvbGOedXTh5k0EAksKlBmiUy3YYbPtJxuuNA+R6J4NJOj60S8fsSc2XTAu
         +q9q1o650C3XAjFYuepO56qb4gsFtYIRvQr4jDHbbWs7SlYPzaDDT6VzynvuucsfTS04
         UBGg==
X-Forwarded-Encrypted: i=1; AKwUvBwvvL3QNT6KSXOmpE1SuD8UU/++jqvwLO1ysszKPolPJzZfPQFVyAn7xjyfk/IB8zhPYiw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlmmp3wixHzdftp8dIblN1Cm/rh/FpKZZ/lmNF2gB5FSK267FI
	9WaSm4LGPE6hyNdbiXRxD3nSw2SM6AtQnv4qy1gpcDAWjxSeV6bWuddBKzFGHLVHPOQ4vRuXygk
	wuIAFt42wm1tKlvZ43DHjHpbAft4dHCo=
X-Gm-Gg: AYBFou1e4/exITsYizNboHy06gs9/0GDrFhPicQ2NqJvzwjpCpvbA91XQX9loOC/V6Z
	te++CxiFi09r4xHooRIg40but68Y1mFIkN52HEIZrZ+IdENXfBnglZ0Ljr3kTzWBWELt1kigY87
	4TcrF5GpVG6XpP2j58zz1XbDMzGzW/WIULux2ZWapBkMid6IzkN67axXyMiUFDn7d21dJH58flQ
	mAe5eX7/FUykyXbsBO9w09RrjoXjIty9ymZRKkrzxiKORyYrMR6C61F2Yw1uMDvodYW2nQOHU9R
	OzTgW5Uc403bLJb3XxO7nGpomx0Zn9/5zdDjSSJgG0oH+TEt/gxua10j2T3/IHElnadHh/TXEPX
	Rv0FcLqOB7j/VNLg/d3DqklpUH8EVY6+RtLnEAe9CXaN4Ul/E4L7BxqQTEdH6rPvoBn4RAg==
X-Received: by 2002:a05:622a:342:b0:530:430d:87f7 with SMTP id
 d75a77b69052e-5359fba77f7mr196535301cf.47.1791855910479; Mon, 12 Oct 2026
 18:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com> <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
In-Reply-To: <20261012-vsock-guest-ns-v3-4-b32447c66b23@meta.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Mon, 12 Oct 2026 22:44:55 -0300
X-Gm-Features: AclHuK-kA8q05fe6Esk_oixM2BCHb47BieLQLjZDYfiDhY6CS2aMRdOMVHtXa5s
Message-ID: <CAMAsx6fKVQaYLzkK34v5DRkmQS5Ym-XqwNh-+Jj_Uue8NJCNUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com, 
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com, 
	edumazet@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	bobbyeshleman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em seg., 12 de out. de 2026 =C3=A0s 19:51, Bobby Eshleman
<bobbyeshleman@meta.com> escreveu:
>
[...]
> + Movement to an unreachable local namespace results in sockets being
> + closed with ECONNRESET. Peers are not guaranteed to be notified via
> + an RST.

This reads a bit differently from the sysctl documentation in the same
patch, which says:

Connections established before the move, from a namespace that can no
longer reach the device, are closed with ``ECONNRESET``.

The net.rst wording also covers moving the device back to init_net from
a local namespace, which this sentence does not. Maybe use the same
wording here:

Connections established before the move, from a namespace that can
no longer reach the device, are closed with ECONNRESET. Peers are not
guaranteed to be notified via an RST.

Daniel
