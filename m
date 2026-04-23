Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BE2080C1;
	Thu, 23 Apr 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960025; cv=none; b=Y1uiYPlOgCPmvuWLSkLrW0hDu5x74+W62AHBOvE9nyeIJ8nbtH0AYUIHQMxhuyVySk9fD6DGWv75oqHqKw7286tArmh0eb3mXV04b7VTIaf/KYlwf5U8oN7f+KvUy8mqx1VvDFeoyDXPhc/ER4TlfJRDnMAMkgQo72FhQzk6x4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960025; c=relaxed/simple;
	bh=ZcEQ0mTXcKrmcxqrNcmTfA/O0IFOwltTpNgvHoUb3xk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=m35j2vKIjM76MqowdFCD1RrCdkrwV4pnfCOEfeE54pS63PnhDZM39th3jky0yV1FMdBN2r1a3SDBP1aOHqWp9IVJIC1N9+rW8gwLZz1iLW5CVRn5QAANfrfyYRIi8NBffvZffnQmMIvJUYUYcwuoumhnqbhbyPrZXdK7ieRhd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iylchHLj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iylchHLj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZcEQ0mTXcKrmcxqrNcmTfA/O0IFOwltTpNgvHoUb3xk=; b=iylchHLjx8+ZX4c8n5ogpLNoBv
	NUQiBeDIi+fmg5a8VcgJ8CmUeFsOhBmyiGmr9WBwT51R+Iq7VqLKx34RbAWIeCO06BLCx4zFiIMM2
	Mox+oT1oRUu1S7rc9Sghp+J9HW1mFXYpYg6dY8Qx0UaAd+FBU3nVH4xELxDjmBnWunNsDy0Um2Ez4
	tdoE+lRH3bwiqUgPfhJP1fA7qxL9rUXR7nJhb3W2x4cnkiqTFvh7mV80P87bFjJLpdQ0XpQngxn0z
	CQ1YX2ONKObkSEL2R7qO+wK3lf5w9IyMF7diN5ZGZX1bJ1OwqLHIUvE12PHAkjeGm503WaENI+2PO
	MjoSnRzA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFwTS-0000000DNmz-10Rv;
	Thu, 23 Apr 2026 16:00:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 210803008E2; Thu, 23 Apr 2026 18:00:16 +0200 (CEST)
Message-ID: <20260423155611.216805954@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 23 Apr 2026 17:56:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Sean Christopherson <seanjc@google.com>,
 Jim Mattson <jmattson@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 Paolo Bonzini <bonzini@redhat.com>
Subject: [PATCH 0/2] x86/kvm/vmx: Fix VMX interrupt injection vs hrtimer_rearm_deferred()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Hi,

Nicely split out in two patches, but otherwise unchanged (except for a small
comment).

