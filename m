Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30603CFF44;
	Wed,  1 Jul 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897756; cv=none; b=H74VJi7q83aruhZdrGFVVUtTu/pxEHA8h4ds8c13UtV2zCLv37vfGdRQcm+AZSIXuvoYYLqmxsEaudk/62xXOPwoCRs+F0chftXI3dFUJFBjQ11maWVZGYMYEyC0ur0MHcXLajYkKA8tAy6Rt+SG8oLNuaIVtwqIRzOeiYcwIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897756; c=relaxed/simple;
	bh=PGNlMz/ldxIbmhOjA6SSqvseK/YttsS9tMAQyqdgtL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImiEyyMJ1sQ3ue7tW+T9kC9vo+aOYSzr7GpPCXxaLu3IVjkcQ754YhzdYTT7UqdK2ExPKx1OuEyMqPcv7y1d1IrxAE9Le5H6bTBSOmSZ6r/9gFG+aDTMsKzw2AaoEqJKOTdDb7JKZBRjIe030iR+BgURL7F2CXIqWF5S5NpTmJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbEg5mlC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbEg5mlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482921F000E9;
	Wed,  1 Jul 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782897755;
	bh=QC9eMQGEwS1mPstbudBwJ2k/M9odx4x/ZU29lVgmBw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XbEg5mlCFsFNf8WxcslomD5TBF+duyzVp2giqWTFQ6MDQ8l0wG1Gk5jllN3/ilY/4
	 3kEX9VZFvYedcvqfzvjr0IZfMISKHoMQ6LnY/QIH9LzDONEnXjKQoVH+c63j85ldcU
	 UDZWnaQMYZmRHLk2m8tkQ+KBl7gCbe040yCo9zhGI/kt9pS7wYNO4xfmy65fKsATbN
	 E0BfybuQX9lquPrLKWAaQ4tnKJP+lyd6ha/VtERSyEY/nswSbXGiZa40A5txNsFNdB
	 uLAhyb7sS3yZENNqbKxtAVQYvkz4osvpqGQ9xtS2hx3Nmd5ecIw7wRcR1FOTpMA/UT
	 X8aaFmhlI4tUg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5D16FF40079;
	Wed,  1 Jul 2026 05:22:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 01 Jul 2026 05:22:34 -0400
X-ME-Sender: <xms:WtxEatBatq_LxB83cfl-ohLWsFHBW5x0TmNdrEw4_2QwOiZYwWcRkg>
    <xme:WtxEatMlWFEfg1gbBW7-ot6W3tvgHJhzVimbEyKnHXPr3F4tsw0fXQ6z9J4Fdofdo
    4FiuMxTKxVW-BYf3nHkog7RFdkVdVuqf0eRxHGSRjZ4NKW-Ca0aNdM>
X-ME-Received: <xmr:WtxEasBdBqqZ89ieIw4gf1MSZwrXA7jD6g21nGklNPiLsdxUaPPiXwXaBZr_zg>
X-ME-Proxy-Cause: dmFkZTEU2XvJf4FUpRdoStr5992Qvo5BG7diE7G73HVsj48BwRH7DIS6R9JXJFdVfvPbob
    tP+6Uad1a35epu43pCTMZQ1efJBO5vVkXxspnZ+YvW6t9qMDGWnfhboFqhNfH0JTYOJ/jQ
    cqqzQLh1TBtWOPaBK1bsw43OxzUXgUdDbntzroxqM3g0cpeyJ5jnPu+GB3u5Fmv1UTQDm2
    dqErAgK06rm+gzJ7VdhD33o9JVgrIdTE6rQa2wvD7j171Uv8JkVt8+OAFSFiBB+8V3XdlJ
    huRP7hZDTl9LXlOQcYivzk58fPk2X/qLWX/v3d1O7kZbxyHTPhAVhMZ0T1wPNQDoXY78dQ
    zi2boI7lNdVXLM+tgBC8+YOafUUJpAzd35j0qIwcgLqG88936Evs4GNnbwsLLhXClVNqQw
    j/4xRn/L1YdWKbHYX2aZMpj/RF1k6+8zoKDYddfUjSHdSX8426pyqzvPCgf9CI0iIsr4K8
    q9tMJTdAtpp3HnneMGA6+dojPaxsR9pAz1Qlh2wIuy7eHxipflUHNYqfi3N9owkxVi4fQk
    bWkk1+7xz9R7BOi5pEL8uTfXstf7dyBoNgEOI/vywqF50vI9tEiJo4JY//kF3E6KtsKsLi
    SbDYqt/1WT5/c0Apt3zAMH5P9CG99mxrUQPYLfY16eFDQrodK1/VZGUTusoQ
X-ME-Proxy: <xmx:WtxEanlgX2PQPIBZ0XccZsCXHJi5b6U9ENVicgXSMZekSXY5kDDh_w>
    <xmx:WtxEaoomQeK0_hOEWYwZ8dIEfKHKn-oEDyjJee_eDTbExR1OoeDMOQ>
    <xmx:WtxEaujjdzJ4g6nkSOKGiC_1Nk4M9MsdWAeQAkbWJEdnqwJxMdxa0w>
    <xmx:WtxEaqiAhtQz2L66XuTeotdXOTPFK_Fmxi1NFUK4Zl9LsFfMLFBjZg>
    <xmx:WtxEasFubIc1QrhO8IMoZ9ObFmg-K0DHn4aTDQtP671aqpxhP6CW7P9->
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 05:22:33 -0400 (EDT)
Date: Wed, 1 Jul 2026 10:22:32 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
Message-ID: <akTcPqeSRWyj6akB@thinkstation>
References: <20260630213711.479692-1-seanjc@google.com>
 <20260630213711.479692-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630213711.479692-3-seanjc@google.com>

On Tue, Jun 30, 2026 at 02:37:11PM -0700, Sean Christopherson wrote:
> Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> consistent between TDX and SNP (for LAUNCH_UPDATE).  EOPNOTSUPP was chosen
> to be a forward-looking error code for when guest_memfd supports in-place
> conversion, but even when in-place conversion comes along, it's an awkward
> error code as KVM is deliberately choosing to disallow virtual address '0',
> which is technically a legal userspace address.  I.e. it's not so much a
> lack of support as it is that KVM reserves address '0' to simplify KVM's
> internal implementation.
> 
> Opportunistically move the check so that it's co-located with the other
> checks on the userspace address, and so that it's more obvious that a NULL
> source address is explicitly disallowed.
> 
> Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
