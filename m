Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C334EF15
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499794; cv=none; b=NgQ+NQ09fvyE2Tq5ZyzPjTUrJcZ0kLv8MjLDnqd9YD37piwJ792rCoCeoZ1GdFxtQPvgllB/MAfP3Jf1Gar7Xiyl0kKC64IHxNOZJwzAvXWexXTR2synAHwYdusqc/9qDhwQBX+6PLrpfeFaOjHxCN6995BQQi9CE0toudWvLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499794; c=relaxed/simple;
	bh=+8YocelimR1miuAAwQufcLiszfC4rkPOzoXQw6gS230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6HeTrl+dqHXpdyd8b6fVxbsixKvcDSkmrfCHfAesHJvWa+Tt4kySlHBq2Gl7ZZG3zzXZ/4lY2saEaN5oNhs2dMpNUZ6DjRSxeN5b/oFoe0/yirEBIdFv2dUQ4bkAGabJUzRizntdKgdYqulZp1wOLoPLhF6wDW4A0eT5u1+f6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZc+bX7f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZc+bX7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788499791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8Dp4OEHE4PQFg3Th8GenXljeg76pHdsrU4kpFRBhPw=;
	b=dZc+bX7f3UWTxrtXDoWFIO3Ug4KVicb+cqiimAR85r9NyNsZN8nnBng5Zp5//TSL0ElUsp
	DnxHUqEcc3hX9s4O3NWzLdvTqod0Adl41r4i8xFkZQ3iZi6OhWjeaH4Ol9hZgFCujD1YM4
	b9aG5wE4im+BwBSHiDfZpbX0DMO83JI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-HvncyaaoPsaKWPeBlRNW2Q-1; Fri,
 04 Sep 2026 01:29:49 -0400
X-MC-Unique: HvncyaaoPsaKWPeBlRNW2Q-1
X-Mimecast-MFC-AGG-ID: HvncyaaoPsaKWPeBlRNW2Q_1788499788
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AD9B195F17D;
	Fri,  4 Sep 2026 05:29:48 +0000 (UTC)
Received: from ghoffman.nuc.csb.home.kraxel.org (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D55DE1956049;
	Fri,  4 Sep 2026 05:29:47 +0000 (UTC)
Received: by ghoffman.nuc.csb.home.kraxel.org (Postfix, from userid 11758)
	id 53E474006269; Fri, 04 Sep 2026 07:29:45 +0200 (CEST)
Date: Fri, 4 Sep 2026 07:29:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/4] sev: rename set_guest_policy to set_id_block and
 remove dead policy code
Message-ID: <appWT4FHRUc2j6BA@ghoffman-na.rmtde.csb>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-1-e93a6cf8c5ac@redhat.com>
 <aplMPpjG6X__JZeM@sgarzare-redhat>
 <aplPIuIgLYKofjGq@leonardi-redhat>
 <apl2D4DKmfHohZdF@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl2D4DKmfHohZdF@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Sep 03, 2026 at 03:55:31PM +0200, Stefano Garzarella wrote:
