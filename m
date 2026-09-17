Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CD4B44B9
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680442; cv=none; b=nD3b+YQhKZutfEtJC3NBZZ6B2ExHoL5EK/At2NN1onCcs1EYmIWNkJyIP/TOoM2E+TpV0IphJ2rrJ9YV9aKWTwETbQJxdQb2F1jNKKIGu5ItDphU3wPGLcnD9yoI/BonPH4NIL5nOjCR33CrHEwRjMmow4ZMtnlhwkI/O4xtGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680442; c=relaxed/simple;
	bh=KBW8l/WH4AjuiCi0wr6AJLkatFN1Gl9ojLwHIoQuMPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxtN1GR1Fvk5KuakqeLCQudzrnW62nu2aontbt27rWkLHjsQnP8qizWvfUlg82/UkYuXlEh0mAVrfpgI2tNdpbtrIZvBpzqVNQ2F49S0ApWUm6Zrx4s1MhTbOVkc5tNO2vbK+oOLQVJtVkBurJoGBkngm7MrSmReVtsjAd8gBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LD/oq0LL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOBGrRET; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD/oq0LL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOBGrRET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789680439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tX3RlWeoOz7igc7z4njxFc9RJDJlLUAyhOvvpITNjZc=;
	b=LD/oq0LLWUWv8SWHGougtDXusZGLHxFXjuw8Cjuxqti4xjGiH1PIi07vg3Jf1FsYeZS8NT
	NeELaw48y7Qp55AlziYPGMDqqAlxWJIsMxyrT9pejLRX3z0DaiP0it6pBAEBBpsZVpU11x
	wQ10yqShnsWxMpd9IyhQuAjBw3/TARc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-Ri5qgi_kMIisuWIF_EKUWQ-1; Thu, 17 Sep 2026 17:27:17 -0400
X-MC-Unique: Ri5qgi_kMIisuWIF_EKUWQ-1
X-Mimecast-MFC-AGG-ID: Ri5qgi_kMIisuWIF_EKUWQ_1789680437
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0b66ecd9so10321685a.2
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789680437; x=1790285237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tX3RlWeoOz7igc7z4njxFc9RJDJlLUAyhOvvpITNjZc=;
        b=IOBGrRETO0b6JceZfz6WugaDUnswWgAMO0TvxFi7VqzEJ7+QbkHrcUO7oXNA/2QF3j
         FECRdyfTgSxT7mEnvnSCmeZ+bDHn7JTjNBIH1yQyclsmpCXyH2FPTaFVUMaCKPwN9HDR
         LFlHl3kSArX38HiyvJ3+agKZfLMpsuD5tCOPY7pAUOXO+U5G8VR38sFzjO2WWj+VaAb6
         7N2gRnAjEI17jWjAHe7cdFNFGxMWq+MGAVXUaEBia4Sl35aqtXu8sU7tHUKaLfxWxM3/
         Zfa3ynJ7vsj6VBp1t+v8RbHeBTVR+Gm5uI3Uu9Zsoj9YMpSiyPw/Zn+WLHGrGuEBOqJU
         kp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789680437; x=1790285237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tX3RlWeoOz7igc7z4njxFc9RJDJlLUAyhOvvpITNjZc=;
        b=PrcbeJtooag7y0BVjphmAHQwmCVo2jQpYrvYQRMClOSoMqpLF4A3N9A1AvBPI/FlsZ
         rFVNhQkx9jydV0rJ/04BNxfoIug3NgAXBWgOFyPfoZo3DV7aMXzFLWf4rSC6wNfuITKt
         UTL4Ftjm/R3ZW2MNF+UDDKtYNLRnNsgUKlzFQ6hoX/iis6mspprNfyIllb6bLjBf+UEu
         4NjxjGt8J4S06BFDXh6UAxBvMr4vVCY6HIKC/T+Fg9st0kr59/ef8G0hgDrzxNlWnU3n
         gXnCowjruNaWtkoUDmwmZ4gT3PlbC1pDMWa7/BRZbreiYrLD+78qDfYNtXFoSjC47dN8
         eJVg==
X-Forwarded-Encrypted: i=1; AKwUvByQnZmoiwT3I/g1qFSzey/2vXQmyh90byXiUjTFX1uy2txLif+7m2phIlFnZNe5YW9BWv0=@vger.kernel.org
X-Gm-Message-State: AFuF++kx4QIbSo6H3QEK5I6MuS/+d8HrtpYC9xFD78Asssj9SH1fnuLA
	0xGNaF8FwLhayHAPEOHZZ70ce8tsKYGK5RljxOrD/KKbGQPrcfugaCMk7m70wQAh8AMVAkMJgln
	GGSk7CZ9S97g6PMoilQMBPzoZPKsvXfszVzbdbe76wVyn7lBIk2YewA==
