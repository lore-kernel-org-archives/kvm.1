Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BF476CD6;
	Thu, 24 Sep 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249366; cv=none; b=arNfHAEEH7vv3KUPMQpHLmBq12QwwRW6h0KOX+dwnpHKjOWWghtb0wMTz+VTS9g9YEeLExY8+fSWjxzyaVXuxsVdbX7l9+Y4Zqp8i3X98+ZEWk/OeZsusLs6jTH1Vv4ZHnnHUDY2vaD6f83L51RsMtHC33W5EBcQ9XWRRvs1lcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249366; c=relaxed/simple;
	bh=96uOpUh7uZ4FaXHMzQizbgjaxeNQdo8l1V0PdDoF1Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjPvyQHKTp8VW4ZlQ4pdxIn9lQMgfdFQqojZxMquQxCcQMPI85jkVwMsUSOxb3E8Xa3WNYyxQU77MY3DL7oH9+j0Zo9Ob8Lyjlehi1/j3Mcx9FB6naCgCnqr/dxbKrRDjL/j8NA+lMfPo79ZaTPPf09PPeG1d4B2sK6emujRVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0kntss2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0kntss2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585341F00893;
	Thu, 24 Sep 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790249357;
	bh=x3v8NeaBapDbL8/nRL9ofnJteHNN3uYDzYKjV+q7JN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z0kntss29tc8mz1YeXfRNTG2kMqmMlQCb5Ajr6cwBUSWYWVjHO8WS4J7KvES8e2lF
	 yQk5/Kjyb3UTLxGP1CWcQ7IXO4Z2dJSgp4EDuy1DdRlc4e78WXeLVEdmFEQdFX4fmX
	 erb3l0gbvaxHzA/UL33Yvvp1//nmwXQYiTo51kiy+Uh+vQddjXn8pio9CasI/nmCze
	 Qr7iuy/RzBc6csoCPt4ZiD1KjhnIRX2bAM9eQoE8NMv38A/ev2jAaUmEs1IWWUv4Mb
	 xMSzVbLM44toZHLXZU5AY7btEJvNtdHQSPMZnsU7gPe2Y1gBuwo+QlK0lhe1vN5jjS
	 NzJ6RGsBzMNIQ==
Date: Thu, 24 Sep 2026 16:51:25 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@meta.com>
Subject: Re: [PATCH v2 3/3] KVM: SVM: Clear AVIC Physical ID table entry if
 vCPU creation fails
Message-ID: <arUGoepfp97GY8aK@blrnaveerao1>
References: <20260923155108.1550622-1-seanjc@google.com>
 <20260923155108.1550622-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923155108.1550622-4-seanjc@google.com>

On Wed, Sep 23, 2026 at 08:51:08AM -0700, Sean Christopherson wrote:
> From: Naveen N Rao <naveen@kernel.org>

Nit: I noticed this because I thought I had fixed it, but the From: tag 
above does not seem to carry (AMD) attribution even though the patch I 
posted seems to have the correct form. I checked 'b4 am' and that seems 
to be doing the right thing too. Anything I'm missing?

Otherwise, this series LGTM.


Thanks!
- Naveen

