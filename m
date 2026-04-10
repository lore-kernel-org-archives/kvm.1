Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CF93E3D88
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844734; cv=none; b=NpWSN21FJ01wKMVTYKrph9mUN3pywvA8oZl1BOPQW2Ii3eVSYQxqehpTTsjrAUwg4VLmnumXNwk1DuEU+4YN7RGx5U6jLKVTu8Pa/0e6s7HbKM4vGC2MBh4hCc/JHXxZaBSprpYnLnXYvmK393wRl4bfcpj8uddiCYkYGIIfCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844734; c=relaxed/simple;
	bh=hiUP/Ze4OUB+WZ8fmnUh+G8NB5KKB69S/b0GIm7VAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiHdB7FuVUoDFKZ3S+UzG88Ert6TvF4qHv4E15ZGV59s3lN4GYbC5W2GXgP2BolHloCKA9DcM1Q7t5F/Ykqmf1XETRMYWY481FLd/R/86KCav10KuHsGa56B+yuk/kb4sGsIWNpFQpK45MZvClkA5r8/NIUqNq6bVygQv1MBkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ip9e41dR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ip9e41dR"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3bae8d3eso196104285a.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775844732; x=1776449532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bcrNPUvexRHFlvWYMVKo1yO/LnbhXx+tOPPYwyGpqA=;
        b=ip9e41dRJIAzDBhf2maq19BHtpNJUcsZSma/3LbhUbccqzcEOeOsuk/bm83sO3w1rU
         2xS9IujCxwAjUEdFZheaKmxG0i9Dv8rb92YPtRvU9USIxsMHuljo68X19Mk4X+6vjkDK
         1oNV84/Xlnp+wZQ1PJGYLOm/N2m91WuMYokmq9ib+oIzF+fkhZMWvVtku11Vx8lLr9kp
         tuPADZkpBVzIkQ3BZky8pTBIoLtc1KLNjTHYOl6pBr+Sig8AP2xDSlEj3tqkQgov/V3i
         NTzCMnlW/hjkXzrkVlV2QHEc9Kwi7xbhZEdoywgifEdmVwLbLI6RXyNE9ZCMMUX0T+f/
         KVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844732; x=1776449532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bcrNPUvexRHFlvWYMVKo1yO/LnbhXx+tOPPYwyGpqA=;
        b=TQ8i7UfmDc9hfZBIOOxaks/kWzwyl3uqgAoh5Dw/7n/iYL9eMC7JbnvYqTHAxJoHUZ
         0qbYsG+hfS1ck9ovf7qO6/E2pHBF+8mvpHXhKhVihKme/PeFR2QbuMssGhzPFtlmgdIm
         3hnQK98f8UIVoFr3vXKdN4M/l1cmOLrqxmOQ1nDoT2bK8OfuCx28HQrCqLhrpJFRtw3i
         LvEwLhUZZhNUi4DgJHODDoy0TMXcda08GK2Yj4K6lfNpV9HXTG9nUyKsFcMxKw92Kgtn
         hTRdaJefbw3iytp+WTzevjyBoBCupxGQUHU0h7W1vGlkL/dWjAPCd0MV7CrV+SphjKGA
         Casw==
X-Forwarded-Encrypted: i=1; AJvYcCVfI8+tS88a9dlUjUEzvXwbU+gxq3l37WrfqNtbqGOK6O+1pe58ALHF5rOyynVwIeKEpBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunxINWuM2ocQfiPhH0bfYdixZAapwgG3g9P7+I0irt7L6R7bI
	vILJHL53CQELAP7Ri2mMmqiPKh/PEjb01GJjLaPpUxHoRUcnX/KcZsNJ03f1fJ0XszE=
X-Gm-Gg: AeBDiese8sBsz87Khyp75dcXJf4/PP2PkyDU0pztjE8dwDSBOMFmgExgu84wJn0Rr44
	y8oU4XUQVg4WfHLNMIZPDkKgWXvbcJqs7y6uVOGbyct6Zv1naccIm1QNLz1Tp6ef6DxaMr3henu
	hr+d6QT0XuT/0X8/gdpcuWYMnDJPRcPkTm/MnTCFZzyYA0j0egEBYJEoQXcBUbDKtmJN6YnYdmE
	Pz+W3dphWWAjNylwMvcd/RVNf83BTWFYq2nJBvXB+RoOjypd7HXWKf6o/nHFBbaoi4HlrMlFe2H
	q+Vor3r97+oBHl4xR/rbhvlq7vsBB8vl+cXKYU8GqP2IfvWyR2JIVafjldHruTy0l0t8g9CZX8O
	7Hah0nNEaEAQOhVbrCWQlPmu2uQ1XgHyuKu6bdrvHhwAn/y4h2P9Zip1nL/B7iDQzZeOyqMTX6M
	Tnbg6CIxqZmKsqE2LNKoulUs+morCBjrH5e9niJo0F8+VmYxyKSk457D5lwkc27FID5Csgeg==
X-Received: by 2002:a05:620a:448c:b0:8cf:bbf0:ff55 with SMTP id af79cd13be357-8ddcf9b2fb7mr627569085a.51.1775844732110;
        Fri, 10 Apr 2026 11:12:12 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6e13fsm282533785a.23.2026.04.10.11.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:12:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBGKx-0000000FPyq-00fp;
	Fri, 10 Apr 2026 15:12:11 -0300
Date: Fri, 10 Apr 2026 15:12:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
Message-ID: <20260410181210.GG2551565@ziepe.ca>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407180107.1603697-2-pbonzini@redhat.com>

On Tue, Apr 07, 2026 at 08:01:05PM +0200, Paolo Bonzini wrote:
> VFIO is implicitly taking a reference to the KVM module between
> vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> symbol_get and symbol_put.
> 
> In preparation for removing symbol_get and symbol_put themselves
> from VFIO, actually store a pointer to the KVM module and use
> module_get()/module_put() to keep KVM alive.

Why should VFIO have to deal with this? If it has a refcounted struct
kvm then it is kvm's problem to make sure that module doesn't
disappear while the refounct is valid..

I would expect this to happen naturally because the file_operations
are still live and they will hold the module refcount.

Jason
