Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA22E738B;
	Sat, 30 May 2026 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102658; cv=none; b=W9hky6IDsIL/7EBuoOB55/V4AlZjJPNYW0Cd9HGcuiVXOQbOaC8lwjXcxx8lQqA1nZhDb10ez7sPKPJ84ZdAs0XKPhcdj6iDuG1Qcg6+ufNt11e9nOEz6rHGhwhXFgLXWecj8nI6oTO89j/RqpMajHQjt6KANh+FoH9mnxmkMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102658; c=relaxed/simple;
	bh=w3P0jS19/Ep6ftNj2azVlimxFKR50MUWq8hhMiYzRD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smnsbT4rW2+zJDlc/cCxZs48S7XOtXUojeO1w7KT1wTVtbGXKvNtnHt5YOQPmNtaE9gajzcwKTjklzMjDRTzmbVvHeQdaY53moQSxdZWQLCU5kLfKJys9tJBTZds1jIFuQAJBAfkVUuA9aD2p19ltCQjeIuX2cDfq9MgxiesmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KciVvldq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KciVvldq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049CE1F00893;
	Sat, 30 May 2026 00:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102657;
	bh=Yc/rr2QLLem20eMUqap/ijcjOW5Y4p3L99U9b3qL+ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KciVvldqo0KmasLYDCG2eoeH9L+S0Fl+4o3K/F+Q1zTbNGcY2+hYOwTx5x8mDS2Vy
	 w7LsqRS8yZZmdfu/gtg15us4J7vPbXSFOLVKKwrQfbFiw8ejzw3IzNgiq//7W6zHbV
	 /RSyt8XVhb5joX1WVGbq8R25xvOvXw+5GbuK1+OeioZegEF+8alUFuGq6Mt5brNlsr
	 p4omA+TwqsWqn/nE+qDT02Hn6WcqneK++rnv6o226YnPA48gXus+8d5J2yF7yIJivl
	 gYhx7Jx+RqVBF/oDaDabeLuWxunozBu44khFd/ZOu5N5YxwZ65sGBEpLbUK624+/pX
	 KK/eGbVBevpSQ==
Date: Sat, 30 May 2026 00:57:35 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 29/40] KVM: x86: Remove defunct
 kvm_load_segment_descriptor() declaration.
Message-ID: <aho1-sU5pWQmoRYM@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-30-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-30-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:12PM -0700, Sean Christopherson wrote:
> Remove a dead kvm_load_segment_descriptor() declaration, no functional
> change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
