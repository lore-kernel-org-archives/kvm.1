Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494C3451A7
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776445188; cv=none; b=FAnU2eOhw49zliHZRm5H1R2oYJ9ukYLl9zxAm/gHDU3tNAlPCovBp4yp44iUpFIchHmwBovH5o+BxKOujCUUZn9vt82UaT451hKkYbn5eEg0mI5Pf9LeKk4MzVaPdHn4VhP1d66iMq35xlvGFV357j0A+NYQu3akiMoyLaBQ3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776445188; c=relaxed/simple;
	bh=fMsQaBkPIWlFvTddq3pkA/GSUQ4jKl6XtjEyjYg9b7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tY742Df/28BwArQOppo07lRrZSekVosicFcqR0ZaFZ82aUSb+7g+xMXBRNL4rogy9WYsKGod7luUQKfRdEelvmeoEZxO2rhZ19m79utW1PtGW11c4f08ywDTsoRxkAg7FTH/fHlXYRb7ExqparvJ6I0m3HAGhOTzPYO6DF+7Iz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BLX0XOzk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLX0XOzk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so1217542b3a.0
        for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776445187; x=1777049987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xpUE/ibC3YyCoGenWCVFz5lepygm50eO7SK+GhPCXc=;
        b=BLX0XOzkjZHvUHDauE0NN0Q/h2rSK089gCCKUuUpsQc2kAePQfWmgon9p733O0cmHz
         ffHoI+830Ui2lu3spK/6+6JL97MnuyzHzNbweftwVtWmLgAi9FRp8Ace5oYcgwC4xV+F
         ooMiqv7Io176NxdDkBs0Ps7v7vEZpAga+SlB8cBaIYUzzDmoVIFyV2IfiAn9+Te9vwRs
         VJbvDQmKktFOR9Fh58Xv7K6rSoSU7NZFuJoUTTSqy2Yy6j7Z/evRCW8erzE48iop4GJH
         ReFSCgBNi3PSUio3GyfeTzX+yAoC11/Vj7y3zm3OlnpkUcANGSm2O+MibRTSLXHTNfEc
         htpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776445187; x=1777049987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xpUE/ibC3YyCoGenWCVFz5lepygm50eO7SK+GhPCXc=;
        b=NYSUtQIArajNZ8epdvFBCbhThUuL+lGedBDy6vLpygjlgEJRv2+1w7SCRjjYqpX47x
         PwhQKv6p5qIY72k3EfTLVTVR2zoVfM9XmC/xl2aO8zH9yNNcsiTCw1jDgN9TA5aJJxBv
         5GnNkC8SAJUmL5zd946zihYvMK0CZES94gyXVUMJs8yOWQ/QryMigAv+xTE/S09MP9PO
         IjBoEULhPphFVb73reDAOUopbA83AfgesQ2oSFK9QphrAINQUaeH0y/kHu/LLjux+3Qr
         5qfRGNhtO2SPZdQoIypoW9yJJjwZuAxgwpVN+toNWszbY6tna9MEfcrVWGaKFmCpPqtN
         fzLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GZFjqeCisFaF+sdTvda1FfhLxviSEyxkPRFCaYbPWpT+FqS7eSKmkJKR9tWBQJo+EMGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuM0666Y0QcxfigoB55kNOqdByidov2vPtcubmKrgX1W6Owktm
	pypr1GQyaWQ0EcXhSwsjHljLvm8f/3eMjt+JM+ejUBFyYqCd1oDg3hqA8ICemujReTarPucQfBO
	tIKmYSg==
X-Received: from pfbic16.prod.google.com ([2002:a05:6a00:8a10:b0:82f:8a3b:87f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e26:b0:82a:7aa3:a2fb
 with SMTP id d2e1a72fcca58-82f8c8f07d2mr3805935b3a.37.1776445186761; Fri, 17
 Apr 2026 09:59:46 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:59:45 -0700
In-Reply-To: <0f25c1c247c08f19d36ca774608bc8162d2454a4.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129011517.3545883-1-seanjc@google.com> <0f25c1c247c08f19d36ca774608bc8162d2454a4.camel@intel.com>
Message-ID: <aeJnAfIryxf5Bzpe@google.com>
Subject: Re: [RFC PATCH v5 00/45] TDX: Dynamic PAMT + S-EPT Hugepage
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Sagi Shahar <sagis@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 15, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-01-28 at 17:14 -0800, Sean Christopherson wrote:
> > As for landing these series, I think the fastest overall approach would be
> > to land patches 1-4 asap (tangentially related cleanups and fixes), agree
> > on a design (hopefully), and then hand control back to Rick and Yan to polish
> > their respective series for merge.
> 
> Sean, were you still planning to do this? I see you're, I think, asking for Dave
> to pull patch 1 here:
> https://lore.kernel.org/kvm/ac_bMKD7YGhMwUCf@google.com/
> 
> But actually he acked the version in this series,

Oh, right.  I forgot about that.

> so another option is you could just take patches 1-4?

Yeah, I think that makes the most sense.

> Please let me know if you are ok with that plan. We are growing stacks ahead of
> DPAMT and the other splintered pre-req work and looking to reduce it. It could
> be nice if we could take all the pre-req work through the same tree for that
> reason, and most of it is on the KVM side. Is it reasonable?

Ya.  I'll apply 1-4 and create a stable tag for patch 1's commit for 7.2.  If
it won't throw a wrench in things for you, I'll wait until 7.1-rc2 to get 'em
applied.  I've been burned more than a few times when using rc1 as the base for
topic branches.

Dave, holler if this doesn't work for you. 
