Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6B3E123C;
	Fri, 10 Apr 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840029; cv=none; b=sHnuuFxbYQ8A7DXihj9t3UuWCRuKm2+aOt3DK21RXdRkn0yBhagszyRCACKPdGwSpkWzXVsZUSXtp9jq7TI5+P6XDWUbKc7ZS60mmxTQ4cYsHDMzdVKJshCccIkdzQC4oY9VA+BPAkMR38kaRR/UJagYxaut9DqpiC9ciCb7pQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840029; c=relaxed/simple;
	bh=qI8p01uJ1OsjyOblF8gv6JYuAMH7bq+PTnjJKXk4zAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl41fc0+9UIJB4eJk929r2KBNYgxqnLdfHXTouVlQqHT95kle7YVYlH4WAdlTpQdVZNd5Z5VW6mRULrIZsDNr/hrkdLM4u3W19O84jiJ1K9u0ZsROqdTWcbsU/5iNjNH2yKu+mSmOf/oOknqyF7U3cKzqXi/QtLHBoVC5PTbANo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuSdLS/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuSdLS/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE06FC19424;
	Fri, 10 Apr 2026 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775840027;
	bh=qI8p01uJ1OsjyOblF8gv6JYuAMH7bq+PTnjJKXk4zAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fuSdLS/ZLxryBwtveQ+Bwi+agDetOs8NyuKIr/hrC8EI3UJ1T0UcOqT5xwEbIV3jQ
	 D7zo21A2HlEA6byACTPKfru1+xIWez8Xhl9byhRtRnizz2baPpl8rzYuTcWGsX06wT
	 vFNrfCkTMv62jAqPHk1nX781ZgfR4FfjjPmEyYyd+9jj1iwv0gHFznq8Y5mj7E32wf
	 XKVgx0p/CFuH1ztldA7B0ebnvsnKm+EM8LZE3iTjD2fi/Q3mQ3TaNPCfV4SLg8NwHA
	 fUF02yYX2bNR1LQ2XHxoxmx0QQwDPRYoZnuw6CLY7uZE7pCb2RxGQolawrgdPerxW8
	 StEJ40q0UbzFw==
Date: Fri, 10 Apr 2026 22:23:28 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: SVM: Only disable x2AVIC WRMSR interception for
 MSRs that are accelerated
Message-ID: <adkqDG_2UouUjDFD@blrnaveerao1>
References: <20260409222449.2013847-1-seanjc@google.com>
 <20260409222449.2013847-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409222449.2013847-4-seanjc@google.com>

On Thu, Apr 09, 2026 at 03:24:49PM -0700, Sean Christopherson wrote:
> When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
> actually accelerated by hardware.  Disabling interception for MSRs that
> aren't accelerated is functionally "fine", but very suboptimal as many
> accesses generate AVIC_UNACCELERATED_ACCESS fault #VMEXITs, which requires
> KVM to decode the instruction to figure out what the guest was trying to
> access.

Not sure I follow: as far as I can see, most writes are actually trapped 
except for MSRs that are supposed to be RO?

- Naveen

