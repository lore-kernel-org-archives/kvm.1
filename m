Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184703A48C8
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375121; cv=none; b=KTUbEimP9DCeztMuQmOFAXlhZEeQVzPRTkBxLzD/IkGkBuaw9yFuPQRESZ99lhHPth8CS3wTQ3EPdwA7/tittg+yxPVD2UE7Lt1ZWHGyiQV25OHxyMgBryImU/JYjtjHN7iiwERbb98CT4CiEO/ZhZcdO4QrjS2JtGsEUZhfp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375121; c=relaxed/simple;
	bh=NzWCxNOvMAOcoOXn22R7estCq5OdqenBkKBNdX4yU2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqKjiqZ5AevG/1HGqSkg0JCmUTfzLYtObjpl3qo1mQOMN1bAoIJTR6WVYd2upBRzpaZF1WAxMkDB8sbNddrt4Bfa9u4WJ7yMQhZVzLheFlJaFtS+Ad4u1dDhIx3MmdDJ02PxlQIuxotJXWfj4Qj2IWef/ePoKuhcnaIfdBOO4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L1ZrE+u1; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L1ZrE+u1"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j0Bn963mWzMlWQ;
	Wed, 07 Oct 2026 14:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791375101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5MXvRH2slPTdWRP+1ub5UU19nJMLIDkAkBFTyrn3jg=;
	b=L1ZrE+u1Pv6c2p6MTly/AlHh4++a8ht50MnWBKDmeKe7ers+jSK4MpbalKhsFzKsSxbmU2
	y1HMxFWw8zamlx9+PqgQLhX1Pd2iAMDsECdoQwUsPiIU8VkfaFqq5sNvKnrxG9W/YDKg26
	O+EpZL7pHjyyqhqc96/JecMS7hD2jnuDKq/4RZpG8/o8JB2ci9wxDskEqre+4ws8Bv4N/U
	q4+c8wCbKYM8XX7SwKIlexCkGMCP9F06L5q2wX892YfF9Vf3Y/HyvMpLyyJj8IYd7M8Yxh
	kUNJltU3Hu2pTHiT4Zwn/J68Ciq+ncTFAC/vzlq6aLvg/S57coZtvoa1F8xV/A==
Date: Wed, 7 Oct 2026 14:11:35 +0200
From: SimonP <simonp.git@mailbox.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
Message-ID: <asY2RIHcGtZVdWD1@mailbox.org>
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel>
 <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
 <asYw47C3kHRtrzk8@mailbox.org>
 <CABgObfasfsz8ALzFjLTVn+YCe2qXyfjTqc-mQYJ6se8zhxJLXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfasfsz8ALzFjLTVn+YCe2qXyfjTqc-mQYJ6se8zhxJLXA@mail.gmail.com>
X-MBO-RS-META: u34915ccpnue5pkrtximkmfwuhs3hzzt
X-MBO-RS-ID: 811cdae6f76cc4aebc8

On Wed, Oct 07, 2026 at 02:05:15PM +0200, Paolo Bonzini wrote:
> On Wed, Oct 7, 2026 at 1:47 PM SimonP <simonp.git@mailbox.org> wrote:
> >
> > On Wed, Oct 07, 2026 at 01:16:32PM +0200, Paolo Bonzini wrote:
> > > On Tue, Oct 6, 2026 at 7:37 PM SimonP <simonp.git@mailbox.org> wrote:
> > > > Hello,
> > > >
> > > > See subject. Happens in permission_fault() on line:
> > > >
> > > >         fault = (mmu->permissions[index] >> pte_access) & 1;
> > > >
> > > > Some output from a printk I added, not spammed but keeps happening:
> > > >
> > > > kvm: permission_fault(): pfec = 70, index = 35, not_smap = 0
> > >
> > > Can you confirm you are using nested virtualization, and if so what is
> > > the L1 hypervisor and L2 guest combination? Also what is the processor
> > > model?
> > >
> > > The issue is weird; it is caused by the SS bit which is apparently set
> > > in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
> > > misc_ctl field, and KVM never sets it. Can you check if the attached
> > > patch fixes it (modulo the fact that it shouldn't happen in the first
> > > place)?
> >
> > Will test the patch when I can but for now increment the weird counter
> > because there is no nesting, this is on a bare-metal hypervisor. The
> > guest is Windows 11. $(lscpu) is below.
> 
> No, I mean nesting another hypervisor *inside* KVM; do you have
> Hyper-V enabled in your Windows VM? The stack trace has both
> npf_interception and paging64_page_fault, which doesn't really happen
> without nesting.
> 
> If you are using QEMU, you can use "info stats vcpu guest_mode" from
> the QEMU monitor to tell you more. If you're using libvirt, likewise,
> that would be
> 
>    virsh qemu-monitor-command ID --hmp 'info stats vcpu guest_mode
> 

Sorry, misunderstood. Yes, I use WSL2 in the Windows VM.

$ virsh qemu-monitor-command win11 --hmp 'info stats vcpu guest_mode'
provider: kvm
    guest_mode (instant, boolean): no

Regards,
Simon


> Thanks,
> 
> Paolo
> 
