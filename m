Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8335B125;
	Tue, 21 Apr 2026 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814042; cv=none; b=H99uSjDV34UGbFmAkvSpBKjo7JGd9KEk9RF5PJbPhpVr4zPJQ7WlKnqE+ySTx/V9fxfda0XhDN0akqa0PSReI1DEXzsxkS1Oj8/2HYttOVSU2DHmjRFjauoOzPYg6fZ5oJK9s2fOqHSja5VsdjWJbyGiMgtG41AChzldIq7+H+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814042; c=relaxed/simple;
	bh=HXaB2CZetFuYmHdjbqfor5CVOCnYHfGEr/5x2eSYpm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg12/ROWYsskSslyAnfkwFHGlUhqxqAkywsyzb9VrdqWz36FmWWetL0Fx7gfz3ZWpy0jM0HbVYfxuBNODCIhS/AO2h2G0m9c23Jss/Z74jdzNudrkW5qXggYHaayGy5g6mFcTvTkyurAXUy+vjM/CWkp5y0XvLUDkmX5ZeCu5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlvU84d3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlvU84d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01CDC2BCB0;
	Tue, 21 Apr 2026 23:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776814042;
	bh=HXaB2CZetFuYmHdjbqfor5CVOCnYHfGEr/5x2eSYpm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlvU84d3BMitnfGgJ8rIcMUJPmZgldF68lgcLhGxnI3JAO0kX5Z4PY6El2HV63fKq
	 8I5y3ToyXrW0j6gXtIHxIHg5aXsPVPViMeTlB5qNKjjsqmpKfO/u30hhsxB4h85769
	 ESwsy/WoJklzNoBfGMHs6Bj6SDFWXXd+5hpVomcM35Ln/sF8Hxy4xnX8LzLRl6GEuE
	 6puXDalJTcHJAH0RX2YLcXtKbZ5mo6HksS09zCata771gcVwx/iuq5dV30mDC2WCm8
	 kpgU0la49Jk2xfsEwN5FwYmtFMRkBjr3e83mrQmy5EoPPSAqCsagskDOOyFISa8wJq
	 j8jJWQ0b0seiQ==
Date: Tue, 21 Apr 2026 23:27:20 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] KVM: x86: Trace hypercall register *after*
 truncating values for 32-bit
Message-ID: <aegH03lUF83VpbZP@google.com>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409235622.2052730-6-seanjc@google.com>

On Thu, Apr 09, 2026 at 04:56:16PM -0700, Sean Christopherson wrote:
> When tracing hypercalls, invoke the tracepoint *after* truncating the
> register values for 32-bit guests so as not to record unused garbage (in
> the extremely unlikely scenario that the guest left garbage in a register
> after transitioning from 64-bit mode to 32-bit mode).
> 
> Fixes: 229456fc34b1 ("KVM: convert custom marker based tracing to event traces")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
