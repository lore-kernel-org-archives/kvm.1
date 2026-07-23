Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78E4570ED
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822318; cv=none; b=pWkFpxmaVx+OU07Rl149RZYE2SnZWiVdPl1SNgHdqktPW1i7oQhYDXsQF6lxt0CBTQbHv3L4r8k8u/x9o+3KFnnye9xrkBICA325Hnhc3CdW6deYI8jzLJbHLO2sQHACRsqVqGKlp6dc1Nq6LaiHbuhHkhnkyM2bxUuNhtGsOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822318; c=relaxed/simple;
	bh=qlxjHxg0aKO43aQp28f/OFH/keg5U1hhwcde6rqWGEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfC0TNz8MbWndKZYTiJyw8LTaLv/euHhuUeuSR0kXdRgnXVOrqd8kzlWKJ54AgI67MUH7hA395LQxCavbSvnrI+D1fjEp7jGNz6dFpXZoHnS4VaYZe/Zhdbzqsa61D89DG9jF3QgxgDRHlmTKsSDAfD9K3Q595cm94lz3jxi38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Cgs+a2F8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Cgs+a2F8"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9305a2121a1so83567185a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784822314; x=1785427114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g76/VCTunnMtb1dTlZWxSdXy3jUc5pTpstI44HSyfHw=;
        b=Cgs+a2F8/dI1G05i6c49L6Zm+g/D4YnuzywoDSi98wX7hTxubqn4qNkTDTYJ2k7igO
         HI25kUaXiFyZf0T1wMK4W6girHDUAUCo9mNE//esq2Gszt8/JR9+B7h9iHOxuTx6bQBN
         Ku8JIfr8R9/FbMsfe4fTtO4Qmxb6J8sP3s9E4VsOAFC2pUygFIkhBq3zuBWbSFggi8jG
         7LX9+dYzEVJL4kdFoDIqP1JdmUoqX5SbuUx7AMT0K+fm6J1mv/eGBDCa2xuicEgZs214
         l/bGuCqW3F6cZhHe691sFl/8GB3+Ra2ooI7J7ffNob1EeOEYqjY/J8pMV4zI44fJtbFF
         1GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822314; x=1785427114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g76/VCTunnMtb1dTlZWxSdXy3jUc5pTpstI44HSyfHw=;
        b=lfpVwE2E3kNsDvFOzFmhVEt/evJg7dcJl/B0Ffbq+m89ogIuXlhT8OerIYh7mt9V4J
         YZC+5XL7sSz869UkDAsLoM4R1hJ+rzAVT0BPXDLQrDKgttU28aA9q7jYnuCr3IAXwum2
         EOLetUHnhUP2m7KMqQpkOT5i5lK7jeemETelg9hOgG32p/D4az4KQyNf3gy+r7OeMR+P
         jW2EyEK8eGS1guIyIis98XGAr5NKSJHWWWIje32jW0CNO5HVVn20mowSocvkuXSVxgt0
         5wCHx4w8Tio+Da6n7HmsRQckdsviALhZApAjjMqZJak/mo2zOcNgT6ynXkuKJGlt8HBO
         gGhg==
X-Forwarded-Encrypted: i=1; AHgh+Rp06MSuVB+CK7t7y5Vh8AjTEo7QtIf3rHXxo+ukL/MAWubV22kXI4JMADbrK/33oX+8WDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL488gFPZQtSK+47VZuzPcIyiD51laXGQSMpmr1I/lauHj6P/n
	y7BUTErbLvXE9+d5XFOVlPI4gyP8N2bSW58zYYDhO46xrX8FyH7+uM72T/uuVAnT3zY=
X-Gm-Gg: AR+sD10c1DqFKpTes7mHf6HkblK3WxDuQGQsgtjmW7A8quolEWbmcbdWtzQ0vqL6XIf
	FN4oHryKswfhA0JNruPZhaLVkyPgGX1aoBg71UlvGjS0f2/ZotM2Q8ulmj4IXqUlfZ7eKHPDu/T
	1ZZFzifQ+1In/OSvnfwl9EDXM5F4X3wRcwqJl+bLTfJSqeAnl2ODkLSk1K7ocH/tzs7WK5kYXfG
	K1yuiATwyhI3plkH6ezKdr81a8Na6Gb9hPPqD/6WncrSuoqrNMfQw+fEQnfRckp8NEsaTsKFajO
	R4Gl42pLrxIS09ZjBQFQoQFYolf5KgOgYX9wP0I/mJmoNBXZHmDj1kNti5jzsmhuOHZJtWiVDVL
	22e1PdTDKzMvcMTX7ygM6UR5wkObuPlsoRMBkEUYNxQrxhHGvFrj8MIzpZLhHrtYb8EriuEVh1B
	zXZNDd6kERXocgI+zv+ZhuWpbs3bqTRYrD44gZXmzkHnj6oUSmNo+lOf0LVg==
X-Received: by 2002:a05:620a:1726:b0:92e:7d7a:108b with SMTP id af79cd13be357-93103aee60bmr357433185a.50.1784822314110;
        Thu, 23 Jul 2026 08:58:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a03834sm441323085a.30.2026.07.23.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:58:33 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:58:27 -0400
From: Gregory Price <gourry@gourry.net>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amIxyy4Vg_TTE8Y4@gourry-fedora-PF4VCD3F>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
 <amIrDncrL4K-JRBO@cmpxchg.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIrDncrL4K-JRBO@cmpxchg.org>

On Thu, Jul 23, 2026 at 10:54:06AM -0400, Johannes Weiner wrote:
> > 
> > My stance is that using NUMA balancing with KVM guests is a terrible idea, and
> > that anyone that insists on using such a setup gets to suffer the consequences.
> 
> I agree. Surely we cannot leave shmem balancing broken due to
> that. It's also not clear to me how many people even enable numa
> balancing.
> 

I lean towards Johannes' stance here that consistency is better, and if
KVM has a known-poor interaction with numa balancing, maybe KVM should
simply set a default policy (when none are present) to avoid this.

That said, this is painful because MPOL_F_MOF / MPOL_F_MORON are already
a silently inherited policy on boot (added during init).  This will be
confusing for users.

This is not documented anywhere.  Maybe this change should come with a
docs addition that says the default global policy is ACTUALLY:

   MPOL_LOCAL + (MPOL_F_MOF | MPOL_F_MORON)

Instead of just MPOL_LOCAL and letting that silent implementation
detail bite people.

~Gregory