> On Thu, Sep 03, 2026 at 12:47:00PM +0200, Luigi Leonardi wrote:
> > On Thu, Sep 03, 2026 at 12:32:21PM +0200, Stefano Garzarella wrote:
> > > On Tue, Sep 01, 2026 at 12:09:18PM +0200, Luigi Leonardi wrote:
> > > > The guest policy must be provided at guest launch start: LAUNCH_START for
> > > > SEV/SEV-ES and SNP_LAUNCH_START for SEV-SNP. See the SEV API
> > > > specification, chapter 3 (Guest Policy), and the SEV-SNP firmware ABI
> > > > specification, section 4.3 (Guest Policy).
> > > > 
> > > > The policy parameter in set_guest_policy was never effective: by the
> > > > time this callback runs, LAUNCH_START has already been issued for both
> > > > SEV/SEV-ES and SEV-SNP, so writing to kvm_start_conf.policy or
> > > > sev_guest->policy has no effect. In practice the only thing this
> > > > callback actually does is set the ID block and ID auth for SNP's
> > > > LAUNCH_FINISH, so rename it to set_id_block to reflect its real
> > > > purpose, remove the unused policy parameter, and drop the non-SNP code
> > > > path which was entirely dead.
> > > > 
> > > > This is preliminary work: actually forwarding the guest policy to the
> > > > platform before LAUNCH_START is added in a later commit.
> > > 
> > > IIUC the behaviour is the same after this patch, but IMO better to
> > > clarify.
> > 
> > Yep, will do.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > > > ---
> > > > backends/confidential-guest-support.c       |  12 ++-
> > > > backends/igvm.c                             |   6 +-
> > > > include/system/confidential-guest-support.h |  28 ++++---
> > > > target/i386/sev.c                           | 118 +++++++++++-----------------
> > > > 4 files changed, 67 insertions(+), 97 deletions(-)
> > > > 
> > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> > > > index 156dd15e66..a0b36d2da5 100644
> > > > --- a/backends/confidential-guest-support.c
> > > > +++ b/backends/confidential-guest-support.c
> > > > @@ -38,14 +38,12 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
> > > >   return -1;
> > > > }
> > > > 
> > > > -static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> > > > -                            uint64_t policy,
> > > > -                            void *policy_data1, uint32_t policy_data1_size,
> > > > -                            void *policy_data2, uint32_t policy_data2_size,
> > > > -                            Error **errp)
> > > > +static int set_id_block(void *id_block, uint32_t id_block_size,
> > > > +                        void *id_auth, uint32_t id_auth_size,
> > > > +                        Error **errp)
> > > > {
> > > >   error_setg(errp,
> > > > -               "Setting confidential guest policy is not supported for this platform");
> > > > +               "Setting ID block is not supported for this platform");
> > > >   return -1;
> > > > }
> > > > 
> > > > @@ -64,7 +62,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
> > > >   ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> > > >   cgsc->check_support = check_support;
> > > >   cgsc->set_guest_state = set_guest_state;
> > > > -    cgsc->set_guest_policy = set_guest_policy;
> > > > +    cgsc->set_id_block = set_id_block;
> > > >   cgsc->get_mem_map_entry = get_mem_map_entry;
> > > > }
> > > > 
> > > > diff --git a/backends/igvm.c b/backends/igvm.c
> > > > index 7b7bdc72b7..85de0d54ec 100644
> > > > --- a/backends/igvm.c
> > > > +++ b/backends/igvm.c
> > > > @@ -968,9 +968,9 @@ static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
> > > >           id_block_len = sizeof(struct sev_id_block);
> > > >           id_auth_len = sizeof(struct sev_id_authentication);
> > > >       }
> > > > -        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
> > > > ctx->sev_policy,
> > > > -                                          ctx->id_block, id_block_len,
> > > > -                                          ctx->id_auth, id_auth_len, errp);
> > > > +
> > > > +        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
> > > > +                                       ctx->id_auth, id_auth_len, errp);
> > > >   }
> > > >   return 0;
> > > > }
> > > > diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
> > > > index 5dca717308..6d35ddb97a 100644
> > > > --- a/include/system/confidential-guest-support.h
> > > > +++ b/include/system/confidential-guest-support.h
> > > > @@ -128,21 +128,23 @@ typedef struct ConfidentialGuestSupportClass {
> > > >                          uint16_t cpu_index, Error **errp);
> > > > 
> > > >   /*
> > > > -     * Set the guest policy. The policy can be used to configure the
> > > > -     * confidential platform, such as if debug is enabled or not and can contain
> > > > -     * information about expected launch measurements, signed verification of
> > > > -     * guest configuration and other platform data.
> > > > -     *
> > > > -     * The format of the policy data is specific to each platform. For example,
> > > > -     * SEV-SNP uses a policy bitfield in the 'policy' argument and provides an
> > > > -     * ID block and ID authentication in the 'policy_data' parameters. The type
> > > > -     * of policy data is identified by the 'policy_type' argument.
> > > > +     * Set the guest policy for the confidential platform. The policy
> > > > +     * configures properties of the guest, such as whether debug is
> > > > +     * enabled. Its format is platform-specific; for SEV/SEV-ES and
> > > > +     * SEV-SNP it is a policy bitfield. Must be called before LAUNCH_START
> > > > +     * so the policy is in effect for launch.
> > > >    */
> > > >   int (*set_guest_policy)(ConfidentialGuestPolicyType policy_type,
> > > 
> > > I'm confused, this commit says "rename set_guest_policy to set_id_block"
> > > so why this callback is still here?
> > > 
> > 
> > We will need this callback in a following patch, so I thought that removing
> > it to then add it again was pointless. If you prefer I can go this
> > route, or I can specify it in the commit message.
> 
> I see your point about avoiding remove and re-add the callback, but
> self-contained commits aren't a matter of preference or taste, they're
> a maintainability requirement. A callback declared but unimplemented
> across three commits leaves the API in an incomplete state.
> 
> Please move the set_guest_policy declaration where it's first used.

A typical and good way to handle cases like this (a fix needs some code
reorganization) is to split that into two patches:  First patch does
the code reorganization without functional change (in this case: split
one callback into two), then have a relatively small patch with the
actual bugfix (move one of the two callback calls to another place).

take care,
  Gerd

