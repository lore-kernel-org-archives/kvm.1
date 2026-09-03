Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48784499F00
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436256; cv=none; b=IGOwZaFr2XFjrubZqt8Cogrm2BuaRJCc8zpPDLn7YNOp5U2d82/uaxyhttHjqYO8tpyh4efXZJkuKap8wRuUygp4jKTbbTJYE4xvPz1Fg0+V8wl6mzQ18t0QIbUOgcZ637EQUNnMsvdvPVPDTlYU8h44SpAsSFHZSA98qg+jh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436256; c=relaxed/simple;
	bh=IA/FyinYLLiRR7uiR9JiTcuMCefiei+WEKGA7rZCOXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTms8GKupF3DazAwGzz8L4S3PH+sXX3D2EmcXDDba32rfoZXpfPvM/L8JKlKJLLqNZ60//bTPN1kGddfkudaKCaGZ1gc4b3GOonRE7x0ZGx86XrMhsf4jEINw04ymsYgN+QiBFpFSW6dlA9PNMy/QVtwvqVU2Fb8FBKXnarqLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1ME5cDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1ME5cDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436239;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N/zyzj0lUQ4bvNdYRstAKniDWgPqMJqPkFYzvAl/Yg=;
	b=c1ME5cDxGI4Avn64mGJg58bzA9QZq6E21USj/5o5Ev+aLdFsBJJ/HHccRGS6+Krz+D6oX/
	9WuCEqkZWhiYIBHAomMEuennseM5GpWZw7B83WWCHmRmA2iG/UXM8CYpHYpYNJn5as/Y90
	/+IwJRiuqdlQ7sTgSSugkOi5f6lFD7Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-uFtoyYfqPlOg56D0c1VwWQ-1; Thu,
 03 Sep 2026 07:50:38 -0400
X-MC-Unique: uFtoyYfqPlOg56D0c1VwWQ-1
X-Mimecast-MFC-AGG-ID: uFtoyYfqPlOg56D0c1VwWQ_1788436237
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F44E19540C5;
	Thu,  3 Sep 2026 11:50:37 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5559D1800346;
	Thu,  3 Sep 2026 11:50:33 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:50:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <aplfB4L_WoFdpeBD@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aplQKjieyMHUoCWs@leonardi-redhat>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Sep 03, 2026 at 01:02:17PM +0200, Luigi Leonardi wrote:
