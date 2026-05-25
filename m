Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112853F5BEC
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729285; cv=none; b=Pbv83zTscJTTM6JagLBEj2/iB1TDtkI/jBqTH4B5rR6UalK9aLWYbA7baaXBNeSKmspZvoXNGLGySFhp2YFRtNohG4rvNM52AiUpY4xOLSH5gx2E0x7bdfWJS5Fjt6jbSxfjGUvLI0hSrLW1RxdVixdXcl5mN8hQQ2YGpqoprtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729285; c=relaxed/simple;
	bh=2sV4pz6YR0OYuF0/R7iMTf2Mnfa/i7KDjcdfesmU1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2YaWVzr57Qu0nnO0hVVH030E6Z0r73lltGn7SGoVomElyPqAC12REHV02NiLpjcLUIG0Q2lUnHSXaBt0rV47UKTYSj9SKYDlZnlbPUEYOMLozTgDNY/RbsKygHasM2Jqug+eaZ949Mq/ar9rt6VhWMMlbdnDOGo38WVDTSYCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBKKHIJq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBKKHIJq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso8540046f8f.2
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779729282; x=1780334082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBpakHiyp2Ixi6ETxg8xxyuYG4nYq7ywoAzoB8P6KoU=;
        b=rBKKHIJqBeVByHkP4pPb8OpYiOdtN++0V/VhA8o14xzAwl3DDAuoxgkRZs3FE1m/th
         394zKqYgB6xVOb/knFqxgajG/u9rwCs9CjYBd+hxjood2wTexs+X7hi+/syZjnqL2XzU
         JYh74o/GXTcH4OKGPr+eU2KjpdRCQ97wA5OaQbiT+LHa9dnbdd9EpcfKkEa4T5MZGZQA
         yuqwWB1d3ldlYBaCsI20Fji3Ta1XLXsdxDQ3c2OLBu7K6A3LDv9kTcaSso/rE146RVbW
         0Uoo0e12ay/14kljA/zeU02gMsVQkzSr7DumHcZfVgqpTQG5hcA6quY/Lf/VYTKKfhJK
         npgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729282; x=1780334082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBpakHiyp2Ixi6ETxg8xxyuYG4nYq7ywoAzoB8P6KoU=;
        b=LxA2YRG9OsoBZb6FbJe3OU+er83+pXNzCTUsmhcqyph7j6ZxryKbfcRaCoXBMHOWd9
         nWuglmXT7VGOIIeNuRS4MicGS1mR6Va3MjH6Ln7ljTqKRZSrhtugweqN/uNvHZt3NuDX
         zXLPF8ta7m2Qox0mgGB7HZeF2EmPat5/u1eFMrc8Z3lYICoAJhaTNpJQ/RQMSWmJevLI
         st84pTCOriS1mDOF5ZZhGsj5CMtRJ40RXRTF7rtBh3jlQq0voC1Fdr9O3JGx/2UWI4uH
         w9g07igjYg4uD2eZ3SM3PhHqymep1dyuwxb5IiOMYiq2z4cEeyyIPtav+Xx3Vlj4D9Le
         dnZA==
X-Forwarded-Encrypted: i=1; AFNElJ9gFm2wH0ocPYhkG7eCbH3yiNtsdDFz6/WVJNGMI6y9LGipRvHr6cPwJ9aR6xJcTYSXp2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrv9jgaju9yDIHO/PMRDb/k8M5QNezgi3V3yxHWAJpAEIEBvq
	ZLRedxpbSXsd5GktXTiVGYbaT5mLs3DueuEmonw/h5BSzt2vQHZrP7gA
X-Gm-Gg: Acq92OEgtkRhVhHsGRPRx7/0Y0i2xDN76XotUZKlWz+22FtSGx+eHTjf4eOFhj7+91L
	JYbhioyR33gQHpGP+AP6TD8LvUm60IY2cm59Q3oBa3c0/LQlwY1VcnsWRpZ3cMFrSI561sdHeLv
	B+3T8oXfBB6XOhJ4jFYx4Pa6kkqD++WT9S4vid6FTT3rIWQamSQm3P0oRbI2rTFHrykiwbuYq2n
	bMCvTCOlifAUMArmfOolGU4L9DNbJVEYZP5MeQiCigjA6/5+FA0wGME6fe3gShzd2yoFMlDkly+
	Zqs8H7GlwZtm6Kzy7XKAqm/gINzNktvaFP7qmzQcG5srtT4YdINNozaWMCx++KyivHm5pYOvf49
	m8TTUhq4RdAvKc+MwZ/cUO52LH8p0rikv86n2Bu0GR2hX7vfJqfg1Cfshh999sYLjhrqhZ3XAvG
	cgsKmSlJuphWFFuCAboMva7t3XN5WDtewWRLIPMw5HuQYrnn619NBqDxEWImbXMY53
X-Received: by 2002:a05:6000:4606:b0:45e:8727:be87 with SMTP id ffacd0b85a97d-45eb36aa72amr24711421f8f.15.1779729282272;
        Mon, 25 May 2026 10:14:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm28840763f8f.35.2026.05.25.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:14:41 -0700 (PDT)
Date: Mon, 25 May 2026 18:14:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
 stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525181440.5a6cdb43@pumpkin>
In-Reply-To: <ahRmBTnNMrg-oano@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
	<20260525115314.3cf310e6@pumpkin>
	<20260525083859-mutt-send-email-mst@kernel.org>
	<ahRJS2bN9Bw_AKyo@sgarzare-redhat>
	<20260525155322.240fbd87@pumpkin>
	<ahRmBTnNMrg-oano@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 17:16:18 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, May 25, 2026 at 03:53:22PM +0100, David Laight wrote:
> >On Mon, 25 May 2026 15:09:54 +0200
> >Stefano Garzarella <sgarzare@redhat.com> wrote:
...
> >> >Indeed, I wasn't thinking. For this to even get close to overflowing
> >> >we'd have to have almost all of 4G available to the 32 bit kernel taken
> >> >up by this single queue.  
> >
> >Except there is usually only 1G or 2G available to the kernel.
> >And all the skb would have to contain no data.  
> 
> `skb_overhead` was introduced to prevent exactly queueing skb without 
> any data (essentially containing just the EOM for SEQPACKET) that we 
> plan to fix properly in some other way instead of queueing empty skb.

I think most of the network code counts skb->truesize so that it limits
kernel memory on the queue rather than the amount of data.

This does rather rely on the low level code setting it to a sane value.
Last time I looked some of the usbnet drivers lied badly.
(IIRC short packets in a 64k buffer with the truesize set to the data length.)

You need to do something to limit the number of single (or even zero) byte
SEQPACKET messages that can be queued.

-- David
