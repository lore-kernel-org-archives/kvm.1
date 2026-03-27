Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3136A036
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583026; cv=pass; b=pWU+F6WoX3iRxIPKTomH2+9fkhUMH3mta7vW4r8LXR2KD9p0ifbyBUUphn8fyKJKZmvfyEPyhcwIW1XYgYjVBvc7NdSVXxSrjliJ8/TrhEm5tsGqr9LI/pOQMTesCgz3ZGJIQlPdiS6WXTBOsokEZQ+oqMhaE+q8phX+q8f8RKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583026; c=relaxed/simple;
	bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoQk2GzLoA5UrlFVjank9G8Kd4SFFxtaGYMrV23KQ2qA+YbXyOOpnOJS+tcOnQSzctthdAk9Yq+JqWtIrcF9/AqmOBEkVwuCJ7y4ARhzEAalYvZ0K43wnTh9L0kJmaB2p2n+mBGq4CTOuBLUaAHK4g3YB9WKsoFnBCM6Q1NjS6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7Ws/JCZ; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7Ws/JCZ"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506362ac5f7so15718571cf.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 20:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583024; cv=none;
        d=google.com; s=arc-20240605;
        b=KfcJHdc/NNoq01ZWAiUHCopQtDmSWbPgwvhITT6xsDkemYkInRrM1040kedfPU1IDZ
         YErWLyRUdS6RnU/GRn/co/v3bVzseXHT/YwVRvSFaaSRz7Pfyt7CH3nw9oyLe0hwRvKz
         aYkvjj7MVIHdniRee6EiT3s2xmoz2D7hFq4I2/NxdYRDTPSGaNRnPFCqi6CbEKduntjI
         X4rjVTeXN43+Ti6pNcSftTIFi5vIwcRGETa2O1ae/gLsk+W/U7D0jwn797yHjpa2T33/
         2+sXJKedS8n01v93lXxOpoIxB4QJGLUJB82PV/Mqsc+8FnQ2EJD7eDmGDPuZwUFw+AGD
         lQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        fh=mYI2p2Yb011jpTMzlURFH2xcTujDGn/QhjkdlsYj0Bo=;
        b=T3CYNkNGvwg7KOQs/b5dfLk8ZKIt4oJz1UMUN4DAPYj/xePuubSvoVXCUy6E81TBll
         VeUTvSEnj2ZPDirkSUhbrht7JS6J1Z9F4FensVO1FD15/f/QEVHNsXMTgi1T29tSi7Js
         bRvBnTC4ySAcArv4z1qGPG5/igHxswbuOxLA7xjqnEs05ew9Mit2EBYp9vyJMU491Pb4
         f5yxF9RyEkYcp+Y3m8DIp3zA0qpZiz0ToPUjaRIz7f/MC8Bp/Piio7uaAOG63WJqwnb/
         ERI1ikSdB4uATytnmGGP1iJLmKwX3FhI83u559NzrgqmxBCBLXX8uOTovx9JPyQvNNVm
         PqFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774583024; x=1775187824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=u7Ws/JCZNimk/pAmatYO3igeRU+sC4Nb/sBDK0vRl6AooNd7ymqtFy5RvKSeP4jHSv
         26mAA0AqrHmzOWvuvi6GU/G/xaTGgRvp2N+6DtttQXSw/JTOG7f6MuK93Yp0bi8osAon
         JyC2HPayj1uNLRxfA07Pbq+xVlrF1tejQ327w6lS55WWdGkJU5jozm7cdawikJ9mtPvn
         F6iZ/X7ob56en+EHu+j9iNmLXIdFCOuJ/T1K4maFljQII5ZYUC7WetRr1LPm8x16bxpE
         Rhb8Fee71nJxyTg+C/O78t/mx6RpPR4F4tpjgtRzIbJH3mox7N+Dj2RNIe9n0OVSwF0Z
         1XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583024; x=1775187824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=CgggoRYGLc0o89W/XTYprs9t0hK8rnpfYg7PpkiAxftVtutY8a8uUTG0MPQzDQXzCK
         ZN25CR62ptHQW1KmMIK5/nzvuJTz0WA1jdbtq/dPw8cLzEQsDXq4V9odU9RlXamjg5kA
         ipTigSVaXOrGlLgqtpoZ06XHYP1dsXw6aJfwvmKvP3iSbeno5npBpraf3yZpkaWXhQlp
         MKTzvwPyuOq6OzuSwrA9GTvPryiQkXfbgCcEFJcNZ6bmy3QMCTQCeFBJVE+ybDizFABd
         CoWq1/ZwVKyiHQx9PRuSeTpqqsIN3zn0ef5iHWKCVEDZ5xST0GeYz+kFNhFdbimYHyey
         flXg==
X-Forwarded-Encrypted: i=1; AJvYcCWxJUcqgxjtYcHsy0ecIs9XT2KJf8yGi0xVZzXzNqbp630pJkpkGZrglTIt3/RC2sjy6kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTI2hfhQJRTfBZ50H+4MClks9KcrlhcBrAfnLoSlfslp8ccCCq
	88guuVqk6stULl2Y2/rgpUdA5nHBGO59+DVpn0nFoVMoTuZdDsRb4R8Es3u+pYDJBbTTbpySpqB
	PjUW3EugymnQavxspqMVfWoFk8SbB+YVa2edPq7wN
X-Gm-Gg: ATEYQzxifWgB6RTQhiyHevbLcdqKsxbNgxjwY1b43pZT0b7rGPCrZwmVij3C23ZBSIx
	FXofUK9XRCydWg4Vx+gs28mIjYMyd0ZG9yJ/6p7Kq8MJrx1cpQtFmLMjlZqg0nOM42E8q0zIkVL
	Z9ry7yqFSbJgSaY/Sl/OAFYMDoBusF3lwQ+MUD+OPgwyk2W9oh4hREhi2TVa6mz/u1bFAiYAUKj
	KnT43AZ/FeJIRsIY+bBIuvueRMV1OkXGq4YgIMUUEoQ/++osGQgA8YQeo9j2M8zMdSGtWZhXh51
	x5x6RQ==
X-Received: by 2002:a05:622a:5a0a:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50ba37d3a17mr14739431cf.15.1774583024002; Thu, 26 Mar 2026
 20:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
 <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
In-Reply-To: <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 20:43:33 -0700
X-Gm-Features: AQROBzBTAZQiZv5gITUpNks5cRGZmqvxfVTU9Y6vZlwD1VKoOLXGxZ_EY6bfseI
Message-ID: <CANn89iKJUMP+7udEPs_j2Z5pPJnc8-Gkn==5OLr63OJQs1a5Mg@mail.gmail.com>
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:17=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 1:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
