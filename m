Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEC3ACA77
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819322; cv=none; b=Bm52SpO/Ei8pPdZJR5JAog20qlvhY14Yn5xb4BxLVmTD/51hFz8X+DX/CxtgkRazXpwcnFKboAgwby0y+yyECK9mWjCzC3PpADqCjgFh4JZmsaOnq37shEToZO6LvRr0NZ/z+nh1BE26jfxc5dzRsFQYRXsmea8B18kJO+PrvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819322; c=relaxed/simple;
	bh=xWQKezu4BREhy3j/blXwxCRCfvwvHIXrTtHnHeeaEXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk+9zLsI2/mkQwV0DGlNotuJnLNLWaJkijMxwnv2j7DpMFfc5il7f5GwHr3bDosEOybsdyBy1XVC+IRArwzJwY4CCo93JNoC1L4EJX4Y8e5ekhY8PKUrvTAVFCGFRTCvDGPixrO4He0/fTSN35aSs7/wSgprAgvbHQ6QogyEqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJqnduyv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJqnduyv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so20111785e9.0
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788819318; x=1789424118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=rJqnduyv3+GKruEiOn2qVV1C7znyq5QrRRS8m9CUavzzgCz57d0/XAd8J+yUQrhg3O
         F0GCmdNrqMi7ytL99Rnq4dFDA58FMM9YfFX6s78vnx07rs0ylnylBPDT/qU8kkOBktKz
         yC8rRFqMDdP4lxGY3fvArsigYGjlylSkxKzCt3lVKDTLpWb2q9fCuZgzrZ2v9HAXXMpY
         RzL3zjzfevdli53ZcpxkIU6hS2QkZSuHgHOkt1YtMcnaty4fQzT2TwEBmQMAkVQ4etd9
         D1dXx3OwuRL5WVEuXzTf0xpLuI6Q6CGwc62QzAJzVWS3oY0n1RFIkjwDj+ij9CvKeAgv
         dl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819318; x=1789424118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxCw6MZUrUMQF3PxuLGYM79WzM4GNi956bvyl3WEJ2c=;
        b=A/LW4L7XO4Bz3UrzpulWmcfr1arVntztUUBXoB6KyRUCwyk4r1FO23YNbQunEt6WcD
         7/+SEPF3bvYHlBtaJdKjXgumvKAYfVomLWTwFWjFLdV8ItrX1NDLnD1vf2sgSJ66Am80
         z469RX3dCaIPKgNQiLnuAOzz4zQxDkAjqjLcTIM2FEkBwkAnvZEWEBJQj0eA7O9WFAW6
         CFtRWo+EuZqtYen28yokP/4fWQrx7aPUy6SeBHtwWmYfAYHrNmtMqOXPuCN+xiE4NmCH
         bnat+UB/wwRyjCbOGo7zTymJbSbXZyCLAaxC5Zk7YwCnZFSfzZo7SP7sl5FjDWQ68bNi
         +ITw==
X-Forwarded-Encrypted: i=1; AKwUvBxoZXUEqm9r+oG/Aq0EbgsX4e8xTDqXxp653NtqDj57RuN1IM2TfWCVMYS/9hokBkSDczk=@vger.kernel.org
X-Gm-Message-State: AFuF++nqK1+c/EQXyE5CqKJGxuoBgNoNkzy7y1TxvCSzpaCVlhCIul6B
	8vp0+XIoNLfUkfPiHEIkE6DaS905MnqYmJy0sO4XxAe94nKrOMyODGWe
X-Gm-Gg: AYBFou3C3Ai3N4sBGWNnI0crYw6ijyzCQ6ZP4v+sU0UydBK9iq3gt0OtLBaBX/Di5K8
	zziMjyK9RtVlpGelRzSEAJmG7P2U9FilHd0+lxxOl7TlxxNaDUn1p0nbAa9ozjkTwwvQlvyzMNB
	w2Sxrylfwfyg1O4dpXQmEra/pD+hAGQG+VVvphzv4AeNvQHtj2dn9Jk7mfS/JiLZviYUA9sk5iq
	TA234m55bglBX2c4z7Js0cA3CXQnDCRaEGmw6RC+VTttUDryTWB7Xl6BS/7v/Yuu7vZKTsjpk4O
	AB1pkrcE40RTH6l2Rh2Myz6YO1cg5k9t3gT/g11OrI/GgeS5gHL0UpfeXhZGHkmGTtsUAxrbzIf
	3NPk4MeilYEBQMWdotB8PAdnXRNCVvYQyeKmphZsZWo63287jy6KGRfkRumZ133iBBYyIPYKNY5
	SRl42ZnsghrxqjysXhxFx1WOCR2V4ceKrMC02Uak6XZK9cq5jyyQXugbT9EmTREZCf0pFJrqI/4
	N4PEO7eE/BOhIJQQfkq1zQYVKobDowcf1V2zjG7FUUQrbtTZr2jhV24CxgLFw1/ajgcVsGJJj/o
	oAr1G4zQlmdtBny/l3suiTVRc43veTQFuxbp8/6keIZS4HIiRUF4mdLwizcy+gP88kxlcS+JdW2
	i
X-Received: by 2002:a05:600c:8012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cf826818dmr259779075e9.11.1788819318162;
        Mon, 07 Sep 2026 15:15:18 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-2a02-3100-b0c9-3601-cdce-ba4b-d0e3-dede.310.pool.telefonica.de. [2a02:3100:b0c9:3601:cdce:ba4b:d0e3:dede])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm29993570f8f.8.2026.09.07.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:15:17 -0700 (PDT)
Date: Tue, 8 Sep 2026 00:15:14 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <ap82pFlX8enNG0gZ@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907174559-mutt-send-email-mst@kernel.org>

On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > Assisted-by: LLM
> 
> which llm and which agent?
> 

Claude Code and OpenAI Codex, each with their current models.

I switch between them and let one do review, the other
helps with implementation.

"Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
gives now.

Thanks,
Karl
