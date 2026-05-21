Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088D17A586;
	Thu, 21 May 2026 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330984; cv=none; b=iieDFxaJ2jSfdqXuPAQvwEVRWpPc8NOgYGNufkaBr07KrdYTe2CYqCI7xIHsTJq4MN/UosNXHtPKdS+4GHjOzLB6GgCb83xRO0nO6ClRsiPHFvJYhmJoqv+dcZ1EHAppEBISwusR9RtbJQM0wsPUC9CdDmhmUXeXYrqU5EHF5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330984; c=relaxed/simple;
	bh=dNtrvwed4/w0fdQW30VL14wT3CsBmo1iXjfBasbkAe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Odm90F8vDYUEqK0V3BBNQ2vMGrq587EQ4wpNf3LBSefePPM94LU61aEWD5ifiCtovcyK7rxkyC6hz98vGILZk1CJvhAPE22PWQRvyVkoYJn6KCblzHJV1JPiDNkhOZyok4RXzHygQUBIwAje2TExQGPPy1hoNCkqwGFgLxR1THw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLXJUF+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLXJUF+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F2C1F000E9;
	Thu, 21 May 2026 02:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330982;
	bh=kuMYJnVmYJfssp6PNhyDyTEfcu3yF+ETKpEa1/R7Gtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oLXJUF+vqOcs0adSAFyn2iS2z47uHHsACe0vuIm0Efwr+RmT5BcCKJl3Bi+gkrfXd
	 qNhUUE0j6qCw4DTrXFW4KwY0Z+9FypLH34rDRkhvkQxbb6E1S7CKd4MBBO63brb6EH
	 /u2u+wIHbK0toxv7h5VyBQteZ2gVr6IOenEHFE31DzqnjWA+/kYO2FbmGWuIoqySrk
	 +hRzpy7m1abmqFy57/wcOCKXEKzRv1MjggyJsJfQki+wNfiZPci3aNiTS38nxB6AR7
	 47TAg63waUDAtNkEdviLzCeKF3K7pFpxjpySATchDQyDFiW3zmoh24Xqab7ObQMj5S
	 QZqZspw1SD6/Q==
Date: Thu, 21 May 2026 02:36:21 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v8 0/8] KVM: x86: nSVM: Improve PAT virtualization
Message-ID: <ag5vj3q2r7NdYFQY@google.com>
References: <20260407190343.325299-1-jmattson@google.com>
 <177915062620.2226127.1264745848157211491.b4-ty@google.com>
 <ag4ZwD53B7a0ivgT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4ZwD53B7a0ivgT@google.com>

On Wed, May 20, 2026 at 08:30:31PM +0000, Yosry Ahmed wrote:
> On Mon, May 18, 2026 at 05:41:06PM -0700, Sean Christopherson wrote:
> > On Tue, 07 Apr 2026 12:03:23 -0700, Jim Mattson wrote:
> > > Currently, KVM's implementation of nested SVM treats the PAT MSR the same
> > > way whether or not nested NPT is enabled: L1 and L2 share a single
> > > PAT. However, the AMD APM specifies that when nested NPT is enabled, the host
> > > (L1) and the guest (L2) should have independent PATs: hPAT for L1 and gPAT
> > > for L2.
> > > 
> > > This patch series implements independent PATs for L1 and L2 when nested NPT
> > > is enabled, but only when a new quirk, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT,
> > > is disabled. By default, the quirk is enabled, preserving KVM's legacy
> > > behavior. When the quirk is disabled, KVM correctly virtualizes a separate
> > > PAT register for L2, using the g_pat field in the VMCB.
> > > 
> > > [...]
> > 
> > Applied to kvm-x86 svm.  Yosry and/or Jim, please double check the result, the
> > goof with patch 5 was slightly more annoying than I was expecting.
> 
> The result looks good to me. I also ran the selftest from v7 and it
> passes. I couldn't help myself from reworking it and cleaning it up, I
> will send a patch your way soon.

As promised, if you want something you can directly run against the
current kvm-x86 svm:
https://lore.kernel.org/kvm/20260521023448.3826878-1-yosry@kernel.org/
