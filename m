Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB935F8AA
	for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770997396; cv=none; b=WrREchhumZG2yZ4hGVgqPit4lohsTPjw44CfXOKsAX3sWdb5AA1VAGClrS7LYJWWdvowSFVfpR0+oGfDGEdyP5pqX+W2tcMIsnNPvRUKdHpuvIAx7w5HBE6JkGQj7HIiBnWe0ito2FjBR+0MhGlSJAZ+8zLgmlkUPf5g6t+5mOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770997396; c=relaxed/simple;
	bh=RQrcy1og/Kpv3pjGM812R4VK0JaKFjqk8EcINytj5RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ6aXxsv1oFB1NUjImu9uijheWj+aym8L8ikziRD60bz17Vik9frRO2kZyvoCBAfBVI9yGZuUqVtE6PMFMaHqmmBgvQGqnIOswlcliP8s4Udgxcron9nYr0qP5VpIk71vKxcXFLTapvVHca9gd2xy7OTzV51YTahkggdQlYV0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wzlni9ZB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wzlni9ZB"
Date: Fri, 13 Feb 2026 15:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770997392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VG5FJ7NS80s6E2CwBzmJjFWPxZKa7XVgLrzUuPfCJvw=;
	b=wzlni9ZBAFEw/1oQhOOFCcY7aEMkyfeTVGRFm1lObiRhb4OY/ucKr9NBt9Sm+Af1WooiH2
	Jq7KpCmj56VTlD6LQGE9xtIFxLqHQ8kQ6Clw/1KmPsZ8lUT/OgUW4uiRBUulJQYgwWFxQX
	GuSvvJMYQWkgN7JGcarxqIIPg66FGHY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 4/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
Message-ID: <lrvnjvj7ocndldzfjkwy5mv34nacnketug2ra67uqohlhwywec@ibwwlvc2twex>
References: <20260212155905.3448571-1-jmattson@google.com>
 <20260212155905.3448571-5-jmattson@google.com>
 <gqj4y6awen5dfxy32lbskcxw6xdv4xiiouycyftjacndjinhvp@7p4dtgdh6tjw>
 <aY9BPKhzgxo4UuHB@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY9BPKhzgxo4UuHB@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 13, 2026 at 07:20:28AM -0800, Sean Christopherson wrote:
> Please trim your replies.  Scrolling through 100+ lines of quoted text to find
> the ~12 lines of context that actually matter is annoying.

Ack.
 
> Actually, calling svm_set_l2_pat() when !is_guest_mode() is wrong too, no?  E.g.
> shouldn't we end up with this?

legacy_gpat_semantics should only be set in guest mode, and it's cleared
in pre-run, so before we can exit guest mode IIUC. But having the guard
in place for both cases is probably simpler anyway.

> 
>   static inline void svm_set_l1_pat(struct vcpu_svm *svm, u64 data)
>   {
> 	svm->vcpu.arch.pat = data;
> 
> 	if (npt_enabled)
> 		return;
> 
> 	vmcb_set_gpat(svm->vmcb01.ptr, data);
> 
> 	if (is_guest_mode(&svm->vcpu)) {
> 		if (svm->nested.legacy_gpat_semantics)
> 			svm_set_l2_pat(svm, data);
> 		else if (!nested_npt_enabled(svm))
> 			vmcb_set_gpat(svm->nested.vmcb02.ptr, data);
> 	}
>   }
> 
