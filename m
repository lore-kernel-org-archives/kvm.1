Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA83A9D94;
	Thu, 24 Sep 2026 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248767; cv=none; b=LDMZbZssga/Q4jXzvi64WBnCiDFO0I81jGJWeLdG4/AJRxWtZWhIRELiGis5mwDaQ1XHub/ejz1l6NGdKljm4OnplwTDo6x/oq9iiMXZXroQXCYJfWzZPPu5E3d1dgx9e8mskkDmlXQcilZTE2SnGDg9Yp1xjYA3TUMpZECNF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248767; c=relaxed/simple;
	bh=MnwdhcHKXLY94wY+1bbVKuGxrYS0AS2RPC15TSllF9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4AL9ra2py2vH8YWCd91TP2rIQ/Ks6RwjiTDloAu7I0gj8vldEo4+pmuZl3FkFntwRoC1Z6qTFb439IXNHMqg8ffqAO+xdpzgOPEbnNmH7F+n4X4ipz2kwA0uRRGiU+u3X8jJU72AnjwejbkNsbezx9Z7qBU0LEz8iCUvbwnWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxOnSnvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxOnSnvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F320E1F000FF;
	Thu, 24 Sep 2026 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248765;
	bh=zg5lEtC7IKPEkqS3hTsVeEcT77zPemGTUXAh+3v/7IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WxOnSnvq//uGyGVNgNkUKG3nMPBCz0AK4PTuWmXalkV9E/bYNsE6OPvuuZ5fVZ+or
	 7d3miO40lPDxZWL7SX6C4AgVEjWoRTIXUy3ySWhfSXzGkVhueISnMo800sxhBVezC6
	 b6MZSnHSxaYCJn2fOrzUJqbppnprptUHzcvq4Umzfc/J1EoE+O5ZgWZ9/WGEgZ9D3S
	 d1TVzspC3H/3e6vUNYKarOOl3x3l90kNsxeCh6AX68BakZIwJV04NBjHwd72nUAHhd
	 QsALu5k2YUkrwADQZDscuscC9j8QUW5rE2qcGAjxzfi29ao5JTyP9GrmDxZf1xvV4W
	 lC4eCxjQ5YtIg==
Date: Thu, 24 Sep 2026 16:46:22 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@meta.com>
Subject: Re: [PATCH v2 1/3] KVM: SVM: Add paranoid helper for checking if
 vCPU is AVIC-addressable
Message-ID: <arUGWlBcGnxw-dae@blrnaveerao1>
References: <20260923155108.1550622-1-seanjc@google.com>
 <20260923155108.1550622-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923155108.1550622-2-seanjc@google.com>

On Wed, Sep 23, 2026 at 08:51:06AM -0700, Sean Christopherson wrote:
> Add a helper to check if a vCPU is addressable by AVIC hardware, i.e. has
> an APIC ID that fits in the physical ID table, and use the more paranoid
> helper when determining if a vCPU is compatible with AVIC when initializing
> the vCPU.  KVM is supposed to reject vCPU creation if the vCPU's ID is
> greater than or equal to max_vcpu_ids, i.e. simply checking the
> architectural maximum *should* suffice.  But piecing together why this is
> safe is unnecessarily difficult, and there is no meaningful downside to
> being extra cautious.
> 
> Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)


Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen
