Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004928CF42;
	Fri, 23 Jan 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176671; cv=none; b=g8a9W3TSG9+l/SYAVJEjxAOjwL4mZWOX6GmuA0pebfhP4MBAzzEVDKdnuMG7SdSSjUrAE9ho3+/rQmzkxzz6Y4RhR7X0MXzijpgDQr2XxhYrp4tUzn6o4pocBJQZpBu5pWo8y8whSf66m5XeKJEwCN7YvX6Ei6Bo2Nxp+WneyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176671; c=relaxed/simple;
	bh=Ok+c9R9UGaVDPYh4y+adgWZlrRlqrwFjE4p5h5fvLjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vojc+dgZZH/Cb0rJQbBCmsgtto5CsTCrsuUARxt3o1iSNDNV6LxrAJvjzZBalm63X3fh3IARsnSLqw2KBVLD8hAsslOnBEWjfvY1DFR6QDuGscaQWSpF69b5S576yqWRoxsWZeaZicDzLctVVX+afgCrOV7lcYwW/PB2EkzTo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=effective-light.com; spf=pass smtp.mailfrom=effective-light.com; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=effective-light.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=effective-light.com
Received: from MTA-07-3.privateemail.com (mta-07.privateemail.com [198.54.127.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4dyKJ66HK2z2xHd;
	Fri, 23 Jan 2026 08:57:42 -0500 (EST)
Received: from hal-station.localdomain (bras-base-toroon4332w-grc-44-142-112-152-160.dsl.bell.ca [142.112.152.160])
	by mta-07.privateemail.com (Postfix) with ESMTPA id 4dyKHj6Hjdz3hhTp;
	Fri, 23 Jan 2026 08:57:21 -0500 (EST)
Date: Fri, 23 Jan 2026 08:57:18 -0500
From: Hamza Mahfooz <someguy@effective-light.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: move reused pages to the top of
 active_mmu_pages
Message-ID: <aXN-PsEU8jk7LEwh@hal-station.localdomain>
References: <20260120234115.546590-1-someguy@effective-light.com>
 <aXLAfjpWwNLNv7pP@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXLAfjpWwNLNv7pP@google.com>

On Thu, Jan 22, 2026 at 04:27:42PM -0800, Sean Christopherson wrote:
> Does this actually have a (positive) impact on real-world workloads?  It seems
> like an obvious improvment, but there's enough subtlely around active_mmu_pages
> that I don't want to make any changes without a strong benefit.
> 

My testing mostly focused on correctness, though I did see the fault rate
go down on a long running VM that I used to host a web server (I only
only gave it around a gig of RAM, so it is on the more extreme end).

> Specifically, kvm_zap_obsolete_pages() has a hard dependency on the list being
> FIFO.  We _might_ be ok if we make sure to filter out obsolete pages, but only
> because of KVM's behavior of (a) only allowing two memslot generations at any
> given time and (b) zapping all shadow pages from the old/obsolete generation
> prior to kvm_zap_obsolete_pages() exiting.

for_each_valid_sp() already filters out obsolete pages, so we should be
good to go from that perspective.

> As alluded to above, I think I'd prefer to put this in kvm_mmu_find_shadow_page()?
> Largely a moot point, but it seems like we'd want to move a page to the head of
> the list if we look it up for any reason.

Sounds good to me, I put it in __kvm_mmu_get_shadow_page() since it seemed
clearer and it's currently the only caller of kvm_mmu_find_shadow_page().
