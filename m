Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AF392803
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527145; cv=none; b=YnlPGwWMg7KyvYtMnFZ+xedqvGiMeBPpQgrcomHPWg//n+ApYfQ6mO2Aa5qcXu2hgocwfZPe2icvJDN6q/05PK4RzJGwARFqPb3lI/rH/ifDQnn4lvAvs1sThHPCiLju/MpDOA9iwqRf1Rfdolpjk0dfXgz3DMty6ZURw1ebhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527145; c=relaxed/simple;
	bh=3ldpM/1Nn1J9v2DDBv/PiC6XkAeKsSKc8aJ9GttZn1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umGi+OoL2eazHxgcYw0fKgPIYfUlQeNdgBSa3ADQFUWKnziQtVzKSE08ZsSzxySJxDpHjaLkU93iroDyve4jUAJfomvj3MDJna+vXVoH0AolXxbeiBYkxHc9ilir5kiuvwcSLIeTNFI8dhMpBRWQlp1uMpEpZH9TbIhCdTh5YCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oPZJKLSG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oPZJKLSG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd7284782dso58287985a.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774527142; x=1775131942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOQcKHhSbpnRXlvxZdOJhqpuwk1wdptQ8/fVLC7kjw0=;
        b=oPZJKLSGqle2AKFXsmp615JnYjm0PYz42wtIOelUmoIfRLhFj3Qc1513KNacTLmZdW
         oI4lncJOfn//9pAuD5IXmNnyrIf2Zwf1uwlPHH04hayZqqYKd+bnoFYq9z1zIsA43F41
         7+ka9df4ohPSROrbRI4UNHlhjPkA3UklltGoprZYOjAjfdNwwvRIXG+bojNuU+Z6TuAK
         TR8EnMI5chSBO7zI6ehwbmkcb+WX0nQUtRPDc3qBIoGdKeHisyHiXv4oeQpiS19adkth
         JLNE5P51h1ucDjkZ5kwBjhnw+yfRpmeG46cplq1aaYUz+jDKHpVgwrNOt/PYZjZM8v8P
         a5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527142; x=1775131942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOQcKHhSbpnRXlvxZdOJhqpuwk1wdptQ8/fVLC7kjw0=;
        b=iuh0utPCllgHrRNicMh3AHE+Mz0Ms7uzDAyVRq+BFnJBCVWNz6HjNOXC6Zk5iRP9tn
         /EwuxNJgwOGbFKjU28ZlYyaCWbU8gIcTkXCviUa5H+JDcHctK9HF3thtIce8DV6vkBSm
         xCiGki6noGeQdB1ZJnZZS3h1Y6jLYShRzjjXS5x8jp5d6mQE0Xl0CVXuyNqobz6oveeh
         pugnlh7WMGyPsio2laggA39pNi5dP6hRKS9cja29AjI3dykLYF1PbG03azwxn87EIfVB
         MNa1ClvCksizwLEj7JV64+9dAYceE1Kh7X+fzqxA/Xsd1qQ09bq2IeVvdi+aQPQQmQPz
         DznA==
X-Forwarded-Encrypted: i=1; AJvYcCUxb5JF3TOp3CLsIkQStnLhgwoLCaHSjLYgRvzqAaTg6bfUVV2jA3BTfgE+W3wzNRZFU14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocZRTfy0o/PNj++rdo4L5MSTx2uCfGyhhP9xZuuqHmT9HBKIh
	Jl1aQatTTrC7j6Y4mN6qVtPXt6b9fo1lZAFGa2ql0UD/rs2e4J+MypKP41RuClWzeoeSyUDHhkW
	7q9bx
X-Gm-Gg: ATEYQzw8mLLEJXv1fMnQ9aB1D/4Yjnj+WwWCgp9xkeiL3gkXlM5G5mP7agrW95u2uqb
	UISufV8nXPPIaXJ1R45QqJaRA5pFenidRwiwAUGINUbKQ1TFtqPE/zMelfZt3Y7m2yKHPdn50zf
	OOxhlCGPTgTtM6WhUnTtu79NZkhL/V5l+DeAZMJo2nBsLRvyHREuuAo+Hpy8UQKoxRKisqpELFN
	agWA7xJzsn/V2kp1GyMn7H5pTEXAwSCOz6lRqLlyksejuGFkTWr/vFqjyxoks54ltrx3Rr+v5C9
	VnEPg0vlbeAIgnfkciUPhTsW70lwMgjPimMxlyOiAbW0qcxBWsbOgszKBrkL5EQ6IyRVLkLpFdQ
	fMbeveyLhRsIYNZCYdlfosI77R2Y3RlGGZawNYKHtwk7V4K8mNnXfD7T0W6DDpydzVMpXdj3uLB
	jkk47qiJNVhSRQkp9SWF8q7zdeWt6cIJU/fP1f73eftZP6lKVcxWw5wr8TsHg/eQXnr8PlzQ==
X-Received: by 2002:a05:620a:44cd:b0:8cf:c877:ed1d with SMTP id af79cd13be357-8d001092beamr972621985a.69.1774527142407;
        Thu, 26 Mar 2026 05:12:22 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4fa7d9sm237271885a.32.2026.03.26.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:12:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w5jZU-00000000mo9-1zIg;
	Thu, 26 Mar 2026 09:12:20 -0300
Date: Thu, 26 Mar 2026 09:12:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: alex@shazbot.org, kvm@vger.kernel.org,
	Renato Marziano <renato@marziano.top>, stable@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] vfio/pci: Fix double free in dma-buf feature
Message-ID: <20260326121220.GH8437@ziepe.ca>
References: <20260323215659.2108191-3-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323215659.2108191-3-alex.williamson@nvidia.com>

On Mon, Mar 23, 2026 at 03:56:58PM -0600, Alex Williamson wrote:
> The error path through vfio_pci_core_feature_dma_buf() ignores its
> own advice to only use dma_buf_put() after dma_buf_export(), instead
> falling through the entire unwind chain.  In the unlikely event that
> we encounter file descriptor exhaustion, this can result in an
> unbalanced refcount on the vfio device and double free of allocated
> objects.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
