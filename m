Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158831F9B0
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139199; cv=pass; b=KUu6bKcrxW/DOw+70bkkhXA/fGeKq7WllKPurYiDYlp9JGZotcqLaWuCeQ+yexSyNkxXkeD7Tu3vt2OqLq5+qgD43PTqd4kw5fTx7ze/3bFOythpOVZDo3s5oznrJW0q/MxdKfqHAVJ6z0cWAtjTmKwTsyCgFy8MuuhSSsKn02Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139199; c=relaxed/simple;
	bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwVNEG5wIdWQo629eQdRgI8LOIpvCjn42s3DP7KX7zxvmDyDEr+4V4mrP5cGEq1AtIrmyuJHeXmMb/z2DHYLegVPpWm4IhlS+vgSk5PCgUPRbUqCwLrUHddDX/qs7GvfpTsZMsWzyp4FkDvA2tnBptRBgu2US6ahAYAE7Tq+nFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTIWm3VZ; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTIWm3VZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cee9b74ee1so23929545ad.3
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 11:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784139194; cv=none;
        d=google.com; s=arc-20260327;
        b=aaGwCviNizs+mthZI1dZs/gVPQvQbcBTQFKrBbpVPRO28d4LvN8IYGIwJ0Cq7Mke6T
         uPTsI9uDa/sgR6e2iMGi7y4M9IXzW1m3h4omI49ocRMBsO9r2iaEX1lEdKgFHr8U2H2S
         27Nt7jAsQXveXiE6k9Zbh7cWBwcQAfgz2VjVBjpGJMJ3E/ZLzE+WQ7OrzDzOMKMArH0+
         7GcvnRrh0oBIJNO7d3Zo8xSLlITSpDrImzUvd64s3w3t8u5Hi5rALAeblzONoUtAMHxw
         NLGSLd6rGE8T+JHxpxZo9E3B4VcsHls8jUXItYPklT7wirVPDLpgKqpj0rWT3SkR3JIb
         wF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
        fh=hGkQcb02w2UZTjKmRJwA/8VNYeBvGi9x0EWlMiPYQro=;
        b=UwQ0VAcHGhwJ4qZ2p7HHbulqeGrPSb8dyP5zF9EG5z2WuDeU/hFncnmnre+EX3apMu
         t+bj/A3ECR1vOKrGNALBLJwEPPqCEDGuDE3lnq5yUoGBwt0ItK7Zd/7lWhY7u20XD2P6
         R3ec+t5jZyeA6rMNQYCBkp25rqGn8wgMBAqsC1zsYknKXgRsthLFdML2m2YPAYQb6goI
         6IbseRMNNFXPgkwEDBnAKhCIKyYP04eMcE15cTOUvt56r+lBnG4s1KFzH9SrlPcgqgpA
         Cg4VOwtvBf1mAxuYG4lFCRH0UB0CSGpX+aWzpty/3guXaE65GnNDw37zA/iqQpr1ufK7
         SeUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784139194; x=1784743994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
        b=TTIWm3VZdzcMxAM9YAR8kvHU7kjJ9hewXfAK/SIgTMmt/kcEc+e1rD7LqwTvhTJ7Fn
         OjkhXCNMSbZXl05Tug95wXA3cTRyOeiFiqZ8UH/tpA0rgGpdU0eH2f8HTIqVp14d2Lwk
         3YSwLSAjM4245pDu+6q8T2L7MHVxld5IlGXDiGpJlenNtgtsGY0lNCcBtiDBQkiLXHT9
         8f/4jTdPJmr2uy8DhaFSEtWzNyZxkmS9phbDNRBKixKpDORN9mWxZyYlTeF52X7W4bfP
         Ss8Vj8saSLLV71afVr6giPOrvgUz/UYuc1EVrXL7lPcTu/0b2lqvOR0i1YgGweJO5+Ms
         szZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139194; x=1784743994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
        b=WNyFdslGN+id/O95MoBPYsG7W4xth9JpLDVuxbWaV/d5Byq4r5oRrN50D3wweheAna
         h8hSCwnkQv4qmk/jmCBW6msfBDaJcUVnOe39ZCFaczJp86uRLcTse75sKmf9nLOa8nai
         H5nidvNNkdPlZF/FTZhbON1oA+IpR6CqJwFh6BC8sRJ/4ijYi25LJqIwSL66gXFBBCAU
         1MqBekyiSjaslX4MhpIv0aKnCVYSWVyBMfXPDui66HgVkxEWy/WbzmjCVoybf52nIOK+
         5ovZig/6FYnzlm/Kv7Ul0JqOmNe+D3s5dXsgbqeYENVhHuUB9mQZ9ZsaWSaU0X8HO1a2
         Oviw==
X-Forwarded-Encrypted: i=1; AHgh+RpFVSsBLHc7AHEr64hI/P6tt6IwHjWn8dW62Vs8e0LKeY0qKisfA79m/XklaMes45jMQMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfOwBQJguywmz7g4ZLT2u/uHOXFgAqPJt5D07xyklrUZF/zRM
	4O2zd7GH1ra+KEdFRQCD3ALr+I+tVq7tI2XZjhGDU/XcyLKVGkJ0jBr/z30HDDn5Rp0iEBXRZjl
	huSx8nAyKHNzpcEapNwDDBbtrO9ZPL4Nu49/o2OAD
X-Gm-Gg: AfdE7cldO9XG3+bx0Cg+GqV5FWdMBx6RpxpP0o0faIXbU6lP4g+hpFEdO+cBpct9HdI
	wUWY+0wcsEROVnolkSsJyBo/ry92phGw1q8zsjbzGAbf4LbLTOe10IIW5uQtsvDlIITsDV3FZ92
	R99v6aYPXjd14wjGIxya3Wi3j828xpYX+OOxY6s8ZzfMY41/uCU7qm7JWHp8w65PzdJEkvaMgsn
	sKweVBJlPjFcNnhXr1JHdAQofumW1ZNgHXVkQkWEsvK2PNAJz2EC2ZabRsWWxUwJvH1D2wm
X-Received: by 2002:a05:6a20:4308:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3c36c1f1e9dmr3992057637.31.1784139193430; Wed, 15 Jul 2026
 11:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 15 Jul 2026 11:12:46 -0700
X-Gm-Features: AUfX_myjzByVJrMRsslJCPDuFhCRYahAX-J5d0Fnwjil213_UwTGXzV50T-Uvqc
Message-ID: <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
	Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote=
:

> This is based on v7.2-rc3.
>
> These commits are on GitHub for easier browsing, along with
> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
>
> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-m=
map-v5

It'd be great to have this test upstream. I'm happy to review it when
you're ready. Looks like it just needs to be redone to use the VFIO
selftests library and kselftests harness. AI could probably do the
conversion pretty quick :)
