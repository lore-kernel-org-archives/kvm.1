Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F2233936;
	Sat, 30 May 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101387; cv=none; b=Gvk/EFYPelv98PRUyUDppu8N7kvwEXs/IRyzJHXFt3Lw6YZNRU6la1xQlFt1V73kfzRiIjPFBMWSoPuMSz1DlPPe2sAc8W20cMhLffbAPVOvsamjrKwVoTtSiS8ckXH5ZWGb/JHP59Ab/QKU4cyRNe8ONnl96VL9HMxkpV+IE3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101387; c=relaxed/simple;
	bh=EQs0hpm29b04hS3i3M78VfeByhjWQkMtmGVmS7uYFHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJhMlzoZDAV6kH7taJOBdJK5HYi5K1KSgGhJRH9UTyeozMhQFSruJ1kQRGbJv1V6tSOjDXC87TfyWYPmz/wJcHB5Uh2gyTBSLfwXnT0fpOYC2qaus311ZDrQvMbfgnm9u9Zk4wv0iUPkFUFED+0A0spbuJEwBWMDuQkjcjCHLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVoeg9/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVoeg9/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC021F00893;
	Sat, 30 May 2026 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101386;
	bh=EQs0hpm29b04hS3i3M78VfeByhjWQkMtmGVmS7uYFHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VVoeg9/eBoQ5swBnh4BscY2A+kbINw4cJ4KURdrrBG7DcMFdLkAI0CRVcdOoB4tJt
	 HcBwGLrLj4Bmr8+00d0GN/iM33Tkem22tlV/9ojppTjFda/K6A+sjnHOj2EBpnxCX/
	 ykxi3D6VPNC3QzVLmZ5uG1ATTkXS5jTUxcTir6qoBcqfYGTCtXZnaYQfKkFpQn7IMA
	 Vix5XnqTNGUnmsegdQOxfqRA+9Y+IONimz9Grxplnt9Pf6KB2KIMlfWVfeYgHIojdI
	 EVP6Q1Ea6/II6JEbesYDIXfCTW5LKlh8Qb7HYXBPzlZ6oNPAYSXUHfRVSh3RTNP6Nf
	 /BSjydUeV9uvQ==
Date: Sat, 30 May 2026 00:36:24 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 14/40] KVM: x86: Move async #PF helpers to x86.h (as
 inlines)
Message-ID: <ahow9ka9VEwQbKOV@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-15-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-15-seanjc@google.com>

On Fri, May 29, 2026 at 03:21:57PM -0700, Sean Christopherson wrote:
> Move kvm_pv_async_pf_enabled() and kvm_async_pf_hash_reset() to x86.h in
> anticipation of extracting the majority of register and MSR specific code
> out of x86.c.

Not sure how these things are relevant?
