Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EE477E57
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546274; cv=none; b=C29O1g7cUwP9uF33r9na2cAicjU2TMQ8XSrDXbh9EgsUJF7Hd8tLPb5es88xCa8lH6+Ohvh0C+R169Kd01pAP93jBZRvLsSYPnQ0qdMbJj7POnkdh4dE9+C3Pq4YzvZpr0wGRaaYAFsNoMS6fILGp7s9Hd5D2x5W/iscpGV9gvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546274; c=relaxed/simple;
	bh=yywNw13W4fT+nKTgWA7OJ6hsDY2ls7dwcYnRDo6s1ek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXU+NAom2gC1JxF8LW7mUFnBwivCUwih7ViDYaIoDgnDbT9SCDDqSZ8+wYfSe4dgT+5/BkzEBVgb5rlPDxujhvZfz9TRWRY63Zr9sWGJHqU0geMXmJ9Ml9540dA3rbp0PK+JpVtafW9uRBlTSdzJJlQoPCExBO7n9l5X9ZjRmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViR2vQUc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViR2vQUc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-485850cf499so769406f8f.3
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788546270; x=1789151070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hji4sWFzvSAFALCRyVksUKXmRDhWft7BefXXvRmx65E=;
        b=ViR2vQUchamNXuR+mPvPNBtE92wCzYvrkbKO1T6sMQkuMhx+u57UIzSbXo44B6kBLT
         QbkVC+gA6TnT0eZPk0rX+0cErfBd0SWT0Q6Qvd72q6iP9PZ0OcgZKOmjahqPrhl4tRTk
         TbL7Ti4Z6FaGruenyBcI6b+tYFaNudGdDsrVNEQJA48Gb0RDy66FnvV85wq6/6SVadiV
         WjiSPs8eFPuVMAAJUjJtFXM0P0M2bERf+XgAPesNCDRMZkNrIfymEjDnDp0QMyWzScA0
         B628k/l/vW4ypgqxZ8VN5i60dFWUhNa3Pv+7l731nax40J2DFIfQ6vhc0QCvjWKT6+5C
         WFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788546270; x=1789151070;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hji4sWFzvSAFALCRyVksUKXmRDhWft7BefXXvRmx65E=;
        b=fGp6OiR/TdD00/ZDiQx8t74sbawS+Te2qfhPojyIIFwj3eCO6ZbdWfxkUZrYNdcool
         /k71v1GXXZ+ZBVy+IwQXwUFgey+nnEyL10uRmceF10GLbaERS13flzhsiWIxmY7qRgfr
         J/x9a9VKmm3AcdwOS79CtkV47DYasq9N7i+/46mqeePtq4SGWYLWQENt4aAxdkqxKwfD
         0Xi9zeFLobk6FokMeJkt6ihhnJMs5y0b/ONA+m7nSBWwvejVV+JpXzr4wYTSB7/7tf5j
         NjoVHzK3vrYulTZDuRAE2fVufWf7fcwtk44udBetyqPzzgjHWleXso+ffdImPMk8eU1y
         sUTA==
X-Forwarded-Encrypted: i=1; AKwUvBw8cmC17Z4F6LOaAUInkXY5DWjnZSu4x3OdV0Zze01Cx87TNa6vxSOfSu+ioAqJRdVCfTM=@vger.kernel.org
X-Gm-Message-State: AFuF++kOo+kBfFJppRavngQpdmildTyC9Hox0XdOfU15Sdlm+u8EPtLm
	zn9HbWAwvKbIla0YonU5cu1CkVnMmkCHFXolC6wTJyuupuxfkz9cJ9Fr
X-Gm-Gg: AYBFou3oWlMsQorUhR4/Y1IjYbKhrqgwbvDy0U2dug8ui6alXppp6n6OmzEE4Bgqj/Z
	GXaqQxrx1yfiNfxXxV8ELGz9ierWJvB0I9gr2QE4jbZRyKEkfNwd0t4hSkaOeVouF0BEIHD75g2
	CLSG8+RS/XHqmlX+xiofcbnig+pJ0Gnb4ehUrrcBWRDhk0VsHFxaf6AdGexUD5ieRQlSCswmZty
	m/SHh6T06vISm+4pqSrtuGUZFviTfEUP8QUS/dM+eZ3grG51gH0MpJxiQ8d0usgwBxu70sG6LX+
	Apk+G0KEw4GjW4jSwwWUD7VHXsmySy4CMYwU/R2/XpX+uFr6aSxNZq+mJEuFGU+tOQEWxEVdZvj
	srwjKaBWiDvYwNj66XXUR1myX9plDTuDd/tziTgJ///vw6Tn7u43HL8gFN8L8y3A+8ERM38RfMg
	3kpOBWMsJtyzh5A99x6qAOVoLfHBBUdIvExcQSHFD6yBSlWKlyt85f/DN3JAP8dC4=
