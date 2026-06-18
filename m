Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A19347533
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815411; cv=none; b=DLSUfQgNk3WicS+2FIMKS2CZZVyrbTxvxgzoAFlnYgf50zLbRBhSoaNqdHWVMUDYH28q9VmzJg46KZBkbw1lEvSl4ok6FBEut++wy/0WMibybYF05765dJWtJvft05zHE5DlHwD1CRvgIKT9LLVDSJOn9AAgadl0lzULHHkfuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815411; c=relaxed/simple;
	bh=8hBCLfH/eUYN/8OyUODW+AbWvZee25ehqy42zoDceEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugwV9I/+9JyyfSB6To4IS759Qcynt2F4fTnoDbQw2YXZ5MmV3lVKk+Z+HW2MAZxEiiBJtmoZWu4ZLhFhwh4OjMejOc07B083f03Le5y//PY8eNmtJ0k2r2QA6FckwSJxSWSmmhj7RBR4SVoYP5/xh6PObhvj+y4Kdz9OGQVkFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inusxuyK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inusxuyK"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453a67659fso875499b3a.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781815409; x=1782420209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cl1wOvElj8v4VpvcZneMj5bA/9tCB8HmI7qNhRYEvSg=;
        b=inusxuyKj4Ggnj9/OAxZcVO5oPVjLoKWl4wqrAWDwVpl2fb10SaboVexcZwtYjlgLQ
         HozXVi5unI2w3kx5N0O/LXgNDMumzdm7C0W4SB2d2HcIQpV2+w0QQOAhl2jdMUF7IF1v
         CNCsIJGHWZp228UbETaoZKlqqwuYxinZmYGVLl3tmfeZg/MsvSTrl0FhuYkfflQS83cJ
         9Rm9unr/VqW75h9FISq9WDBLZSa+Q7gTiFCEtGfhlJVbydPwlksPS99KhXD0OnQP+/h1
         mkY8V+k7E55dGDSsbC+eNrER0fm+nEhGYEH7sQxydazXYKisvRa/2vsvsTXg4Slz9ph8
         h3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815409; x=1782420209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl1wOvElj8v4VpvcZneMj5bA/9tCB8HmI7qNhRYEvSg=;
        b=Xbc7sbggW2AmNkRqDc86EyYufA+xRHrEIpqibXghSMHW5nGNDx36ZAQLJaYOHtA5FQ
         CjD6/t2s5vNkqIq+iRIOgw4BZU55HQ9BqBAGAYogPdIojOL43paHMUDxz0AA66vKyIT2
         UP81Sclrlomk5mBUnW2dA5cQsh0V+NbBa1IPIylKGQ01TKClBjHblQOzfh3yJrrUCZRY
         GCtLuvQiIwsN8wN9nHxIa7MO/W8P7M4jXqGFmbGdyB61ZDracU7OHM7knD7cTRta0lq0
         itPqSIKr5Xlze6HEuAY7bI3kLUmE7WYAQ0VtWL9Clcg20oKNhTTEIIAd/ja5XXOtEF1x
         oRpQ==
X-Forwarded-Encrypted: i=1; AFNElJ91/U0r5ZCpMr/K4zMEN/+Rzr76JLL967/ZLw9invZOa+yufXPV+/b3WelZHvBMYyIVD5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Pu1Tw1QuTrBUR8EaLX3Hi/Hd1AptXpi1eKRVz64urqNpqQsT
	rO9x849M55wo+HPnm6tlJxV/6kVQjnaVuP/4yQz9H1xZtpojttlOUQ4mZehvrUEFXw==
X-Gm-Gg: AfdE7cncopJb5tSCbqo2Fxgc3HBVWek+b6MrunMZaJZzI8SUpcEZapWOkphhspj/bz+
	ttR/lEKi04fztMgmxyUZ1qIewNyoI7FmCWfQwGjL6O+hrZbEeE1SK+6u4pFFzIaXNuBL3BefikP
	6JkF7MTQs9BOzmVbNIL8MZyoffjM96/kl91+dfU0dv8kUJ2ExtcHIMV8VG9ARD5iaZ81ZT/c9Mr
	lZWh2LRcNdHy7XV7Q+IjIPfEIB10V1TAycQF4lZm6hJ3vtoUqDGeGu0rLKnb8aKN+Qz+h6VPjfC
	wWqRCpFHFa/b8zFjWXEWARNaOnbbvV50oKP0wxI/CFF93pNpwDks5tVLpSPeB4egUo0Q4uIp53k
	njvyC9/i7/LOKVlqMEu944TE/PRkLuXyKrqJD29GOd/aq7NTMbG0QWNTIhKcSWHmrLoGEBdbZVC
	3kzhZcjjr7PW7XocTlcwU2agvgPwQUILncnPsKTEmgLlcSXsH2I6E=
X-Received: by 2002:a05:6a00:2a0c:b0:842:7cb7:a3aa with SMTP id d2e1a72fcca58-8455089274bmr650023b3a.33.1781815408580;
        Thu, 18 Jun 2026 13:43:28 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455364d4e7sm28363b3a.11.2026.06.18.13.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:43:28 -0700 (PDT)
Date: Thu, 18 Jun 2026 20:43:24 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 4/4] vfio: selftests: Add NVIDIA Falcon driver for
 DMA testing
Message-ID: <ajRYbI-4ZczC_V7B@google.com>
References: <20260609232855.3808971-1-rubind@nvidia.com>
 <20260609232855.3808971-5-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609232855.3808971-5-rubind@nvidia.com>

On 2026-06-09 04:28 PM, Rubin Du wrote:
> Add a new VFIO PCI driver for NVIDIA GPUs that enables DMA testing
> via the Falcon (Fast Logic Controller) microcontrollers. This driver
> extracts and adapts the DMA test functionality from NVIDIA's
> gpu-admin-tools project and integrates it into the existing VFIO
> selftest framework.
> 
> Falcons are general-purpose microcontrollers present on NVIDIA GPUs
> that can perform DMA operations between system memory and device
> memory. By leveraging Falcon DMA, this driver allows NVIDIA GPUs to
> be tested alongside Intel IOAT and DSA devices using the same
> selftest infrastructure.
> 
> The driver is named 'nv_falcon' to reflect that it specifically
> controls the Falcon microcontrollers for DMA operations, rather
> than exposing general GPU functionality.
> 
> Reference implementation:
> https://github.com/NVIDIA/gpu-admin-tools
> 
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> Signed-off-by: Rubin Du <rubind@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
