Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EB364EA6;
	Fri, 12 Jun 2026 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302846; cv=none; b=jFqHD9/WAO8PlruN1PqrR3z2iVEajXdY8xW2shG6YBCaCODq+Z2M6x7Io01vmt0g3s75xyWe1NO3aKJI8yIzfospRFDAJ+XQr00m4uVoZEcHwPktJl+83ut2JpdEbE6sCwZPtRMStmPuAz4AL+JmLXXLlBrO6ihgookekr61t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302846; c=relaxed/simple;
	bh=7x6kSlZQGfAFexoU1OlfqwUGK1nj6IJaeGi5o9AQz+A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YW46Z4StXvTs8SLyHOQbbrQQJnfBigyIOl+8NlmUaIs3uAB1DUJjEirc2VAEL0eFIK1SYZ0ULeuQuvEiJspe6gEQp02KWvWzf7d+27DukDWlGqQYYMwVown5rbJrE6PjwQ2SnfKih5eUmsqC7kGrwsc0rgx0jvXN4VEhFX273+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOagGIp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOagGIp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925FD1F00A3D;
	Fri, 12 Jun 2026 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302845;
	bh=ztDC5Nfbx5tCMLN+HeyysCV+hhwsD1YPStFDbx5Qn9o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=gOagGIp+lImXnIIOxb3IWUjuUyUuUiuZQ5dE32Jgcr3kjjZcFxQQKNF1xeW0DUk7e
	 h1pPoHlCybVZfkr7IRgzIH/fwMOglK4Imqq97LfoULNmYHDW1OKhUG1bk4QreAXe2l
	 JNZrDtb7oxfsr99cXtRKNkKg7zM7CQrUCb9g7k/kR7T5KPfd1AIxA4F/2ZFizZTQPm
	 9SAwQIQh7GvOflzmH3QIMndudSemOEMYO3zyCPMyHLoGF+lt8QaZUxamlhZTpy7zT/
	 thkR1bbQMQQgMMIzj/pAvmc1fU+QmQpp4TUqbJYc+nN65ydPXin2zmagTJrejgvJyF
	 oHAhCG+n40/7g==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id D103DF40078;
	Fri, 12 Jun 2026 18:20:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 12 Jun 2026 18:20:43 -0400
X-ME-Sender: <xms:O4YsahByAQSxfEZTv08ppVtRQ62CQG9abG2xp7wWzrRBGASm-9iXYg>
    <xme:O4YsalFQi7vCfJcIQ2tLAVW5i3RpZuoqx121lC7h3jToqSB0zjspahSH9zP_nkbyD
    15BEcBZk0ppGjwGTJniKjoHSDeC57ToZdoxZr7cbrzmaNCYeAYVwAI>
X-ME-Received: <xmr:O4YsamKAd2Fszrrn4ZYsP74S8Fhqdzgg2A4PU1pqPwfsHpG301aIsGquah3Cy3xKBRC0zrV8r-BC7HGjcY4VYUB6gXMx3mHxke4>
X-ME-Proxy-Cause: dmFkZTEbdDP9kN0QKLI+4aVGbax1rKXXCXkeRhON2/Q5LyeTbOtXJpWxagbHzvln3jQlmg
    9twoXvMB4tZaY+WaCAd4CTq6eKXTDk2UO4qRyP1fZQV7ySx9YcIh1wNt0aMLyWfHxdXCiu
    A3ZPO2xo+y+kdJswyU8YJZBV9phhSH408vK2EKBETe5koI75a7x6i6S9iYUi5nd9gWdMMT
    YNrMVF0kD0qEIm+YrwSMHcWGg4d6MK59yVgQLy16e2OhvgGnSTQvwKTuocB66hIN2Uw9rz
    e5o/VbjdxA/qYHjHovFUCHButvCGp7NCUzcM7z78P8LS9fsJ8RozhCLhVuF0AoXeBzg/Z+
    GRSVMxcGYs2hw3odWzG6ybe80jMECud2kRy+pyveKByGngtr6pVWQdQtwyl7fTTszvl8Pd
    dDep5w53V8w52SXTRRD/T7HSr1G5npCUHJbKxYvhrhMa5MpCI3Ejlp/OGJDlsn7kDLkz6n
    SjIiA0zPfmFEI0iy8R3vyQBoFOtZn1WBdDHcNnb5rS8tJLPyrzx7mFTljg3aQX3msxFvaq
    HvtD1UVc6hxm684X9tPXgnNNgqrf7W1RgT34QhVsxAmYFgfYq5oaBkjLhHZkn2S6bLfwcG
    ko34xtnG9Lj8sHkJr5IqLfUNvMvqgsOIj5zfjIKdfepWexHm4uO3fPmePYUw
X-ME-Proxy: <xmx:O4YsasrzFxNj9Jp_kUWspUTjC9SAZt74mBH_Abh64Dr2eik_et-UKw>
    <xmx:O4YsathkbgaT7cwc5ATrcvWr9tqS4pa6jsTXNtLU_xkajXTJ96ydwQ>
    <xmx:O4YsarZLIQSsOIB2PmntRjfcWdjxc_Bb1E8Afqf4IZapmDZZ8pkSwg>
    <xmx:O4Ysaln--RsGUQZswSKC2ntyeRrDSKDq95fKDinqnHKXFlWGI49CpA>
    <xmx:O4YsahzAOWhG3_wPZkhnZyjcCQwH94RtrDbELt9ddigmorWExqwSFMUf>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 18:20:43 -0400 (EDT)
Date: Fri, 12 Jun 2026 15:20:42 -0700
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
Message-ID: <6a2c863a681d6_9b85510064@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-2-yilun.xu@linux.intel.com>
Subject: Re: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module
 Extensions
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
> Add reading of the global metadata for TDX Module Extensions.
> 
> TDX Module Extensions is an add-on feature enumerated by TDX_FEATURES0.
> But for the Module's integrity, Linux requires that all features that a
> Module advertises must have a complete, valid set of metadata, and the
> validation must succeed at core TDX initialization time.
> 
> Check TDX_FEATURES0 before reading these metadata. If a feature is
> advertised, a failure in reading associated metadata causes the entire
> TDX initialization to fail, otherwise skip.

Others already commented on the patch ordering, so I will just comment
on the changelog to recommend referring back to the "any available
extension, all the time" implementation policy rather than saying "Linux
requires" which is ambiguous.

The patch reordering will make it more clear that
memory_pool_required_pages scales based on the number of features that
Linux grows enabling for at configuration time.