X-Gm-Gg: AYBFou3T1vwq6d2WJO4h6tNouejwlZHTX3jG1K3n8q3q2zTS5d/CSLDXTF3jg5BNWZE
	JLsOPqDxtvu4VBupL7jgnn7eKnaaoaH5qkETyTEKJHs9qWJiCsM4220VjL4+Lvn/2cfMNz7jsqi
	fDQvOKHRX1M463CGMLSALYb4IXBAZjKFIeDlHgUtWFJXPajeNq2/51cfFCJwdAXl1HThw3p8VZ2
	ZGSqF4Aa59e9oCHCCqyyZCyFSHJq5QZ2y+4rkvkWqfVa1gkziYIaiN9VUTLPy2wt4TgzdDf8Z8/
	dnjWF39EFG9Cq+2xTT/+3cBKo6Z4N48S6aj5Aq9mferTAzwjTJe32ORpuyEanXUMZ7BbKo3P8Ys
	cRsvHIcZo0i/uI4yqapu8wskH9jCDmqISBQKCloBkRFceb1t7H5LR6dya2gY=
X-Received: by 2002:a05:620a:2b8a:b0:93b:d79a:c477 with SMTP id af79cd13be357-93bdcaab67fmr35413185a.79.1789680436835;
        Thu, 17 Sep 2026 14:27:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8a:b0:93b:d79a:c477 with SMTP id af79cd13be357-93bdcaab67fmr35406985a.79.1789680436269;
        Thu, 17 Sep 2026 14:27:16 -0700 (PDT)
Received: from localhost (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d19df1sm561506685a.45.2026.09.17.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:27:15 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:27:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>

On Fri, Sep 04, 2026 at 09:24:25PM +0300, Artem Bityutskiy wrote:
> On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> > Tom, since you mentioned that AMD SEV-SNP and Intel TDX live migration
> > sound similar, can you please take a look how the API might work for
> > SEV-SNP?
> 
> The presented example uAPIs were designed to fit the TDX live migration
> flow, with the intent that they could also be used by other CoCo VMs.
> 
> It would be super great if someone could commend on how suitable these
> uAPIs are for AMD and ARM flows.
> 
> AFAIU, what is generic in the presented uAPI is more of usage pattern.
> 
> - The order in which QEMU calls them.
> - The idea that QEMU/KVM is a transport for opaque blobs.
> 
> The proposed container - 'struct kvm_transfer_buffer' - only has address
> and a size. The vendor defines the layout of the data in it.
> 
> Some example high-level topics that would be nice to get feedback on:
> 
> - Can we come up with a single set of generic migration uAPIs for different
>   CoCo models?
> - Or should some uAPIs be generic while others are vendor-specific?
> - Or should each CoCo model have its own vendor-specific set of migration
>   uAPIs?

It's always good if we can put together as much function to be shared with
generic ioctls as possible.  At some point, IMHO we need to collect such
information somehow, so when merging the generic API we know what vendor
specific API will be needed.  Hopefully this series is a good start.

> - Should the same uAPIs also support traditional VMs? But the only use-case
>   I imagine here is "for testing purposes".

This is an interesting idea, I think this could be useful.  Especially, I
wonder if you already have it done and PoC branches you can share, so that
I can play with it.

> 
> > Artem has put together a brief description below of the example API and the
> > migration flow:
> 
> .. snip ...
> 
> > Migration flow
> > ==============
> > 
> >  Source host                                      Destination host
> >  ===========                                      ================
> > 
> >  CMD(SETUP/SESSION)          <--- setup msgs ---> CMD(SETUP/SESSION)
> >        |    (repeated)                                  |
> >  CMD(SETUP/IMMUTABLE_STATE)  - immutable state -> CMD(SETUP/IMMUTABLE_STATE)
> >        |                                                |
> >  KVM_GET_DIRTY_LOG                                      |
> >  KVM_EXPORT_MEMORY           --- memory data ---> KVM_IMPORT_MEMORY
> >  CMD(ITERATION)              --- epoch token ---> CMD(ITERATION)

Could you elaborate this ITERATION operation?  Is that something the
userapp must do after full scan of a round of guest memory?

> >        |    (repeat until convergence)                  |
> >  CMD(STOP_AND_COPY/PAUSE)                               |
> >  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_STATE)
> >  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
> >  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY

When read/write encrypted memories, two questions:

- Is there an upper bound of the buffer size per-page?

- Does this operation supports concurrency?  If it supports, how well it
  scales per expectation (e.g. is there known big lock for that)?

