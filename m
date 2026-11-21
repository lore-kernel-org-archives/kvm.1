Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265253;
	b=Yyx804t/B3GSyB+ytJ5bvfy2MVHjYyf3oKsxsH8gIVQNkG27w081OjnPYhvxdO/qT9Bm
	 Om8rTctroYVlD8MiA9CPyy8t6JM/SfWOeiikS6Zl6AAVHvi+QEP0WSzykCkPeLJlrNMF0
	 KgJ1YRw36KLWhz/NnL8uA/14uPU7eKn2cwRfRBoQnUwnW/QCUAWfuU7kfTdlUkE98dR8J
	 CD7EBt+m7/H5MHQRd3ZlTscLKyTZ8yyvJMTFzz9nhz6fQ4MYk3MuqEJYFgwnt7bsat0El
	 Y9cTnQ73QPZltjrSTsezQ5Prui8St0ZuJeo4/zkPAWpJElPgwD6aNp3Jk5HNFsLBZ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=dy/9BbEZRYuwT8a6wlWpCFQITWgRsvXhPUvkZriskFw=;
	b=L0WSySko+SSNuKLWIKPBJKqWegE2o5xAQUSD+KwYL+kWhBzmzD99JXhVjNQP9+zNAksh
	 SVf2x4CxgTZ9HbYXIHu5NvWChsp4aCXvg0HmMBv19sluHDFEmuLB8Y9IxmUhFiOQEPWaQ
	 7uGNQc1WZCMeTndV4HpfF1nd7T0ptG7vKuMDe2kDPnpi0GDCK0wr97M3ndcbcMnH9x+mp
	 M3yhcysYsl20YIAjIi2GhXx+rzaXFqvPsZKArAPYUVeMJKntar/b3u3iUrBOLZ7eFpBBs
	 Ne9znYQax0q6FxfUossbb5TcCtsD9w7kmJyrZ2EPRp1vt0FtNZNZrvDapE47Li6z4mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lFCLDijC;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15352606A330
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15352606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lFCLDijC
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-194d0c31715so3286c88.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 04:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795265251; x=1795870051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dy/9BbEZRYuwT8a6wlWpCFQITWgRsvXhPUvkZriskFw=;
        b=lFCLDijCWR4c0zcB+lObbjKd6P8KnxKVD+5W6jsOzhzeEv6sPuTZF2x3k6ibOSSL8h
         mravhVYe5IKpSZjrpSbRMIyJDu1IE9lvxOA8ORus8K7msh/cVLWJseEDXTg2sUyWmcMY
         9Gi4j1FMV4QbRTYDIbJu0Kf84qxr5my5njtKUk/zRZgYOBR/1XvbSDG1DgtgmXaFix9X
         Dm14UECJ24H+BuoGvAQobvq8f8VGj7HT4yKmd4Ehz7j7YoDDq5wfDkuUQuAuRhEEPR92
         /AS8yYrR8pR/hFdATfiCqeU8js9EB5tkqcDTaGdBcHtu2SwWSZhNByUJxJmXooaNZd1y
         lxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265251; x=1795870051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dy/9BbEZRYuwT8a6wlWpCFQITWgRsvXhPUvkZriskFw=;
        b=nxuKzMGQNvDrd2OuoG41dxCqRSfYprMgu8kaGBQLCmGwWJXA4l3drgM/+XN/YMQcQX
         z8YVqsrff9zyfbsrq+zUnDLOyW5FRwMLqzv4StxGfh/ondh97ZTih1LmEoinGCvXouTh
         AOxTX31RV5QrOS6O66FxkKohFCULfzNbr4kv9eU1GtulpuhGXJaGLVEFn4C5tGcfyTKN
         VkWZsLULEspogOZMPV+aIv7mcOGulZhzz+X9QD8/DtpRe3oWxXp1IcgNftpjWSbyw6Hb
         xUJeNZjJwQFtp7k3rYyjYYj/CAKth8LXVcismyfeuaUwL83gVlKvqljx+AB+qPVjaVks
         W84w==
X-Forwarded-Encrypted: i=1; AL+hErFlS4Nz0ujYOkta9DNuy337Excl7l9pyNf1TlGjwujr2mQC1cbZbKfyGNZaeYEIlgeUmDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3/0UIsWUCdLvBhvBFhq417ye1kWNioAStt1/+yvhuS/xZQxuc
	W1Gyc7xS48dGxvBx0tmPmCVWQBTk5EIjEGZmCJhCBUo2/oYpPQEVaiKyMBUKwes6Qw==
X-Gm-Gg: AZFdTZfyGb2FBJUfjD1y9wdYSerqdCNBvuxUIBu0yOcH2fl067gEUUOCOFNqotsWdEr
	fbsy/C+TiLcyHPi6MfZJAayDp2ld8Q/2RnNxglaZlVYmpZSEXXJ9lA+T72ZQB+13bI46uFmfZfw
	N2A2AxJa7BV/8rbyLz8PqaaZ2Zqs61hdaQSsjqT8Gv2AJr9VIQP6sqAjOHfNX7UQXfT5MxAITGp
	Htp+PbxVWd2k/4FDGoWYz2pNtNDIHTYBFm96CXLIuoSJt94tnfr7Ygz+Bgpxmd9Bc4So/6vbg+H
	V1+VGu1rYeS9/zjUTTlkTV4+4JaEWzTsfIwuiqN4uAxmGduBQqDLEg1P6TkpTBR6F7JlDJ0LYc6
	PAaQfBxAC9LjDmt8/lpXhtdZPmC2q12VLweXbCqItYTjOYg8MDIQ4sFdedW/XZG1t/RjgoqcwV4
	robfm4Fx/zRgR0czkxIrRXWopgF7bkQLfnMSJnIRW7Tx/sYxqdB5dpC31DvsvUP4u5IjAsftKU+
	F5foIFG0G3ZXoCzGAopCcRmStwkysUNGKh163tr2rbXKIbw3yVnLvUxQlKmrrBuidpUe+LZTjPF
	ik2BpFQe7HYMySz5w9W5wPeH4WVQbfAi4EdNhdN1jUdqaU6ekrCkVqf5gTl4bVUgTd8=
X-Received: by 2002:a05:701a:cca2:10b0:139:90c3:391b with SMTP id a92af1059eb24-1b56336e369mr649347c88.1.1795265250428;
        Sat, 21 Nov 2026 04:47:30 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm17147164eec.23.2026.11.21.04.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:47:29 -0800 (PST)
Date: Sat, 21 Nov 2026 12:47:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Mostafa Saleh <smostafa@google.com>, kvm@vger.kernel.org,
	qat-linux@intel.com, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2 03/10] vfio: Allow untainted use of driver_override
Message-ID: <awGS2tAtt0yKFXMC@google.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>

On Fri, Nov 20, 2026 at 12:11:04PM +0100, Uwe Kleine-König wrote:
> From: Alex Williamson <alex@shazbot.org>
> 
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
> 
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
