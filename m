Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E952E9730;
	Thu, 19 Mar 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929060; cv=none; b=Ofd7A7VRmP5XOGoVlNBu4hv9G5WxUlQtQRBYjg86LZ4aEQE9i4x37Y2Ikuj7+Om9ugPHDfaRjjTfeQd3T09n7IHGzjl3dL1ffzSLXqkm3cCRLevwZQksEGLiVxURl/5xv4zwa8qJwmM8yMh03AavNrQ5igQjuWsvXKlcDGhvE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929060; c=relaxed/simple;
	bh=9idan2UExXxNXmfQkQwCAh8m7SsTCNHfkJZp1pluT7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPxuZitNvvGkfs/6MASQBCTHW7zx1q7PvE4VpISlUXI9e6K7KgHEqewD9RMel9f8h8SdR2rIYe713Q7Oc54RJ8/8LKusL67bxmui2wRRkaWtjRyDj93ZVbCEtcD3pC4XYJkrIJSYt6mS/fnYUaSbpeR4SyrDxAHik3NT5NkgRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOhkXtkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOhkXtkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF4FC4AF09;
	Thu, 19 Mar 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773929059;
	bh=9idan2UExXxNXmfQkQwCAh8m7SsTCNHfkJZp1pluT7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOhkXtkRiCOqFirwVQUGKGyDzcxR47XbA3ZlqHzuSX2QbG32kH7thL5QRjDbCbQGR
	 Dx5dsc55qu+acPf8fZOLJAjaQyjwg34xfGxUEGFKBxPS+n0O/oVl0WNigRXVbShic9
	 O9ZOfRl+JWq3R39bMGqn4wFTxO9cPw6nn8IUK8YU5GJhwIYeVE2t2dsKFTOYCMuvVO
	 ceUfiqvvzpn+zXvvH/BTPvw+NitE9AL098KfOzp+hgCBsdUWeMcs/KXYafnhOWZ0Y1
	 b1/QRyIpw9WpENRXReREBOSurBXmjDTJbvQVIUiVsYr6CZjAhZGCYsNwNnnBTB+P4E
	 QQClDOWGLAmsg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1B50AF40069;
	Thu, 19 Mar 2026 10:04:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 10:04:17 -0400
X-ME-Sender: <xms:YQK8aZh3vkdUqqD8zauTzQBvtSwSoLjeY_4nQZc3eZLkL4ivF0f42A>
    <xme:YQK8acpvWyxVzZ0BFMIJCqmHCUNvE1bSupJ5OUkfMqiLZgZfaWvEcjM01q0udk7-K
    9XS-lTfXOsmI5hcOZJwHWOB06LfcFKPMyC1p-hth9QyrvyDPxtD4c0>
X-ME-Received: <xmr:YQK8aYukUIiiDfdbnLpaQKXLV2FoAZqx8e1NnQB4ElXKFD4JmmZxv_Z0vbslVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtohgtoheslhhishhtshdrlhhi
    nhhugidruggvvhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhugidrihhnthgvlhdrtghomhdprh
    gtphhtthhopegurghnrdhjrdifihhllhhirghmshesihhnthgvlhdrtghomhdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:YQK8aUdS2Dj2ifSYybPXZ_FaabKdz4oAkk5KsYKi0Ouw9iTmTbHxWg>
    <xmx:YQK8acBpISnxEQWbJAePF2w7vhHmJKt8_YstRzb03a28L7Xuwd09Jg>
    <xmx:YQK8aXmcrqr59ya1YA24-qvgfxGgsRWQ05DWUcAYn5CW3zZn_rsS0A>
    <xmx:YQK8aShsGq3J5UMyb5DZqQkJHwb8nQCs17E_PgBhlkq_N2K8l6ot5g>
    <xmx:YQK8af0M-jj5Fbr-hXJcyowqXILQDfyWQgOPEVpXZoQsN7BpmmOBzgq1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:04:15 -0400 (EDT)
Date: Thu, 19 Mar 2026 14:04:08 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com
Subject: Re: [PATCH v5 20/22] coco/tdx-host: Document TDX module update
 compatibility criteria
Message-ID: <abwCRFO5AoH1BoR8@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-21-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315135920.354657-21-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:40AM -0700, Chao Gao wrote:
> The TDX module update protocol facilitates compatible runtime updates.
> 
> Document the compatibility criteria and indicators of various update
> failures, including violations of the compatibility criteria.
> 
> Note that runtime TDX module updates are an "update at your own risk"
> operation; userspace must enforce all of the above compatibility
> criteria.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
