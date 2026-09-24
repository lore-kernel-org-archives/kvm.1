Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7D25CC74;
	Thu, 24 Sep 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248781; cv=none; b=qfLtgpGNUQWvqiyj7Te7YRslzojbBoRihBhpMQ6Etw0nwPjTB2sMPdZwnja/zXKk7XFCtHaC9xQv3xPrgLyfnNHOR+nmmfAPIiGN+RMluROHFTuUg+SSGOM4Z+xykw1LO2WEbdUqr0/6whHuet/IXPHJapt79vDT6yxV0qaWldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248781; c=relaxed/simple;
	bh=swLMIF1I4I/8QkaApjSu43b7I5po0N8bkRnCO5zEVnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icGO7Ge4fxtjya0ZoTdfxssqr9BZNTXZL72Ko/H9za1Xye86SDKlcNkDeyehSGMD2oyhXbhsJP4Ellp6kMenUcI8UtmEIqfKC9gw8hnc8um2tw32AEpTFb86GeoYAxM5FJMBm1twS3AbMh0Uan/FnZKPDKyX17g46unlPw7hgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPPeH6Fk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPPeH6Fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE4C1F000FF;
	Thu, 24 Sep 2026 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248780;
	bh=l3S2c3QBqulgceaatbXl52x8C2PWlioAFLh7ONORQqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gPPeH6FkQWUy3PN+iNxRRWPAjw9wnPzau6GHPIQC8obOMC6Gtme0wgcwFgYs+QCSX
	 d2eFEQEizs1Lw6uo7OM8a3I3lXfmrHim27PfwGWb5q2n0XmadvGpE91gLo+kMwAuUC
	 CGZ9G1ulIl3/t2+7G0EYyxc4VWqWHa8Xstc9OlzPltVAn5K03dG6dXX6LQwQWGN09Z
	 /pR/z/JYX2I65gMU9+Wt9j03VRyb/zGcsQn/EgV5p1NRbGuD9jPe0STyvt4SleeoE5
	 /XtL51Zrie6XKQxIpkVOWumsVMQJ/hwK4Xp0B5dxlNPdrhti+b2Rp5ghceZnbK2Nzp
	 Jq4xcsHtZhDGQ==
Date: Thu, 24 Sep 2026 16:46:45 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@meta.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Use "is AVIC-addressable" helper to
 sanity check load()/put()
Message-ID: <arUGiiweeeN4exvs@blrnaveerao1>
References: <20260923155108.1550622-1-seanjc@google.com>
 <20260923155108.1550622-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923155108.1550622-3-seanjc@google.com>

On Wed, Sep 23, 2026 at 08:51:07AM -0700, Sean Christopherson wrote:
> Use avic_is_addressable_vcpu() instead of open coding a check on the bounds
> of the allocated table for the sanity checks when loading/putting AVIC
> state for a vCPU.  If KVM botches the allocation, then KVM will already
> have performed an OOB write in avic_init_backing_page(), i.e. being super
> paranoid in load()/put() doesn't provide meaningful protection in practice.
> 
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

