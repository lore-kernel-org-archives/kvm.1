Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A53F8EAF
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371343; cv=none; b=lBTwuCLpMEzKddEopwS3y7BByTddJsrebvOHJj3kp0jPhz8bvm1xdaLcPJNFur3Y+nOTc50KYx2lJlg2mAnE/+dmAdR7HPTABnIV3cLT9xkRhHKqKDk7F8ywyvpw4UqkAgUJo61mP8U3/JQeoGdnQaBtTqou41+CNX7sRikp3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371343; c=relaxed/simple;
	bh=nruYDjYkbVoSbTlu8ww/YfnNlPxR3BwUDyr7YpbGo70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdoVrCuTL458z/JbPUC9HIn35IZULVTZRldxb4vjW8mhDdzmzRz/2Dx05J9hzS2KSqHW2s+2/RYvjMgWY4B92h3ery/YcZDIGFBTt8Aua9+alaeU6NG+2WA8wV7WuVNQEhy1OWKPUjrq0H9svX9sS2LWRe+KkQRXLgam3QhQui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=if1Z/eZT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="if1Z/eZT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-847a483e344so263362b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783371340; x=1783976140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAKNTA5FfU2S8dXtknGgkQ1uEtqxg5UVf4r8W8OhjYc=;
        b=if1Z/eZTtu4Y6PqfiIVg78VuoGxKinIq+QC+pRNCjopx5djzGXSeQugVhIkcmfY0EA
         UAi4QQJmKltz7cnXvRauCGE3aX/j4gquxi901xxOi+EGM3dlaAkginzXz+ZxSu9NSUF4
         knYIC71WfR8z2plIx4r+RF5k7Bk7jZe5VqVuWW/+eSw6qoNeN/Bg/neoeLfX7++MiOgU
         YLYcRan09ZWHbHpx1UJvFegbOLdrKVeGHZUrHN55A4R+o+0qrkvxggTNlj6SgY/ON1S5
         IzQCAG1wzruLXpFSWJ3rVN56K6pCJhb5vOsdyovs69nGfMqRvmprM4j0chVepqM5yqxD
         SDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371340; x=1783976140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAKNTA5FfU2S8dXtknGgkQ1uEtqxg5UVf4r8W8OhjYc=;
        b=KY+04YmXkcyTIRG2i/wl8TAx8ByBn69D2kg5FxFm6dUytJSqNH2FuMX3/7+1rgcVf8
         kttFr/ZFUZDd+wtjK2X7TS5yZyypEbYnzwoRM3fG6pilFVvi2UvgR/gvPwvVyfRvQqUG
         19zNoMUDDSXnxWAgYvgs4bF1AQTYB+mXA7GkYmFWFN/ivXLGmiJm2t/+de7dkoMVBUap
         ZoiGAmc0edgOutbqYtHLHmRu2mX6W1U6iUYbA0kGpuS0IQyz5gwFSN496F+gfHK+PLrT
         u8TFYoFfETo/+lLz3l+xIlCmoAbQIysVVthR+ZSY8KQQ5Abm9mlOXaSKP3LT5p3byRrp
         z/wQ==
X-Forwarded-Encrypted: i=1; AHgh+Rofl1atU/mKoGsq+ouxNt9QWcaBcaJ4EIH6meb4uexSUkniAsy+BhtPdzeudY8MqkcdSEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJQNhot0YC/6GUqPNtWRmUQRh7Jkb+3xvwivvk1P/Ox/YNm8M
	KS+jB54y5v2T8aljh58V8F7O/wdEBRWRbpYwOtbTnSn/h4api6hmIVm8ZM8T4OfAYw==
X-Gm-Gg: AfdE7cn/xt1XCTKlC3XwisblLk6J44YMFmUrPVsV7KbE44WdMJ5Zj0IFA7ipgKQW2R/
	mQq5A4sBfx1/JlxqKawg+d0MGsRLmwmr8EQrct73Sn1jQQUllIhlMAhBoqSwau0HLRFfmboZYld
	oOjraFjRFIdGM7KT5OUXZ7X1qnFnxZqZ69FKYlZW0DzMQ+/w72Xd9xpcKFXzODEsuoR2tmhNDHw
	CZ+s24ji42taseGVZ/HU+hx1yk4K1WTwaNdrsBqFIMfUlLZwUElEf0T7TYV24ZMx7TfMieyyBMJ
	Ik7sHxkny7vlxGrCCb0w0ok+zzAsv8Ma+x1/IEv0SBJtInZhnbbLVgBW/N+bJ7QX1w/Ir3nXES6
	Z5c2EkZnJOsMsaZNceJ+IZ4Q5V6Su5dZ4oL5NEkoJzYtXdpos19jLNKZQR7G17/8DqGLnv+TBa1
	8RQLAMRD0D+YjqijFNl8KIZX2RFZ8yteMGIjb6HgrIquojnEac/mO5SmUrF8LLsA==
X-Received: by 2002:a05:6a00:328c:b0:842:6259:5e2b with SMTP id d2e1a72fcca58-847e1928c3dmr13916968b3a.33.1783371339851;
        Mon, 06 Jul 2026 13:55:39 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afdb754asm32680a12.13.2026.07.06.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:55:39 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:55:36 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 00/10] selftests/vfio: igb: Add driver for Intel
Message-ID: <akwWSNbHc2fprpcE@google.com>
References: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>

On 2026-05-26 11:54 PM, Josh Hilke wrote:

> Alex Williamson (8):
>   selftests/vfio: igb: Use PHY internal loopback on 82576
>   selftests/vfio: igb: Use advanced TX and RX descriptors
>   selftests/vfio: igb: Program MSI-X interrupt routing
>   selftests/vfio: igb: Extend memcpy completion timeout for line-rate
>     hardware
>   selftests/vfio: igb: Disable PCIe completion timeout retries
>   selftests/vfio: Add vfio_pci_irq_reenable() helper
>   selftests/vfio: igb: Factor hardware programming into igb_hw_init()
>   selftests/vfio: igb: Recover after DMA-read faults
> 
> Josh Hilke (2):
>   selftests/vfio: igb: Add driver for IGB QEMU device
>   selftests/vfio: igb: Use offical IGB headers in selftest driver

Please switch these to "vfio: selftests: ...".
