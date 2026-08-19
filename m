Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76873A83AC
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155204; cv=none; b=Yh/xc0uXOS0plY0muNZeN8slWvneA+2/o1AhxBCOqawtFUT9qVNooAD/iZwl2+tYyjdo7rQ+OGQZjuS+fB3dkasF/9aOLO3b22sGlyR4nDWfey4KDXRJRYtFjEvNibgNp6b34Xl3Nbczp9E2GUQpU3IhQo/cHNvftbMzX1+jtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155204; c=relaxed/simple;
	bh=LZz892YH9/xaM8/iTFuxgJlCJs566ZSjCktU3cWjXjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AdoI2foBK33cxZWy/ZieKdLVK+S3xAgIo7awOF5oysE7RyyTr84+M30iLzJZcbnxZ2IBjkRcNSCGOqWapYKAHdDI9/Rs9Mu2tvBh9jM1KfzIVZvl+WIvX6L4BGaFtskUZKM+sRUg90Npa02rBgebFF0voo1B+OLAiJgWK2SmQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YOF4IYYx; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOF4IYYx"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso1578452a12.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787155202; x=1787760002; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaU6PgQH9SUVRtzx3SN8O7eufPpN9+OcuRfvjznD5/4=;
        b=YOF4IYYxVfrb/CNi1lE7e8iElSvs5ev++E/gve9v4bEq/3Vn/bvXhnGeYIs198QxsR
         N5fgS+lzGlSraFtQPQ/cdRsiJ9PGBIIghugUBpPEgvhEFa2bDaZk3cY22qZvqIZyjhry
         yHFviVXYLlC3Lxx7lfn3GyD9blaWbP2Bw1XUp7be0059QkOVM6xQ0MNVe6nuFhZtTgBY
         kEvdRW8N8n6Tz4nvMsYEx299m8OIespO5KTnYvrdB+P+FvbxJ5kvr9W5+gK18M6bjmk4
         kfX7CBBhVhHoV8tgwpw1IK/oA8f/h1OpGeIAFRf3E3abdZlH2nh21p5OvvlDIZJFSeeb
         kaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155202; x=1787760002;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XaU6PgQH9SUVRtzx3SN8O7eufPpN9+OcuRfvjznD5/4=;
        b=JiGPgv0VTha3TpvEi5frhCah6nS6u0AIyc0qDPiqQhsrNXMF15LSZe6fsykDkrJDgx
         7Vpsm3JeVFKQt5JaxyJrM7K0T58bBWbT2KB5FqxCSO2vuhU6/0tiJrCbjHs5EsKGNYv6
         CPQp145Gos6oMFemm3Dkn0++NIvuopGjvL6eo/7M7TdbHKZwo+swuzN/z1+ukfwm11ZG
         BEawK0WJvq9amN9AdncVEYCq2Ma56/u8pXG3/pBfIGJPttKSRdy3Hd3BN6L6oMyheRCt
         V9Gvv6rOTh2cqKujELy4YAKSbCnGdljKQG2qt24QUI27LanwEBQT2zr4AxnybfxzO5DV
         +Uww==
X-Forwarded-Encrypted: i=1; AHgh+RpzhHcyrjG60eQLjdv8GWP2YwCqy206yEHgLAxwyFwYOGSrZDQaatb0/8HrYSQpy2T1stA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISTIANE0V75SQlATw3zIhpZjQbXb7cDcA+2M4cGIgYcGdrThW
	BtMgyezwfkGDa33sgwvkppXFqp8hjSHuVRTPrZaMhTUQtMyMFOHD9GnXvehFEZOW1lGx1QblA9H
	2EwY2NQ==
