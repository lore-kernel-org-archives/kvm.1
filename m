Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922683BE621
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324374; cv=none; b=Iq09IkpCwqHhg4VmpnemuMIwWLfif9DWbUoLsccpC6L2Sf0FFMi4pr99084kpCdBkS+2RJdkEtEzbhhLO77AFRAVT+cYzr5bYiePgqvH2UxagppwzEmJogCtm2KzzGWhYZtm+CVN9suXqxyNSudikr9Odt//dU/T3BMQDZ6FF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324374; c=relaxed/simple;
	bh=GWT9f5g5xTs3pgj7dYhq926onG7epK/eJHZ5TO13AI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRasoLw0Xu1HqrFsvP3ICk29g6dH5IEUMVSzt0lwAG/Xf8sXb0EB7HB2KbjdKru7WCG4gRhlRiYfhg1AYZc5AB5fMUbGQcEvJ8KOxzCO3fqbsNk6hc2KaT890WrU28Ul0lepl03nvbL1rLr9ovRn0JCfZQo17WnDN4VEaXZwIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OKyxgbfV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OKyxgbfV"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-914bb8e95c2so574383185a.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780324373; x=1780929173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi2AxBnDBuiwVVwwXIXlKf9rcXdvhFLnG5wAFAlVNdc=;
        b=OKyxgbfVTZnSA5nbA1o+58xh8V2SwBddBPc8lXj6oZ9w3ROQTz68v4DEstEVPJz4pV
         cKdHMJPcTE4UHL2b0X6ibDvv51PTNyAcvwBCS4TSoX45Q9db/WkRpPqYmz1NvLr+/5ek
         wvCxlxQPsTX1gpnhYXQIf3TqbezfLqlDo5nnIBPzYgrs90TPYSa4pCnx5dV7cB2GRths
         wc5c5UIj5dZ54o+81u1U3qx+Ss8L7y4coyn2DbjA3BptdJ0Xdu7pwrpJzInuN2nnHe3d
         PKgaMk6JmKW2e3JcvWxLmdIfNefnswjd4xY4TUHg/SxXXGnv4mh98BDP9KTIXXsBm1ej
         n5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324373; x=1780929173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi2AxBnDBuiwVVwwXIXlKf9rcXdvhFLnG5wAFAlVNdc=;
        b=D3nNzXEPQWLUgw+4iKuBOckxAZONfdXu1vYQVq4jLkRta1bA8TfCtxmVXGZbamclW5
         srcTKYph9P+fzjkbRxulmUFV6ik9DdcrZOvuXdBHZ7E74kZ7gMO31fxulKnozajPRPLL
         bgFt3aZ6WbkH6bcVBwiHLtxjevBFUWYyxWpogoDyZe02xTeZZNFUyZJIaJ4vJKpgyUQC
         KhzMOrQaMMsmfLKkdLQjbgej6LvfcWz7eT92a9EbOrb9N7eGbcIM8kpktInRRvd/1viK
         ubGNmB/7ow9gih3XKmpHwFknBnUoUJoy4HENoD9Ip8v3OKasYEU9WuHdvb7zLuK//JOx
         Cl2w==
X-Forwarded-Encrypted: i=1; AFNElJ9q+zntu4sub0aeGeQqY9Re7q15NOaOtKbbz1QkkLa5OgKhlqA3Eu3JwPgGH9fL+WOhdxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqy247xg5kep+lE8r1yTrHGcF1UrG39Sekyi7brwgO04KuNo6N
	lVLnBOeCfxPeTvGfw9FA7GqDB2XZYI6dEot11Q9SnFfP1A8sA77+1mQE+kFRfyiTt10=
X-Gm-Gg: Acq92OH/Oumt5cRIdA1KOwwNJkd2n4Ip7TZKw0YL8eCdwMv3H+7/ldIYLddDb1tJnZ4
	hTyBxyaF3as8d17VOZVjveTZN0v5KHBvA9ZB2BMo0kuZuXryBLB8W/XTtMdcGHIzDHgdPQGbq6Y
	OW7aWsbvmQUHNI7po+AYsYHAVqiMNlj5yTJFpzJJ6HO9vo1mDIsuVhdMFXlU5ggMxcQBfW/KEZX
	bKPH1iiElP8k+/Is2TnbCynFvkQHqp0TOS9+wY48VvAX6lKGLynyOqRmUNNDy7it66CUQyFu+yo
	tIcG4DSxDDGa43QflycTMDs3QCAvBTcPEokjMT/BUNjiYormSh4yZHJDL9a6h9CLzBiotlnBCtK
	H33SGfQPasp5TmXwnl6LLpBhjcLJjR1bMJ+biXpTnYDGfaYjTGSV5OnkAFRsEjlzOD578TIL4ba
	7fQCePeyNb0g/495Seu9Z37Axs3ZjT7uPZlrLDz3yE6i0CGLZGmf/F51I67qEIi+W2YpJ6EboSJ
	X3uT8c8VVMNQghT
X-Received: by 2002:a05:620a:701b:b0:915:4213:eb98 with SMTP id af79cd13be357-91542140a21mr1632452385a.56.1780324372641;
        Mon, 01 Jun 2026 07:32:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91570271853sm113463685a.24.2026.06.01.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:32:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU3hC-00000001n2t-2ubv;
	Mon, 01 Jun 2026 11:32:50 -0300
Date: Mon, 1 Jun 2026 11:32:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Message-ID: <20260601143250.GA2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
 <20260531235421.GW2487554@ziepe.ca>
 <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa924b86-1ca9-4819-8330-0d5f6ede8923@linux.alibaba.com>

On Mon, Jun 01, 2026 at 10:24:14PM +0800, guanghuifeng@linux.alibaba.com wrote:
 
>    Therefore, currently only the PTE mapping size of the iova is returned.
>    The current commit has a large number of changes; this issue will be
>    fixed  in a subsequent series patch.

No, do not introduce the wrong API to start. The iommupt version
should be easy enough to do this.

Jason
