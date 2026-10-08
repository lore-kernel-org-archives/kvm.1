Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B45225788
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474814; cv=none; b=MoNPyOESmiEVSTse4kslWsFMXsvXMHUPz5TcxaNWNJvpphER2bZa0m1AJld2VUIzpYqufkENI81oqfsCK2a8Be/iBCaBEDbB+m32PYCBcAiIh+nExIHeruto+gOMHoh8X450IhFPv27I4CMIbDCa+spGJhxL/KkJiKp940rckcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474814; c=relaxed/simple;
	bh=1xWXcqzIrkHEWIbydCe9/F9btnY9lWWcTY+ha58hLgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoJEZiQB2oveq+Y8B1hCI8q1I0ZsEkvAkpQsMynTLqblcu67WolYXDmYyPr2M+lJGv762Xpo/uvVpy2g2AtIgXlBFTsSmHasPUp4TLmZg+IjKF3SNGI3KuPv0PQZMWDNa5L648gbLL1ZH+F4D6HcxMgmYuoroL3CACtaOkxVoJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UAurSrN8; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UAurSrN8"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j0vfd2RjKzKnT6;
	Thu, 08 Oct 2026 17:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791474809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RR5QsDI+1RTjibdKaWzzOO4/deoxZvqhuaQVj493AR4=;
	b=UAurSrN8T1W16aOJLH4n4iJOmjdH2ZiazpCSrQN+bvFypukwl9d1OoosY31+O0PTKr8aEv
	pJ4MvfVz8RaG+rE1h8hUSZcv1esK/g8jEJLBo0/9s7zc1wwbiRJD1dl+8bmT+Zn9dBoCts
	2V0AYBwN/G12pIujoJta7vjGagCNLiBl7lqahDELXOdWGmCSgXXk9xdenbBFqMPwBHrpI2
	WaCXL/fhjNqMxqT70WbcAW9qpicz7zFOQCAAXUe9DySe4yxv4h65BDCJipqQoFbPS6dKJa
	6LQTLnX5EkOqcW39D6JY4LXm0hmkP7mRlq7cON/Rm9O1X6BsZpdZGbzxP8+eKg==
Date: Thu, 8 Oct 2026 17:53:20 +0200
From: SimonP <simonp.git@mailbox.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
Message-ID: <ase8Jrg2BBru6lg3@mailbox.org>
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel>
 <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
 <CABgObfYMRUzDSUPY7MMp2fbRbU+eMCdDVZT9vQxUcT_Bwm9z_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfYMRUzDSUPY7MMp2fbRbU+eMCdDVZT9vQxUcT_Bwm9z_Q@mail.gmail.com>
X-MBO-RS-ID: 020c5b7975fc444fe15
X-MBO-RS-META: kya8fy7g1zwfuu333g49hgmb1nxj7dnp

On Wed, Oct 07, 2026 at 01:18:03PM +0200, Paolo Bonzini wrote:
> On Wed, Oct 7, 2026 at 1:16 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On Tue, Oct 6, 2026 at 7:37 PM SimonP <simonp.git@mailbox.org> wrote:
> > > Hello,
> > >
> > > See subject. Happens in permission_fault() on line:
> > >
> > >         fault = (mmu->permissions[index] >> pte_access) & 1;
> > >
> > > Some output from a printk I added, not spammed but keeps happening:
> > >
> > > kvm: permission_fault(): pfec = 70, index = 35, not_smap = 0
> >
> > Can you confirm you are using nested virtualization, and if so what is
> > the L1 hypervisor and L2 guest combination? Also what is the processor
> > model?
> >
> > The issue is weird; it is caused by the SS bit which is apparently set
> > in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> > misc_ctl field, and KVM never sets it. Can you check if the attached
> > patch fixes it (modulo the fact that it shouldn't happen in the first
> > place)?
> 
> Attachment added now.

Patch is good. UBSAN doesn't complain anymore, no WARN is hit, and the
guest works.

Regards,
Simon

> 
> Paolo


