Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBB3CBE8F
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715188; cv=none; b=e13eu3xj/u9EAM9FIyVTxIpuXQnLUIq2x0eQHibVrWniuK9qUQ/61JkC4ocahrkuCeovBiarvCksikJgTg8soDceRRt7XpQei4yIttwve0QGF/p9bRZ1TCldy5k7MY8gEYSac9FJT70WnyU1vkraYjCM3WbMXM8RI1FXdjIYNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715188; c=relaxed/simple;
	bh=Hq/A3AGR+clgfWZctOXr6BbesstRAudCd0yGsK+Tw3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1G+e80zdpLbxlFYvPqPOsST5PhctczoM6JLUuUynagIQSd10BCMceMO1D2onWubrJEfJS2Rr4Sd+qMt8wH+ByzmP/9SWK/AejmtjAENq7BpPoJZyIS9GMJCVEm20LdHHQfJBf4h5orUnZu+1d64G5tkXI5/fLb6mJS1OHEUpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVX/59pY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVX/59pY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-366be8040a9so2962767a91.3
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778715186; x=1779319986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NsiDmjXtYlzjW8kSMiUkwYEAF0x8k/ex7IY8QVm8zJg=;
        b=CVX/59pY+/swuJ+Ri5GGnX84Xd3ro0LlqiWi7VdeZDKbE0XKB05tu+VossYFF2qJAI
         Fm0j38102ih6T4LZs2rO4GB6N9onecxqJ3Ek4p6qAyopQLUyCBCMLzCdsSBVEJ/pGlEl
         Arlz8w12ZaOszXEQ8gebGaraXib+3a4zGTcdjf6oj9wmzA6Ay+M2F3bWX170phcNSH79
         q5l+39wZOrX9J97f2RilUp9pMgWFWlk5m+rKs2uKJzP/NpXF3U2Q4H6SgcjHPruqU5ua
         uUo7esEFrnWiWjDcP7JHpiD90PzcUhSPrZ6zDD/5R6etUlnLZT12dO/w5UwjPiY2Bq+M
         /5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715186; x=1779319986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsiDmjXtYlzjW8kSMiUkwYEAF0x8k/ex7IY8QVm8zJg=;
        b=VmgG3XJvfEjTW3AekTfxgFumggmr+zfU82latFGkNWjBsqlIFVsyU6IVZh9aEgKVjV
         BBIfrtWyFhCMm6ODmkHB7Mt81ECprsD31+n9+KbjZsXTUePs6z7utklgKeTa+StpWLba
         RUO4Dmc3v80rvA7r/JkBbD3qqjtMWBtmBBnFKBPY44wWVU0RKuYFgGUhFr72Gn9vZ0gR
         O7AIrAK64fBQAqPS1mvAsysLbRJAt+ttvFREDOGK9qgireuNLZ0YtP2S5VP3jfwQA6q7
         jS9h4BR86Sb4pSd1Le/uQr10ox83+qQ9J+o9ZNUIo9dA3+Dz/qPKKy0tie6TLP8KlGbT
         EPxw==
X-Forwarded-Encrypted: i=1; AFNElJ8oKJoPLrVVZat6pPSNFdTg0hPn628suoiDnyA+0mRjSc4E2lA07yd8XGyShc6c1cUpEi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3zA30eMV0QQzt4TAqPdTWu1xtXxZ2FOCW1JdLtHmsUH3RBmH
	TXdqXQ4qgI7t3eBpZIWBpOQNmTr+ecbK+PaCiWUUKr3Bpu8GFpeA9U91W6iinN1ubw==
X-Gm-Gg: Acq92OFITLe5hR4r/N5HS404epp6pPEQ0lC6p+3wm0vDgu/3pIOCyL97oLeBcwex1wm
	ITd1rqcdlVWiKB/wK81d13Siay/Bnq9q9n2QR37GVXA0goO0EczfpHIU4TvcZEON0a28v4ifdHh
	alFjh9+pjT/jEOAcjemwmpCsp1kdkJ2P3IlInnW22kwCgIfTETqHdmgs60UFMZu7V0ufEFKVB7B
	IVKLhTjSo4o9yM/mIAYEiSUZyzmNaK8wRqjKltYHvh2emlYxpJ2Z0kPgId+ByzQsNIcfvFiF6+a
	Y7dN5zgzW3MJnVNz/kJi0jl6iFC3J7h3xrXs7K/NUp6xdZjWeaLbAHLB+4i40wSiEC2DhkApjal
	C/LyqckD6XjtqHctBT0RlL7xA078t0jWrhr8ezPbeqpgdXi3xg9UGCZMHLe0WsoIOpzyY9odi6S
	qiU6nQsst0fY750GJraLyDSLP7wt/QEdTKgnGSp/FEAx7gew5ww8uF02UQnyepuP3rd7QHl354
X-Received: by 2002:a17:90b:3a46:b0:368:ac5f:d313 with SMTP id 98e67ed59e1d1-368f3e7b6e1mr5890966a91.20.1778715186079;
        Wed, 13 May 2026 16:33:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb115c38sm336563a12.28.2026.05.13.16.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:33:05 -0700 (PDT)
Date: Wed, 13 May 2026 23:33:02 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] vfio: selftests: Add driver for IGB QEMU device
Message-ID: <agUKLmKLoV71Hq6S@google.com>
References: <20260511211839.2781731-1-jrhilke@google.com>
 <agJqAO-RRdjMrUZJ@google.com>
 <CAAdrzjtiiOtw7-YL2COgZC-QSFp6LLwq+jP9V3jPKLUe0w7Y0g@mail.gmail.com>
 <CAAdrzjuf3z-CyWeBRPKmMQxmQZ9U=2Tc0cDAFqdRFRDHKw_K-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAdrzjuf3z-CyWeBRPKmMQxmQZ9U=2Tc0cDAFqdRFRDHKw_K-Q@mail.gmail.com>

On 2026-05-13 11:49 AM, Josh Hilke wrote:
> On Tue, May 12, 2026 at 7:12 PM Josh Hilke <jrhilke@google.com> wrote:
> > On Mon, May 11, 2026 at 4:45 PM David Matlack <dmatlack@google.com> wrote:
> > > On 2026-05-11 09:18 PM, Josh Hilke wrote:

> > > > +     retries = 100;
> > > > +     while (retries-- > 0) {
> > > > +             if (rx->wb.status_error & 1)
> > > > +                     break;
> > > > +             usleep(10);
> > > > +     }
> > >
> > > Why bail after a certain timeout? The test may have kicked off a large
> > > count of memcpys. Is this for error detection?
> >
> > The bailout was intended to detect errors during development.
> > Shouldn't need it anymore. I'll remove it in v2.
> 
> Sorry, I forgot: we need the timeout  to detect DMA errors for the
> memcpy_from_unmapped_iova test in vfio_pci_driver_test. The test
> triggers an IOMMU fault because the IOVA is unmapped, and the IOMMU
> aborts the DMA operation. However, the QEMU IGB implementation does
> not set an error bit, so timing out is our only method for error
> detection.

Hm... that's going to be tricky then. This means we would have to set
the timeout to longer than the longest possible memcpy duration to avoid
false negatives? That means we'll have to set the timeout to quite long.
