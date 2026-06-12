Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F93DD85C;
	Fri, 12 Jun 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267869; cv=none; b=Zyz93rqPU5R5NRm71cymlJle29gFrureWRjh/BaTYZm4wk8kaiVMIxiPedqLztOosJKXBCoZFQmRbfP7XPN5wSEzB8kLx9AFLAyxDPLV7BNnHccocM+5e3XtyJrfV6uibf4PW1EftP/bEl3s8637SVeOhYoqMKCffAXHBIpr8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267869; c=relaxed/simple;
	bh=UKfzpTQLSgoxXBu2isW4CaEfIzaw7u6McQl+HbEjRAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBrsD4Ek1UOmz/EK5WapBf3Zzt8C2SvoZQCP7Xb6Rq1ko2a5fkkh1VmGAzb35dVJ9/hFBLy5REtcEKF7JuBKw0f6Rn6yLVXeoUhgRszZWj2E7sLcI1feAtOhrG4JizBgfOsMMMTvgCrTBWPPEPloy4qTWTs82Z6OIHTg+RQ+W/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5nal86r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5nal86r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982501F00A3E;
	Fri, 12 Jun 2026 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267868;
	bh=cGo9yvIsvIj+eRLqqH1V9SxPyEGnmV0RhwWpE/TQRLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J5nal86rCc2lsk/CANrHCLMI7pzUFGU8MRhMImq/2MGFNHB88kitT1TvDFpay+XrQ
	 Drenkogl9r2UqO3DsOaHJb0Zh7N1UQs9hxiv+yLLfSwsU/qfcmLT+crmTbEFVIWUDs
	 eL8AbJTg+ci/ZEI7haCi2bushR4DrAENVO2kSULwOMTDwleBz0XCaHy4UELX4aHmlo
	 9kGdLFRrn3atYGU6Z0+SbVhXBFbPgx7yVY/LNV9T4gJx3TM+Pplk5mOdqnLCgMcQDP
	 CPW//m4Yu9NGQAYogU0IxTh/aytUaGnyWNCvkSWo2mC+mHhGM1s4ryKmuih5svLF3Z
	 cwsGHGWPeuUhQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id D75C4F40076;
	Fri, 12 Jun 2026 08:37:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 08:37:46 -0400
X-ME-Sender: <xms:mv0ralpbY8OZ1cZhOubkEpEnx9WpZgf43PeQeWmljmzUP2JHeeqoyQ>
    <xme:mv0ranhAO9lhZdHVgXHxtay71XaWNp6ANmlFgilfei6NZ2ZPvGU44_ozz_7dfJt_H
    m6WaI7nFmUgM7yASNiGs4mLbhUspXiaA8OerBJIB6oLJ6pPedblCM8>
X-ME-Received: <xmr:mv0ravhJno-1UPTGEwL6h5NJBtDM2SoSlLTb6B4zpl4OFUFEdrI3M8fr_uT8ig>
X-ME-Proxy-Cause: dmFkZTEtFS+1K4eXhcGekzQ6V3EgiJtIQsM4zCBH4PeymPoBfoFJ6l84nRU/Dqf85frzjS
    vnfllBskDapPCX96/JMh/tS4eR/VHraYy+j4P17ECYXnwXYwCzsjehXOAbwGNNi6GnV/0C
    Y1cVUlxCD9RkCT0Z/T38ce6babEvkvi2me7N7Nr8PxU3zH5R7gNkXVNZOApe49/SxQ/WXL
    f+BLpgQpwjvZIaR7JgwdJxrFVQ4KqDFwmCDNuh0/8kMPHIp0twRiUK8JiTM1cY7+siq5/L
    WPMWOZ25EmU+tT1TZp62rWJUj5dIkVWzYQGb+b8tGiix+GpeAb+UkHXEbGE+XE/wTVI2iP
    gLOYKsFMiTazhScZcr7tYisqw3O0UisTO/3X1U1jRV0+s7oyvjJY0QXcH2LF9h6YgfEdDo
    dp5RLzMHvfs3r0mjvpCjj4cdEug+gH4PFbFMr2/nHYuoWdM318vw+1rpk9rKdJd38jZoIn
    WSxTnIclbfHw5g93qTIknbf9Nm3Z6JTAFTKyDWwqGH9WazN2h1DBR+KSOaogFa0/t4aHn0
    xy9UAeLp2voo7Pr27udH7sgNeXz7kOA0ZjTTTUPA+fmhfnDhANFdEBC6gp0LnHp3Az0or/
    PLe4zq6u17TlZdkO8Vrkv5nQQRezHiXvWGULF1gayzILLuaKnkv3EtMFu8og
X-ME-Proxy: <xmx:mv0ratEFK4V8rPzDTeK5tdPJL5CvfcSmdT-yRSYZ9YSrRCMM7Y7OMA>
    <xmx:mv0raiAVvyuxxGXT9NF-xMJGrmRyXgH4vI-FV3Py_h6oHsRqJOuTxA>
    <xmx:mv0rap8EsdkYLie1wTurW3FVmI6kGoe0VUUKa0UWkT-Q5yHM-WjggA>
    <xmx:mv0raliNav3MjKRNr3vvxthISpTPwNVc7iSBKL6m5G84zMxdes5LVA>
    <xmx:mv0raibXv6j7ia8KyTrmGAfxL7BHRhjLDw5UzQT9mgt5OYSLRyuYoCpa>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 08:37:45 -0400 (EDT)
Date: Fri, 12 Jun 2026 13:37:38 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Message-ID: <aiv7bInvJdltX71S@thinkstation>
References: <20260612110853.3188196-1-peter.fang@intel.com>
 <20260612110853.3188196-3-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612110853.3188196-3-peter.fang@intel.com>

On Fri, Jun 12, 2026 at 04:08:49AM -0700, Peter Fang wrote:
> @@ -171,7 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
>  #define GET_QUOTE_SUCCESS		0
>  #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
>  
> -#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
> +#define TDX_QUOTE_BUF_LEN(n)		(offsetof(struct tdx_quote_buf, data) + (n))

I've got confused by this offsetof(). It is valid, but why not plain
sizeof()?

Otherwise looks okay to me:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
