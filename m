Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF44BA1D4
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108615; cv=none; b=rUpa3H5vKkpZuf2ClDYI5TUzS++5QCGgI62i6ehGOoFJdb6KZh5zcZgIgyaU9ZZjIE17ynoEs3QWHnEY9CL0qatzCMT6UH4i6VQLvb3rBRzek9gXXCwgn0x1+nBdz3eyfZzrO6mTe0wAGbStIapYV6EHmN+ArveQS6LoTXntmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108615; c=relaxed/simple;
	bh=OLKZfeAEGNd4QrCvnjx531rHZB9oA9ODZa1gnZdedSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3pOwKwIU+2UJlUdoiHdjINY4RqGItEh7dkeHyebhmELfeHKs8hI+57CbDoDDJ1zuQOX4GPp+Ct+DKsj16cDUdsQJ6IPg3sfzTLVi52dS30hxblYkbCYbVfhRi45OvnIJiCzjiecFkRLtb8lAhr6+A7P5P1+PxrMTzTk3sCIE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApjIy5vj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApjIy5vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE3D1F000C6
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108613;
	bh=AdumzskNHkZh1l/i33IFVVPJoN8A4mpwGvQVHoQhWCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ApjIy5vj6aRrXElfrL524uA0NR2ZAXxKhOCGXCCzThrtOYWKgGLLRhIf36BSHjtVu
	 u1FjIja3SMkZl9NIdoIRz/DhslutyKoBFg6ovc/cqZneCBW7Db4jZF/T4DJ9TMTUC/
	 fUwYrry6SA/1EnyzmOTXBM7VzVoKz/wmfmwx9onY0VpMxMfiC4fIP0F/GpvFs+S5bo
	 PfjeUlCFtNd1XqfMXJ2RglQnp9l71gUWOinjVSTxYFNFHzhj64zazjUv9mvtV6Xou9
	 /jOfWeRQnefydpLuKklHef4vXWX8e9BykxgOlCebfg9sAE6tRD8yhlTcICbgzuE7aQ
	 zmnTBrqWfoH8w==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2dcbcc546fso725128366b.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw3AR3xYTX+hdYrp5USlfftqcM9TMUG6oxAEOfTDEWnNrYfn/agEssiHILuTR8a+3npEbw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiNvN/dhVT1LNK7qgiV+oQVXjQ3Gg4sRSItzyivCSrjFU+1N/5
	msK5fq/wVCc9p5MrHPN16l6Xh98ZK+8J53vvzoMHCJ7x63j834XaQsu2Sms05eabFR5P9djVkg+
	fsifqPFHtiiUfEIiBVFLfsNiYRv/aPls=
X-Received: by 2002:a17:907:724a:b0:c2d:c800:d797 with SMTP id
 a640c23a62f3a-c31a9a2d879mr1922117066b.6.1792108612039; Thu, 15 Oct 2026
 16:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-23-yosry@kernel.org>
 <CALMp9eSv9a23si8rtWd_XGRJxVWE96aWdSzE_Ram5Bu6G_pb+w@mail.gmail.com>
 <CAO9r8zMkRADNhRCBoxKCPNM90H0uqB5Jyt7oB4RDmbhgY_UM-g@mail.gmail.com> <CALMp9eTM23iFdrbZE8qw9kuJ2va+Mahv5wZDmgs1TZrAREh=gw@mail.gmail.com>
In-Reply-To: <CALMp9eTM23iFdrbZE8qw9kuJ2va+Mahv5wZDmgs1TZrAREh=gw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 16:56:40 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNFYNR904b0NahKj=vwoc1tRZdr2wwUYpTVwUdwvYAtpg@mail.gmail.com>
X-Gm-Features: AclHuK98P5xud1M3Uu8_V1jqxz7NFSA37b3DkBoaVSsnZgUfueLMwshqG5P2HOw
Message-ID: <CAO9r8zNFYNR904b0NahKj=vwoc1tRZdr2wwUYpTVwUdwvYAtpg@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] KVM: nSVM: Flush the TLB if L1 changes L2's ASID
 in vmcb12
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > @@ -691,23 +689,35 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
> > > >  static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> > > >  {
> > > >         struct vcpu_svm *svm = to_svm(vcpu);
> > > > +       bool new_asid = false;
> > > >
> > > >         /* Handle pending Hyper-V TLB flush requests */
> > > >         kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> > > >
> > > > +       if (svm->nested.ctl.asid != svm->nested.last_asid) {
> > > > +               svm->nested.last_asid = svm->nested.ctl.asid;
> > > > +               new_asid = true;
> > > > +       }
> > >
> > > To make sure we don't miss a flush after restore, do we need to clear
> > > last_asid in svm_set_nested_state()?
> >
> > In [1], we set svm->nested.vmcb02.cpu = -1 in svm_allocate_nested(),
> > which should be called when EFER.SVME is set on restore, and should
> > force a TLB flush on the first vCPU run. That being said, if EFER.SVME
> > was already set (not a fresh vCPU), we won't necessarily flush the
> > TLB. KVM_SET_SREGS will _probably_ flush the TLB, but I don't think
> > it's guaranteed.
>
> I'm pretty sure that restoring nested state on an existing vCPU with
> the same asid12 and no TLB_CONTROL skips the flush.

I can clear last_asid in svm_set_nested_state() to make sure we don't
break this.

>
> > But wouldn't this also affect non-nested? Are we guaranteed to flush
> > L1's ASID after restore?
>
> That may be a bug too.

It's tricky. KVM_SET_SREGS will only flush (with 64-bit vCPUs) if
CR0/CR3/CR4/EFER are changed apparently. But it's not just the TLB
flush, the entire MMU context wouldn't be reset?

I am not sure if there is a practical use case for restoring on an
existing vCPU tho.
