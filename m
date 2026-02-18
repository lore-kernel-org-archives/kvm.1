Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA033A9FE;
	Wed, 18 Feb 2026 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456915; cv=none; b=dFAlUyJGiIfYNlnpUhFGlBOxFkGqTXhY5kAUoJDtBYqwWjW9mXX6vrmFh9znGPQTLHonP2tJo+Als0SumKrJmhJ+Bymw3+TMGWx7+3ADDujqXRjo2MqoxWn2rno2n7LL/knSmxmKQXPyCXlm7oYLXEWFCVM4daFg1t3h1cT81C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456915; c=relaxed/simple;
	bh=T/cclOwhKKQs3XRUlicg1FKjJ0GzkG9KvdpnuKBPaGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSKfa9iiZSeDPqY07QhxwXXlfGt9dcVwQuSa3XNgSdqPuuyIAQpjeWw750vpXAe9ZdADansxIyfbqpoI6/+lDQAtbFq7gCvbXNV3Vd28ml0EGyo3LTU2Nl5nxbLGkP78eU51XTetFB5U2C1wFgxHgimnNBYg0TZcAq5J2Et05ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jDh6SHln; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jDh6SHln"
Date: Wed, 18 Feb 2026 23:21:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771456912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fKwnUMMgghWDxNQszAx9SQm5fZRDMK/2Wm7yA6ehEOo=;
	b=jDh6SHln/lpOmQCWYeWGIooe6RIqOZ4Xxd2Zxc/aMNSt0+5n8xgY4td/NbJimp5qUcf7JR
	mFEwoqplrC2CHDunBgjvsPy1GZhVzVyjxD/iKqlNimYo2gyPE3bolL+Znk2/eokwL/QmSr
	7QAg6ipDCweY0VSMGX089Uik/1LJZgQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] KVM: nSVM: Move
 vmcb_ctrl_area_cached.bus_lock_rip to svm_nested_state
Message-ID: <awpvwdbikxo6dgeakzenvydp23vbhctf573b4hdsb4ohoi3vou@r3eiw3jh6tdq>
References: <20260218230958.2877682-1-seanjc@google.com>
 <20260218230958.2877682-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218230958.2877682-8-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 18, 2026 at 03:09:57PM -0800, Sean Christopherson wrote:
> Move "bus_lock_rip" from "vmcb_ctrl_area_cached" to "svm_nested_state" as
> "last_bus_lock_rip" to more accurately reflect what it tracks, and because
> it is NOT a cached vmcb12 control field.  The misplaced field isn't all
> that apparent in the current code base, as KVM uses "svm->nested.ctl"
> broadly, but the bad placement becomes glaringly obvious if
> "svm->nested.ctl" is captured as a local "vmcb12_ctrl" variable.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