Similar question to the vCPU getter and setter.  For now even without CoCo
we serialize vCPU get/set, but I want to understand the potential of
concurrent operations, and see if there's anything special for CoCo from
that regard.

> >  CMD(ITERATION/DONE)         --- start token ---> CMD(ITERATION)
> >        |                                                |
> >  CMD(END)                                         CMD(END)
> 
> ... snip ...
> 
> 
> As I mentioned, the example uAPI is modeled around the TDX migration flow.
> In case it helps the reader, here is a summary of that flow that was
> presented in PUCK.
> 
> It describes what the TDX module offers today and focuses on pre-copy
> migration. This is our interpretation of the TDX specifications, not a

IMHO we should really take postcopy into account when designing the API and
state machine.  We don't need to implement it in the first version, even
until merging, but we need to make sure postcopy will be new ioctls on top
of existing and it should have no major loopholes that it'll need a new set
of APIs.

For example, I think we should consider KVM_EXPORT_MEMORY being usable
after END on source, KVM_IMPORT_MEMORY while TD is in operation, etc.  We
should likely also need to still picture the rough process of postcopy,
reserve those APIs since the start (but return -EINVAL or something).

AFAIU, postcopy is so far still the best solution for extremely large or
extremely busy VMs regarding user experience, and it will happen to CoCo
VMs one day or another.

> specification itself, and may contain errors or omissions. Please refer to
> the official TDX specifications for authoritative information.
> 
> Migration Overview
> ------------------
> 
> In TDX, the TDX module implements the migration logic. The VMM drives
> migration by issuing seamcalls to the source and destination TDX modules and
> transports the resulting encrypted blobs between them. The VMM does not need
> to know the contents of those blobs.
> 
> The TDX security model enforces two hard rules:
> 
> - Only one instance of the TD may run at a time. Either the source or the

Just curious - could I ask why this limitation?

>   destination may run, but never both. In other words, cloning a TD is not
>   allowed.
> - When migration completes, the destination must have the same memory and
>   vCPU state as the source. It must not end up with a partial or mixed
>   state.

If such happens, it's definitely a bug, even without CoCo.  Anything
specific about CoCo?  Like, whole-VM checksum?

I recall QEMU could have some devices touching the memory during its post
load process (after destination QEMU receive the device states and apply).
I'm not sure how much it affects.

> 
> Simple Overview
> ---------------
> 
> Run the migration setup session
>   |
>   v
> Transfer immutable TD state
>   |
>   v
> Copy dirty memory pages while the TD runs <-------+
>   |                                               |
>   +-- iterate until convergence criteria is met --+
>   |
>   v
> Pause the source TD and copy the remaining state
>   |
>   v
> Start the destination TD
> 
> The migration process starts with a setup session. During the setup session,
> the source and destination TDX modules exchange encrypted blobs and
> establish migration encryption keys. For example, these keys protect memory
> contents transferred during migration.
> 
> Next, the source transfers the immutable TD state to the destination and
> initializes the destination TD. This state includes the read-only VM data,
> such as its vCPU count and topology.
> 
> The source and destination then perform iterative memory-copy rounds. In
> each round, the source scans for memory pages that need to be migrated and
> exports them in encrypted form. The destination imports the pages. The
> rounds continue until the number of pages that change between rounds is
> small enough to meet the convergence criteria.
> 
> The source TD is then paused. The VMM transfers the remaining TD state, such

I want to understand what is extra for a CoCo VM in terms of "pause", say,
what's more than "stopping the vCPU threads".

I saw there's mention of PRE_COPY_STOP state.  One example question is,
when reaching this state, can the guest memory still change?  What happens
if some emulated device are still DMAing to the guest memory (assuming
flipped from private to shared)?  In case of future IO zone support, what
happens if in case of VFIO-PCI assigned doing encrypted DMA?

From that regard, VFIO has the P2P state where it quiesce initiation of any
DMA from this specific device, then another round to fully stop all devices
into STOP_COPY phase.  I wonder if CoCo VMs need similar treatment.

> as vCPU state, and the final dirty memory pages. Finally, the destination TD
> is started and the migration completes.
> 
> Notice that the VMM's role in this process is to issue the required
> seamcalls and send encrypted blobs between the source and destination. The
> VMM does not need to know the contents of those blobs.
> 
> More Detailed Overview
> ----------------------
> 
> The following diagram shows the TDX seamcalls used by the source and
> destination:
> 
>  Source host                                          Destination host
>  ===========                                          ================
> 
>  TDH.MIG.SETUP        -- crypto keys, attestation ->  TDH.MIG.SETUP
>        |                                                    |
>  TDH.EXPORT.STATE.IMMUTABLE -- read-only TD state ->
> TDH.IMPORT.STATE.IMMUTABLE
>        |                                                    |
>  TDH.MEM.SCAN.RANGE                                         |

