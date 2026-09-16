Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929D393DEF
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561586; cv=none; b=mOSnvOx+LthNTiLVFlHti12IfUoFoNtWMjCwW2IVYFlfJra9gQQwQZVx+/Xz07WlOgdlYeMITp04Uq1inOvSc0KCU8ilQuUASQzhSMdxwJRWLRQpJjkN8neb29IPQ108vdV3aZZJdRpVMV8kHIFPyWutDog7ctynqkCP2Af6C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561586; c=relaxed/simple;
	bh=QorOvZXFzOZ1+Fc2s37tYdEoKdEVm+Y0KI67NCN+qxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxKZe+BnT+0NXOcQbkDMQajQFWSWNMDUDbXnx3knGvmf+uRsR3O8j2DpN/MABFkyabhpXycmLRnACL9CTMCf0vEPRJnCFis7fM7OWvDs48dZkF+FfOL8NbvD244b7IJma5b8D8Ru/mP4fSKyOlDZIhfqWpRZC/SluB4c60EARH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMxs6sSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMxs6sSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF31B1F00893;
	Wed, 16 Sep 2026 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561585;
	bh=mCAlnM8+XNCHui6pLotQaszdYPa3f9MPj3y0wzrxLV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BMxs6sSxLR54XRbNNLXtJVJh3VVsMmmGUE30rptJkm6RWkRm0JcMzwBPLlUZgMvM0
	 Zpa/X3ywC7hxryY/PoEzINAt3vg4WEASjAvkWPeV+D7kJd+jIDKEtYLwr4Id4l6bgX
	 6l7fkB1gU6Tagt89Z8k0BKkQr8UsAvuH1bUafRbbCv5FmoFguo2EBXCD1UNqRm7zLe
	 oXwMYrlNgETtJu/3xScBULu+WB54Fq0XQ4FKS3Ic9jwrYrHyhOJdJhfPdAdr4i1vM0
	 hlMse7xfwVAAxorU+ESPpc/xun8gmpo/MYj+8ny6wE5StQDBVHgiHlQQOo/V858Wuv
	 FKSIL4tqeAy6g==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id CBFB61980047;
	Wed, 16 Sep 2026 08:26:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 08:26:23 -0400
X-ME-Sender: <xms:7IqqakT3ipcrSlT7rUaCb5CZV0_MqXF-OXTwRHabqS7-ckbLqGi59Q>
    <xme:7IqqahAB_6noWt20hu7e-vnHheEVJJSSPF_JYNGwiarNVzxLMLQIX7WabSSzTUgLy
    6J1BKGrXC3RM6Fwo6QP_ZvTH3xIc6OI1jlK8UZkQhlJDYo5rU891h1C>
X-ME-Received: <xmr:7IqqauBoqJXxxUrK48jhod8CfDs48_XeLyMsoEke6Lqb2oOY9moubQs_vik>
X-ME-Proxy-Cause: dmFkZTFq6odZDDV1MbWatV/ogB8xNp9I0LZXqD9XYhLxfYbKOKS8UmtQu9jik/YJw5+uDe
    IQ6yOJ08HjDRPvYi9QFt1jq0pHGSfYW6nwxE+Sm7yr9nKcBmi5RUalxcvapJTiUZkcarzc
    Altx5IaL1NPrtSorlwPUW9SMwDvZR/9hNrEX1CWPEvmZJDDv27xZOM6Inb5XPJLhAbLlhk
    CcFHRQ1NHECVdbI0qiw3RFSyKV9nCbqC0DillmW/DW7U11KmKmJu9FpAeasYtIEcLsZ/VX
    fguKYmbKr3ea2GVW7GZmUiPj4seG2XhlkZtj5DvqTtNjjQkLAf9OUw31q4uYXd9/ZONdaw
    rh5IB0eMMfxuIJ5GU4VW5RxZiZFlCBX+GHbuSdIT2WoSko/DhXvqeqgvbVeFLK5dKl3CoG
    y946NaAYL3rRj8BN2g/qTaCLFBK/X60Es/NEcaKfNfl1z2lT+adp7hkQueGj5yWmVjRS3k
    o3BYRt/JZ0FZVsXQNe0zhkOnfGiwUI7joQpzKhdQs14AGWSyztUTp68Y1y20/saGhrSReD
    k5jecQAE2xOksfoczQ/Xqnda+qpX0gc2KgaBhXb2uvr9uPGnkeb6Pom2Fe9OPWYwEl/eJq
    xSkVCr9T59sRkxyX5K65Xc6oARvkSI1MRqM6OPa+UvQo79V25OKEnk0R1eMg
X-ME-Proxy: <xmx:7IqqaiwgX5F-JUx8dPM4mFdA4S3CpqUsMQiip8lYcW3Yjd3wH3JhaQ>
    <xmx:7IqqagjnPCozhtqxSxzD9CNCpBVGzUVvOlE3cnseU7vq_-ultxe3Cw>
    <xmx:7IqqakatHr0Mc_uF8KlVmejsk4VKD0XeqBJ6XII0o_SlVbNRlD_eyg>
    <xmx:7Iqqahex9bKK0aifqNX-tFl2BLZDc-eBvSCxBKxHAvXc7h2QCdTI2Q>
    <xmx:7IqqapBYVpay56NXrp-1pjT6pKl1emfHvI2cKmd8bTtQKTS4uAKJezvW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 08:26:19 -0400 (EDT)
Date: Wed, 16 Sep 2026 13:26:18 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Tony Lindgren <tony.lindgren@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Artem Bityutskiy <artem.bityutskiy@intel.com>
Subject: Re: [PATCH v4 2/4] virt: tdx-guest: Calculate the Quote buffer size
 safely
Message-ID: <aqqKp6Vr-60UEGl5@thinkstation>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-3-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915092632.2822169-3-peter.fang@intel.com>

On Tue, Sep 15, 2026 at 02:26:01AM -0700, Peter Fang wrote:
> struct tdx_quote_buf has a trailing flexible array member.
> struct_size_t() calculates the size of this kind of struct safely. It
> handles overflow, which helps since the Quote size comes from the host.
> 
> Use it to rewrite the bounds check logic, since
> 
>   "header_size + data_len > buf_size"
> 
> ...is more readable than "data_len > buf_size - header_size".
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
