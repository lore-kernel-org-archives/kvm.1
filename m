Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAA3976A7
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624358; cv=none; b=qGN75nusoqMhpSMwUa/Y739yqssdx3Va4vpKsGnzGvFw9Ozg7vroI3/R0GoIqfIKEwjvRlPqC35FNCxp9kqAP2JPGaMTK3hX6/znG3utuphvIhePXQs9xP0e9nNnPR8MGBJ0SITc6GNCnAjjhavVhVzPD8BkkHvCWYBChlh5N1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624358; c=relaxed/simple;
	bh=mIRBSkYT/knMMHjLf1iN250p2zinYiYJdGsXK4RAguA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=metiBysy/ZrjCJmfSNKsrqdUYyLrf2eC5bCmiMlPdgiaa5ApiG9CwdxQoRfDXBxdy5f3KXSCvSP8Z8oXX6ZzSKtEIpCRhQXzs1584VUjC1rjNZRVkwr9jSyzyroHDY5bsFJOCgeX4cIw874C8qKqVcMZ2ThlbkDHEFukM0ga/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aVoW0tQc; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aVoW0tQc"
Date: Tue, 21 Jul 2026 10:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784624345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTGegFWNBEQm0YUeGI6qH59Pph3lrL6+2+bz/GFsUb4=;
	b=aVoW0tQcsQfcLNcGR0ONVznjbP11YRKKUWr/a3MyJBajXMrTu/kRfb9YXAXwjHE05257ow
	ElrQB8lygx+eliUHBAbPC0wXzwd9L9LuvyxrRxTTEjvJLAqQVVYdr8k5LTwg9J4mp6okKi
	ozoq1243jrYvUMf4Yss+XaXQ1ujmazI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: pbonzini@redhat.com, alexandru.elisei@arm.com, eric.auger@redhat.com, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [kvm-unit-tests PATCH] Makefile: efi: preserve .dynstr section
 for LLVM objcopy compatibility
Message-ID: <lxhagolfvr6w5h5xujrhq33pzx7hb6db5ihga46z6qn3dba4nx@q5b2fdclitqs>
References: <20260716173315.2775989-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716173315.2775989-1-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 16, 2026 at 05:33:15PM +0000, Colton Lewis wrote:
> When building EFI binaries with llvm-objcopy, keeping sections with
> '-j .dynamic -j .dynsym' without '-j .dynstr' fails with:
> 
>   llvm-objcopy: error: 'arm/spinlock-test.so': section '.dynstr'
>   cannot be removed because it is referenced by the section '.dynamic'
> 
> Include '.dynstr' in the list of preserved sections across
> arm/Makefile.common, riscv/Makefile, and x86/Makefile.common so that
> EFI binaries can be built cleanly using llvm-objcopy.
> 
> Assisted-by: Gemini:gemini-next
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arm/Makefile.common | 2 +-
>  riscv/Makefile      | 2 +-
>  x86/Makefile.common | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>

Pushed.

Thanks,
drew