X-Received: from pgch14.prod.google.com ([2002:a05:6a02:508e:b0:c9a:53ea:434a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2285:b0:3bf:49c8:f7b
 with SMTP id adf61e73a8af0-3cd017c44afmr12092360637.13.1787155201847; Wed, 19
 Aug 2026 09:00:01 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:00:01 -0700
In-Reply-To: <7f52191f-c6b5-4d27-8e11-2c00bd9de968@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ak_wC4Q-mQe14DI8@google.com> <alDI1b8fC99SG4_a@J2N7QTR9R3>
 <a127176a-1722-460c-aa84-754e1d343f53@arm.com> <an3sEiQlIuGEjUur@raptor>
 <b6080c23-a2a8-4bc5-b3bd-982bd766c648@arm.com> <an5UJ4S_P1LUFmzD@google.com>
 <487aa57c-72ad-453b-971d-ca24a8380429@arm.com> <an8SOvLybeilzCEU@google.com>
 <an9JNUln8dKaidQc@raptor> <7f52191f-c6b5-4d27-8e11-2c00bd9de968@arm.com>
Message-ID: <aoXTAdnEcKJ8-Ft_@google.com>
Subject: Re: [RFC PATCH 0/3] KVM: Dirty page logging for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david.hildenbrand@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Mark Rutland <mark.rutland@arm.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, David Hildenbrand wrote:
> On 8/14/26 18:58, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Fri, Aug 14, 2026 at 06:03:54AM -0700, Sean Christopherson wrote:
> >> On Fri, Aug 14, 2026, David Hildenbrand wrote:
> >>> We have a hardware feature that requires pages to always be mapped into S2. Some
> >>> things I had in mind:
> >>>
> >>> 1) Page migration would not be a problem as long as hardware could be paused
> >>>    while migrating (e.g., kick all vCPUs). I doubt someone would implement that
> >>>    right now,  but you could consider it an implementation detail that page
> >>>    migration cannot be supported right now.
> >>>
> >>> 2) Newer hardware could mitigate this problem, allowing the feature to support
> >>>    pages temporarily being unmapped from S2.
> >>>
> >>> 3) Disallowing page migration is really just one implication of "pages must
> >>>    always be mapped into S2".
> >>>
> >>> So what we really want is "if feature X is enabled and hardware requires it,
> >>> always keep pages mapped into S2, which currently implies that page migration
> >>> cannot be supported."
> >>>
> >>> Which isn't all that different to "if a confidential VM is run on current TDX
> >>> hardware, always keep pages mapped into S2, which currently implies that page
> >>> migration cannot be supported."
> >>>
> >>> So I was wondering whether the flow could be:
> >>>
> >>> User space enabled CPU feature for VM -> KVM knows that current hardware
> >>> requires for that CPU feature to have S2 always mapped -> KVM tells guest_memfd
> >>> that S2 must be always mapped / disables page migration.
> >>
> >> I'm a-ok with adding a flag to guest_memfd to communicate whether or not page
> >> migration is allowed, because guest_memfd needs to actively support page migration.
> >>
> >> I'm not ok adding a flag telling guest_memfd that memory must always be mapped
> >> in S2, because guest_memfd doesn't care.  E.g. KVM doesn't yet support page
> >> migration for SNP, but SNP tracks page ownership in an out-of-band table and so
> >> KVM can map/unmap all guest memory from S2 at will.
> >>
> >>> That would be in contrast to user space having to guess that page migration on
> >>> the current hardware with the current guest_memfd implementation does not
> >>> support page migration, to then disable exactly that.
> >>>
> >>> Does that explanation makes sense? I don't know the exact mechanism to do that,
> >>> but that's just my high-level thinking.
> >>
> >> Yes, I'm supportive of KVM expressing to guest_memfd that page migration isn't
> >> supported by the VM.  I'm only objecting to expressing that memory must stay
> >> mapped in S2, because guest_memfd doesn't care *why* page migration is or isn't
> >> supported/allowed by a particular VM.
> > 
> > My naive contribution is this idea I had:
> > 
> > 1. Userspace queries support in KVM for feature xyz by checking the
> > capability KVM_CAP_xyz.
> > 
> > 2. Userspace knows that for feature xyz to work correctly, it is required
> > that memory remains mapped at stage 2.
> > 
> > 3. Userspace creates a guest_memfd instance with the right combination of
> > flags set and _unset_ for feature xyz to work correctly - i.e, to keep
> > memory mapped at stage 2.
> > 
> > For this to work, new guest_memfd features that might lead to memory being
> > unmapped are enabled via a flag, and KVM keeps memory mapped at stage 2 by
> > default, to maintain compatibility with an userspace not updated for the
> > new features/flags.
> 
> I was wondering whether KVM could be driving that setting in guest_memfd, with
> less userspace intervention.
> 
> 1. Userspace enables support in KVM for feature xyz through
> capability KVM_CAP_xyz.
> 
> 2. KVM knows that the feature, on the current hardware requires permanent S2
> mapping, so it instructs guest_memfd to disable any features that could lead to
> a temporary unmapping (e.g.,migration support).

Yes, that's what I would like to aim for as well[*], with the understanding that
things may not play out exactly as we want if/when we actually implement all of
this.

 : We might make guest_memfd page migration opt-in, but if all of the incompatible
 : setups can enumerate their existence prior to creating guest_memfd files, we may
 : handle it all automatically, e.g. enable page migration by default, but disable
 : it if a TDX, SNP, pKVM, or SPE-capable VM is detected.

[*] https://lore.kernel.org/all/an9oR3dBVgFs7j7q@google.com
