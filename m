Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EF15E5BB;
	Tue, 12 May 2026 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546283; cv=none; b=DWEP6XkLZgt2zRLgJpuVHgVih3RTQyE+DY8W+4W6IKyVknnvHlKz/+JIl5TXjoPOrkKyja/eOnnJBroM4sbUM+XIFhsPIpfozRwomxKuK4pmBu17WUhUSml2EXX7EKoPzUtYdteI9HIR5Mc6+aABTe6l4bx+9TXvQeiuCYf8+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546283; c=relaxed/simple;
	bh=av50ekhwDqan5HsS7/1OJVTH9wrg0R2PA52xK/hu+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+IpW/5K08/zpfWc165XPvrnhd6ugvRTP+4VKQkOjrnGYlzNHNmKrBeHN3y3QpXA5OCo3Z6BnM5LBXtSmzqLySVmmRThqjdbZsvZfGEpbNWip+jSIj0nmUGHVtq92EssdNYY0UAXFnoilIF83My0PHvZCzB1R/xEQzdi5tGeiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUYgT2rO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUYgT2rO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF8C2BCB0;
	Tue, 12 May 2026 00:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546282;
	bh=av50ekhwDqan5HsS7/1OJVTH9wrg0R2PA52xK/hu+Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUYgT2rOOOE2V9frE6zRmqJiKWWKjWjeCJkZPqRvX2a5/KYJRZmsG7FYYar/gY+tC
	 49tIodyjymvx6N8qzu02KYMbLSlk/YtTk0YdlX40LrYxgB14c3rKK4kBCpU+8Gap97
	 8S09z8YRZwdhAcqB39bPDUkQex5YBS/FNke5xSZPkwztKY24puhwr/LThatZ/uukbJ
	 Yk1Me/AjTeE5Hx0FpkaLm2/EHXHrpPuX4EhQgRq5VFY1zjOxvFAXu8gIi6Ja/Ir4Lq
	 4nicsglJhAWUHdzPU+zsyYwRIhP6MZKvRKMmCU8aFZOPqH8lM96ZnGBTmzJgdKLe+w
	 T6xDfPQKIpUNQ==
Date: Tue, 12 May 2026 00:38:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	David Kaplan <david.kaplan@amd.com>
Subject: Re: [PATCH v2] KVM: nSVM: Never use L0's PAUSE loop exiting while L2
 is running
Message-ID: <agJ1Banej3qmdPoR@google.com>
References: <20260508213321.373309-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508213321.373309-1-seanjc@google.com>

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e7fdd7a9c280..ac21f402c1ca 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -913,7 +913,12 @@ static void grow_ple_window(struct kvm_vcpu *vcpu)
>  	struct vmcb_control_area *control = &svm->vmcb->control;
>  	int old = control->pause_filter_count;
>  
> -	if (kvm_pause_in_guest(vcpu->kvm))
> +	/*
> +	 * While running L2, KVM should intercept PAUSE if and only if L1 wants
> +	 * to intercept PAUSE, and L1's intercept should take priority, i.e.
> +	 * KVM should never handle a PAUSE intercept from L2.
> +	 */
> +	if (WARN_ON_ONCE(is_guest_mode(vcpu) || kvm_pause_in_guest(vcpu->kvm)))
>  		return;

I initially thought putting kvm_pause_in_guest() inside the
WARN_ON_ONCE() was a mistake, but I don't think it is. KVM only
intercepts PAUSE if kvm_pause_in_guest() is false, so grow_ple_window()
should never be called.

But I think this applies even without this patch, right? Maybe would be
clearer to do WARN_ON_ONCE(kvm_pause_in_guest()) in one commit and then
add is_guest_mode() here?

>  
>  	control->pause_filter_count = __grow_ple_window(old,
> @@ -934,7 +939,7 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
>  	struct vmcb_control_area *control = &svm->vmcb->control;
>  	int old = control->pause_filter_count;
>  
> -	if (kvm_pause_in_guest(vcpu->kvm))
> +	if (is_guest_mode(vcpu))
>  		return;
>  
>  	control->pause_filter_count =
> 
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
> 
