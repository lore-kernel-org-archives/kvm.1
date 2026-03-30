Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8417634572B
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886215; cv=none; b=P38pe/81s1JBYnevKbkJz3pz+zp4Mcl3x/OGOc8wyyP1kntdRDmvmt9dIoOTTkQgumiEbOcLPD6lvJZY7TU67DlYsgbSn0EeKEmdcHhxpHpbfamnp8uQiZNu4Mzhy8Eu+CzrXu8SCgIzAiCJ5zo0o7GlPM/nlOE3y5Nxg+jd2W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886215; c=relaxed/simple;
	bh=MvxaAIkc/vMbD2wvC/YxOU7JwZEPwJRXPevAKf4Yi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD7gcCO2miCHE4SV2xUcA6AnRI3Alj2TtBA64BN/BfYcdDvs7d3RMgkUhX8o0ckd7Vt1eKcZMCtdF5Is5Q54+Rn8tWnQryKtOuc4EMa/04mJOaFTXjfQ2JoJrsmMoXpg4KoNPNULemDaADte/Ye10UxZe5kXnhnf3I+TdLgoanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J4bfIjOb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J4bfIjOb"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a05c388b27so5121766d6.3
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774886213; x=1775491013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeZbDTptZg5lfUHxFUgvvXT20LbyuaUKO1YdEoXFrgs=;
        b=J4bfIjObsxswXFEH6G5gRmOuEYhC7Z/GfJgprhC/N560AJLgMRNrqlZM5KDuz2zeel
         QPCP1WK8I/C9uUutoV2Hr6tTdWwH6Oi5kPVnqzudJzaIMp+Mexuv+rHpvHyanmj1VXfq
         56MAs1r2g6IqxIyVKXnigsvWiVZaleft7uJU1rj2+jXg9DumfpRw4cWJ8/OsFsKbuUvf
         1yC9RKjJ9b0s0OLP316+HZWj0u3J9hLW5lzD1ab4S3l2aF2URWAgWSHNDilXawrHE7XY
         xIjEO3llrQ+0HFquDbbG/JkL2lQnln6kH5YSM9pDS3B81XcEkW335CXJitrBf4kI479K
         bNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774886213; x=1775491013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZbDTptZg5lfUHxFUgvvXT20LbyuaUKO1YdEoXFrgs=;
        b=sfFn3dGTmegqmvgdw6WDRRLHqqaoZIO+Ah1tqk9GD4Ngtwpoz4OIUCzL/myX/zOZd5
         ILxciHiAxWqwCK8wzk+T/G/wLdntULuvFRPmYUwzviI155IkN5mrtPlx17kBqlVAEVCH
         6SbIdRi+u5alllbsMJPBFovVF2gjIpMqPlmuqieuUQf8oDuPNHgZSkh90qUihSjg/mRJ
         Dmy/UKancXHcd++VkNyVmd40XoEaXbEqMtHvlCkacFdlVhK0BLsqWnHMl/bHLfGBQe1p
         xsFwlPA0hsUOjy9XycelJsohgUZO6ewj3tC4iGjOhLfp178pgzKO3Y2pUyxaw441rjhL
         FN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV73Vqt1XFrGbN0uHX2xd11+jb5P9b1FcZXm7CLfFFT/KfER1GCb5HXD+vUOaZixufgScQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsURpjeha9clv/FLk7snFpG923HriywP+yQhnwGPh8NCsqP7Or
	4x+spc97DQGgd4QKNHUigVDObb8P1zufSx9R7ESrOhBHvW0JSCAARBhdUaHE0SLijwU=
X-Gm-Gg: ATEYQzyI+zDmx2kJYZKbs1+mJ6gav/uPL9v1FLo/aAP0jzS1smA4u9Cp3oeJuOh6Aw+
	sR2fzs38yA0TcZovDwX4hSqsnL0Xgz7DahGmFD0q0b2bEv7OeK1nDqxnj9jBDxNWsY+VhFTJYbS
	bV8sgVYghEOBLcuYq2daC25aBsKEY6sYDz0CW/ymJ+xvALRKwYjIHz2AhZMa0Nvjf/3uWQTDry7
	eqAFcuD6Z/V+LNSLay6ZakPheWr6cSM9e3OWJBOLZz182wCVCQNX2kE1X9VRM4ZH9E4jY+2clny
	AL775vyvM2AsoqjJqN1I1Cl9A5UhGbR0TYs1zKGvo9GmfLBmTxVvnI7n3vD8kpwVvDuAvXcFSK3
	tvpVAYgdfhu0XNqhL3JgCXeJpdu7qxXMFoAKExw6gFGrmWWYxXknT3RFsvEQG3DNqUq+oIOz4RC
	uAGC/hmwqM6bW2V8oLSDbGAm0oOnSSVwasJBJlCUmo9ukGUGGuhiPFeUPndnErGu1QiKwToQ==
X-Received: by 2002:a05:6214:4a05:b0:899:fab4:730f with SMTP id 6a1803df08f44-89ce8e2a475mr188167876d6.49.1774886213420;
        Mon, 30 Mar 2026 08:56:53 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf865ccesm66356736d6.39.2026.03.30.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:56:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7Eyx-00000003cgN-4AHM;
	Mon, 30 Mar 2026 12:56:52 -0300
Date: Mon, 30 Mar 2026 12:56:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
	ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
	raspl@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260330155651.GD246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
 <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
 <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
 <20260330093646.03b0455f@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330093646.03b0455f@shazbot.org>

On Mon, Mar 30, 2026 at 09:36:46AM -0600, Alex Williamson wrote:
> There's risk involved with changing the default shift.  The fear is
> there's userspace drivers that hard code the shift.  DPDK was even such
> a user at one point, iirc.  Maybe it's ok to break such users, maybe
> there are actually no such users left and it's all FUD at this point.
> Either way, I have a hard time justifying that risk for a single,
> obscure S390 device.

If we go ahead with that DMABUF series could obscure cases like this
be told to just get a DMABUF FD and then mmap it? Avoid this whole
issue?

Jason