> On Thu, Sep 03, 2026 at 03:33:30PM +0530, Ani Sinha wrote:
> > 
> > 
> > > On 3 Sep 2026, at 2:31 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
> > > 
> > > Hi Ani,
> > > 
> > > On Thu, Sep 03, 2026 at 02:16:30PM +0530, Ani Sinha wrote:
> > > > 
> > > > 
> > > > > On 1 Sep 2026, at 3:39 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
> > > > > 
> > > > > The guest policy carried in the IGVM guest-policy initialization header
> > > > > was parsed into QIgvm but never forwarded to the confidential guest
> > > > > platform: the previous callback ran at the end of qigvm_process_file,
> > > > > after LAUNCH_START had already been issued, so writing the policy had
> > > > > no effect.
> > > > > 
> > > > > Add a set_guest_policy callback and invoke it from the guest-policy
> > > > > initialization handler, so the policy reaches the platform before
> > > > > LAUNCH_START.
> > > > > 
> > > > > The guest policy can also be set on the command line. As it is part of
> > > > > the attestation report, silently overriding it would cause attestation
> > > > > to fail, so return an error if the command-line value differs from the
> > > > > one supplied by the IGVM file.
> > > > > 
> > > > > Link: https://gitlab.com/qemu-project/qemu/-/work_items/4189
> > > > > Fixes: 915b47078d ("backends/igvm: Handle policy for SEV guests")
> > > > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > > > > ---
> > > > > backends/confidential-guest-support.c |  9 ++++++++
> > > > > backends/igvm.c                       |  4 ++++
> > > > > target/i386/sev.c                     | 39 +++++++++++++++++++++++++++++++++++
> > > > > 3 files changed, 52 insertions(+)
> > > > > 
> > > > > diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
> > > > > index a0b36d2da5..c0d15b4a76 100644
> > > > > --- a/backends/confidential-guest-support.c
> > > > > +++ b/backends/confidential-guest-support.c
> > > > > @@ -38,6 +38,14 @@ static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
> > > > >    return -1;
> > > > > }
> > > > > 
> > > > > +static int set_guest_policy(ConfidentialGuestPolicyType policy_type,
> > > > > +                            uint64_t policy, Error **errp)
> > > > > +{
> > > > > +    error_setg(errp,
> > > > > +               "Setting guest policy is not supported for this platform");
> > > > > +    return -1;
> > > > > +}
> > > > > +
> > > > > static int set_id_block(void *id_block, uint32_t id_block_size,
> > > > >                        void *id_auth, uint32_t id_auth_size,
> > > > >                        Error **errp)
> > > > > @@ -62,6 +70,7 @@ static void confidential_guest_support_class_init(ObjectClass *oc,
> > > > >    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> > > > >    cgsc->check_support = check_support;
> > > > >    cgsc->set_guest_state = set_guest_state;
> > > > > +    cgsc->set_guest_policy = set_guest_policy;
> > > > >    cgsc->set_id_block = set_id_block;
> > > > >    cgsc->get_mem_map_entry = get_mem_map_entry;
> > > > > }
> > > > > diff --git a/backends/igvm.c b/backends/igvm.c
> > > > > index 6545382546..5131ee7829 100644
> > > > > --- a/backends/igvm.c
> > > > > +++ b/backends/igvm.c
> > > > > @@ -868,6 +868,10 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
> > > > > 
> > > > >    if (guest->compatibility_mask & ctx->compatibility_mask) {
> > > > >        ctx->sev_policy = guest->policy;
> > > > > +        if (ctx->cgsc) {
> > > > > +            return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV,
> > > > > +                                               guest->policy, errp);
> > > > > +        }
> > > > >    }
> > > > >    return 0;
> > > > > }
> > > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > > > > index c76cdba8d2..533ea4b54e 100644
> > > > > --- a/target/i386/sev.c
> > > > > +++ b/target/i386/sev.c
> > > > > @@ -128,6 +128,8 @@ struct SevCommonState {
> > > > >    bool kernel_hashes;
> > > > >    uint64_t sev_features;
> > > > >    uint64_t supported_sev_features;
> > > > > +    /* whether the guest policy was explicitly set on the command line */
> > > > > +    bool policy_set;
> > > > > 
> > > > >    /* runtime state */
> > > > >    uint8_t api_major;
> > > > > @@ -2723,6 +2725,40 @@ static int cgs_get_mem_map_entry(int index,
> > > > >    return 0;
> > > > > }
> > > > > 
> > > > > +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
> > > > > +                                uint64_t policy, Error **errp)
> > > > > +{
> > > > > +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> > > > > +
> > > > > +    if (policy_type != GUEST_POLICY_SEV) {
> > > > > +        error_setg(errp, "SEV: Invalid guest policy type provided for SEV: %d",
> > > > > +                   policy_type);
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > > +    if (sev_snp_enabled()) {
> > > > > +        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
> > > > > +
> > > > > +        if (sev_common->policy_set &&
> > > > > +            sev_snp_guest->kvm_start_conf.policy != policy) {
> > > > > +            error_setg(errp, "SNP: policy mismatch between IGVM and CLI");
> > > > > +            return -1;
> > > > > +        }
> > > > > +
> > > > > +        sev_snp_guest->kvm_start_conf.policy = policy;
> > > 
> > > Thanks for you review!
> > > 
> > > > 
> > > > I had fixed a bug initially here where we need to check if the policy passed is not 0. I am not sure if that fix is still needed here.
> > > > Please test this scenario:
> > > > a) Generate an IGVM file with policy set to 0.
> > > 
> > > 0 is not a valid sev-snp guest policy: bit 17 is reserved and must be 1.
> > > It's a valid sev/sev-es policy though.
> > > 
> > > > b) Start a confidential SEV-SNP guest with policy set in command line and with this IGVM.
> > > > I think with your patch this will fail as the policies won’t match.
> > > 
> > > Correct: this was suggested by Gerd, as this is something unexpected. I
> > > think it would break launch measurement.
> > 
> > Yes I think the right thing to do is that if the policy is correctly set by IGVM, override the one set in the cli with the one in IGVM. Otherwise ignore IGVM policy.

As a general rule, if the user passes a parameter to QEMU, it should
always either be honoured, or result in an error. Selectively ignoring
user input has proved to be a generally bad idea, as it tends to mask
user configuration mistakes.

> mmh why? I might be missing something, but for now I'm not really convinced:
> if we have a policy set in IGVM we should use that one. Overriding it using the
> CLI, may cause measurement failure. If we have an IGVM image with a wrong policy
> set, then the problem should be fixed there.

If the user choose to override policy on the CLI, isn't it now just
their problem to also figure out what the new expected measurement
will be ? 

Why wouldn't we just honour the IGVM by default, and if the CLI
has further customizations let them override the IGVM, and leave
the user to figure out the implications.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

