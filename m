Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577370;
	b=DEix6at/BgFfW0kGYD7LFXuEZkJhsaVUkty9uHyme/jG3SUohZZB8//MSJEzH7XVM9+Q
	 zhVW608JSs43FFKjQmfhOkw1T3AHtJNAVBZK23b3q9LQy6M0EYKV4jGOOp91AUnO81RHd
	 lVHHHB8gCQ3Spvl9SjFYowgmc4FHZVUlIsHx+jS5mD0QER1C55IE2vUALIJIsqUUuwhEJ
	 plqH8ODFddLExUNTuT8upUPIG0PIHRWrD19uEsQW26I7tS9WWsNPLatovoPE2GtjzI88s
	 PCdJUFfg+3UulWf5gpC/WPmNAuelnNw7yxGry5oGDYa15gTGlSavey4O55qAoZTpttw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577370;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=MomDzf9ezklTAjydgdZgOF6GCoe+fxI6qshI3Sn+i8k=;
	b=FROCoGPXYbjRUWpY+NRO1wwPQfRAb1rLGK9Lx+/SqUjVuoLfY2DHDavJMeYZHwJjo8Lu
	 LJlSumB22p+W81MgRY5itM6/iMwdj8D5oXv53gMq2xzMMM+BXR5RLiCM3UQ8c+6KKNXAu
	 z+H/jvaYN9gTiHhlpe3TFA6q3tBLmanqzXrs7615dAAEqyOPL3lsmEmFOG70vt+k1E0P6
	 7aVxK3X8nk4S2aOIUidr3haYKwtSPgfM8uHey24D727lWRfrWSX9SNBUDSUCEE6rI55F9
	 z74T/HGLWF24zQ69JDwbeN1VDpx9RzfeTsyHMdBXw8T5+dAfRa/foGd4HHiYtDsvOfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJJ16uNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E562606A31B;
	Wed, 21 Oct 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJJ16uNU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041EB1F000CC;
	Wed, 21 Oct 2026 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577370;
	bh=MomDzf9ezklTAjydgdZgOF6GCoe+fxI6qshI3Sn+i8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AJJ16uNUIz51qa8990y8k2ylKV9i5N/ru1SxeChWYPDSl5EVlo2EbJDwxwdMyfIVz
	 UTYYO+Rdl/21SI2Jsrcxb55jMvXwddYuLj10OSR7ve9HBQC+c6Nlq1zGHbBUgq8QJ/
	 GXXNL11qRUwjTZbv3OckWlfUVvxnpvUhOEcsdz2v5hTe4UsfiqjXlIsJwKk0EdJC0l
	 iECrKy5O3A13UQML6HLHo889otR5nj555AFiT6aFs8+TNttFWEXa+vuO2Tk5hGInQs
	 oOuOFbXAwMGe0dMootsHB/ut7x0tbZJJOnZUL3AetUoXPLoCoqSYv4gmCAgaoSTV2m
	 os0OVijAQjOpg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 457E91980047;
	Wed, 21 Oct 2026 06:09:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 06:09:27 -0400
X-ME-Sender: <xms:VI_YaghKAelp6C7x_UXpmnjm3YOvfwdKly3BSoKqRZ93n-FqQr6h8g>
    <xme:VI_Yah0lg-SqfdPcMkM-dhqG-_IFhCC5ahg7RDdUIT3Asg5QC-EEqFY3ZrhShbTMh
    -QIJmMtrlcLplA_X7WdDG3k9CVY5lL33YVZSQitLPouckYm2AA0yv2a>
X-ME-Received: <xmr:VI_YavCVv33WjaojE5Of6tD-4fnnLinXLLAkpXlMA_IcpYu5aAMiGWaqfMI>
X-ME-Proxy-Cause: dmFkZTFrWX9EKJlX/03kbzxt6ZTUfd0vFLBMSOeQ5q+rRZitrelbc4Zd+yLxR2dPEkZiXA
    j4PF/cOMfxQ1CCz5rP4XxVYLzqoaq3b48MtdFRz6HVZtuE7fbmirp4a4LppcC0uJR7RBS0
    evjYeDM1NQsmuXmlJgBWK5BYmxDgc7/T73/LeX2/QaI6XlFfp+VmpFT/Y+4OiVrMiaiFMT
    cPZFsVM6DyLzuzitl0KuLmmeYy5CLgV37qmMXEoDUsMbathTjRK34ORJ3IwpNwrpwjSbbW
    5DqZxyPbUbnNpIHBbyK33qtZQPagHPeuQuxL3tghFeA4xNW067Dp5rBj+G/ZMqGZAyN6sr
    J8GxODShaeqI26vxsOXEACx9BadlPzK7fIVAObXm/DLO4hDugcBSq8EQsrUTFmfu3d8R2m
    QdD2jKfZTJR4Ig6RIlzI2FpXeA+7YnxhJYXzWGIW+iL3ufKeAWp5j5ftZnzo+w8YpL93yc
    Np+cXCR4T53mGTp21QecDDyVh62JNOde05ym84mUltA0NZc9J/9VIzLEHGMqa4kGWaNPHS
    f4j/QOAkMjdyT3f0QF+bgQGKiI6prI2mqRjvuGTMYlZNnjQGIN7xzJsp7vxfjX1Xoo/s8V
    PkyoxYeVkImJ7m4wL+GpV4NRaI6QgTEuGTtyflOEcAzGb5wrx3tohMwRdXnA
X-ME-Proxy: <xmx:VI_Yaq2s-86Jp27jtg6KA6ztz3bIyyujIwWlDTFn79Fpvp9GxFFZsg>
    <xmx:VI_YamrrldCSwESSfTCihyVu8KzugFFGI7X0tXdcy7mGTW34A6-twA>
    <xmx:VI_YauVam1C0xDQu5_4jtKwJNoHXvUn7IIOU78hik9QT0qRigpETxg>
    <xmx:VI_YaqiyTEYzR7OgsKV90UwxNGwwWXmgEzwt73YybkelrWAVPE0H9A>
    <xmx:VI_Yat8fDEqIu_n0Ck9dLUzsiwKBP5JkIVI83cId-32f6UFAFYZJtp_w>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 06:09:24 -0400 (EDT)
Date: Wed, 21 Oct 2026 11:09:23 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com, 
	x86@kernel.org, adrian.hunter@intel.com, yan.y.zhao@intel.com, 
	binbin.wu@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, nik.borisov@suse.com, 
	yilun.xu@linux.intel.com, tony.lindgren@linux.intel.com
Subject: Re: [PATCH v2 0/2] Drop unneeded cache flushing
Message-ID: <atiPBtAVRC9hHXFm@thinkstation>
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>

On Thu, Oct 15, 2026 at 12:17:08PM -0700, Rick Edgecombe wrote:
> Yilun's comment about cleaning up the TDR reclaim after the changes in 
> patch 2 was a bit bigger that I expected. I really debated whether to 
> split that out. But it wasn't very feasible to do it as a prep patch, so I 
> left it as one big bigger. Really debated doing that, or an follow up 
> cleanup patch. Opinions requested.

I am fine with one patch.

For the series:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
