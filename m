Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AF421240
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834172; cv=none; b=Xy814GucHvl8GOk2OP9GrfQ3wGHJDtkkNyFtAmmMllcL9djLupw1uOKW6/9qkOFbbzPul5IFpJH0y7gl34iO8QY/lv6uni9HARfIQjpLVzbqDcFDRLHnIce3oaOd7m8o7VuJWxWTc5XqHE8e7NoNGxG3iFTEAwXbyhNrchE9goY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834172; c=relaxed/simple;
	bh=IN+j4qhmvzZzw0racY6eBMDXhLNl7L91DQjXjcqFtOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiWbQJ6TlGl7UpRbqcavrlpj2f3ElesAVZR7mJFJdSBJWsaIDCkQPCFrwg8z5fXkzQdeHYIlv24RG+mSGEzILk8oKi5mJG9iNG8cI+eqwd5AHSwb4wl1/ZIKl/40mzaTgHm1tCMMNBGcV27Y2o/R4BFZfcDyfirkLY8ecKd5u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcBe+kKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcBe+kKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232191F008A3;
	Mon, 12 Oct 2026 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791834171;
	bh=rDtrw0f8mrw6gHdZ9DRAOVFvIiyYA0pBZrU4Aoe9j+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WcBe+kKdwd/4p5FAKkIluWqY7S+Ln+SFrED0Bw8cOsfUsrVm3GYxAK8v/spZMyWRh
	 twpWJBpKJyArwGPeWQaWwUqh606FXJZ5CT4gTPNCYb7M8FtuBrkb1vvxBViHrmtinx
	 EDEdpR7Lh46PSRmHTYB3RgmPLkzr0ULsANHySzVmGTyBOK4e/xAdqAIwwJAEvm7B7m
	 0lXFfDJ7bTnP9ZqyeI3iumIBYdvkJrc8MWzAOq8hAsXvbV9UuuvCCtoqz0PMV55k2+
	 m97BCr8S7GnXbhqGSrBb/BavymNVNsZcmqTrWQbETEL5bd2vLfX5T18V+MZftXALgd
	 3JtdHxcIW3MJw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 418AE198004A;
	Mon, 12 Oct 2026 15:42:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 15:42:49 -0400
X-ME-Sender: <xms:NzjNakTtjFyJEIobH29kBBtXsCgxpnQUIu586h7ONsKqTd4uqp6upA>
    <xme:NzjNapXtbQ5b1RsJSbvhDbVjE7lrbO60k9K82ABoCJ5WI7rSkNGitNKpD7cIa02t_
    v6Xsh-R6F6sY7pWYnjUd0aN_bYtxzUsMh5vWS8g2DLUiXePiMXto_flgA>
X-ME-Received: <xmr:NzjNahcRST7Zsr5V1BZwDLc9YyLWntHmvSahqo7KRBpNXyn9K2RbEgvCTYw>
X-ME-Proxy-Cause: dmFkZTFnmaaHimdgDncFU5ghUKJW9/QboIvGlRYE0iS5gtleWpTh0zgwXl9V1hb/kzVd+1
    27p0qEbJuNaIj1lihzcV1laxlaPCfbnb7AxMG74X//pqGNz+2XgWg668vBFV5CSZ92Ttcx
    LT+NjgNThwRiwKznE3PtTBFFYwNKv5WlHlVAaz5T+KPf7n+AA3VasRYG21yG9fGWbY+OwV
    AQQ6PokbKvkb8sRQ1OWsfYWIFS+ZdXq1/j26g4DcZaNNoU1crsdP/n2JrD9Jm6P4dvugPj
    I7hjyJSJOf0xEUKBAP4SXwSIZlbWf1PhsG4+7WCYXg2OzkuHYVDvtIj83CT0nd+bl+8fCC
    krfbCPACP6iSKWwPtlf5RabilpBCk/dhhZ+Xll9IbMAFzn2ND902F/VOSdUEAcnXhUE2oE
    OKyGJ02UjdKzAqs+OAMx/lsGrRNxpE8MVJ46n08i5WzgPP1027aYNknSXATHou6HtnogW1
    6STJgye5tNBY+ehLbyaKKNbWjyIAZCdvGO3OLSk7p5/FMclf9IsxTMPFBzcCnAfRY+iD9H
    5evMY2xcIiTgWqKhPkNa3zw7pp2sV0ct0MAkGsOsY1CXdbTMbrim1KpcG5SevoAxTBoot6
    vKD6Zkwq5EJBhYfT8cjEjI0BGBv3q4Rje8eK0k+Eqksdi8OtmNH2SUgIHskQ
X-ME-Proxy: <xmx:NzjNakxQXpHRig4I5jWSaNjlTRTyPz_xi2a5TVFiq3KKCe094NAIjQ>
    <xmx:NzjNakEArqPBJFGoqrivMLZQbLw1AHaWp41QJdBjZ29wC3hdqkzQ6Q>
    <xmx:NzjNar2_wn7quNiRxtl0BIsb6jcGf6rorzDGAifDhCw2xX0LhyXc3w>
    <xmx:NzjNak-NZw_Kc7tipf62aAWjI268KZiug66fXm8vRSufnK1wMslpPg>
    <xmx:NzjNamFwRjDEQ6vy8SIhJv-3CG6Am9Ep8aVK_PIlnxwQlYeMC8FigkLt>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 15:42:47 -0400 (EDT)
Date: Mon, 12 Oct 2026 20:42:46 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dmitry Voytik <voytikd@gmail.com>
Cc: Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-coco@lists.linux.dev, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coco/tdx-host: add Kconfig description
Message-ID: <as04AoNxjzlvh-K8@thinkstation>
References: <20261012175348.1256363-1-voytikd@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012175348.1256363-1-voytikd@gmail.com>

On Mon, Oct 12, 2026 at 07:53:48PM +0200, Dmitry Voytik wrote:
> Fix the issue when the driver always gets compiled as a module.
> How to reproduce the issue:
> 	make mrproper
> 	make defconfig
> 	./scripts/config \
> 	  -e CMA \
> 	  -e ALLOC \
> 	  -e KVM \
> 	  -e KVM_INTEL \
> 	  -e KVM_INTEL_TDX \
> 	  -e INTEL_TDX_HOST \
> 	  -e TDX_HOST_SERVICES \
> 	  --refresh
> 	make olddefconfig
> 	make mod2yesconfig
> 	grep '=m$' .config
> 
> 	returns only this driver as module:
> 	  CONFIG_TDX_HOST_SERVICES=m
> 
> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
