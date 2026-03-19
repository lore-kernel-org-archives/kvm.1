Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF3D4134;
	Thu, 19 Mar 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926107; cv=none; b=Fv221N1OnZdE8vmaV4VRD7XULC5gScMmlOWzEabA0i/JmA1K+SKs/pgJRmr+PviVmdyTJH6XuYqF6N4M9di3Og4kKVs1VpdR2JNVTZudUyG8WMXhNaXNlU/hB93H7UhNH5UKagA4tQb+uCMLDvDKCqmvm2luYSUY8YBDsKz5Vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926107; c=relaxed/simple;
	bh=5if652ifix7m4r6JjLyYoN8p4oc9k9AQF9kES9+XFR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cidBMaNOUfHLkF5EHBG9ZTRd43aXbCJeuZdvXvlU1IpF5Uz+samRJyWrv5YJ7yPM6cRex29xYqy0cepVcpLhHovxWp3oD0MuQ0vM/21V684DKGDzepFpG1F7XMHqDfDQUXoBEgfK6WG5E05tV6SsOoP70iSFgs6b/qj2quK4roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XouKpJly; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XouKpJly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AE2C19424;
	Thu, 19 Mar 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926107;
	bh=5if652ifix7m4r6JjLyYoN8p4oc9k9AQF9kES9+XFR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XouKpJlybgb2gbfvsKBMNz48jiY71rjYPAdlCf/iIG/o3x4077m5y5TDQCKjyKSV/
	 YF/XehWNtd0y5Qvtj67tOZP9o2VLiVFl+W23rIEL8DyQ19n5Q9rJdqw/PImf0eBJ7j
	 9qE2fRbJl35rOQGTP3c3rnGYlMrIsTBw+aVC04sDeo6eXSTKRCtttAnGtfWZYG6TPl
	 dHrDTRKzGObGDbIW0DVfV1aOTt/6x7z3vfmfr5x3J97mxqWR3dTWJQFLcuFamO0J6u
	 lR0HsKtj4oB+WuDhDnZumI0Y6oRk/4CFHvsw0MN/5W9w2KtVTwo8FRqPjEc259tDQ8
	 8okOe1MqWqyoA==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 533C7F4006E;
	Thu, 19 Mar 2026 09:15:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Mar 2026 09:15:05 -0400
X-ME-Sender: <xms:2fa7aQA-chx6RUCCqQkdPPYpElEWWRla5DDu8MKs9NuY3b2-JzU7tw>
    <xme:2fa7aTNyoM0E2RvXHeEah9QfjJJjuLWAJjRf9UxcM78N9vK4omM243RQjl_502F9p
    ceC1MvwTiPDLxvdpXekfZLkU17ZAP8qmUMMshX6ikf6OSEm0Tft-XkC>
X-ME-Received: <xmr:2fa7aerY5WMjGVKCFa8uBlouzicluByyZ7xpo1tmudfZ3_StWdVipl8kz8uoLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheptghhrghordhgrghosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqtghotghosehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepkhhvmhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsihhnsghinhdrfihusehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhdrjhdrfihilhhlihgrmhhsse
    hinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhgrihdrhhhurghnghesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:2fa7aWxpSFCPc1VeySjcvd1EynLLdptXynQkfxZa_iDBx9SsGLmHKQ>
    <xmx:2fa7aYN0bie4tBPAaYUGtZuknA0_E-Ol4f_jMdX4Td2DM8cSM2eLZw>
    <xmx:2fa7aSBZvhAxu-U2gfkLwqkBCdIURwMGdRFEjFp-16zEVSHd-gqMew>
    <xmx:2fa7adXWugHh-mAvqFo9EPxJeAKN50WoNI6qpCcFhbv0ZOlcNoG_SA>
    <xmx:2fa7aUIXNQKLiwHE1h_VDD02o4sl8sJOATeEjDdkSLbH8WNuaaNES-fG>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 09:15:04 -0400 (EDT)
Date: Thu, 19 Mar 2026 13:15:02 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 09/22] x86/virt/seamldr: Introduce skeleton for TDX
 module updates
Message-ID: <abv2PWj4jBwm6zKO@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-10-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315135920.354657-10-chao.gao@intel.com>

On Sun, Mar 15, 2026 at 06:58:29AM -0700, Chao Gao wrote:
> TDX module updates require careful synchronization with other TDX
> operations. The requirements are (#1/#2 reflect current behavior that
> must be preserved):
> 
> 1. SEAMCALLs need to be callable from both process and IRQ contexts.
> 2. SEAMCALLs need to be able to run concurrently across CPUs
> 3. During updates, only update-related SEAMCALLs are permitted; all
>    other SEAMCALLs shouldn't be called.
> 4. During updates, all online CPUs must participate in the update work.
> 
> No single lock primitive satisfies all requirements. For instance,
> rwlock_t handles #1/#2 but fails #4: CPUs spinning with IRQs disabled
> cannot be directed to perform update work.
> 
> Use stop_machine() as it is the only well-understood mechanism that can
> meet all requirements.
> 
> And TDX module updates consist of several steps (See Intel® Trust Domain
> Extensions (Intel® TDX) Module Base Architecture Specification, Revision
> 348549-007, Chapter 4.5 "TD-Preserving TDX module Update"). Ordering
> requirements between steps mandate lockstep synchronization across all
> CPUs.
> 
> multi_cpu_stop() is a good example of performing a multi-step task in
> lockstep. But it doesn't synchronize steps within the callback function
> it takes. So, implement one based on its pattern to establish the
> skeleton for TDX module updates. Specifically, add a global state
> machine where each state represents a step in the update flow. The state
> advances only after all CPUs acknowledge completing their work in the
> current state. This acknowledgment mechanism is what ensures lockstep
> execution.
> 
> Potential alternative to stop_machine()
> =======================================
> An alternative approach is to lock all KVM entry points and kick all
> vCPUs. Here, KVM entry points refer to KVM VM/vCPU ioctl entry points,
> implemented in KVM common code (virt/kvm). Adding a locking mechanism
> there would affect all architectures KVM supports. And to lock only TDX
> vCPUs, new logic would be needed to identify TDX vCPUs, which the KVM
> common code currently lacks. This would add significant complexity and
> maintenance overhead to KVM for this TDX-specific use case.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

One question below.

> +static struct {
> +	enum module_update_state state;
> +	int thread_ack;
> +	/*
> +	 * Protect update_data. Raw spinlock as it will be acquired from
> +	 * interrupt-disabled contexts.
> +	 */
> +	raw_spinlock_t lock;
> +} update_data = {
> +	.lock = __RAW_SPIN_LOCK_UNLOCKED(update_data.lock)
> +};

multi_stop_cpu() used atomic_t for thread_ack insead of spinlock.
Any particular reason you took different direction?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
