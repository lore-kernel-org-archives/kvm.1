Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B68BE9;
	Sat, 13 Jun 2026 00:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309332; cv=none; b=olGVDzs6ueESKdRB1hYZapLWcNFXxlCHTElPuW6gOxeGp5+VfkJOjNwVsI5Ygmhwaq3VlGJCAafX7j7cW9rlv8HNn+jehQdR5o1dDV2o6w8KETYhPcgOc6EF210GwYWh0dyTyQip89Ycd5CI0V9We+TrOmQT5OUg6sVHSQWvMSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309332; c=relaxed/simple;
	bh=FGfDSYUzR4CCGquDoYUGvbdgqtpxGy59aE+t6VmydzQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hWsNnlcItLcWqtj3DImgYP9QLXRT/XIEZyFoPOCekjbbeXLSA+UZxaIsIBnJVXcjK5bOLGFB2htVbaHeILxu4Yeem/pcQy1PG4+OTdr+++1C+chsVjpFsXd6A9TTF44L9FVNx29yPhvRJ/YxW06DXw/gmXJCGjePBmePm+D9P8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxYyOi6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxYyOi6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DDD1F00A3D;
	Sat, 13 Jun 2026 00:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781309331;
	bh=nGxa9IMcv53z2azwObO2YlW/PW02VJ6MFszDO1jlzVg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bxYyOi6H/XWA/Y2J/44vOjtGAF7mr9yIQGqqhNEydZvUE9u4kKAF/sbt/+q8JTMzE
	 7x/8hSbfi7oni499ospkve5C/3kWuSaA0VnzJk+YJcbBEkXfHuc6Uqdg7tI97rITth
	 pZUyTGYVU3iwDUDDl3o9qkJMdwjEgblsGFmLwbb+LsOcAVnQzfHMQ9jV+52/jZX2x8
	 IPkG8jAcxB+EIdw5/c/woX8sGZDyBR99nMeTl3zRXvXBIAbcsEvYzT+/TfgmzkwkUW
	 jbK12QWLjlVIu5PXBEenmtnBpeex5l179TyqMHAE30VJ/h+t4QIjq+cBpDKVUo3cML
	 bTBgxd3K1J73g==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6F12CF40068;
	Fri, 12 Jun 2026 20:08:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 20:08:50 -0400
X-ME-Sender: <xms:kp8sas-m1MadYzNzE3GKeoiMZdV_iMnwY7WN2W807kSfARnzcno5Aw>
    <xme:kp8saqRf8LKFJTelwbeuoV4cGT4wXHldUaUH0pSOI6GmBc6qWISfQuLqlxp_3n4K8
    99rs6EuyH2_1pdH3CKLSG9o93pMOvrB8kKC6nVh0iQMvp9VqxvHQJgO>
X-ME-Received: <xmr:kp8sarmYx51mvAAm0oNLuyy2le9TzUBmK1zgPNpfaNUknmgMGr1D0iijO2oWT9JTIkGMpub54h4qWDBJj_L1wmnLVp4wqpIBncM>
X-ME-Proxy-Cause: dmFkZTECaqWc+bBCQTP33LZCVcgpDog5woX4Pk0w+tN7k5C+anpxEi+11sOcToFp2YNhFQ
    XXkOLiPpOtcuAt4BLAJvhlb7O8nxZgdFWzhdtvXjhffwAwacbY3zEbPPvwbumpAUPAXWEp
    Bgx4CamE/ooy9Rmp4n+szWTIeEluvgAHuE6mZuG6nDvB/dq+sGK1+KOb0YPrrcX4etzoM+
    +yT1xXSfn4eeQcVYqtsfFhqJYvzY3citFLQahF05zyv5SAjzoM5MjNRKy10Mg5qTaHSyhY
    8r7x73EwCEReh81vhTNa8Fa+wkxrHfA2h/jnBVT4BIn0M6gOMHeKu7A4dH+8HtfbI3FRsb
    0gC/ywipQLbX4MDqxESNJlQK+K9po3Od5p68lT4Ij01H2wvcaei9NEiImuGkhU5Tal/XLP
    ikUsRTZyY5FVFhEAkc/8dziVLZdtOKQjOK0axXbWT2ETRtzHpPWQYNGhk2lUedQeb0NFvS
    x9CNornK2PKwLHbeSiyN3nbNb3tUqt+RdAka3rapqv90vtVcuRLInHWKoClF9WglfjN02R
    KYkVur8cw2Q5QVgKjU/oygOXvy36wu13mNk/aYeXCFrjsI4zumNphrYvgUFLxpWUqPBZMU
    IMzvcZpVm8LRKBt+mhI5y4UQVyg2Do3bgpCREoh9JEcdkpk2wav3kt8TLUKw
X-ME-Proxy: <xmx:kp8satV6RJn4UUYUx3wYePDlQV8snuogAWSta9882ttLqcOQcO2Jsg>
    <xmx:kp8saofG2zDXntFvensLmhV9Bt29j2buk9lnb9ENt-4q-xciuZAO5g>
    <xmx:kp8sajkdyylhXrju-6QIgs8f5Dnzyw2AE14HafsmDQoMjWiWqGqCMQ>
    <xmx:kp8saiDlR3aE0buPQbXmapb9-xLOZrHwiy4y3RWwu7QcpGLjx4iWyA>
    <xmx:kp8satfMLyqNZj6_XFOMNauI5LKtT3OX2EdTzSY-TmDo60JQ-MDdtOgK>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 20:08:49 -0400 (EDT)
Date: Fri, 12 Jun 2026 17:08:48 -0700
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
Message-ID: <6a2c9f90d348_9b8551003e@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-5-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-5-yilun.xu@linux.intel.com>
Subject: Re: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after
 basic TDX Module init
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
> The detailed initialization flow for TDX Module Extensions has been
> fully implemented. Enable the flow after basic TDX Module
> initialization.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.

No real point in rehashing the rationale for the "any available, all the
time" policy yet again especially when this directly conflicts with the
"relatively large amount" comment in the original cover letter.

Otherwise I agree with the proposed reordering of this initial series.

In general though, no big showstoppers for me in this first 4.