Could you elaborate what's the relations between TDH.MEM.SCAN.RANGE and the
GET_DIRTY_LOG ioctl?  I recall above mentioned GET_DIRTY_LOG will be
available even for CoCo, which makes sense assuming dirty information isn't
confidential.  However then I don't understand what TDH.MEM.SCAN.RANGE
plays the role here.

Thanks,

>  TDH.MEM.TRACK + IPIs                                       |
>  TDH.EXPORT.MEM        ------ memory data --------->  TDH.IMPORT.MEM
>  TDH.EXPORT.TRACK      ------ epoch token --------->  TDH.IMPORT.TRACK
>        |                                                    |
>  TDH.EXPORT.PAUSE                                           |
>        |                                                    |
>  TDH.EXPORT.STATE.TD   ------ global TD state ----->  TDH.IMPORT.STATE.TD
>        |                                                    |
>  TDH.EXPORT.STATE.VP   ------ vCPU state ---------->  TDH.IMPORT.STATE.VP
>        |                                                    |
>  TDH.MEM.SCAN.COMP                                          |
>  TDH.MEM.TRACK + IPIs                                       |
>  TDH.EXPORT.MEM        ------ final memory data --->  TDH.IMPORT.MEM
>  TDH.EXPORT.TRACK      ------ start token --------->  TDH.IMPORT.TRACK
>                                                             |
>                                                       TDH.IMPORT.END
> 
> The source and destination go through the following stages.
> 
> Setup
> -----
> 
> The VMM issues TDH.MIG.SETUP on the source and destination TDX modules
> iteratively to perform the setup session. The modules return status and may
> also return an encrypted blob, which the VMM passes between the two sides.
> In other words, the migration protocol is between the two TDX modules, while
> the VMM is simply the transport mechanism. The setup session performs mutual
> attestation, establishes trust between the modules, establishes migration
> encryption keys, and loads the migration policy. It completes when the TDX
> module returns success.
> 
> Immutable State Transfer
> ------------------------
> 
> The source calls TDH.EXPORT.STATE.IMMUTABLE to export the immutable TD
> state. The destination VMM creates the destination TD skeleton and
> configures migration streams, then calls TDH.IMPORT.STATE.IMMUTABLE, which
> finalizes the destination TD initialization.
> 
> Iterative Memory Copy
> ---------------------
> 
> While the source TD continues running, the source and destination run
> iterative memory copy rounds:
> 
> - The source calls TDH.MEM.SCAN.RANGE to find migration candidate pages.
> - The source calls TDH.MEM.TRACK and sends IPIs to the TD's vCPUs in order
>   to ensure the dirty page scanning algorithm correctness.
> - The source calls TDH.EXPORT.MEM to export private memory pages, which the
>   VMM sends to the destination.
> - The destination calls TDH.IMPORT.MEM to import the received memory pages.
> - The source calls TDH.EXPORT.TRACK to generate an epoch token. The VMM
>   sends it to the destination, which calls TDH.IMPORT.TRACK to consume the
>   token. This verifies that all data exported from the source was imported
>   on the destination.
> 
> The rounds continue until the number of pages that change between rounds is
> small enough to meet the convergence criteria.
> 
> Stop and Copy
> -------------
> 
> The VMM pauses the source TD, which begins the downtime period, then calls
> TDH.EXPORT.PAUSE to start the TDX-enforced blackout period. The source then
> calls TDH.EXPORT.STATE.TD to export mutable TD-scope state and
> TDH.EXPORT.STATE.VP to export mutable state for each vCPU. It then performs
> the final dirty page scan, runs TDH.MEM.TRACK and sends IPIs, and calls
> TDH.EXPORT.MEM to export the final dirty pages as encrypted blobs.
> 
> The destination calls TDH.IMPORT.STATE.TD to import mutable TD-scope state
> and TDH.IMPORT.STATE.VP to import the mutable state of each vCPU. It calls
> TDH.IMPORT.MEM to import the final dirty pages.
> 
> After exporting the final dirty pages, the source's last migration seamcall
> is TDH.EXPORT.TRACK with IN_ORDER_DONE=1, which generates the start token.
> The VMM sends the start token to the destination. The destination calls
> TDH.IMPORT.TRACK with this token. This verifies that the mutable TD state
> has been imported and allows the destination to start the TD. Finally, the
> destination calls TDH.IMPORT.END, which ends the migration.
> 

-- 
Peter Xu

