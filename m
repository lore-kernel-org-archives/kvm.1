Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6531A2C0B;
	Sat, 13 Jun 2026 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310036; cv=none; b=Aw3D6dgtzxDgVmaD291vP2JowqBmDHDOWSnxpJfnbFwxIYWpeY2TBPuP/vxAQJGN/cY79+/Cn0MJ32o+oDJwSR3xeUefvQJIvYU1I0zI8B3UP1i1ds6vNVSb+u2Q8PD4oRCgUCj4eJSzqsElgrdMa1hhcfGXKv3pevjIqn0SITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310036; c=relaxed/simple;
	bh=A/XloPAD2cMS8vUfQ5KdwFSk93vR8Ny1utNuIYvd9wU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b4AOrhHMpi/CxOcFWPpZIb43A9uNGRR1y1pjhV3FRx8ulNTR5XYDWqslnYkFbvLVwTz3ylvNy6udj0Qr/YWQnzhvTLpUA/fpyFT05a1YN1M1GCB3h8seJewEy3RIT3gCBNd2sv+Jm9KLRJSHURvuPptHgXTmFoz5WRNSU5eyVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgJKyL2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgJKyL2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D8A1F00A3D;
	Sat, 13 Jun 2026 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310033;
	bh=X0Pc0LwLc4RmH6+Qu3X6i5FQfx/7NQF+K9TgmHSN+NY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JgJKyL2dsFf1fYjudONxl0omQdlc+0A3LL+vGAmPdjgUxHtppGLl80ujZ0cXS3Ujs
	 og1gjnpEKxEiDYenuYY2nJzCF7m++5KPiKG4ifS5/R8vAEIxAdiKuEV/tdI9pc/njC
	 ZhiWONOxF6oJH150c870nq+13zYN2l3o7hqkHIE397+JHvUflUgeyiRmcWypgHQ+WH
	 n9zwPs1zsd+n5de94mw10mCP5k17tzSZns9Et1NNKGnA4yO82Q2nYvmZbrzjq2PCLt
	 w/HKeXscyPtsPNuLzQ1181AKgYXu9QTSOYefcL8fzT9IdZo/zzUdUdisogaWNIGMrT
	 Snhfi2VConAyA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8451DF4008F;
	Fri, 12 Jun 2026 20:20:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 12 Jun 2026 20:20:32 -0400
X-ME-Sender: <xms:UKIsamZIl_rpbPZXuqyluy6LnQjftM8_QcZ7d1O_zIOVW_qT7kIiVA>
    <xme:UKIsau_WMIMWo85UzLz6DV70yBJsVkpRJIObEjPvoCQpBs8kacLsQcNtJ0OxKbZvZ
    Fb-gudC4252xn1eDuMVHRqGYjhiCvf3q7_eg5JBqlP0R9epvIzAn4k>
X-ME-Received: <xmr:UKIsaqjFizeoQ8epCEqNN1symK3Dm4TdD7BHGVmtF72bjLguVgPv5oTPRanWIGKpv1AJRSpS7Onj6WaAOvihsv4pZJzC-fJHR7A>
X-ME-Proxy-Cause: dmFkZTEvXz8b8PCNm26NU7mvbWwj/clozIv9nUxrgaKxBy0LBIOYhD7XCtXTKvDkbVKPUx
    Os9ugHRt4u+xI1H3KQDrSPWfI9srSq70eVm20us6U8L2kYEMNj3AR9+TfSKCYW8Pu81hN5
    rMXSMnSVi6EwodNFKLI/x6W1JqqchNGOTZsrG+WVpLBcfDsdqeqRVmyKSF5kMu/rFnIBfz
    cOBD9Z0oRN091CWIEVfQuEbsC2MXQEfbO6223i84YTf2gfv/AQN7pj9CzIWAyfdmaZZ53e
    NKgEj8EXpukf0wJZ4AekttZmJl8/R23lr+9w8N4PAWBsnHYK5kk0TUaGIgmZFYx9o37Fm6
    SyoB5vEhs3i3vS6xkyHfq8xyCkRKoFfnsPSdBBQB8YxVhZbuLlZ2fZq4njhFBKgR3CDp+m
    oT4E3IULw2h+H9x/TjoZ7JFs0rNXm9UGuP+tMqEvFq1hB5qlsEM0YakHqJVj1Px0CYTRia
    rp4rjPTz7w8gPtfr9MvsHebN8MhVJZOxv34wcZYInGH8T1ZO4glVbf+mJnAjKUN3HRMO90
    Rl3dO2jmJE4hGV7MzsXlYHcdwJY/a/uPvru35W5Y7eM8kPAn97brmJWkyVzJNdFPZHNBSv
    st1rjnOAD0Y4YtX0EpG7m6869kAKNrFSEUsv/+pt386x4q4ztJ5leiS+cX5Q
X-ME-Proxy: <xmx:UKIsaphWfgAKDGIbzR0cXJfu72AK8OFhRYlJm9yZr5rgKXkQFKLQFg>
    <xmx:UKIsao6Ks9GC7VXW1UCWz3qqeY3MACrqlJItLU6qjzcED5lcvpcifg>
    <xmx:UKIsajTeO0j19rjSpCGm7eCYmm5PyeoU1p0BcaeFdbjNRag_03Vy3w>
    <xmx:UKIsav-RD0u5nZwO7VZIRgbxS9i1VREXERILCODcz1CL21eY6I0pgQ>
    <xmx:UKIsasrBGOgNML_HeoIg3Pkx-EmIotij5pk7Syvb6H3Dxzntv-5iMU6O>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 20:20:31 -0400 (EDT)
Date: Fri, 12 Jun 2026 17:20:31 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 kas@kernel.org, 
 djbw@kernel.org, 
 rick.p.edgecombe@intel.com, 
 x86@kernel.org, 
 peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 sohil.mehta@intel.com, 
 yilun.xu@intel.com, 
 yilun.xu@linux.intel.com, 
 baolu.lu@linux.intel.com, 
 zhenzhong.duan@intel.com, 
 xiaoyao.li@intel.com
Message-ID: <6a2ca24f16277_9b85510070@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-13-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-13-yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Provide an in-kernel path for TDX Quote generation when handling
> TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.
> 
> Use the core TDX API when the TDX Quoting extension is available. For
> simplicity, each KVM guest checks for availability only once during
> initialization. KVM does not handle Quoting service disruptions.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
[..]
> +static u64 __get_quote_kernel(struct kvm_vcpu *vcpu, struct tdx_quote_req *req,
> +			      size_t req_len, gpa_t req_gpa, size_t total_len)
> +{
> +	struct tdx_td *td = &to_kvm_tdx(vcpu->kvm)->td;
> +
> +	/* Only support version 1 as defined in the GHCI spec */
> +	if (req->version != 1)
> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	if ((size_t)req->in_len + TDX_QUOTE_REQ_HDR_SIZE > req_len)
> +		return TDX_QUOTE_STATUS_ERROR;
> +
> +	/* The caller frees the quote data */

No, it is freed by cleanup as far as I can see

> +	void *quote_data __free(kvfree) =

...this shadows the global "quote_data". A global really should be
properly namespaced.
