Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46703D6CD5
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901261; cv=none; b=ic1IFDYUXUlMdj9qU1WOegEfj0L1ioQdVGYdAdrxfxZN8CIrV6snFFsWlX3acsui/ELS1pbXmOiuFm2T0ngwnf8PnmCnuZa718ceNUo/EDlo5jnEKkSmrbmmbQAfJ/kLliQ+WzCHfTBYH1HQiEwobGHLacerb29F2vEF++nRuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901261; c=relaxed/simple;
	bh=IC03rV44yx8SbaDtxThdFCvVl5fVz1TnoYNrddEg7m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxuSmTNyDcSj+c7iSpkn92QOJRKdg1UdMQJJ4loakRdMcTfzXiOcTjpMieqZZGRtrq+E8Ec0Bcmlf0hnVnsARZVMTMx3Jcss18faU3fKtAtWCsbu+JGQHhMgfYxrhn/t7iPUMt2SJ++JV7OxbJhhowytfpCAoiVApN7cL0l//1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDxCEQSd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDxCEQSd"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso885ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779901259; x=1780506059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Og5FR/9qWtaybmoKawxFptjk13+mvY5AZnqWPtKcDM=;
        b=GDxCEQSdMC0hubLsATO5WComY3s4aOxIvo8zo5MBQcddD0s2rbrd8T/SRY42mlbEAX
         mGAM/d47Lk34RE1vmQRvMbeyoTNLrlRloFv1yvixSD1FgwZUdLk9SS9RfNm9HZW7M5rk
         xyAbZRM6JHq6pQvp5ZeOsNNIzTf4ieP0xceKeCD71HSF/ITKratMsvfj8eux72jnQcV7
         yt0bf0D3eNGPijaVycsEfGqjkE1CqjMNgoKt2X52HQksuDw0b3PorZX4o7Lgv6zQEpFB
         TmeZk2HHoBpqd+zUsuKdmyto6LCiYETfp3mjhGoMnONEFi2FdEzpA/T79bjAUhYWUD2R
         DXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901259; x=1780506059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Og5FR/9qWtaybmoKawxFptjk13+mvY5AZnqWPtKcDM=;
        b=IoHn1LyRml2TI3YPuVMJMwujbBf1rPYKewxh7L5I/t1UtmggQAX/3m8QkB5JQKHSLR
         DAnj/Op77pEcM+C75/GY1n8u4y66gd/FZ7Mch+eaeoO3MJJxS/PCy/m+OSMnTVIcb9c+
         Mt+Mtf8tt5noE6x6aCz67t8eKax/g+XkTcIMQpFMcwazQBh9LPIytxN8/9jRCjhRZ2Ce
         hvH6xA6DwFzb2ov4F8xr8jePh9Xr9zWeyupWBgUW940P0WSu2hYHoCxB+lWAAQWo+Fsf
         BnGs8cy2d8HMOE1UzVZznjePdxprTwAX70+QMNgIAwMENdSJjkDoc6l7sSndepq0JaCG
         Cjaw==
X-Forwarded-Encrypted: i=1; AFNElJ8LX0SDzUdxj4BsNqWs2EeDevNKpXWrZMxwB7YIGlcMRwQ42mWV1pe/sbB3qW4Igp9kAoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kOnglZbLkavtuQRN8jE0erY8u1ARhe5CsOHYo6Mvlm+RRjHc
	dApFT8GS1IdpCadgAyN9UD8EzmAAP1sNI+MyDsNObLi9flf/DBPRWaWBQMLLklFeHA==
X-Gm-Gg: Acq92OHojvEam9TewbO0PRQG3wyx7QlaeknypPh4yT632p2FObBMelzYWIFaBwN8Roc
	Jx5LpQ/CQZLjeklKD302O+tHuWbt504gKZ+d1USQK8MynxbC7039Q/0svWQlNVpNgH7VKPNuKkB
	dtEAWOJ4Gcdllhwqy1bdoTwwSy8bEXn9FnowxpdwJ/xp/V/BUViE3STILkusM1e3U75X2iRguxw
	uAXpAqUl9NnHsQhaQ1DGVS7NP784NEOMXmTfP7VTnUvEhR8GxQXI8I8Uue0yjatXtBhh/xzllrR
	Nx2heZZ9Hi5LBKzwDdEQpS8jQ28HMCHckOc6dQUkkpFDKfbWf6U7qUqImzmhDJ7Cl/o42YSkPyn
	ZceMJX73t9iknaIdJ3wetZLZHZeBYf9XfYMlqn1kXZXbkhA2Ku/Hn4OH3+bOJ1qLMK4+CnXqOIu
	IhOlTD+XPUg3X6eyJeKQew46mu3ylYrtBj83+pe2bNWr2X1CFu89AfnSdCzJR9h0fZm5E=
X-Received: by 2002:a17:902:e551:b0:2bd:7e8e:ad56 with SMTP id d9443c01a7336-2bebe9feb6emr8862045ad.6.1779901258238;
        Wed, 27 May 2026 10:00:58 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b7653c9ffsm334915a91.4.2026.05.27.10.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:00:56 -0700 (PDT)
Date: Wed, 27 May 2026 17:00:52 +0000
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com,
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com,
	tabba@google.com, dave.hansen@linux.intel.com,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kselftest@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v3 5/7] mm: selftests: Add shmem into memory failure
 test
Message-ID: <ahcjRGwLFEN2NH3b@google.com>
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
 <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-5-718f45eb7c75@google.com>
 <9effbeca-3453-f0fe-571f-85f8923e1385@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9effbeca-3453-f0fe-571f-85f8923e1385@huawei.com>

> On Mon, Apr 13, 2026 at 07:57:55PM +0800, Miaohe Lin wrote:
[...snip...]
> > -
> > +	case MADV_SOFT_DIRTY_SHMEM:
> >  		/* The page content should remain unchanged. */
> >  		ASSERT_TRUE(check_memory(vaddr, self->page_size));
> 
> Why we skip check_memory() for case MADV_SOFT_CLEAN_SHMEM?

Because we did not write 0xce to clean_shmem.
The difference between clean and dirty pagecache is whether we synced
the dirty pages to disk. However, the difference between clean and dirty
shmem is whether we initialized it with 0xce. Thus, we need to skip
check_memory(), which checking 0xce,  for clean_shmem.

> > +	case MADV_HARD_CLEAN_SHMEM:
> > +	case MADV_SOFT_CLEAN_SHMEM:
> > +		/* It is not expected to receive a SIGBUS signal. */
> > +		ASSERT_EQ(setjmp, 0);
[...snip...]
> > +   if (variant->type == MADV_HARD) {
> > +           check(_metadata, self, addr, MADV_HARD_DIRTY_SHMEM, ret);
> > +		ret = sigsetjmp(signal_jmp_buf, 1);
> > +		if (ret == 0)
> > +			FORCE_READ(*addr);
> > +		check(_metadata, self, addr, READ_ERROR, ret);
> > +	} else {
> 
> Should we always add a FORCE_READ() just after variant->inject to verify the accessibility
> to the addr for soft-offline case ?
> 
> Thanks.

In dirty_shmem, check() already verifies accessibility to the address
through memcmp(). Thus, we only need FORCE_READ() in clean_shmem. Will
add this in the next version. Thanks !

Lisa

> > +		check(_metadata, self, addr, MADV_SOFT_DIRTY_SHMEM, ret);> +	}
[...snip...]

