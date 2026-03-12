Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D5361DBA
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325055; cv=none; b=lSQI7fpHEGOMZMtBEB2K2PKw7sLzT5Jvpf3QTUkQkfCvwlZ5ElxQicbeDAhaWeMCYxSv97cFRNgtn8G1ldv51Jxqyr/mmagjHH3R/+zbUrKmUgtndAFBhZx8RGrOEVcxRMyH2keJeJMUBFdd7JSED5G4rbB0BWsUjqDDhRd3+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325055; c=relaxed/simple;
	bh=I4CtxijTazzeNlxvuTUyF3RUnOOc3n8OjRgx3tDTnuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJql+Bzs8tTPhVrGRCErPBXp5inOSS4v1zBYS8Xb8nK12fGYb8PUr7r2NInZOE7GUC1BW+Hf08GB6ID1qpgxE7bdE+aSKQkniT4H78YBYMVbD92b+N/DRA+bI2HUqipX873HU2yt8ydqZoeQay9J21+V4ffCt1j/zbHQssvWiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EZNez9Ct; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EZNez9Ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773325054; x=1804861054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExMhMb/APv7OcCxSZ6UblIQl314K7bm3vhp6MQjWmUA=;
  b=EZNez9Ctz6ifBX3KeCpMN3oUT96rVO8KXe6oW7Ah+9+UmFX8fHnPyMRQ
   xJK+mRmTDoNtxubqRmY4tq/ikDOyHsagOIUwJQLnbu34kvEslEkqtPneQ
   mz43e90a5nDAqNuhO4VDLgW0d8ZABL2YhYTR7K5QOnyPkdmPuCof7f/b+
   Nw8/JKFRMUiCP422aYCBSP69VBAojPHkJt3kVNIUJ5Nbw6nZa5wyRC0l3
   Syhg+TTLY99tURfdj1wZ8bByh5ZmQ0AmuSM6Jlv8vWj7RQLGf7HlEWne8
   7xD7qk64zY+R0TbcL53lMW2hGfiGRYLGquS3TTatCbRXTzfk/8lQ+dO2a
   A==;
X-CSE-ConnectionGUID: g4CUpUJqRi6dko+4w4nQNg==
X-CSE-MsgGUID: Hyra0qxQQ12/D/fKS0Fv3Q==
X-IronPort-AV: E=Sophos;i="6.23,116,1770595200"; 
   d="scan'208";a="14883665"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 14:17:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:32038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.152:2525] with esmtp (Farcaster)
 id 6c87c1e6-d0e4-4727-8183-e41af652fc2f; Thu, 12 Mar 2026 14:17:31 +0000 (UTC)
X-Farcaster-Flow-ID: 6c87c1e6-d0e4-4727-8183-e41af652fc2f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:17:31 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 14:17:28 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <seanjc@google.com>
CC: <david@kernel.org>, <dwmw2@infradead.org>, <itazur@amazon.com>,
	<jackmanb@google.com>, <kalyazin@amazon.com>, <kvm@vger.kernel.org>,
	<patrick.roy@campus.lmu.de>, <pbonzini@redhat.com>, <pdurrant@amazon.com>,
	<tabba@google.com>, <vkuznets@redhat.com>, <zulinx86@gmail.com>
Subject: Re: [RFC PATCH v3 3/6] KVM: Rename invalidate_begin to invalidate_start for consistency
Date: Thu, 12 Mar 2026 14:17:06 +0000
Message-ID: <20260312141724.9775-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <abHWLDvJcWlQOdYh@google.com>
References: <abHWLDvJcWlQOdYh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, 11 Mar 2026 13:53:00 -0700, Sean Christopherson wrote:
> On Tue, Mar 10, 2026, Takahiro Itazuri wrote:
> > Most MMU-related helpers use "_start" suffix.  Align with the prevailing
> > naming convention for consistency across MMU-related codebase.
> >=20
> > ```
> > $ git grep -E "invalidate(_range)?_start" | wc -l
> > 123
> >=20
> > $ git grep -E "invalidate(_range)?_begin" | wc -l
> > 14
> > ```
>=20
> I'm a-ok with the change, but the changelog should make it clear to what =
KVM is
> conforming.  Very specifically, IMO, all that really matters here is alig=
ning with
> mmu_notifier_ops.invalidate_range_start().
>=20
> Because for me, "MMU-related" anything in the context of KVM means just t=
hat,
> KVM's MMU code.  I don't care what other MMU-related code outside of KVM =
uses for
> naming, if that code doesn't interact with KVM in any way.  And for KVM s=
pecifically,
> it's a much closer race.
>=20
>   $ git grep -E "invalidate(_range)?_begin"  **/kvm | wc -l
>   11
>   $ git grep -E "invalidate(_range)?_start"  **/kvm | wc -l
>   16
>=20
> But as above, I'm definitely in favor of matching mmu_notifier_ops.invali=
date_range_start().

Fair enough.  I'll update the commit message as you suggested!

On Wed, 11 Mar 2026 13:53:00 -0700, Sean Christopherson wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 2ea5d2f172f7..618a71894ed1 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1566,7 +1566,7 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_mem=
ory_cache *mc);
> >  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
> >  #endif
> >=20=20
> > -void kvm_mmu_invalidate_begin(struct kvm *kvm);
> > +void kvm_mmu_invalidate_start(struct kvm *kvm);
> >  void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t =
end);
> >  void kvm_mmu_invalidate_end(struct kvm *kvm);
> >  bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *ra=
nge);
> > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > index d1094c2d5fb6..8ecf36a84e3b 100644
> > --- a/include/linux/mmu_notifier.h
> > +++ b/include/linux/mmu_notifier.h
> > @@ -134,8 +134,8 @@ struct mmu_notifier_ops {
> >  	 * Invalidation of multiple concurrent ranges may be
> >  	 * optionally permitted by the driver. Either way the
> >  	 * establishment of sptes is forbidden in the range passed to
> > -	 * invalidate_range_begin/end for the whole duration of the
> > -	 * invalidate_range_begin/end critical section.
> > +	 * invalidate_range_start/end for the whole duration of the
> > +	 * invalidate_range_start/end critical section.
> >  	 *
> >  	 * invalidate_range_start() is called when all pages in the
> >  	 * range are still mapped and have at least a refcount of one.
>=20
> Please move the include/linux/mmu_notifier.h change to its own standalone=
 patch,
> as in, not even part of this series.  It's an obviously correct change (t=
he comment
> has been wrong since commit cddb8a5c14aa ("mmu-notifiers: core")) and has=
 nothing
> to do with KVM.

You're right.  I'll exclude it from this series.