X-Received: by 2002:a05:6000:1843:b0:485:8c17:975f with SMTP id ffacd0b85a97d-4858c1798damr5634476f8f.33.1788546270143;
        Fri, 04 Sep 2026 11:24:30 -0700 (PDT)
Received: from [10.245.244.253] ([134.191.227.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm8168408f8f.14.2026.09.04.11.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 11:24:29 -0700 (PDT)
Message-ID: <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
	 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Jon Grimm
	 <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky	
 <thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton	
 <oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel	
 <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>, Jakub
 =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	 <jakub.ruzicka@matfyz.cz>,
 =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,  Vishal Annapurve
 <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, Kai
 Huang <kai.huang@intel.com>,  Kishen Maloor <kishen.maloor@intel.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Peter Fang	
 <peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li	 <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	kvm@vger.kernel.org
Date: Fri, 04 Sep 2026 21:24:25 +0300
In-Reply-To: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> Tom, since you mentioned that AMD SEV-SNP and Intel TDX live migration
> sound similar, can you please take a look how the API might work for
> SEV-SNP?

The presented example uAPIs were designed to fit the TDX live migration
flow, with the intent that they could also be used by other CoCo VMs.

It would be super great if someone could commend on how suitable these
uAPIs are for AMD and ARM flows.

AFAIU, what is generic in the presented uAPI is more of usage pattern.

- The order in which QEMU calls them.
- The idea that QEMU/KVM is a transport for opaque blobs.

The proposed container - 'struct kvm_transfer_buffer' - only has address
and a size. The vendor defines the layout of the data in it.

Some example high-level topics that would be nice to get feedback on:

- Can we come up with a single set of generic migration uAPIs for different
  CoCo models?
- Or should some uAPIs be generic while others are vendor-specific?
- Or should each CoCo model have its own vendor-specific set of migration
  uAPIs?
- Should the same uAPIs also support traditional VMs? But the only use-case
  I imagine here is "for testing purposes".

> Artem has put together a brief description below of the example API and t=
he
> migration flow:

.. snip ...

> Migration flow
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  Source host                                      Destination host
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                      =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>  CMD(SETUP/SESSION)          <--- setup msgs ---> CMD(SETUP/SESSION)
>        |    (repeated)                                  |
>  CMD(SETUP/IMMUTABLE_STATE)  - immutable state -> CMD(SETUP/IMMUTABLE_STA=
TE)
>        |                                                |
>  KVM_GET_DIRTY_LOG                                      |
>  KVM_EXPORT_MEMORY           --- memory data ---> KVM_IMPORT_MEMORY
>  CMD(ITERATION)              --- epoch token ---> CMD(ITERATION)
>        |    (repeat until convergence)                  |
>  CMD(STOP_AND_COPY/PAUSE)                               |
>  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_ST=
ATE)
>  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
>  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
>  CMD(ITERATION/DONE)         --- start token ---> CMD(ITERATION)
>        |                                                |
>  CMD(END)                                         CMD(END)

... snip ...


As I mentioned, the example uAPI is modeled around the TDX migration flow.
In case it helps the reader, here is a summary of that flow that was
presented in PUCK.

It describes what the TDX module offers today and focuses on pre-copy
migration. This is our interpretation of the TDX specifications, not a
specification itself, and may contain errors or omissions. Please refer to
the official TDX specifications for authoritative information.

Migration Overview
------------------

In TDX, the TDX module implements the migration logic. The VMM drives
migration by issuing seamcalls to the source and destination TDX modules an=
d
transports the resulting encrypted blobs between them. The VMM does not nee=
d
to know the contents of those blobs.

The TDX security model enforces two hard rules:

- Only one instance of the TD may run at a time. Either the source or the
  destination may run, but never both. In other words, cloning a TD is not
  allowed.
- When migration completes, the destination must have the same memory and
  vCPU state as the source. It must not end up with a partial or mixed
  state.

Simple Overview
---------------

Run the migration setup session
  |
  v
Transfer immutable TD state
  |
  v
Copy dirty memory pages while the TD runs <-------+
  |                                               |
  +-- iterate until convergence criteria is met --+
  |
  v
Pause the source TD and copy the remaining state
  |
  v
Start the destination TD

The migration process starts with a setup session. During the setup session=
,
the source and destination TDX modules exchange encrypted blobs and
establish migration encryption keys. For example, these keys protect memory
contents transferred during migration.

Next, the source transfers the immutable TD state to the destination and
initializes the destination TD. This state includes the read-only VM data,
such as its vCPU count and topology.

The source and destination then perform iterative memory-copy rounds. In
each round, the source scans for memory pages that need to be migrated and
exports them in encrypted form. The destination imports the pages. The
rounds continue until the number of pages that change between rounds is
small enough to meet the convergence criteria.

The source TD is then paused. The VMM transfers the remaining TD state, suc=
h
as vCPU state, and the final dirty memory pages. Finally, the destination T=
D
is started and the migration completes.

Notice that the VMM's role in this process is to issue the required
seamcalls and send encrypted blobs between the source and destination. The
VMM does not need to know the contents of those blobs.

More Detailed Overview
----------------------

The following diagram shows the TDX seamcalls used by the source and
destination:

 Source host                                          Destination host
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                         =
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 TDH.MIG.SETUP        -- crypto keys, attestation ->  TDH.MIG.SETUP
       |                                                    |
 TDH.EXPORT.STATE.IMMUTABLE -- read-only TD state ->
TDH.IMPORT.STATE.IMMUTABLE
       |                                                    |
 TDH.MEM.SCAN.RANGE                                         |
 TDH.MEM.TRACK + IPIs                                       |
 TDH.EXPORT.MEM        ------ memory data --------->  TDH.IMPORT.MEM
 TDH.EXPORT.TRACK      ------ epoch token --------->  TDH.IMPORT.TRACK
       |                                                    |
 TDH.EXPORT.PAUSE                                           |
       |                                                    |
 TDH.EXPORT.STATE.TD   ------ global TD state ----->  TDH.IMPORT.STATE.TD
       |                                                    |
 TDH.EXPORT.STATE.VP   ------ vCPU state ---------->  TDH.IMPORT.STATE.VP
       |                                                    |
 TDH.MEM.SCAN.COMP                                          |
 TDH.MEM.TRACK + IPIs                                       |
 TDH.EXPORT.MEM        ------ final memory data --->  TDH.IMPORT.MEM
 TDH.EXPORT.TRACK      ------ start token --------->  TDH.IMPORT.TRACK
                                                            |
                                                      TDH.IMPORT.END

The source and destination go through the following stages.

Setup
-----

The VMM issues TDH.MIG.SETUP on the source and destination TDX modules
iteratively to perform the setup session. The modules return status and may
also return an encrypted blob, which the VMM passes between the two sides.
In other words, the migration protocol is between the two TDX modules, whil=
e
the VMM is simply the transport mechanism. The setup session performs mutua=
l
attestation, establishes trust between the modules, establishes migration
encryption keys, and loads the migration policy. It completes when the TDX
module returns success.

Immutable State Transfer
------------------------

The source calls TDH.EXPORT.STATE.IMMUTABLE to export the immutable TD
state. The destination VMM creates the destination TD skeleton and
configures migration streams, then calls TDH.IMPORT.STATE.IMMUTABLE, which
finalizes the destination TD initialization.

Iterative Memory Copy
---------------------

While the source TD continues running, the source and destination run
iterative memory copy rounds:

- The source calls TDH.MEM.SCAN.RANGE to find migration candidate pages.
- The source calls TDH.MEM.TRACK and sends IPIs to the TD's vCPUs in order
  to ensure the dirty page scanning algorithm correctness.
- The source calls TDH.EXPORT.MEM to export private memory pages, which the
  VMM sends to the destination.
- The destination calls TDH.IMPORT.MEM to import the received memory pages.
- The source calls TDH.EXPORT.TRACK to generate an epoch token. The VMM
  sends it to the destination, which calls TDH.IMPORT.TRACK to consume the
  token. This verifies that all data exported from the source was imported
  on the destination.

The rounds continue until the number of pages that change between rounds is
small enough to meet the convergence criteria.

Stop and Copy
-------------

The VMM pauses the source TD, which begins the downtime period, then calls
TDH.EXPORT.PAUSE to start the TDX-enforced blackout period. The source then
calls TDH.EXPORT.STATE.TD to export mutable TD-scope state and
TDH.EXPORT.STATE.VP to export mutable state for each vCPU. It then performs
the final dirty page scan, runs TDH.MEM.TRACK and sends IPIs, and calls
TDH.EXPORT.MEM to export the final dirty pages as encrypted blobs.

The destination calls TDH.IMPORT.STATE.TD to import mutable TD-scope state
and TDH.IMPORT.STATE.VP to import the mutable state of each vCPU. It calls
TDH.IMPORT.MEM to import the final dirty pages.

After exporting the final dirty pages, the source's last migration seamcall
is TDH.EXPORT.TRACK with IN_ORDER_DONE=3D1, which generates the start token=
.
The VMM sends the start token to the destination. The destination calls
TDH.IMPORT.TRACK with this token. This verifies that the mutable TD state
has been imported and allows the destination to start the TD. Finally, the
destination calls TDH.IMPORT.END, which ends the migration.
